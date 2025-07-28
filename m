Return-Path: <linux-kernel+bounces-748192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5310EB13DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD137A3B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440A4270542;
	Mon, 28 Jul 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq24yJpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2826772C;
	Mon, 28 Jul 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714477; cv=none; b=hKz6HirDB1sG5JahJj/ho1a6/B3Ot6AO0cAbS45uIzvbV5uXRVErKRynZdOTj1MLZyCK+oifuAjI0IwaVL3DN6K4ukKOS8GEAArRHfJPuSgZKPzuOhx6XqzIg/nU8B44oKT/bhaaeZ9rtKW0SpXOMw5agU3s7vqQ56rSyZsK3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714477; c=relaxed/simple;
	bh=LcqYflMiuNR1BpY/hEp2KEpN+DgVGr4KsB6ZUt4m8+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn7YQPDwrBz6ASgZyb0/euBtKLIB9Wsqc1wSVLKoIjqVjA5zgjO+NLFk7zfvgn+QCE8ZWkW8qYVjlt0ZErWONfjcQCc92/xN8GkDPH+9EdnzVwWgyjB72extsqsITr4ma0E1Cj4poANIvjTUmE23d/B8NGm8ZkoySqZM/ykQXPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq24yJpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDB1C4CEE7;
	Mon, 28 Jul 2025 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714477;
	bh=LcqYflMiuNR1BpY/hEp2KEpN+DgVGr4KsB6ZUt4m8+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eq24yJpoEdA4ZgGZrIOuuyPJI9VpBHVGOGzHavDQxrWEyJtse04fO2UGWBqA5pJnR
	 3w08tkoTYqtuX5L3WFJZErHXjzFvwbz9u2mYvAVikpDNoF80vyYC/+sRl0FbmrVxf3
	 TN6MDodlxUVOknhgxmMXJ8UAst2vonqtam7bMGiY40OhZN1mKG6t/tefHE5fnhyULE
	 kiTKpKzH8Aj4Z0b8CrxqBxJtuNkLtbTsW+i20LWMgfgSNKl41bRk6uv3pD2ICutOsl
	 Wz3WbDLpTH3cYUBcnGFdWFaEr0O9dzrFF0yzQEviQGwKLP8GS5s8sSsK0GrHAfclUw
	 Qk5t2DSsAtAfA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugPFK-00000000G5Q-2Z8y;
	Mon, 28 Jul 2025 16:54:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs: kernel-doc: avoid script crash on ancient Python
Date: Mon, 28 Jul 2025 16:54:28 +0200
Message-ID: <dc75423e817f92cc6b8369892ee79166c2fb5ecc.1753713955.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753713955.git.mchehab+huawei@kernel.org>
References: <cover.1753713955.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

While we do need at least 3.6 for kernel-doc to work, and at least
3.7 for it to output functions and structs with parameters at the
right order, let the python binary be compatible with legacy
versions.

The rationale is that the Kernel build nowadays calls kernel-doc
with -none on some places. Better not to bail out when older
versions are found.

With that, potentially this will run with python 2.7 and 3.2+,
according with vermin:

	$ vermin --no-tips -v ./scripts/kernel-doc
	Detecting python files..
	Analyzing using 24 processes..
	2.7, 3.2     /new_devel/v4l/docs/scripts/kernel-doc
	Minimum required versions: 2.7, 3.2

I actually tested it with versions 2.7 and 3.4 using anaconda
(version 3 < 3.4 was not available there). For both, the
script didn't crash and emitted the right warning:

	$ conda create -n py27 python=2.7
	$ conda activate py27
	$ python ./scripts/kernel-doc --none include/media
	Error: Python 3.6 or later is required by kernel-doc
	$ conda deactivate

	$ conda create -n py34 python=3.4
	$ conda activate py34
	python --version
        Python 3.4.5
        $ python ./scripts/kernel-doc --none include/media
	Error: Python 3.6 or later is required by kernel-doc
	$ conda deactivate

	$ python --version
	Python 3.13.5
        $ python ./scripts/kernel-doc --none include/media
	(no warnings and script ran properly)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index fc3d46ef519f..d4f9188d6a19 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -1,9 +1,19 @@
-#!/usr/bin/env python3
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
 # SPDX-License-Identifier: GPL-2.0
 # Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
 #
-# pylint: disable=C0103,R0915
-#
+# pylint: disable=C0103,R0912,R0914,R0915
+
+# NOTE: While kernel-doc requires at least version 3.6 to run, the
+#       command line explicitly supports Python 2,7 and 3.4+.
+#       The rationale is that it shall fail gracefully during Kernel
+#       compilation with older Kernel versions. Due to that:
+#       - encoding line is needed here;
+#       - no f-strings can be used on this file.
+#       - the libraries that require newer versions can only be included
+#         after Python version is checked.
+
 # Converted from the kernel-doc script originally written in Perl
 # under GPLv2, copyrighted since 1998 by the following authors:
 #
@@ -107,9 +117,6 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
-from kdoc_files import KernelFiles                      # pylint: disable=C0413
-from kdoc_output import RestFormat, ManFormat           # pylint: disable=C0413
-
 DESC = """
 Read C language source or header FILEs, extract embedded documentation comments,
 and print formatted documentation to standard output.
@@ -273,14 +280,22 @@ def main():
 
     python_ver = sys.version_info[:2]
     if python_ver < (3,6):
-        logger.warning("Python 3.6 or later is required by kernel-doc")
+        # Depending on Kernel configuration, kernel-doc --none is called at
+        # build time. As we don't want to break compilation due to the
+        # usage of an old Python version, return 0 here.
+        if args.none:
+            logger.error("Python 3.6 or later is required by kernel-doc. skipping checks")
+            sys.exit(0)
 
-        # Return 0 here to avoid breaking compilation
-        sys.exit(0)
+        sys.exit("Python 3.6 or later is required by kernel-doc. Aborting.")
 
     if python_ver < (3,7):
         logger.warning("Python 3.7 or later is required for correct results")
 
+    # Import kernel-doc libraries only after checking Python version
+    from kdoc_files import KernelFiles                  # pylint: disable=C0415
+    from kdoc_output import RestFormat, ManFormat       # pylint: disable=C0415
+
     if args.man:
         out_style = ManFormat(modulename=args.modulename)
     elif args.none:
@@ -308,11 +323,11 @@ def main():
         sys.exit(0)
 
     if args.werror:
-        print(f"{error_count} warnings as errors")
+        print("%s warnings as errors" % error_count)    # pylint: disable=C0209
         sys.exit(error_count)
 
     if args.verbose:
-        print(f"{error_count} errors")
+        print("%s errors" % error_count)                # pylint: disable=C0209
 
     if args.none:
         sys.exit(0)
-- 
2.49.0


