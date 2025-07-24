Return-Path: <linux-kernel+bounces-745094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD319B114C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF6CAE1C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22F24E4D4;
	Thu, 24 Jul 2025 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SWvXhcnw"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C29024DCF0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400254; cv=none; b=pKPgMLpjpgch37QfPzbaMUdCTsQKouc22rUfy0MPmWNCNwsWZg4iuqwQcgZGbbFdZpVZCy8IdjGYJEee5R+Hz+Z3owQ8n9TyDpF8r9b2Ed6/nUpajadJns36JIbyZHFND+C7R+fyNaXtB//0jk/9/freFhSqHcqVT0Lek4NZt2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400254; c=relaxed/simple;
	bh=vupMCP2fr0Cb/pZmxuFw4zZQjJXpTFO3J1Grnpowo0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFHf7dKHYsIGo6wxDNzuI/Clh9SYQgFb3bYRDQSQKUvIYfVIT+n6royPJMAZB/vc4lzsGIDsX+TZb88Byok/uVt8ItOK0I0xZPTBwnFGKRh5RDfReCMKcYhV228bapyCsQfFIAb8lxFI61V5C7xboLDMJ+aWOBB66XUEeozLlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SWvXhcnw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31d489a76dso1696476a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753400251; x=1754005051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peHOF2kFTCg4ZjEHfH+NsYT+T4LY9ghqoCHBPY5quO0=;
        b=SWvXhcnwCObvj3bc0Yo7h+Q1IIpa0m/JSjtcUspgIn4m2FBu96Lry1w4SUMU41z6iY
         SyaT2d7rOgv3uMWJvxTyqGUxSHcS0xF1GQGNRMagJ3Bn26QRImKFia6uS/5Qin1bXrd6
         8YQNl4vLIqAV0rOERoBdLlTA17AaTzziWNido/VWMGe1gTdkFOeYqRFQovZDwiX3OsSi
         pDPwHTGrGqpGCX806rSV0thZAEeCDljQR12pRL8NEO3PSw1hjmnp0z2ZKCzEWbJOe0WS
         fLrcsLt73nHeVr1HzMlDFWm4/P/jPYJFLTE5xRMfitr42ef9PdUSKp5H3zB3kCigZ1eg
         Br+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753400251; x=1754005051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peHOF2kFTCg4ZjEHfH+NsYT+T4LY9ghqoCHBPY5quO0=;
        b=ufKs7E1ELuv3ZiaE9QUBObFGNZ5G/GIUwTCfyfS8CybBMmwXV7VkOkrUGRb+k7SuZr
         zhbsS+Qen/G+Au7Ts4sR5ddMJrQCKFY0faK+X/Y6MHqwrm8+kv6Fdeq4Huor/0zS8riR
         koBdzTfUU1Fgr1xUjsFOM6Mcis/ZE4frsCE8aZv+voN1UMP2hwKFhTdxonhMXdS3HaeH
         ahTVDleH7j0aMumY1Yq8IXyGHuKg0sECcy7+k7iuzKQKpQ62zAMwHXIEC2QsnqE34Faa
         ZCf+u9gZgmEqc1W5gpLLJZtc2/niDw72U3SmDb7Blr3luoEOGGytfIcQGfYKw9NBtvDj
         IH5g==
X-Forwarded-Encrypted: i=1; AJvYcCU65u68vKAZKxQ0GoqRjXkwT6WAke7IKQjUzFJRyXob4dXqfIRcV841AYCXAascXN2DjLqqJZ5U88HNQWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZfV9lsZUnKUAL+Ju7DGzUOSZIblrIqJ66XEJwqI7lTh/quhc
	LBznnugBrja1ix0GKKu0sg5H0/YOap5F7kxGtQhXGz0auYHmEFo16ifvghA4/xg2orw=
X-Gm-Gg: ASbGnct14fvSNfBoiskYm6KWShYHnFQbIwyzRyyKuQo+jb27XdiqrXSC2ftP/S/cZ/k
	3xMQPdSDQIZGkPGbTHHP99rU/+m2NsJyVC4PZB2ndWPmKBVnEKWgD2CJOfLIWW1UApKqw6Bqwo+
	Z2XqOrKO7v6eWGRfaMOn+LqU0aMvlpS+PAs1YVCocSaXRUhr6gOugiy3nswAnUEU//kPkJ4kx12
	KBjjKYIcJYUhwbaJn9uisi4AHmP2HPPs+kwgSaFuqmy+hrKIticQpJ+P7mrgopSgo6KusWzSvMk
	aA4hIHGRp4iiX83yQnO9WUHg3AS1ohfheWAlYPYwB3bjxU97eHyrxUUdy1tW4wSUcIsWqJKsrd0
	QV2pzm+tHwlSBha7A+U3c2u5btfgSt0tihRsWsshCnIc=
X-Google-Smtp-Source: AGHT+IHWiexaVwmMrfCesAYQvzzDEjUSkMZA8bOmNgM6tMD5UpaI8v8Bzd/POThkVi6Pt2HxfwQt4Q==
X-Received: by 2002:a17:902:cece:b0:234:d431:ec6e with SMTP id d9443c01a7336-23f9813a90emr143907835ad.3.1753400250715;
        Thu, 24 Jul 2025 16:37:30 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc706sm23598685ad.106.2025.07.24.16.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:37:30 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Jul 2025 16:37:04 -0700
Subject: [PATCH 11/11] riscv: Kconfig & Makefile for riscv kernel control
 flow integrity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-riscv_kcfi-v1-11-04b8fa44c98c@rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
In-Reply-To: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>, 
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com, 
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com, 
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com, 
 heinrich.schuchardt@canonical.com, andrew@sifive.com, ved@rivosinc.com, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Defines `CONFIG_RISCV_KERNEL_CFI` and selects SHADOW_CALL_STACK
and ARCH_HAS_KERNEL_SHADOW_STACK both so that zicfiss can be wired up.

Makefile checks if CONFIG_RISCV_KERNEL_CFI is enabled, then light
up zicfiss and zicfilp compiler flags. CONFIG_RISCV_KERNEL_CFI is
dependent on CONFIG_RISCV_USER_CFI. There is no reason for user to
not select support for user cfi while enabling for kernel.

compat vdso don't need fcf-protection (toolchain lacks support).

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig                     | 37 +++++++++++++++++++++++++++++++++-
 arch/riscv/Makefile                    |  8 ++++++++
 arch/riscv/kernel/compat_vdso/Makefile |  2 +-
 arch/riscv/kernel/vdso/Makefile        |  2 +-
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 385c3d93e378..305ba5787f74 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -245,7 +245,7 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
 	depends on CC_HAS_MIN_FUNCTION_ALIGNMENT || !RISCV_ISA_C
 
 config HAVE_SHADOW_CALL_STACK
-	def_bool $(cc-option,-fsanitize=shadow-call-stack)
+	def_bool $(cc-option,-fsanitize=shadow-call-stack) || $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp_zicfiss)
 	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
 	depends on $(ld-option,--no-relax-gp)
 
@@ -864,6 +864,16 @@ config RISCV_ISA_ZICBOP
 
 	  If you don't know what to do here, say Y.
 
+config TOOLCHAIN_HAS_ZICFILP
+	bool
+	default y
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp)
+
+config TOOLCHAIN_HAS_ZICFISS
+	bool
+	default y
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+
 config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	def_bool y
 	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
@@ -1182,6 +1192,31 @@ config RISCV_USER_CFI
 	  space does not get protection "for free".
 	  default n.
 
+config RISCV_KERNEL_CFI
+	def_bool n
+	bool "hw assisted riscv kernel control flow integrity (kcfi)"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp_zicfiss)
+	depends on RISCV_USER_CFI
+	select ARCH_SUPPORTS_SHADOW_CALL_STACK
+	select SHADOW_CALL_STACK
+	select ARCH_HAS_KERNEL_SHADOW_STACK
+	help
+	  Provides CPU assisted control flow integrity to for riscv kernel.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge. Shadow
+	  stack protection is a hardware feature that detects function return
+	  address corruption. This helps mitigate ROP attacks. RISCV_KERNEL_CFI
+	  selects CONFIG_SHADOW_CALL_STACK which uses software based shadow
+	  stack but is unprotected against stray writes. Selecting RISCV_KERNEL_CFI
+	  will select CONFIG_DYNAMIC_SCS and will enable hardware assisted shadow
+	  stack protection against stray writes.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This enables forward
+	  control flow (call/jmp) protection in kernel and restricts all indirect
+	  call or jump in kernel to a landing pad instruction which mostly likely
+	  will be start of the function.
+	  default n
+
 endmenu # "Kernel features"
 
 menu "Boot options"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7128df832b28..6ef30a3d2bc4 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -61,8 +61,10 @@ else ifeq ($(CONFIG_LTO_CLANG),y)
 endif
 
 ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
+ifndef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
 	KBUILD_LDFLAGS += --no-relax-gp
 endif
+endif
 
 # ISA string setting
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
@@ -91,6 +93,12 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
 KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
 export KBUILD_BASE_ISA
 
+ifeq ($(CONFIG_RISCV_KERNEL_CFI),y)
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICFILP) := $(riscv-march-y)_zicfilp
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICFISS) := $(riscv-march-y)_zicfiss
+KBUILD_CFLAGS += -fcf-protection=full
+KBUILD_AFLAGS += -fcf-protection=full
+endif
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
index 24e37d1ef7ec..552131bc34d7 100644
--- a/arch/riscv/kernel/compat_vdso/Makefile
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -69,4 +69,4 @@ quiet_cmd_compat_vdsold = VDSOLD  $@
 
 # actual build commands
 quiet_cmd_compat_vdsoas = VDSOAS  $@
-      cmd_compat_vdsoas = $(COMPAT_CC) $(a_flags) $(COMPAT_CC_FLAGS) -c -o $@ $<
+      cmd_compat_vdsoas = $(COMPAT_CC) $(filter-out -fcf-protection=full, $(a_flags)) $(COMPAT_CC_FLAGS) -c -o $@ $<
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 2b528d82fa7d..7b1446b63ebc 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -17,7 +17,7 @@ ifdef CONFIG_VDSO_GETRANDOM
 vdso-syms += getrandom
 endif
 
-ifdef CONFIG_RISCV_USER_CFI
+ifneq ($(CONFIG_RISCV_USER_CFI), $(CONFIG_RISCV_KERNEL_CFI))
 CFI_MARCH = _zicfilp_zicfiss
 CFI_FULL = -fcf-protection=full
 endif

-- 
2.43.0


