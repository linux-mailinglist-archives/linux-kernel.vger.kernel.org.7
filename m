Return-Path: <linux-kernel+bounces-727367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209A0B018F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6755C122E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2227E7E1;
	Fri, 11 Jul 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtF9bTyw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F827D781
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227933; cv=none; b=Xapu70O99PO2XEnLzJ45hT9f+vORdYjwJ6aHIDBjE6OFXoKdLBO5/YfGxAhVTxAdQ893OazBkju6TtYESTKQtEQJ1ieQ3bTHJoawDQ+nzlT1Fl6wBaAtpZdn+kJB10yMlQN/Oo2d61iV7UrnivmUIJ2Yt8E0zXJZgrMp/iOX4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227933; c=relaxed/simple;
	bh=jcwl1hcgxkhkVpibJEUIfNE7pqlQzKHmndBpD3OyFLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUJCj2ji8xWasafrIT/3F+mUmwHswzdn/E73JiXTnJZNGreyIZS2iDyCG7waaBbueTBCsdHyWt9EuB1tYVlXZmXg2uvz38ed5NL1Eu+5QyuXZmMWyzyqmNH5gB3Pz/Ui4E3lh/WB5JVjIv/QRTVFRldvv5Fkg63TaWXCo9uenOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtF9bTyw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752227930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+UKKl1tl/4X4RmJ4nRhAivPInQxndntWwMlFBpiS/So=;
	b=CtF9bTywY+U+Yj7Vcj3AlXUItYbKvfCww9JWcdA+u+FsD2uI331I2/9bE1Jw7JYoy0s5Tz
	VGFScqLrdUT6VDZOudrwsLFTX+DdfCTrz4qPN2jh1GL5NsAYdTm3VDicm5LQCIGfRdF+6j
	BxghmCGx0MS/7QwPfgazrSnYt/K+fhk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-bW6avyVyPymujg934UcF3g-1; Fri, 11 Jul 2025 05:58:48 -0400
X-MC-Unique: bW6avyVyPymujg934UcF3g-1
X-Mimecast-MFC-AGG-ID: bW6avyVyPymujg934UcF3g_1752227927
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso1011934f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227927; x=1752832727;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+UKKl1tl/4X4RmJ4nRhAivPInQxndntWwMlFBpiS/So=;
        b=JiulHVkNjqXyT+WtW6juGfs/Mky1Y9GpcTPnGZfrua+TKG3sHEy3x8lSG+7VXozwJg
         Br1HpBiZoWrBX+v6sI++9J0zq8lQFU1idCfdwjXAcNEInFMJOWTMkA7LAxXPXbnqzAjV
         y/d1XarxucCaWG92Swf6ee7STVmhT1Cn+W9VdgnLnqHju3z5FHiLa14VbXpwROn19lso
         hKDkApwLdJFytUiuZKQpupkH7NLB4o6xs8qT/Hx8kCyQg+NNWckDiDgAusI40DDUh8QV
         pTgS4o7fQ48ch3cK301V4Rhcl7bJWsHHem9ogfkSX8kg3y3gSFRuQE+VaCEAIHkvuJfr
         yPbA==
X-Gm-Message-State: AOJu0YzfPoXxPeGYEbczlHga4HxO/JGpUDUV3yKbe00PZ1n6diApj964
	Kodg5qSVja9ACNI4tN4gYm/sngwGQJEJppSJDzPV7gqZEjvzkItcUsd0Et+hhwf9Aa5nNysviJy
	q+0tWNH0dd6vO/pCSzp5B5kLw/FJ6uSk2CSBM9xnPVqjXEgsWW15V+Qp7Kowio7PdeBg6qf6SHD
	5xb6GVpOJkB1jvqZdyvQpYeTWXFnlVP8BnUD+lDTzO1LJZ4bL7
X-Gm-Gg: ASbGnctIBO+AU7KZE6Up6j1ZQnckBetm2RMMY3DWjnav273eDX5Fgqj/l8tnN6RYuqK
	cOEndMbPFxoKFnhqkqO5MvYr/wsrOEVAKgzUHYvdHoHrGPB8LrApB1DYLwLZp1tHg5zV4B3Uv5B
	UfUL1dQVe9UOoKKYIrBNdTEMXLxhejWdSW0dv6t6iqmGg7DIEx+wZHZl60nBKzlnf6vMYJQcNcM
	haLZVGeOwMpKVM+R2f+QF00X4QDoQhsVmYWhfO8UUEdJUIxarKA2g9ePjWGt6GpAlFpBU8soFum
	26HDfhkmIjoHBQ1ipDyecCjeZ8u2T3WhowVPyq0P26mA5njZL1fyk5ZHbzJ7p0QBODtZ+fp+0Er
	AtRryXj3W1yksUsa+h0HOHXxblhDy1hsJYzSMXfw32nHUOPmTGWEoZxLE1VaxoBw1eFI=
X-Received: by 2002:a5d:648d:0:b0:3a6:d255:7eda with SMTP id ffacd0b85a97d-3b5f2dfd1b8mr1404576f8f.28.1752227927213;
        Fri, 11 Jul 2025 02:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBZmauJhH+3iF5EU/3X92DU30FEe2aNm1uPMNqVM2/Rpwxm5AE5/oI+EKrP1imiuyTuELdjg==
X-Received: by 2002:a5d:648d:0:b0:3a6:d255:7eda with SMTP id ffacd0b85a97d-3b5f2dfd1b8mr1404495f8f.28.1752227926612;
        Fri, 11 Jul 2025 02:58:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d727sm4072600f8f.51.2025.07.11.02.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 02:58:46 -0700 (PDT)
Message-ID: <65601756-e9ae-4a26-acd4-2dcfe58a7f7f@redhat.com>
Date: Fri, 11 Jul 2025 11:58:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/29] mm: convert "movable" flag in page->mapping to a
 page flag
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
References: <20250704102524.326966-1-david@redhat.com>
 <20250704102524.326966-21-david@redhat.com>
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
In-Reply-To: <20250704102524.326966-21-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.25 12:25, David Hildenbrand wrote:
> Instead, let's use a page flag. As the page flag can result in
> false-positives, glue it to the page types for which we
> support/implement movable_ops page migration.
> 
> We are reusing PG_uptodate, that is for example used to track file
> system state and does not apply to movable_ops pages. So
> warning in case it is set in page_has_movable_ops() on other page types
> could result in false-positive warnings.
> 
> Likely we could set the bit using a non-atomic update: in contrast to
> page->mapping, we could have others trying to update the flags
> concurrently when trying to lock the folio. In
> isolate_movable_ops_page(), we already take care of that by checking if
> the page has movable_ops before locking it. Let's start with the atomic
> variant, we could later switch to the non-atomic variant once we are
> sure other cases are similarly fine. Once we perform the switch, we'll
> have to introduce __SETPAGEFLAG_NOOP().
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/balloon_compaction.h |  2 +-
>   include/linux/migrate.h            |  8 -----
>   include/linux/page-flags.h         | 54 ++++++++++++++++++++++++------
>   mm/compaction.c                    |  6 ----
>   mm/zpdesc.h                        |  2 +-
>   5 files changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index a8a1706cc56f3..b222b0737c466 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -92,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
>   				       struct page *page)
>   {
>   	__SetPageOffline(page);
> -	__SetPageMovable(page);
> +	SetPageMovableOps(page);
>   	set_page_private(page, (unsigned long)balloon);
>   	list_add(&page->lru, &balloon->pages);
>   }
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 6aece3f3c8be8..acadd41e0b5cf 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -103,14 +103,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>   
>   #endif /* CONFIG_MIGRATION */
>   
> -#ifdef CONFIG_COMPACTION
> -void __SetPageMovable(struct page *page);
> -#else
> -static inline void __SetPageMovable(struct page *page)
> -{
> -}
> -#endif
> -
>   #ifdef CONFIG_NUMA_BALANCING
>   int migrate_misplaced_folio_prepare(struct folio *folio,
>   		struct vm_area_struct *vma, int node);
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4c27ebb689e3c..5f2b570735852 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -170,6 +170,11 @@ enum pageflags {
>   	/* non-lru isolated movable page */
>   	PG_isolated = PG_reclaim,
>   
> +#ifdef CONFIG_MIGRATION
> +	/* this is a movable_ops page (for selected typed pages only) */
> +	PG_movable_ops = PG_uptodate,
> +#endif
> +
>   	/* Only valid for buddy pages. Used to track pages that are reported */
>   	PG_reported = PG_uptodate,
>   
> @@ -698,9 +703,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>    * bit; and then folio->mapping points, not to an anon_vma, but to a private
>    * structure which KSM associates with that merged page.  See ksm.h.
>    *
> - * PAGE_MAPPING_KSM without PAGE_MAPPING_ANON is used for non-lru movable
> - * page and then folio->mapping points to a struct movable_operations.
> - *
>    * Please note that, confusingly, "folio_mapping" refers to the inode
>    * address_space which maps the folio from disk; whereas "folio_mapped"
>    * refers to user virtual address space into which the folio is mapped.
> @@ -743,13 +745,6 @@ static __always_inline bool PageAnon(const struct page *page)
>   {
>   	return folio_test_anon(page_folio(page));
>   }
> -
> -static __always_inline bool page_has_movable_ops(const struct page *page)
> -{
> -	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
> -				PAGE_MAPPING_MOVABLE;
> -}
> -
>   #ifdef CONFIG_KSM
>   /*
>    * A KSM page is one of those write-protected "shared pages" or "merged pages"
> @@ -1133,6 +1128,45 @@ bool is_free_buddy_page(const struct page *page);
>   
>   PAGEFLAG(Isolated, isolated, PF_ANY);
>   
> +#ifdef CONFIG_MIGRATION
> +/*
> + * This page is migratable through movable_ops (for selected typed pages
> + * only).
> + *
> + * Page migration of such pages might fail, for example, if the page is
> + * already isolated by somebody else, or if the page is about to get freed.
> + *
> + * While a subsystem might set selected typed pages that support page migration
> + * as being movable through movable_ops, it must never clear this flag.
> + *
> + * This flag is only cleared when the page is freed back to the buddy.
> + *
> + * Only selected page types support this flag (see page_movable_ops()) and
> + * the flag might be used in other context for other pages. Always use
> + * page_has_movable_ops() instead.
> + */
> +TESTPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
> +SETPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
> +#else /* !CONFIG_MIGRATION */
> +TESTPAGEFLAG_FALSE(MovableOps, movable_ops);
> +SETPAGEFLAG_NOOP(MovableOps, movable_ops);
> +#endif /* CONFIG_MIGRATION */
> +
> +/**
> + * page_has_movable_ops - test for a movable_ops page
> + * @page The page to test.
> + *
> + * Test whether this is a movable_ops page. Such pages will stay that
> + * way until freed.
> + *
> + * Returns true if this is a movable_ops page, otherwise false.
> + */
> +static inline bool page_has_movable_ops(const struct page *page)
> +{
> +	return PageMovableOps(page) &&
> +	       (PageOffline(page) || PageZsmalloc(page));
> +}
> +

The following fixup on top:

 From 3a52911a299d3328d9fa2aeba00170240795702d Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 Jul 2025 11:57:43 +0200
Subject: [PATCH] fixup: "mm: convert "movable" flag in page->mapping to a page
  flag"

We're missing a ":".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/page-flags.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 970600d79daca..8e4d6eda8a8d6 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1150,7 +1150,7 @@ PAGEFLAG_FALSE(MovableOpsIsolated, movable_ops_isolated);
  
  /**
   * page_has_movable_ops - test for a movable_ops page
- * @page The page to test.
+ * @page: The page to test.
   *
   * Test whether this is a movable_ops page. Such pages will stay that
   * way until freed.
-- 
2.50.1


-- 
Cheers,

David / dhildenb


