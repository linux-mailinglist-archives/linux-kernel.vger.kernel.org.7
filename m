Return-Path: <linux-kernel+bounces-743571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6BCB1005D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DD95638CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D0A2066CE;
	Thu, 24 Jul 2025 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egbZnqQk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D319A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337085; cv=none; b=B2oeArxRFLBeRXsjpl1APdLdCiMPgA134T5rEuwmPPF7ljvXLXjPvAyf8/UAKrMoYrVV95tIrhvEAoYblbVZb+26B8fAiClNYQOLKxnO0+PSYs4IyTcETgbgwBPpkN5af8iMG8KjCCo+ch6A9Aq+xwdFGb6p46dng06DvaeEo2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337085; c=relaxed/simple;
	bh=kGyBdpfPNd78QntgJMgptPE/2hD8RBYiBmsv2J9+sA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ez1EeBAGvCdwvu3xJtmF4szMOUk88NMdkbju1WDM6SBmvvEgEEZGXS0ECGXR+6o+a6UtXjNjMzDOkTdSTX9ZTfT8nfdpX0o43Pz4965c/Bp0ZSUlCtKF7u1u83srXlV4X6Lg1bzoC3UhMO+D/5xEeevSBJBcCeLoJYXJyB5ztoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egbZnqQk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753337082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccZ81ZlUeeRi2wfgmebHDybZVstxHsPhDJfQob29cPM=;
	b=egbZnqQk+72aK+TSsyEABdGgfIExw3gJDl4VO6u70M87TT4zBWcpMSin2/0nNB8Kt9DUnl
	iWnZsM7aEgvpIRWfoBKBrHX0D0aFirnoXXV7cxqY8NpPKJUGyQslPKWZNfocd9omt9S9eb
	Sp8Kr1E5RhC2X0fI6O9vb5ob17cFWw0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-s9yQcZcwPVeT0Y_gXdSlpw-1; Thu, 24 Jul 2025 02:04:40 -0400
X-MC-Unique: s9yQcZcwPVeT0Y_gXdSlpw-1
X-Mimecast-MFC-AGG-ID: s9yQcZcwPVeT0Y_gXdSlpw_1753337079
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-553decb7e3cso337781e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753337079; x=1753941879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccZ81ZlUeeRi2wfgmebHDybZVstxHsPhDJfQob29cPM=;
        b=eAG25hwRRgvVtxE8HOqGM1NSwtDAQgbvK7SyTcw1cd6UejEcbe6UxWil/bh4Qs81ue
         UmXgaSTh89RRwkEzDz9QlTVhgrucXfwhXZ4MWst0cpxmPlo31Ov+PfF0Iffdgdpk9BGS
         vvWmsvv+PA60BamBrl7SflKK3z/WJrCAXyNCn6Yd8NQ6x6vp/vKysC8dbJCUx8jdgnuE
         jHwHDlR/UCXTsN/Qj/SUcTWGSuTtDvycmOVvDET+P7jBPpBDMmi8KhAA0IeeM2F6oVZ2
         ikylOPSgfFLkwJAOb94wfZAdfzzh9ch8r+W5JvE0h0AgNZPZf435B2UJE+LT8SkOBwGq
         dN9w==
X-Forwarded-Encrypted: i=1; AJvYcCWZewMbttmJ8BLDf9iUTwuh4umnj6KiKkDPRPGlf5panQd+OV2LfsTozr4cZdVXaweg6WyrpZC98K7WO+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjhGRGcD40sB75YS3HhCa00y2FdKAtJWXs8fY+AZMj9zb0sXX
	4dq/T2jJFemtDrf6LgR2HhbHYCsdC2uk8d1YpKZLsBtgO0zukL1fkppgcwlaKmLFXdFNPwhqAAv
	adm8kH9mksNvKwYM1tPArP2ttMajRBkdX1Xv90+QdTRG3DuQcGgZCb+3/9ZsimpBP
X-Gm-Gg: ASbGncsDXSMv+1vx2MD6AZnnC/E3rAwvZJd9qlfmfw3WakFcuuvgtC1g0EoDPiB3ClX
	kh5igVoYG6oWH4uXkWkhWcBPpKkUm9TxDtHWJGHatRQPBLrDvXIDjH3l6ilLb6OD59VBX9GUm9s
	3bjFWFBj1f/h7g1bxtZouyT7wBIvykwB37DdG0OSbt54wDCki4i43HyGTe08lhIwDp8lwtuhRRf
	iXt27Iryxkb2ScJCu/PisFY5Iq9R2H4v0n8Tfejy4X1TAYj92isNHoOoPHO94rm3j4F4dVtUEFP
	glSMO7kGfUeCayWmX8ho/INXdwS8ds5eDWoaXrkq4JJp6foWEbmIrWL2NVTqhFn7gA==
X-Received: by 2002:a05:6512:2208:b0:554:fa07:c60 with SMTP id 2adb3069b0e04-55a513c213amr1911784e87.34.1753337078494;
        Wed, 23 Jul 2025 23:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnCw/KB+3dIXEoU6waww4AHDaUQMrgUdTBjRzH+fX3UUbcMIPvjmX7Jt0OS1gjnbZ536mDdQ==
X-Received: by 2002:a05:6512:2208:b0:554:fa07:c60 with SMTP id 2adb3069b0e04-55a513c213amr1911766e87.34.1753337077998;
        Wed, 23 Jul 2025 23:04:37 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53b22ea7sm192788e87.43.2025.07.23.23.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 23:04:37 -0700 (PDT)
Message-ID: <368fa1c1-fccc-445d-bd22-0053fd2db29c@redhat.com>
Date: Thu, 24 Jul 2025 09:04:36 +0300
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
 <dad71615-0eba-4a8d-abfc-979fb815511c@redhat.com>
 <aIHLWnjzKWma1NLC@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <aIHLWnjzKWma1NLC@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/24/25 08:57, Matthew Brost wrote:
> On Thu, Jul 24, 2025 at 08:46:11AM +0300, Mika Penttilä wrote:
>> On 7/24/25 08:02, Matthew Brost wrote:
>>> On Thu, Jul 24, 2025 at 10:25:11AM +1000, Balbir Singh wrote:
>>>> On 7/23/25 05:34, Francois Dugast wrote:
>>>>> When the PMD swap entry is device private and owned by the caller,
>>>>> skip the range faulting and instead just set the correct HMM PFNs.
>>>>> This is similar to the logic for PTEs in hmm_vma_handle_pte().
>>>>>
>>>>> For now, each hmm_pfns[i] entry is populated as it is currently done
>>>>> in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
>>>>> optimization could be to make use of the order and skip populating
>>>>> subsequent PFNs.
>>>> I think we should test and remove these now
>>>>
>>> +Jason, Leon – perhaps either of you can provide insight into why
>>> hmm_vma_handle_pmd fully populates the HMM PFNs when a higher-order page
>>> is found.
>>>
>>> If we can be assured that changing this won’t break other parts of the
>>> kernel, I agree it should be removed. A snippet of documentation should
>>> also be added indicating that when higher-order PFNs are found,
>>> subsequent PFNs within the range will remain unpopulated. I can verify
>>> that GPU SVM works just fine without these PFNs being populated.
>> afaics the device can consume the range as smaller pages also, and some
>> hmm users depend on that.
>>
> Sure, but I think that should be fixed in the device code. If a
> large-order PFN is found, the subsequent PFNs can clearly be inferred.
> It's a micro-optimization here, but devices or callers capable of
> handling this properly shouldn't force a hacky, less optimal behavior on
> core code. If anything relies on the current behavior, we should fix it
> and ensure correctness.

Yes sure device code can be changed but meant to say we can't just
delete those lines without breaking existing users.


>
> Matt


--Mika


>
>>> Matt
>>
>> --Mika
>>
>>
>>>>> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
>>>>> ---
>>>>>  mm/hmm.c | 25 +++++++++++++++++++++++++
>>>>>  1 file changed, 25 insertions(+)
>>>>>
>>>>> diff --git a/mm/hmm.c b/mm/hmm.c
>>>>> index f2415b4b2cdd..63ec1b18a656 100644
>>>>> --- a/mm/hmm.c
>>>>> +++ b/mm/hmm.c
>>>>> @@ -355,6 +355,31 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>>>>>  	}
>>>>>  
>>>>>  	if (!pmd_present(pmd)) {
>>>>> +		swp_entry_t entry = pmd_to_swp_entry(pmd);
>>>>> +
>>>>> +		/*
>>>>> +		 * Don't fault in device private pages owned by the caller,
>>>>> +		 * just report the PFNs.
>>>>> +		 */
>>>>> +		if (is_device_private_entry(entry) &&
>>>>> +		    pfn_swap_entry_folio(entry)->pgmap->owner ==
>>>>> +		    range->dev_private_owner) {
>>>>> +			unsigned long cpu_flags = HMM_PFN_VALID |
>>>>> +				hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
>>>>> +			unsigned long pfn = swp_offset_pfn(entry);
>>>>> +			unsigned long i;
>>>>> +
>>>>> +			if (is_writable_device_private_entry(entry))
>>>>> +				cpu_flags |= HMM_PFN_WRITE;
>>>>> +
>>>>> +			for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
>>>>> +				hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
>>>>> +				hmm_pfns[i] |= pfn | cpu_flags;
>>>>> +			}
>>>>> +
>>>> As discussed, can we remove these.
>>>>
>>>>> +			return 0;
>>>>> +		}
>>>> All of this be under CONFIG_ARCH_ENABLE_THP_MIGRATION
>>>>
>>>>> +
>>>>>  		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
>>>>>  			return -EFAULT;
>>>>>  		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
>>>>
>>>> Balbir Singh


