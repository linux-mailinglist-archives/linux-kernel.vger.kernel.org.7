Return-Path: <linux-kernel+bounces-723775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81949AFEAFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725BE188B305
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869992E92A2;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR7FnJLj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B652E54B8;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=oCqDHZcykvColnHXcpDGw5FYDRg+sTkIiOHMih6TRzPoQyOzjUzEaFXrMVGImVYy3UDhzCTjsM76p3RduZiGrEXoS5omG1geQgXhju/opp4X6HA+JaRYtSYzob/yBV5X5bdC+ipVpNAAwKvO3y6VetxY4nIcoo9AFoHGBGD1t1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=lTAkg7u8HXaXh2CCMJr0+qB6A4vyNHejb2fT597Jdvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqzqEUF9Y7ElGS7AQIvZrNjUqbTD8a+HnmMKwMOJF1B+HEI6KtozYPf3OFNaYtCtVhSyYKqpR9v0jVJD6FI60Tv4XQ285vnIZvkjaoeUK2oFZzrkUqe4tGqIGvDmz2xzPrLeMCcFl/ns3hZjDF5MFAmfEniS+7RPgW0iAiTeoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR7FnJLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112E7C2BCB8;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=lTAkg7u8HXaXh2CCMJr0+qB6A4vyNHejb2fT597Jdvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LR7FnJLj9AjsOPqevYpq0UNuQfjEeoGmqNL2UbaHF5K25zLAdax2nki60Y73S2QrG
	 0l0ZIo/vVBPLOJvZMqBvEJwqUAz3qFhEtz/qQavirgUbVjMHr4ZVeo3XbEw7TsQblb
	 vPXkLPrnbcP+BZij3c/S3Ti8ckBMpSwouViAt7k1PQNmKbItXTlVUx0uEzfVRe0mEX
	 2VhakPT+VcJm140OAOZwVxsuvB5ZaPLo8nmRC7BQf/27bxyCrIJK6+9NptyTqV+N4/
	 OwNrcFYGaVcwKzJ8/xP0T/bQIwhJFAWKQs7em7SoiGux0YHQPMK6EJbmUI2b7VTG/p
	 O17IvXq3n+4AA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDp-3beU;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/39] scripts: sphinx-pre-install: add support for RHEL8-based distros
Date: Wed,  9 Jul 2025 15:52:07 +0200
Message-ID: <b00eb1041c07e02387cd1818cab15f06bf4e3ca1.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

On RHEL8, only installing with a venv is supported, as there's
no Sphinx package using Python 3.7 or upper.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index fc9dc45054d7..324baa98a395 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
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
2.49.0


