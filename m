Return-Path: <linux-kernel+bounces-816758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8FCB577FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B957AC234
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C52FC013;
	Mon, 15 Sep 2025 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qarg0R4x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC12FB991
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935335; cv=none; b=GubdBbkxQWd5rdMGdcJCo+sEU3/3ELZoBqeH6zWuny2X5saArc80/yt/thv48lvI+y3k+yTUSYbbbq/BMLGmKKDYGkhcx3D8mze5PTi+Hz2DzJqEltnQdsYxV5UasNCK/nB+NNFCtxYfEmmz1xogNQUDjQM1SqC1chiJS0UpSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935335; c=relaxed/simple;
	bh=dOIkUCCEXSod4dzJQk5Loct1T8yKGsqwCY5OOdUb2no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJcXyS0BUQ22twz7fXzdAMtdI+Kfs2V9/flitrR5GReh5EUPWGq37aYTeKlJFf++kHM064lNATeRn0DlOgDps/Tr+m9NoTobmfJLd7WnSrTQ+4G6nOb9QrtGS+zc3CGzU58i4L983mXTy8xbwhod8421pvOKxCmJEiH7+N8tYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qarg0R4x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757935333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6JS9BpphTEQIvKpjiDMgsvluJyslUVzzLKfuwxGpvmo=;
	b=Qarg0R4xEBZQi4dWaGHcWwgcrFNbN/Xu6kSQglOtFbpcP2SwxUF9SuyrgQOKVweXao12sE
	kMOkiFfbslByq2ctviPtzH2dAiWDbZFgwz0m+i4qefvnMX6ZnONU6QJ53CPLFecKWIjR3F
	VbrGzcvSzmcx6R6gcAhb0INHZpO6Pmw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-MXIFWPnpP5mfBxFi9jcnmg-1; Mon, 15 Sep 2025 07:22:11 -0400
X-MC-Unique: MXIFWPnpP5mfBxFi9jcnmg-1
X-Mimecast-MFC-AGG-ID: MXIFWPnpP5mfBxFi9jcnmg_1757935331
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2f1a650dso4130385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935331; x=1758540131;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JS9BpphTEQIvKpjiDMgsvluJyslUVzzLKfuwxGpvmo=;
        b=dryQl6vMQ3mabc8K0+xB4N1j+wEuRxF18QkaveHZFlwOFgGx1+z++rX3aEPCR0QVN8
         BJQLcNVIsJ9OJhagoayj2HH7SVPue69ayTRiTN6kAxDpzINA9ULX+RY9awLnQfUjvHR1
         wjOS/es/kbe+uWWUPLHm7MAGtVj+T50tVzehIFUdDmsekQGOfC9JHz1QK9LExkkKt0UV
         jtJdc+9+KZcOeiPGP4+qqdJh6eiEFMk0ukuQrvyYE6i7YUrTJHU7rhe2F1nCLcC6kmLV
         bimDnwljg1wZeAnFt4vdQR1B0EKEChrCexOcupyfE2X8dV40wzgFGheSiPw/o04gp5HV
         0o7g==
X-Forwarded-Encrypted: i=1; AJvYcCWQM18Z8kSsUG20Ci3PpBWM3Ny4dTLnqfgZ8HC0hITD/otY14P/INt43TmY7EUg45nS/42gDxsR8pYQFF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeIFuVfm3rIeyIrVWvcv5LfNYGLePhn94JJ7vTy3yolsvET1Fg
	ag6Zjrz08V+vc6BmJuvLuxvD6CdAN/FdFAXm0NWDFOIA0wuTmrCUfwnml6RgoroO+1gVyrA9ete
	Bqhczv8jr92U7gCJLGvrGLsb/zg75gAp+b59anXbhnsT06cth5cQ4D7CmiUt71a6OMQ==
X-Gm-Gg: ASbGncsObc7gMfNQoJTodlPZtsW2R5i80uhZsY1kK+E5o+SWJEQKR7OoLeUO37F6nwP
	Hx2x3C9t7ea+cqhv+RTFbhUCWZ1z9S8R2gijCplZ0KlPtZ659J/Imc+ovmI08l5fjfeekdEuh1C
	mTwKOgZ1HWKsfmuWfclZK8Wsb71TaqbTzia1+mXTiw7rcC2J17mBhyAn4RaTrpBmv//DXd2k8v/
	FGm+D4btQIwfVey+9upNCOdyIy7Dj0DvhUD6g2tBtnACzU/V5Gxh+SQ+9Z3RY9imlm/vzcpk5wA
	MMr1eEp+ubLE6CV7M/R2mXL7imLfn2x/niRqJmdayreJghTQ+kb8vU7UOPYmvL6isjNCkgHOJzG
	VsnX7KBSBT5LAT7qUKe2WSsIut4DrPYogTDb785nc/OhydsWaHYvyDOnE4AQ1mCWvJEA=
X-Received: by 2002:a05:600c:4446:b0:45d:f7e4:bf61 with SMTP id 5b1f17b1804b1-45f27ceb2f2mr68690575e9.4.1757935330627;
        Mon, 15 Sep 2025 04:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbzlCmUlfFh3pRrb1LTU/GY0YGAbYOxUMXj2cLY+VIMiWhAEy48i5aLRY2rCGTwJQhgLvVKg==
X-Received: by 2002:a05:600c:4446:b0:45d:f7e4:bf61 with SMTP id 5b1f17b1804b1-45f27ceb2f2mr68689975e9.4.1757935330079;
        Mon, 15 Sep 2025 04:22:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm11234210f8f.27.2025.09.15.04.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:22:09 -0700 (PDT)
Message-ID: <d5d7cf04-784b-447c-9d63-8322ac97be29@redhat.com>
Date: Mon, 15 Sep 2025 13:22:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 07/15] mm/memory/fault: add THP fault handling for zone
 device private pages
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250908000448.180088-1-balbirs@nvidia.com>
 <20250908000448.180088-8-balbirs@nvidia.com>
 <d4ae7f61-f2f9-45dc-91db-4de7f3127744@redhat.com>
 <37196a41-77ae-4579-97a2-2c7a1eb65bae@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <37196a41-77ae-4579-97a2-2c7a1eb65bae@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>>    /*
>>>     * always: directly stall for all thp allocations
>>>     * defer: wake kswapd and fail if not immediately available
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index d9de6c056179..860665f4b692 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -6298,8 +6298,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>>>            vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
>>>              if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
>>> -            VM_BUG_ON(thp_migration_supported() &&
>>> -                      !is_pmd_migration_entry(vmf.orig_pmd));
>>> +            if (is_device_private_entry(
>>> +                    pmd_to_swp_entry(vmf.orig_pmd)))
>>
>> Single line please.
> 
> Ack
> 
>>
>> But didn't we have a pmd helper for that?
>>
> 
> This is a single if that handles is_swap_pmd() and then is_device_private_entry() and is_pmd_migration_entry()
> under that

I meant using

	if (is_pmd_device_private_entry(vmf.orig_pmd)))

just like below we use

	if (is_pmd_migration_entry(vmf.orig_pmd))


-- 
Cheers

David / dhildenb


