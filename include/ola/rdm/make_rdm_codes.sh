#!/bin/bash
# Autogenerate the RDMResponseCodes.h file from the protobuf definition.

if [ $# != 1 ]; then
  echo "Usage: $0 <path-to-proto>";
  exit;
fi

proto=$1;

(
cat <<EOM
/*
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *
 * RDMResponseCodes.h
 * Enums representing the state of a response. This is generated from the proto
 * file, so that we don't have to make the Ola.pb.h file public.
 * Copyright (C) 2010 Simon Newton
 *
 * This file has been autogenerated by make_rdm_codes.sh, DO NOT EDIT.
 */

/**
 * @addtogroup rdm_helpers
 * @{
 * @file RDMResponseCodes.h
 * @brief Enums representing the states of a response. This is generated from
 * the proto file.
 * @}
 */
#ifndef INCLUDE_OLA_RDM_RDMRESPONSECODES_H_
#define INCLUDE_OLA_RDM_RDMRESPONSECODES_H_

namespace ola {
namespace rdm {

/**
 * @brief RDM response codes
 */
typedef enum {
EOM
sed -ne  '/^enum RDMResponseCode/,/^}/p' $proto | grep RDM_ | sed "s/;/,/"
cat <<EOM
} rdm_response_code;

/**
 * @brief RDM response types
 */
typedef enum {
EOM
sed -ne  '/^enum RDMResponseType/,/^}/p' $proto | grep RDM_ | sed "s/;/,/"
cat <<EOM
} rdm_response_type;
}  // namespace rdm
}  // namespace ola
#endif  // INCLUDE_OLA_RDM_RDMRESPONSECODES_H_
EOM
)
