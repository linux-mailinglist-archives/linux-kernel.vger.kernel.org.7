Return-Path: <linux-kernel+bounces-822319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F98B8385D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A740417A1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68154243946;
	Thu, 18 Sep 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XOu0WkU+"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A22F39C1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184294; cv=none; b=uzdiA/PLk7z4BU4IkzKdC2DVwEJcWNT39qSKfYdakaRPtKX3cfV+vsTsbw7lU1+wxl5RFmLI14Tmm3bLUCk26gb0yO9MQxfqJgdLZC/os5tM0FdKFyTP6k4Ft5MA8X5ggknqmwDdbt2Gm8F+V3edodpLNMYC9Z9bE4ZyfiCaUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184294; c=relaxed/simple;
	bh=1h7zDDI+7FfBi88DmmpxVJ+mDfq7ZhhwGFIDuj3theQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYsqPsnbhnB+GIe7EbBOyRbZM0O9Q4SnxXBdYIJhcVj+ruBGXSbkf1mrhVfHYn1mNgm62k2fpJPcj79gXJ8mRDn8iDm2RAmOwxtmb1HvJnqugr54bVSdkijWl08SDCPdRvygwPrFWwEoY97kwIW9SmWwQrRZZ5l4eG64Kem/zqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XOu0WkU+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d6e2e33-c221-4ab8-a29b-3d14fb1a592c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758184289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jjiJUgOdqQcZN+L/ySOi1U0QoPVQrpVp8UxDsjbiI4=;
	b=XOu0WkU+plWpFLyGyEkqg6QdAh3SC7FRzxiMgrf5YnFsA+iV/iIlOIMbbXoED2aPkC8BPU
	yUyGHOwGWN6G9P5TFwZYpTHzTxSlD8TdX83JZZdnJXfEQVGL/aQT0guiay/jy5aeOnSrH0
	stYtr5IZdNnRCdVaUUDCWH1yMktmVE0=
Date: Thu, 18 Sep 2025 16:31:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/vmstat: add header line to /proc/buddyinfo output
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250918071741.526280-1-ye.liu@linux.dev>
 <aMu01xIkj-3hgW88@tiehlicka> <1a9f44a1-855c-450e-9dc4-415a29b90011@linux.dev>
 <780aa9d6-a85c-4050-820e-c0ca9f5bb658@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <780aa9d6-a85c-4050-820e-c0ca9f5bb658@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/9/18 16:16, David Hildenbrand 写道:
> On 18.09.25 10:11, Ye Liu wrote:
>>
>>
>> 在 2025/9/18 15:29, Michal Hocko 写道:
>>> On Thu 18-09-25 15:17:40, Ye Liu wrote:
>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>
>>>> Add a header line to /proc/buddyinfo that shows the order numbers
>>>> for better readability and clarity.
>>>>
>>>> Before:
>>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
>>>>
>>>> After:
>>>> Free pages per order       0      1      2      3      4      5      6 ...
>>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
>>>
>>> Why is this needed? And have you considered tha this might break
>>> existing parsers of the file?
>>>
>>
>> Thanks for the review.
>>
>> The reason for this change is simply to make /proc/buddyinfo self-describing.
>> Right now you have to know which column is which order; with a header it’s
>> obvious. This is similar to what /proc/pagetypeinfo already does, e.g.:
>>
>>    Page block order: 9
>>    Pages per block: 512
>>
>>    Free pages count per migrate type at order   0 1 2 3 ...
>>    Node 0, zone DMA, type Unmovable             0 0 0 ...
>>
>> Regarding existing parsers: the patch does not change any of the existing
>> “Node … zone …” lines, it only adds a single header line before them. Most
>> parsers match “Node” lines and ignore everything else, so the risk should be
>> low. If you know of any existing parser that this would break, please let
>> me know so I can address it.
> 
> What if there is a single one out there that has hardcoded to skip the first line only?

I understand there may be no way to be fully compatible with all existing
parsers. However, /proc/buddyinfo is essentially raw data intended for
human and tool consumption, and parsers are expected to be robust against
format changes.

Adding a '#' prefix to the header would allow most parsers to skip it,
but it still changes the file output and cannot fully guarantee that no
external tool will be affected.                                          


> 

-- 
Thanks,
Ye Liu


