Return-Path: <linux-kernel+bounces-780907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D2B30ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBC06021F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4581A5B9E;
	Fri, 22 Aug 2025 01:29:13 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415681A9F98
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826152; cv=none; b=rTUOsZ55oa5aqigJqr5Q5/MUW0vSOy3hdDFKrYrRWf0vOW9HbR0nvZJpFRp0QpE/aBqJ9PGVQJnNPrIf18zv5IDv+nCyu2vBSK8pfV1Mf22wRWIiq49074rTEWnDXTGLWrk7RYV/W+nngu156xgmZ8fgd1eEzBdUKcUShwrxwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826152; c=relaxed/simple;
	bh=2ylFmxJx6uNEESak0nHQ8CPl0SoS2b/Sc/aQYqeFj4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UrDkkPd60OgNG/ZQsfd8ScnW+80/IHiWmH2OWA+ll1RHFbtHxHH51Qx/rdRdGIYiIqV67ZInPHoLlRZMUzVQAya3xTemw5EcIZsnShO410Pp7dcRT+gxhuui/O5SjixJBLtNsAZfS+HW7bkCqL+LlH9ona4l9Ty0/arhHO2TZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c7N0h06xzz27jH6;
	Fri, 22 Aug 2025 09:30:12 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D1E71A016C;
	Fri, 22 Aug 2025 09:29:06 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 09:29:05 +0800
Message-ID: <8b3f1571-6510-453f-96d4-f365eb10d02d@huawei.com>
Date: Fri, 22 Aug 2025 09:29:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] mm/damon: add damon_ctx->min_region
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250821173320.82616-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250821173320.82616-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200018.china.huawei.com (7.185.36.31)


在 2025/8/22 1:33, SeongJae Park 写道:
> On Thu, 21 Aug 2025 18:51:59 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
>> bytes and cause data alignment issues[1].
>>
>> Add damon_ctx->min_region to change DAMON_MIN_REGION from a global
> s/min_region/min_sz_region/ ?
>
>> macro value to per-context variable.
>>
>> [1] https://lore.kernel.org/all/527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com
>>
>> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
>> ---
>>   include/linux/damon.h        |  4 ++-
>>   mm/damon/core.c              | 67 ++++++++++++++++++++----------------
>>   mm/damon/sysfs.c             |  8 +++--
>>   mm/damon/tests/core-kunit.h  | 21 ++++++-----
>>   mm/damon/tests/vaddr-kunit.h |  2 +-
>>   mm/damon/vaddr.c             |  2 +-
>>   6 files changed, 61 insertions(+), 43 deletions(-)
> [...]
>> @@ -1248,6 +1253,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
>>   	}
>>   	dst->ops = src->ops;
>>   	dst->addr_unit = src->addr_unit;
>> +	dst->min_sz_region = max(DAMON_MIN_REGION / src->addr_unit, 1);
> Can't we set this as src->min_sz_region?
>
> I asked a same question[1] to the previous version but seems it was missed.

I apologize for the issues caused by my misunderstanding and carelessness.
I will make adjustments and release the v2 version as soon as possible, and I
will not make similar mistakes again in the future.


Best regards,
Quanmin Yan

>
> [...]
>
> Other parts look good to me.
>
> [1] https://lore.kernel.org/20250820215612.86678-1-sj@kernel.org
>
>
> Thanks,
> SJ

