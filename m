Return-Path: <linux-kernel+bounces-822300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D6B837B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A382A1898062
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769892F25E0;
	Thu, 18 Sep 2025 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/+787Ig"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302122F0685
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183079; cv=none; b=kJHkKcLjuUIDEpr5nPOC2AIn1tte7BBLqzm/DVLxi8K52GH758+jjHYoSHs+PiCEGc0OxC7xaxyAksmf4hyNfiKSvGnY0DD6iQbRLcT1jhMt/bUKysQYfedJnLsMSsVpA/0RUuWpHafLH2uS7s5VYhrm0hTS/xbERI3vcC48xSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183079; c=relaxed/simple;
	bh=RTKSYR0ltSdkGYyDTEhK7mqwiF+pYMNwAriH0F7FxKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivN6tBed1gE1H2atAb7Zr3ZiUz18YvU021bQx7mGiiCV4psBO8xFsGNEcbq/7Vl5sefyBXY9cchlAjgeUXye98dLBfTeqpYPm6K+6r427KrDtCGsrT6I/C7b2taWvzdWPRm7viYXbV/tdU6+vakN+lhcWXF6Rsndgs1FzyH9E7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/+787Ig; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a9f44a1-855c-450e-9dc4-415a29b90011@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758183074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpdf5zd5/ar6nMWB3h3rjQXpfUfe+I/6t4BRZfYK1Fg=;
	b=E/+787Igq6FLtq7IBnUzJz8t8JWQ0z9A36rBHkQT1b8XDJtgz16gaPD2eAvx+KcEItNW1u
	RLTJMqAvXNnHNZv2kMTDYiK+S7IAAbPyrn3iBnCsmmesZCrmLexQKBArkpNMNwaMhU9lFk
	GsK6teS25ZC/b42u8jTb1xN79kGJ+6U=
Date: Thu, 18 Sep 2025 16:11:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/vmstat: add header line to /proc/buddyinfo output
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ye Liu <liuye@kylinos.cn>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250918071741.526280-1-ye.liu@linux.dev>
 <aMu01xIkj-3hgW88@tiehlicka>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <aMu01xIkj-3hgW88@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/9/18 15:29, Michal Hocko 写道:
> On Thu 18-09-25 15:17:40, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Add a header line to /proc/buddyinfo that shows the order numbers
>> for better readability and clarity.
>>
>> Before:
>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
>>
>> After:
>> Free pages per order       0      1      2      3      4      5      6 ...
>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
> 
> Why is this needed? And have you considered tha this might break
> existing parsers of the file?
> 

Thanks for the review.

The reason for this change is simply to make /proc/buddyinfo self-describing.
Right now you have to know which column is which order; with a header it’s
obvious. This is similar to what /proc/pagetypeinfo already does, e.g.:

  Page block order: 9
  Pages per block: 512

  Free pages count per migrate type at order   0 1 2 3 ...
  Node 0, zone DMA, type Unmovable             0 0 0 ...

Regarding existing parsers: the patch does not change any of the existing
“Node … zone …” lines, it only adds a single header line before them. Most
parsers match “Node” lines and ignore everything else, so the risk should be
low. If you know of any existing parser that this would break, please let
me know so I can address it.                                                 


>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
>>  mm/vmstat.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index bb09c032eecf..e9606457ab91 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1574,7 +1574,14 @@ static void frag_show_print(struct seq_file *m, pg_data_t *pgdat,
>>   */
>>  static int frag_show(struct seq_file *m, void *arg)
>>  {
>> +	int order;
>>  	pg_data_t *pgdat = (pg_data_t *)arg;
>> +	/* Print header */
>> +	seq_printf(m, "%-21s ", "Free pages per order");
>> +	for (order = 0; order < NR_PAGE_ORDERS; ++order)
>> +		seq_printf(m, "%6d ", order);
>> +	seq_putc(m, '\n');
>> +
>>  	walk_zones_in_node(m, pgdat, true, false, frag_show_print);
>>  	return 0;
>>  }
>> -- 
>> 2.43.0
>>
> 

-- 
Thanks,
Ye Liu


