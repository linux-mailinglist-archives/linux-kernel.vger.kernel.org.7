Return-Path: <linux-kernel+bounces-628179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB412AA59FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 05:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09DE7B2E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 03:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77322D7BF;
	Thu,  1 May 2025 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri9hYZns"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996DC4C80
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746070599; cv=none; b=IhDwepECteHgKCSgz+vU+AyZe7nuQkgJqHQcLTNjWeVLsjfLl8teC2kzrIoxTj5eeqmqG8UKBm8ybrL5y7dwp24ILOeUFAZVHS2fhHvFwb/Z6hf3pI+NOFrsB23sum6AW1QMoohWJakamcIyDa5x/XL5Dg5b0b6+lsV2dJWyGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746070599; c=relaxed/simple;
	bh=jOUm0TGjHvVgOeTlX7WUSROohi02FDP2MJVQZDEyK9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lN7YzwO1O7clvnSN5lHKu5azbmXGLT+icPzgA6lYyQXDsUjE5ws/8RBcy84SPEI01ygZNCP2mHB3Odd6pglfdQF+e2rD0TSnSphPM66Fnt0LiCayc+kzsv2NqAPwM8/1+KeVEKja1nr7mrOZIbP0+yy9o35fpDNTvUZlS8txyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ri9hYZns; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746070596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTFtgQvUStCLWm58c+Cl1OhMJYhsO+XdoCxoo3JcEgE=;
	b=Ri9hYZnsRNPVCrOEfP7RpmnPQTJnbE5J0To22oO20KNW6ZgVsvO2eLgCL4WwUz0WNk3jsQ
	oo5Sg/WmgIbb5jYQt2gEXWzOiLp3K89CuLgzrmLlu+YzEoqye73dhE8wAqcGGZ1UOYy7ok
	GuBAYEyf5bGEmNnwjh/yRoue2ytXIR0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-v5otuVycN4GLe6oi1ab-gw-1; Wed, 30 Apr 2025 23:36:35 -0400
X-MC-Unique: v5otuVycN4GLe6oi1ab-gw-1
X-Mimecast-MFC-AGG-ID: v5otuVycN4GLe6oi1ab-gw_1746070594
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2241ae15dcbso6171355ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 20:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746070594; x=1746675394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTFtgQvUStCLWm58c+Cl1OhMJYhsO+XdoCxoo3JcEgE=;
        b=MR7HEGlxiGYqDFCfMtcoGdOPzzzPaYK5gJBcQy6WHAsxz2OlRwXmABromAy5AKLw25
         Mlx+dKGlTBdPr85TLcDyiTxAxBQiy3ZmJqUjBncTKdr891dWJYetX2lDzl5nyK4z4KuM
         jXHU8QXRnYdYfDxctG2zEg5aR5RjzcRJhfRFC1/pszs09suJO51BeCnxSsyv2y7V3c9z
         CzBMMyEYDZlYQkNDQb/XPuJ3HznIFI5S1FEE9EHWy4gVog0ms7H+y4FTvuJn8CCzeQ4/
         635kO1EdMp6JlI3FD8dkj3Uv5bIZ91zTE3kVEGWbjt8LW2ZzuqSso6n4yQgjqDV7hDUG
         WXKw==
X-Forwarded-Encrypted: i=1; AJvYcCXw66nwEyKUVOMyYBiFFSiFElAjYaMWea9Ax4Ha55L9U5aCKf80FSErd/B4pAwECh2sOTrhvU+R3cjcymk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysjo7TNCXpbrWMHAsVSDq4rVDA6FwVKakrvy2Ho/ouHu2AJVoS
	tcE4SSJiP7yiAtU/uwg5LxRYCpC7tSyhUZFW0U5vBvQqtknd0cpdz7hdnEY7rF/PnEJM8Yl+sHP
	nSb7sEls/LwVQv3WCdePcaC3X22pITPympkLYWDIxPCKzqmTA1AMGFTqse3BPrA==
X-Gm-Gg: ASbGnct6z0EGkSFfbe4+w+HgLAmx8grfVSx47Sr1C9CzS17rt1qhZp9ZJP/hM+J5FYm
	HT7SpQqW1DMoLTPjOm8+Y39owXFW9nT2H7Vi2zINhpZQmUHPNgN8UnK7dXDwgYpD5F4CoTUuWKD
	dyiqys3doRJxPEwxqZQh2zJ+YWf9ZOHfQ6LbpljND4WdsWAugq6bB/FiDKpaJcsxZb+7EnPThOv
	p4CXTSDwpirHvrNsqJ1iqwiYG3blF25C8UnapOOi1Zdd+DcnO89VAXcyBwVCkRJiqBPA1bPxT6j
	KZshf4qoURzx
X-Received: by 2002:a17:902:f689:b0:21f:564:80a4 with SMTP id d9443c01a7336-22df5821f58mr76534835ad.33.1746070594074;
        Wed, 30 Apr 2025 20:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRVQ709s9NlHNG/57ZQ0bX3xBINvQEcZ7cw6X19Wk71uY6m4FTQDBhudqbvsTzqwNROwGOtQ==
X-Received: by 2002:a17:902:f689:b0:21f:564:80a4 with SMTP id d9443c01a7336-22df5821f58mr76534535ad.33.1746070593712;
        Wed, 30 Apr 2025 20:36:33 -0700 (PDT)
Received: from [192.168.68.51] ([180.233.125.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5101636sm130469695ad.180.2025.04.30.20.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 20:36:33 -0700 (PDT)
Message-ID: <19ec5533-ee10-4670-a9fd-da1345a6946a@redhat.com>
Date: Thu, 1 May 2025 13:36:24 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 34/43] arm64: RME: Propagate number of breakpoints and
 watchpoints to userspace
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250416134208.383984-1-steven.price@arm.com>
 <20250416134208.383984-35-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250416134208.383984-35-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/25 11:41 PM, Steven Price wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> The RMM describes the maximum number of BPs/WPs available to the guest
> in the Feature Register 0. Propagate those numbers into ID_AA64DFR0_EL1,
> which is visible to userspace. A VMM needs this information in order to
> set up realm parameters.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   arch/arm64/include/asm/kvm_rme.h |  2 ++
>   arch/arm64/kvm/rme.c             | 22 ++++++++++++++++++++++
>   arch/arm64/kvm/sys_regs.c        |  2 +-
>   3 files changed, 25 insertions(+), 1 deletion(-)
> 

If I don't miss anything, it's not enough to apply the filter on reading and
resetting path where sanitise_id_aa64dfr0_el1() is called. id_aa64dfr0_el1
is writable and it's possible that QEMU modifies its value. Afterwards, the
register is read from guest kernel, which will be trapped to host and the
modified value is returned, without this filter applied. So I think the same
filter need to be applied to the write path originated from QEMU.

Thanks,
Gavin

> diff --git a/arch/arm64/include/asm/kvm_rme.h b/arch/arm64/include/asm/kvm_rme.h
> index f786fd978cf6..09cbb61816f3 100644
> --- a/arch/arm64/include/asm/kvm_rme.h
> +++ b/arch/arm64/include/asm/kvm_rme.h
> @@ -94,6 +94,8 @@ void kvm_init_rme(void);
>   u32 kvm_realm_ipa_limit(void);
>   u32 kvm_realm_vgic_nr_lr(void);
>   
> +u64 kvm_realm_reset_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu, u64 val);
> +
>   bool kvm_rme_supports_sve(void);
>   
>   int kvm_realm_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap);
> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
> index 297b13ef1729..0c358ce0a7a1 100644
> --- a/arch/arm64/kvm/rme.c
> +++ b/arch/arm64/kvm/rme.c
> @@ -87,6 +87,28 @@ u32 kvm_realm_vgic_nr_lr(void)
>   	return u64_get_bits(rmm_feat_reg0, RMI_FEATURE_REGISTER_0_GICV3_NUM_LRS);
>   }
>   
> +u64 kvm_realm_reset_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu, u64 val)
> +{
> +	u32 bps = u64_get_bits(rmm_feat_reg0, RMI_FEATURE_REGISTER_0_NUM_BPS);
> +	u32 wps = u64_get_bits(rmm_feat_reg0, RMI_FEATURE_REGISTER_0_NUM_WPS);
> +	u32 ctx_cmps;
> +
> +	if (!kvm_is_realm(vcpu->kvm))
> +		return val;
> +
> +	/* Ensure CTX_CMPs is still valid */
> +	ctx_cmps = FIELD_GET(ID_AA64DFR0_EL1_CTX_CMPs, val);
> +	ctx_cmps = min(bps, ctx_cmps);
> +
> +	val &= ~(ID_AA64DFR0_EL1_BRPs_MASK | ID_AA64DFR0_EL1_WRPs_MASK |
> +		 ID_AA64DFR0_EL1_CTX_CMPs);
> +	val |= FIELD_PREP(ID_AA64DFR0_EL1_BRPs_MASK, bps) |
> +	       FIELD_PREP(ID_AA64DFR0_EL1_WRPs_MASK, wps) |
> +	       FIELD_PREP(ID_AA64DFR0_EL1_CTX_CMPs, ctx_cmps);
> +
> +	return val;
> +}
> +
>   static int get_start_level(struct realm *realm)
>   {
>   	return 4 - ((realm->ia_bits - 8) / (RMM_PAGE_SHIFT - 3));
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index de7fe024dbff..36e22ed84e7e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1844,7 +1844,7 @@ static u64 sanitise_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu, u64 val)
>   	/* Hide BRBE from guests */
>   	val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
>   
> -	return val;
> +	return kvm_realm_reset_id_aa64dfr0_el1(vcpu, val);
>   }
>   
>   static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,


