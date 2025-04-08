Return-Path: <linux-kernel+bounces-593094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05953A7F520
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 08:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624BF3B21D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 06:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8AF25F976;
	Tue,  8 Apr 2025 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAvhgW3N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF11CD15
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744094357; cv=none; b=lHdFhTZc5cnkjsAsEr4njHiQlnHHJ3A6nP03Ueb64ala21EAuwVPDDJmxl5/kJr5xPWeaL5xUNJtHYXJqGokkhAFnkloH3slhD7IBZagfyRGdP/wtJY3zd80liOVDbElEmQHX7rLYn3E+BX141xHaBTw4RfNmq+QG0xpsbEz614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744094357; c=relaxed/simple;
	bh=QImjOwZmHFIglPjEksFrg4C+14Ff/Y7CUPgguEl5tWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kt7fVNPdx0cT9O8yMQVrmupGLL1xa3UQOY0I3PqdN1HuwuU30L3lFGH9QUzh5oc//e3zcAoAueJssIHmm9QMV/uE7QuWym6EKx11HaDxM9FkKN12M+opgBtPDVIxcWq7uEtoWptOMqCd3z1Zj7wPMZNUkuEN29K5Fh0UZQzPygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAvhgW3N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744094354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo+vNBz6jEsiKjb63zXVQ6UhZa9LQg13RIyxKH2Wp2U=;
	b=cAvhgW3NPcK+I51CEnAIUQVzMhXbsaTT1HL5TIZHT3lFcHSdY1Vg5sdpfZ04/CgydnVZRL
	oMTY0dZAT8sJP5BmDhikpCzVlJ0qF2fk0ne3WfFjSQinyrnrYfwEcXwWCdls8wTk4YyQVs
	fye4YUetTUOOIm1ISkygo/MAOKFBL1c=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-7Kst784vO7qpmLkmkrFLUw-1; Tue, 08 Apr 2025 02:39:13 -0400
X-MC-Unique: 7Kst784vO7qpmLkmkrFLUw-1
X-Mimecast-MFC-AGG-ID: 7Kst784vO7qpmLkmkrFLUw_1744094352
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso7380830b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 23:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744094352; x=1744699152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oo+vNBz6jEsiKjb63zXVQ6UhZa9LQg13RIyxKH2Wp2U=;
        b=byvYBYy2t1cgC6YVC5D6C9RSwSmcZNp15UK43cCKMvgmg6lD9qxOmzbZbivM/ltasG
         pdCDZeV1AZiKaVSeftngCxNExNOReI0D6CtBavp0YuFv2adhytlDCDig2GKwKk2rMHzn
         VjQ6Y4vLWeEyD2slO6pZ4tQlB1R3cH0gTeOd0rVagYeAgzZ8mOi5qdZ/A+3oas0bICA5
         2lBgEIAgjcx+zwliLTcY24Qvr/O+vWVWXMJ6l5zexqhqEAewjcETXvuacwxH4kZj3g64
         teYKNqtwRIUfe/ly0E47tX+tbg6SM4hCFs9vmMNH3Vl6BuGoBpXsU9yMHJs7a53uF8In
         dIEw==
X-Forwarded-Encrypted: i=1; AJvYcCUNRvNUufEiElUkci6V/agn+y2wsIMLi+R1v8d6c2DfDH/P/2kgmMmCc4dxN8RPaooCtMVsKnmGZD4+Jso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GlijXIaakra//8bHOWpkmJBZo7LezI0UCoHVTYUtVNtOkuQ3
	W1wekF1hIRrCBnglY+Ci+Rh5oUUXCP5lALgau3AB6IpjhaxmgVMbebgOzJU4qOl2KTsIhJsXrGK
	Kw+WqTIV5M6sJKHMKbzAp67RAnhJHVz2nxzjB59sJ3cqTLDzr9EdXIxSUPeRCow==
X-Gm-Gg: ASbGncsLPa3AyiA3kvj6sUcy4kVrMR5nWfnoZ6tGbJkRFuLE1IDiGsRxo8wsueNa8C0
	0hHXZG3g88uWna7C/aQvvL18jqrQMGUtmiDX6CxgNHPXQTi0NatwOXtb9Md4JToYwd9biUaQIFV
	bLuCYoayoazTuUMrJHtSLaAvQEuXB1HzU9WODv/tJYW8LJ3GQpzq3MG+jBGRNwqV0S3k0EdLr+q
	S3q4NjPp7DAojpuCWfR+9yQipsefB5Hkm/EUNBkAq1ftH/kR++i2NqZr7LotPM+Gv1Cj7Lv+7Sh
	7wNaDmlECAjfc9jq
X-Received: by 2002:a05:6a00:2393:b0:736:52d7:daca with SMTP id d2e1a72fcca58-73b6b8c3084mr14619976b3a.18.1744094352230;
        Mon, 07 Apr 2025 23:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCluDWzP6aX2PyZk9at9nI1CqMZ/cLW37DfwKCDqyszydjKUwNSMY0//3epUtYWIjDAxF0tw==
X-Received: by 2002:a05:6a00:2393:b0:736:52d7:daca with SMTP id d2e1a72fcca58-73b6b8c3084mr14619954b3a.18.1744094351805;
        Mon, 07 Apr 2025 23:39:11 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea15d6sm9712319b3a.89.2025.04.07.23.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 23:39:11 -0700 (PDT)
Message-ID: <cda1db80-4b4d-471f-87f0-d978278a4b6c@redhat.com>
Date: Tue, 8 Apr 2025 16:39:02 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 35/45] arm64: RME: Propagate number of breakpoints and
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
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-36-steven.price@arm.com>
 <c8af8a7f-5ee4-460b-aec4-959f688db628@redhat.com>
 <adbca476-7d0f-473d-a2a2-0a29a497dbca@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <adbca476-7d0f-473d-a2a2-0a29a497dbca@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/25 2:35 AM, Steven Price wrote:
> On 04/03/2025 23:45, Gavin Shan wrote:
>> On 2/14/25 2:14 AM, Steven Price wrote:
>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>
>>> The RMM describes the maximum number of BPs/WPs available to the guest
>>> in the Feature Register 0. Propagate those numbers into ID_AA64DFR0_EL1,
>>> which is visible to userspace. A VMM needs this information in order to
>>> set up realm parameters.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>>    arch/arm64/include/asm/kvm_rme.h |  2 ++
>>>    arch/arm64/kvm/rme.c             | 22 ++++++++++++++++++++++
>>>    arch/arm64/kvm/sys_regs.c        |  2 +-
>>>    3 files changed, 25 insertions(+), 1 deletion(-)
>>>
>>
>> With the following one nitpick addressed:
>>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>
>>> diff --git a/arch/arm64/include/asm/kvm_rme.h b/arch/arm64/include/
>>> asm/kvm_rme.h
>>> index d684b30493f5..67ee38541a82 100644
>>> --- a/arch/arm64/include/asm/kvm_rme.h
>>> +++ b/arch/arm64/include/asm/kvm_rme.h
>>> @@ -85,6 +85,8 @@ void kvm_init_rme(void);
>>>    u32 kvm_realm_ipa_limit(void);
>>>    u32 kvm_realm_vgic_nr_lr(void);
>>>    +u64 kvm_realm_reset_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu,
>>> u64 val);
>>> +
>>>    bool kvm_rme_supports_sve(void);
>>>      int kvm_realm_enable_cap(struct kvm *kvm, struct kvm_enable_cap
>>> *cap);
>>> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
>>> index f83f34358832..8c426f575728 100644
>>> --- a/arch/arm64/kvm/rme.c
>>> +++ b/arch/arm64/kvm/rme.c
>>> @@ -87,6 +87,28 @@ u32 kvm_realm_vgic_nr_lr(void)
>>>        return u64_get_bits(rmm_feat_reg0,
>>> RMI_FEATURE_REGISTER_0_GICV3_NUM_LRS);
>>>    }
>>>    +u64 kvm_realm_reset_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu,
>>> u64 val)
>>> +{
>>> +    u32 bps = u64_get_bits(rmm_feat_reg0,
>>> RMI_FEATURE_REGISTER_0_NUM_BPS);
>>> +    u32 wps = u64_get_bits(rmm_feat_reg0,
>>> RMI_FEATURE_REGISTER_0_NUM_WPS);
>>> +    u32 ctx_cmps;
>>> +
>>> +    if (!kvm_is_realm(vcpu->kvm))
>>> +        return val;
>>> +
>>> +    /* Ensure CTX_CMPs is still valid */
>>> +    ctx_cmps = FIELD_GET(ID_AA64DFR0_EL1_CTX_CMPs, val);
>>> +    ctx_cmps = min(bps, ctx_cmps);
>>> +
>>> +    val &= ~(ID_AA64DFR0_EL1_BRPs_MASK | ID_AA64DFR0_EL1_WRPs_MASK |
>>> +         ID_AA64DFR0_EL1_CTX_CMPs);
>>> +    val |= FIELD_PREP(ID_AA64DFR0_EL1_BRPs_MASK, bps) |
>>> +           FIELD_PREP(ID_AA64DFR0_EL1_WRPs_MASK, wps) |
>>> +           FIELD_PREP(ID_AA64DFR0_EL1_CTX_CMPs, ctx_cmps);
>>> +
>>> +    return val;
>>> +}
>>> +
>>
>> The chunk of code can be squeezed to
>> sys_reg.c::sanitise_id_aa64dfr0_el1() since
>> sys_reg.c has been plumbed for realm, no reason to keep a separate
>> helper in rme.c
>> because it's only called by sys_reg.c::sanitise_id_aa64dfr0_el1()
> 
> The issue here is the rmm_feat_reg0 variable - it's currently static in
> rme.c - so I can't just shift the code over. I could obviously provide
> helpers to get the necessary information but this seemed cleaner.
> 

Ack.

Thanks,
Gavin

> Thanks,
> Steve
> 
>>>    static int get_start_level(struct realm *realm)
>>>    {
>>>        return 4 - ((realm->ia_bits - 8) / (RMM_PAGE_SHIFT - 3));
>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>> index ed881725eb64..5618eff33155 100644
>>> --- a/arch/arm64/kvm/sys_regs.c
>>> +++ b/arch/arm64/kvm/sys_regs.c
>>> @@ -1820,7 +1820,7 @@ static u64 sanitise_id_aa64dfr0_el1(const struct
>>> kvm_vcpu *vcpu, u64 val)
>>>        /* Hide BRBE from guests */
>>>        val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
>>>    -    return val;
>>> +    return kvm_realm_reset_id_aa64dfr0_el1(vcpu, val);
>>>    }
>>>      static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,



