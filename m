Return-Path: <linux-kernel+bounces-723771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E176BAFEAFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066921888B19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9B2E8DFB;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzgMQhH4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70B2E265B;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=Vo3rglxV4Qf3E6UWBVBaOzJ8srDntLHpYAxmm6gtp34BuVlxNx+cVTJLk5d9EsYwXiPYxh79ghSomtS4m/qu1rGy6oYsKk5iibaic/z1V09oM6S4bVfCJuuHPE7041HEA5CvTGcTDKBNhFF4e1wZDpK20xaAi0Y1UbVYNkDNC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=xFZLNwkdYKL1EU7gu8VeeFOwcLL2l6SYNOrdu6yu8Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKVwCR6XvkOuIeWUMFkFgZ7BWxSD61zNt7bInW8ZP+CXsegoDzuhK28J9ws9l9goULEGQ15BLmx1/2Y+t0KklRSO5IUbEP9zLp+mJBInikvJ4Q8RqAFA7YcelEBEqw5JCjLOrsU3fmBouU8gnj2vdQW0IBrPPERMZF+trOdS7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzgMQhH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EC1C4CEFD;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=xFZLNwkdYKL1EU7gu8VeeFOwcLL2l6SYNOrdu6yu8Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lzgMQhH4JoiZn1WOmnEvdnea7AIYUF1l83VRxelysw25y4ouXjVCr59+FwZ9diOW0
	 JT8yYoxqmhNTBCuehdql+3BLfS0rrhs5wa/kKCdpyy7OeTs1JwWEwiYXe8DDStNXHI
	 EFSeYGzqpbPt5eR3ITZEmsTEcXWTr/u34sfRcVQhbSYstpVcVPiO8Cc6qNkyIWatzt
	 MLm12olIOyGoqT9FLl2aJiVZpOFoHEPSC4cMM3XMiP1f9n6elXkwZDHtJQPzICX2sS
	 rCSfhIcFm3Q/p5VbYy/4LSZu2gjV5Dy49byqWTdO6rf1i+3W70JHSwDEkyXbAhPNpF
	 fOe5FLFbQt0xw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECj-1jQA;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/39] scripts: sphinx-pre-install: cleanup rhel support
Date: Wed,  9 Jul 2025 15:51:45 +0200
Message-ID: <65ae48c45bf7aada8b90a7bdb8d97bc661ead4f8.1752067814.git.mchehab+huawei@kernel.org>
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

Rhel < 8.0 is not supported anymore. Drop support for it.

Rhel 8 is problematic: at least on the tests I did with a
docker repo, it didn't work, but it could be due to the issue
that it is actually different than a real One.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 808d31bfa790..42f55e67256d 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -487,15 +487,31 @@ class SphinxDependencyChecker:
 
             progs["virtualenv"] = "python-virtualenv"
 
-            if rel and rel < 8:
+            if not rel or rel < 8:
                 old = 1
                 self.pdf = False
 
-                # RHEL 7 is in ELS, currently up to Jun, 2026
+                print("ERROR: Distro not supported. Too old?")
+                return
+
+            # TODO: check if RHEL8 still works.
+            # On my tests with  docker "redhat/ubi8" image, there's no
+            # python3-sphinx (or similar) package. It comes with Python 3.6,
+            # but there are other python packages over there, so it may be
+            # possible to work with venv.
+
+            if self.first_hint:
+                print("Note: RHEL-based distros typically require extra repositories.\n" \
+                      "For most, enabling epel and crb are enough:\n" \
+                      "\tsudo dnf install -y epel-release", \
+                      "\tsudo dnf config-manager --set-enabled crb\n" \
+                      "Yet, some may have other required repositories. Those commands could be useful:" \
+                      "\tsudo dnf repolist all" \
+                      "\tsudo repoquery --available --info <pkgs>",
+                      "\tsudo dnf config-manager --set-enabled '*' # enable all - probably not what you want")
+
+                self.first_hint = False
 
-                print("Note: texlive packages on RHEL/CENTOS <= 7 are incomplete. Can't support PDF output")
-                print("If you want to build PDF, please read:")
-                print("\thttps://www.systutorials.com/241660/how-to-install-tex-live-on-centos-7-linux/")
 
         if self.pdf:
             pdf_pkgs = [
-- 
2.49.0


