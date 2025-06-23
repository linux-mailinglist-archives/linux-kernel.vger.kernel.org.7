Return-Path: <linux-kernel+bounces-698772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AEFAE4968
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 17:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB041B61402
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1C829B790;
	Mon, 23 Jun 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0VOMCxt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41829B777
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693828; cv=none; b=d+JtIfw2Xr1uqGIgemN34EuwepCCLstXPsY5Tz/0/IY+5wFHrssc2cmUAK+m3EFV8asY8+WhykrRkJvZB/lD+A5PMz0GjesaeiCxs8SGytKkkT0AFmgYtLZmlkhT6PTb5b3fNKBeJXc989q1P/EPwvv/MQIZkUR/c9Y8mQtxttE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693828; c=relaxed/simple;
	bh=puUb/0dcRLlTNVtu0br3LcKN4RWlOBVw1X786J6bLZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdhjkJIrFBDqjvFFfUgZzpuuQ6mojC1rb4C6bmzB4XxrNZDVZO8p+bJiaMUAEJ8rDm9+QUyYBe6ygF0CJWWRWrS63IOBOHkcT8VJ5pvtXAgz0H8pKalba2t5PeAMeBVPHeRm7yu1kgI45iRAWaLw9bg1Zv9TacRc0L3fzRiUL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0VOMCxt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750693825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yRC43xoNyhfCsplc/KR++YxoYFjBMRcRCyrGGtLCdu4=;
	b=Q0VOMCxt0DLtWHcd3My6phT9bxvygRCRCxbsirW1TKJxyz+OTpUk/SQADXQKKCOD4oDxmq
	v+v6WA2LozNxco47bffe/7rIhA9dBKODfKRAW1Os5u6Tw0t0PEtaUY1ChT1o0VIaBZW3Jp
	Zd1g75EEN1VabpvxVU2QNvvznNwJR94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-GFfRU9UVMfqdMOVyKdl_QA-1; Mon, 23 Jun 2025 11:50:24 -0400
X-MC-Unique: GFfRU9UVMfqdMOVyKdl_QA-1
X-Mimecast-MFC-AGG-ID: GFfRU9UVMfqdMOVyKdl_QA_1750693823
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50816cc58so1826794f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 08:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750693823; x=1751298623;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yRC43xoNyhfCsplc/KR++YxoYFjBMRcRCyrGGtLCdu4=;
        b=qcC2InDr3Wbm+eKGNOGQEeI8gNqntWGVCmeagB/SpZltqtF2qnHLYbz/oNnOWGBBEk
         2jDYhhA6GYHxgHlUpCPpGWIY3YkMnYJrYLW3hRNe0cjbQ45hWM47YMzdffHBEoiEXW/l
         IspDRYh8dEBgWw9heGu2f/xrxvKJrl1wb7ovIUU1e2e9rjS5tsQIiP4MVu4/vopFQnYf
         0whgUzv/oZb22tCvceT0zkMbVJKltumUlBAG+qGWIUTCFi4q2uIrAsgn+dJrU1Hkovph
         d3XXq6Lv5W11WQqjFFU55u6Me3nqj5Yvka3BebWuIiMt+8NzDNzW9v7RmrftpIKj2t1U
         X5IQ==
X-Gm-Message-State: AOJu0YyGah7YhOuC2q6zzASZqauRDmyjnXHa5xehIqZe/H3MHcF7aD0i
	1K/nZooLDgQYmdszhB/jQYKyGlHkplvTUC6xMFgAgnRntpY4diPGKJTPA/zJt5Msw+DEWeTxc8x
	eRAuY0HFqdC4o/8OnbGilvqYzCKQjj2hBJ3oRJdYNTi4Y9sxAubB+k4GJK4AS2Zzxjw==
X-Gm-Gg: ASbGnctl1ujs3CanffuEr7a1AHnhCnHc6X9DBpEFvrzV1axEBHs5p0GLrtZL3lIGukK
	5c3YCIHvVmbQ4bhuXsB5EEJqmwsqK8h9xqvWt80rCTcl3egT4tD03kbjdtaVoRj14c8pFGv5hev
	9ks8R74sQndND+9XzBgqIsNJ2PFHR6rkR0CUdrncW2KjVFFdTfaegi5/LKuH9UMmkqza11AhG/P
	Jte80DFw3unF0m5eueveEYAHMZiNG6u+l5/YkleqItxYZFC+dhvcN0ovoM49pFKBGEKMDO+Dh9l
	hCPVxnehwtzJC0ca/erkJB3q/yDBCfojXpjafgwKnWP9qpxmg9PR8FU2cfRVMW1sjrUTY+bvZoK
	bdNTx9ChCR/B8dKHu1TMABvUO/5sDLBvG182w/xtZxujdb2dHNw==
X-Received: by 2002:a05:6000:2412:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3a6d13019e7mr9836605f8f.17.1750693823130;
        Mon, 23 Jun 2025 08:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7nWn2XFwK6TT8ZAkqrEp9zhAtjyd7MNgn344l/d1NlIJSnSP6B7frYWb4hjnDR6A7h3gMKg==
X-Received: by 2002:a05:6000:2412:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3a6d13019e7mr9836566f8f.17.1750693822675;
        Mon, 23 Jun 2025 08:50:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45365af83easm108398715e9.25.2025.06.23.08.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:50:21 -0700 (PDT)
Message-ID: <b45e3332-e962-4c8d-9399-f3ec48c3c7c1@redhat.com>
Date: Mon, 23 Jun 2025 17:50:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 20/29] mm: convert "movable" flag in page->mapping to
 a page flag
To: Zi Yan <ziy@nvidia.com>
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
 Matthew Brost <matthew.brost@intel.com>,
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
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-21-david@redhat.com>
 <2EE119E0-C71C-43C6-A445-E9CB8AAA86E6@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2EE119E0-C71C-43C6-A445-E9CB8AAA86E6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.06.25 16:14, Zi Yan wrote:
> On 18 Jun 2025, at 13:40, David Hildenbrand wrote:
> 
>> Instead, let's use a page flag. As the page flag can result in
>> false-positives, glue it to the page types for which we
>> support/implement movable_ops page migration.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/balloon_compaction.h |  2 +-
>>   include/linux/migrate.h            |  8 -----
>>   include/linux/page-flags.h         | 52 ++++++++++++++++++++++++------
>>   mm/compaction.c                    |  6 ----
>>   mm/zpdesc.h                        |  2 +-
>>   5 files changed, 44 insertions(+), 26 deletions(-)
>>
> 
> <snip>
> 
>> +
>> +/**
>> + * page_has_movable_ops - test for a movable_ops page
>> + * @page The page to test.
>> + *
>> + * Test whether this is a movable_ops page. Such pages will stay that
>> + * way until freed.
>> + *
>> + * Returns true if this is a movable_ops page, otherwise false.
>> + */
>> +static inline bool page_has_movable_ops(const struct page *page)
>> +{
>> +	return PageMovableOps(page) &&
>> +	       (PageOffline(page) || PageZsmalloc(page));
>> +}
>> +
> 
> Should we do the code below in case PageMovableOps is set on pages
> other than PageOffline and PageZsmalloc?
> 
> return PageMovableOps(page) &&
> 	   !VM_WARN_ON_ONCE_PAGE(!(PageOffline(page) || PageZsmalloc(page)),
> 							 page);

I think this could trigger in some corner when other pages (esp. 
folios?) reuse the flag and we run into some weird races while we don't 
hold any reference on the page.

-- 
Cheers,

David / dhildenb


