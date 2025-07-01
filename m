Return-Path: <linux-kernel+bounces-711024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E990AEF4C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 12:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE73C1BC6F71
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A152701BD;
	Tue,  1 Jul 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5guPKg2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92026E6E4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364949; cv=none; b=C4j5ZOFK2dl244gD9PLhMmroBxkeShOIspmLxmxvLsXLHdZAarZUzVQoA4rVgwr4Enz/xa+NLxOuzihkpgBDCbAM2S4WayIxFKYECZZFv1jXgeUac0ncTPiYrPpKekG6vK5G+GKWR6enz7a/7umy/9PiIK8jSwxeEK7QJ8gbxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364949; c=relaxed/simple;
	bh=nToQeFitzvpdsFa2XptVBAepU8eO4awOe3r5a/HWkVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI3s5M9ItPx5vXavChuvGoUbSNCKgs+Q3rVd0pQr04TvGJrVsdoGQa+WuFVU+CXT9rD+HR7gPxQ7udI0J26RRNDjgYMW09fzCNVdZySBwvhiAHidbJCHsnQP/bvEZ9npBK4WQyXgDv6C720XugNj0SSNTDR1VTaL4L4kB74lHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5guPKg2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751364947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J4Wnv9upb7wAm0VhLvAftXFWY5tUZLgFJPfWZ7TYeAU=;
	b=X5guPKg26l+Q6nEdaQysq0ZIie5jvi5r/QLqP+/48Nj/aWUfAonR3yf87Dig8sPb+fuWAR
	Iet3220IzbRIwqvAvTseyAg8AAxJpSXM1FHs7oYLQiFdd59Kc1X+SDVjsifNe4gN+C7f0E
	xsfgxDx/OrmY8IpT9v+YdZGEPsBs/5U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-Z5ThPJ4IPi2rEYZ-3jE9yA-1; Tue, 01 Jul 2025 06:15:45 -0400
X-MC-Unique: Z5ThPJ4IPi2rEYZ-3jE9yA-1
X-Mimecast-MFC-AGG-ID: Z5ThPJ4IPi2rEYZ-3jE9yA_1751364945
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so2716173f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 03:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751364944; x=1751969744;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J4Wnv9upb7wAm0VhLvAftXFWY5tUZLgFJPfWZ7TYeAU=;
        b=Wk/Z0NxdI5HwKfW+ovPNs48wMZJvRevwsC4GhTf9eNPgtlXjxJ/2FmfoQwZb9w8OaE
         fThNAng/eOnrvmtQtQK/KYqABW6CD1Un/aJ12ny4saUfdg3Ekbots+kKox8t9s2xCdbk
         VAYR9pKXhDhmOKGITqv6CX0pzu7gMiE5debDG2WGd6k8Hf5HMybRRUV209CadhnC2S5P
         ech/OJkduDAaSswJ2TQYPnrPrqAmOG2kdWy0fzCJcIyeJoDcNOyBaBEPP8KZMIODiMUY
         nXErcFl8XuFzzoC+vJdAKIDzszaqgv5OI4QXjcPRBlHQt6hwmdqXhPFlHTvWg0DLyatd
         aM6w==
X-Gm-Message-State: AOJu0Yzc6cbC3RHFJplx+pzjymhfgHHH20CbjETg92dJOGUktneM7BWV
	//EvqUQLd80UjsLwtQzp4ZQjZlj8VZ+vOuyjPx07AWwEKmRJwDYo6pvZtl1PvNoxrulb/3yin1O
	JMb1JKuC17clHWB5J3jhJGM+q9owi26U3OkCsKm54xs0USlbfb74ADcrZfxOdt/y1KQ==
X-Gm-Gg: ASbGncsxJby0DL04eGtocfvlwYPE3byMFojDBKEi5sy14tUUgAK1hpSXJKUP9dlAOcN
	bFYq+nj4osermiqyDYDDOKBKeYoAvo6us3MXpkDxB+bxxprilqVR+QgFtBrunUN2uyZf8pC9IjC
	cevaxeRp7ZjlGdHmvh/GnGiqICxFalpERTbfVyBd36w+zQEH3601LASekjW4Sq2l8jOZH+Hbaow
	NIclKrH4bOmSyMj4UcpMOlnZrrrA4YFbpnlpTQHVKkd1q3RgEKibW9j1B0GJAYnCy1/CbhP+F1v
	0Y9zea9m1AxmZ5t/+sv4/OUtgZce06OlSgA0mYhU+ssQj5kRxTS+lb6WEDOLAGiMLvvrhGMmK9e
	68yjRijr4kmgGbR/lPBdnymcXDr4WLdsapHmkRzDPgGbzbvT2HQ==
X-Received: by 2002:adf:9dd1:0:b0:3a4:f63b:4bfc with SMTP id ffacd0b85a97d-3a8ffcc9f0cmr13281188f8f.34.1751364944498;
        Tue, 01 Jul 2025 03:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBcN+deUjqfPetiJ/myiyifjCnu6+sl2jGKUFJOp6xe1gkfchpSA8Op3NtcLea2c6cf5QT6g==
X-Received: by 2002:adf:9dd1:0:b0:3a4:f63b:4bfc with SMTP id ffacd0b85a97d-3a8ffcc9f0cmr13281122f8f.34.1751364943981;
        Tue, 01 Jul 2025 03:15:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234be76sm191227645e9.15.2025.07.01.03.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 03:15:43 -0700 (PDT)
Message-ID: <3887c07c-db95-41a2-a3c6-c1199005cdd0@redhat.com>
Date: Tue, 1 Jul 2025 12:15:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/29] mm/migrate: remove folio_test_movable() and
 folio_movable_ops()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-11-david@redhat.com>
 <100ed589-d3cf-4e31-b8d1-036a8bf77201@lucifer.local>
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
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
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
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <100ed589-d3cf-4e31-b8d1-036a8bf77201@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 19:07, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:51PM +0200, David Hildenbrand wrote:
>> Folios will have nothing to do with movable_ops page migration. These
>> functions are now unused, so let's remove them.
> 
> Maybe worth mentioning that __folio_test_movable() is still a thing (for now).

"Note that __folio_test_movable() and friends will be removed separately 
next, after more rework."

Thanks!

-- 
Cheers,

David / dhildenb


