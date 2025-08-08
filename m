Return-Path: <linux-kernel+bounces-760014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20306B1E5A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42173B8B92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB623F417;
	Fri,  8 Aug 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWH+IkQx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8321B9D2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645577; cv=none; b=pzCbIhH0HFF0bgHxEAlQaIRIXuXKwdCM9m2+hsPLEWM1S9Mlr6mSzEoKcgz11Fx+JYwXR+/RgcTOGhsWFz2YplzoseKvePIY/KksRT1jq1Hq26x09f0/bvrwIywJuU2J1Kjsti06+CPEydN5cVXEL2XnGfSSVHo46bqfQDA4wRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645577; c=relaxed/simple;
	bh=Pb+4oYTXuL+GYaaVWl4sKWH332q9FnJV/oKMH2EQ6qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfWYOMYuAdxFRjMJTeItWSTxbfqMPoetv41hQ6z5134jEM+pyPzmx4qid0QIShsXSGMq4hRzMvs5c94H7ONXvfH0QjYmZjLNbkeSY6/LWapcHzqhQ4GB9aYSkETiDQTFWt46bp09/jqSatDnblUaSQuoX8/Weh3UHI2O85hsBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWH+IkQx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754645573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8fqawn29acQYTvV5f2qtOAfggWuwJrZMxIhaMzrXxiY=;
	b=IWH+IkQxSDv2WtrlGFg5NPC/Vvp4PDG/DcLQNO0Uu/ny/PQyI6UUwJ6igQL0FFHcrUBRK0
	cbxYgN4Mm5a2qLhTe3Wlgvtub1E9XvIE5lcihUIjwnbHGKEFWCB5G5RsuEUOqIyRZUdPBl
	sA13TbRiI227mpKRS4F15CZoT0sGO9Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-5k3w6rtOPeK9-LQMzXZq0A-1; Fri, 08 Aug 2025 05:32:52 -0400
X-MC-Unique: 5k3w6rtOPeK9-LQMzXZq0A-1
X-Mimecast-MFC-AGG-ID: 5k3w6rtOPeK9-LQMzXZq0A_1754645571
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b793f76a46so1342921f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754645571; x=1755250371;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8fqawn29acQYTvV5f2qtOAfggWuwJrZMxIhaMzrXxiY=;
        b=sjELPOMmf/98p8nOpQEaNNEW/68ebidJIQ7rNLPOjUK46nIaAEZ3k5RzqlGlQ4Ip7m
         SzeMGOwUqlqKnByTQnlmLr1iC+KqP5LcaD9pBDhCSYPScDccc03GebuGzogaD0UFXSPq
         kWxycEqwUAF9n3aSMvIfWaz7oGRS1iTlONxxvQ4sADjM6S6//EhKv/ZeUnlQTtPv6tqh
         KOYmlHxjzIJRUz9bCihAcxlBPVCqo3e/wxQaxHDVR5k6j6DM6mF2nkeBRssO30UXOjyR
         WishoIjR0K3DwmpHNgoI61/sZHUs3FaJIDNz7+X5ktuq2Y3xdwQtaKsXkAf53HSe5tv3
         wO2A==
X-Forwarded-Encrypted: i=1; AJvYcCW/bobo/Fdj6IWNYqBMDkMzql3DxgCYbRX4AgiIaijA1P+KLH3fDm4WJLNGi+fxV80eBgZ85GX8fpXhuys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+2WbEdstJXYVJpT4jLWobA+PQaP2DR+fK4g32ppL7BBNG+eU
	U+K9SEw91ZLFxxmzJ38hBDMGbkS5G9YETY7Lsnrx8U9ZDQyZ3I+DQ2foOf47JfsvlwZ9SgAO4bg
	GnVdQaltjVWlcFML24kqlnYGjshH826klrhpw4YR1Mf06Gl6VL3LqIW4IX4tuTk/wYQ==
X-Gm-Gg: ASbGncspfdYu0Iq3exHrD8e0+c3rPMwp5OOtP8aFBiwEbrLbuZ28ZHvdbaR/ZgTdnDZ
	+VjNdXrWwld4soa1ESbfcb9rF619kMLxU9Truv4VBKuCWLTlsKcVc9Htm5f/gpWOcnX1LrdkAd5
	+nP6gwCdsQUGFT4hpndHHxnZSEaLjxBY5LI8VQCBszHbDEy9nR+aca0CQA1AnmccgKj764XUF/j
	QSolqJaegw8TghqVB0Y6lKH7gVmi5mTxpBxFd5zrs1ykBZEUD2wd63TzXTzneJxTdW1PO46377v
	84WHetyAmOMEp988lax/PRMRDtNqFEVzyVDwpLDcdzvYBcMNCOSEHbnDV/RnP7k/TQHcnsQpyDG
	VGaQxstdwRjVFgE/9NAn8dD9SjMXcmA8EcR0v7T88VQZb9LdPuLWyz1Gj3DtOvbbD
X-Received: by 2002:a05:6000:18a9:b0:3b7:e3c3:fbb6 with SMTP id ffacd0b85a97d-3b900b7b012mr1960524f8f.31.1754645571139;
        Fri, 08 Aug 2025 02:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdsifZDD507tJMgAw/08JXefbfz0MKtE3hTWOJ4TApQ3mJ6Uysv1ySPif0mWJ4aM5BAsYn8A==
X-Received: by 2002:a05:6000:18a9:b0:3b7:e3c3:fbb6 with SMTP id ffacd0b85a97d-3b900b7b012mr1960499f8f.31.1754645570690;
        Fri, 08 Aug 2025 02:32:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6? (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de. [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac115sm29745063f8f.12.2025.08.08.02.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:32:50 -0700 (PDT)
Message-ID: <00e75d85-45ce-4248-815b-0c03d589a29d@redhat.com>
Date: Fri, 8 Aug 2025 11:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix the data type inconsistency issue of min (tier,
 MAX_CR_TIERS-1) in read_ctrl_pos
To: fffsqian <fffsqian@163.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>
References: <20250808072106.153449-1-fffsqian@163.com>
 <91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
 <3d57fccc.8a13.1988900f06e.Coremail.fffsqian@163.com>
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
In-Reply-To: <3d57fccc.8a13.1988900f06e.Coremail.fffsqian@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.08.25 11:26, fffsqian wrote:
> Hi David,
> 
> 
> Thanks a lot for your feedback!
> 
> 
> Regarding the question of why only I encountered this error: it’s 
> because my compilation environment has CONFIG_WERROR enabled (treating 
> warnings as errors). The original code triggers a static assertion 
> warning (due to the signed/unsigned mismatch in min(tier, 4U - 1)), 
> which would normally be a non-fatal warning. However, with 
> CONFIG_WERROR, this gets elevated to a compile error, making it visible 
> in my builds.

Does it?

$ make mm/vmscan.o
...
   CC      mm/vmscan.o
$ gcc --version
gcc (GCC) 15.1.1 20250521 (Red Hat 15.1.1-2)

What am I missing?

> 
> 
> The error message is as follows:
> 
> from mm/vmscan.c:15:
> 
> mm/vmscan.c: In function ‘read_ctrl_pos’:
> 
> ./include/linux/build_bug.h:78:41: error: static assertion failed: 
> "min(tier, 4U - 1) signedness error, fix types or consider umin() before 
> min_t()"
> 
> 
> I really appreciate your suggestions on the patch format issues—I’ve 
> addressed those as well, including adding fix information and 
> streamlining patch descriptions, etc.
> 
> 
> V2 of the patch will be sent shortly.

Please wait with v2 until the discussion is over. Also, flag your 
patches as v2 like [PATCH v2] etc.

-- 
Cheers,

David / dhildenb


