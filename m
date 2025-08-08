Return-Path: <linux-kernel+bounces-760029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B0B1E5C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB0F44E2405
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F826A1A8;
	Fri,  8 Aug 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMdpNKgq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147112AE74
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646170; cv=none; b=Jr3lRCBtYOsUye32k5i4WQUHojLrCwPupyaYClm+lA4waGoaRTQR2AKa4aq4Xh6DFLoFgiL/soqDch78SHIyZEGGdGCPtqlM1RnODrbuA7bFs7ytObx6Nr7GZHcyAvlxB/v+5R/nYXpfrejx3JLFed9Qvo4x1Ynhsob3xa8+aiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646170; c=relaxed/simple;
	bh=p3XMdzW6JxbkRUJn07vYxXCoqpYc5DTRVxZnI34cNbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbNjsNX1t9OzJElAGYkg4cOXPN4a1PzDtjA7+CF6PvBod9YXMrYEXWd6ab+rrur9RRZHf/Q70wubU7Y4kbgjyFPHlhczQJSadvRGs7awPiHFv1y+6zPWXATc1tehr38Hg2Z+ve/taTmT1wA2CwVkXcBY5PCGLRF2hTWHLuLU0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMdpNKgq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754646168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0MrQzdrJbcnzVF+wkegO/u32eadRZC34/Y8ls/2HbFA=;
	b=YMdpNKgqLht/btT23dKRX3sZCUkIVYr1NscMZYHclbflo5jPd8Q4ivuuTXguwWb3UuYR8u
	1exGUCbRDXc3s4b3p9VbunBxEJlDJ1vYQXsh/9VIZCA6OQkwBEg967HH69KOVY3KBC99vv
	ZWM8/HCkekKGWI+oUMeILxOia3UcMcM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-no3fS5LXMHqSSFp44cJJDA-1; Fri, 08 Aug 2025 05:42:45 -0400
X-MC-Unique: no3fS5LXMHqSSFp44cJJDA-1
X-Mimecast-MFC-AGG-ID: no3fS5LXMHqSSFp44cJJDA_1754646165
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459d3abb2b5so7120785e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754646165; x=1755250965;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0MrQzdrJbcnzVF+wkegO/u32eadRZC34/Y8ls/2HbFA=;
        b=RwS0C9jcA70c6rX/NJ59ua1x+5igVuSUdhM8HRGZLf8FbZQ+YEz5q51T7C3COsXqPH
         ssrPCCjkqujTHu9hTI8www/oa2RAMlA0HDXLyVtCnWNgaBVen+iOGlf41FcX/J51UzCi
         gxIHgBM+WsHiK1sR+w4XjjfYk49umrVk+cfrhnOEPGbVAWHs4bIiCccLQ6Jd3eaaTFdD
         v0wjFNb1Ykhw3pDAmSDvvIAkvlNshtCQkYniPs/2F7M1hv+bRyN2YLafAumwfY/WeV8R
         zVBnyQozfcueOhgMd80fXkTezOSe+6t8M00naf0fHhllzYAk0avId28kkzkn/LV90CLi
         GO3w==
X-Forwarded-Encrypted: i=1; AJvYcCWrQfUUEFShc1HFL2zF7vq2Wtql3CKnll/OGa+WtLUuJBGt316lHSHy/kcOniMPF8jNjf8tjCncX/9YerU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3BbM3HcsVhDJiIm7FBEKv+RtL16PY0fha3LGYuWUafPE8u/Ot
	MchUB1nkV8BHpgLnpnKfKdzQdkuOYABoLGb9zboVr8jaqNfAcDpIy1+6ojrYpcz6fMiilKknKLs
	vkO0ekuO9htoJVC4FbphClexjTlTrb9C1zB+/ueZNT5E2o+A6yq3lH4sJfHIQKw1ucmWtMXTR+g
	==
X-Gm-Gg: ASbGnctIcvGHk2kJpGN1SLyciIx6f3lak3YerbB3WsofCbvaxzJKSFUVQfTX1VZ7Uuk
	zRigEOnk+nRsZxoWpt+zWjHUnz5hPaG8fo2Fm/P0FjWO8L3sqAkeA52h0L4vBcagtZ0CyUgcqPN
	u//yQpDNT5+Cz+ehwtFaTKzXqfAeJ+626F8LdlkXwsRlvlFyqHtcWYOALOX5x4L7hYh3M99TeXW
	Z9ttdTgvLd0k7cHRGwihu/muGbRIsUvitOyFUA2yWecmQQNRjP+LYTgG/I4sm/MRypwKroQpiBv
	J4gNcCmwlxyINIWXRaR++zo4IKnHtTy2GkGlUbVw0ow3kHRHhX42VBFHDk7Lv/P0MYqlkgYhv3T
	wuQoR2hjqEfHs489SFM3mwJMvAlrHaCz8FVcXXc8jFIVQEv5YW1Svcn1ZQhIvtwbs
X-Received: by 2002:a05:600c:4e94:b0:456:1846:6566 with SMTP id 5b1f17b1804b1-459f4fa8a20mr16024995e9.29.1754646164719;
        Fri, 08 Aug 2025 02:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECbtEIdNMBLy0FLygd0cVTYC+gBMQpD+maXZQx9LpgpoUM3XCikyJgg1dewZlUjd3zovVfdQ==
X-Received: by 2002:a05:600c:4e94:b0:456:1846:6566 with SMTP id 5b1f17b1804b1-459f4fa8a20mr16024745e9.29.1754646164321;
        Fri, 08 Aug 2025 02:42:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6? (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de. [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5887b7fsm127134155e9.30.2025.08.08.02.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:42:43 -0700 (PDT)
Message-ID: <cd3c9744-c07e-4ab6-aba7-9392e431b9e9@redhat.com>
Date: Fri, 8 Aug 2025 11:42:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix the data type inconsistency issue of min (tier,
 MAX_CR_TIERS-1) in read_ctrl_pos
To: Qingshuang Fu <fffsqian@163.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>
References: <20250808092717.191444-1-fffsqian@163.com>
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
In-Reply-To: <20250808092717.191444-1-fffsqian@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.25 11:27, Qingshuang Fu wrote:
> From: Qingshuang Fu <fuqingshuang@kylinos.cn>
> 

See my other reply, (e.g., versioning), how you have to provide more 
detail on how to *actually* reproduce this (I cannot) and you ignored my 
comment about the patch subject.

-- 
Cheers,

David / dhildenb


