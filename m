Return-Path: <linux-kernel+bounces-873511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE03FC1418F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A2C3BA3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FABC302168;
	Tue, 28 Oct 2025 10:26:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C12E540C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647173; cv=none; b=U6BeHfFGPMF73BNQ9tLtTUhlm1FcV2PwXQfdSXdzE5x7EfvRt9fiGRJi62eiT2wcdZOwNrLy7o1MTuNnD7DJkxamGtVFA3QLTZdAw6j70ukKGENTVkPLMovMEy0rvtPiAkjkMMBWNimMLrnKhtzI5774ryUT4FTXRltk5ONG0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647173; c=relaxed/simple;
	bh=+J5qvhm2MQNu+iEcPAkphWp3vaq8ieFAb18tZkLd69w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fELKM/hEWfCQW/cCkLaGqxDLTef/4BRhtbi2N2htB92HAdE6L4izYTxNw9NmtkSqHTDJ/v3l/Z0WM0Yf7gMY+zBJ1n0caDhAyRc0Dbcvm0C0IQzIbOkO0MnW4+Fk5E8GSzVxgf/9HVLN75Ic8yI3e9Uu8VbLsB5Jip2Q/OFYpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CCDB106F;
	Tue, 28 Oct 2025 03:26:01 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 146923F63F;
	Tue, 28 Oct 2025 03:26:06 -0700 (PDT)
Message-ID: <f5aa3c19-fdea-4f62-9541-530e59b20a87@arm.com>
Date: Tue, 28 Oct 2025 10:26:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: arm64: support optional calls of FF-A v1.2
To: Yeoreum Yun <yeoreum.yun@arm.com>, maz@kernel.org,
 oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
 perlarsen@google.com, ayrton@google.com
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251027191729.1704744-1-yeoreum.yun@arm.com>
 <20251027191729.1704744-3-yeoreum.yun@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251027191729.1704744-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Levi,

On 10/27/25 19:17, Yeoreum Yun wrote:
> To use TPM drvier which uses CRB over FF-A with FFA_DIRECT_REQ2,
> support the FF-A v1.2's optinal calls by querying whether
> SPMC supports those.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 0ae87ff61758..9ded1c6369b9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -646,6 +646,22 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
>  		ffa_to_smccc_res(res, ret);
>  }
>  
> +static bool ffa_1_2_optional_calls_supported(u64 func_id)
> +{
> +	struct arm_smccc_1_2_regs res;
> +
> +	if (!smp_load_acquire(&has_version_negotiated) ||
> +		(FFA_MINOR_VERSION(FFA_VERSION_1_2) < 2))
> +		return false;
> +
> +	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
> +		.a0 = FFA_FEATURES,
> +		.a1 = func_id,
> +	}, &res);
> +
> +	return res.a0 == FFA_SUCCESS;
> +}
> +
>  /*
>   * Is a given FFA function supported, either by forwarding on directly
>   * or by handling at EL2?
> @@ -678,12 +694,13 @@ static bool ffa_call_supported(u64 func_id)
>  	case FFA_NOTIFICATION_SET:
>  	case FFA_NOTIFICATION_GET:
>  	case FFA_NOTIFICATION_INFO_GET:
> +		return false;
>  	/* Optional interfaces added in FF-A 1.2 */
>  	case FFA_MSG_SEND_DIRECT_REQ2:		/* Optional per 7.5.1 */
>  	case FFA_MSG_SEND_DIRECT_RESP2:		/* Optional per 7.5.1 */
>  	case FFA_CONSOLE_LOG:			/* Optional per 13.1: not in Table 13.1 */

Looking at table 13.54 in the FF-A 1.2 spec FFA_CONSOLE_LOG is only supported in secure FF-A
instances and not from the normal world.

>  	case FFA_PARTITION_INFO_GET_REGS:	/* Optional for virtual instances per 13.1 */
> -		return false;
> +		return ffa_1_2_optional_calls_supported(func_id);
>  	}

I don't think that an smc call here is the right thing to do. This changes this from a light 
weight deny list to an extra smc call for each ffa_msg_send_direct_req2 from the driver.

Instead, I would expect this patch just to remove FFA_MSG_SEND_DIRECT_REQ2 from the deny list
and rely on the TPM driver to use FFA_FEATURES to check whether it's supported.

So, just this change:

@@ -679,7 +679,6 @@ static bool ffa_call_supported(u64 func_id)
        case FFA_NOTIFICATION_GET:
        case FFA_NOTIFICATION_INFO_GET:
        /* Optional interfaces added in FF-A 1.2 */
-       case FFA_MSG_SEND_DIRECT_REQ2:          /* Optional per 7.5.1 */
        case FFA_MSG_SEND_DIRECT_RESP2:         /* Optional per 7.5.1 */
        case FFA_CONSOLE_LOG:                   /* Optional per 13.1: not in Table 13.1 */
        case FFA_PARTITION_INFO_GET_REGS:       /* Optional for virtual instances per 13.1 */

Am I missing something?

>  
>  	return true; 
Thanks,

Ben


