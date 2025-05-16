Return-Path: <linux-kernel+bounces-651525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65822AB9FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 17:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FAA3BEF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B81B4121;
	Fri, 16 May 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GQfsSeGy"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F0198E81
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408577; cv=none; b=mTn1ja0Ri7ZLP8Wfl4KMRmIg6rPb2x7O2kYZy7c2jshXtcSZHOVSLfhQ+zBWczMFY7TVMJo6t5XcJeY9cupiUt78MGOhUU86t0U3XNNe4i3hWLQm7usfAcqQkUJ9nsKRvl29qyPd11u1jE9S/7h1a39906/cw97bysvPL9NQ3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408577; c=relaxed/simple;
	bh=t+2Gst9xAi5hlIwYx/cxza1UHimWoYdHPusTdQrrccY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hInffBfy02RBSdsIusjCwGbretEJZ7SnKc6kdKa58fFZ12AkZlEiAJLtOsnyuzdhs5Q6aOf36a8PG68ljyNtx2JmeQzTyeIiAjVP6SpO9sbI8NfyOvJVqw9uWOoMf6RhazTwAd5Sl/ip0euTtosrFPMVZMbMQ1YjeSf05sXKiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GQfsSeGy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e033a3a07so23783775ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747408574; x=1748013374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0GNirFBXfZksDmcLkIx7giCST3II4UpjpZdHFvaex5s=;
        b=GQfsSeGyAB7JAoCVcMbV98hs3mI84XNwIJHFtrgZ90GXZKudh64JoDvi+O3SUidgzX
         wiBkIPz47Q97T6sfusCfCzh0Dk5lLz3omyUJigHsvb/MvSSSToZxSPeDs55kTmN+Dje6
         Ki0sQL/oLrJp6rWPCpfIOTDzB9OS/ZWkGpE4op+b3+LdLJw9FuUA61krpV1YlMV3tJPq
         sjiDQ/w1EIWBYEb6Q1/yCANfG3KI4kwTvTy0TolvE/EhUPFv+EAYz+RSaAjDs5FwXb24
         QgtLTuDiBW3kzQCZJyeDIGKyfXtcikj3A4LntFRTfkmy/zOIk4iF1Nso18z8PWPcJ3sj
         3wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747408574; x=1748013374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GNirFBXfZksDmcLkIx7giCST3II4UpjpZdHFvaex5s=;
        b=MRgKgIIIWDuESwb+7bZaXmBm9syb7TiXn+ficrNyaBj7hM4SMlzzO3wOipRfioFgUH
         FFFaVcWfjSFvGavazAlM+rMDtx0rDaH41mPfLOPejzwYWuN1schCyoCFDgD4WTSQgqgV
         ELce+JrrGu8bc3B5I/JNQkbsU3Zp0tVJ/z8m+aGW+UoTFzBYy++BTYO6194NVki6t6qC
         LZqKYsLhQLaI/GKPBm9SAnjT985C/xJiBTa6yNL0jU67VKZLKhBstEY9XU8MwYY1bdYb
         KOod1bPfVrTWa8oDmG6uRHvav1e0NuCSCnktfcWHjtcLiYkjytnjaMnDsX4w/KeDIMes
         gHUg==
X-Forwarded-Encrypted: i=1; AJvYcCUH0VazpEeons+o7lkZIzMwD6pTCw1PHYzoZoq/z0Xku4qv5jyklSAsMQL6Cahz1nR7igbkMu8JQ+Wkreg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXNk4ls3qhFU3c25G1nsGWtUiOJEzoojXmMh+zyVkVTwqki4a
	38ogTm8/hx9HCNRow0n1CItI5oY7VaxQSXRJ6ib9dnXBBl7qDE2t7WGIlUKkKxGMmf0=
X-Gm-Gg: ASbGncurnje1Wrlwy0dEd/OwANIxfxZhRDXaKzBM487V+MWB4844EgLmJpXutRUu7o3
	tFDr1Nj2DCo/pBrJux223YcaA9h/kELsvP2m+TrCK6LMvT1OULMHj/LVHti5SInEiwy+1Bgm7vw
	BqcVfb+rc+IwbJ6UKjUiX5MSv7gf2C1LmEL/bgzdGloV3Gbhy7HtFxuM4vRGlQ17BykUQIM7Ii7
	pbLZRLRo16op+cFrv+FBP/YKniaxKIH08s98SrJggdSviuIcNJYgOSaEntGClgKo6d5XWcOFvLo
	fDCdkmcsTUouslHmxCU735zNDBfDOhgK6K5Py26gvAzxy/ev2If1RGV7qBxxwg==
X-Google-Smtp-Source: AGHT+IHSSRQv6UaVUp1uY7YxcQ7Fp0Nkh/iVwU/C9R2BEes+S1JYlxj3SIRdl94BDLGOoJJBYixrLQ==
X-Received: by 2002:a17:903:faf:b0:224:c46:d167 with SMTP id d9443c01a7336-231d44e7049mr42573705ad.16.1747408573939;
        Fri, 16 May 2025 08:16:13 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebb0d4sm15446025ad.195.2025.05.16.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:16:13 -0700 (PDT)
Date: Fri, 16 May 2025 08:16:09 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v15 22/27] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Message-ID: <aCdWueNaGeru4CRW@debug.ba.rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
 <20250502-v5_user_cfi_series-v15-22-914966471885@rivosinc.com>
 <c911eead-30c4-497d-8a56-1450792b24bd@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c911eead-30c4-497d-8a56-1450792b24bd@ghiti.fr>

On Thu, May 15, 2025 at 09:10:08AM +0200, Alexandre Ghiti wrote:
>Hi Deepak,
>
>On 03/05/2025 01:30, Deepak Gupta wrote:
>>Kernel will have to perform shadow stack operations on user shadow stack.
>>Like during signal delivery and sigreturn, shadow stack token must be
>>created and validated respectively. Thus shadow stack access for kernel
>>must be enabled.
>>
>>In future when kernel shadow stacks are enabled for linux kernel, it must
>>be enabled as early as possible for better coverage and prevent imbalance
>>between regular stack and shadow stack. After `relocate_enable_mmu` has
>>been done, this is as early as possible it can enabled.
>>
>>Reviewed-by: Zong Li <zong.li@sifive.com>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/kernel/asm-offsets.c |  4 ++++
>>  arch/riscv/kernel/head.S        | 27 +++++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>>diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>>index f33945432f8f..7ab41f01aa17 100644
>>--- a/arch/riscv/kernel/asm-offsets.c
>>+++ b/arch/riscv/kernel/asm-offsets.c
>>@@ -514,4 +514,8 @@ void asm_offsets(void)
>>  	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
>>  	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
>>  #endif
>>+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>>+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
>>+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
>>+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
>
>
>kernel test robot reported errors when !RV64 and !SBI, the following 
>diff fixes it:
>
>diff --git a/arch/riscv/kernel/asm-offsets.c 
>b/arch/riscv/kernel/asm-offsets.c
>index 7fc085d27ca79..3aa5f56a84e9a 100644
>--- a/arch/riscv/kernel/asm-offsets.c
>+++ b/arch/riscv/kernel/asm-offsets.c
>@@ -532,8 +532,10 @@ void asm_offsets(void)
>������� DEFINE(FREGS_A6,����������� offsetof(struct 
>__arch_ftrace_regs, a6));
>������� DEFINE(FREGS_A7,����������� offsetof(struct 
>__arch_ftrace_regs, a7));
>�#endif
>+#ifdef CONFIG_RISCV_SBI
>������� DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>������� DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
>������� DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
>������� DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
>+#endif
>�}
>
>No need to resend the whole series, I'll squash it.

Thanks.
>
>Thanks,
>
>Alex
>
>
>>  }
>>diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>>index 356d5397b2a2..7eae9a172351 100644
>>--- a/arch/riscv/kernel/head.S
>>+++ b/arch/riscv/kernel/head.S
>>@@ -15,6 +15,7 @@
>>  #include <asm/image.h>
>>  #include <asm/scs.h>
>>  #include <asm/xip_fixup.h>
>>+#include <asm/usercfi.h>
>>  #include "efi-header.S"
>>  __HEAD
>>@@ -164,6 +165,19 @@ secondary_start_sbi:
>>  	call relocate_enable_mmu
>>  #endif
>>  	call .Lsetup_trap_vector
>>+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
>>+	li a7, SBI_EXT_FWFT
>>+	li a6, SBI_EXT_FWFT_SET
>>+	li a0, SBI_FWFT_SHADOW_STACK
>>+	li a1, 1 /* enable supervisor to access shadow stack access */
>>+	li a2, SBI_FWFT_SET_FLAG_LOCK
>>+	ecall
>>+	beqz a0, 1f
>>+	la a1, riscv_nousercfi
>>+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
>>+	REG_S a0, (a1)
>>+1:
>>+#endif
>>  	scs_load_current
>>  	call smp_callin
>>  #endif /* CONFIG_SMP */
>>@@ -320,6 +334,19 @@ SYM_CODE_START(_start_kernel)
>>  	la tp, init_task
>>  	la sp, init_thread_union + THREAD_SIZE
>>  	addi sp, sp, -PT_SIZE_ON_STACK
>>+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
>>+	li a7, SBI_EXT_FWFT
>>+	li a6, SBI_EXT_FWFT_SET
>>+	li a0, SBI_FWFT_SHADOW_STACK
>>+	li a1, 1 /* enable supervisor to access shadow stack access */
>>+	li a2, SBI_FWFT_SET_FLAG_LOCK
>>+	ecall
>>+	beqz a0, 1f
>>+	la a1, riscv_nousercfi
>>+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
>>+	REG_S a0, (a1)
>>+1:
>>+#endif
>>  	scs_load_current
>>  #ifdef CONFIG_KASAN
>>

