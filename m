Return-Path: <linux-kernel+bounces-767516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90016B2558D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC8A3B3BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE230E823;
	Wed, 13 Aug 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="eJ2HIX6A"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915252D061E;
	Wed, 13 Aug 2025 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120757; cv=none; b=sEPT6rYk4e4hVUR9C2WsVZ/zW3LBLuRxlUKfCV2IGFiNSoFnDSxagdmL+0eZgzcVTtpToIeuX879nyfLn9Arwi1WVaQZg19zxwgpK28ljZiAVvdc6z3dkHqL9ZoZMo8cXBGgGT4Bj2J+bzVMrVRYLcmKTxM62WcWfz67wDUXs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120757; c=relaxed/simple;
	bh=v7g6zpss8IUeemtM0CDlpIOABCzgG7YdeGrLH61dWag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/CbsfIdE9ieSTPK1uO/D/rzlZAMgeScCLKo3HH4GVCcxSBaWcC9McSJ2BcPWFy6JwGylplN6MxZiZ6Zh/mZVfyrtWgQaHeIiLejSRS285lFyrKQsRv27Ml5P3reyracXaqc/vCY3VHPeOnZktySXwcawpv55bOwhWXRpb2iLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=eJ2HIX6A; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1309940AF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120749; bh=MDQvvRBEgYN5FGOXnKomMUjquDhJ5zdv5Vhtz4dl+kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ2HIX6AbD2s6Xeo9Xcvqto0smu6TVpB5Fl84zvlN2muIUPI0TAtMlvAoY3E+1bXc
	 XaIQHFZiAh+AV4urXbB0a1C/huY1EkyJqelPw3MlNz5iNA65QaG8S3/Dd7KNC/vHbP
	 HQElVJgF1G+GAykZR0rYBLv+R3762Tg10kuE2ZrnRlBFrJ4Zos6bzkxQt7hOrTLlTH
	 g8EOJAYh56aeL3ljQaXvU/aJ97z6kmiqblyM8SaFPnRdQNqk6SIagJtj2rLu0VP/aW
	 dMNVU3xu/2OX3+yFuN1hUQw94Oa6I3Vc4T1JibscikopAzvMS264YHmsJldK90/T3R
	 vybGpyuwi7Epw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 1309940AF6;
	Wed, 13 Aug 2025 21:32:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 03/13] docs: move scripts/check-variable-fonts.sh to tools/doc
Date: Wed, 13 Aug 2025 15:32:02 -0600
Message-ID: <20250813213218.198582-4-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813213218.198582-1-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
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
 Documentation/Makefile                         | 2 +-
 MAINTAINERS                                    | 1 -
 {scripts => tools/doc}/check-variable-fonts.sh | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename {scripts => tools/doc}/check-variable-fonts.sh (98%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 820f07e0afe6..70095465dce1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -146,7 +146,7 @@ pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
 pdfdocs: latexdocs
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	$(foreach var,$(SPHINXDIRS), \
-	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
+	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/tools/doc/check-variable-fonts.sh || exit; \
 	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
 	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
 	)
diff --git a/MAINTAINERS b/MAINTAINERS
index a3a396fc1c3f..ca4c7992369d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	tools/doc/
-F:	scripts/check-variable-fonts.sh
 F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
diff --git a/scripts/check-variable-fonts.sh b/tools/doc/check-variable-fonts.sh
similarity index 98%
rename from scripts/check-variable-fonts.sh
rename to tools/doc/check-variable-fonts.sh
index ce63f0acea5f..9660df53d716 100755
--- a/scripts/check-variable-fonts.sh
+++ b/tools/doc/check-variable-fonts.sh
@@ -106,7 +106,7 @@ if [ "x$notocjkvffonts" != "x" ] ; then
 	echo 'Or, CJK pages can be skipped by uninstalling texlive-xecjk.'
 	echo
 	echo 'For more info on denylisting, other options, and variable font, see header'
-	echo 'comments of scripts/check-variable-fonts.sh.'
+	echo 'comments of tools/doc/check-variable-fonts.sh.'
 	echo '============================================================================='
 fi
 
-- 
2.50.1


