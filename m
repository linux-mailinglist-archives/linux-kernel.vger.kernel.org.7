Return-Path: <linux-kernel+bounces-723789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB1AFEB08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2D25641B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476D2EAB6A;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq1GDBVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D912E610C;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=F4in5NAbb0C4nV1RKJ8CKOVU3MtYiM+5KCsoXIvbkCh/4AJ8fZhF4DcU4oI5XloY4G8ootF4litht1raQwbx+YUul8QuFdYOIbyZO48jcRJvJs/vh2wOvvJtrTAHzWm6wWeMVnqA1mbLbQJWZ51vFtXa4jTaBQ31fqD3LI68iXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=dlvtFjDx3u9j2myWhO/mqck+5Tif4fxNwbNfKRZqDdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzk6u6fyN3xfmbdlDbX+9Zoht4W5nZRnvq0JJmaevfgfDP8aPflQ5FthBWyFGMeQj0FsHDruekZDw/+KpPZnL931SYdxCyKimL3Y3tG/7QALGNXu9J2r4XNwS9xoOvAU81j8tAJCX66T9ygy3hKJj8LpF1LCq9c1hzYBV4lkAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq1GDBVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAF0C4AF09;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=dlvtFjDx3u9j2myWhO/mqck+5Tif4fxNwbNfKRZqDdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fq1GDBVklavfrdvDCoKzxDKA5ISVbqdrt2kq+0CpFvbO73kVK+kDUsr7oXnExm2Mw
	 b+PIWqKqlEvIkPd1LVO0OC2/cp/NinIlh9C8KM3VHTQdHvIdvtWZwEgo/jFMhtyABO
	 I18edLua34vwuftyPrU78S9uRs2zYsjhGoigP/AacH38Tq06lgQjSszL8EYWuVL5QA
	 gmGfP4IgTVUc2tfMRZjlX1YTNMUQKayBwbOVxRTSfIJdq5m9ey+NH90msYScykTXKm
	 R4jM2kW3Yr0+gfOhASrhridY/bVJSz9YcE6lfy8L5DUdKshroQ9CEty1EQwV3BYGfr
	 QIGXsZb9qH8DA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDD-2YsP;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/39] scripts: sphinx-pre-install: better handle Python min version
Date: Wed,  9 Jul 2025 15:51:55 +0200
Message-ID: <f3e79715d7860bcbf817a76a0864d8413820f2b4.1752067814.git.mchehab+huawei@kernel.org>
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
2.49.0


