Return-Path: <linux-kernel+bounces-635919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB0EAAC3A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 14:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005091C2529D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 12:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BCA27FB0C;
	Tue,  6 May 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7ZQZJVK"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FA27FB01
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533814; cv=none; b=PB70Nziy9qsKUV89I+TbYKi7nl8EIXjjWCYlgW7D0kx7+jUAe1sdvQ1I7iq9fkiJ7h+B5+JoBV1N5Yzw97ln5WKNHsyHaX4Pt1xweaPM+1hjKWCTxgxHfsbjWyJ+KjK9mr6A+aUPqWTZ4hOmdZ3741uy11BmJu9WndCdA2Kg9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533814; c=relaxed/simple;
	bh=28bm2lz6nrAKK9UAhh7rr1Tj60SFzKcxLaxFc2JgOx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av3G/WT9kS/ngA3gUtSkdYi30mIlOB3JIgxzpHMFvTptgD+u5mFg/w1tqTO9gNKHR9pwGtt3w6UFf+T1GSzBOy8B5f1rdPtQjzoUT/+F+/KSK1zCakpK/KRR/VZkG8C3UsjwimydrxLap8lFqlBHwWfycROXj+C81prnulnVqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7ZQZJVK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe808908so57095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746533810; x=1747138610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kO+JIG55K7wbG0qihfpLAhhBwuPCPUUUJ6Q0SZcQ118=;
        b=y7ZQZJVKAKXd8ryNJ8wpZNqmsQIHUZMw45xGCQK8rHuKkro46ngqiIyfI8OXAqUgur
         jboGA6pnyxKHr1KU7YRFX0lUUB51ZPhVVCYbvZkKRV45GFkCLF7ST/e89qouwHPbIuJQ
         1/LMV5GTMplQqydvegcAT7fC+Ucc0Z4xcNKh17E3tUOigqpo9TIj7YRcsD9IIb9jHyf7
         LyHhVWBaoxtVDOd1YWEoE4fExZc/EccD1mfxug4ZFxMid6dDLncHG0KZAdxf1PO4y+/q
         eMasvBIzK45aACHL8YsfJO4xsURbXovgl/R2FYL3Y5XfxIxGz1P+k5p6qyHRhU/yXzP/
         JcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746533810; x=1747138610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO+JIG55K7wbG0qihfpLAhhBwuPCPUUUJ6Q0SZcQ118=;
        b=gdhtztz8VpgprEzI14484IjIOVzg+pORPogaQDr9G9IvWmlLLGZpMzybkbiGguQTcK
         3E4KRiQm0/kuB8XDpjIUs4zk8H6hGd6epmsghMF1qgkR790O6kKOrjDuKECis/vufqVO
         4ueHDJwyLmBZIttVRtxbvSYirOVoF85LyxFlHEl6nQZr7EIbPZY1qrdbk2VWWuDNW/zT
         vOdfqYdh9mRk2Fug6YT+JYFhe8dLQvrIzC9/+eeOHl8TfUV4ljSzJfP+vEKiNMaQSAZc
         HHqQ4zHc/4KjMf2ES/BbAm5bEysj8MZXGB8TxOQvQ/TK45gBSIcF8+KDmxTQA68/+9Je
         YKOA==
X-Gm-Message-State: AOJu0YwPT5TYaCBSTlxDp29sFrQGAnPa3ah9Zy+DdryhLhpP8oj6N/Xv
	cZKlKG5UnTS5Q3C7W3ummtjw3DXknVJMaDGlSIjMc2ewSvlh8MS4B86hc6NFIw==
X-Gm-Gg: ASbGncul8v5tK2TCFXRDvermDFe9bBG3WkOSYwz7A74Wt1qJA3LlZKMVn6J3BptOX/i
	KU6QlnmoKdJibXnWpEGOEPRU+QrfX0eGhNMUWL2TX1KbC/cVqvjyKgyRCe/IbnfmwZub0AYIpu8
	/nEqnFyClMTQgGqHmxCA/YXFofIwVSXUzThX3RSkWMIvbrK05FOLuEAwaKBi2QOQbpGD+3dXL2i
	YnEEc+8KUJnPBAwWB7qPWXX09ITPVAa7Dc/tKMKuBn6t2Ok4NxAYoc/mBm+5KQDp+fjtbRZmQ++
	Ry6gFv/c4eGadS0sLPc8Jm0lIHMioDAHpKlIxLI261xqXIN6jTDJS0AnsCLizYu2EtQI95XeQ/x
	A7M7CWRHepYM2LYQD
X-Google-Smtp-Source: AGHT+IEUqOQN9tee1kxirMRrJrS9/mWRcggk23cxyeNJT6T7FSNwCIyP8+ehQ+VVuCmQMo3UzSHE4A==
X-Received: by 2002:a05:600c:3b8c:b0:43b:df25:8c4 with SMTP id 5b1f17b1804b1-441d07b1637mr1330795e9.4.1746533810196;
        Tue, 06 May 2025 05:16:50 -0700 (PDT)
Received: from google.com (207.57.78.34.bc.googleusercontent.com. [34.78.57.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0fe92sm13701288f8f.68.2025.05.06.05.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 05:16:49 -0700 (PDT)
Date: Tue, 6 May 2025 12:16:44 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Per Larsen <perl@immunant.com>
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
	james.morse@arm.com, jean-philippe@linaro.org,
	kernel-team@android.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com,
	armellel@google.com, arve@android.com, ahomescu@google.com,
	Per Larsen <perlarsen@google.com>
Subject: Re: [PATCH 3/3] KVM: arm64: Support FFA_MSG_SEND_DIRECT_REQ2 in host
 handler
Message-ID: <aBn9rMiVI_7CcdED@google.com>
References: <20250502092108.3224341-1-perl@immunant.com>
 <20250502092108.3224341-4-perl@immunant.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502092108.3224341-4-perl@immunant.com>

On Fri, May 02, 2025 at 02:21:08AM -0700, Per Larsen wrote:
> From: Per Larsen <perlarsen@google.com>
> 
> FF-A 1.2 adds the DIRECT_REQ2 messaging interface which is similar to
> the existing FFA_MSG_SEND_DIRECT_{REQ,RESP} functions except that it
> uses the SMC calling convention v1.2 which allows calls to use x4-x17 as
> argument and return registers. Add support for FFA_MSG_SEND_DIRECT_REQ2
> in the host ffa handler.
> 
> Signed-off-by: Per Larsen <perlarsen@google.com>
> Signed-off-by: Per Larsen <perl@immunant.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 111 +++++++++++++++++++++++++++++++++-
>  include/linux/arm_ffa.h       |   2 +
>  2 files changed, 111 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 8102dd6a19f7..d8c066f3c5c9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -79,6 +79,14 @@ static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
>  	};
>  }
>  
> +static void ffa_to_smccc_1_2_error(struct arm_smccc_1_2_regs *regs, u64 ffa_errno)
> +{
> +	*regs = (struct arm_smccc_1_2_regs) {
> +		.a0	= FFA_ERROR,
> +		.a2	= ffa_errno,
> +	};
> +}
> +
>  static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int ret, u64 prop)
>  {
>  	if (ret == FFA_RET_SUCCESS) {
> @@ -89,11 +97,26 @@ static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int ret, u64 prop)
>  	}
>  }
>  
> +static void ffa_to_smccc_1_2_regs_prop(struct arm_smccc_1_2_regs *regs, int ret, u64 prop)
> +{
> +	if (ret == FFA_RET_SUCCESS) {
> +		*regs = (struct arm_smccc_1_2_regs) { .a0 = FFA_SUCCESS,
> +						.a2 = prop };
> +	} else {

NIT: no paranthesis needed here

> +		ffa_to_smccc_1_2_error(regs, ret);
> +	}
> +}
> +
>  static void ffa_to_smccc_res(struct arm_smccc_res *res, int ret)
>  {
>  	ffa_to_smccc_res_prop(res, ret, 0);
>  }
>  
> +static void ffa_to_smccc_1_2_regs(struct arm_smccc_1_2_regs *regs, int ret)
> +{
> +	ffa_to_smccc_1_2_regs_prop(regs, ret, 0);
> +}
> +
>  static void ffa_set_retval(u64 func_id,
>  			   struct kvm_cpu_context *ctxt,
>  			   struct arm_smccc_res *res)
> @@ -127,6 +150,29 @@ static void ffa_set_retval(u64 func_id,
>  	}
>  }
>  
> +static void ffa_set_retval_smccc_1_2(struct kvm_cpu_context *ctxt,
> +			   struct arm_smccc_1_2_regs *regs)
> +{
> +	cpu_reg(ctxt, 0) = regs->a0;
> +	cpu_reg(ctxt, 1) = regs->a1;
> +	cpu_reg(ctxt, 2) = regs->a2;
> +	cpu_reg(ctxt, 3) = regs->a3;
> +	cpu_reg(ctxt, 4) = regs->a4;
> +	cpu_reg(ctxt, 5) = regs->a5;
> +	cpu_reg(ctxt, 6) = regs->a6;
> +	cpu_reg(ctxt, 7) = regs->a7;
> +	cpu_reg(ctxt, 8) = regs->a8;
> +	cpu_reg(ctxt, 9) = regs->a9;
> +	cpu_reg(ctxt, 10) = regs->a10;
> +	cpu_reg(ctxt, 11) = regs->a11;
> +	cpu_reg(ctxt, 12) = regs->a12;
> +	cpu_reg(ctxt, 13) = regs->a13;
> +	cpu_reg(ctxt, 14) = regs->a14;
> +	cpu_reg(ctxt, 15) = regs->a15;
> +	cpu_reg(ctxt, 16) = regs->a16;
> +	cpu_reg(ctxt, 17) = regs->a17;
> +}
> +
>  /* Call SMC64 using SMCCC 1.2 if hyp negotiated FF-A 1.2 falling back to 1.1 */
>  static void arm_smccc_1_2_smc_fallback(u64 func_id, u64 a1, u64 a2, u64 a3,
>  				       u64 a4, u64 a5, u64 a6, u64 a7,
> @@ -681,7 +727,6 @@ static bool ffa_call_supported(u64 func_id)
>  	case FFA_NOTIFICATION_GET:
>  	case FFA_NOTIFICATION_INFO_GET:
>  	/* Unimplemented interfaces added in FF-A 1.2 */
> -	case FFA_MSG_SEND_DIRECT_REQ2:
>  
>  	/*
>  	 * FFA_MSG_SEND_DIRECT_RESP2 is not meant to be invoked by the host or
> @@ -709,6 +754,20 @@ static bool ffa_call_supported(u64 func_id)
>  	return true;
>  }
>  
> +/*
> + * Must a given FFA function use the SMC calling convention v1.2?
> + */
> +static bool ffa_call_needs_smccc_1_2(u64 func_id)
> +{
> +	switch (func_id) {
> +	case FFA_MSG_SEND_DIRECT_REQ2:
> +	case FFA_MSG_SEND_DIRECT_RESP2:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static bool do_ffa_features(struct arm_smccc_res *res,
>  			    struct kvm_cpu_context *ctxt)
>  {
> @@ -882,9 +941,47 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
>  	hyp_spin_unlock(&host_buffers.lock);
>  }
>  
> +static void do_ffa_direct_msg2(struct arm_smccc_1_2_regs *regs,
> +			      struct kvm_cpu_context *ctxt,
> +			      u64 vm_handle)
> +{
> +	DECLARE_REG(u32, func_id, ctxt, 0);
> +	DECLARE_REG(u32, endp, ctxt, 1);
> +	DECLARE_REG(u64, uuid_lo, ctxt, 2);
> +	DECLARE_REG(u64, uuid_hi, ctxt, 3);
> +	DECLARE_REG(u64, x4, ctxt, 4);
> +	DECLARE_REG(u64, x5, ctxt, 5);
> +	DECLARE_REG(u64, x6, ctxt, 6);
> +	DECLARE_REG(u64, x7, ctxt, 7);
> +	DECLARE_REG(u64, x8, ctxt, 8);
> +	DECLARE_REG(u64, x9, ctxt, 9);
> +	DECLARE_REG(u64, x10, ctxt, 10);
> +	DECLARE_REG(u64, x11, ctxt, 11);
> +	DECLARE_REG(u64, x12, ctxt, 12);
> +	DECLARE_REG(u64, x13, ctxt, 13);
> +	DECLARE_REG(u64, x14, ctxt, 14);
> +	DECLARE_REG(u64, x15, ctxt, 15);
> +	DECLARE_REG(u64, x16, ctxt, 16);
> +	DECLARE_REG(u64, x17, ctxt, 17);
> +
> +	if (FIELD_GET(FFA_SRC_ENDPOINT_MASK, endp) != vm_handle) {
> +		ffa_to_smccc_1_2_regs(regs, FFA_RET_INVALID_PARAMETERS);
> +		return;
> +	}
> +
> +	struct arm_smccc_1_2_regs args = {
> +		func_id, endp, uuid_lo, uuid_hi,
> +		 x4,  x5,  x6,  x7,  x8,  x9, x10,
> +		x11, x12, x13, x14, x15, x16, x17
> +	};

Maybe use cpu_reg(ctxt, ) to avoid copying two times the values and drop
the DECLARE_REG ?

> +
> +	arm_smccc_1_2_smc(&args, regs);
> +}
> +
>  bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
>  {
>  	struct arm_smccc_res res;
> +	struct arm_smccc_1_2_regs regs;
>  
>  	/*
>  	 * There's no way we can tell what a non-standard SMC call might
> @@ -940,14 +1037,24 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
>  	case FFA_PARTITION_INFO_GET:
>  		do_ffa_part_get(&res, host_ctxt);
>  		goto out_handled;
> +	case FFA_MSG_SEND_DIRECT_REQ2:
> +		if (hyp_ffa_version >= FFA_VERSION_1_2) {

The version is accessed without a lock.

> +			do_ffa_direct_msg2(&regs, host_ctxt, HOST_FFA_ID);
> +			goto out_handled;
> +		}
> +		goto out_not_supported;
>  	}
>  
>  	if (ffa_call_supported(func_id))
>  		return false; /* Pass through */
>  
> +out_not_supported:
>  	ffa_to_smccc_error(&res, FFA_RET_NOT_SUPPORTED);
>  out_handled:
> -	ffa_set_retval(func_id, host_ctxt, &res);
> +	if (ffa_call_needs_smccc_1_2(func_id))
> +		ffa_set_retval_smccc_1_2(host_ctxt, &regs);
> +	else
> +		ffa_set_retval(func_id, host_ctxt, &res);
>  	return true;
>  }
>  
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 5bded24dc24f..4d541cf12ceb 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -268,6 +268,8 @@ bool ffa_partition_check_property(struct ffa_device *dev, u32 property)
>  	(ffa_partition_check_property(dev, FFA_PARTITION_DIRECT_REQ2_RECV) && \
>  	 !dev->mode_32bit)
>  
> +#define FFA_SRC_ENDPOINT_MASK	GENMASK(31, 16)
> +
>  /* For use with FFA_MSG_SEND_DIRECT_{REQ,RESP} which pass data via registers */
>  struct ffa_send_direct_data {
>  	unsigned long data0; /* w3/x3 */
> -- 
> 2.49.0
> 

