Return-Path: <linux-kernel+bounces-733628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2360DB07723
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2750C505109
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDF1C8626;
	Wed, 16 Jul 2025 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wh4CxyGw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D074040
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673138; cv=none; b=b4/Q8+iam/Im5i7Qxv43q6GGJNyNGQGmVbt/HSASMkUP4OkFHTEsOmhb6jnlTgUZNNLSAyuNn6ig3afciReGAcXYP/MejZrmeriVqaHWecLP3SgOAj9uNoragDYjgm3GGGo3idW5ea9Fvg3tumzFv1cIh8TOP0m7wgzny59z/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673138; c=relaxed/simple;
	bh=Uihv2ZMcXflJWdptpxbYoOBMyVwcp0Gvv2N3y8AMZ44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a67H2acfaK5S1bnX+NHAip+bCggTZuwDZT642VidS7xQOAMRh7HxPbukoh4aztKr1p4iA30iIda8t/fgnIIij79wdbdz6AxI++YI2cTmq6efhChMeZ6Wu+Y74FNGBXCwrvAIjqQlTJImo9NF//dgWPcR1+6n3iWeLH5guglWLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wh4CxyGw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9LXcbb1TYxRb1baXYAWLipiAAtAriq/1xerzXLTDLpg=;
	b=Wh4CxyGwnoK//Jvs6aE/J9poYgGyUAjBqrbePX7oDoQh4IaxAf4ZG+4EYeYBPZcPklZIxO
	eqTR5f3wNbmDCokyqFVBAKvO07VQKl27PW3XHUkJoqHFXz/Mpatq4Hi7QpXKNCNlyt/eIW
	v+7OY5WigogJQGmYmPmghtYfo2Rgz7Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-zEnq3sKJNISNuMiiC5Nhzw-1; Wed, 16 Jul 2025 09:38:54 -0400
X-MC-Unique: zEnq3sKJNISNuMiiC5Nhzw-1
X-Mimecast-MFC-AGG-ID: zEnq3sKJNISNuMiiC5Nhzw_1752673133
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so2843440f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673133; x=1753277933;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9LXcbb1TYxRb1baXYAWLipiAAtAriq/1xerzXLTDLpg=;
        b=Um8owdZ2JaEASU2hT2PUtelog6jQU9KNBUSP7iMpAFew5jhkaudti3HgxyS89LER36
         qXeySQixD1N1x+befa4oFVzlCsrV0FL487tgdlucSWclGMoWYm+rQPBTueZP02uCgjxE
         DgoQ50Jn5AE6bEZGqsR7Gvnjd5nBudRwZyvD7H1HV8DkQUWTkJAUi3Qh/wKEYo3cDeiu
         +d2fgdBypoi75sFnT3AbWwH4CfxALh5aJbXvwlc/NGhYdPjtHFYwGN5PvqV6hUKpXz6n
         OM/sC4Q9/89uLg/hXB0OFeFIFAfrB7iCWBcXBI6OEr1KK0Ls0TgNkm2uKy6YxKCTtCvW
         wGug==
X-Forwarded-Encrypted: i=1; AJvYcCV/zjPk2v8kRN0BOaLZv/8+ycudMmJs8e14AxSuHi2Y7XQzFqHB+TRslsQlKD/vFXxDtmT8qddPLEQhdjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySI8k6MWtOk8VOYiDEHrnRqhGSCwed+zIG4oJY8KTgc4+1oZjo
	4C6OI8Ilsnge261v1lnlZ6FBPcXCCW1BbCyN96OrB1oORkT9ZU3VHYn/qm3dmeLlv1+mmrmPijU
	JaLJQPZjlkUqGCP4lgmvG1yHyxb/4HI7+d5VafwufNHb0BCQo8jCpTrVSpRr28D8hUA==
X-Gm-Gg: ASbGncvpRhn+6nz0inUDhMLO9Bt+dYndV34J/HlbZ2Gkz7Z6w+3U/A1Zu9ake1jazPW
	9dolt3S+8JoKElwdF23qaSgKfiNKXF+YmHjcz0BjiFNKzzBad2KmJOSUGXHwgPLDRMaVj4GTdI+
	YKXcoSwmKVgRyXtC5fnliQ9IJaUpSkY4OUZFp6KZyf+pT/2lZ3wSvnZ4tSqr9Kr1mI8ZBbsaQKr
	YcvFEpByHGjVLhpV1+4CXOUBCayc/ATYRcg56FWA+xouoMweabMtlkSCqzFEABXnUA1LAVDKuvz
	Q/8ixirTITru4W8Ka1AMbKljRNKHhapsjFhPUJg5wXr4U9vGzi4NfT7xyhPh33QCdV4UhN6SmhP
	aR93MPHepeuFck2WI2iprA68+pK37aKXYSh+c25Xn8QN6zv74UIPlaYL6NhCSGX2zN/o=
X-Received: by 2002:a05:6000:2dc9:b0:3a5:2f23:3783 with SMTP id ffacd0b85a97d-3b60dd72557mr2611563f8f.24.1752673133177;
        Wed, 16 Jul 2025 06:38:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR2oK5V+RlrDg09tKIdzWocX0ML7lbcqM589Y19VRknX4QYCUhaHDazst1EabWcRBqz8SFjw==
X-Received: by 2002:a05:6000:2dc9:b0:3a5:2f23:3783 with SMTP id ffacd0b85a97d-3b60dd72557mr2611520f8f.24.1752673132608;
        Wed, 16 Jul 2025 06:38:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e2cfsm17673967f8f.75.2025.07.16.06.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 06:38:52 -0700 (PDT)
Message-ID: <9845f6f3-6265-49e9-8eba-5855b2b5f90e@redhat.com>
Date: Wed, 16 Jul 2025 15:38:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm/mseal: Simplify and rename VMA gap check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
 <8efef79c46553a9b8924878c1f4363998c1f49ed.1752586090.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <8efef79c46553a9b8924878c1f4363998c1f49ed.1752586090.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 15:37, Lorenzo Stoakes wrote:
> The check_mm_seal() function is doing something general - checking whether
> a range contains only VMAs (or rather that it does NOT contain any unmapped
> regions).
> 
> So rename this function to range_contains_unmapped().
> 
> Additionally simplify the logic, we are simply checking whether the last
> vma->vm_end has either a VMA starting after it or ends before the end
> parameter.
> 
> This check is rather dubious, so it is sensible to keep it local to
> mm/mseal.c as at a later stage it may be removed, and we don't want any
> other mm code to perform such a check.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/mseal.c | 56 ++++++++++++++++++++----------------------------------
>   1 file changed, 21 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/mseal.c b/mm/mseal.c
> index adbcc65e9660..794d1043a706 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -37,34 +37,6 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>   	return ret;
>   }
> 
> -/*
> - * Check for do_mseal:
> - * 1> start is part of a valid vma.
> - * 2> end is part of a valid vma.
> - * 3> No gap (unallocated address) between start and end.
> - * 4> map is sealable.
> - */
> -static int check_mm_seal(unsigned long start, unsigned long end)
> -{
> -	struct vm_area_struct *vma;
> -	unsigned long nstart = start;
> -	VMA_ITERATOR(vmi, current->mm, start);
> -
> -	/* going through each vma to check. */
> -	for_each_vma_range(vmi, vma, end) {
> -		if (vma->vm_start > nstart)
> -			/* unallocated memory found. */
> -			return -ENOMEM;
> -
> -		if (vma->vm_end >= end)
> -			return 0;
> -
> -		nstart = vma->vm_end;
> -	}
> -
> -	return -ENOMEM;
> -}
> -
>   /*
>    * Apply sealing.
>    */
> @@ -102,6 +74,24 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
>   	return 0;
>   }
> 
> +/* Does the [start, end) range contain any unmapped memory? */
> +static bool range_contains_unmapped(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long prev_end = start;
> +	VMA_ITERATOR(vmi, current->mm, start);
> +
> +	for_each_vma_range(vmi, vma, end) {
> +		if (vma->vm_start > prev_end)
> +			return true;
> +
> +		prev_end = vma->vm_end;
> +	}
> +
> +	return prev_end < end;
> +}
> +

Probably better to not ... move the function in the same file? Then, we 
can se the actual diff of changes easily.

-- 
Cheers,

David / dhildenb


