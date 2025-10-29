Return-Path: <linux-kernel+bounces-875667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9905C198FE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12AE6502EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56822D594F;
	Wed, 29 Oct 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl6nJXM+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33F2C3274
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732022; cv=none; b=Dwc8pFeAF0E3o4L6bMvleCWjqu06GO9YiO6ZqPwWJOPhW/gpd5XAPpAHhYkDPFzNm2IerkIFr5Bis+LQwic4T4CFz09lExvYYNwsIrkSHsGNFc1kNb8h8lEr16PD0ZgTwl/2b1B+CuniJ8nMgbszGKEKm0MpsRKlN7r3p9DQJ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732022; c=relaxed/simple;
	bh=SKZe0CVlQ/p+I/GhlcWTfXycD/+oUUOcjJrYGg72xyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkXNlfM7ifjG8+sDOiFRaviNoATOPzxGf29lMMIlIYnoQJSPTk5OLLFIyn35Q1b5naDpne4LFQ0KObqfGwVdIBNbfkcn2Nlln5bRRoCjzAvzrTuCgizzAEzfTRYdJDQ3hZ8rxUVP0iV25SbkvHACuEiVtVxYy0UtcgJMPV8RliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bl6nJXM+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761732020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hEtH/DOi8ufPul8rQIFdoeVO4A7KFJe7+IrA/7Qq9Tk=;
	b=Bl6nJXM+2Bt0zK3cy5OzjYqWxx9/97RvTYbUdHAaFxcYXoV4o6Ln5LpX6TjaNBiYhM7nhs
	ZVfWPsAi1Xpc91lkNLD6aqsyCA1mDYGZ3oEpOXcann4daFp9LX3vTj4Glj0Sk9y+CwpbQx
	CYXuHDaA5RJFdsGhVOGSZbVwlP1EaUI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-wRt3ossIMLKB__yU_i5uQA-1; Wed, 29 Oct 2025 06:00:18 -0400
X-MC-Unique: wRt3ossIMLKB__yU_i5uQA-1
X-Mimecast-MFC-AGG-ID: wRt3ossIMLKB__yU_i5uQA_1761732017
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475de0566adso37934045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732017; x=1762336817;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEtH/DOi8ufPul8rQIFdoeVO4A7KFJe7+IrA/7Qq9Tk=;
        b=ZlPo8uQiqAptI/Bz9ad9WNpvJSZdJptRDgC3tnnumxK5fxLNOGOT/5JiRAS2QTlONe
         AeWu7IdOZFiMvjBSBPzlgz9qftI1G++iHvo0RPPfnB/dbiisOsM0lmpYxKeUPio66PKG
         OcbYzQKxPQSNtjnGQWldqSK7MEjbaCk+XR/M3LeQk9o2GZFPDnLATFmXk3MM2WqEbbei
         8+f5zBrSoGpdGYp0EHVmIdHKyfn+5a20EtKLtmYA8jMH87xzQ5KeTUU3n4ujhrZ3nqjD
         shVGIry4pEoJwvoB0NMLVt2kVsDdnd3VoyXhnE2XWgLxuPoi3tw8XMfZ1ErQHv8bIF27
         qT5g==
X-Forwarded-Encrypted: i=1; AJvYcCVnq+p0KvXFjadOuoI4aBum9T9+0JO6KeBMMuHoooW7NYywGJCrlZKFPtPFBwY7WQhjQUbFXIpS34fN2VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+A4JHDsiZIgK+lIOd1ZzgNeI3MBQmhTqPOjmPZtxQG4WpM2N
	G0SwHxSCavnvrTYHBKupPNNddawADviLOEXV3sb4KVUxRiXLEBwTIVSFChVB4fSaGJ5XzzhkHsK
	WIpvhaVxFT1nfQz4UGDoAPzCVckrkH2uYrFE2aLjcrlc4Nml3QW3b6xbURTcdksEEWA==
X-Gm-Gg: ASbGncvGPleekI6R46APGKRPV87OZM99R3DWMA3JjHR/8n0uUCbH29OrRfl2sqwZXJg
	FVvrv/ivtVETWg+zf+oBGTxlB16BTdUulSdxBHkpRcKn4sITIFuBlgF0Yiy9Awnep1FzFBxIzM9
	h6RhlMMvq7QqHVU65VIMx9b0h9OWNlEt1IZsc6cC4asP/rnz022WriR7hFTZn1F/WJw3kMyj2Td
	XFt+O9COf+q8EAUy8ax7I8hx+yUEGEBqfT+BQR22+b67ZFvGBR+Q2Qsput8ywsWzeqqrQdHBKST
	3iM6QStYhv0giPGrddaJiojzRzG8D7PdXT9QVnr7MHWx6Rtu6ZqAYsXDtjzIFXh9gVP/mVbELec
	+/22y+v3BvtiHCUXtWEyX5g==
X-Received: by 2002:a05:600d:4398:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4771e85156emr12759165e9.23.1761732016758;
        Wed, 29 Oct 2025 03:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnA3IRpFHhYsZzK6qc9l0qizFN8SkkYYfFwlHAG+3t4PNESgPO0z5ya7ZscSCTji9s1WIskA==
X-Received: by 2002:a05:600d:4398:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4771e85156emr12758875e9.23.1761732016284;
        Wed, 29 Oct 2025 03:00:16 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771902fa8dsm39879465e9.8.2025.10.29.03.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:00:15 -0700 (PDT)
Message-ID: <db143076-afa0-4129-b5b0-eab85ec54aac@redhat.com>
Date: Wed, 29 Oct 2025 11:00:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] KVM: s390: Fix missing present bit for gmap puds
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, akpm@linux-foundation.org
Cc: balbirs@nvidia.com, borntraeger@de.ibm.com, Liam.Howlett@oracle.com,
 airlied@gmail.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, byungchul@sk.com, dakr@kernel.org,
 dev.jain@arm.com, dri-devel@lists.freedesktop.org,
 francois.dugast@intel.com, gourry@gourry.net, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, lyude@redhat.com, matthew.brost@intel.com,
 mpenttil@redhat.com, npache@redhat.com, osalvador@suse.de, rakie.kim@sk.com,
 rcampbell@nvidia.com, ryan.roberts@arm.com, simona@ffwll.ch,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com
References: <d4a09cc8-84b2-42a8-bd03-7fa3adee4a99@linux.ibm.com>
 <20251028130150.57379-1-imbrenda@linux.ibm.com>
 <20251028130150.57379-2-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251028130150.57379-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 14:01, Claudio Imbrenda wrote:
> For hugetlbs, gmap puds have the present bit set. For normal puds
> (which point to ptes), the bit is not set. This is in contrast to the
> normal userspace puds, which always have the bit set for present pmds.
> 
> This causes issues when ___pte_offset_map() is modified to only check
> for the present bit.
> 
> The solution to the problem is simply to always set the present bit for
> present gmap pmds.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Link: https://lore.kernel.org/lkml/20251017144924.10034-1-borntraeger@linux.ibm.com/
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   arch/s390/mm/gmap.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 8ff6bba107e8..22c448b32340 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -599,8 +599,9 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
>   					| _SEGMENT_ENTRY_GMAP_UC
>   					| _SEGMENT_ENTRY;
>   			} else
> -				*table = pmd_val(*pmd) &
> -					_SEGMENT_ENTRY_HARDWARE_BITS;

I'd add a comment here like

/* Make sure that pmd_present() will work on these entries. */

> +				*table = (pmd_val(*pmd) &
> +					_SEGMENT_ENTRY_HARDWARE_BITS)
> +					| _SEGMENT_ENTRY;
>   		}
>   	} else if (*table & _SEGMENT_ENTRY_PROTECT &&
>   		   !(pmd_val(*pmd) & _SEGMENT_ENTRY_PROTECT)) {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


