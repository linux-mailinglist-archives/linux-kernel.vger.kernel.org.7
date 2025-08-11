Return-Path: <linux-kernel+bounces-762070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD31B201CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAB41884F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267CC2DAFDE;
	Mon, 11 Aug 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLBdoGWF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110202DAFCF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900783; cv=none; b=QWj/EiXvFP9AOzwmjAV1DjaVwcE4Biz51WPwLWjbMHYm3neMEx1rox1t8wgHeTwMf4aRFT9y5oPqDwIW2qI/QdikXkTTCVr4yUszRh5e6fR0RA1uazcFWxRWHmEt7o3BZP1aLMP9lfHqT/7C0KJ6xvpTc4Pz+udZitjBsJMuJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900783; c=relaxed/simple;
	bh=ll38W//8msQJHh731EQE4l8FxqyFbBSeQczClWb+BSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjA/PcW2zJi082ymni75mk33rO401QIuq8dg2TZRHaCaZdTmVMZFzVFn7SdApWOOlKcIZ8le8U+GkF1pVzacFAar4milz7SUPHi3N4smR6kAHHcyTHk5ywjTOZ0DMjjYn3k+ndIbK/teaFyFpHYnVyZbjizoN1sI0ftoyxIcUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLBdoGWF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754900781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DjTKxkTe0tmF6ZqQmCfbJH473lyi+VVvJAAe6OH9uC0=;
	b=HLBdoGWFuEQ3HagbVlEHX4pFtbEziZ2+d8V7vAUySBrBbIWYDocYQrHWt/vuwYJKbRM/c/
	Y99czLHe29mz16/23rbXmbCiKDj8WIhWKMgMWgeY1ICB6w6Cmha96tjVPZWt108NTg6GsK
	FinnztD5UB7fQ3N6N5C5ybTNmLRuO9g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-5uVDyroONKesH6BuI48GvQ-1; Mon, 11 Aug 2025 04:26:19 -0400
X-MC-Unique: 5uVDyroONKesH6BuI48GvQ-1
X-Mimecast-MFC-AGG-ID: 5uVDyroONKesH6BuI48GvQ_1754900778
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459e02731a2so32315435e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754900778; x=1755505578;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DjTKxkTe0tmF6ZqQmCfbJH473lyi+VVvJAAe6OH9uC0=;
        b=s/dG+ySCqwnqDELmhnz6FKKPFyc610AmsgmRFn7jLwUzAXhwTGRxaz9Ncwpe7arw5K
         4Ve0zI6Mev2toLoN8E4ZrPzflHKuk2baR9N8/Kl3CbhXnxBJICH6jJO9xBQS+krdFl+F
         XirWKUqmKUk/v3osEBJPdMJzqpsAk6DzLJRHgVzrMf6NBy4Pwz3+ZHFKGtF1Wtn9qkGO
         cnAcezIo7zzMD+htqD0xkV7JQQ+h8uYptzq/i88sqdXrks+URZ6Fdq6GqAB9QtzuIYTl
         PMvzNIxCULM9r04PxWF57vWFO+C10IAM2faYVD1HN4NCVsbFromx8SZb9bffcEkTAT1L
         dktg==
X-Forwarded-Encrypted: i=1; AJvYcCURqWOHN7G6ADbqIS5tZLMidCUOsq+uZP+5jVky6jVD86NA2F4lTfl+nC4+jFedCKtmFCcRbPbNtpUczQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt72S7T9fBiRuqJHTeCu0Pb/7oV7w1GAckoG20kdqBoxNeOPeV
	3dYwyftCUKs25p40Z/bKgXAnPFRu5Cq4UCyEe77TqZUn8Q5uSTs3cO3k8mBtZwSdmVKhZpDCb+l
	evf7yjKpEEyqNai+9Y+Wh1CRZMuvXyKUN6sJKVbSL9Kwj9Vrr/qErKO1UbVuQxL/jXA==
X-Gm-Gg: ASbGncuv6lHhSzjBRnaIslKafPO3rqhn82CM1UtHVEJiuji6DcV2iUtcmXsN1tBnMMT
	C93WTrUNzVhbGFFYWjZ2T2DBPjq7VeMBuDhZxHGtZWBK0uvaSQ7bgNOFwp2Px2uk7YMOJvhFe1b
	Le3MPx65qZ4wZqhXuf14JWT90c45NGR9A88b6v7E9iBypAffCQLvgxawFPI6R3GrFrtCQApp7Ih
	Gmgz762UlyB/EbxwdFS9noN7m2/XUNxxpM9laCpcpItTnd+/FRXmsfXcb4Cfv7SKksDcv4rlti+
	xJNkPY2w7g3KYkwK57yu/UvOzAEp/3xnbJ2mSd1tmicRDwLbK/dvx1oa7KScy4xvPppYmnQz3ht
	nbGyjS5IlQCRY0qLhxqqQTpY0jW1oVk7Hc/RVkcdx3Insagk35Kp8HfOJqIQyIsHGuws=
X-Received: by 2002:a5d:64cd:0:b0:3b8:ff39:486d with SMTP id ffacd0b85a97d-3b900b470b8mr8495032f8f.8.1754900778415;
        Mon, 11 Aug 2025 01:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk6RKKxrY5nZ0KANzwIEQvIBjFFdFZPDE9g0xnnExj7Th5CeimssUgDeqgkKs0YNXeYtV/oQ==
X-Received: by 2002:a5d:64cd:0:b0:3b8:ff39:486d with SMTP id ffacd0b85a97d-3b900b470b8mr8495008f8f.8.1754900777940;
        Mon, 11 Aug 2025 01:26:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm17491078f8f.69.2025.08.11.01.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:26:17 -0700 (PDT)
Message-ID: <7fb6ce41-a5e7-496f-979b-775b8e30e764@redhat.com>
Date: Mon, 11 Aug 2025 10:26:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: Use max() to simplify
 hugetlb_vmemmap_optimizable_size()
To: Matthew Wilcox <willy@infradead.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250810214745.2368-2-thorsten.blum@linux.dev>
 <aJk2IygsxWKYf17u@casper.infradead.org>
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
In-Reply-To: <aJk2IygsxWKYf17u@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 02:15, Matthew Wilcox wrote:
> On Sun, Aug 10, 2025 at 11:47:45PM +0200, Thorsten Blum wrote:
>> Use max() to simplify hugetlb_vmemmap_optimizable_size() and improve its
>> readability.
> 
> That ... isn't clearer.

No, it isn't.

-- 
Cheers,

David / dhildenb


