Return-Path: <linux-kernel+bounces-754810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A433B19D04
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB069189627A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D859923B63C;
	Mon,  4 Aug 2025 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBt9lF+4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941142367AC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294262; cv=none; b=jaWWVa/jS9jyhc7mZGRYB9yViWO8sG33i0FfjkeKzKNQgJl19o0qykAlmbLOLwsvud6gmkwbxXkGlALDD9lyJzba2OzH9I3Rfx2vwHt1Oci4a0zwd1iiMV06/DDPoUTQDcc2jaBB4cACFpj4L3QGlzwWb/m9LgU0SRePQ0LOgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294262; c=relaxed/simple;
	bh=hfXdazH1DNfnrSbvveRBIAuIjbrrLtceqTPpzOrKWnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i02AiW8TfJdf7VJATaaYkJABYdqZXa3UyYzciPFClnnGTlX+ut0XHr/u7ZDPAVWEB1PzskJoqYM9kao5KiWKMDQv+LyYUTLzyNbK+/8eOyFTY22JuV3KIElN0YNj9B4etIJukYGhQVZp1swRgGWbL48PEmfjZUVV932tvPM7E90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBt9lF+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754294259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zEnfn65S30ERPs/XGnstuALMnDwrRUYoFQnMMJQxY+M=;
	b=EBt9lF+4H2hDTR8rnBSIdjr0PKTr3iHiv3G1oW15ZO0yYK4gEUv73z5JyOlIoDwZDuI1/B
	xiHAyfVhQUJJjUuUAik4DAd2RPbaIfylxmTwuYZLxiqmFW3d+1AfNUfiV13ng4U1ttn0MM
	dmqiK5qQbBM9m74nT/Je/284oFXz6Ks=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-hVft-onOPgSPFSZm0U6k2Q-1; Mon, 04 Aug 2025 03:57:38 -0400
X-MC-Unique: hVft-onOPgSPFSZm0U6k2Q-1
X-Mimecast-MFC-AGG-ID: hVft-onOPgSPFSZm0U6k2Q_1754294257
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7865dc367so2291361f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754294257; x=1754899057;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zEnfn65S30ERPs/XGnstuALMnDwrRUYoFQnMMJQxY+M=;
        b=mPjFfOHBWEBv2zqN2Tulpi0lq/sJTjPzJviT+XANgvjEi0UyUArV6nSmCakaGlLJpD
         UZIKGZBtlgr7pQbGfBrCxyB7oD/feCXn2FuEBlf/wJd4dSG5HxmZ12LKA0Wj/7HFnzkG
         hlnagpnMJ5m1X08/MdKMrKJC8yPmIWPo84uTyX2A7ugdjrrX1O8GO6RmezTc1g6E9eJ/
         RG7JBFF8OTF06F9GUsgpQ0ANjbwLpaeKEsTl38etHMoQVKsfl3xvjnQB9ybNNoZwhMk7
         qSLIshYbwVm7rykU7CsBYWtEwAzsuOTZfh1DmzUbeqczhn6cgSVYjxYQL5LSHLI9v+cC
         QRvw==
X-Forwarded-Encrypted: i=1; AJvYcCVHLvIZjtlTdWYVHHYnF4i15+syBtkrD0arOjbGZ58x4bpmFfdAApywaBofu2Kx33xJv5TYQauDtX/hhlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGKkFUmA6L5vr2mq/lUDhPko7XM10mIIUhITbfazWR3hcg6QY
	6/07uns+TSat3mbv9rvxTKhWR81UThJFsnxp7kZyUhMzDUYusk46diLwgqQbJg03+4bPPK/Gn8b
	UPFNRUR3ZyGN7Cm2f++g3rPXlL4HnkXknbSZkYbzMdaN2um1m5ZKOozRi/RBeFSO+xQ==
X-Gm-Gg: ASbGncsRMtFaCud/lIGDe03dfRRfGnbPruhjfHI7tzku5QD99E+38L6sE2GS5mlkfjQ
	vYLqrccQov0KOy9mFN9jE3j5xe2AURzZ9cxMN0WlOSmuMDrAXCAaU5Qpw7MuYULIF11y/aRo3kc
	4G1jYrhu3bJWoc5SCQzdmcB9qfh/heUedmEAPFh6NI62IgVAMzHgODEcb+mrybIty2ddIZotnd3
	hUO0953wbF05reKf1QNZ/QrhxemtnRhdMUgcWyJVpLLw/Tlx0LS+w/21s+Lo5SS8S2/4Jtg9vWg
	2VjmPh8PtRK0IjYbZJG2lbPvtYZnRO1oTHUkPVPSX5izMjdWnpburL2+TQgIVNqKstiHTDoXwdR
	zTPqWkkRtA8nO4TGE1V4wiGEkIoEIvjA+GxtAXBwZynNzY8DM2PPA4QWcONxX1VAzHRI=
X-Received: by 2002:a5d:64c4:0:b0:3b7:9b3f:1e1d with SMTP id ffacd0b85a97d-3b8d94bb165mr6185804f8f.33.1754294256901;
        Mon, 04 Aug 2025 00:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsqbc8gnOPT6CLzPVM6D3iHMXlsCPDfMrvXHulzSXMlqTzPaQDQ5jt5SrsJVVI7HeiFswFkg==
X-Received: by 2002:a5d:64c4:0:b0:3b7:9b3f:1e1d with SMTP id ffacd0b85a97d-3b8d94bb165mr6185777f8f.33.1754294256408;
        Mon, 04 Aug 2025 00:57:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm14584315f8f.67.2025.08.04.00.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:57:35 -0700 (PDT)
Message-ID: <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
Date: Mon, 4 Aug 2025 09:57:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: "Lai, Yi" <yi1.lai@linux.intel.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra
 <lokeshgidra@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, yi1.lai@intel.com
References: <20250607220150.2980-1-21cnbao@gmail.com>
 <aJAFrYfyzGpbm+0m@ly-workstation>
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
In-Reply-To: <aJAFrYfyzGpbm+0m@ly-workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 02:58, Lai, Yi wrote:
> Hi Barry Song,
> 
> Greetings!
> 
> I used Syzkaller and found that there is general protection fault in __pte_offset_map_lock in linux-next next-20250801.
> 
> After bisection and the first bad commit is:
> "
> a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
> "
> 
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250803_193026___pte_offset_map_lock/bzImage_next-20250801
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/250803_193026___pte_offset_map_lock/next-20250801_dmesg.log

Skimming over the reproducer, we seem to have racing MADV_DONTNEED and 
MADV_COLLAPSE on the same anon area, but the problem only shows up once 
we tear down that MM.

If I would have to guess, I'd assume it's related to PT_RECLAIM 
reclaiming empty page tables during MADV_DONTNEED -- but the kconfig 
does not indicate that CONFIG_PT_RECLAIM was set.

-- 
Cheers,

David / dhildenb


