Return-Path: <linux-kernel+bounces-745902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B116B12038
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655BF17F306
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33717200132;
	Fri, 25 Jul 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="v4v8Kdm4"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1C1C6FE1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454354; cv=none; b=b7DdNwP/uYoMPtcquXR7V+mmkUyQu41JAViFD1ycmH/wJfAoPtDn206zkFrl1pVPQYEJjnsiEX8/MZxIjkQt4IEAV5rcnxz86J5XGw1ymGifCaQemzc7uNo84e4uCMl6qGp9NtnvuYTLr6YoanLIi8JlgGbKF9x5+jC1VYbAIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454354; c=relaxed/simple;
	bh=jWtKEViyRsx4wGGZi+nhAcShNNGvOY5lw4zpCDS5WhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAwIyhnM+E3eXR1CxUv0YjFxBOI8r/K25iXq4+tnKlHv/o/EAdSKDDaB1mPrJSvXsOGnSQgD3MZQqfV3lvq1zZVjQoOoctZkF+IJFKDWpiZpo7o8CQyKGDLTYjxxuIw4NAcoGyO+KSKA5KvoQ+M6Glz5+DSZC0NlrDMMxXpI54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=v4v8Kdm4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E2C643F731
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753454347;
	bh=4mUY+1XR4b/e27uHYcOnJJ9KFj0pqpjkndNzpVgnRDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=v4v8Kdm4w8ue8cMYd9velwgpVtTHeQHMxeEq1WpTxwsIxhFZ2I5jiP0CUC54OjfQv
	 4nsDtdKNhwV2N40gcRm44wBQ3MYj+Mo7BpHApFlp0CNYaEMNyd6h4IT9lrGD8WwS7k
	 wqeNgRUFzbbdwglcPozBPSXz54N5cJzvHbAxHAPs1ODnQZVhqZZyYpFf0ib/yAdkMk
	 nbicCmHPa/uzH3/GyF2QkJhmPBYuyMGK2baKlsH0EIgPM0IWlXS+9GNTUmnAq5ofFY
	 ONvwXT0OGXAcm+AlhO8ThVrcteBTWh31M29j4Qt5cBsNaZPRjYuzMSODYtqEoVAF6H
	 SlwkrRjlX+MOg==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-606b62ce2d4so2200181a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753454347; x=1754059147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mUY+1XR4b/e27uHYcOnJJ9KFj0pqpjkndNzpVgnRDU=;
        b=P+YOHXWot1+zZld5MHWg6bM1fQhZbkMolyI4jGqCSc1hbjm1p7+kiMWQjiA+I5c6aH
         V1chCvr1s09EWrR3n3BlJzxxCwr0kPU7dQr9ZUM/sOuUTOCYSxrUU/w0khDA9zuzY+Zt
         lF4/gmpX4qW5SkuvfUfMZPZ0QDkLEkSWLWlMnoc5xx+EuS9SkSsXLkbQYqBCwsYVT4CF
         2R5rLf0tXPOvBWegSfUVkSEonDhc0lC+qsuqmDuQ0ZIkT5BrPWNGPDW8OQNO6FW+wwjV
         Qeedk7AYcI+T3CZc0597cb6z5z1JbLHt27ZZ7JAvnKGcaxFB3J8Lt79slTUiAtoO0yuK
         rgog==
X-Forwarded-Encrypted: i=1; AJvYcCWErVynVtRxLGohEU+efNBh5MDm+DuQ6mtw4aNafm+f/iYDfmjWsFoaBZAL7+KR3TshtZ2aSmVwhL/XpTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUHQWuW95J3D4yB77aiWkeHD0IuGYEg9hG01GpoGFZve7K8Yl
	eoTtM3VbhM926P4oFXIrMSNwSy543hBlOAtCjFOF9/QoZuWY7IvfsVQfgO3SY/uKWPvK8ow3Z+r
	EECbLgZ2AQRARxki9SmNHh/X91udQAhBgjS5v6mhG5HCwCtuZfZLrqVMOu9MCMzmLBSnlgePTfx
	nydrttPg==
X-Gm-Gg: ASbGnctjTLMyof5a0RzzbvR0FyIn+1qi3UJ1rm9q1gwL67miM/0hIQd/G3/nKnVCSUi
	6JMemDYxFPE8lntf3fWTX4iHuNM44L+8X6JPI5PqLBxHO2PZYxYJ6LHPaGmI+LQfOvaCrhz2p5U
	dDsYoUUUNkBfuwYRSOus3I4YNAAVVJ3lYPVA8ourUWHn9ydUP/sq2zOZjnpPI/2FxyZ31WTMOQb
	C4zfSCCXW/9OJw75SH4V6ceiicfvWc/9dsjHMHow3dJP9WLzZ1LWYg9tKDPh6YlL9194jxFVXKL
	UQ/YCVPikeGdMPk1yusdMpM4xBcNhE9ao1e7gvNVIK2ktWOmM1soqlYtQ3oUVaM0sbX92cbCaK3
	j9ZInu99u8ExaL/WIEqy1k0rURDMkccKGLAQt5htLZmxnMXk=
X-Received: by 2002:a05:6402:84f:b0:612:a507:5b23 with SMTP id 4fb4d7f45d1cf-614f1bbef74mr2314224a12.11.1753454347275;
        Fri, 25 Jul 2025 07:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF14h0UnqVMVE8DmU1HkI4HkVFGaC2n5jgqzt8HvQEsuyPWhXxWakRNoUb1Vt7GxR2EJttOLg==
X-Received: by 2002:a05:6402:84f:b0:612:a507:5b23 with SMTP id 4fb4d7f45d1cf-614f1bbef74mr2314178a12.11.1753454346728;
        Fri, 25 Jul 2025 07:39:06 -0700 (PDT)
Received: from [192.168.103.102] (dynamic-046-114-110-103.46.114.pool.telefonica.de. [46.114.110.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd2fd3b1sm2185550a12.40.2025.07.25.07.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 07:39:05 -0700 (PDT)
Message-ID: <06955781-118d-4208-af28-cfbabd7d57c2@canonical.com>
Date: Fri, 25 Jul 2025 16:39:02 +0200
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
 <b50da4ef-53ca-4edf-bd74-f5e037a14f99@canonical.com>
 <aIOTauktSYmw2LUV@debug.ba.rivosinc.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <aIOTauktSYmw2LUV@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.07.25 16:23, Deepak Gupta wrote:
> On Fri, Jul 25, 2025 at 01:26:44PM +0200, Heinrich Schuchardt wrote:
>> On 25.07.25 01:37, Deepak Gupta wrote:
>>> Defines `CONFIG_RISCV_KERNEL_CFI` and selects SHADOW_CALL_STACK
>>> and ARCH_HAS_KERNEL_SHADOW_STACK both so that zicfiss can be wired up.
>>>
>>> Makefile checks if CONFIG_RISCV_KERNEL_CFI is enabled, then light
>>> up zicfiss and zicfilp compiler flags. CONFIG_RISCV_KERNEL_CFI is
>>> dependent on CONFIG_RISCV_USER_CFI. There is no reason for user to
>>> not select support for user cfi while enabling for kernel.
>>>
>>> compat vdso don't need fcf-protection (toolchain lacks support).
>>>
>>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>> ---
>>>  arch/riscv/Kconfig                     | 37 ++++++++++++++++++++++++ 
>>> +++++++++-
>>>  arch/riscv/Makefile                    |  8 ++++++++
>>>  arch/riscv/kernel/compat_vdso/Makefile |  2 +-
>>>  arch/riscv/kernel/vdso/Makefile        |  2 +-
>>>  4 files changed, 46 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 385c3d93e378..305ba5787f74 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -245,7 +245,7 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
>>>      depends on CC_HAS_MIN_FUNCTION_ALIGNMENT || !RISCV_ISA_C
>>>  config HAVE_SHADOW_CALL_STACK
>>> -    def_bool $(cc-option,-fsanitize=shadow-call-stack)
>>> +    def_bool $(cc-option,-fsanitize=shadow-call-stack) || $(cc- 
>>> option,-mabi=lp64 -march=rv64ima_zicfilp_zicfiss)
>>>      # https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/ 
>>> a484e843e6eeb51f0cb7b8819e50da6d2444d769
>>>      depends on $(ld-option,--no-relax-gp)
>>> @@ -864,6 +864,16 @@ config RISCV_ISA_ZICBOP
>>>        If you don't know what to do here, say Y.
>>> +config TOOLCHAIN_HAS_ZICFILP
>>> +    bool
>>> +    default y
>>> +    depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp)
>>> +
>>> +config TOOLCHAIN_HAS_ZICFISS
>>> +    bool
>>> +    default y
>>> +    depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
>>> +
>>>  config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>>>      def_bool y
>>>      # https://sourceware.org/git/?p=binutils- 
>>> gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
>>> @@ -1182,6 +1192,31 @@ config RISCV_USER_CFI
>>>        space does not get protection "for free".
>>>        default n.
>>> +config RISCV_KERNEL_CFI
>>> +    def_bool n
>>> +    bool "hw assisted riscv kernel control flow integrity (kcfi)"
>>> +    depends on 64BIT && $(cc-option,-mabi=lp64 - 
>>> march=rv64ima_zicfilp_zicfiss)
>>> +    depends on RISCV_USER_CFI
>>> +    select ARCH_SUPPORTS_SHADOW_CALL_STACK
>>> +    select SHADOW_CALL_STACK
>>> +    select ARCH_HAS_KERNEL_SHADOW_STACK
>>> +    help
>>> +      Provides CPU assisted control flow integrity to for riscv kernel.
>>> +      Control flow integrity is provided by implementing shadow 
>>> stack for
>>> +      backward edge and indirect branch tracking for forward edge. 
>>> Shadow
>>> +      stack protection is a hardware feature that detects function 
>>> return
>>> +      address corruption. This helps mitigate ROP attacks. 
>>> RISCV_KERNEL_CFI
>>> +      selects CONFIG_SHADOW_CALL_STACK which uses software based shadow
>>> +      stack but is unprotected against stray writes. Selecting 
>>> RISCV_KERNEL_CFI
>>> +      will select CONFIG_DYNAMIC_SCS and will enable hardware 
>>> assisted shadow
>>> +      stack protection against stray writes.
>>
>> Please, consider adding a blank line for better readability.
> 
> Noted. Will do.
> 
>>
>>> +      Indirect branch tracking enforces that all indirect branches 
>>> must land
>>> +      on a landing pad instruction else CPU will fault. This enables 
>>> forward
>>> +      control flow (call/jmp) protection in kernel and restricts all 
>>> indirect
>>> +      call or jump in kernel to a landing pad instruction which 
>>> mostly likely
>>> +      will be start of the function.
>>> +      default n
>>
>> For Linux distributions it is important that the same kernel can run 
>> both on hardware both with and without CFI support. The description 
>> provided does not help to understand if RISCV_KERNEL_CFI=y will result 
>> in such a kernel. Please, enumerate the minimum set of extensions 
>> needed for supporting a kernel built with RISCV_KERNEL_CFI=y. I guess 
>> this will at least include Zimop.
> 
> Yes, it is expected anyone selecting this config is going to take this 
> kernel to
> a RVA23 hardware. RVA23 mandates zimop and thus shouldn't be an issue on 
> such a
> hardware. Anyone selecting this config and trying to run this kernel on 
> hardware
> prior to RVA23 will run into issues. I can add a comment here to 
> highlight that.
> 
> I assume you wanted that awareness and goal is not maintain compat of same
> kernel between RVA20 and RVA23 hardware, right?

I am aware that this option is not RVA20 compatible. Could we either 
mention RVA23 or Zimop here so users will understand the implications.

Best regards

Heinrich

> 
>>
>> Best regards
>>
>> Heinrich
>>
>>> +
>>>  endmenu # "Kernel features"
>>>  menu "Boot options"
>>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>>> index 7128df832b28..6ef30a3d2bc4 100644
>>> --- a/arch/riscv/Makefile
>>> +++ b/arch/riscv/Makefile
>>> @@ -61,8 +61,10 @@ else ifeq ($(CONFIG_LTO_CLANG),y)
>>>  endif
>>>  ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
>>> +ifndef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>>>      KBUILD_LDFLAGS += --no-relax-gp
>>>  endif
>>> +endif
>>>  # ISA string setting
>>>  riscv-march-$(CONFIG_ARCH_RV32I)    := rv32ima
>>> @@ -91,6 +93,12 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := 
>>> $(riscv-march-y)_zabha
>>>  KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/ 
>>> (rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
>>>  export KBUILD_BASE_ISA
>>> +ifeq ($(CONFIG_RISCV_KERNEL_CFI),y)
>>> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICFILP) := $(riscv-march-y)_zicfilp
>>> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICFISS) := $(riscv-march-y)_zicfiss
>>> +KBUILD_CFLAGS += -fcf-protection=full
>>> +KBUILD_AFLAGS += -fcf-protection=full
>>> +endif
>>>  # Remove F,D,V from isa string for all. Keep extensions between "fd" 
>>> and "v" by
>>>  # matching non-v and non-multi-letter extensions out with the filter 
>>> ([^v_]*)
>>>  KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
>>> diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/ 
>>> kernel/compat_vdso/Makefile
>>> index 24e37d1ef7ec..552131bc34d7 100644
>>> --- a/arch/riscv/kernel/compat_vdso/Makefile
>>> +++ b/arch/riscv/kernel/compat_vdso/Makefile
>>> @@ -69,4 +69,4 @@ quiet_cmd_compat_vdsold = VDSOLD  $@
>>>  # actual build commands
>>>  quiet_cmd_compat_vdsoas = VDSOAS  $@
>>> -      cmd_compat_vdsoas = $(COMPAT_CC) $(a_flags) $(COMPAT_CC_FLAGS) 
>>> -c -o $@ $<
>>> +      cmd_compat_vdsoas = $(COMPAT_CC) $(filter-out -fcf- 
>>> protection=full, $(a_flags)) $(COMPAT_CC_FLAGS) -c -o $@ $<
>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/ 
>>> vdso/Makefile
>>> index 2b528d82fa7d..7b1446b63ebc 100644
>>> --- a/arch/riscv/kernel/vdso/Makefile
>>> +++ b/arch/riscv/kernel/vdso/Makefile
>>> @@ -17,7 +17,7 @@ ifdef CONFIG_VDSO_GETRANDOM
>>>  vdso-syms += getrandom
>>>  endif
>>> -ifdef CONFIG_RISCV_USER_CFI
>>> +ifneq ($(CONFIG_RISCV_USER_CFI), $(CONFIG_RISCV_KERNEL_CFI))
>>>  CFI_MARCH = _zicfilp_zicfiss
>>>  CFI_FULL = -fcf-protection=full
>>>  endif
>>>
>>


