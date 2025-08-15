Return-Path: <linux-kernel+bounces-770826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63496B27F60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7D25E9086
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51451304969;
	Fri, 15 Aug 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lir05pcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950D288529;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=jQ2LVRYRPPRclX4Otlnsv+9Y9lN6npZ8LMEFqtXeN+18ntHJM3seJ6d6yT2h2sAaQFfLHjdb8nzYAsWCsiOcWzTZRcMz2wYla4ndDItEHJ98TjocTEr3in70GaWImyDCrGrCWdJy0JTu/AtFotqRR42pLtsAnes7Gh5z11P0KCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=DbSg1eVMzWOl8sp3iwWjKfFikdD3ZrhJkW3NI3ZW7Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kl871T8WOrRiu8mJQfMDCnZkSawl0lch2NoBWGNXe/EjtaS8w2HJGuEl7Laz109fykv3hPnFjFMwC3n88we0uh1jR3Lu0i5ez+n47CdXjRCpotaoeLXf5iul1xeRSLXqBg6oFSO9MX7+usRheHxStCRPQrt0L94SUApQ3re0zoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lir05pcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6A3C4CEFF;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257846;
	bh=DbSg1eVMzWOl8sp3iwWjKfFikdD3ZrhJkW3NI3ZW7Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lir05pcNITHZGagABV6/OicIXK6PyLn8cU+Ikx2xcaYgyXGWujmjzHpXwbgjy7CYY
	 nShNUZ34Oxhxwjp1RmfJyl+chUSMirQsb6R+FO9kxD6BVLjK0U53jeFuSJ47Us0Nhw
	 s/jX33AzUcSuEWXfaKsCvO0AAJkFmFd0ZjER6kfEcY7zQAq1ODZbI14aE0QV0zrI5t
	 B4Mqdpu5gyo7wAe4P90PBnW8nQvlI35e+CZhlKL9Ei46ug+RszcCFv3Qrxd2nB1a/r
	 3D/xRm6CNYUVXIpNwy0c48gmgkgb7yXhrFPHG1vEQc0lizoz6Ae03HeOzYMVsBZcgB
	 aNY1V4EvLqHtQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskO-000000042TT-0lfq;
	Fri, 15 Aug 2025 13:37:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] scripts: sphinx-pre-install: fix dependencies for OpenMandriva
Date: Fri, 15 Aug 2025 13:36:25 +0200
Message-ID: <73a2384db32429ac6640474d63af9a7440c7a211.1755256868.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755256868.git.mchehab+huawei@kernel.org>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The dependeny list for OpenMandriva is wrong. Update it.

Yet, on my tests with OpenMandriva LX 4.3, the texlive packages are
broken: xelatex can't build anything there, as it lacks xelatex.sfm.

Yet, this could be a problem at the way I created the container.
Just in case, add a note about that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 86f129c76ecd..224db3af17db 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -984,13 +984,19 @@ class SphinxDependencyChecker(MissingCheckers):
         if re.search(r"OpenMandriva", self.system_release):
             packager_cmd = "dnf install"
             noto_sans = "noto-sans-cjk-fonts"
-            tex_pkgs = ["texlive-collection-fontsextra"]
+            tex_pkgs = [
+                "texlive-collection-basic",
+                "texlive-collection-langcjk",
+                "texlive-collection-fontsextra",
+                "texlive-collection-fontsrecommended"
+            ]
 
             # Tested on OpenMandriva Lx 4.3
             progs["convert"] = "imagemagick"
             progs["yaml"] = "python-pyyaml"
             progs["python-virtualenv"] = "python-virtualenv"
             progs["python-sphinx"] = "python-sphinx"
+            progs["xelatex"] = "texlive"
 
             self.check_program("python-virtualenv", DepManager.PYTHON_MANDATORY)
 
@@ -1004,7 +1010,9 @@ class SphinxDependencyChecker(MissingCheckers):
 
             if not self.distro_msg:
                 self.distro_msg = \
-                    "Note: for venv, ensurepip could be broken, preventing its install method."
+                    "Notes:\n"\
+                    "1. for venv, ensurepip could be broken, preventing its install method.\n" \
+                    "2. at least on OpenMandriva LX 4.3, texlive packages seem broken"
 
         else:
             packager_cmd = "urpmi"
-- 
2.50.1


