Return-Path: <linux-kernel+bounces-749681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4B6B15193
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1163B99AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013382989AD;
	Tue, 29 Jul 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQu/MNa1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A457296158;
	Tue, 29 Jul 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807445; cv=none; b=hq7FIL3G5NB0Op9s2nZ7NaR3is7u1rXAdxCUTR1IUNjIddrLMcc5CfUchbCm2HqIqjNKilEj02vuZL+hqfz4UtRN4LLfVqWjKUBr8wYmpbRduI79TvvcLnWwG1sURtu/J536GbuRXFbGyIVQ9SeH+Omdiz7IaWdEfKlxsn/6gXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807445; c=relaxed/simple;
	bh=TsMpcACiWzSB16cKLBwRJj3t0mcIuiGGTbXT+qc7vZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deHaAYNzWWKRmJlvP9dbmzS/atrSYaKF+8brRSDOQ166jt5eXuAMLsHXZVEjwSkS4GZFc15NKS64hHtiT+2AErqIsr7rC1xv7o599yhT94uCVOtHkngLNZmnYNBOyozPyZ88p63/t5vNDbIVep2TwuM1snMzA3CB+7yzg4nApxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQu/MNa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9B3C4CEEF;
	Tue, 29 Jul 2025 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753807444;
	bh=TsMpcACiWzSB16cKLBwRJj3t0mcIuiGGTbXT+qc7vZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQu/MNa1/AGU2UynK49ZkWo/BLqXvKoM8/hFXH5zf8+gizu8vsiwakY2ukSSTeXxn
	 s/1nvxH6aEdgHQ1L4qZR58jGG3YTOUHO56PBVWL8I1P7+9qLpu3PSulkP6PydLh0Qy
	 SHvEOSQuazYdieysUZjbEDwMDg6eIENDxEi0mLemYb0CKycyKOPlliTAurX+OOg+OK
	 M/3ksJzew1ZRkaPug9ADVQsjjwOj3r4gYl0OOaQ3xxS9oYWMi+7EnQEpitH83AvVDC
	 KDik8bDoFrWJb37u3+CSbgqCJjht5vpYCVRytFAvtnGetDSE69qPFBuG/pGpNKiZ83
	 /4S4IWuTGL51g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugnQo-00000000Liw-1Z1s;
	Tue, 29 Jul 2025 18:44:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] docs: kernel-doc: avoid script crash on ancient Python
Date: Tue, 29 Jul 2025 18:43:03 +0200
Message-ID: <87d55e76b0b1391cb7a83e3e965dbddb83fa9786.1753806485.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753806485.git.mchehab+huawei@kernel.org>
References: <cover.1753806485.git.mchehab+huawei@kernel.org>
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

3.2 minimal requirement is due to argparse.

The minimal version I could check was version 3.4
(using anaconda). Anaconda doesn't support 3.2 or 3.3
anymore, and 3.2 doesn't even compile (I tested compiling
Python 3.2 on Fedora 42 and on Fedora 32 - no show).

With 3.4, the script didn't crash and emitted the right warning:

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

Supporting 2.7 is out of scope, as it is EOL for 5 years, and
changing shebang to point to "python" instead of "python3"
would have a wider impact.

I did some extra checks about the differences from 3.2 and
3.4, and didn't find anything that would cause troubles:

	grep -rE "yield from|asyncio|pathlib|async|await|enum" scripts/kernel-doc

Also, it doesn't use "@" operator. So, I'm confident that it
should run (producing the exit warning) since Python 3.2.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index fc3d46ef519f..d9fe2bcbd39c 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -2,8 +2,17 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
 #
-# pylint: disable=C0103,R0915
-#
+# pylint: disable=C0103,R0912,R0914,R0915
+
+# NOTE: While kernel-doc requires at least version 3.6 to run, the
+#       command line should work with Python 3.2+ (tested with 3.4).
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
@@ -107,9 +116,6 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
-from kdoc_files import KernelFiles                      # pylint: disable=C0413
-from kdoc_output import RestFormat, ManFormat           # pylint: disable=C0413
-
 DESC = """
 Read C language source or header FILEs, extract embedded documentation comments,
 and print formatted documentation to standard output.
@@ -273,14 +279,22 @@ def main():
 
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
@@ -308,11 +322,11 @@ def main():
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


