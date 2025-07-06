Return-Path: <linux-kernel+bounces-714735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB5AF6BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 09:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5974A0BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCE299A80;
	Thu,  3 Jul 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcRpdVog"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0581FFC46
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528739; cv=none; b=VtQ1+9ZJGvTzgknQOvkN4zjWfoTIt/nWRUmI2GHla+riuNHSqY/vqYstYTlFITs94aHndymDcsGdZGtG4LqZx7AXDuCQe75nk34WX3hpF8mlaqVUJPgtEm5bGRBvWKU1h7NAmCtTo3dUKWz3DDeatG0iEwgQQqBXuq7F3v1hjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528739; c=relaxed/simple;
	bh=/WEvDghZh/eBp6pZbpWMhAbauOIfrWBiYWBD7URA+Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKdOTDBosEa0AoefPfAli7vygYa9hA43K/m5geIZ5l+AN3RjJNiwJIoCDYPISB2xU1rNokp/u8buRF02RddOO2pQfRaLRtWTfGjF4N8J7JN38b+6exdmpciBXI0RKyP+wZ6YEiX555RKYpVZ0k1YtufbOlj23LlZC/jat+tfsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcRpdVog; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751528735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WPP1PRWhtmPHNfolpuSgWHE9hj7dLgaAzKr9Pb92+J8=;
	b=EcRpdVoguRsQwKMFGk6pwCpNPftTXh4JzNJzGSSTZmDuLBFn++VY6LkyjizluGNE8lumEm
	EMgg4qGcKIxZKYV0aiozaVNCZtOAYccsiwDxFUxH/5F0KhRtKZrYAVaOcUoRSqfZkyWWWh
	bjrj6l2J/OG/zdo+Uyp2pSJ/Tqc+Kx8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-Fl6Eu7QoNwqbJYoVbmC_Gw-1; Thu, 03 Jul 2025 03:45:34 -0400
X-MC-Unique: Fl6Eu7QoNwqbJYoVbmC_Gw-1
X-Mimecast-MFC-AGG-ID: Fl6Eu7QoNwqbJYoVbmC_Gw_1751528733
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb94dbd01fso416684566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jul 2025 00:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751528733; x=1752133533;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WPP1PRWhtmPHNfolpuSgWHE9hj7dLgaAzKr9Pb92+J8=;
        b=IoX0WJzTBTLsHSjVzj6LjVzevZNCXTo7JY0lNOXBdRczcesU1cVkwad1xFbwRr0fV/
         aCUSE4eORxhe8otwKyiXZXAt1bkc/TXQPjZVnwMWL82Op54XJ8QlKfzIY4fbBi1xh3o5
         cdwQBHVsKA0yADQf2mIVNrOwsnrSbJuPP/RkBBHOyK0y0XUUbJo4X5ckqP9UZ0mS7b6d
         utLl2MGZYqJ6FmSi1sJxyseuJqO2YrjzbeSfyLriAJ2XxEqSWObqey7U0n5HOINiGBGf
         OAoUDFvYNLxMoJa1gDds/IrfxMLHA92kqK97MkDN8+adwIDib/wWJg5cl9kBd69ZcUG+
         PgFA==
X-Gm-Message-State: AOJu0YyrEjTQGlIAeO0ckPRznoae8+MnjSh/RVmmE6ogkfm50hlbsbD1
	tSu1Rt+oWG6vGfRpQN59IM+hjSAB+kXjG9/dn/rNN2B5sbGxACMiYvAk8Erc7MPrcg103ao3+K7
	4tALCPC6mi3a9+6denwq8jK6zY7IcjdnoADRxbAUdxShxxF/IigK1BJuedNC9dbXLxA==
X-Gm-Gg: ASbGncumSSWb7mHPc/jytfTfvnthb5cKjbd8AA+iYPFvHoc5QiubsYGuCIJ3bJeME3+
	suzUZN2F0Bpx7NnM5iCpE2dQGxgkGS5z5ykKhXwpDQ9cNq4yW6MGtDomg/ZBtXeJhdxf0gGJiwR
	gXYmv00Ns2w3yiDUjML214FgHn5BeR1496K7zbvHlqHtY2ts9leqmWSECWfscLrqGBDUrj0p9PA
	FzBEy1kfrqQSNNLCtRW+mCdhbl9UrSJMgeYf6OE7uvyKBrFZ4QPdqf6XjSj4Z2H+66ZMfoNYvee
	9In1Bmvy0pW+rMZA8EGBNNoaeNmc+L0QYGr9gCRBTzJV
X-Received: by 2002:a17:907:3cd3:b0:ae3:6651:58ba with SMTP id a640c23a62f3a-ae3d84f7f66mr193262066b.35.1751528732686;
        Thu, 03 Jul 2025 00:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9dut9O3e981QeFm7ijgo302R9iI7Vl24WdUyqyOYprtZmMn909rbBKXFTDk2fblCy/fN7iA==
X-Received: by 2002:a17:907:3cd3:b0:ae3:6651:58ba with SMTP id a640c23a62f3a-ae3d84f7f66mr193254666b.35.1751528732009;
        Thu, 03 Jul 2025 00:45:32 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c015b8sm1214932266b.78.2025.07.03.00.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 00:45:31 -0700 (PDT)
Message-ID: <6a83e3e1-ab1d-409b-8395-df363321cade@redhat.com>
Date: Thu, 3 Jul 2025 09:45:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
 <zmsay3nrpmjec5n7v44svfa7iwl6vklqan4dgjn4wpvsr5hqt7@cqfwdvhncgrg>
 <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>
 <ugm7j66msq2w2hd3jg3thsxd2mv7vudozal3nblnfemclvut64@yp7d6vgesath>
 <11de6ae0-d4ec-43d5-a82e-146d82f17fff@redhat.com>
 <5thkl2h5qan5gm7putqd4o6yn5ht2c5zeei5qbjoni677xr7po@kbfokuekiubj>
 <vscedd6m3cq73c5ggjjz6ndordivgeh4dmvzeok222bnderr5c@dujm4ndthtxb>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <vscedd6m3cq73c5ggjjz6ndordivgeh4dmvzeok222bnderr5c@dujm4ndthtxb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.07.25 05:22, Sergey Senozhatsky wrote:
> On (25/07/03 11:28), Sergey Senozhatsky wrote:
>>>>>>>     static int zs_page_migrate(struct page *newpage, struct page *page,
>>>>>>> @@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>>>>>>>     	unsigned long old_obj, new_obj;
>>>>>>>     	unsigned int obj_idx;
>>>>>>> +	/*
>>>>>>> +	 * TODO: nothing prevents a zspage from getting destroyed while
>>>>>>> +	 * isolated: we should disallow that and defer it.
>>>>>>> +	 */
>>>>>>
>>>>>> Can you elaborate?
>>>>>
>>>>> We can only free a zspage in free_zspage() while the page is locked.
>>>>>
>>>>> After we isolated a zspage page for migration (under page lock!), we drop
>>>>                         ^^ a physical page? (IOW zspage chain page?)
>>>>
>>>>> the lock again, to retake the lock when trying to migrate it.
>>>>>
>>>>> That means, there is a window where a zspage can be freed although the page
>>>>> is isolated for migration.
>>>>
>>>> I see, thanks.  Looks somewhat fragile.  Is this a new thing?
>>>
>>> No, it's been like that forever. And I was surprised that only zsmalloc
>>> behaves that way
>>
>> Oh, that makes two of us.
> 
> I sort of wonder if zs_page_migrate() VM_BUG_ON_PAGE() removal and
> zspage check addition need to be landed outside of this series, as
> a zsmalloc fixup.

Not sure if there is real value for that; given the review status, I 
assume this series won't take too long to be ready for upstream. Of 
course, if that is not the case we could try pulling them out.

-- 
Cheers,

David / dhildenb


