Return-Path: <linux-kernel+bounces-739045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115E1B0C0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B5218C26BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289A28DB58;
	Mon, 21 Jul 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g52yxrs7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3191E28D8F5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092643; cv=none; b=p8ZwtczfBGRdCg6mzMXM5yIroxweiMuc7EdOkAALHwtxaXAtLoE7IhpF2xX7WgFfbmOWZVudwWZ8u563S/vnwkI9WQNDI279ULxZ4YOU+xhltrqmkv3Lis3B+laTuHmBTbFnU6CnqYF/8jgiA/n5SPiF8DS7n6wAV4akksy9zQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092643; c=relaxed/simple;
	bh=7QET8QCnNLYs3jbtPVbIvk6HIXzvVH/bTeiHZw5lSao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ybrifyg3opm3qcdrf8jOZ5BBHd/ck7Ph/BYi8kz5BmVvB9+POAeMsPZKhpeuYreCYfoG2k/KMW/Ew7uXAojtYIhSpi6ECBFmsRvpI1lM996yOzjyOZuYaaRNkM13Wy+ym8b44pbHQMK2FUYRDrSUxcz1YcgMqk1PaweShQ8S1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g52yxrs7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753092641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x0NugjdIePzRcMM8ZGljv12Jg4kfxteOSlIrE85rj4U=;
	b=g52yxrs7jNS6UrV52iN/0rAUMhVNeuo/TOwqiHFgGDjVGwIIwFesHX0vXmY9/PF7xN6vmQ
	fdyEkul3QVUOnx6DAg1OYgNkkTbgCmSZ08Yxwn0u70piWj7ze02BM+zrnF7xnTEh4v00CU
	0us8tO9WOYoXFl8ysPQOJ390G/gobyk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-gxALfdO3OHqMooyJ1j7_fw-1; Mon, 21 Jul 2025 06:10:40 -0400
X-MC-Unique: gxALfdO3OHqMooyJ1j7_fw-1
X-Mimecast-MFC-AGG-ID: gxALfdO3OHqMooyJ1j7_fw_1753092639
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso2288521f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753092639; x=1753697439;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0NugjdIePzRcMM8ZGljv12Jg4kfxteOSlIrE85rj4U=;
        b=jSNmnb/5MY2PGetVyHd0/+SEpCdhIS304rXbZuGeHTAajc33horcR6nGcMNoedi9DD
         7a60t0BWlBISldJuoRoAKEhw8MH5JSw5Zgc9SbATnlgJL2Q87oFH6y4z461ECEi+a23b
         IJg3BIyQf+IAw9372blANceL2rYByRmbl39pyHXnhhgF2t/PXJGWyr46Z4cM+lstoYEC
         ng1q5SoAxnWxwwO31OUyN67zhhn7wzz8ED0GHNdCvRdpFG9M2Ex1tnm+dg8CvRWn+dHr
         9W9/iL0dquKYLp5qXFyTgOI9/1rjE4JQYG63PgN4cI8IVbfabWl9Cm5l3KukrGEcqkwD
         pVyw==
X-Gm-Message-State: AOJu0YzdO5J3bE/xOVIUvJH6b+ediiq72vsS5tuYA17W//Jno9iCGOws
	Mrq8FYBtFPznLW3MGJpuAUoXyrQYi2GMwR/gsWLmnV/+N/XR6HsjM9DUSGiWBRGGeHTz1+YrNJ0
	3ne/8cbzzhnPoBNVKXdUcL30yV1fwoVl6cXJDCwumFlutFlOu8GpNvWiFkXY6KHtB1t/SlOW8lG
	U07H/L5Z4NIWFQRUrmERkFNDWqOob9pj1CDyfb0iMQr6qZc6cs
X-Gm-Gg: ASbGncsCbPD4xy6j326SflrnjnDxHZvuZc+HnpOYbRm7/bKMekrZ13IqcfdvTrU5pGO
	g+6uwnXaEltUK54w8yIVyS9h7zQnWH1suArbtMaRDM+spwpyKEkrdJ+dgEibz+mhaJ7ZUwXkmkl
	frHsNGTuS36sJiu4BO/cTUSrKwBm2efA5cf3cXHMl9KwfeXx7J1pYi1C2JrqOLhLwJ9HGsvKYYA
	c4KhJfuo+IoHM1a/uxTmbvKMOrDYQcXYDbTSJH6BO237cposTLvbJDhU6t5zIdtxXdagW4CDI1c
	dnpRPb66iSNiCMF02GkbHk9Et7ZKkdWHADVx5BWhOxjB8RZAR254BQKAWfcT1g2oZlXoeMMVu3w
	qxcnhHF8z160oqJqZ5Bmj5/6qnCjcCQW8uXEHzhUTaGgCAGRmsA4AxSEpkpzSBtIk
X-Received: by 2002:a5d:5885:0:b0:3a4:eecd:f4d2 with SMTP id ffacd0b85a97d-3b61b2188bdmr9213726f8f.38.1753092638627;
        Mon, 21 Jul 2025 03:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr9Bj7npF3emkZ6nnaN3iiQO29Uc95teKauJtipnBERj6xbTMIzTBxhnuJwBBOmhGP/0a7rw==
X-Received: by 2002:a5d:5885:0:b0:3a4:eecd:f4d2 with SMTP id ffacd0b85a97d-3b61b2188bdmr9213656f8f.38.1753092637918;
        Mon, 21 Jul 2025 03:10:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f? (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48719sm10064791f8f.47.2025.07.21.03.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 03:10:37 -0700 (PDT)
Message-ID: <5dffdbca-c576-489c-b84a-ec2747cfbc21@redhat.com>
Date: Mon, 21 Jul 2025 12:10:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Usama Arif <usamaarif642@gmail.com>,
 SeongJae Park <sj@kernel.org>, Jann Horn <jannh@google.com>,
 Yafang Shao <laoar.shao@gmail.com>, Matthew Wilcox <willy@infradead.org>
References: <20250721090942.274650-1-david@redhat.com>
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
In-Reply-To: <20250721090942.274650-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Two additions:

> 
> (E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are not
>      disabled completely


As raised off-list, this should be "only if THPs are disabled completely"

> 
>      Only indicating that THPs are disabled when they are really disabled
>      completely, not only partially.
 > > The documented semantics in the man page for PR_SET_THP_DISABLE
> "is inherited by a child created via fork(2) and is preserved across
> execve(2)" is maintained. This behavior, for example, allows for
> disabling THPs for a workload through the launching process (e.g.,
> systemd where we fork() a helper process to then exec()).
> 
> There is currently not way to prevent that a process will not issue
> PR_SET_THP_DISABLE itself to re-enable THP. We could add a "seal" option
> to PR_SET_THP_DISABLE through another flag if ever required. The known
> users (such as redis) really use PR_SET_THP_DISABLE to disable THPs, so
> that is not added for now.

I don't think there is any user that would try re-enabling THPs through 
that interface. It's kind-of against the original purpose (man page): 
"Setting  this  flag  provides a method for disabling transparent huge 
pages for jobs where the code cannot be modified ..."

So if ever really required, one could investigate forbidding re-enabling 
once disabled. But that obviously needs more investigation.

(also, if a workload ever enables THPs through that mechanism, probably 
it is to blame)

-- 
Cheers,

David / dhildenb


