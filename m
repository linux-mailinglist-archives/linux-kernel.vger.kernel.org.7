Return-Path: <linux-kernel+bounces-779276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14358B2F18A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CD21C21EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE74C2FDC2B;
	Thu, 21 Aug 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxn2eg5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A282EB87E;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764225; cv=none; b=S3+vAcnQG8Jg4P4bo5dOWAoVaoL6BPVyb/XBup5O3cKHjV288OP0BoKHkfEAbRX8PiX0UmBMxj+I3eytqiMCZCvVRX1HjwOFsCvlyShDMT6LIHMDLplGccPe9Egfnxs8RqIvXYlz9zjmQiAKQWlbh5qNKEjmUR9vyEduH/HdW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764225; c=relaxed/simple;
	bh=fC/Zs5gmjYzgmfpcSoCA1d9edA3MkAXrkitO6YzqW1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqxJU/Vf7d/1Jm9GR6swt1u7MGIC0N19WKXBqKYrhpsI7FONv5Z1iuP6wiQkIAdX+Qffp8gAUvbOhyxx9824C7iToVPnny3Ona1x8LHTlIAQnkMKv1yiqqWQrX9rR3UlQ0VPlYsfma8aWMv7x+86rBpgSQVz1svKqhcdej3Luu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxn2eg5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E5DC2BC9E;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=fC/Zs5gmjYzgmfpcSoCA1d9edA3MkAXrkitO6YzqW1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kxn2eg5hfLDgU6IiKOwWrsnCHuBYltIx/uzLZwPGX5VRzt19eYUC7hNts7A36RUH5
	 nWYxU+jqmoSbi7/5NTlufbdZcajVVDZ5E7Wb0j4osWiMrnVZBdNfM68bXjNmsx2L95
	 8gV4bapR8CNusMIDFANIvI0NTk3tfLhRn/I6Ipq0a0k0szGTZfrDrsCHYrKAQD2XoJ
	 6fvxG6hd6jJ+nsMY7rIO7lDmoyrL2AFacvHJzdOMk8O04LIQOAp0avTVV9rO2F/aFW
	 awRiLR5Z8ycUYrUOz3hO9+O4lpYXZMe39KSI3t2AjLGQEfMN7rlD6/FimLBAJlhLvH
	 +UsH22sIE5hRw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgf-3Q5a;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/14] scripts: sphinx-pre-install: fix PDF dependencies for openSuse
Date: Thu, 21 Aug 2025 10:16:46 +0200
Message-ID: <d78457376f9dfd24cb7ac3a32895c654412715f3.1755763127.git.mchehab+huawei@kernel.org>
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

The dependencies are outdated: both versions need texlive-dejavu
fonts. Also, for PDF generation, python311-Sphinx-latex is
required.

With that, all PDF files are now tuilt on both:

openSUSE Leap 15.6:
-------------------
    PASSED: OS detection: openSUSE Leap 15.6
    SKIPPED (Sphinx Sphinx 7.2.6): System packages
    SKIPPED (Sphinx already installed either as venv or as native package): Sphinx on venv
    SKIPPED (Sphinx already installed either as venv or as native package): Sphinx package
    PASSED: Clean documentation: Build time: 0:00, return code: 0
    PASSED: Build HTML documentation: Build time: 5:29, return code: 0
    PASSED: Build PDF documentation: Build time: 13:45, return code: 0

openSUSE Tumbleweed:
--------------------
    PASSED: OS detection: openSUSE Tumbleweed
    SKIPPED (Sphinx Sphinx 8.2.3): System packages
    SKIPPED (Sphinx already installed either as venv or as native package): Sphinx on venv
    SKIPPED (Sphinx already installed either as venv or as native package): Sphinx package
    PASSED: Clean documentation: Build time: 0:00, return code: 0
    PASSED: Build HTML documentation: Build time: 4:33, return code: 0
    PASSED: Build PDF documentation: Build time: 13:18, return code: 0

Summary
=======
  PASSED - openSUSE Leap 15.6 (7 tests)
  PASSED - openSUSE Tumbleweed (7 tests)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index f987abfec802..86f129c76ecd 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -901,7 +901,7 @@ class SphinxDependencyChecker(MissingCheckers):
             "dot":           "graphviz",
             "python-sphinx": "python3-sphinx",
             "virtualenv":    "python3-virtualenv",
-            "xelatex":       "texlive-xetex-bin",
+            "xelatex":       "texlive-xetex-bin texlive-dejavu",
             "yaml":          "python3-pyyaml",
         }
 
@@ -937,7 +937,7 @@ class SphinxDependencyChecker(MissingCheckers):
                     self.recommend_python = True
 
                 progs.update({
-                    "python-sphinx": "python311-Sphinx",
+                    "python-sphinx": "python311-Sphinx python311-Sphinx-latex",
                     "virtualenv":    "python311-virtualenv",
                     "yaml":          "python311-PyYAML",
                 })
@@ -945,7 +945,7 @@ class SphinxDependencyChecker(MissingCheckers):
             # Tumbleweed defaults to Python 3.11
 
             progs.update({
-                "python-sphinx": "python313-Sphinx",
+                "python-sphinx": "python313-Sphinx python313-Sphinx-latex",
                 "virtualenv":    "python313-virtualenv",
                 "yaml":          "python313-PyYAML",
             })
-- 
2.50.1


