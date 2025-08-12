Return-Path: <linux-kernel+bounces-765175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60CB22C77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D6C87B978E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1079A2FA81E;
	Tue, 12 Aug 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPKfhhYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C872F8BE8;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=lR03MSif2NrYQj9GJcmt1KfNgzCF4+mjzfFkgvRZOT6TOyphYUmPE+tzGDW3oi0ghk9i8Hzx3XNOxIU4q5xXOQubfZAsa/Ip4SIqgmF2+mru5yrvtgP7st1mnuJS0mFAtx2PoYYDVW+yE9EqhYeYTM9DJjhJe8PVDkGmP8qgwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=qLTUoIeHx8ybD7DbPrlVFUdn0U//pEmmYDk8jCaRb/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQoxEX7uQxmT8FgBDb93LKIFRVBAr7zB60BI4xIZyRifJOlzO5CUp5Zcnf+9kZCykJute9HOUQF3bLKCU6ocunQcVjKFMDFT5MoEIpFJ9vwQwu8GK8Ydwwa21svxMdAyDD0Bt0pEnZNNqh2rQ9oAy0Pq/okHZhgQbt/4RFxA6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPKfhhYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEACC4CEF9;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=qLTUoIeHx8ybD7DbPrlVFUdn0U//pEmmYDk8jCaRb/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPKfhhYniAUoi3VzM1inuPRpcyjh1ue0mI+Zh9LrYWPx/UL9UrpulXbQ1ZWNrNSSA
	 muQHRobp+QKziVErl6vQveRSyFbnkSIOotnOPrHYYvyk6IsELCuN0qXkaZNtbZIptD
	 Mir4coFf7bI0ZqcoBX5uC26a484sYFOaAZksFEiSfYTm/7F7I3vfMo8i+76TGiIRB9
	 u0Tci0MG4Q6td21tORIHNt+JG5+9okor72t1Ou7P+gnJHCcy66lZYC9Ijy/QVxdGAi
	 vOf56nnXDstHUGOJ/SYzE3e/QBYkADaXAAg4fIFKNlpUs4KeEbbz5RWeQiNzL6TOTv
	 A/Rs+Fjud0o0w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWY-2q80;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/39] scripts: sphinx-pre-install: move package instructions to a new func
Date: Tue, 12 Aug 2025 17:52:38 +0200
Message-ID: <4fb2181c960e89774309a833f80209a1a3ab10d2.1754992972.git.mchehab+huawei@kernel.org>
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

Currently, if Python < 3.7, package install will fail. That happens
with OpenSuse Leap and RHEL-based ver 8 distros.

OpenSuse allows installing Sphinx with Python 3.11, but RHEL-based
distros don't.

Prepare to recomend only venv on such cases. For now, just split
the recomendation on a new function that will check for a
paramtere to be called.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 44 +++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 2f6036eadc94..2360ca2ed21c 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -89,6 +89,9 @@ class SphinxDependencyChecker:
         self.python_cmd = ""
         self.activate_cmd = ""
 
+        # Some distros may not have a Sphinx shipped package compatible with
+        # our minimal requirements
+        self.package_supported = True
         # Certain hints are meant to be shown only once
         self.first_hint = True
 
@@ -969,6 +972,27 @@ class SphinxDependencyChecker:
 
         return self.latest_avail_ver
 
+    def recommend_package(self):
+
+        print("\n2) As a package with:")
+
+        old_need = self.need
+        old_optional = self.optional
+        self.missing = {}
+        self.pdf = False
+        self.optional = 0
+        self.install = ""
+        old_verbose = self.verbose_warn_install
+        self.verbose_warn_install = 0
+
+        self.add_package("python-sphinx", 0)
+
+        self.check_distros()
+
+        self.need = old_need
+        self.optional = old_optional
+        self.verbose_warn_install = old_verbose
+
     def recommend_sphinx_version(self, virtualenv_cmd):
         # The logic here is complex, as it have to deal with different versions:
         #	- minimal supported version;
@@ -1053,24 +1077,8 @@ class SphinxDependencyChecker:
             print(f"\tpip install -r {self.requirement_file}")
             self.deactivate_help()
 
-        print("\n2) As a package with:")
-
-        old_need = self.need
-        old_optional = self.optional
-        self.missing = {}
-        self.pdf = False
-        self.optional = 0
-        self.install = ""
-        old_verbose = self.verbose_warn_install
-        self.verbose_warn_install = 0
-
-        self.add_package("python-sphinx", 0)
-
-        self.check_distros()
-
-        self.need = old_need
-        self.optional = old_optional
-        self.verbose_warn_install = old_verbose
+        if self.package_supported:
+            self.recommend_package()
 
         print("\n" \
               "    Please note that Sphinx >= 3.0 will currently produce false-positive\n" \
-- 
2.50.1


