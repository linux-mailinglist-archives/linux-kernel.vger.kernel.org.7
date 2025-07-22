Return-Path: <linux-kernel+bounces-740650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B40AB0D740
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3E4166CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D9F213E9F;
	Tue, 22 Jul 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFw5MEF/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BD28A1F3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179793; cv=none; b=LlTILlNPUeUThGGT5nkGtyky9PDcDN+wxSdFXSgWVMvfmt4/5D3W443Vyf6YQJKWYu0bzQ5gpXFtUgDk62feDrb3zop+Y2hG/jkizFnK3J+0glvTpDnXW5Kn6fZ6MD88K6xdhX6SmvyQScw5IaLOTBNupK42qq5hcrlKjb24JwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179793; c=relaxed/simple;
	bh=slxHmWQa2IX1KjBECU57VeVZrW8ZpxZCDYkUw56/CdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSlL8p0+m35kJNhQacJN4Z7t9y+j+OPHifmaqi0Mn4KBMPkpnH2hFy2HUvzcREBAwrwa5VmDUSctmZ2yPT+cFi9R93zTEON/rdVcOlqmOvY09jsv5EGo75I9PgSD9pHMdXoWqMK1w9SY8XdkaymCpZCb3n0Erkesv5Fwi7i7tKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFw5MEF/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753179790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m+S7Rk/Tf7EQpkhoT2UZDEzwJf1SEtYPp0YlOKuGPhg=;
	b=WFw5MEF/qVpfZTUpBH9lEBJmz7EPxMGeqpYQjUDBglEHugO/xMA87ZIIjJixKHEt8Lsixs
	FQXYLuIjylyPRoWXtuyYWwDj8ZQgQB9CqC4vegb0ubW/d5Tk0JGHL9DI6vSbvyO77s3crx
	Wc+kD2NpbAe7BKQahpoy6o7munjCkzw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-5eQAcotFPXieJkbSAChVPA-1; Tue, 22 Jul 2025 06:23:08 -0400
X-MC-Unique: 5eQAcotFPXieJkbSAChVPA-1
X-Mimecast-MFC-AGG-ID: 5eQAcotFPXieJkbSAChVPA_1753179787
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4563f15f226so10164835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753179787; x=1753784587;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+S7Rk/Tf7EQpkhoT2UZDEzwJf1SEtYPp0YlOKuGPhg=;
        b=wxdVBLlK5pZ0AhL+4LZqwjD9yLhiKPs7bD3VAbfEcKf+0pgv84M8CFU4FvLWG3V6D+
         dVPHErLleP4ttczmNLqDF3OzDjw4AJ89ITPCXIZonZWH1x3GT2Qbw0cu6aVCyS3/+0kN
         s3Xf1UwlSXDIwGTIyfC4Ap/5lp0Xs/NfHgvqkgMY6Y4P9NK41a2H2hhVGfB/X+r/jACM
         LeJqJ11Gz6NygH7IcGY7V3004Oy1gzyhBFOeRzOhLjVt5rYh5pyodwjmbW7bMmdKjcfw
         KWPlqORR78xekUBrJTACj6UCrgYGUpfYowAhh8kHa7mkpDdOV1orOUepcLWiYqDiTZMc
         X/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW3aLFteMINMt3Ks/ruMT83KgBggcNBOUcJAkti3e36yPfW7KpyIHLCsuFFA2hJsv1VHW0hHzRhnHmoCgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0U1tb0orTCyW+CKlGZZeGWufJURg+5jbu0ax1BvibJXCdhjEX
	Hl2yS2FAddmpDW/0XIRAvi6Z86/p+vaN+bc5pB9/2W2p78lPeyJDVsL0JFu7CZUfQDRnfzRQ+vh
	FX+ZeEZ4Bia5NdL/tiYDIl4BkcWI0FUY/X2qLHpaUgIAhaEzmRy4/Euf1TWhIuANHuQ==
X-Gm-Gg: ASbGncsf9bojTu14ImgDIPaoow1eMVe2YNAJl0uB3FI87PIAvLbfnkp5KNbDYxkr8f2
	abjAVwZTnMD/5eULDN/Hejs7tqYXD3KgnqkEdEqrU6Fr97oD+srtCmJVWnoNf1PSJ7jFCpb2Z/L
	9JiD0Hq9txIbQzkNylQpRexKY5CNuZ1EeSJqOQOMltqSJ0FVOvx7g8Fkz0Xb7+s8syUB9eT+HjH
	OzYStF5L1xGhUV4Q/JsaOzZXAioZlgmAEsk5Hz1ZS35YAjSXurF1qz5kTog6UbTSgdnOL3ILDdC
	fI39nUQ8jiS6jXlGeCr9LBs5ZHUgKmRTa0fpE0teI+e9dRB3YFFtKk/S5bw4hc67emTJi+M30Pr
	eFM9kNbXw5mwVFZwkGMZtQplKS7ZiQG7amL+FIYh+K6XsUQi4mMmqvJqZPqoNdQ8PY/o=
X-Received: by 2002:a05:6000:5c7:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b61b0f0b18mr12228808f8f.16.1753179786943;
        Tue, 22 Jul 2025 03:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFRtybMjsg2qZlLIP8yQk8M1mE4cW59qFxe3Fb0Sb770Vp8GPrX4xLPrDvnT/TaspBcH7F1A==
X-Received: by 2002:a05:6000:5c7:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b61b0f0b18mr12228777f8f.16.1753179786323;
        Tue, 22 Jul 2025 03:23:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2b81asm13053693f8f.20.2025.07.22.03.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:23:05 -0700 (PDT)
Message-ID: <5968efc3-50ac-465a-a51b-df91fc1a930a@redhat.com>
Date: Tue, 22 Jul 2025 12:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
 Jann Horn <jannh@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20250721090942.274650-1-david@redhat.com>
 <4a8b70b1-7ba0-4d60-a3a0-04ac896a672d@gmail.com>
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
In-Reply-To: <4a8b70b1-7ba0-4d60-a3a0-04ac896a672d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.07.25 19:27, Usama Arif wrote:
> 
> 
> On 21/07/2025 10:09, David Hildenbrand wrote:
>> People want to make use of more THPs, for example, moving from
>> THP=never to THP=madvise, or from THP=madvise to THP=never.
>>
>> While this is great news for every THP desperately waiting to get
>> allocated out there, apparently there are some workloads that require a
>> bit of care during that transition: once problems are detected, these
>> workloads should be started with the old behavior, without making all
>> other workloads on the system go back to the old behavior as well.
>>
>> In essence, the following scenarios are imaginable:
>>
>> (1) Switch from THP=none to THP=madvise or THP=always, but keep the old
>>      behavior (no THP) for selected workloads.
>>
>> (2) Stay at THP=none, but have "madvise" or "always" behavior for
>>      selected workloads.
>>
>> (3) Switch from THP=madvise to THP=always, but keep the old behavior
>>      (THP only when advised) for selected workloads.
>>
>> (4) Stay at THP=madvise, but have "always" behavior for selected
>>      workloads.
>>
>> In essence, (2) can be emulated through (1), by setting THP!=none while
>> disabling THPs for all processes that don't want THPs. It requires
>> configuring all workloads, but that is a user-space problem to sort out.
>>
>> (4) can be emulated through (3) in a similar way.
>>
>> Back when (1) was relevant in the past, as people started enabling THPs,
>> we added PR_SET_THP_DISABLE, so relevant workloads that were not ready
>> yet (i.e., used by Redis) were able to just disable THPs completely. Redis
>> still implements the option to use this interface to disable THPs
>> completely.
>>
>> With PR_SET_THP_DISABLE, we added a way to force-disable THPs for a
>> workload -- a process, including fork+exec'ed process hierarchy.
>> That essentially made us support (1): simply disable THPs for all workloads
>> that are not ready for THPs yet, while still enabling THPs system-wide.
>>
>> The quest for handling (3) and (4) started, but current approaches
>> (completely new prctl, options to set other policies per processm,
>>   alternatives to prctl -- mctrl, cgroup handling) don't look particularly
>> promising. Likely, the future will use bpf or something similar to
>> implement better policies, in particular to also make better decisions
>> about THP sizes to use, but this will certainly take a while as that work
>> just started.
>>
>> Long story short: a simple enable/disable is not really suitable for the
>> future, so we're not willing to add completely new toggles.
>>
>> While we could emulate (3)+(4) through (1)+(2) by simply disabling THPs
>> completely for these processes, this scares many THPs in our system
>> because they could no longer get allocated where they used to be allocated
>> for: regions flagged as VM_HUGEPAGE. Apparently, that imposes a
>> problem for relevant workloads, because "not THPs" is certainly worse
>> than "THPs only when advised".
>>
>> Could we simply relax PR_SET_THP_DISABLE, to "disable THPs unless not
>> explicitly advised by the app through MAD_HUGEPAGE"? *maybe*, but this
>> would change the documented semantics quite a bit, and the versatility
>> to use it for debugging purposes, so I am not 100% sure that is what we
>> want -- although it would certainly be much easier.
>>
>> So instead, as an easy way forward for (3) and (4), an option to
>> make PR_SET_THP_DISABLE disable *less* THPs for a process.
>>
>> In essence, this patch:
>>
>> (A) Adds PR_THP_DISABLE_EXCEPT_ADVISED, to be used as a flag in arg3
>>      of prctl(PR_SET_THP_DISABLE) when disabling THPs (arg2 != 0).
>>
>>      For now, arg3 was not allowed to be set (-EINVAL). Now it holds
>>      flags.
>>
>> (B) Makes prctl(PR_GET_THP_DISABLE) return 3 if
>>      PR_THP_DISABLE_EXCEPT_ADVISED was set while disabling.
>>
>>      For now, it would return 1 if THPs were disabled completely. Now
>>      it essentially returns the set flags as well.
>>
>> (C) Renames MMF_DISABLE_THP to MMF_DISABLE_THP_COMPLETELY, to express
>>      the semantics clearly.
>>
>>      Fortunately, there are only two instances outside of prctl() code.
>>
>> (D) Adds MMF_DISABLE_THP_EXCEPT_ADVISED to express "no THP except for VMAs
>>      with VM_HUGEPAGE" -- essentially "thp=madvise" behavior
>>
>>      Fortunately, we only have to extend vma_thp_disabled().
>>
>> (E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are not
>>      disabled completely
>>
>>      Only indicating that THPs are disabled when they are really disabled
>>      completely, not only partially.
>>
>> The documented semantics in the man page for PR_SET_THP_DISABLE
>> "is inherited by a child created via fork(2) and is preserved across
>> execve(2)" is maintained. This behavior, for example, allows for
>> disabling THPs for a workload through the launching process (e.g.,
>> systemd where we fork() a helper process to then exec()).
>>
>> There is currently not way to prevent that a process will not issue
>> PR_SET_THP_DISABLE itself to re-enable THP. We could add a "seal" option
>> to PR_SET_THP_DISABLE through another flag if ever required. The known
>> users (such as redis) really use PR_SET_THP_DISABLE to disable THPs, so
>> that is not added for now.
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Usama Arif <usamaarif642@gmail.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Cc: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> ---
>>
>> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
>> think there might be real use cases where we want to disable any THPs --
>> in particular also around debugging THP-related problems, and
>> "THP=never" not meaning ... "never" anymore. PR_SET_THP_DISABLE will
>> also block MADV_COLLAPSE, which can be very helpful. Of course, I thought
>> of having a system-wide config to change PR_SET_THP_DISABLE behavior, but
>> I just don't like the semantics.
>>
>> "prctl: allow overriding system THP policy to always"[1] proposed
>> "overriding policies to always", which is just the wrong way around: we
>> should not add mechanisms to "enable more" when we already have an
>> interface/mechanism to "disable" them (PR_SET_THP_DISABLE). It all gets
>> weird otherwise.
>>
>> "[PATCH 0/6] prctl: introduce PR_SET/GET_THP_POLICY"[2] proposed
>> setting the default of the VM_HUGEPAGE, which is similarly the wrong way
>> around I think now.
>>
>> The proposals by Lorenzo to extend process_madvise()[3] and mctrl()[4]
>> similarly were around the "default for VM_HUGEPAGE" idea, but after the
>> discussion, I think we should better leave VM_HUGEPAGE untouched.
>>
>> Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" where
>> we essentially want to say "leave advised regions alone" -- "keep THP
>> enabled for advised regions",
>>
>> The only thing I really dislike about this is using another MMF_* flag,
>> but well, no way around it -- and seems like we could easily support
>> more than 32 if we want to, or storing this thp information elsewhere.
>>
>> I think this here (modifying an existing toggle) is the only prctl()
>> extension that we might be willing to accept. In general, I agree like
>> most others, that prctl() is a very bad interface for that -- but
>> PR_SET_THP_DISABLE is already there and is getting used.
>>
>> Long-term, I think the answer will be something based on bpf[5]. Maybe
>> in that context, I there could still be value in easily disabling THPs for
>> selected workloads (esp. debugging purposes).
>>
>> Jann raised valid concerns[6] about new flags that are persistent across
>> exec[6]. As this here is a relaxation to existing PR_SET_THP_DISABLE I
>> consider it having a similar security risk as our existing
>> PR_SET_THP_DISABLE, but devil is in the detail.
>>
>> This is *completely* untested and might be utterly broken. It merely
>> serves as a PoC of what I think could be done. If this ever goes upstream,
>> we need some kselftests for it, and extensive tests.
>>
>> [1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gmail.com
>> [2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gmail.com
>> [3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@oracle.com
>> [4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local
>> [5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.com
>> [6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com
>>
>> ---
>>   Documentation/filesystems/proc.rst |  5 +--
>>   fs/proc/array.c                    |  2 +-
>>   include/linux/huge_mm.h            | 20 ++++++++---
>>   include/linux/mm_types.h           | 13 +++----
>>   include/uapi/linux/prctl.h         |  7 ++++
>>   kernel/sys.c                       | 58 +++++++++++++++++++++++-------
>>   mm/khugepaged.c                    |  2 +-
>>   7 files changed, 78 insertions(+), 29 deletions(-)
> 
> 
> Thanks for the patch David!
> 
> As discussed in the other thread, with the below diff
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 2a34b2f70890..3912f5b6a02d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2447,7 +2447,7 @@ static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
>                  return -EINVAL;
>   
>          /* Flags are only allowed when disabling. */
> -       if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
> +       if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
>                  return -EINVAL;
>          if (mmap_write_lock_killable(current->mm))
>                  return -EINTR;
> 
> 
> I tested with the below selftest, and it works. It hopefully covers
> majority of the cases including fork and re-enabling THPs.
> Let me know if it looks ok and please feel free to add this in the
> next revision you send.
> 
> 
> Once the above diff is included, please feel free to add
> 
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Tested-by: Usama Arif <usamaarif642@gmail.com>

Thanks!

The latest version lives at

   https://github.com/davidhildenbrand/linux/tree/PR_SET_THP_DISABLE

With all current review feedback addressed (primarily around 
description+comments) + that one fix.


> 
> 
> Thanks!
> 
>  From ee9004e7d34511a79726ee1314aec0503e6351d4 Mon Sep 17 00:00:00 2001
> From: Usama Arif <usamaarif642@gmail.com>
> Date: Thu, 15 May 2025 14:33:33 +0100
> Subject: [PATCH] selftests: prctl: introduce tests for
>   PR_THP_DISABLE_EXCEPT_ADVISED
> 
> The test is limited to 2M PMD THPs. It does not modify the system
> settings in order to not disturb other process running in the system.
> It checks if the PMD size is 2M, if the 2M policy is set to inherit
> and if the system global THP policy is set to "always", so that
> the change in behaviour due to PR_THP_DISABLE_EXCEPT_ADVISED can
> be seen.
> 
> This tests if:
> - the process can successfully set the policy
> - carry it over to the new process with fork
> - if no hugepage is gotten when the process doesn't MADV_HUGEPAGE
> - if hugepage is gotten when the process does MADV_HUGEPAGE
> - the process can successfully reset the policy to PR_THP_POLICY_SYSTEM
> - if hugepage is gotten after the policy reset
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>   tools/testing/selftests/prctl/Makefile      |   2 +-
>   tools/testing/selftests/prctl/thp_disable.c | 207 ++++++++++++++++++++

Like SJ says, this should better live under mm, then we can also make 
use of check_huge_anon() and vm_utils.c and probably also THP helpers 
from thp_settings.h. Most of the helpers you use should be available in 
some form there already.

With THP helpers in thp_settings.h, you can explicitly set the system 
policy, to then reset to eh previous version IIRC.

Further, can you make sure to use kselftest infrastructure for the test, 
preferrably kselftest_harness.h? (see pfnmap.c on one of my latest 
selftests)

I also wonder if we want to test old behavior, without the flag set. We 
could also test that MADV_COLLAPSE doesn't succeed in either case.

Ideally, you'd send my patch (see above) along with the selftest, as I 
suspect there will be more review+changes to the selftest (and only 
smaller changes to my patch).

Thanks!

-- 
Cheers,

David / dhildenb


