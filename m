Return-Path: <linux-kernel+bounces-753109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F7B17EC7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189123B0518
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED3218584;
	Fri,  1 Aug 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyByzm2/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256118C02E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039049; cv=none; b=O7oBG0NnKQcZ1m6hH3hO0iTMe5oIs93KjKrGTYFIRXWxYfobVRnOOLpI+QOKubTNUkuDWTW60XSi4oaucCGsqpwbVkTsR3sgNUzDIZEI82Mst0z82T+avGeU5iA2MLmTDJDLsfghsQDXVnn0jwgZoJUHzasJJ22xRJVhbfBTe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039049; c=relaxed/simple;
	bh=sFV9KXYp/MnrGDlIESBjaoOTGiYwc/Vz3RTWHkWTvsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJQfbeR3IqPq4jqT/2EqJicO4EXujGYb20dsANqzlwNRDxQ+0w+xAnrrDnh2I940XiLwC7ecpx6OHrCWZ/9QL2WEnuDxycysRQzvRt8OL/485f2+yPqhRuM0Qr9acadigl2peoiZyTRy6cEdGaN3fv2qfQv9Aoss5EUiDBpRMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyByzm2/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754039047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cRD25sedaIjZXj+qDAPX+BDxoHBPtP+iWA8E9uH6ICo=;
	b=eyByzm2/Z5qDD8fuSalYKf1Oqj4rFLPJ7lGI8JvKs8E3N8lbbOPefEAsvSEG9qRWd6YG7p
	BZYsCY0hmTZZLTsoOzdL3DXyo7saRZnMcz4pk6mxQQAqeA5XYsLTIMqedWDtF+Tmr2mei1
	jF3+McbHpJgDj9bX2XxmMboerupJO9o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-g_xFi8CENfixbzk9L-1hrw-1; Fri, 01 Aug 2025 05:04:03 -0400
X-MC-Unique: g_xFi8CENfixbzk9L-1hrw-1
X-Mimecast-MFC-AGG-ID: g_xFi8CENfixbzk9L-1hrw_1754039042
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7886bfc16so742923f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 02:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039042; x=1754643842;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cRD25sedaIjZXj+qDAPX+BDxoHBPtP+iWA8E9uH6ICo=;
        b=bCg9I3uAfKXPDntn86OrgzUmSr9JRh1aMbXtsC8qWPZNs8Cw+pyP1agxDbGyJYYpNj
         iqeL1HKPhbQBXMfca0Ayugwo61XiZ+Ngn6YCbxjK7uX6mQgGb47rJ7wUXQ9KY313SyO1
         +tHEytKelsZnAUUxyhp3TqY2Uc0nYofCYmfITflNh0FHBFzSQKb/IWcOzFcokAykT+1m
         zIOSZcQa9CTYvEfOek35ceozAnc+brH7tWUXI/qEcj03G7Ym+DfbSNckQ4CLxJJ+YhkK
         YPAZSD+g/GxZHjYM9KqZxqwvPEn9SOK60/RDPAVjr3rj7IKsNpMCSYxS8RgV2o51E2W2
         DUBA==
X-Forwarded-Encrypted: i=1; AJvYcCUG9YvUS7m3YUSwyu25cy+XoZj9QibpvaXYz703POnKCyUXPtOnwa0QX0Mz1kInh2oRnj1j9hf+bKAc7OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4ooJyhxgkgMC6yN3gygBynDyFKEzZ1TM6t4ODxYqeyZHenRK
	4OvfpBlm0/0zneiChM2HESZJb24GI2Ermb4ZgsUPTjXVd86JrbHkD+dd/TgztwlSIsgeEC9Hd+u
	XntI5iCoxxaCBUIK4PzEp3YgAIHkVGPb4+IsOz1vbhssHswc1bRFCxRw/Gs8Jt1jGHQ==
X-Gm-Gg: ASbGnctW9M292BM+N/UKx0FOMdKL7nXI0dGOMt5/zUMGyq9+AG38XuOJfv3LWhKoGXE
	smovq3w5qxFqrJwlBC+ayvejFT0o9tmz5Hx3Oyy7j+UTaQZpOmhGgcjFo6wG6lAdhnm+yTZ53Jc
	vyvs/nXJAmxvgKYYtpSinf/0KnlFKVr/VugMtoEo56beuXeWlh8oC/hksWR6/KDWd075aUVLTJ5
	qimhgULBdXKN5VgdCR6hJdtNFgfPpIosJxDZGqfCOQrdbhK3TczEohDfWEs3hgcJvcLrjBzVw/7
	N6QXrJUYqQkYfAvOxawoZiawil/DgkwR12Av+thL01qgF7Xicc3V5j5czIt1nJIsyZcd8lWlT4X
	LS98blOsKxaxcuYUijjl/J26JIehUM/LspzydsH/IygHDjBJWIFHgLeYi6t+4hT3H
X-Received: by 2002:a05:6000:18a7:b0:3a4:f644:95f0 with SMTP id ffacd0b85a97d-3b8d34b0ecfmr1768517f8f.54.1754039042397;
        Fri, 01 Aug 2025 02:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK+KG8xlZVg9JksCn4O4NiosqBcdHpE5fmX/CIoMx9dQCMWNiuz57r3wjBfzb3dQXnmbtcbQ==
X-Received: by 2002:a05:6000:18a7:b0:3a4:f644:95f0 with SMTP id ffacd0b85a97d-3b8d34b0ecfmr1768474f8f.54.1754039041904;
        Fri, 01 Aug 2025 02:04:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57922sm57069765e9.22.2025.08.01.02.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 02:04:01 -0700 (PDT)
Message-ID: <3939866f-e57e-4caa-919a-558bf6866b82@redhat.com>
Date: Fri, 1 Aug 2025 11:04:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mempolicy: Clarify what zone reclaim means
To: SeongJae Park <sj@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ying Huang <ying.huang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Matthew Brost
 <matthew.brost@intel.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Alistair Popple <apopple@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20250731224155.1646-1-sj@kernel.org>
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
In-Reply-To: <20250731224155.1646-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.25 00:41, SeongJae Park wrote:
> On Thu, 31 Jul 2025 14:07:37 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
>> The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
>> memory. Contrary to its user-facing name, it is internally referred to as
>> "node_reclaim_mode".
>>
>> This can be confusing. But because we cannot change the name of the API since
>> it has been in place since at least 2.6, let's try to be more explicit about
>> what the behavior of this API is.
>>
>> Change the description to clarify what zone reclaim entails, and be explicit
>> about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
>> past already [1] [2].
>>
>> [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
>> [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
>>
>> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> ---
>>   include/uapi/linux/mempolicy.h | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
>> index 1f9bb10d1a47..6c9c9385ff89 100644
>> --- a/include/uapi/linux/mempolicy.h
>> +++ b/include/uapi/linux/mempolicy.h
>> @@ -66,10 +66,16 @@ enum {
>>   #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
>>   
>>   /*
>> + * Enabling zone reclaim means the page allocator will attempt to fulfill
>> + * the allocation request on the current node by triggering reclaim and
>> + * trying to shrink the current node.
>> + * Fallback allocations on the next candidates in the zonelist are considered
>> + * zone when reclaim fails to free up enough memory in the current node/zone.
> 
> s/zone when reclaim fails/when reclaim fails/ ?

Agreed, that confused me as well.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


