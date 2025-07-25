Return-Path: <linux-kernel+bounces-745716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B475BB11D77
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A474A1CE34B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0632E610E;
	Fri, 25 Jul 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nAk8evin"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025652114
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442814; cv=none; b=dg9jrY9KKux77Q5AuRLJerqZWNY02rMiihVH6y8nFR318wEv8dalsu0ZF9O1kYK++2pdO8NGytKZZF3jiKf+OvvH7EA/N6aMxKn7o2xFCwZpHVclfP49fSsJfN0kG0oJjm41erOk1VWgs9JPRe/8Fq3ObzFMXwBlF7FoBrniQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442814; c=relaxed/simple;
	bh=0ZJExULLVmMGi4y+Mqs82rijJnvXJ2O+mBZMRl15Ovs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwRYFpNbGb5im/EX40fg5HPRHDH1gw3HHqVz7wcOzpLXwd4REOPAIkQja/MeMufSp0jMdTZs6GwXxfukf+5Q+9G8apWA+c/9XUvwe4adfXbaBEw15q/5O7QxRUs1aNtuucbjOh6uXrFmXPR9o+aTwXdrEEZ3yyt6Gbjc53z3szE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nAk8evin; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D35143F73C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753442809;
	bh=/9lBchv8Xl3/zU+kUSWuOOJSWBoJGBapA/sirJQnK+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=nAk8evinAH0Sdcbx8SXv7tQry6qarcisyKFC4WD9n0NEImZwXRI8HGHy2cYk/l8Bm
	 VlVwY5c/J8KdTuh9zNzOvnZ4nSbAQ3kKnruz92HBdubV6abq7SVcBmFghQxlyZ2R99
	 KBDdiGbSgGwDccF8wdAJkWpReSVTGwKcTigexs+1gDymZg0AgqbEIgz1uyvpxYjsQk
	 8JccYpideRhFu4mzDV0RDjmAwkbdYwgDd/9Q2iR7JuXbTKqr/dd1wLBTbcJdgb+/t2
	 fZFchEvtAdATxv+nb6Z6Ay7nACZVSaKz+rUujG6orQH3WqwoL02wHhVD6PQu5gRtaN
	 HAHH/5TDr/7fw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae3c5ca46f2so159138766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753442809; x=1754047609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9lBchv8Xl3/zU+kUSWuOOJSWBoJGBapA/sirJQnK+E=;
        b=Zp+TgHC6qG8PwAFQrP/GrFTAfwZB8TDAWMdCLonb9iNhP+caNaen2Kqq4Uy3SucPLT
         bLf/jDzKpmfjKYVwb+Yv6KEPwTnhTrcWCIAnXQRKBMfOR/wy6oMsXB94abgkHkzSNH78
         tLX+XHxYfj58nrzxaN2deKSn+pHcgaKqxYKbdg28WOCVPjrnzsxbiH3xTXtkAt3DPky8
         SyKYJ2os03sSJ5cFi+ZeeFG9IXbz07Ewejky203Sfxl4q67Zvz2ZIGNR1+LiVGQ6DOmp
         QIJ90usUpa9jVCjwNDIBY9/jURf5ePH+4mzPXmx3yLsbtTb3d+vtNM8M0gp5EfwvKS2z
         jmzw==
X-Forwarded-Encrypted: i=1; AJvYcCVTBhEMzEvczHZtiPdy46VazOV3kXIsjiyxnbxGfndlzBIAZ1ujrlZbifnWnUaCgJUj/Yk1d5s9Ob6mYYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IqyqPkfoCdL5Q94p38geAz49DYGGY9AFMvDzZMIXqtL1uomz
	SCOzstvuS3K7VbyM8CfCO6XbCyK4t4s2t2ro0uOR26FX6Y/Mz0uVG5L4/Bz7Duz4FP7kOmy2k+B
	J5i5Hx4mitkEsByyk/SvyQ3UAkTcOKs4P2IE5g3NjlQDqnR75vkGTo4TJ/yJoLYi4cKgzgqvJ1d
	OlO3fnig==
X-Gm-Gg: ASbGnctU+r16sNbnM2fI6i4NflhJS8yb5CHDOPfpLlmmQv9ngabeE+l+RTI13wl/k1p
	kOOHkvs6yJBwXvuDukoHRBHt5qP7kHAQZJUTX3L0E3ZLg78ng3y80tC0OQauYYlN+YugwaZyl7L
	KOsT1TcfdEq+1kpRpHWQON0uA7z4YMG8TiSMKqeV7YmMaLZGNo/OhUh6NOgWPw5Y7TDR/JisYfM
	/hd7RzHjeMI+w1EdOtHguOXvO9T/B/r9zk1F9LEAjLYi2JPPPI82WjQ8p5wqyP2J/M1aF47ZUtF
	tVE5t0OUA7Eo33KvZ85WIDdSFU4CfkdIR21wCVqvV9Z2bAH+1ipJWTgjF9gbpxfMb88s+3f8cWp
	fRDHDP7lFuC5vQ+j5sldvTy2koOGZyAIL6I1H
X-Received: by 2002:a17:907:868b:b0:ae0:dd95:1991 with SMTP id a640c23a62f3a-af619efda7fmr218778166b.51.1753442808324;
        Fri, 25 Jul 2025 04:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF62wP3IqAMJ1/E1mQqpiMFCO0fY8T1aVjgbgNEGN4i3p5BpL7PdyFIzDt2eRf4SEXlVdUVvQ==
X-Received: by 2002:a17:907:868b:b0:ae0:dd95:1991 with SMTP id a640c23a62f3a-af619efda7fmr218773366b.51.1753442807745;
        Fri, 25 Jul 2025 04:26:47 -0700 (PDT)
Received: from [192.168.103.102] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd31ac41sm1898416a12.54.2025.07.25.04.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:26:47 -0700 (PDT)
Message-ID: <b50da4ef-53ca-4edf-bd74-f5e037a14f99@canonical.com>
Date: Fri, 25 Jul 2025 13:26:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] riscv: Kconfig & Makefile for riscv kernel control
 flow integrity
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com,
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com,
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com,
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com,
 andrew@sifive.com, ved@rivosinc.com, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>,
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-11-04b8fa44c98c@rivosinc.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250724-riscv_kcfi-v1-11-04b8fa44c98c@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 01:37, Deepak Gupta wrote:
> Defines `CONFIG_RISCV_KERNEL_CFI` and selects SHADOW_CALL_STACK
> and ARCH_HAS_KERNEL_SHADOW_STACK both so that zicfiss can be wired up.
> 
> Makefile checks if CONFIG_RISCV_KERNEL_CFI is enabled, then light
> up zicfiss and zicfilp compiler flags. CONFIG_RISCV_KERNEL_CFI is
> dependent on CONFIG_RISCV_USER_CFI. There is no reason for user to
> not select support for user cfi while enabling for kernel.
> 
> compat vdso don't need fcf-protection (toolchain lacks support).
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/Kconfig                     | 37 +++++++++++++++++++++++++++++++++-
>   arch/riscv/Makefile                    |  8 ++++++++
>   arch/riscv/kernel/compat_vdso/Makefile |  2 +-
>   arch/riscv/kernel/vdso/Makefile        |  2 +-
>   4 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 385c3d93e378..305ba5787f74 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -245,7 +245,7 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
>   	depends on CC_HAS_MIN_FUNCTION_ALIGNMENT || !RISCV_ISA_C
>   
>   config HAVE_SHADOW_CALL_STACK
> -	def_bool $(cc-option,-fsanitize=shadow-call-stack)
> +	def_bool $(cc-option,-fsanitize=shadow-call-stack) || $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp_zicfiss)
>   	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
>   	depends on $(ld-option,--no-relax-gp)
>   
> @@ -864,6 +864,16 @@ config RISCV_ISA_ZICBOP
>   
>   	  If you don't know what to do here, say Y.
>   
> +config TOOLCHAIN_HAS_ZICFILP
> +	bool
> +	default y
> +	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp)
> +
> +config TOOLCHAIN_HAS_ZICFISS
> +	bool
> +	default y
> +	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
> +
>   config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>   	def_bool y
>   	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
> @@ -1182,6 +1192,31 @@ config RISCV_USER_CFI
>   	  space does not get protection "for free".
>   	  default n.
>   
> +config RISCV_KERNEL_CFI
> +	def_bool n
> +	bool "hw assisted riscv kernel control flow integrity (kcfi)"
> +	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp_zicfiss)
> +	depends on RISCV_USER_CFI
> +	select ARCH_SUPPORTS_SHADOW_CALL_STACK
> +	select SHADOW_CALL_STACK
> +	select ARCH_HAS_KERNEL_SHADOW_STACK
> +	help
> +	  Provides CPU assisted control flow integrity to for riscv kernel.
> +	  Control flow integrity is provided by implementing shadow stack for
> +	  backward edge and indirect branch tracking for forward edge. Shadow
> +	  stack protection is a hardware feature that detects function return
> +	  address corruption. This helps mitigate ROP attacks. RISCV_KERNEL_CFI
> +	  selects CONFIG_SHADOW_CALL_STACK which uses software based shadow
> +	  stack but is unprotected against stray writes. Selecting RISCV_KERNEL_CFI
> +	  will select CONFIG_DYNAMIC_SCS and will enable hardware assisted shadow
> +	  stack protection against stray writes.

Please, consider adding a blank line for better readability.

> +	  Indirect branch tracking enforces that all indirect branches must land
> +	  on a landing pad instruction else CPU will fault. This enables forward
> +	  control flow (call/jmp) protection in kernel and restricts all indirect
> +	  call or jump in kernel to a landing pad instruction which mostly likely
> +	  will be start of the function.
> +	  default n

For Linux distributions it is important that the same kernel can run 
both on hardware both with and without CFI support. The description 
provided does not help to understand if RISCV_KERNEL_CFI=y will result 
in such a kernel. Please, enumerate the minimum set of extensions needed 
for supporting a kernel built with RISCV_KERNEL_CFI=y. I guess this will 
at least include Zimop.

Best regards

Heinrich

> +
>   endmenu # "Kernel features"
>   
>   menu "Boot options"
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 7128df832b28..6ef30a3d2bc4 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -61,8 +61,10 @@ else ifeq ($(CONFIG_LTO_CLANG),y)
>   endif
>   
>   ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
> +ifndef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>   	KBUILD_LDFLAGS += --no-relax-gp
>   endif
> +endif
>   
>   # ISA string setting
>   riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
> @@ -91,6 +93,12 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
>   KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
>   export KBUILD_BASE_ISA
>   
> +ifeq ($(CONFIG_RISCV_KERNEL_CFI),y)
> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICFILP) := $(riscv-march-y)_zicfilp
> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICFISS) := $(riscv-march-y)_zicfiss
> +KBUILD_CFLAGS += -fcf-protection=full
> +KBUILD_AFLAGS += -fcf-protection=full
> +endif
>   # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
>   # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
>   KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
> diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
> index 24e37d1ef7ec..552131bc34d7 100644
> --- a/arch/riscv/kernel/compat_vdso/Makefile
> +++ b/arch/riscv/kernel/compat_vdso/Makefile
> @@ -69,4 +69,4 @@ quiet_cmd_compat_vdsold = VDSOLD  $@
>   
>   # actual build commands
>   quiet_cmd_compat_vdsoas = VDSOAS  $@
> -      cmd_compat_vdsoas = $(COMPAT_CC) $(a_flags) $(COMPAT_CC_FLAGS) -c -o $@ $<
> +      cmd_compat_vdsoas = $(COMPAT_CC) $(filter-out -fcf-protection=full, $(a_flags)) $(COMPAT_CC_FLAGS) -c -o $@ $<
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 2b528d82fa7d..7b1446b63ebc 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -17,7 +17,7 @@ ifdef CONFIG_VDSO_GETRANDOM
>   vdso-syms += getrandom
>   endif
>   
> -ifdef CONFIG_RISCV_USER_CFI
> +ifneq ($(CONFIG_RISCV_USER_CFI), $(CONFIG_RISCV_KERNEL_CFI))
>   CFI_MARCH = _zicfilp_zicfiss
>   CFI_FULL = -fcf-protection=full
>   endif
> 


