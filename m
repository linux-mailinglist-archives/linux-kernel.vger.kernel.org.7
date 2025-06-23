Return-Path: <linux-kernel+bounces-698775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A582FAE495A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92387A3CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C262B28DF2B;
	Mon, 23 Jun 2025 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R566ciCr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50D28DB49
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694037; cv=none; b=XhWPClQD8KG87GSybM6wf48KGp9XPzlfbKcEFM+6JBCoN7SV7Kf34nmehBuc8VkqSi/DFRYTW+oGb64GJwX0je+yorLpFWZl0qRGedgYqHCfxBdd92qA9U0hdZWDVtiLEqMJy4/1BXRuIrNF8ehyDuJxlPSjXWd01sGeZFSfLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694037; c=relaxed/simple;
	bh=L5ZyfNncg4FSIUqVC6DCRfTvnr0Ro/a0zsavgyY4EDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6Z7VzW29XcodMXFBjT6XSzHFhTV6XHvKjDHq8AFhY1+p3GiZeUr+BbDfByPz61mczXIrvVYwzMhkoROdDvtrYZbfyKTYkZM/QlDN3La5JhbuYRNNvC7RWkzKjbdssf3eYYUq0DkIx3LBQhUJtH3Gt3tz44cm3ZSnWyrD23iy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R566ciCr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750694034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X8qCzEjS8nA9NJsMXte4WyKdsfhgHPUhKDBSVhbgMFU=;
	b=R566ciCr4crUSPsQFRzoFezp8VcR0RSYwwhCBZ7vL3UYHiC2TL9iL9yCPzxwx0z3Iva62S
	YztOhIJwTZn7vpRsPDLimpxU5xz2nL44N/J4X2J7W1vUSJKXJBzpp2gmuVUgMeNr9VD7Gp
	BjvVMteLQTcU14mQTb8vh4ZEg16pMdg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-nF0MH41DPoyLV7BbPbKQZw-1; Mon, 23 Jun 2025 11:53:50 -0400
X-MC-Unique: nF0MH41DPoyLV7BbPbKQZw-1
X-Mimecast-MFC-AGG-ID: nF0MH41DPoyLV7BbPbKQZw_1750694029
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1931493f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 08:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750694029; x=1751298829;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X8qCzEjS8nA9NJsMXte4WyKdsfhgHPUhKDBSVhbgMFU=;
        b=I/Hp0lBhOaIV/kU9gW41QTLu75DQxV/wvOHcsnqU2bJwS+qhWfqJD/+jmhJRfw0+l9
         DGtaTIYZ+TAvC4UjRCA3bjj8INdT0FqnW0R6kYc+OBATisX6Yqhh0pC8AtzyQgDYCqTK
         Ubbt10BnuZnjSGcQXlzJHULdHnU8sSGcV+9kXtZTeQtPxGdfBzsjFkdBHTkO5+rYYtqt
         ncf4icfPfPQ6MKN7M8O59c43SWSUDc+/6kUjBS1SBe6B3JtH2AkrVtQB3XDfObqRudGZ
         fz6McN4n+bC4gDZ5bErgFgOf7VA7uI6FFhA9zKm2vm0aB1P0/Aj8Wbir+MNfdtP729Um
         68yA==
X-Forwarded-Encrypted: i=1; AJvYcCUwDUzrOMO5+fLQYYIvqqT7UQ3O4ZzpEishISgOnmKFfwK+4bQ5+hdfU3Qt7d2XdC0AQoAiWd2mxSw3uqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3GGRBb9LYR0ukpvI86XRvfpSP7C0uFBFYWNMWlB9YQe07xj7
	EqmKo1zpUsmWALWLduxKOgW4HgkHIQ97mw3sA8G+Fd/jX1IuRhTVewHIfbDoF0jwXSulLZ5QhlA
	vC2SycS5eph/GADAOjfkphzygqFJtSFlSrIpjF52vIWY+6FT05GWvvY76aohxaHC8Rg==
X-Gm-Gg: ASbGncvDiT1ertKoRLIOA6Fz8GNslLktFkYhcDqEJcU/JG0/0nGqWFfqzyjFUTGv+Ze
	SgFvgnlxQCGvRnSUbwI5vyzELpfWGs5bzlu0GX5n/8b82ypw2z1ezeiJr2FONUy+Oj7els6uh4t
	knPFnFwP320cjfK6RRixDFyHvxLB7adZhmuugrI+HJm8i3yHqw+Q0l/xI08pdlasxF88ZtF/QgW
	qjhHJtqvr7yVUIdZHsz61bzVotu8VnhfpEXmbobdSbShpIuAqg6yXOcwYVYLi5sRO1Px1b2n3Yn
	kwtt2KmiP8qkxzzKrHOcxlwbHCu9KCOoa5PoaIAQ2wJgX8i15vMyAYdAMCQQDXyngnuO5f+bNcc
	I7eq1qzwa/GftgDWHKY+9a0uy7Ui75ZsSPjsATbpXyWfME+W05Q==
X-Received: by 2002:a05:6000:20c1:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3a6d93e56fdmr4631716f8f.59.1750694029387;
        Mon, 23 Jun 2025 08:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA1KvuWMUKN9KvaBuLXR047CctA8x5Deyzs96cGxifQWvv9nqh0pubra4q6mzKwy1TzfQHsg==
X-Received: by 2002:a05:6000:20c1:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3a6d93e56fdmr4631669f8f.59.1750694028940;
        Mon, 23 Jun 2025 08:53:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1188094sm9767260f8f.74.2025.06.23.08.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:53:48 -0700 (PDT)
Message-ID: <c3cb8f4f-e343-4109-b679-a6b37e18dd30@redhat.com>
Date: Mon, 23 Jun 2025 17:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
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
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
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
 <20250618174014.1168640-8-david@redhat.com>
 <9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
 <aFMH0TmoPylhkSjZ@casper.infradead.org>
 <4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
 <bef13481-5218-4732-831d-fe22d95184c1@redhat.com>
 <8FE2EDF1-DF20-4DC4-A179-83E598508748@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8FE2EDF1-DF20-4DC4-A179-83E598508748@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.06.25 17:42, Zi Yan wrote:
> On 23 Jun 2025, at 11:33, David Hildenbrand wrote:
> 
>> On 18.06.25 20:48, Zi Yan wrote:
>>> On 18 Jun 2025, at 14:39, Matthew Wilcox wrote:
>>>
>>>> On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
>>>>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>>>>
>>>>>> ... and start moving back to per-page things that will absolutely not be
>>>>>> folio things in the future. Add documentation and a comment that the
>>>>>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>>>>>>
>>>>>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>>>>>> it gracefully (relevant with further changes), and convert a
>>>>>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>>>>>
>>>>> The reason is that there is no upstream code, which use movable_ops for
>>>>> folios? Is there any fundamental reason preventing movable_ops from
>>>>> being used on folios?
>>>>
>>>> folios either belong to a filesystem or they are anonymous memory, and
>>>> so either the filesystem knows how to migrate them (through its a_ops)
>>>> or the migration code knows how to handle anon folios directly.
>>
>> Right, migration of folios will be handled by migration core.
>>
>>>
>>> for device private pages, to support migrating >0 order anon or fs folios
>>> to device, how should we represent them for devices? if you think folio is
>>> only for anon and fs.
>>
>> I assume they are proper folios, so yes. Just like they are handled today (-> folios)
>>
>> I was asking a related question at LSF/MM in Alistair's session: are we sure these things will be folios even before they are assigned to a filesystem? I recall the answer was "yes".
>>
>> So we don't (and will not) support movable_ops for folios.
> 
> Got it. (I was abusing it to help develop alloc_contig_range() at pageblock
> granularity, since it was easy to write a driver to allocate a compound page
> at a specific PFN and claim the page is movable, then do page online/offline
> the range containing the PFNs. :) )

Oh, interesting :)

Yeah, with a folio that will be a bit harder ...

> 
> For the patch, Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks!

-- 
Cheers,

David / dhildenb


