Return-Path: <linux-kernel+bounces-881820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C85C2900D
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC6188CFDD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9C219303;
	Sun,  2 Nov 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="gk8Y9jmf"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549D20C004
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762092655; cv=none; b=kwIRNqyjrpJywcHlTlnnrKnzYztFf75ZeCCS8A/3id/gTN70mXE51tfdRnW4QbMtbCfTbG4TiNzI7cgTu1iva6WIBOULri6eSH3ILfADPaAC48wWxjCRnbXlviwRkS1w7h1jcg/s77TZvazZL6CIsbKqjmGO+T/MLG8yoM5VO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762092655; c=relaxed/simple;
	bh=lCHlPHkdv1/NXawJHpuwj6rJ7BRsvDNM7ZuBARFoTO8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PwGKy8mSyFULSyjLtphog9umGHn7mrEo7iI4B4jjXt5Ao1IBplLzUnrm6SOR+e2TngxYrIm7/bTW9h9TWKQ0TX91GShnn8dpL7COTGdPmazAhzBeW9Jk8j9qdN2kTIGiwdxcVLP6jqZUk/sbHaETaLk1oxBFlSbbXk45NuE+J9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=gk8Y9jmf; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762092651; bh=3u4DfFO7kxUBf/y4/6YgRuX8bP9V6GRcADka+B5z5GU=;
	h=From:Message-Id:From;
	b=gk8Y9jmfwNGpnCPu6qnh/q+PJxM4yawI77mFThbZ9KS7Rt5adB/HJrP7B0350NLAq
	 ellXS8Kv3Kym4PQKQfNk2nx0772Hz18HRRSwNeMSW01JONgCLfYtPBLFaYBdOgnC5n
	 oRknHxrZzjesYQr0KqKTbILcKy5V5O/Dsf+Tw4P8=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 3289DC06EE;
	Sun, 02 Nov 2025 15:10:51 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2EAoKu008519;
	Sun, 2 Nov 2025 15:10:50 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux@weissschuh.net
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH] tools/nolibc: make the "headers" target install all supported archs
Date: Sun,  2 Nov 2025 15:10:45 +0100
Message-Id: <20251102141045.8477-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The efforts we go through by installing a single arch are counter
productive when the base directory already supports them all, and
the arch-specific files are really small. Let's make the "headers"
target simply install headers for all supported archs and stop
trying to build a hybrid "arch.h" file on the fly, to instead keep
the generic one. Now the same nolibc headers installation will be
usable with any arch-specific uapi installation.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
v2:
- updated to recent updates and new archs
- use only files instead of an explicit list of supported archs
---
 tools/include/nolibc/Makefile | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 6e31187c89aa..8118e22844f1 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -23,7 +23,7 @@ else
 Q=@
 endif
 
-arch_file := arch-$(ARCH).h
+arch_files := arch.h $(wildcard arch-*.h)
 all_files := \
 		compiler.h \
 		crt.h \
@@ -82,7 +82,7 @@ help:
 	@echo "Supported targets under nolibc:"
 	@echo "  all                 call \"headers\""
 	@echo "  clean               clean the sysroot"
-	@echo "  headers             prepare a sysroot in \$${OUTPUT}sysroot"
+	@echo "  headers             prepare a multi-arch sysroot in \$${OUTPUT}sysroot"
 	@echo "  headers_standalone  like \"headers\", and also install kernel headers"
 	@echo "  help                this help"
 	@echo ""
@@ -93,18 +93,11 @@ help:
 	@echo "  OUTPUT  = $(OUTPUT)"
 	@echo ""
 
+# installs headers for all archs at once.
 headers:
-	$(Q)mkdir -p $(OUTPUT)sysroot
-	$(Q)mkdir -p $(OUTPUT)sysroot/include
-	$(Q)cp --parents $(all_files) $(OUTPUT)sysroot/include/
-	$(Q)if [ "$(ARCH)" = "i386" -o "$(ARCH)" = "x86_64" ]; then \
-		cat arch-x86.h;                 \
-	elif [ -e "$(arch_file)" ]; then        \
-		cat $(arch_file);               \
-	else                                    \
-		echo "Fatal: architecture $(ARCH) not yet supported by nolibc." >&2; \
-		exit 1;                         \
-	fi > $(OUTPUT)sysroot/include/arch.h
+	$(Q)mkdir -p "$(OUTPUT)sysroot"
+	$(Q)mkdir -p "$(OUTPUT)sysroot/include"
+	$(Q)cp --parents $(arch_files) $(all_files) "$(OUTPUT)sysroot/include/"
 
 headers_standalone: headers
 	$(Q)$(MAKE) -C $(srctree) headers
-- 
2.17.5


