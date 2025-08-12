Return-Path: <linux-kernel+bounces-765184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C35B22CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63EE62170F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A572FD1DD;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGzjKHCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A52F83AE;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=O2bsvkgaYryczlIVyBl2imKjMWmV5kj3LXYAsjgPO560gETVJniZeNZlbKXZ8LysikY9Yphvvwct1QFo3WxlVWOSFAtQTv/FuVdPHpWV1a+0qR/uXVaXk3CHZRmIsurFTb/ilo5cYag1tD4M6owMk0NMVA0M2QE38PZJMRz4EWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=wJnSHEtnfEDAispvO8hkEglJmLys0nv2+O3sl9tpI6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUFB+C7QcwCRftty6nCl1VHYNwyXRK06gV67g4FwxnwriwYGdLrMEF/3b0Pdoe/D5pt95L3EV73z/Gg+MpYhJvudkFOgLtIiNV6HSAXCg6+2rvb/6GD28JmvlMr7dVmn2maKxvPWI0z9P/NQAwXP7g53MV9xlIyvDIrh0b1w8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGzjKHCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA11C4AF1D;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=wJnSHEtnfEDAispvO8hkEglJmLys0nv2+O3sl9tpI6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGzjKHCHIXp/dRp23WRPuBOLAyehmHihe4lv5XXB4O4Kb8b+M9CtYz0UZf0hu4dT6
	 EtTwvJF0cpaQGfA3HJnz/NcpTrgIrpezVU6TEDndJK+iG0o2jtSxwI/A6a5SJalYJo
	 MPFXb5o+880RIz30SQCRlG8jNBZcxKwK+XBiE60z5L5kE7IgEEZk4UbnjywhVFY88v
	 O5Y8DbiE1ZomQGa05Y3/7mgaoxE4VRXYuG6W0fpDG5wPDO47uR8+CFT62SE4Ifraf6
	 9y1QfkGeir9Gq8VKq7G2sQxjYTkDmBkRT+lqLBHjPi5HZPO0LIbc5vRN+IKTP/1ShC
	 L4bYb0B1hPzQQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ9-00000006kXd-0ZNo;
	Tue, 12 Aug 2025 17:53:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/39] scripts: sphinx-pre-install: add support for RHEL8-based distros
Date: Tue, 12 Aug 2025 17:52:54 +0200
Message-ID: <bcdde20edab07be6bf447eac18eecdd88c7f947c.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On RHEL8, only installing with a venv is supported, as there's
no Sphinx package using Python 3.7 or upper.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index fc9dc45054d7..324baa98a395 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -691,7 +691,7 @@ class SphinxDependencyChecker(MissingCheckers):
 
         super().__init__(args, texlive)
 
-        self.need_pip = 0
+        self.need_pip = False
         self.rec_sphinx_upgrade = 0
 
         self.system_release = self.get_system_release()
@@ -840,9 +840,15 @@ class SphinxDependencyChecker(MissingCheckers):
             # RHEL 8 uses Python 3.6, which is not compatible with
             # the build system anymore. Suggest Python 3.11
             if rel == 8:
-                self.deps.add_package("python39", DepManager.SYSTEM_MANDATORY)
+                self.check_program("python3.9", DepManager.SYSTEM_MANDATORY)
+                progs["python3.9"] = "python39"
+                progs["yaml"] = "python39-pyyaml"
+
                 self.recommend_python = True
 
+                # There's no python39-sphinx package. Only pip is supported
+                self.package_supported = False
+
             if not self.distro_msg:
                 self.distro_msg = \
                     "Note: RHEL-based distros typically require extra repositories.\n" \
@@ -915,8 +921,9 @@ class SphinxDependencyChecker(MissingCheckers):
             # the build system anymore. Suggest Python 3.11
             if rel == 15:
                 if not self.which(self.python_cmd):
+                    self.check_program("python3.11", DepManager.SYSTEM_MANDATORY)
+                    progs["python3.11"] = "python311"
                     self.recommend_python = True
-                    self.deps.add_package(self.python_cmd, DepManager.SYSTEM_MANDATORY)
 
                 progs.update({
                     "python-sphinx": "python311-Sphinx",
@@ -1289,7 +1296,7 @@ class SphinxDependencyChecker(MissingCheckers):
             return self.latest_avail_ver
 
         # Either there are already a virtual env or a new one should be created
-        self.need_pip = 1
+        self.need_pip = True
 
         if not self.latest_avail_ver:
             return None
@@ -1344,10 +1351,11 @@ class SphinxDependencyChecker(MissingCheckers):
         """
 
         if self.recommend_python:
-            print("\nPython version is incompatible with doc build.\n" \
-                  "Please upgrade it and re-run.\n")
-            return
-
+            cur_ver = sys.version_info[:3]
+            if cur_ver < MIN_PYTHON_VERSION:
+                print(f"\nPython version {cur_ver} is incompatible with doc build.\n" \
+                    "Please upgrade it and re-run.\n")
+                return
 
         # Version is OK. Nothing to do.
         if self.cur_version != (0, 0, 0) and self.cur_version >= RECOMMENDED_VERSION:
@@ -1467,7 +1475,6 @@ class SphinxDependencyChecker(MissingCheckers):
             if sys.version_info < MIN_PYTHON_VERSION:
                 self.need_pip = False
                 print("Warning: python version is not supported.")
-
             else:
                 virtualenv_cmd = f"{self.python_cmd} -m venv"
                 self.check_python_module("ensurepip")
-- 
2.50.1


