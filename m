Return-Path: <linux-kernel+bounces-865723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E4BBFDDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB2A3A723E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5684434B18F;
	Wed, 22 Oct 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hb5AGfw5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E62D77ED
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157928; cv=none; b=R7XbeiZtE+OCoYvFcy/rfgkT50TKjdMtgmFHFdOg8mwAQQYiX0S2R0LmdQBiiqW7tyZg4F/DAOMTctZ9TDkg3WTks1+VqsdagPiF/wnvEghYeCG6pIudQ6UKz7YbTb8YodgLgqTuzLtU0blfHkVoVe5bIm8xSZOuAZtvTrkWk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157928; c=relaxed/simple;
	bh=8QxdwBViXoiu7Po4tADJmy21C5mhOXMcHk8DM4i0mfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xqz34KFhGs8g/PlC7suF106jgsOUBImuXmiJ3HvuT6h3ibIANjQz7GfzLq9QduND7BhufT8H7ELr1gJkGEOWU0f8VwZfbhm3Ip8YzLLRdj6OqSI/p5hWhKgJHh08ldcqP9nubYQv9asfI3dR4H4MUo8W47/qv0URFTcp4Nz/2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hb5AGfw5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761157925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C/JbIxWbVPjgjOtLlLqeo5HXZLCpenJC/fAvBvHGrhY=;
	b=Hb5AGfw5w5UOrh3FFdONJ/L9RiOVb+yEcgOahTHPeRrcPrF4iu4l3GKEoXRVqtUpPZcqwx
	mqKnIA8mbnNer9gQLFpaVRq/SE+Tw4k1yxcvv5HT06+SRm07EhlnuA+tmHa+BpJB0GmAwd
	KgLuBSKx+0HNBNAF60i6J5EdaZYz+9A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-eRvrNP3NOnm8MwY685Jhaw-1; Wed, 22 Oct 2025 14:32:04 -0400
X-MC-Unique: eRvrNP3NOnm8MwY685Jhaw-1
X-Mimecast-MFC-AGG-ID: eRvrNP3NOnm8MwY685Jhaw_1761157923
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471148ad64aso30639055e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761157923; x=1761762723;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/JbIxWbVPjgjOtLlLqeo5HXZLCpenJC/fAvBvHGrhY=;
        b=DtmkNGE1gC1Ez/HKw6UVrO2aRn5Ae2uYsOm+zbBCFdNGsI8eCkmXSd4sJJNlLZ/72H
         3xtv+J+LiDZE6jqDuU/ebkmSR3Caxbo9eEcDNuWFxIbjnA1nzaMBI/l78Yqcyh1Zn4ay
         s7cBsvHkOS8FnTR73NimdOaAo4kCMRhFre/pkYm4j+zW15p2EqhA4yslM1Oz70LlwxbE
         R4fV+/juPMS1hU5dX97CwMIt8mfAZCFD+tQ8kx7L4+vQ8lJbbzpAFQuFiWh+3Swe/0R7
         rR6jWAxoe8zdjl+dm0tPSf3Vfwd4PcQdZ6WCkG+GZiKCRbPMct2wjX0LqYsvdZsOg/LG
         bAXA==
X-Forwarded-Encrypted: i=1; AJvYcCUraB0EvRNxBzHiJAYq6ZjuEscbF1o7Fm2wp54xr8V8AY7IGjdXBuyQZwFB5vEBOuld7FPeGvhK/wDt9i4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywig7MMRXvOabMz1dceiz4nS+y0o8a/0BrIBFRx+hHDajzmvSOq
	8QC0lISH8+GkbBwvJ30SkIZ6PsyujaK6rX7w8pPtx/dKRMP4u9rb4YatKo6xHKvcwOiscVoHtdD
	rPu/2Wzp7cRMs+gi3QKqgQbkztI4bBmonC9imPOG+qIb8whQgcQVpg/yAEIbXKu/aMg==
X-Gm-Gg: ASbGncskhjEvyXaM2zBD1rwQLDmUWYaxvAVwzJhS77XPORc4iDxNcCtVugZUeqysSt4
	aDUnz37uD6voM3J1uYREUSeMcK1zvHn2KGUd9IV+PfATn9FdZe0rs6zPonNqQVBh7+5l0X2o2Ug
	G/Tu46TYqNXtXui3EHM/fRez3W6xbi6KWW0IECbW/7jRsbeqVPrDDFOcCftANVqn9v3fRtBxtyA
	5dBcirMpREhvtT4G3GBheJ9aIoy99rL6P46f+uECLfhDm3WSxeRIIVluc/19Y6C3osG7EYUYCGh
	nmA5zP6wjQeRFHUKDWBSj0gHfJ0EJIr2/mwo9iZI61M5W7Bv92sjkUxgShiCaLhmGakHVEhhDVF
	fA9/mRC0NJFcbFisW2vvlU5jUvjHjZeBstGrQ6JU1pVnacshS2I9g9ffwpWZyvbjfrG1FidX0d6
	FRvEPDbDgi4szzQ3KRQ3xd/CZgO+0=
X-Received: by 2002:a05:600c:4e89:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-471178a236cmr148583375e9.10.1761157923148;
        Wed, 22 Oct 2025 11:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkqa/ppk8VcHZoDFi34/v5kHVDgvIPPynsre7cySVOZE5NngxycVOpUfHTE5B9ULebelTd5A==
X-Received: by 2002:a05:600c:4e89:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-471178a236cmr148583005e9.10.1761157922599;
        Wed, 22 Oct 2025 11:32:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-428566a7906sm3527685f8f.38.2025.10.22.11.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:32:01 -0700 (PDT)
Message-ID: <8537a80c-bc8f-4b2e-aba0-c7f8f1c437f9@redhat.com>
Date: Wed, 22 Oct 2025 20:31:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/8] x86/mm: Use 'ptdesc' when freeing PMD pages
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
 <20251022082635.2462433-5-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251022082635.2462433-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 10:26, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> There are a billion ways to refer to a physical memory address.
> One of the x86 PMD freeing code location chooses to use a 'pte_t *' to
> point to a PMD page and then call a PTE-specific freeing function for
> it.  That's a bit wonky.
> 
> Just use a 'struct ptdesc *' instead. Its entire purpose is to refer
> to page table pages. It also means being able to remove an explicit
> cast.
> 
> Right now, pte_free_kernel() is a one-liner that calls
> pagetable_dtor_free(). Effectively, all this patch does is
> remove one superfluous __pa(__va(paddr)) conversion and then
> call pagetable_dtor_free() directly instead of through a helper.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


