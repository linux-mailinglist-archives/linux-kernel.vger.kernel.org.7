Return-Path: <linux-kernel+bounces-627508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59BDAA51AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3A11C20ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1C265614;
	Wed, 30 Apr 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2q97p0V8"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744C265608
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030453; cv=none; b=gu6arDbiiTour62xjrUPrdvqCAEqalaMqgrosnTL81eKmcLTWu6aUDI9aXrsCpFA0+486Vh6LnuR0G4WpMrEJvXp8J9jSVpKdEeWnjVmJcg4C8/g+hndhzoUktOKxJrCwuhCGPpiOJ//+2/ITWGTEuqHebZDNSBvzS2jbto6y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030453; c=relaxed/simple;
	bh=esaH8w+qP4dacyJDOuK09lepOX2rSwpGvRjGWl+rkdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MUlMbcf/Led1c91b67N9m5Bdiq5g+MPhN+suotT7SqN4JMiTKZogXPeVDZTBZfiraEszyUoWkAfLuZOFmsajh1weYXYwUZVgypENnNmck9pNwnsWPtP4JbmBgZnhd6+QZRFopm56B0LPgOCU37dkdltDF0RclDHsUOpJ0w6wwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2q97p0V8; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39ee57e254aso3639725f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746030450; x=1746635250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1qsu6fkrd6uduOladyyR4ZyoWD5vL8Q+jaWgw+feE0=;
        b=2q97p0V8NXi5TVvuRocs18seyHRiYY0T9mHHv47fYn9+q2UaJA07VtNMzMUM9QAELf
         J55t21zlhFC5a7EcW3Qr6rE4KatyejWc0qYT8FNiFrHNBizBk8ilt8DAA/qPcq0/lfEI
         uEfj5VEjSE5Pq9imI09l9RsBEmyeN3ZtLKz2o8NY3+yBWMked5JFKAfq/w2k34yx9XEm
         QKqorXubk8ua48lulQkNv3fOq/P0Eb84wPWGtosHunEEBiAJI3DBDs4AIpuS+ZPwKlXc
         PPyIfHqK7HaHmLngtCnLtiuBn7heLjPoJcn/M/WSCA4RtiUC1nB80nLquGzCh0D4HMgL
         SyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746030450; x=1746635250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1qsu6fkrd6uduOladyyR4ZyoWD5vL8Q+jaWgw+feE0=;
        b=ehN+y0+TQat7LGlUBAMIs6szAgFR/+npFKCCDVTtBGLnjTMfilt07pSpdxc5TMpavJ
         iWa8iZLWemZt6fSLKSr0kF3bzkRVIU5zpoiQwZiKpNkND62GMArivEhIw3vG6qUulcVD
         0NkK3K/z28dNZXVIfmzBMKWlCFtlyxYPSVoyr551eP7iARqO3bLeqZKo0apvgsmStadJ
         Z5UmueiRUy4Mo7O6rPbO+ZtziTbXwaIZe/kT9WFpjFVcYvbYRE5JKYH0QCno4j7ktUka
         Mwn/CZkmT7QJ9hrvCQiwpk7Sq9CPTRdStPZeQc7vaYuubI2UAm8NWXu+/THhlFdrRRf8
         u+4A==
X-Forwarded-Encrypted: i=1; AJvYcCWWpuqy7PzJXJZyDqzXKoOTO1FRveQtobqQ+MMQdYeocXCpamN8fUs5w4mAe8fNUQFtmjimAoHG0k/0KQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSajeodZlOhy8UkZSbsmzNkUo1ZQPbKSCAGD3gv6ybAAj37m7
	hPKoK6O5/SwRz15lGIdAZPpO4McYhBMBMRv+tZvlSk4cG+YITm3uyKYqJ0rJUqSrkTLShLXm5OM
	x7q+CeeF6sA==
X-Google-Smtp-Source: AGHT+IG4BlUgz6HW2Kxnd0khlJFiLyO62h9ryy5TwZM3R2e0jq/UJyUCK2ECwVgEFsDnoXM94u24uHZ/XOF4Lw==
X-Received: from wrbbh10.prod.google.com ([2002:a05:6000:5ca:b0:391:434a:b7c9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:fbc4:0:b0:3a0:7fd4:2848 with SMTP id ffacd0b85a97d-3a08f7a4abamr2805108f8f.52.1746030450479;
 Wed, 30 Apr 2025 09:27:30 -0700 (PDT)
Date: Wed, 30 Apr 2025 16:27:10 +0000
In-Reply-To: <20250430162713.1997569-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430162713.1997569-1-smostafa@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250430162713.1997569-4-smostafa@google.com>
Subject: [PATCH v2 3/4] KVM: arm64: Introduce CONFIG_UBSAN_KVM_EL2
From: Mostafa Saleh <smostafa@google.com>
To: kvmarm@lists.linux.dev, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	broonie@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kees@kernel.org, elver@google.com, andreyknvl@gmail.com, 
	ryabinin.a.a@gmail.com, akpm@linux-foundation.org, yuzenghui@huawei.com, 
	suzuki.poulose@arm.com, joey.gouly@arm.com, masahiroy@kernel.org, 
	nathan@kernel.org, nicolas.schier@linux.dev, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new Kconfig CONFIG_UBSAN_KVM_EL2 for KVM which enables
UBSAN for EL2 code (in protected/nvhe/hvhe) modes.
This will re-use the same checks enabled for the kernel for
the hypervisor. The only difference is that for EL2 it always
emits a "brk" instead of implementing hooks as the hypervisor
can't print reports.

The KVM code will re-use the same code for the kernel
"report_ubsan_failure()" so #ifdefs are changed to also have this
code for CONFIG_UBSAN_KVM_EL2

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 6 ++++++
 include/linux/ubsan.h            | 2 +-
 lib/Kconfig.ubsan                | 9 +++++++++
 lib/ubsan.c                      | 6 ++++--
 scripts/Makefile.ubsan           | 5 ++++-
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index b43426a493df..a76522d63c3e 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -99,3 +99,9 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAG
 # causes a build failure. Remove profile optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%, $(KBUILD_CFLAGS))
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
+
+ifeq ($(CONFIG_UBSAN_KVM_EL2),y)
+UBSAN_SANITIZE := y
+# Always use brk and not hooks
+ccflags-y += $(CFLAGS_UBSAN_TRAP)
+endif
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
index c843816f5f68..3ab8d38aedb8 100644
--- a/include/linux/ubsan.h
+++ b/include/linux/ubsan.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_UBSAN_H
 #define _LINUX_UBSAN_H
 
-#ifdef CONFIG_UBSAN_TRAP
+#if defined(CONFIG_UBSAN_TRAP) || defined(CONFIG_UBSAN_KVM_EL2)
 const char *report_ubsan_failure(u32 check_type);
 #else
 static inline const char *report_ubsan_failure(u32 check_type)
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index f6ea0c5b5da3..42ed41804644 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -165,4 +165,13 @@ config TEST_UBSAN
 	  This is a test module for UBSAN.
 	  It triggers various undefined behavior, and detect it.
 
+config UBSAN_KVM_EL2
+	bool "UBSAN for KVM code at EL2"
+	depends on ARM64
+	help
+	  Enable UBSAN when running on ARM64 with KVM in a split mode
+	  (nvhe/hvhe/protected) for the hypervisor code running in EL2.
+	  In this mode, any UBSAN violation in EL2 would panic the kernel
+	  and information similar to UBSAN_TRAP would be printed.
+
 endif	# if UBSAN
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 17993727fc96..a6ca235dd714 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -19,7 +19,7 @@
 
 #include "ubsan.h"
 
-#ifdef CONFIG_UBSAN_TRAP
+#if defined(CONFIG_UBSAN_TRAP) || defined(CONFIG_UBSAN_KVM_EL2)
 /*
  * Only include matches for UBSAN checks that are actually compiled in.
  * The mappings of struct SanitizerKind (the -fsanitize=xxx args) to
@@ -97,7 +97,9 @@ const char *report_ubsan_failure(u32 check_type)
 	}
 }
 
-#else
+#endif
+
+#ifndef CONFIG_UBSAN_TRAP
 static const char * const type_check_kinds[] = {
 	"load of",
 	"store to",
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 9e35198edbf0..73c7a9be0796 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Shared with KVM/arm64.
+export CFLAGS_UBSAN_TRAP := $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
+
 # Enable available and selected UBSAN features.
 ubsan-cflags-$(CONFIG_UBSAN_ALIGNMENT)		+= -fsanitize=alignment
 ubsan-cflags-$(CONFIG_UBSAN_BOUNDS_STRICT)	+= -fsanitize=bounds-strict
@@ -10,7 +13,7 @@ ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
 ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
 ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
 ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
-ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
+ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(CFLAGS_UBSAN_TRAP)
 
 export CFLAGS_UBSAN := $(ubsan-cflags-y)
 
-- 
2.49.0.967.g6a0df3ecc3-goog


