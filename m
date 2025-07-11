Return-Path: <linux-kernel+bounces-728199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE32B0248E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762D23A35BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4D280A3B;
	Fri, 11 Jul 2025 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCBtSNSl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7518DF6E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261990; cv=none; b=ohtf8iPVL3cDi6GoxBRtqMht9StMeZB7p68A6uBN/0wRnm075NPjT49ctY7TqMK6fst3na3PR2j65RSSFiSKo5cYpvCshH1NcJn0aS+H78xxDh7IoSPqymAd1WSJ/NuD0xmHSawqCU2vc0S5F+xeSaWzLS8eZAvVazoi6TcYYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261990; c=relaxed/simple;
	bh=O6b29vfp8NAjIK7dSvR9eF/PkCS+jZUZlSer7albEO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3HoOR7Y+Ey8/F12PCz/tQaxAKPT4r/xyPeav6HtH/EREURgPXFQ4SO7c8Nf07KN46OXEt9jblCbeiiLs+8zI5hdiD9w4OAvGRuvJndGrgbZUVlqzfkXakBydYSf3i0MsGMNxXThNA1dKfwV/MOffmOTo4O+3jUJItEFR5hMbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCBtSNSl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752261987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EdZeHYjTUsEo8EIqSdC2KguJH2n4inFGo+2yY+zKrgg=;
	b=YCBtSNSl/bUFW1BirQx50D21uLLDs48f/gKQCcsjhv4F93wOPBjIUHcRIlj/wNlZp1PXEt
	XTdEKJ7dBFo1yF5U5D1+QooFmj70PE76Yw8lkVotif8d7Gv1th4EiOmxccOI6FMIDiTC0J
	7U5mLmD3j6Td5nkRyxEAhDofmvvNSM8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-oHEfOrQePI-9a6zesdMsyg-1; Fri, 11 Jul 2025 15:26:26 -0400
X-MC-Unique: oHEfOrQePI-9a6zesdMsyg-1
X-Mimecast-MFC-AGG-ID: oHEfOrQePI-9a6zesdMsyg_1752261985
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b4a0013c0dso1108329f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261985; x=1752866785;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EdZeHYjTUsEo8EIqSdC2KguJH2n4inFGo+2yY+zKrgg=;
        b=BEptQtR5XWjjPtqBWGyOSs4V5LBgCBGPBnW8zwpERAj2W7Zad/cvp8RtuaMLTKUvQM
         kQlvWj08QtIeSZrmYUU7o8PIsuvAiA5IZCDfCE/n5wSTA3pyHAArVxrkMh1+bnJvJdfy
         DalCmA0o6wFoRIKz/LeBsAVLwFoQg3Vs8SkLMwy5PyJYAOYjJz+6ApxhzLsidDiLy3cq
         cuIgq5Ybn9pLsuEPP4EuJ9pSwpPCGgLDb+FtMvpCoVbkON90xyntsztuWHxeZfWWdprl
         geOsOQNCB6SwBrGqNTJRM6w2clbiQn14ygrGlaPyOueTiqJRGgvDeLIAXHV2ANhADzhw
         CtXA==
X-Gm-Message-State: AOJu0Yx+mtxWNhauYGhgmLGXlzxUCuenv+NXvsSmGNwAcDMv5njdA+5S
	09C6Fo04XEFBLUHUuUmnuQUdRZcOAwV+i/BBiJBTnoJDetmL5OICP+YUSYh/VsSX91GLK/XjVLg
	OdV1cpswiwES24rLwQjmp4DH9y/Btz2ne/KsLNFkqY1EY3EcFce7AdY1JaE4UtAgJNQ==
X-Gm-Gg: ASbGncsEzuuCThKIDL7+oO4ynBAtOLbSiC7YiljCvBwe15379n2GBE2jouUtua9mG8f
	hAncAHMMVCiHvjRBvO/ia5y7McqCoV0hke1bVh5SGnlCv/ZS8KvvqPtuQCiSVt/CgjgUYfBf9pG
	ouvS3xa++X5lKfYuqv009X/nRQ/DNtPFTXRAKCtuxUaXouEjsW/l2asrYQ4dePC0s9KF71JJ/a9
	KTOvpwWYQBb/QMGI/YWjs86KaRqSD7rT6QKmi1POPK8TVhdM8MyWLpzZDhRf+QzVypHizvAGrij
	dG5Cd0tECgcaFGYigXUCo77v21urUJrUzi3sFT15VnbYozxUAxtFsrwZyuXItqO6hsfA3FvFqLi
	3w2do0VlCZpR8zoko/tpIDnmy7s56xeruw4nFNbonKqg/JKhfBnUS9TSr5GBjwfD1tQI=
X-Received: by 2002:adf:e18c:0:b0:3a5:2cb5:642f with SMTP id ffacd0b85a97d-3b5f18dc494mr4414635f8f.34.1752261985220;
        Fri, 11 Jul 2025 12:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAC0mrP/PV63n9LW3+mNjRAvzllgV/qy6U9gBqjiMU1XbBQTnmyfTh6tCFAjdICjFigDHT4A==
X-Received: by 2002:adf:e18c:0:b0:3a5:2cb5:642f with SMTP id ffacd0b85a97d-3b5f18dc494mr4414618f8f.34.1752261984742;
        Fri, 11 Jul 2025 12:26:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c? (p200300d82f0a2e0089cbc7f082f2e43c.dip0.t-ipconnect.de. [2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d785sm5385180f8f.59.2025.07.11.12.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:26:24 -0700 (PDT)
Message-ID: <9865895d-c9bf-42e2-b813-bdbd39ad3af1@redhat.com>
Date: Fri, 11 Jul 2025 21:26:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing page-extents
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
 <fe138d11-e0fe-4e57-8e51-a5521bad1b88@redhat.com> <87qzymocok.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87qzymocok.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.25 19:32, Ankur Arora wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 10.07.25 02:59, Ankur Arora wrote:
>>> Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
>>> where architecturally supported.
>>> This is only available with !CONFIG_HIGHMEM because the intent is to
>>> use architecture support to clear contiguous extents in a single
>>> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
>>> which excludes any possibility of interspersing kmap()/kunmap().
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>
>> Staring at the next patch, I think this can easily be squashed into the next
>> patch where you add actual MM core support.
> 
> I wanted to do this in a separate patch to explicitly document what the
> responsibility of the interface provided by the architecture is.
> That said, the commit message didn't actually do a good job of doing
> that :D.
> 
> Copying the more detailed commit message from my reply to Andrew,
> one important part of the clear_pages() is that it be interruptible
> because clear_pages_resched() implicitly depends on it.
> 
>> This is only enabled with !CONFIG_HIGHMEM because the intent is
>> to use architecture support to clear contiguous extents in a
>> single interruptible operation (ex. via FEAT_MOPS on arm64,
>> string instructions on x86).
> 
>> Given that we might be zeroing the whole extent with a single
>> instruction, this excludes any possibility of constructing
>> intermediate HIGHMEM maps.
> 
> Do you think it is best documented in the next patch in a comment
> instead?

I would just add + document it as part of the next patch.

Looking at the bigger picture now, you introduce

	ARCH_HAS_CLEAR_PAGES

To say whether an architecture provides clear_pages().

Now we want to conditionally use that to optimize folio_zero_user().

Remind me, why do we want to glue this to THP / HUGETLBFS only? I would 
assume that the code footprint is rather small, and the systems out 
there that are compiled with ARCH_HAS_CLEAR_PAGES but without THP / 
HUGETLBFS are rather ... rare (mostly 32BIT x86 only).

-- 
Cheers,

David / dhildenb


