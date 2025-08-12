Return-Path: <linux-kernel+bounces-765189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C5B22C95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C37173391
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E02FD1D0;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIQ/OGUA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC32F83B2;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=DJh+wbiBA64LiQsNqhxkrtwZNjjo2gm6is565O8UJem28CLT6epYNuCpeEWmPpvhv+oWPA1wtP9a8p/RePVzBdqzqn74v/EnkdL4WDX48jfOHLpi2vJlDbquGJHWySB2VimGrIAev/Nu/UAkbRZ1WwG2maFGD5gWvBg//QkvNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=Ttf2nErBntacD7+Zyv3rczkrnRx+/elXiyJgXiaMhfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/uYtdb7wjWTIv4AdGVesv33Xknv/IGjPpAnMHQpHmaPqMUYc664k2ofxNRnuvI1/kRHfS8ifiJ8WodPZBwcWIISVe7PI3POgJq+F53z/1I6X88nFIfb0CAbzX4rhGrxO8LA2CVzgdmc2w8RmIolNwN5WqWGIlPbglgfCkyINSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIQ/OGUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174D9C2BCF5;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=Ttf2nErBntacD7+Zyv3rczkrnRx+/elXiyJgXiaMhfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIQ/OGUAkdovMTbFZ76EZtN7MVny+nAhrPOTQF2lWXbCfEhZaoTX58o7RXrDpRpn1
	 4uB3MvpMFvY2xiFfqabQNH3ncNOWEH7sUf45uViJJJ4Hq19dmlsikRea3CA3fUCfvH
	 DAp8+qezqs1/3r9ZYAQdnw4MWr10z3DYZndXob9UqqqeLQ/9X765eiyBs57ADle4ks
	 9pJZzg4KhrRLkBnGOU5SX8jfQQIfgLQQtqeC46F0ZOwh3iIJ+fFmO+L2G15hdr0//n
	 YWKMdo26zSNZJ00vqjwBuEMlw+rD/1myExlo+nCVJnsBRAcMwoKRHZRVkXm5bQQzhn
	 BXD0CCP6Oo1lA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ9-00000006kXh-0gG6;
	Tue, 12 Aug 2025 17:53:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/39] scripts: sphinx-pre-install: add a warning for Debian-based distros
Date: Tue, 12 Aug 2025 17:52:55 +0200
Message-ID: <628d01784e8c24e3d93c69c436f12398e00165b3.1754992972.git.mchehab+huawei@kernel.org>
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

On Some Debian-based distros, ImageMagick package has a broken
policy that causes LaTeX to fail while building docs.

Add a note about that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 324baa98a395..09a337509b23 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
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
2.50.1


