Return-Path: <linux-kernel+bounces-643741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E9AB311A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A3C17043D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C49256C75;
	Mon, 12 May 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHB3vnKL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D272571D5
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037309; cv=none; b=PHLVqwf4dqbS3y58PBS9gVU7RjZGRWzL0c6xpfLklbOgd1ZI4tlRPuZyMQkIGpcgdCnlVvoO8QD5V2Opcd23TGpToLR8f+5XM7PtDwStraFIgFVaPTTU6ktdUCbBXk0CosD6QhHUsBec7isV1O+6sx/QMdVrvXmnIVsCcSW/lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037309; c=relaxed/simple;
	bh=vfLGs2EZk3WWDZqkMVnA5PtXcaICcAOoTfsus67/ggI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPpbT6DNzJt2XXuQ5ylgKlfDZbCkm9VNz3EHxI4JPJRO8UQFba/gGtYR4fAo85jE4fI6lpmQnaEGmxR3f6LQOQdu6kgrBkqj6YrxiyzsNXBun1clX5dmTwlrA8YW6HDSwius7iOgTGqFN9lDDyRbjfKIV27kVrVj3mQFvpnv9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHB3vnKL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747037307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UGUdqmhJSrxghOP8zxzQdatB2JBTD1eddUHrFZRyN48=;
	b=cHB3vnKLmBslgfgbB3uHyuJlyeEArSJqe7uTKIMIddefdZQz2bvk9eVzKfMhUN6Z2wdafq
	uzht5t1EAtEydFBs0PHpDgGdHsGPVg6KaPk2UwvDyOnN/lJGH0fjsLpY14EwpS0SQCB0Xq
	gmTXTh3k0dktrxE9SfANLb9HrZllRZc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-z8YqGX1kOs68eXt-1ryF8w-1; Mon, 12 May 2025 04:08:25 -0400
X-MC-Unique: z8YqGX1kOs68eXt-1ryF8w-1
X-Mimecast-MFC-AGG-ID: z8YqGX1kOs68eXt-1ryF8w_1747037304
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a202744565so495158f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 01:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747037304; x=1747642104;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UGUdqmhJSrxghOP8zxzQdatB2JBTD1eddUHrFZRyN48=;
        b=jYd+0PAiMdicLDw5arSvi9EOB+N/xqJOdwGsuVFtUf65dzdCdWO86uzPe5EuLt3G+k
         gzyTXEoPp/usRL7sfPAUwskHWXSUpb9RyCvRLBephvJaLtJB+jMPV7dVg01m/OB5ZxYN
         49QsjJXYIQjCjh/GPfq73/JsELDwd9MAml0Nb+zP/dkhlbRJ6lW8FQL8Ypf4jt8BvEuV
         DJxnsdnxh3f6XwbynU/JA1ok/Ii/VRsL61SGllsxxLqp00JEF6fLgZCHPxizW23ao7q/
         9yY31eqXjvFVZN4tHUuiYd3crmIqWneI4ZXCfacdetptg2xUS7hQ7n4Ur9JnpPVdxC+i
         P8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVUDcTfJ78cQjbXNBf6yl/M0LtwendGTSo2xWTyJ3v1jWH7EX1bRrynDdk8wILuOz/0Zqwko/WLEVTJRIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMmq8zWDfkcP3dalzlzybhzHOu/M/Z9d3XMe0XXPCwLOjKcqW
	bRRyNwFb1nmUQcSFoHNpUE445MPtVLnanZneZsmIYPYPZnHnvgkk42XHfRoOGFX01E4DRzQIAAb
	XOVVAROpaGi9WLiTvg6X62SBcMT7Ay36Wt9AQ1bTcTbKfq4rLlqXx6pcxSXw3Gg==
X-Gm-Gg: ASbGncuHEBNB8OGNgLJzmW57iiCCdudmdxBPx/O1+na+nDuOeevE5a/bUVrrsh+O2qb
	nzRe8GiViD0JZ1Lv05bAkXelmHRBPMhUAoUbc9dyBzIY4M1C6R1Ki7DIfD4Bunf/Vvi1+FAF4YN
	an9JkoQuXzv9Xv/+tEHCA8CGJS1vvdOUa3Ge4jiCVjcA0p9mcnlGSMC9fPi95g8+u+CsjhKDOIJ
	TxzICdW/tOiMzn6hpetrJfj2CYwzt8+WVHoHx1yn4/Bnnfe2ZAeHVQ1s5PBsnN+wuXF5Dl9at96
	2LmRcz9IHDlQ4NCCBPjNkL7vu//8d9+cvIxFwsLGqR/e2Dp6JgyD8sSrLZKV1sbnsSBeggFt4iC
	yfSWMXHlNVWfTRdZWopdVjJx3c+Wheeaql1VEKP4=
X-Received: by 2002:a05:6000:2502:b0:3a0:af41:f92f with SMTP id ffacd0b85a97d-3a0b9941d91mr14517672f8f.20.1747037304090;
        Mon, 12 May 2025 01:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOoFqrplAInUI/G0YpV+kZq787EFRHoWXWRXZr2R9GzOjZDVbLxdiJMlgpB+zpYyoph9nGKA==
X-Received: by 2002:a05:6000:2502:b0:3a0:af41:f92f with SMTP id ffacd0b85a97d-3a0b9941d91mr14517593f8f.20.1747037303582;
        Mon, 12 May 2025 01:08:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0? (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecccbsm11737338f8f.32.2025.05.12.01.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 01:08:23 -0700 (PDT)
Message-ID: <5d5e50f1-ee5d-4fca-8d7a-31482a8482bb@redhat.com>
Date: Mon, 12 May 2025 10:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: khugepaged: decouple SHMEM and file folios'
 collapse
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, ziy@nvidia.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <fbdbb35301219f8fef5697006b58d82b045114f5.1747019851.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fbdbb35301219f8fef5697006b58d82b045114f5.1747019851.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
>   static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   					    struct collapse_control *cc)
> @@ -2436,7 +2427,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   			VM_BUG_ON(khugepaged_scan.address < hstart ||
>   				  khugepaged_scan.address + HPAGE_PMD_SIZE >
>   				  hend);
> -			if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
> +			if (!vma_is_anonymous(vma)) {
>   				struct file *file = get_file(vma->vm_file);
>   				pgoff_t pgoff = linear_page_index(vma,
>   						khugepaged_scan.address);
> @@ -2782,7 +2773,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>   		mmap_assert_locked(mm);
>   		memset(cc->node_load, 0, sizeof(cc->node_load));
>   		nodes_clear(cc->alloc_nmask);
> -		if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
> +		if (!vma_is_anonymous(vma)) {
>   			struct file *file = get_file(vma->vm_file);
>   			pgoff_t pgoff = linear_page_index(vma, addr);
>   

Yeah, I've been complaining about these checks for too long :)

I assume this is fine

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


