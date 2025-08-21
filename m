Return-Path: <linux-kernel+bounces-779271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC7B2F192
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5775E1CE08AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901702FD1C4;
	Thu, 21 Aug 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbFBenZZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E62EB86C;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764225; cv=none; b=PgbJZNwKeFCcTD5qmyLw3LsOk3r8WaGTj26L7Qfv61P/8eGLL2IBIHRLCCx5nZSmFNv6P+cHtjYlihRgE2q2OGpH4YyQvRBfgo2rzrOQjyZxvWtpexJUJqzrkttWu2yPJOy3EtG1ErMX4AWOvfp26549xCfVibO4m+grFafePu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764225; c=relaxed/simple;
	bh=DbSg1eVMzWOl8sp3iwWjKfFikdD3ZrhJkW3NI3ZW7Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p23bWhs7TaHRJcWuIA4Bb8b+Z0AV2LJ24tlpqQN0RoztsrLWcn4DBpgK1sGtMoITvdxUiQ9hgBrMqI2zP09BWmm/BVFAFcsoMvSts2HhYH7envAlepJmlKjVlBSC4a+S4YIVd4PRZJO9bjTfejbppzp3+TgJI3Ivu2HYdtOFaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbFBenZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A34C4AF0B;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=DbSg1eVMzWOl8sp3iwWjKfFikdD3ZrhJkW3NI3ZW7Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbFBenZZGSqb6+92iV9k8tbt5QVzepDHP6dfiWwWmRrQWWMHIbP51Exzp+t1LRrsQ
	 NuT8Xa/htYETEn5gLTAWLSTbhnnjyi2du+7pU5Xl8VAF2sacylRtKfnMn+o5Lpds8m
	 wFVQT3H7LGKP/3pjypwYhh87T54nMH3SRr4zX2FnCKivWIARZ+5mYw+qShd1z73/RI
	 H1JQbkz4WcWDu4m1+OM+kDDWhiAPkaFomzb/GcNhamYCxWv4OZZjhbyP5rS2iyKvPZ
	 wVh6B7mWjB4R1pWY90Aal+jSPy5EGP+LYn1xKfXOHSqwAWg9S+sKjU3IKEhmW8aKNq
	 2FrqNTW5aHulw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgj-3X8Z;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] scripts: sphinx-pre-install: fix dependencies for OpenMandriva
Date: Thu, 21 Aug 2025 10:16:47 +0200
Message-ID: <669e759ba366328e5c8d5b14a591ba45a1f58176.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
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


