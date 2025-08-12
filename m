Return-Path: <linux-kernel+bounces-765166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC49B22C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50377AC642
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105B2F9468;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/+T373I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78C2F659E;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=C3eQLQ4T2hFmKNEeg4CdZrxVaMlDmZ2HGWhV4u7teHFKohKNSdBvVXXUUG7dy862kZ1GJf16VtJT7n3iROi/hyUc6gJd/+jPKXpARX2KwqMjlBCmtcA4vTHq+3J0OiLqa7VERok0xRfpaXQpGs8c6sK8kU+vM31RlXUIfSEnX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=tUovukr9LJAZFuTCxPr3I6APWlpK5/pEVeW1gSeYrBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJSMgRDYyxOqI3vmP/7UjlTAuf4IgCN5L9f8UNbfkznZvni2NeNXGLKCY8UFjZCDGuUUTfmIvjKfNKgNeEXS7cKSBmI4fa0CqgQ2JB0AdEDVgoHu2C6BsbochldqzM9RMHGfi/yrRjR3iWxSEnCpjtn9wcVpaKgecoCKEwIZl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/+T373I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9BEC4CEF7;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=tUovukr9LJAZFuTCxPr3I6APWlpK5/pEVeW1gSeYrBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/+T373IkRxMN4+DbM1srsAKLqJA4EpftaFElQ21Z13GAB1+HutvQICiDJDocfqMF
	 EfS5atY9zpDFPSH6RbYx16uq8cvZsw6BRgQvZJ0kKMA/OCxk5Z2EidulJxmuoIR4u0
	 aZyLXWeJciCwPkGwTMR2cwtONhoHP7ilJqQ3HQYTjZm3nMBCazgMOX0FZ+nq+6jzNP
	 VwlgcrKRCgs3ju7XbFRVDxA6k++hjNb7Zz8kRk4kGs3P3Rb5ybovsDnu9d0KUkSCrC
	 raV4o0DqUFQ8oy1Idt8IMiO1gr3/WDy30rgT32TgsheX2h+0HfMXy4V8nPTvCgvMXv
	 coIGXToQ8uRnw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWg-35r3;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/39] scripts: sphinx-pre-install: better handle Python min version
Date: Tue, 12 Aug 2025 17:52:40 +0200
Message-ID: <013aeb848ecc3f6b69b4518cf3d335bd2353b6e1.1754992972.git.mchehab+huawei@kernel.org>
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

Don't do any recommendations about Sphinx install with too
old python versions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 365590f81551..a5c777e529ec 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -92,6 +92,10 @@ class SphinxDependencyChecker:
         # Some distros may not have a Sphinx shipped package compatible with
         # our minimal requirements
         self.package_supported = True
+
+        # Recommend a new python version
+        self.recommend_python = None
+
         # Certain hints are meant to be shown only once
         self.first_hint = True
 
@@ -511,11 +515,11 @@ class SphinxDependencyChecker:
                 print("ERROR: Distro not supported. Too old?")
                 return
 
-            # TODO: check if RHEL8 still works.
-            # On my tests with  docker "redhat/ubi8" image, there's no
-            # python3-sphinx (or similar) package. It comes with Python 3.6,
-            # but there are other python packages over there, so it may be
-            # possible to work with venv.
+            # RHEL 8 uses Python 3.6, which is not compatible with
+            # the build system anymore. Suggest Python 3.11
+            if rel == 8:
+                self.add_package("python39", 0)
+                self.recommend_python = True
 
             if self.first_hint:
                 print("Note: RHEL-based distros typically require extra repositories.\n" \
@@ -596,6 +600,7 @@ class SphinxDependencyChecker:
             # the build system anymore. Suggest Python 3.11
             if rel == 15:
                 if not self.which(self.python_cmd):
+                    self.recommend_python = True
                     self.add_package(self.python_cmd, 0)
 
                 progs.update({
@@ -1000,6 +1005,11 @@ class SphinxDependencyChecker:
         #	- recommended version.
         # It also needs to work fine with both distro's package and venv/virtualenv
 
+        if self.recommend_python:
+            print("\nPython version is incompatible with doc build.\n" \
+                  "Please upgrade it and re-run.\n")
+            return
+
         # Version is OK. Nothing to do.
         if self.cur_version != (0, 0, 0) and self.cur_version >= RECOMMENDED_VERSION:
             return
-- 
2.50.1


