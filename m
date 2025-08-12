Return-Path: <linux-kernel+bounces-765185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5234B22C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EBB7AAFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946DD2FD1D6;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpgghlEw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B72F83AC;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=cKpHpc3FSYEB8iKgs4ATh4f1XE8wJXJ+OpnY0ZoZQFPqAa058VyBYyx0f9V6BbE/jCjiDnQM+DTjhGA6UICX8K+wunJw4wNL1H7Z0ZUc5A4Z5koKunKRI3bmdeuEggj4jB2bRj6lpE1XFJmeFXEhwsAoplKk1ns0Q29Nq5Ew13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=WIW4xmrBDrTW4s4+RAhMaPsZsgGw9ZJA1kTCbhssfL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQIVDEOi4Gct1OREdKni3uZpm0xAhlpHSS3TT2/GnVUn2L7bpO2zbnpXt4O+Q8NHD6VAgpFiR5BP8hSXw51ecRafh8TSAQyyZgkiNb1ef9EEMWRm4ZI1XtoHYEt+5TmBW/XcaYXuGSHzB1Gv1akGxo+nKlx77WPADIoX3WNRbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpgghlEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06EDC2BC87;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=WIW4xmrBDrTW4s4+RAhMaPsZsgGw9ZJA1kTCbhssfL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CpgghlEwndxcgRLA+ym40cijs9ihpb5NSiq4AKsyk3H2YDcIEwveVKYre3g4EdjJp
	 UXqisr+kF71p4iax7hGPNyY07oP0b957VRMWefVgWVr+QI3HYw28INhk45KDjzuY7I
	 TVWTb8XOV1nCaukaVG42vPkH1DJbu0BLwEtNJcwHOtpT+ugxdlHZQK2fHAyH4FzKC6
	 CD1HkVJI4ifqfqUyX/KDZwGCGndoNEfoyhONBVGFpc8NVw2cFZxWQC+u7evYcJS6xa
	 bbyvov5wJDWqH/ZZG1S4RrWAE/ywuhrXaFb64WZBViMGwFnWNBP88Q5AfJ8CDx712C
	 AUQVCulr/hGfg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWo-3KYY;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/39] scripts: sphinx-pre-install: better handle RHEL-based distros
Date: Tue, 12 Aug 2025 17:52:42 +0200
Message-ID: <4d1b27d3a381f011e150bb50176babba83af9e1a.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


