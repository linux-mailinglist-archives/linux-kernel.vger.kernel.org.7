Return-Path: <linux-kernel+bounces-866673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F53DC0068C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBD63AC05B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7AF309DD2;
	Thu, 23 Oct 2025 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdyLAsYB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326C303CB2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214422; cv=none; b=tp2VuOdNa3f4eT7HaWnKUK7RXxt76WjjSueRbdHVHqFuDqMOgop9m4bl1/Pz8FR2on1uIrEYxrzk3c1+ZXTttuc66uTgcnBNFNyjVOVVePa5xAmIVcm3ZY/xqaX2e9iNVWdDiW2jJ2qwb5Rz4/UxDGRJvcAH8lm0twEDbj1+rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214422; c=relaxed/simple;
	bh=EKSPlmCEBkTDZ5NGBaXPaeS31CG+/vurTMFkgP0CNz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEbnqd0va29/zhc4eI4Cvs0+Ltkps4DpQxhdEpi14MWNBBvFoiSV2/MXH/3FVrLbUkccPbi9lq8ImmDcOmqOUy2WXVb4fL2tQgVoaZbcOsXe3+NrcujFUoO+Bpa61D3fBviuH8gsP9BBNalvaWDgx8fF+D/4Owk3Nb6X05BFAa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdyLAsYB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761214419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aHktMWgkA59NOlbjgywzEkURdk61yMcemvhRwsjXSDE=;
	b=SdyLAsYBduSuF4EkQQ3EhayCtmB8kxMyPIi64PIBDFn4GtnmItAAfeOccIm2kQsLgskxE2
	Gw+gx7mqLbfrxtbgtwbAZ99Y/RF+MWNhRxVLBmVoUBRivth+Cmqc52RHV1EPz41Inzy3Go
	knrPGBmiGO/yY0Hva7GjPJHA+aco6/8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-s3eBviagNBW9sjaRfAQ7Bw-1; Thu, 23 Oct 2025 06:13:35 -0400
X-MC-Unique: s3eBviagNBW9sjaRfAQ7Bw-1
X-Mimecast-MFC-AGG-ID: s3eBviagNBW9sjaRfAQ7Bw_1761214415
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso288005f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214414; x=1761819214;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHktMWgkA59NOlbjgywzEkURdk61yMcemvhRwsjXSDE=;
        b=f4s3Cj9ZHiS1KD09Zc0+8OChUD675xELCAMTrNOXq4tmdivw9/CdQXBokaD9E+n01j
         o25OEJJswHYZa/UXvgfKNJEVCA4rf352enMOCSCiLzrTBL96Y284cCC7kVKU7qzicaT4
         7Spa7X+pNjzJb5EoLboulvEnzNqLEEH/UvWkNg+D9Pl3t4TtZxzMDZrLRxZ3HLoYYbmf
         F0xrdrvIbLMeLBqiLOmvnD6MCdhPn+qzNDL7SsqlJSb4TNknJNcVEKfVcLuxpLwhemsE
         Mo1wWRKwOqIHwO+R5+ZxWkqnfduvb8gi+GGmuKSlJAfybk8BPZSPZjxjjjysH9mhi3Oy
         eH3w==
X-Forwarded-Encrypted: i=1; AJvYcCVF+ivoYtkyDQLaXEjS0C0U1iRDbNgmq+HfXjm5E1O7hgEwPSRWAeu6EyJh9tfIB9syN+ApMwcUktgcxaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycmNVWfPA943tKUO4c0H04SarZTSiWp4Gcx0ci0q1gizuk0//u
	kF3AKCaahu19eTS/khtuOCmEw++NaXA2twXrQ9qIrMc0uErXmBtg0oLUtsINUiCsuba7+cWzdCZ
	MEhRMcJ0QT/LfjzrecCPlbf+xmUkrddZAQzIwKWzkore8Ur8kI4bWwjZoXipJOHge0pUzddkX3A
	==
X-Gm-Gg: ASbGncsDlP8PRV0CslAhg14s1FKI5WZxVyxF9kJlY9XTmZF6CXW/OQtAVyZKqGAXrlI
	fO566OD6jJARnRGkmki6D6xrQjmCs7l2ghJSgphFP/dj8vJZJAg+lQIM9mOcYFHePTtYk5WhhCj
	B41n02z1D3mF4JIWgsyRM1C1yTGXm0nNPIBw84K+800pN7wYzTS74lsxPC+XKm1GkdmSMtIdTSG
	pHgoOWhNfG47Fobe2gdjj7h7/+30uHEf3BuXeqNG/U4DvN56+9sg/O5agQoQSN4L7cy2csWVsve
	p31uDS+ZCQSu4UIP69F3SZxOXru6sAdch92QNdNnxt17d8+9/uSekf1u4ykFFh0QuJnywBWT0Wu
	/UOn7JI8LtwqT5B9MGrJXWINyPwdvbuy8swokJpSOEE7vrTUQ1bqhTXIkHEoNpAa2Vz7IU9mJyE
	JJHjySYHkNsVyEFIPBDBxxoNQHG0I=
X-Received: by 2002:a05:6000:400d:b0:3ee:1461:1659 with SMTP id ffacd0b85a97d-42704d98980mr15581858f8f.31.1761214414547;
        Thu, 23 Oct 2025 03:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdOK/ndovI7ZRSucl6tmxIKATOgZ2nsBavhyiYYvBwP2HJKnKsVN3z8PcSUoWmo7SG+ASR4w==
X-Received: by 2002:a05:6000:400d:b0:3ee:1461:1659 with SMTP id ffacd0b85a97d-42704d98980mr15581828f8f.31.1761214414042;
        Thu, 23 Oct 2025 03:13:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f57cesm3220279f8f.17.2025.10.23.03.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:13:33 -0700 (PDT)
Message-ID: <e0886fdf-d198-4130-bd9a-be276c59da37@redhat.com>
Date: Thu, 23 Oct 2025 12:13:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 craftfever <craftfever@airmail.cc>
References: <20251023035841.41406-1-pedrodemargomes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251023035841.41406-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 05:58, Pedro Demarchi Gomes wrote:
> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions, causing
> ksmd to use large amount of cpu without deduplicating much pages.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> Consider the following test program which creates a 32 TiB mapping in
> the virtual address space but only populates a single page:
> 
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/mman.h>
> 
> /* 32 TiB */
> const size_t size = 32ul * 1024 * 1024 * 1024 * 1024;
> 
> int main() {
>          char *area = mmap(NULL, size, PROT_READ | PROT_WRITE,
>                            MAP_NORESERVE | MAP_PRIVATE | MAP_ANON, -1, 0);
> 
>          if (area == MAP_FAILED) {
>                  perror("mmap() failed\n");
>                  return -1;
>          }
> 
>          /* Populate a single page such that we get an anon_vma. */
>          *area = 0;
> 
>          /* Enable KSM. */
>          madvise(area, size, MADV_MERGEABLE);
>          pause();
>          return 0;
> }
> 
> $ ./ksm-sparse  &
> $ echo 1 > /sys/kernel/mm/ksm/run
> 
> Without this patch ksmd uses 100% of the cpu for a long time (more then
> 1 hour in my test machine) scanning all the 32 TiB virtual address space
> that contain only one mapped page. This makes ksmd essentially deadlocked
> not able to deduplicate anything of value.
> With this patch ksmd walks only the one mapped page and skips the rest of
> the 32 TiB virtual address space, making the scan fast using little cpu.
> 
> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> 
> ---
> v5:
>    - Improve patch description
> 
> v4: https://lore.kernel.org/linux-mm/20251022153059.22763-1-pedrodemargomes@gmail.com/
>    - Make minimal changes to replace folio_walk by walk_page_range_vma
> 
> v3: https://lore.kernel.org/all/20251016012236.4189-1-pedrodemargomes@gmail.com/
>    - Treat THPs in ksm_pmd_entry
>    - Update ksm_scan.address outside walk_page_range
>    - Change goto to while loop
> 
> v2: https://lore.kernel.org/all/20251014151126.87589-1-pedrodemargomes@gmail.com/
>    - Use pmd_entry to walk page range
>    - Use cond_resched inside pmd_entry()
>    - walk_page_range returns page+folio
> 
> v1: https://lore.kernel.org/all/20251014055828.124522-1-pedrodemargomes@gmail.com/
> 
> Reported-by: craftfever <craftfever@airmail.cc>
> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Fixes: 31dbd01f3143 ("ksm: Kernel SamePage Merging")
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

I think we really want to

	Cc: stable@vger.kernel.org

Andrew can do that when applying.

Acked-by: David Hildenbrand <david@redhat.com>


As a note, we have similar code that should probably be doing a range 
walk instead: unmerge_ksm_pages()->break_ksm().

It can be triggered on a range through unmerge_ksm_pages(), which gets 
called from:

* ksm_madvise() through madvise(MADV_UNMERGEABLE).  There are not a lot 
of users of that function.

* __ksm_del_vma() through ksm_del_vmas(). Effectively called when 
disabling KSM for a process either through the sysctl or from s390x gmap 
code when enabling storage keys for a VM.

In both cases, it's not ksmd that's blocked, it's just that the 
operation (trigger by the app) takes longer.

So both are not as critical as this thing here, but likely we should 
take care of it at some point.

Interestingly, I converted that from a walk_page_range_vma() to 
folio_walk_start() after converting it from follow_page() to 
walk_page_range_vma().

But we never did a range walk, we just walked individual addresses, 
because that's what break_ksm() does.

We could effectively revert e317a8d8b4f600fc7ec9725e26417030ee594f52 and 
adjust it to perform an actual range walk by passing a range to break_ksm().

-- 
Cheers

David / dhildenb


