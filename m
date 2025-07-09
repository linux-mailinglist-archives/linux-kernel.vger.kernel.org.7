Return-Path: <linux-kernel+bounces-723777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B51AFEB04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E781562FA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D11B2E92AD;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THV8hjm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791A72E54AD;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=W0obnz/eA8IYBN65Qtm0QYD4YVHRdzeKTcroA+WqLSSd2zUXPTeixAZOCLh/B3dnRUlatXo65tXGPLyJyqNRllHMyaDUMXW/zBErRKyO7Q5Z7wAyTiWFrJQ9a93XFZ3m5M1Javig/K6mNEDA5xXwMDwfPpPdCzUuYjDuGrZci34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=c0eqVyycu6+AkYkbP+HjEPSJRkmNcUy3eyHfhwOYGrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IftZx4nNp2XcknyRj7OM/T0lmqCBqtSjvX+5ulrE9Q+4/WvPAFcuEUyLSSHLYlGl4qyfX/SIGLsHazazYLO3yrWaWU4uYOF9QpXQBW9/Um8rWc9yhrfcgpw9MhZYVeW8+eXsc5IF5D1J7RpEw04R1x54UamyXJ9gvLazWRH/6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THV8hjm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9A4C2BCB6;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=c0eqVyycu6+AkYkbP+HjEPSJRkmNcUy3eyHfhwOYGrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THV8hjm72LyZiAHIgojHef5FqEFbEiYm4kCxvNcQRVuemg1qUwXmKL7nzTK3alvpo
	 uTg9A/pEd7TfMHbED9Gohb5Mm3hq497WSCtszebD+MnCDwuuUbkCl4q1VRJArDJ5x3
	 935bmsGgZx6mhLayLWwVC4jGy3vIuinbb+1RCc3FgeHSl6+3KBeLoL6/ISvMloi6UU
	 9/DAs2c0AdshxKIvf1Hp8NR1OWrhLN81Kp88b1bnUKT+AC+RtKqv95zpFknccqjvdZ
	 anw+Jue38Gfg+gKaGV8CK+iNh4uqLlSQkdte2DsirdOLboWjg1WXm3ARXHOEQulRxk
	 1scTcRWk6lHdQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDs-3hYe;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/39] scripts: sphinx-pre-install: add a warning for Debian-based distros
Date: Wed,  9 Jul 2025 15:52:08 +0200
Message-ID: <98e16b2f57c5a43074c3c03ec8758d4fd1107388.1752067814.git.mchehab+huawei@kernel.org>
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

On Some Debian-based distros, ImageMagick package has a broken
policy that causes LaTeX to fail while building docs.

Add a note about that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 324baa98a395..09a337509b23 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -782,6 +782,11 @@ class SphinxDependencyChecker(MissingCheckers):
 
             self.check_program("dvipng", DepManager.PDF_MANDATORY)
 
+        if not self.distro_msg:
+            self.distro_msg = \
+                "Note: ImageMagick is broken on some distros, affecting PDF output. For more details:\n" \
+                "\thttps://askubuntu.com/questions/1158894/imagemagick-still-broken-using-with-usr-bin-convert"
+
         return self.get_install_progs(progs, "apt-get install")
 
     def give_redhat_hints(self):
@@ -1193,7 +1198,7 @@ class SphinxDependencyChecker(MissingCheckers):
         self.distro_msg = \
             f"I don't know distro {self.system_release}.\n" \
             "So, I can't provide you a hint with the install procedure.\n" \
-            "There are likely missing dependencies.\n"
+            "There are likely missing dependencies."
 
         return self.get_install_progs(progs, None)
 
-- 
2.49.0


