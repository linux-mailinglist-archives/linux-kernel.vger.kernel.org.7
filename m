Return-Path: <linux-kernel+bounces-723799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771CFAFEB1B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654625C3334
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731F2EACEB;
	Wed,  9 Jul 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp6CdJ19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A12E62C7;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069142; cv=none; b=Xby6PnP/zIMlESRQQ1Qvtcd/CfyDmBY0aCXES/lNT8YUbNxGBIDj0UCcqhM3t+CjZeTnRU2dc9AjEZRi2DiV41ECfb+2yvwYqLNarRJD895hG361HElycjDr1tHdsI6OOCAfhnAIxYwbr+rBStXLyzlQsmBWEDm3iYNlT3D5EmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069142; c=relaxed/simple;
	bh=FBElmqvyhBKLXVXL/Ckav/ng29pt1hj+3FlkcjHKvNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYLLdwGfOMU9iqLldrnLLwYTzdJM3yimCJKzidhW8z74neQY4LaOJmBy/M+aae6x3eSdBy8/xH8rFK3aE+ZrkDbHFhDvpGFqSuU3BBvlFYeEVBYTEk4zHPOC0UY6mC4X82YCL9RcLBJ+qIXwV6NwT12rNBAV4O86BqzfjxAovPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp6CdJ19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9094C4AF15;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=FBElmqvyhBKLXVXL/Ckav/ng29pt1hj+3FlkcjHKvNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cp6CdJ19RKlmasF6xihFNkVJUQuy66Dk7DJ05C1fEUgTE35cyyybr0FvQDVnzR7H8
	 yKoFHGWtpWLBzqTGH8LjHmKmEq/6aOlszO07I6KwnkjmEpQKxlq/WmsddsG+zuFD3S
	 b4+kZeG+TaIlfNHvrQ6d5syb1EEYLdOFTKQIBEnDyoZcPQkSAoXmDqKalCGx2BD3uC
	 S4E8oCPTyHDUaLDR88TURREqk8PpHQCg6H0K3wv5hEzMMiYk9YfcLMiJjA+yvN+qEW
	 BFZh9jITUYnAJoBQV+z8ksBNtSIS5sfRdmLVdM0mtKGKURPs5BH/gFpDtimrHg5aOP
	 lNXf8tSkw7qrw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDJ-2jGo;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/39] scripts: sphinx-pre-install: better handle RHEL-based distros
Date: Wed,  9 Jul 2025 15:51:57 +0200
Message-ID: <96c4982d419b60af948e1b4d9b44a51a2681abd3.1752067814.git.mchehab+huawei@kernel.org>
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

Better implement support for RHEL-based distros. While here,
get rid of a Fedora 28 support which cause troubles with
server distros. Also, get rid of yum, as RHEL8 already
suppords dnf, and this is not the minimal version we may
still support.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 0963da21c27b..592223fa686f 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -536,10 +536,6 @@ class SphinxDependencyChecker:
             "yaml":             "python3-pyyaml",
         }
 
-        fedora26_opt_pkgs = [
-            "graphviz-gd",  # Fedora 26: needed for PDF support
-        ]
-
         fedora_tex_pkgs = [
             "dejavu-sans-fonts",
             "dejavu-sans-mono-fonts",
@@ -549,9 +545,8 @@ class SphinxDependencyChecker:
             "texlive-xecjk",
         ]
 
-        old = 0
+        fedora = False
         rel = None
-        pkg_manager = "dnf"
 
         match = re.search(r"(release|Linux)\s+(\d+)", self.system_release)
         if match:
@@ -559,12 +554,12 @@ class SphinxDependencyChecker:
 
         if not rel:
             print("Couldn't identify release number")
-            old = 1
             self.pdf = False
         elif re.search("Fedora", self.system_release):
             # Fedora 38 and upper use this CJK font
 
             noto_sans_redhat = "google-noto-sans-cjk-fonts"
+            fedora = True
         else:
             # Almalinux, CentOS, RHEL, ...
 
@@ -574,9 +569,6 @@ class SphinxDependencyChecker:
             progs["virtualenv"] = "python-virtualenv"
 
             if not rel or rel < 8:
-                old = 1
-                self.pdf = False
-
                 print("ERROR: Distro not supported. Too old?")
                 return
 
@@ -607,11 +599,16 @@ class SphinxDependencyChecker:
 
             self.check_missing_file(pdf_pkgs, noto_sans_redhat, DepType.PDF_MANDATORY)
 
-            if not old:
-                self.check_rpm_missing(fedora26_opt_pkgs, DepType.PDF_MANDATORY)
-                self.check_rpm_missing(fedora_tex_pkgs, DepType.PDF_MANDATORY)
+            self.check_rpm_missing(fedora_tex_pkgs, DepType.PDF_MANDATORY)
+
+            self.check_missing_tex(DepType.PDF_MANDATORY)
+
+            # There's no texlive-ctex on RHEL 8 repositories. This will
+            # likely affect CJK pdf build only.
+            if not fedora and rel == 8:
+                if "texlive-ctex" in self.missing:
+                    del self.missing["texlive-ctex"]
 
-            self.check_missing_tex()
 
         self.check_missing(progs)
 
@@ -621,11 +618,7 @@ class SphinxDependencyChecker:
         if self.verbose_warn_install:
             print("You should run:")
 
-        if old:
-            # dnf is there since Fedora 18+ and RHEL 8
-            pkg_manager = "yum"
-
-        print(f"\n\tsudo {pkg_manager} install -y {self.install}")
+        print(f"\n\tsudo dnf install -y {self.install}")
 
     def give_opensuse_hints(self):
         progs = {
-- 
2.49.0


