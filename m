Return-Path: <linux-kernel+bounces-769959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668FAB27561
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E353BAB63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A26E29CB47;
	Fri, 15 Aug 2025 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CC8SV4ny"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1A29827C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223156; cv=none; b=midtvN7Qf6tOEguG7py6Lwmx9IhWlYds7UEGABwIJBWEeqKzS48XWDHI9X5epGXfy2237SEt5K1eI9gSq78zph+/gX0zGBdOM8NyyDlEqvGpSOS4RPErAnxq/6ZYX/JBV/sMHcSAs1HpK/l3hFPlVfQ/l89PpIT7JDYPoUvaaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223156; c=relaxed/simple;
	bh=pm9xR/FeoxJAb2EBsmA2hr1amByGV1Ps0KpZ8gKsQHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WC7YHy8QnGN0Z3ata7VlsHyPRPZelQIGJX3De+bYT8by03Qx0P17YT18KklTSllctfgNquq+ct5zGcqamneoadioHpT4OMAUiH9lHOg8+VeqUT2e/g+WdN+I6GQpwSB5/OmcF9Drzi+bEVhYYyTiR/nqn5FTiEZR60YimrLoL50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CC8SV4ny; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5b381aa-33a2-4537-9f71-a95f621441a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755223151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzKVb+OuhpcSSRMoVYa9IuCr7Oh6acF4Qvk0wsQHiRY=;
	b=CC8SV4nybWBdyn4sb5Ef9djH6SombrOwQmW9xgpmCO4hNoUez8LppozIaHXhYsoJlXRzpS
	DkMzD5134Mn+VZVSjdVu7R5h8FW/yZMrUXRdIHpmRD33VcC21R2FGvVAsq/Mrhqv5jXFr7
	8Y/hMUzHHjxNTYXur5IUPLAjuDNgWus=
Date: Fri, 15 Aug 2025 09:59:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/page_alloc: simplify lowmem_reserve max calculation
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250814090053.22241-1-ye.liu@linux.dev>
 <20250814140713.GF115258@cmpxchg.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20250814140713.GF115258@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/8/14 22:07, Johannes Weiner 写道:
> On Thu, Aug 14, 2025 at 05:00:52PM +0800, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Use max() macro to simplify the calculation of maximum lowmem_reserve
>> value in calculate_totalreserve_pages(), instead of open-coding the
>> comparison. The functionality remains identical.
>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> 
> You can remove the {} from the for block as well now.

I agree to delete it, but I noticed a patch has been added to the -mm 
mm-new branch by Andrew Morton[1]. What should I do now? Send v2 ? 
Or send a new patch? If this is my first time, please feel free to give me some advice.
[1]：https://lore.kernel.org/all/20250815004917.03FD7C4CEED@smtp.kernel.org/
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

-- 
Thanks,
Ye Liu


