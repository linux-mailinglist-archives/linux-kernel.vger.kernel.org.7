Return-Path: <linux-kernel+bounces-832065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C953B9E432
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C653851A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75085279795;
	Thu, 25 Sep 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sb2ZILoE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450E2367BF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791794; cv=none; b=PmzA94PqZMj75E7R+ID9zpBbEo5FQcMd1q8BxwKUdu5h7DjokZrjPq/kjAE3fthuyFjit2w0mjhfRyXYUziGCmOi9RU7YSUW64tk5wO7zgLge2Nh5Hu165vQ4nTOq8QSvmSRxwSyO2MVLqbaG/YvfF5EoAceBGxsD4WG3JZx9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791794; c=relaxed/simple;
	bh=jBVkikCWFeWCDG4Kf/i3EdMXDupoSYX2izmIXiAaSrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SENlfpWyxZwBurmw0ETxjLLfl8OUshAHy8aVRGLrPcMOWJswgF8gaDDvkG/KC4rSJynKf6ePrN8eVJNgDwJP4OdZfAa3P7F1pkJ883ohZUdB+eQlSGNNgnI1fpAKnsNf8BxJ5fCW2bKpu05U4tkpwOW7LuZEaNsx/HAZryM8GZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sb2ZILoE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758791790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=toj2ZxJ2b4oOQ+sKDtWc0K+F9qjEsZY2B0GFhQ8OUJk=;
	b=Sb2ZILoE8vVsvABZDtP6UD5VEQ1PfwbC2txX+IQ9WPsQUr6yxq5eWNRyfKf2aQukF6aYoI
	L4/5dIS8TA29gb7TVxevOaG1UnPdKOR6MHoWXinAwMsv7cK2v4szS09T8huFqbmsWnVX3m
	yva0jJQ5r5uB3bvOGj04nozqXfwCv/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-dd9e68OeMUCJe4DcwGOUaw-1; Thu, 25 Sep 2025 05:16:26 -0400
X-MC-Unique: dd9e68OeMUCJe4DcwGOUaw-1
X-Mimecast-MFC-AGG-ID: dd9e68OeMUCJe4DcwGOUaw_1758791784
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb604427fso4125275e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758791784; x=1759396584;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toj2ZxJ2b4oOQ+sKDtWc0K+F9qjEsZY2B0GFhQ8OUJk=;
        b=jsBXrnksIysLCJ5Ayv0g+3hTkSE3/BNvBx2kgBBe/fmflpq+TKzB/lPE5+9S2CwOrY
         oqiiJYWWwIf3VBk5EcIskS5Zo7NluyS+/YS1yp3oaSw8TJYyG0XAYhi44mkpSASkduDT
         othpofdo/R0HqoKgRlmV69CKrqAxDEfnkqvhmaTuoAv/XDvP/6G+i3nT0TiZ3JxCnb8Y
         C+EAkiHWvt3W5ZcaDxQuqp/P9onpQ44MzSEcbk9sD+/OKJ6RLZlv/To5OIis3X0i1h4M
         tiuyVCxlB2f9IBWWCqe6kAzuyqv92UNU17bvNggh65+pPj+ExJ0nuvnTAZaytXi0u0UM
         rDdA==
X-Forwarded-Encrypted: i=1; AJvYcCXcIjP7GWFmfQFqQjppklGxyyAf2hBp4vUM+O6EkW1WJBP+tr/NTpR7YIzrjT2NKtEEIitIEMiGxidJAKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywexidm2RugLgnIaCkFLL2RZ1UIWTf2fv737q3D581o1DMMgrBQ
	e4+WyJ+nA5IuL75UA9LS/ZfaH5Txjkwk9evSxfqfAvO82YVZ+jEOJ5tk+HrQPXdJpRFaUu+Y4Jc
	2aWkoVqk+y+xpvJv60Dy5BC8At6PbeUxoTpjiZLzPJ6IxgK9xgeH7up3bzV4tcuhtJQ==
X-Gm-Gg: ASbGncsRGOjPwye83O+tcq8kIIvRDfIgAOLHsQVlMyzUPUffd8n9S9UIHAv4rmK3vCX
	9inD5u8Jh+u0yow3f11MlJPLPbr9UfjHylJTHXbps2c7viR1qFHgBoWILD3TwC2+8rm6dsQH2Zv
	R3cr8yt9ezd/G2aAUChSt6CCx2uEB+6k8IOaQd1qgocy1EXgf2EsKf1O/CCypxyMAvhkxmyOka5
	LhLHQeKZxy4N3VM/0J2GMlnWcvXVDhc32opPyA0FKkqjtb+2z5rN7HYMZuwm4XOQ4xip1EVIPLH
	dNw1O/ssWbJ81TE+qKjRh6RhUdTsPfdJeXDhIbKizdUqXrjpiVOFVtjJqCDJCd0XbYkN4yeqx/9
	TbD/O8Fz0OUIsa7r8RMWghW/4JDHtaM9O3GuYy1jltBafcuQ18ggrvn6jviBHja4brq3H
X-Received: by 2002:a05:600c:4511:b0:46e:1d07:5cac with SMTP id 5b1f17b1804b1-46e3292451amr28057845e9.0.1758791784145;
        Thu, 25 Sep 2025 02:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2p4A+NW0u3h8NbGhux42vGg83SKSNp9azU3IZCNKQ1B2shvHwE4aZsxwTXhfaWI6hnLnTWQ==
X-Received: by 2002:a05:600c:4511:b0:46e:1d07:5cac with SMTP id 5b1f17b1804b1-46e3292451amr28057545e9.0.1758791783682;
        Thu, 25 Sep 2025 02:16:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e8aesm24980165e9.4.2025.09.25.02.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:16:23 -0700 (PDT)
Message-ID: <072b8684-47fe-4a2a-bf69-f6d348f0489b@redhat.com>
Date: Thu, 25 Sep 2025 11:16:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: move rmap of mTHP upon CoW reuse
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lokesh Gidra <lokeshgidra@google.com>
References: <20250925085429.41607-1-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250925085429.41607-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 10:54, Dev Jain wrote:
> At wp-fault time, when we find that a folio is exclusively mapped, we move
> folio->mapping to the faulting VMA's anon_vma, so that rmap overhead
> reduces. This is currently done for small folios (base pages) and
> PMD-mapped THPs. Do this for mTHP too.

I deliberately didn't add this back then because I was not able to 
convince myself easily that it is ok in all corner cases. So this needs 
some thought.


We know that the folio is exclusively mapped to a single MM and that 
there are no unexpected references from others (GUP pins, whatsoever).

But a large folio might be

(a) mapped into multiple VMAs (e.g., partial mprotect()) in the same MM
(b) mapped into multiple page tables (e.g., mremap()) in the same MM

Regarding (a), are we 100% sure that "vma->anon_vma" will be the same 
for all VMAs? I would hope so, because we can only end up this way by 
splitting a VMA that had an origin_vma->anon_vma.

Once scenario I was concerned about is VM_DONTCOPY, where we don't end 
up calling anon_vma_fork() for a VMA (but for another split one maybe). 
But likely that case is fine, because we don't actually copy the PTEs in 
the other case.


Regarding (b), we could have a page table walker walk over the folio 
(possibly inspecting folio->mapping) through a different page table.

I think the problem I foresaw with that was regarding RMAP walks that 
don't hold the folio lock: that problem might be solved with [1]. Not 
sure if there is anybody else depending on folio->mapping not changing 
while holding the PTL.

[1] 
https://lkml.kernel.org/r/20250918055135.2881413-2-lokeshgidra@google.com


Regarding (b), I think I was also concerned about concurrent fork() at 
some point where a single page table lock would not be sufficient, but 
that cannot happen while we are processing a page fault, not even with 
the VMA lock held (we fixed this at some point).

If you take a look at dup_mmap(), we have this:

for_each_vma(vmi, mpnt) {
	...
	vma_start_write(mpnt);


So we allow concurrent page faults for non-processed VMAs IIRC. Maybe 
that's a problem, maybe not. (my intuition told me: it's a problem). To 
handle that, if required, we would just write-lock all VMAs upfront, 
before doing any copying. (I suggested that in the past, I think there 
is some smaller overhead involved with iterating VMAs twice).


Long story short: you should do all of that investigation and understand 
why it is okay and document it in a patch. :)

> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> mm-selftests pass.
> 
>   mm/memory.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e32eb79ba99..ec04d2cec6b1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4014,6 +4014,11 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
>   	 * an additional folio reference and never ended up here.
>   	 */
>   	exclusive = true;
> +
> +	if (folio_trylock(folio)) {

We should likely do that only if the folio->mapping is not already 
properly set up, not for each reuse of a page.

> +		folio_move_anon_rmap(folio, vma);
> +		folio_unlock(folio);
> +	}
>   unlock:
>   	folio_unlock_large_mapcount(folio);
>   	return exclusive;


-- 
Cheers

David / dhildenb


