Return-Path: <linux-kernel+bounces-753451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFCAB18336
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD957A832B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F66B267B94;
	Fri,  1 Aug 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqHh0Gcx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9938DDB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057187; cv=none; b=t9Y2S1MVhmgXSYTGnKb+ZrNuoog3qCC/qrMJzDKJWOq3JXLGjVWdIun/M+HV7XFLqKKnbeN9MWr4VtwHopu9hmTBun97/fEdrIyrfmdrH1g8qzRLD4Uno5TPZy5I/Yh5acc25/njXcOPMikWvq/hB8eemNzXjN8rnJNmYl2wXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057187; c=relaxed/simple;
	bh=4175kAbgqwKohVfcjzttks0911ffoj7qITIi7SO6HFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWw/by4AXxrnGAMNziPTN3ShSOeA4Frq/xzQG+s3kRWGBRxyPMBivtu3usMqFxijPRhg0rBW61Fe7xXc44iGTMUVyWmdQREsQ7hco4EDLXTzQ+eRFNQ9gk/ffe7pbyE0N3SWhplOwtbAr3APYeRjuzo9jadUwhCmhPn8qyls7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqHh0Gcx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754057182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ldzxtItibaaD3BzZxT60cR6OJ4mUiDciQvmka0Ujt8M=;
	b=SqHh0GcxBPEHyutRPt31meR6opLHFeEUFzaeWq5aDjpv5etgPV3rlnHfUFNpMUYi1UVd/l
	4sTKUEEZJgn1JhRG1i797KEph9nDO+9QZWR0cDoB+ubQhXX2R/2Fq7aIfEnrU8t3EtKjO0
	xRTq2VmT9Suu+ll/n7c4dd4n9bvx6eE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-NX5fGK74PbWlvdw2c9QkMg-1; Fri, 01 Aug 2025 10:06:21 -0400
X-MC-Unique: NX5fGK74PbWlvdw2c9QkMg-1
X-Mimecast-MFC-AGG-ID: NX5fGK74PbWlvdw2c9QkMg_1754057180
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b79ad7b8a5so1457163f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057180; x=1754661980;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ldzxtItibaaD3BzZxT60cR6OJ4mUiDciQvmka0Ujt8M=;
        b=afuItc6ECYkCXxg77wKdJ5k2nxgEOszgo6b9DvPdT44iSos04TlmP8mJXenasan1rN
         PUMFgN9QOe/RlVIWPSXJA42BqBQ2AgRG/V/2T8bT5HEC+1j+BDMb0IR2wtxuEtlZQ+kk
         d1mtnzcSHR22EKuHwAX9YbVzUp5lNAvSQJPtuhckitmhoRALQvq5i2guNoZECvgSetxz
         pcP9rQDgmAPrOwdWCjipt9914e0UP2sSIE04VCTfJZksKGnvhRhLG5/wMgHMmBFYtKse
         2zz3jh/QpZ149LV6qUI5KgEhfhQD3AJTqRkKLciS7EO1WzWD8l3+zjaw/75fdbNYPadU
         JdQA==
X-Forwarded-Encrypted: i=1; AJvYcCUb3YfP1lluXCHKNZG6CvHVp/QV4xhNsjlubGVJLIeQRsjNHoy9cmqpMDbIj6A6dyaTk5BdM1zUru+TPy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweIexCYLqgaQ9AYe6hWm1kCKc5pLDx0Bj+QnWAeO++PYejODMm
	TYmKmUN4HKdkZi14W44cU5zcZ7XtLTcljcyjb7n4kMVHoUWbFSwxs0QCt9RrOoqPrnFH/QyhfJN
	q+Exb9hisv9NnM4Qjzw/hpR3qvfMsDp2RCZzLiS6Ud20zh2PY+6iEJP4PNKDV2Xf5/A==
X-Gm-Gg: ASbGncvqwIjxLrqfxv/+nnoIH0GtNiNnGwMcxSeFQckT4TZ2FxUwqTInsqr9trTGNhr
	2TXTTZxUaNusgmIuDcTBUUQJsBkgCA2jdvBciDs+IA4pTCt+hV6vv847roVZllWug9oZJbLUUTf
	tZ7yyarHY+YZS7TSr+aihH65r1OomRe8LELSEQgCJLWhNsZ1YjZT6+LBpCgRM3rlf/9eiA4R2Hp
	9rRXANoQKSkr/e52PolvUQoaUk/CXa77zBITDSEOL1tKCqNJ/FDSeM+ReqBex9yp2wHSHXcbnB2
	5wuYcdhKZFHpsUVO9priCshofX4kr3t4kcbbQuHsvbhhtv6qPgf4K+vAQ6qtxPSCtOzsTRkd6BB
	QlwvkAmdqckS9lGXFHFe+rLroTXVEwphhg4MaImCNGHDvD61W/kazuZ0YcP2krTuw
X-Received: by 2002:a05:6000:2dc8:b0:3b8:d0bb:7541 with SMTP id ffacd0b85a97d-3b8d349a7e9mr2195265f8f.40.1754057180152;
        Fri, 01 Aug 2025 07:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiudoCNIOJ/WTT3yEgQw5mkZd2ditjk2uppwHc5ZcvTUPtZRu8ZwKQIKsy5lNLF9eVNAv2Ng==
X-Received: by 2002:a05:6000:2dc8:b0:3b8:d0bb:7541 with SMTP id ffacd0b85a97d-3b8d349a7e9mr2195021f8f.40.1754057176846;
        Fri, 01 Aug 2025 07:06:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9c7dsm5935495f8f.26.2025.08.01.07.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 07:06:15 -0700 (PDT)
Message-ID: <593b222e-1a62-475c-9502-76e128d3625d@redhat.com>
Date: Fri, 1 Aug 2025 16:06:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
 aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com> <aItjffoR7molh3QF@lappy>
 <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com> <aIzAj9xUOPCsmZEG@lappy>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aIzAj9xUOPCsmZEG@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.25 15:26, Sasha Levin wrote:
> On Thu, Jul 31, 2025 at 02:56:25PM +0200, David Hildenbrand wrote:
>> On 31.07.25 14:37, Sasha Levin wrote:
>>> On Tue, Jul 08, 2025 at 05:42:16PM +0200, David Hildenbrand wrote:
>>>> On 08.07.25 17:33, Sasha Levin wrote:
>>>>> On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
>>>>>> On 01.07.25 02:57, Andrew Morton wrote:
>>>>>>> On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>>>>>>
>>>>>>>> When handling non-swap entries in move_pages_pte(), the error handling
>>>>>>>> for entries that are NOT migration entries fails to unmap the page table
>>>>>>>> entries before jumping to the error handling label.
>>>>>>>>
>>>>>>>> This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
>>>>>>>> triggers a WARNING in kunmap_local_indexed() because the kmap stack is
>>>>>>>> corrupted.
>>>>>>>>
>>>>>>>> Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>>>>>>>>    WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>>>>>>    Call trace:
>>>>>>>>      kunmap_local_indexed from move_pages+0x964/0x19f4
>>>>>>>>      move_pages from userfaultfd_ioctl+0x129c/0x2144
>>>>>>>>      userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>>>>>>>>
>>>>>>>> The issue was introduced with the UFFDIO_MOVE feature but became more
>>>>>>>> frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
>>>>>>>> PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
>>>>>>>> path more commonly executed during userfaultfd operations.
>>>>>>>>
>>>>>>>> Fix this by ensuring PTEs are properly unmapped in all non-swap entry
>>>>>>>> paths before jumping to the error handling label, not just for migration
>>>>>>>> entries.
>>>>>>>
>>>>>>> I don't get it.
>>>>>>>
>>>>>>>> --- a/mm/userfaultfd.c
>>>>>>>> +++ b/mm/userfaultfd.c
>>>>>>>> @@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>>>>>   		entry = pte_to_swp_entry(orig_src_pte);
>>>>>>>>   		if (non_swap_entry(entry)) {
>>>>>>>> +			pte_unmap(src_pte);
>>>>>>>> +			pte_unmap(dst_pte);
>>>>>>>> +			src_pte = dst_pte = NULL;
>>>>>>>>   			if (is_migration_entry(entry)) {
>>>>>>>> -				pte_unmap(src_pte);
>>>>>>>> -				pte_unmap(dst_pte);
>>>>>>>> -				src_pte = dst_pte = NULL;
>>>>>>>>   				migration_entry_wait(mm, src_pmd, src_addr);
>>>>>>>>   				err = -EAGAIN;
>>>>>>>> -			} else
>>>>>>>> +			} else {
>>>>>>>>   				err = -EFAULT;
>>>>>>>> +			}
>>>>>>>>   			goto out;
>>>>>>>
>>>>>>> where we have
>>>>>>>
>>>>>>> out:
>>>>>>> 	...
>>>>>>> 	if (dst_pte)
>>>>>>> 		pte_unmap(dst_pte);
>>>>>>> 	if (src_pte)
>>>>>>> 		pte_unmap(src_pte);
>>>>>>
>>>>>> AI slop?
>>>>>
>>>>> Nah, this one is sadly all me :(
>>>>
>>>> Haha, sorry :P
>>>
>>> So as I was getting nowhere with this, I asked AI to help me :)
>>>
>>> If you're not interested in reading LLM generated code, feel free to
>>> stop reading now...
>>>
>>> After it went over the logs, and a few prompts to point it the right
>>> way, it ended up generating a patch (below) that made sense, and fixed
>>> the warning that LKFT was being able to trigger.
>>>
>>> If anyone who's more familiar with the code than me (and the AI) agrees
>>> with the patch and ways to throw their Reviewed-by, I'll send out the
>>> patch.
>>
>> Seems to check out for me. In particular, out pte_unmap() everywhere
>> else in that function (and mremap.c:move_ptes) are ordered properly.
>>
>> Even if it would not fix the issue, it would be a cleanup :)
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> David, I ended up LLM generating a .cocci script to detect this type of
> issues, and it ended up detecting a similar issue in
> arch/loongarch/mm/init.c.

Does loongarch have these kmap_local restrictions?

> 
> Would you be open to reviewing both the .cocci script as well as the
> loongarch fix?

Sure, if it's prechecked by you no problem.

-- 
Cheers,

David / dhildenb


