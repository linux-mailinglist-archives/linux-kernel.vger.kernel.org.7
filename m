Return-Path: <linux-kernel+bounces-867345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9A4C0254F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F36A3A3406
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F4F283CA3;
	Thu, 23 Oct 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="e1HG0Mzh"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A727E054;
	Thu, 23 Oct 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235853; cv=none; b=th3QHX6T4ToSG8yJeL+iXb5d5oFcbVfJ7quODGmL4fcvyb4k7ibQ9ASmq8kFrYoL8jKuL1zwXCSK5dpc7Q3CSadQOO5FbNnDks7EfdFp1WZ1CR7w1Wbkf3xzHgMZsyuNocrEMZdTjKA5HWEz3Z6UuotNxuK0p5vPRFSitu/Hoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235853; c=relaxed/simple;
	bh=6S4gLBTXovaIoT0EEaY1K3SMPnixgLqTJpqboP5rM/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBqErJEwRrodre/OobVQG0cwCaoZKbE3AA+CPz90hHTwfQ8szQSrbOwCnqpGQBdQL/Kzpbp5QF9Og85f2TuCHQri4Ew2FaAMj9PQoIG/NtB2Jrnn+HFuI4ToyLYDHLggElVaNFHPn0i1Ry4ZhCG7KZblN5ho/NIMNKw52klnYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=e1HG0Mzh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 366E940B3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761235845; bh=XBPcX2vWQ+8XRkE4kSjK0BRSS1CQI3H0dw/6+99AD6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1HG0MzhakASv+DnzYy4S5aMZ9vxvqeHodKzjpgpSiQWWefIPbk2U0fZ1UXmVs9SU
	 KJ7TmQ8toJlKMjRZHTB+aUPDqTRp/LEuuIxfRHB+1Abz3Y9PU0FYauS76D7QU9Vybh
	 6bXoz4Y9Vl4O0/8JseJkHq1R4WszY3G7T8S84dBbQ49Tlo9cUoj/cIbk4rte7/lqv3
	 GSqCMYcn8fLC5ydduBmnH29vqfz84W3XABx1pEjPxYeTJDpjnKW/AU9J04UkzeMG9J
	 bcDilSorApMGRNK4tN4abaf5oBL3B7CnR23SIqJ7hAvPIKoXsGYXvyDURdhmzsvMx3
	 6+nEeeh5Gt9Cw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 366E940B3C;
	Thu, 23 Oct 2025 16:10:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 03/10] docs: move scripts/check-variable-fonts.sh to tools/docs
Date: Thu, 23 Oct 2025 10:10:11 -0600
Message-ID: <20251023161027.697135-4-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023161027.697135-1-corbet@lwn.net>
References: <20251023161027.697135-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move this script to live with the rest of the documentation tools.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/Makefile                          | 2 +-
 MAINTAINERS                                     | 1 -
 {scripts => tools/docs}/check-variable-fonts.sh | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename {scripts => tools/docs}/check-variable-fonts.sh (98%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 820f07e0afe6..b8795f704385 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -146,7 +146,7 @@ pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
 pdfdocs: latexdocs
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	$(foreach var,$(SPHINXDIRS), \
-	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
+	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/tools/docs/check-variable-fonts.sh || exit; \
 	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
 	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
 	)
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b5413e779f4..0f2d9ff01ae6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	tools/docs/
-F:	scripts/check-variable-fonts.sh
 F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
diff --git a/scripts/check-variable-fonts.sh b/tools/docs/check-variable-fonts.sh
similarity index 98%
rename from scripts/check-variable-fonts.sh
rename to tools/docs/check-variable-fonts.sh
index ce63f0acea5f..eb78ccf11be0 100755
--- a/scripts/check-variable-fonts.sh
+++ b/tools/docs/check-variable-fonts.sh
@@ -106,7 +106,7 @@ if [ "x$notocjkvffonts" != "x" ] ; then
 	echo 'Or, CJK pages can be skipped by uninstalling texlive-xecjk.'
 	echo
 	echo 'For more info on denylisting, other options, and variable font, see header'
-	echo 'comments of scripts/check-variable-fonts.sh.'
+	echo 'comments of tools/docs/check-variable-fonts.sh.'
 	echo '============================================================================='
 fi
 
-- 
2.51.0


