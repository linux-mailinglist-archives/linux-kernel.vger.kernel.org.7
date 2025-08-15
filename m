Return-Path: <linux-kernel+bounces-769891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD69B274CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DD97AED3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09856277C9A;
	Fri, 15 Aug 2025 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rv7j8MQ3"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA019ABD8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221914; cv=none; b=XGX/s1jtl8Ft3lQ9EPNGjcFaVMXbLfTXB8dXYw5blUI0M/j5pTEZkIfqkB8K1BYWn0hahaHakkqVx6wKeVZqddHjI2ePkJzsOY31Jqth079/be6hPBM97PbC5C29Sdrc4aTbVtWh7oG7UD+5GEinG2tOfT+wAUC34U3L3oMd88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221914; c=relaxed/simple;
	bh=bTs4Gl0zj2aTUwfLbuEPcGK9gSHi74I9ri2KM9DxhGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjPxzRC+bF/BA4xV8fJMcX1oO9Ak2KN0NfNxiEL5i0alK9D5Fw2hgW2bPQrCGr5GTkt/WKFVcSBNYHN04j0pYj9a+POTbxhEZyYhg2zxFSR9Qk2oUnPoWWPBVtYV/QA4RyEOBGryzjGVGQ+Y4gq0VMpJ9+mAsq+Os9TjZiMhNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rv7j8MQ3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0032c975-1e37-484f-9b7b-a3f0fea0401a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755221905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvIK9iJ7V8SHnncWDIUPYMTGNncr21um3VSz5HwThLw=;
	b=Rv7j8MQ3/UNGwwdvhntFdBWKEAHI300ZJy5nVbhPaQxP2lu1/Xv6QTPG/vsbkanIXvGX0v
	Gch2UTO+opI2CgstTS5Yq8HjzJWUE64pYMaswUN/0i1GK+1eJ5QD9hbCdcCiY1GLb9bJqV
	ZXEStufgTaSGJR+4CsA+mCz6bpgR/ME=
Date: Fri, 15 Aug 2025 09:38:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/page_alloc: simplify lowmem_reserve max calculation
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250814090053.22241-1-ye.liu@linux.dev>
 <EF575A1E-6AE2-45D7-9AC0-49C462A0CE5C@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <EF575A1E-6AE2-45D7-9AC0-49C462A0CE5C@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/8/14 22:47, Zi Yan 写道:
> On 14 Aug 2025, at 5:00, Ye Liu wrote:
> 
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Use max() macro to simplify the calculation of maximum lowmem_reserve
>> value in calculate_totalreserve_pages(), instead of open-coding the
>> comparison. The functionality remains identical.
>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
>>  mm/page_alloc.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 64872214bc7d..8a55a4951d19 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6236,8 +6236,7 @@ static void calculate_totalreserve_pages(void)
>>
>>  			/* Find valid and maximum lowmem_reserve in the zone */
>>  			for (j = i; j < MAX_NR_ZONES; j++) {
>> -				if (zone->lowmem_reserve[j] > max)
>> -					max = zone->lowmem_reserve[j];
>> +				max = max(max, zone->lowmem_reserve[j]);
>>  			}
> 
> There is a “if (max > managed_pages)” below. Maybe convert that as well?

I should use min() here, but I noticed the two variables have different types: 
one is 'long' and the other is 'unsigned long'. So, I should use min_t(). 
But then again, why is lowmem_reserve of type 'long'? 
It should be a non-negative number, right? 
Is it possible to change the type of lowmem_reserve to 'unsigned long' and 
change all uses of it at the same time? Is it necessary?

> 
> Feel free to add Acked-by: Zi Yan <ziy@nvidia.com>.
> 
> Best Regards,
> Yan, Zi

-- 
Thanks,
Ye Liu


