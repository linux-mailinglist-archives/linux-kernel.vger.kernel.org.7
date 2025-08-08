Return-Path: <linux-kernel+bounces-760209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F23B1E7DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB341AA66F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CDC257AC6;
	Fri,  8 Aug 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWWl3cBh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BD1CAB3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654506; cv=none; b=O/YDQjaA9Jrfp99flhtQWPCjRVObU880gs+h6cMNAKeKYSkOl4FYNIpe2Xv8UQjjDy2nzfz5UizzB3IkywaBx4I6x78+d6jgpLH5xneQfQwHmeliukGou2/nTX2Ct7myM4N7cO6iQTsglOr8fdJSeFuD0qETITErBMWHDdyn0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654506; c=relaxed/simple;
	bh=qmmzMiklvoQQbiF8DEisX7gl6r0kC51/bp8XW20TFBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8RlDy/n8rLNrFPnCdn6wPVU8u8dKFsSq5nOxGf9OkbV1nQTsp1pPF/n7IO+9C/3/14vTEjjfyxsTLE9zl0H6dUyQMK3PqWr3lnNzjBI5PaFIlmKophP8s8JNuTPjH3vdWVYWn7c5XYdB1+g27iYyxZ5Dqs6/pMXu7Bhyruj048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWWl3cBh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754654502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fuVWCm8/vxZTQSAECo7taLOMmR2PQdm996aX0i+uTig=;
	b=PWWl3cBhZ6k4Ol5cueBKjS0+oHMWwUnZaTGs4kykWHD6ogXILZ7F5XllnXs5DPyPUQ39bd
	RlvZ2Xoz1+STx5zHn5jzDEuUrI/f0is3A+gyUUdFAdAjgoNNiV950pAt3m1H2E7I/kbESK
	DdmromZNqjjlPZh+1lIoDDAonEwD0iA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-E_0hQsWlPdOhD8NRb82WPQ-1; Fri, 08 Aug 2025 08:01:41 -0400
X-MC-Unique: E_0hQsWlPdOhD8NRb82WPQ-1
X-Mimecast-MFC-AGG-ID: E_0hQsWlPdOhD8NRb82WPQ_1754654500
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b78c983014so1208255f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654500; x=1755259300;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fuVWCm8/vxZTQSAECo7taLOMmR2PQdm996aX0i+uTig=;
        b=UXDRhj9+MjFpmTD/V40RoJecH2QT42ZZJjDa5BZt5otBP3kbdwKJPX5NdQSCSh1xH4
         EY5VSfbki5LquzM5UI0AdkRIlxdHzJ/RxB1O2jYwtRL7XhFnG4iaPTpehF0L8p9uowYi
         n8Eka6un+k+o687fLZR3V1YV8gHz3VLh2BcmCsVvvoR2SnelwEGwr9uyF6s913nS7qYb
         Qz9VY4VFgEmk/NGACK2e5QQ926v69x8T5Kywuhlz9MfTWw4RXspk9fdDq9mhyKSjcyfx
         /5w0Fmib31e1QtY0hcpsRMj3aHeQdzpMTQAAFF4fZlbCAIEWPjDgub6Y337M0ZxLhMl/
         RjsA==
X-Forwarded-Encrypted: i=1; AJvYcCUbZ0q9pd5tfhV13Ve1A2vlX/yoQYd/FesvK+FxYwOwKJHtVdaRCM7lLN/vIkeYkp/eQXF4+CQxzeoB5OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQKAayRdUl9T82Gz3zyxe45DQdnuT8maVVX5TWwaLuGs9i78Ew
	UPTcBUJ8naFVTOmhBWBa4Vamv240YmDID5cas+l8haUskBsh4VT2tUDlNNJ9cU4z9FY67XXjJQs
	VnD1IMdXj8aWN4B454eI1uNEKwB4ZB2FeQxPTD43kM7OpHUZE3R9zhY/NBwABq1zHBg==
X-Gm-Gg: ASbGncsEnDHdbhLHp1/AH9+kjZa7yQiEiXbe/4aekMPFbXvsj3dFZDCeyeWyFZj3c7o
	Qp1WH4ioAag9gMa1JQ8riWxK/WWCEBtB0zXrOglp3n8s9e/XDNZ3Jr2EVZvvE9OrNCDxXBuxiWx
	eNGTnxFFTs8mkuWYXIb5LmrqMjsZwmf6WvQh2vDe05WN4eBIPFQdEHuicOFiEJtbS0AICHenj59
	pPHH/g/hqFOi3qOSEgevntMem9t9+KE85jEyuucvXkvRei8ldw6Sje/uTWM2ttJDf3uFHZJhECv
	F+uFz3wnjcKKos+P/YnlrkVy5+sVdAU3bHslBAWVFSabq1npJeRBLwV/O+eQszWh+37zQUtbadP
	Do2XOD5cXBRPMCUxG4QRtMGw3lAFVjDPvdZEUS/e/9eo+c/foQPPaU8ODiKrhmAGi
X-Received: by 2002:a05:6000:2c03:b0:3b7:8832:fde5 with SMTP id ffacd0b85a97d-3b900b4d7f2mr2289640f8f.13.1754654500119;
        Fri, 08 Aug 2025 05:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Cof+uVTZkeDN8zA+fsn/xE0Kjasw/BoUL2hR61ythCO9HbSu9Wf87sSKgu3iIzkGoTT9vg==
X-Received: by 2002:a05:6000:2c03:b0:3b7:8832:fde5 with SMTP id ffacd0b85a97d-3b900b4d7f2mr2289505f8f.13.1754654498111;
        Fri, 08 Aug 2025 05:01:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6? (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de. [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0bfc79fsm19755204f8f.56.2025.08.08.05.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 05:01:37 -0700 (PDT)
Message-ID: <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
Date: Fri, 8 Aug 2025 14:01:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
To: Charan Teja Kalla <quic_charante@quicinc.com>, akpm@linux-foundation.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
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
In-Reply-To: <20250808092156.1918973-1-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.25 11:21, Charan Teja Kalla wrote:
> It is possible to hit a zero entry while traversing the vmas in
> unuse_mm(), called from the swapoff path. Not checking the zero entry
> can result into operating on it as vma which leads into oops.
> 
> The issue is manifested from the below race between the fork() on a
> process and swapoff:
> fork(dup_mmap())			swapoff(unuse_mm)
> ---------------                         -----------------
> 1) Identical mtree is built using
>     __mt_dup().
> 
> 2) copy_pte_range()-->
> 	copy_nonpresent_pte():
>         The dst mm is added into the
>      mmlist to be visible to the
>      swapoff operation.
> 
> 3) Fatal signal is sent to the parent
> process(which is the current during the
> fork) thus skip the duplication of the
> vmas and mark the vma range with
> XA_ZERO_ENTRY as a marker for this process
> that helps during exit_mmap().
> 
> 				     4) swapoff is tried on the
> 					'mm' added to the 'mmlist' as
> 					part of the 2.
> 
> 				     5) unuse_mm(), that iterates
> 					through the vma's of this 'mm'
> 					will hit the non-NULL zero entry
> 					and operating on this zero entry
> 					as a vma is resulting into the
> 					oops.
> 

That looks like something Liam or Lorenzo could help with reviewing.
I suspect a proper fix would be around not exposing this
partially-valid tree to others when droping the mmap lock ...

While we dup the mm, the new process MM is write-locked -- see
dup_mmap() -- and unuse_mm() will read-lock the mmap_lock. So
in that period everything is fine.

I guess the culprit is in dup_mmap() when we do on error:

	} else {

		/*
		 * The entire maple tree has already been duplicated. If the
		 * mmap duplication fails, mark the failure point with
		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
		 * stop releasing VMAs that have not been duplicated after this
		 * point.
		 */
		if (mpnt) {
			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
			mas_store(&vmi.mas, XA_ZERO_ENTRY);
			/* Avoid OOM iterating a broken tree */
			set_bit(MMF_OOM_SKIP, &mm->flags);
		}
		/*
		 * The mm_struct is going to exit, but the locks will be dropped
		 * first.  Set the mm_struct as unstable is advisable as it is
		 * not fully initialised.
		 */
		set_bit(MMF_UNSTABLE, &mm->flags);
	}

Shouldn't we just remove anything from the tree here that was not copied
immediately?

-- 
Cheers,

David / dhildenb


