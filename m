Return-Path: <linux-kernel+bounces-743553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08505B1000B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D2B5636C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F491FECAD;
	Thu, 24 Jul 2025 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqOUL2hD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1C1DE3A7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753335979; cv=none; b=G8PWQPGUnLTM0ipk6D8pSBiS5oOf1lRPRaX8AoHwmtKFYS1p732XuCR974RZQw3Ehgs/kxl4lH4mrB5UICcHOtVM8sxzkRxJjV3z3uDUILnOun2+EG9drWUBA5YyakcWqXtX3so5zfRFAbieP2dVEaxky1bJiVuJE/u+69WCupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753335979; c=relaxed/simple;
	bh=w4mAklSUdtqMOVviA7Xs5UAei140JAx5BfouknGITpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/MlIEJY4sdOy3eL4J1bcnZb18JQi4a8Na+Pml/+CD9LoPLRzH92XUjsvFPfjSQmlsb04OArZSSoa1Go32awr0ztkBiQrEtpDnVQ7DDkEwPIbFyZ+HFzSEDIP1eXKkdNhC/w451o6ZIGkI2W+pV4svKhql+1uqHTwtEH0w++qMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqOUL2hD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753335976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNwMJnsrlfjHIfnx8+XyAkalOotEMNE2AFm+hZ9zED0=;
	b=TqOUL2hDgTvnTTQe5ytDiFgeebI/Lm9oG6zO2gYOrr3kCI8Zs+hbOXQ9PnaD+6eJZzats3
	Cc4xa6RoaZ1ZnBuLYspqDbA18QPf8RupqeuBwNbZBTHz5wt+cGdmc5YJ00D1gmCCRxBTKa
	Hc9EgENLUX8XU+iX6kBuicx5MB4UWyk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-S5fj5wHbPGOv5ehrB155oQ-1; Thu, 24 Jul 2025 01:46:14 -0400
X-MC-Unique: S5fj5wHbPGOv5ehrB155oQ-1
X-Mimecast-MFC-AGG-ID: S5fj5wHbPGOv5ehrB155oQ_1753335973
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32b41b99f33so2043541fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753335973; x=1753940773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNwMJnsrlfjHIfnx8+XyAkalOotEMNE2AFm+hZ9zED0=;
        b=FXVdB4nHFKphIiVpk3D1Iyt4qn94ap/1Az1fg2h/Dz+Yj36NGp6w6h+blgo8iZgRjf
         4oBBA99Ll8jvNW9pqRvUpYAjsfJud3n3W8F62DSuqFXt8lDXgajNya6bQbPvt5clnHhK
         XVfNpUBm5RU9EajuGiUVx4EmbQ6fNFkHwu72CJ2oOec9/SPkEx5LzdqS/e06JJwFP9xA
         YaLWI74EWTQf+yqwfWNMT4hLGhLfvDXMenXoRDYWHMDNH6S9y0dOBGpgC2WLKAU/uLtk
         VXZG2Yq8niuTgiB/hV85xMvpanHzeo0kf4DdE+7H4gfLSJ2E917DSPoPFzCaB3RgPPDN
         y/6w==
X-Forwarded-Encrypted: i=1; AJvYcCWPxFJp8d6iCqM/vfJNtVKelQSUpmN9z1IxyVDmTO9XI1sU81IrV3EJ15hGOKUNXi9hQ4VTDUoDEZ23pvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICvvj+9EsWOV1R1jPVYLWM/cnnXC+BBTcpf9iE2IwqL3kfCaM
	NQS685UBZneuRLY8UFK/9/z2uxQrWxLsCbFoZnAEmdtDOxvEXUylL6zeFOQpNxS+dy2degkaSxJ
	jYeDqsE13fdM9+vIDpYaVNCRBJyyUYkzzaXl0n/ahIrnT4ooP/7+XKbWTyHhvZE0Y
X-Gm-Gg: ASbGncuz7Uh6bW3iHvjoy3PbdVIwAHM9w6Cm2slXCrMwkTic7EVpiTFiFvkBfRMYwN8
	IkPnZ7tEVYDYldMbbFlc9F+o7Nt5Dlyl+WCBr8pJDd5K4J0hZzrgYP8Eg7Rdz75zlcQdqt5w07f
	/2LEEsnaMM0VdcvOG2RrkN+atcNBzsBQ7Rz5BQ8XoJ0Rs0OtqVJ6pF57NU0vqy+co91WPwOdAsf
	05bD5UD1CzJ61Av7d9XCA6tPydoV8riWaScTltF5YZdOlRCqYxSTAq0QCCgqdMd84C4Bu4+FAM8
	zJMWJmteLiennux57znmbYtfnv43fiRvg2jhYqIH/KbizYqFX9eg70oyjr3xG+pQrA==
X-Received: by 2002:a2e:b88f:0:b0:32b:a7d2:a8b1 with SMTP id 38308e7fff4ca-330dfcf9563mr17781731fa.12.1753335973029;
        Wed, 23 Jul 2025 22:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVuWN3kjiXBLdFUiaycJpmnxFsCty+fYD0fmCcRFhmov/er61nqrT1/bUmvuEMXStaMCRkdw==
X-Received: by 2002:a2e:b88f:0:b0:32b:a7d2:a8b1 with SMTP id 38308e7fff4ca-330dfcf9563mr17781521fa.12.1753335972491;
        Wed, 23 Jul 2025 22:46:12 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331e079336bsm1708151fa.32.2025.07.23.22.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 22:46:12 -0700 (PDT)
Message-ID: <dad71615-0eba-4a8d-abfc-979fb815511c@redhat.com>
Date: Thu, 24 Jul 2025 08:46:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hmm: Do not fault in device private pages owned by the
 caller
To: Matthew Brost <matthew.brost@intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>, airlied@gmail.com,
 akpm@linux-foundation.org, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dakr@kernel.org, david@redhat.com,
 donettom@linux.ibm.com, jane.chu@oracle.com, jglisse@redhat.com,
 kherbst@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lyude@redhat.com, peterx@redhat.com, ryan.roberts@arm.com, shuah@kernel.org,
 simona@ffwll.ch, wangkefeng.wang@huawei.com, willy@infradead.org,
 ziy@nvidia.com, Balbir Singh <balbirs@nvidia.com>, jgg@nvidia.com,
 Leon Romanovsky <leonro@nvidia.com>
References: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
 <20250722193445.1588348-1-francois.dugast@intel.com>
 <023ab16d-f3af-487e-a7ce-929bf7b2fe3e@nvidia.com>
 <aIG+gqY2YRqBeKlh@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <aIG+gqY2YRqBeKlh@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/24/25 08:02, Matthew Brost wrote:
> On Thu, Jul 24, 2025 at 10:25:11AM +1000, Balbir Singh wrote:
>> On 7/23/25 05:34, Francois Dugast wrote:
>>> When the PMD swap entry is device private and owned by the caller,
>>> skip the range faulting and instead just set the correct HMM PFNs.
>>> This is similar to the logic for PTEs in hmm_vma_handle_pte().
>>>
>>> For now, each hmm_pfns[i] entry is populated as it is currently done
>>> in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
>>> optimization could be to make use of the order and skip populating
>>> subsequent PFNs.
>> I think we should test and remove these now
>>
> +Jason, Leon – perhaps either of you can provide insight into why
> hmm_vma_handle_pmd fully populates the HMM PFNs when a higher-order page
> is found.
>
> If we can be assured that changing this won’t break other parts of the
> kernel, I agree it should be removed. A snippet of documentation should
> also be added indicating that when higher-order PFNs are found,
> subsequent PFNs within the range will remain unpopulated. I can verify
> that GPU SVM works just fine without these PFNs being populated.

afaics the device can consume the range as smaller pages also, and some
hmm users depend on that.


> Matt


--Mika


>
>>> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
>>> ---
>>>  mm/hmm.c | 25 +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/mm/hmm.c b/mm/hmm.c
>>> index f2415b4b2cdd..63ec1b18a656 100644
>>> --- a/mm/hmm.c
>>> +++ b/mm/hmm.c
>>> @@ -355,6 +355,31 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>>>  	}
>>>  
>>>  	if (!pmd_present(pmd)) {
>>> +		swp_entry_t entry = pmd_to_swp_entry(pmd);
>>> +
>>> +		/*
>>> +		 * Don't fault in device private pages owned by the caller,
>>> +		 * just report the PFNs.
>>> +		 */
>>> +		if (is_device_private_entry(entry) &&
>>> +		    pfn_swap_entry_folio(entry)->pgmap->owner ==
>>> +		    range->dev_private_owner) {
>>> +			unsigned long cpu_flags = HMM_PFN_VALID |
>>> +				hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
>>> +			unsigned long pfn = swp_offset_pfn(entry);
>>> +			unsigned long i;
>>> +
>>> +			if (is_writable_device_private_entry(entry))
>>> +				cpu_flags |= HMM_PFN_WRITE;
>>> +
>>> +			for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
>>> +				hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
>>> +				hmm_pfns[i] |= pfn | cpu_flags;
>>> +			}
>>> +
>> As discussed, can we remove these.
>>
>>> +			return 0;
>>> +		}
>> All of this be under CONFIG_ARCH_ENABLE_THP_MIGRATION
>>
>>> +
>>>  		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
>>>  			return -EFAULT;
>>>  		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
>>
>>
>> Balbir Singh


