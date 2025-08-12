Return-Path: <linux-kernel+bounces-765171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F01B22C98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D8B621AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06192FA816;
	Tue, 12 Aug 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFcDJW0t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471BC2F8BC1;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=VQ4OhIZ8QxaE5WJh32PDM9GH6sTHtE3/d3nk6G0ujCaUF0d9CJeDpVBCoe0jOqaOu9KOh21h1fai4RhhRitBBWHym4SgXt29d8j4UUeGsSLyUxUipeNxc8Gs2maC4N2uuQ34pTkCKobMRNFS0SuEX2SYg/JlBxz2VYYdlZBq7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=w1TdiGxle94uulUw1dxGBpedHds+Ef+v2jfRhcuJvSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIx3NrP52N1VURnsiIiis6zKhzSGllJLQ+aLTzRjHAthIeW7hxYB0sI4ur86putNF0ErUg6T9fkuHoXpiLMSNJ7mvEkXKFjiE6okFgwWikUhhvM64oQs+z5mmuJqjkzmgpgzC3RXnE3t5vO3b19PYzXNR4vOC3Dg+B7tRLEcT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFcDJW0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C426AC4AF0D;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=w1TdiGxle94uulUw1dxGBpedHds+Ef+v2jfRhcuJvSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFcDJW0tfgs2h5PaGsRCQUGd14d8v6kjYggaFA6X9mWsvSWffK1RAIFNmc0g5dnG0
	 IccqBiNSpYA1VSywNETNg7vGGQ06UQSB6A2YPoPK+Xr6GuX8jJGenJ0Zyx5S5/ljrv
	 1VfWPvGxVLmNqAE6lPSY1g4/n2WbFKckaUQRmNEEh/IS/V6Co4gB55Jb3BK5QDNicS
	 Sn4adJ34bKsIGuBRVqKy4L7jnwJLWWuee2l8MEzKJbNzTmA+nKjyjVecRts2N1+n/m
	 vll5NrJejWHvAoTPb5JlFStv0SPDi28aFhjy4Et43sddB7WKhenmXEkEcNH55IB/tt
	 a/6Eh1ACav4Tg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kW2-1pPu;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/39] scripts: sphinx-pre-install: cleanup rhel support
Date: Tue, 12 Aug 2025 17:52:30 +0200
Message-ID: <62fe8ab243ad39f4964f1f74b965e43dc8f10e23.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


