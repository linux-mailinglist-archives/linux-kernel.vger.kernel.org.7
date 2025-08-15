Return-Path: <linux-kernel+bounces-770821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609AB27F53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784EA1BC67D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108563009F8;
	Fri, 15 Aug 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzI8qDci"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F352882A6;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=W9xlkK7QVypobNLlIk47M0UQCwrhjtX+k9o5qyaX2gcA7eNfDPG39AkLtWFIPwvcHF4ohaKO5j8k+jqHIeazfIIoHYUv6Mr6tedG0hfrBiOUMlAHNq9mEAUwgUmmxdRwbvOKOJXww9DNtepKSpUfM8HavZuNmduPoC59Yw+jj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=fC/Zs5gmjYzgmfpcSoCA1d9edA3MkAXrkitO6YzqW1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5sEmWVIUQNmCJTc1TAk72ClIH8RQ5tuEQf2G+3ib7XtOjWz9/xvXpX8nHInVkaxT+wDkzApl535xBZOqPs1eIFWK0Ds8Omk5JmYaiz0gy426PipDkBF8+25PFhPMG5Nfs+TEXuf8x8k0TkFExX4Dvw8DiqXLUE5u1SFe56KFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzI8qDci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACC6C4CEF6;
	Fri, 15 Aug 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257846;
	bh=fC/Zs5gmjYzgmfpcSoCA1d9edA3MkAXrkitO6YzqW1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzI8qDciN69UTB2znPj5Ito1AtBzw9HaDuTdo0Ji6Tgx6E3zE0caxJbD8exUXHWT/
	 dzFdXjMcTL5ukEN/KU37QTDXwgJ6WJCOpfRgD+IhXxp18LF7pOeE+VCZYkVgcOsKAM
	 I/b+01mTvP0eaHc1sBU+GII++QGpQFlCS1CTkLtxfp7SRoQ4/J5cpBQJxwKCB2/vRC
	 XjjZW1vr3WOKkto1eGJMJRCVnBOylF9jUynKFIUuSMLkeJk3dz3wfkkSOk91fl9dIt
	 ATHBjg28i0Ub/vz64Mp6JA9Tc2rZMN/oNa37+w+0qm/naC2+bL1z6OpQm7wm0fgPtH
	 61nfcGdBxUpWw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskO-000000042TP-0et3;
	Fri, 15 Aug 2025 13:37:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] scripts: sphinx-pre-install: fix PDF dependencies for openSuse
Date: Fri, 15 Aug 2025 13:36:24 +0200
Message-ID: <cb4b9502d95cbb486c06acb50c45f5dcada01b1e.1755256868.git.mchehab+huawei@kernel.org>
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


