Return-Path: <linux-kernel+bounces-728558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB747B029F4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5306582F94
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739CB254B09;
	Sat, 12 Jul 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu4PIXE0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523E254848;
	Sat, 12 Jul 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308034; cv=none; b=MOw4YrDSo5aRiU9vw7lN69L4G3bWVy3gVxaxcUDegzUSRgC3nH+agnEcQWeKLobUg0sTXjDZncKhOD+X2oGw0QhV8tkG2vfUI9weJO/3fnpiId8RtLAKUc6ViH1yaSu+gA+5xFQnY109AwZkSNOkTzcJfBICA0HN0M22G9eERm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308034; c=relaxed/simple;
	bh=ua5PApvy1DPn+jaoFt7I+58zAD2EcQFSm7ku/DyCCMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ9w9rVHCjVmm+JNWeezTCs6BUZz4x//1+uTY6Pa50pDIBlphfBrEhTjucEgxUGPtlEL+KatONAyHASIBp7tP64j+g0/anNBZhuuIPbAopznSQTv1pEwpvj5T287BdOMipgJXDMtFOAixPEbdAevR4SgOahtNv99Yx02qvEJf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu4PIXE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D189C4CEF5;
	Sat, 12 Jul 2025 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752308034;
	bh=ua5PApvy1DPn+jaoFt7I+58zAD2EcQFSm7ku/DyCCMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fu4PIXE0Uh+JC0FJ5Srz+r4Rb2K9g/xcbCAbqSBnh4wKFWHlX89gddFKI9zONTL9+
	 8acWnNit8xsCVre/e0Xa6eJmTVFrYbTZKihm+xjCUPVJGQnZtXFQ5KemMJHOLJ4IyN
	 3PoFnPoaEsDYBltG3T2e26DzqWoSWFxNoy/2NblRB+xrvDUGQeSWprlZRh2GiMxu4M
	 ETHI5M8DIkmiuQULjhK8rt7woZ3oRSWGNhJP04gRnhj+ScM3YNPa80ihYGy3dj30ez
	 tgFXJD5qHiSiaX4UxI0fXACW2iWpmXBW6eNlc7xvUj2M7NEjflR9Xx8zCpDVJi+l/o
	 OdYRihvNXLHoA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uaVMm-0000000GrLu-11DO;
	Sat, 12 Jul 2025 10:13:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] docs: kernel-doc: emit warnings for ancient versions of Python
Date: Sat, 12 Jul 2025 10:13:43 +0200
Message-ID: <38c42f000ad7f33c2b988f487678ddc085226221.1752307866.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752307866.git.mchehab+huawei@kernel.org>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Kernel-doc requires at least version 3.6 to run, as it uses f-string.
Yet, Kernel build currently calls kernel-doc with -none on some places.
Better not to bail out when older versions are found.

Versions of Python prior to 3.7 do not guarantee to remember the insertion
order of dicts; since kernel-doc depends on that guarantee, running with
such older versions could result in output with reordered sections.

Check Python version when called via command line and ensure that
it will run with a much older version, failing after checking arguments,
but return 0 to avoid breaking Kernel compilation.

With that, potentially this will run with python 2.7 and 3.2+,
according with vermin:

	$ vermin --no-tips -v ./scripts/kernel-doc
	Detecting python files..
	Analyzing using 24 processes..
	2.7, 3.2     /new_devel/v4l/docs/scripts/kernel-doc
	Minimum required versions: 2.7, 3.2

I tested myself with versions 2.7 and 3.4 using anaconda
(version 3 < 3.4 is not available there)

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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 12ae66f40bd7..c59eea3e0fe9 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -1,9 +1,19 @@
 #!/usr/bin/env python3
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
@@ -271,6 +278,20 @@ def main():
 
     logger.addHandler(handler)
 
+    python_ver = sys.version_info[:2]
+    if python_ver < (3,6):
+        logger.error("Python 3.6 or later is required by kernel-doc")
+
+        # Return 0 here to avoid breaking compilation
+        sys.exit(0)
+
+    if python_ver < (3,7):
+        logger.warning("Python 3.7 or later is required for correct results")
+
+    # Import kernel-doc libraries only after checking Python version
+    from kdoc_files import KernelFiles                  # pylint: disable=C0415
+    from kdoc_output import RestFormat, ManFormat       # pylint: disable=C0415
+
     if args.man:
         out_style = ManFormat(modulename=args.modulename)
     elif args.none:
@@ -298,11 +319,11 @@ def main():
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
2.50.0


