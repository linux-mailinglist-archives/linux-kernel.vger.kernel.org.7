Return-Path: <linux-kernel+bounces-770848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF11B27F93
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D171D04593
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2215303CB9;
	Fri, 15 Aug 2025 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acIb1pi5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648212FE06D;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258666; cv=none; b=IfI1FAytyzqI66T4KPMJ/PlOl6tgun/90apq0MAIMLnZiseTol/ZB0bjLDcnuwhzidsHi0FV94+9K4KWDf7nSOhswNmFfhPQWs9nd0ieXXgTjjGV5Grbm7TnWYJWcvSI8DiOWYK6jxiyEQWi22KwiKLUtoj3Y/mteOuftLaEcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258666; c=relaxed/simple;
	bh=M/Xid9UCECaZaplNDPUeVWw4gAtONrcmsCGcddE9UyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8/uXIT7j8qfh7mSOlwlrf+kyx0+7qxNUrl5n4NhmUS37G4cUCoz2cNaGmCaAYVG3lwrghuLndVppYEA3HXqzUWmyGhDpD9t4WRyEwDBShWkJ1GF/ar7MMD2mKxGL+9zNLf84ugDJ3FtQtFBBdoy+3DjxekpWy9uvxsSk1ZV/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acIb1pi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11480C16AAE;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258666;
	bh=M/Xid9UCECaZaplNDPUeVWw4gAtONrcmsCGcddE9UyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acIb1pi5M02DmAniDHj6wI5v+F8YZtGF27mThCk+gdRjQXJmDJ3fpEDtnU/PTL17c
	 xPlnDdYzmF3/GJsRpXOXQkqI453QHS2giSd8qgZT7eT65KBkSY061N13AzJjgnlnB5
	 i4RB2PnJI0UqJY/LIXE+khYYrSYq1KM46iDjhe+jCgrUmwUPtM2gOfeEE0I2d/OYZI
	 GDI7XaXyAZEzcr4QxvNl4/csxoC+9H+xqpTG18oBRt1vb/in0r5aP3oCjhVh4PoESA
	 YKBY3KEBrLOxx6/Ix/OZcfubsrfkcjXXs1aGj4XsxtomaA7ooYstZ4Je5sy4YaJhC6
	 VQfdBKooD3SsA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umsxc-000000042ou-16aQ;
	Fri, 15 Aug 2025 13:51:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] docs: Makefile: cleanup the logic by using sphinx-build-wrapper
Date: Fri, 15 Aug 2025 13:50:39 +0200
Message-ID: <1dbef234504de4a661baaebcc79c9ae3accdb23f.1755258303.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755258303.git.mchehab+huawei@kernel.org>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that we have a sphinx-build-wrapper capable of handling
all the needed step to build the supported build targets,
cleanup the Makefile.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d2e626627ee6..5a3dc9e5b578 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -19,11 +19,9 @@ endif
 
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
-SPHINXOPTS    =
 SPHINXDIRS    = .
 DOCS_THEME    =
 DOCS_CSS      =
-_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
 SPHINX_CONF   = conf.py
 PAPER         =
 BUILDDIR      = $(obj)/output
@@ -33,6 +31,12 @@ BUILD_WRAPPER = $(srctree)/scripts/sphinx-build-wrapper
 
 PYTHONPYCACHEPREFIX ?= $(abspath $(BUILDDIR)/__pycache__)
 
+PYTHONPYCACHEPREFIX ?= $(abspath $(BUILDDIR)/__pycache__)
+
+# Wrapper for sphinx-build
+
+BUILD_WRAPPER = $(srctree)/scripts/sphinx-build-wrapper
+
 # For denylisting "variable font" files
 # Can be overridden by setting as an env variable
 FONTS_CONF_DENY_VF ?= $(HOME)/deny-vf
@@ -103,7 +107,9 @@ refcheckdocs:
 
 cleandocs:
 	$(Q)rm -rf $(BUILDDIR)
-	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean
+
+# Used only on help
+_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
 
 dochelp:
 	@echo  ' Linux kernel internal documentation in different formats from ReST:'
-- 
2.50.1


