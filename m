Return-Path: <linux-kernel+bounces-711326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0890AAEF92A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 14:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1DD178F03
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944D1274653;
	Tue,  1 Jul 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTo4bSvk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAAA22094
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374202; cv=none; b=gjKeOo3HGDr32BdLnYGt8f+Mxy3pJVGemQ0kW+WCNm/riRt7yhuL4VsFxhHmalKz6xttjzHc94QdcU/qNFQWFiTAYX+ZPybuUVeQso9LbRJjqL0ifHlYPRv/VbX070AZNUwKORfN0EH15qnp6tNRDgD0Cp0a+Nh3ZzKgeFbQxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374202; c=relaxed/simple;
	bh=JClbjtfLGzwzJZ3cpZLIXHMkfjNwuXuOTK+9mkC+xfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFujW9WyEvJ6hE9/IeJ0ib9XK6FNVvB1nPAUeCUZuM5Gj/pwE9pxJQmk9RvIp9aKK/kcbITCp3Vd5+u3t5UDrbVireXj1zh1AbcAABHiWVbyoE6XlBYeaNKIRin4/k4HXJwlATtYPAjfj72EFafR0UJ+9fRYZacgQ8DQppx2Ye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTo4bSvk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751374199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C+eeNIGph/RfboTkvhQ0KJF1oXksncRWcmuBP7S2QrE=;
	b=XTo4bSvkQsy1swqkXy42nf7K+gcNEruDIl971R0cYcfJriwF89nGpWW/eeHP7Ewb9YYnlg
	apxUYr1zAFsS2q7hc0HRIUKnZDI1IsdPXLIlqOKUIFjcgMrW1YZPpXrE8V0M2IE0FJZzjY
	zSduNpOq61RUS5+bMCmL06R6vkYWhDU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-PdbJM_-iOYmJBmd0xbkPqg-1; Tue, 01 Jul 2025 08:49:58 -0400
X-MC-Unique: PdbJM_-iOYmJBmd0xbkPqg-1
X-Mimecast-MFC-AGG-ID: PdbJM_-iOYmJBmd0xbkPqg_1751374197
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso1961510f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 05:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751374197; x=1751978997;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+eeNIGph/RfboTkvhQ0KJF1oXksncRWcmuBP7S2QrE=;
        b=P2pjQAxn0lSPoeZIGnbgwkGrhmZK9wK3cecC4BnWNjlN2uJD46rQaouXfuWbQVXAQM
         J4nqXmkwf3FlqPaYsFP5MjxuuLuL5tn3/9OiC9tILGvsFqCnyKLmZE+5C+2aRW7RIoMV
         zsaVfiZiRu3Qr/1c1zzX7u/wJFUpMLTk0FkuY8iwFBosPax31pUT7vitHAJVqGdvSpUo
         /9ASUcSVfrGJCvaQbdYtjuFePgZ4pq1XVmo+kj3kdPnnnHKFqpWqd90PMHyBIXJRCEMl
         cBT7Y6F6jTLyIRaqQnHAntge0QYCJkidRhjhFvmdWbVMIY7nSuHWFx1StuJrF723AHrW
         niww==
X-Gm-Message-State: AOJu0YxSC2Ee+sQK7T9QBRZf0qFBLtW+aOTSUeYl6uQD67fbrsFHBaOx
	5efKebcmrpL2CoNZGe9LV9Os1/8RUhmSyf+21Lx1VxQ+oxhVkSdd2OxRUy4AXl8TAgTYzaMLKU/
	4cL9pjOx9LOW5ORuC7TpR5+1ptmwpo4IIs0Z/j4RXzvNJF3DLI+vXqMx4JotEn0M4kw==
X-Gm-Gg: ASbGncty1v+vegquE/rnMhyzzu/FgRrQXhNYNXXqsztMXXhuxhmGnbO5v8kSpIrXkKt
	5B5GygPLMBzJj6C9sURpKp54GTDMcmu3wQIUJpw+6pO1p5mCYbuxxNwngNIcCxOUFQX69U2aSz9
	oDygfXqrpciwZkkihgPrhqsXqGlBxrjC4nacw//oONQWms6IScxP2mj1VlLKnHWhQdhSd1ONLGj
	4eF3n4mM+KNIQKUyDVOmueLIOxfnlULr5tMHxJO3A9INfM1hVGf9QW0UTxFwBqcYNbRC6yPZguI
	mRfLujOXTd1No5GRE3SgxwMkwoR7seMjBtkW99AJ+VHR3+SUkcPmZEk25MfRPC0Zc5/RmkoeFI4
	MpyeexcrnDpdJ2Vn3+gXlQpOQFXnYcbbQ7CyCJelrlCNyJGgI1g==
X-Received: by 2002:adf:979c:0:b0:3a6:e6c3:6d95 with SMTP id ffacd0b85a97d-3a8fe5b1b18mr10836935f8f.41.1751374196723;
        Tue, 01 Jul 2025 05:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAxFPpLtFvUGf5RCxIdMcSORQzf+JZ0BcoaG83ZHXzVCGagtBTeeRvpO+7s2vJcmdXsJSXFQ==
X-Received: by 2002:adf:979c:0:b0:3a6:e6c3:6d95 with SMTP id ffacd0b85a97d-3a8fe5b1b18mr10836894f8f.41.1751374196190;
        Tue, 01 Jul 2025 05:49:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7facf9sm13066611f8f.22.2025.07.01.05.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:49:55 -0700 (PDT)
Message-ID: <efb280d5-8c8c-409f-89cc-6cf45bfcf2ff@redhat.com>
Date: Tue, 1 Jul 2025 14:49:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 20/29] mm: convert "movable" flag in page->mapping to a
 page flag
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
 <20250630130011.330477-21-david@redhat.com>
 <0150bc5a-1275-4205-8d85-82364ecabbda@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0150bc5a-1275-4205-8d85-82364ecabbda@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 14:44, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 03:00:01PM +0200, David Hildenbrand wrote:
>> Instead, let's use a page flag. As the page flag can result in
>> false-positives, glue it to the page types for which we
>> support/implement movable_ops page migration.
>>
>> The flag reused by PageMovableOps() might be sued by other pages, so
> 
> I assume 'used' not 'sued' :P

:)

> 
>> warning in case it is set in page_has_movable_ops() might result in
>> false-positive warnings.
> 
> Worth mentioning that it's PG_uptodate. Also probably worth putting a proviso
> here that we're safe to use it for movable ops pages because it's used to track
> file system state.

Will do.

> 
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Seems reasonable though, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>


Thanks!


-- 
Cheers,

David / dhildenb


