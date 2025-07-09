Return-Path: <linux-kernel+bounces-723051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C5AFE22A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F28545992
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049C27F749;
	Wed,  9 Jul 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bN6nKz8q"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7327E075
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048703; cv=none; b=DqBlnzTvGoS2sqq0+zP7TDTEddLgRgjL4+EXLkkvYNVZtSYG/fFQYEPiEYQVDdW9d1afKA3coXOT/n6zXI5p+p49f59BBFcAj7XgVTYgFQOGTAt+xMct+Uyf4wyRpT0pH8Xt/5ALeAP/Rw15RNKJWPi64PY/J+PhTxbJk1+uEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048703; c=relaxed/simple;
	bh=L0nuKM1iOS5J1LrRXwl6oFJ2k3UoNAHOTrQqnHSBepc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+jxb6Mox+EPsRgBV0TOs9qjESuEhtr9byctlKGcClK7gZSbMm8K2R2kmlcIkqo6RH1wnezsgwEfiKnyY0lP8ZrMzuscNomqET1lpJJN0VDv0Ma92qHSsXJpSGA2yPoVc4aX/4zOrr5PteTXSwmE7gV+Kh8mLLPnQpDiC1NpxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bN6nKz8q; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-454d910ea8dso83565e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048700; x=1752653500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=bN6nKz8qQeWLT8ZgRQ9DTyT1cDWLWiUmGJxyJsUEPk+zGAFLd4usEfNd2Oj+XfAJhj
         Uki7MMQ7o1Xt85tEUTp60/lz9GeYcAuOjRI8F8FVGZEowNpFKLpf0Jls+DnkhZ+7hsvT
         ZPHhn5M/AzHPmYd2OoAqJp7HZSEk5sqgqS6XndtWwJfM+T8im6XaqWvN1BIEN0ThnYzi
         OLld4lxfDIhb2/IUxp8ELW4Kp9MlJtaTaryVgDSQl6AzMjYWMOzl1Ndtz39wvZ0NNtvY
         Aiqadd9jz9IzLG+dirP6PLPLAJkYHm3i7mqytTGE0YNCf3AlFROxaZE9IlHV/pOtnd4Q
         bj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048700; x=1752653500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=vetkN3Y93KHCsZGesRneeFu8yFuq56fFTAokt/g/7NP6zeAJuGki/+2Hy2D+UR7p2r
         THRS20JengxS4bsjqLLD42FyF7qQjvMkltumGQMuAIaQE04Kje3ZJBQk/QJgoW+LzYxN
         0/AwD7YGCX9Knnd+YAuxerTOYoTgkul0VARE7zag6qFY3LOGtyCT5DqF70bH6ZSOUwjU
         0QtkfMrVIfg2kpIpc/5tHo0o9D3Waku+tuFuBucCIBDjQ5uR9nn946l/vnT8eoC4LKKt
         JM+i2CswsGyL5l7JYxPBo1ekWCFKBb8bQ46d1ET9TgFhcZOL2Ag5HTFaOEBUHeI2Pn8s
         p3Jg==
X-Gm-Message-State: AOJu0YyEhSaCHJt/Mninvz72Z0y8J4/Jr3C5GbeypazyNXzfxeVSLZoi
	fe+0WbU12a0qsdN5SgF3dxnwBxVrHw56bZBandbIw4pvqZtxaoNIZXt+e+c5ggN2Hh4vthyPFf8
	O+rU7597e5T7vTZbn7rCX10B+dExSZPJk3ReXuEdBwEp+uIEywwfWUUiCS02bWkqMNv01Ln0lDF
	+zXkVFCEvoNSLGkS2Dp4THiJukBOTT43IMAA==
X-Google-Smtp-Source: AGHT+IEPZp1VCmwNurBlUBLL5R2bEvNSuc5tGGEyVsOauyKXnhxJ0yeJAX3G1Kl1wdJ6ycwIpaQHUeFq
X-Received: from wmbfa23.prod.google.com ([2002:a05:600c:5197:b0:453:8b14:6e00])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a407:b0:453:dbe:7574
 with SMTP id 5b1f17b1804b1-454d5c8d44dmr8602395e9.12.1752048699898; Wed, 09
 Jul 2025 01:11:39 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:59 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=ardb@kernel.org;
 h=from:subject; bh=L4jffg2+Vf1ZB+P16ZYKMMQDycf2VYvq95i2j0U/b58=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+VmFo4ujna9JaX+z4FKNR2WPIq71tO+/tuedpeOpj
 6pP9vztKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZWMvI8Fo45c/lmIBarub+
 3F2Z2ed8svOP+nRdTAxPS1yYHLNwEcMfrpA4bZ7zX6beaX0UcbRXw+4NQyvL7Lyj2wMuvJ9lvym OGQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-44-ardb+git@google.com>
Subject: [PATCH v4 18/24] x86/boot: Check startup code for absence of absolute relocations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Invoke objtool on each startup code object individually to check for the
absence of absolute relocations. This is needed because this code will
be invoked from the 1:1 mapping of memory before those absolute virtual
addresses (which are derived from the kernel virtual base address
provided to the linker and possibly shifted at boot) are mapped.

Only objects built under arch/x86/boot/startup/ have this restriction,
and once they have been incorporated into vmlinux.o, this distinction is
difficult to make. So force the invocation of objtool for each object
file individually, even if objtool is deferred to vmlinux.o for the rest
of the build. In the latter case, only pass --noabs and nothing else;
otherwise, append it to the existing objtool command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index b514f7e81332..32737f4ab5a8 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -19,6 +19,7 @@ KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
+pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
@@ -28,3 +29,10 @@ lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
 # to be linked into the decompressor or the EFI stub but not vmlinux
 #
 $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
+
+#
+# Invoke objtool for each object individually to check for absolute
+# relocations, even if other objtool actions are being deferred.
+#
+$(pi-objs): objtool-enabled	= 1
+$(pi-objs): objtool-args	= $(if $(delay-objtool),,$(objtool-args-y)) --noabs
-- 
2.50.0.727.gbf7dc18ff4-goog


