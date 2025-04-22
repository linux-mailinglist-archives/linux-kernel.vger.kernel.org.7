Return-Path: <linux-kernel+bounces-613924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C6A963EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A313A66DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A7923BF8F;
	Tue, 22 Apr 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IoOzqOqj"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD819D880
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313278; cv=none; b=H+e4wupQ3vkZnrUKoh8v9P8yXvVXbxy8vIwVnpGiwIXYRnakKY9XKdC9XMWYhi24dOLjCLY2S7qncVh62gaU57w3KFILXemeflEjXfODVneDI68GswaQvT6AcMAObcxLejkuqwugA8eNEOBz+KZwvHAlRL6YrOttQurxz9ZtR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313278; c=relaxed/simple;
	bh=ugqZE6JNbj9oQtcZcJMQR5MwfTra2sRu4byrrBEUJSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NKIBZDjb5C7jcnZbpr+eBrTWq6z9lPD34UkVMj9VuGcfAta8vbNWdRgQ5N1BNwR3efkNggJa8Kmjk7xJu7L3dy2ZHfiMw4ogLeqLwrWbyqqGNGUeuoTsIXgV9RwbKx/jDtDLzPv4fksmyNLz1zaeTFttemuXp9YEgkVnFBo9Cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IoOzqOqj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fd89d036so59507205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 02:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745313275; x=1745918075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyVOrtJIgxT1vzXpBnLLtpPNJp2RqLptpQJYK0Oxhhs=;
        b=IoOzqOqjiniMdhFLCIBvrNDvyzvQLOVcC/5lAqJk4i3u/Ny18HfDkhb8i+dhyZj4aw
         aUkam3aby02OFvQONPkN6Z1LtdIpA2GX79u9zeMle6Vd43bpv5Tx/amD2cSyRnvc6+np
         Pzo69pdHZ5yfOdvWf/4wf+K9NoSKFBQGCDNqc/z5n44WBq/SQJ9geBuSXzWK3a5xk4zT
         J7VZYgxqDm/pFdxWKbw4tze4iQMmo8TeRxL7w2QlqSV7ZEst6k3eMszq7sucUAzDrzZ1
         JvvUKcFjbuSF5oGfV1FUJ3yE67Ar3U2qqnPac2nsy2n3NLuJM2lab4IzN3fPTloWBKJh
         sRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745313275; x=1745918075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyVOrtJIgxT1vzXpBnLLtpPNJp2RqLptpQJYK0Oxhhs=;
        b=SPCo4xM6wiCS+dPOMGcvoz2HhYJFV9RJyOqmo/FYISLNHquqgzGUF2Qd6ss2gqDt1n
         JDJslDzKigYfudaANPJuyeYPBTkfpDzJmGRCZHyuJrI413TOjNKVZIBX+ST1BEhEISEs
         AY8CbfYDvK/xhXSd1bMGqhu0nFw6/LlJNNLgvQz4vIKNZQYTNsCRcuEbkdn4/Rbd28Qp
         CzEHZ18pAzLTXfqkILiuII9MeuLEDzFezhGtdW18XcTpqjkgNEh3VZoYmNqM5aHSfIGt
         fgVdZ5kM13/aWKQoKGs/J7METdtd23sj5byGSRFdhV2iM/cZR9ykE8K2u17I1AM34VYB
         Nriw==
X-Forwarded-Encrypted: i=1; AJvYcCUDWLcDpMJTwRY6vMLRMoaRoNaPjaZEW2sP2q//6ysP2k/NIin7an73ln4rsNdNzCDifeyKfCJgW6l3hQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUF87sZggAuXYAIsMY6h84YktHGbod5eIdhl9Y2OehyWM3sQ8
	pYGWYJqd016ps8Q+LrMariCh6khXcyhs3RU1Yt/tzZ/4W85yv0jvXavBdvHx7j4=
X-Gm-Gg: ASbGnctQA7voZOPaIf2xgo1Y7WTbLeJCOQ6zOYtD2j5DS5LmISdu7uVYgrax3ysDZuJ
	P3grSLOH9M30MOoV67Ajfrmp1X1haRMXCyw9DOmN/nBc/wlGUiINQ1He1v8mM9DAB2q9Nly/wqK
	mYWY6c2QsJz3y37q/sXd5hYzgkMYnZZ4MXYT9f8vxKQgD7F+sHXgplB0GgNrbLQpp6foC8aa8Nm
	WjGntm8k6iganWUtcEdukC2bJi6NAoKOf5hGbhEbDuLoXWwov7S1SAlQWp4SPMXz7GNRS5MCUEt
	ZZLzxsrUZPlRWKIPWP+LNFRjVJPyOMYQVIQzCFwIEMPhjJ1Thjj6f+9Jm9l27TardH3EHq59MIB
	bePb2Sp9U3yd3I6YCFACF
X-Google-Smtp-Source: AGHT+IHbf5npXmqi8gat+Hco3knxebzMcVXnyr89petCkIB59pS/1nzFa6TcAvnityatRhjESw9seQ==
X-Received: by 2002:a17:902:dac9:b0:224:a74:28c2 with SMTP id d9443c01a7336-22c535aa4femr223314305ad.29.1745313275304;
        Tue, 22 Apr 2025 02:14:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df0be00sm8064009a91.14.2025.04.22.02.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 02:14:34 -0700 (PDT)
Message-ID: <f5d40648-50a0-4f7b-a8ef-62eab26364dc@rivosinc.com>
Date: Tue, 22 Apr 2025 11:14:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] riscv: Strengthen duplicate and inconsistent
 definition of RV_X()
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
References: <20250422082545.450453-1-alexghiti@rivosinc.com>
 <20250422082545.450453-3-alexghiti@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250422082545.450453-3-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/04/2025 10:25, Alexandre Ghiti wrote:
> RV_X() macro is defined in two different ways which is error prone.
> 
> So harmonize its first definition and add another macro RV_X_mask() for
> the second one.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/insn.h        | 39 ++++++++++++++--------------
>  arch/riscv/kernel/elf_kexec.c        |  1 -
>  arch/riscv/kernel/traps_misaligned.c |  1 -
>  arch/riscv/kvm/vcpu_insn.c           |  1 -
>  4 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index 2a589a58b291..4063ca35be9b 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -288,43 +288,44 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
>  
>  #define RV_IMM_SIGN(x) (-(((x) >> 31) & 1))
>  #define RVC_IMM_SIGN(x) (-(((x) >> 12) & 1))
> -#define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
> -#define RVC_X(X, s, mask) RV_X(X, s, mask)
> +#define RV_X(X, s, n) (((X) >> (s)) & ((1 << (n)) - 1))
> +#define RV_X_mask(X, s, mask)  (((X) >> (s)) & (mask))
> +#define RVC_X(X, s, mask) RV_X_mask(X, s, mask)

Hi Alex,

I think RV_X() could be defined using RV_X_mask() as well:

#define RV_X(X, s, n) RV_X_mask(X, s, ((1 << (n)) - 1))

Thanks,

Clément

>  
>  #define RV_EXTRACT_RS1_REG(x) \
>  	({typeof(x) x_ = (x); \
> -	(RV_X(x_, RVG_RS1_OPOFF, RVG_RS1_MASK)); })
> +	(RV_X_mask(x_, RVG_RS1_OPOFF, RVG_RS1_MASK)); })
>  
>  #define RV_EXTRACT_RD_REG(x) \
>  	({typeof(x) x_ = (x); \
> -	(RV_X(x_, RVG_RD_OPOFF, RVG_RD_MASK)); })
> +	(RV_X_mask(x_, RVG_RD_OPOFF, RVG_RD_MASK)); })
>  
>  #define RV_EXTRACT_UTYPE_IMM(x) \
>  	({typeof(x) x_ = (x); \
> -	(RV_X(x_, RV_U_IMM_31_12_OPOFF, RV_U_IMM_31_12_MASK)); })
> +	(RV_X_mask(x_, RV_U_IMM_31_12_OPOFF, RV_U_IMM_31_12_MASK)); })
>  
>  #define RV_EXTRACT_JTYPE_IMM(x) \
>  	({typeof(x) x_ = (x); \
> -	(RV_X(x_, RV_J_IMM_10_1_OPOFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_1_OFF) | \
> -	(RV_X(x_, RV_J_IMM_11_OPOFF, RV_J_IMM_11_MASK) << RV_J_IMM_11_OFF) | \
> -	(RV_X(x_, RV_J_IMM_19_12_OPOFF, RV_J_IMM_19_12_MASK) << RV_J_IMM_19_12_OFF) | \
> +	(RV_X_mask(x_, RV_J_IMM_10_1_OPOFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_1_OFF) | \
> +	(RV_X_mask(x_, RV_J_IMM_11_OPOFF, RV_J_IMM_11_MASK) << RV_J_IMM_11_OFF) | \
> +	(RV_X_mask(x_, RV_J_IMM_19_12_OPOFF, RV_J_IMM_19_12_MASK) << RV_J_IMM_19_12_OFF) | \
>  	(RV_IMM_SIGN(x_) << RV_J_IMM_SIGN_OFF); })
>  
>  #define RV_EXTRACT_ITYPE_IMM(x) \
>  	({typeof(x) x_ = (x); \
> -	(RV_X(x_, RV_I_IMM_11_0_OPOFF, RV_I_IMM_11_0_MASK)) | \
> +	(RV_X_mask(x_, RV_I_IMM_11_0_OPOFF, RV_I_IMM_11_0_MASK)) | \
>  	(RV_IMM_SIGN(x_) << RV_I_IMM_SIGN_OFF); })
>  
>  #define RV_EXTRACT_BTYPE_IMM(x) \
>  	({typeof(x) x_ = (x); \
> -	(RV_X(x_, RV_B_IMM_4_1_OPOFF, RV_B_IMM_4_1_MASK) << RV_B_IMM_4_1_OFF) | \
> -	(RV_X(x_, RV_B_IMM_10_5_OPOFF, RV_B_IMM_10_5_MASK) << RV_B_IMM_10_5_OFF) | \
> -	(RV_X(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF) | \
> +	(RV_X_mask(x_, RV_B_IMM_4_1_OPOFF, RV_B_IMM_4_1_MASK) << RV_B_IMM_4_1_OFF) | \
> +	(RV_X_mask(x_, RV_B_IMM_10_5_OPOFF, RV_B_IMM_10_5_MASK) << RV_B_IMM_10_5_OFF) | \
> +	(RV_X_mask(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF) | \
>  	(RV_IMM_SIGN(x_) << RV_B_IMM_SIGN_OFF); })
>  
>  #define RVC_EXTRACT_C2_RS1_REG(x) \
>  	({typeof(x) x_ = (x); \
> -	(RV_X(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
> +	(RV_X_mask(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
>  
>  #define RVC_EXTRACT_JTYPE_IMM(x) \
>  	({typeof(x) x_ = (x); \
> @@ -346,10 +347,10 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
>  	(RVC_IMM_SIGN(x_) << RVC_B_IMM_SIGN_OFF); })
>  
>  #define RVG_EXTRACT_SYSTEM_CSR(x) \
> -	({typeof(x) x_ = (x); RV_X(x_, RVG_SYSTEM_CSR_OFF, RVG_SYSTEM_CSR_MASK); })
> +	({typeof(x) x_ = (x); RV_X_mask(x_, RVG_SYSTEM_CSR_OFF, RVG_SYSTEM_CSR_MASK); })
>  
>  #define RVFDQ_EXTRACT_FL_FS_WIDTH(x) \
> -	({typeof(x) x_ = (x); RV_X(x_, RVFDQ_FL_FS_WIDTH_OFF, \
> +	({typeof(x) x_ = (x); RV_X_mask(x_, RVFDQ_FL_FS_WIDTH_OFF, \
>  				   RVFDQ_FL_FS_WIDTH_MASK); })
>  
>  #define RVV_EXTRACT_VL_VS_WIDTH(x) RVFDQ_EXTRACT_FL_FS_WIDTH(x)
> @@ -375,10 +376,10 @@ static inline void riscv_insn_insert_jtype_imm(u32 *insn, s32 imm)
>  {
>  	/* drop the old IMMs, all jal IMM bits sit at 31:12 */
>  	*insn &= ~GENMASK(31, 12);
> -	*insn |= (RV_X(imm, RV_J_IMM_10_1_OFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_1_OPOFF) |
> -		 (RV_X(imm, RV_J_IMM_11_OFF, RV_J_IMM_11_MASK) << RV_J_IMM_11_OPOFF) |
> -		 (RV_X(imm, RV_J_IMM_19_12_OFF, RV_J_IMM_19_12_MASK) << RV_J_IMM_19_12_OPOFF) |
> -		 (RV_X(imm, RV_J_IMM_SIGN_OFF, 1) << RV_J_IMM_SIGN_OPOFF);
> +	*insn |= (RV_X_mask(imm, RV_J_IMM_10_1_OFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_1_OPOFF) |
> +		 (RV_X_mask(imm, RV_J_IMM_11_OFF, RV_J_IMM_11_MASK) << RV_J_IMM_11_OPOFF) |
> +		 (RV_X_mask(imm, RV_J_IMM_19_12_OFF, RV_J_IMM_19_12_MASK) << RV_J_IMM_19_12_OPOFF) |
> +		 (RV_X_mask(imm, RV_J_IMM_SIGN_OFF, 1) << RV_J_IMM_SIGN_OPOFF);
>  }
>  
>  /*
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index e783a72d051f..15e6a8f3d50b 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -336,7 +336,6 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
>  	return ret ? ERR_PTR(ret) : NULL;
>  }
>  
> -#define RV_X(x, s, n)  (((x) >> (s)) & ((1 << (n)) - 1))
>  #define RISCV_IMM_BITS 12
>  #define RISCV_IMM_REACH (1LL << RISCV_IMM_BITS)
>  #define RISCV_CONST_HIGH_PART(x) \
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 4354c87c0376..fb2599d62752 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -105,7 +105,6 @@
>  #define SH_RS2				20
>  #define SH_RS2C				2
>  
> -#define RV_X(x, s, n)			(((x) >> (s)) & ((1 << (n)) - 1))
>  #define RVC_LW_IMM(x)			((RV_X(x, 6, 1) << 2) | \
>  					 (RV_X(x, 10, 3) << 3) | \
>  					 (RV_X(x, 5, 1) << 6))
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index 97dec18e6989..ba4813673f95 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -91,7 +91,6 @@
>  #define SH_RS2C			2
>  #define MASK_RX			0x1f
>  
> -#define RV_X(x, s, n)		(((x) >> (s)) & ((1 << (n)) - 1))
>  #define RVC_LW_IMM(x)		((RV_X(x, 6, 1) << 2) | \
>  				 (RV_X(x, 10, 3) << 3) | \
>  				 (RV_X(x, 5, 1) << 6))


