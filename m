Return-Path: <linux-kernel+bounces-751757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C6B16D10
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27931AA2915
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4C1A0B08;
	Thu, 31 Jul 2025 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gthW6Hk0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34EC13D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948922; cv=none; b=RQns1/MhdHS4qYuLbxY6riZdWbc1nzWvVfWcHoFFuEz72dvAwKc4K0X31Am8zeX065Zd8ntS9fJ0Jx4mqUeLXmTTj1pWaHtYuyXl4OaVPzVX3c1iUbYBvG+56HlnwETXX1CyTR/Q739koUlDrm/kUJRDx5szFSeY2N/2nY9gEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948922; c=relaxed/simple;
	bh=LcAqJ7x/hkHgTux6gZtuAebLsx1Ln3OpuPN9qKEn+CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cO+omGcc9BWfQDrkC+NLkUNa+0uU4sQb/FtGuQqo6T3etGESkJ63uIplDGdbMTmcSfdrQJ/A6BvFVrRQWzUL2LiKtb9a1ipPDztbqn487g80DgFuSCLmIKAkMwtMYKPPC/90uCIAGQ3pFb+pXOisLiO/5WDEvz/q5BKxhicQhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gthW6Hk0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753948919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1JJijs4W2vHC2VDBttSaecYsyLQnG1kUwLx2TkZowLU=;
	b=gthW6Hk0dAPLVloyLrzolhUPTymnEHe653C9JJsl2jO36qOAtoDpLFYCZ1w4/9gnSyh3RE
	pvIiE5JbVEpkJccLYRfqTLUaZFT+Yt2A36xSkC1nDibLFexY7HgZv0vAUtfoRzbTRLlE11
	ifevNFjfV1iJYPpbWSkIWBQqhCyunuI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-YZqunstIM4ay89jgLV_S9g-1; Thu, 31 Jul 2025 04:01:58 -0400
X-MC-Unique: YZqunstIM4ay89jgLV_S9g-1
X-Mimecast-MFC-AGG-ID: YZqunstIM4ay89jgLV_S9g_1753948917
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45359bfe631so3040055e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753948917; x=1754553717;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1JJijs4W2vHC2VDBttSaecYsyLQnG1kUwLx2TkZowLU=;
        b=arBhI0juZIQv3lNWZif1kSWICYqWPBlKjCHiODsT4Yi+rhtpNwPBZpAIXSN4gsMooC
         tvmuT0x0obUNr8/pX0ATeuwBoPUMb608Tvq+s5vISdRBK4siIqiHMADTrAqvkskOz1LF
         UqBWYGrclGHka2w5wnqMrawS1SYH22hC+n7FoGxQHGG+78GdrkACGo7SFOEVd3udglY0
         f39wYN3y6DVGepneHMIZzqBBxVJPlazV9g2Mt6wBm+pNyHi3ayt4Lck3LVnS7tKzSFvY
         TUEVOxq2g4gnL5RDVWLok0zcxVxppGnf492NoMosC+HG2LWil+j5WAuGO9Zkx8mDiBV2
         6paA==
X-Forwarded-Encrypted: i=1; AJvYcCUXD660TuIH8W5m/texJ6HxM9khjA6tc/1+dsuoviu+ogn8VfSwv3z13BGne1cuHbOyJI9J1x2JfN88mac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOgeCexaljKBsWNjGRfeNgmy/yO3DgbrHKmUNg5/iZSjQJPHYB
	EiZVcnqlnvknp1ObXftGj2egASQgv5v9j+Wf5bW7RU2a4ZauewzzADosIhv2xLgk8SaoirbmjxM
	gam7LPVRK69RfT4utZCRUnnsiD3+AkGbuoSkP3KiPuHNgxbI4yIoSVErvQKJLIQ2GUA==
X-Gm-Gg: ASbGnctEh72XcCFU3KHyRQ7HZkjEfYfRI4UlOXiQ84ZzwYbkFjyeGarcbyzFuXAY0tl
	CRLo73VxNyC3ql+PLZ5VPEPFoe4N0mr5Hdr+TsHvR4C8CWi22HujLD2FyrJrXEnNBn1gAxbv0TZ
	eHYG1gjp3zNc7ZTAkMX7ADrDnGq7JTM/QaD0K4GWTWLPBUBGgh23uKY1VAHE51LoFdp8a6JzMsR
	p80LMR56s2+u+/xQ1Ow87IxFrh8khJUW+CXomLAz0jCMgjUCnxeK2KnLgjcC7z4u2vrUA0IaLAm
	m+FAeroyBVcDoGVvWd7xvVyjHzUmfUnpXCFqDU8BqW+XVl/hVt5hpI7mgn7mQA2aJGxoIdBVpyE
	rT0mkh6Ie/2Sw99wMd0WeK0rZ4rsOyOwssZnhmpbF4AFbNuZ0HEBcIeNgwpQP7UEwpIY=
X-Received: by 2002:a05:600c:8b77:b0:43d:fa58:700e with SMTP id 5b1f17b1804b1-45892ceaecbmr48174725e9.33.1753948916691;
        Thu, 31 Jul 2025 01:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyLz/naDKoYXO0ZrbHzB0TQqBQIY0shm63Y9kIehrjwG6I0rtLZZVVvO3oMjdHoQbbfXbHRw==
X-Received: by 2002:a05:600c:8b77:b0:43d:fa58:700e with SMTP id 5b1f17b1804b1-45892ceaecbmr48174345e9.33.1753948916261;
        Thu, 31 Jul 2025 01:01:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3700:be07:9a67:67f7:24e6? (p200300d82f443700be079a6767f724e6.dip0.t-ipconnect.de. [2003:d8:2f44:3700:be07:9a67:67f7:24e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a3038121sm10902415e9.1.2025.07.31.01.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 01:01:55 -0700 (PDT)
Message-ID: <33b6deba-a1bb-4515-a659-9822b5b13d95@redhat.com>
Date: Thu, 31 Jul 2025 10:01:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 15/24] KVM: x86/mmu: Extend guest_memfd's max mapping
 level to shared mappings
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, Gavin Shan <gshan@redhat.com>,
 Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fuad Tabba <tabba@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Tao Chan <chentao@kylinos.cn>,
 James Houghton <jthoughton@google.com>
References: <20250729225455.670324-1-seanjc@google.com>
 <20250729225455.670324-16-seanjc@google.com>
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
In-Reply-To: <20250729225455.670324-16-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.25 00:54, Sean Christopherson wrote:
> Rework kvm_mmu_max_mapping_level() to consult guest_memfd for all mappings,
> not just private mappings, so that hugepage support plays nice with the
> upcoming support for backing non-private memory with guest_memfd.
> 
> In addition to getting the max order from guest_memfd for gmem-only
> memslots, update TDX's hook to effectively ignore shared mappings, as TDX's
> restrictions on page size only apply to Secure EPT mappings.  Do nothing
> for SNP, as RMP restrictions apply to both private and shared memory.
> 
> Suggested-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


