#!/bin/sh
# vim: set ts=2 sw=2 tw=200 noet :

set -e

# DEFAULTS
CLOSURE="$HOME/.bin/compiler.jar"


# CLEANUP
echo ""
echo "  Removing previous build"
echo ""

rm -r ./media
mkdir media
cp -r ./DataTables/media/css ./media/
cp -r ./DataTables/media/images ./media/
cp -r ./DataTables/media/js ./media/


# MINIFICATION
MAIN_FILE="./media/js/jquery.dataTables.js"
MIN_FILE="./media/js/jquery.dataTables.min.js"
VERSION=$(grep " * @version     " ./DataTables/media/src/DataTables.js | awk -F" " '{ print $3 }')

echo ""
echo "  DataTables build ($VERSION)"
echo ""


IFS='%'

echo "  Minification"
echo "/*!
 * File:        jquery.dataTables.min.js
 * Version:     $VERSION
 * Author:      Allan Jardine (www.sprymedia.co.uk)
 * Info:        www.datatables.net
 *
 * Copyright 2008-2012 Allan Jardine, all rights reserved.
 *
 * This source file is free software, under either the GPL v2 license or a
 * BSD style license, available at:
 *   http://datatables.net/license_gpl2
 *   http://datatables.net/license_bsd
 *
 * This source file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.
 */" > $MIN_FILE

java -jar $CLOSURE --js $MAIN_FILE >> $MIN_FILE
echo "    Min JS file size: $(ls -l $MIN_FILE | awk -F" " '{ print $5 }')"

echo "  Done\n"

