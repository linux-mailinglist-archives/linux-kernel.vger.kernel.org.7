Return-Path: <linux-kernel+bounces-786665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A218B360D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CF184E4361
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2526B771;
	Tue, 26 Aug 2025 13:03:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CF1FBE9B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213422; cv=none; b=MOviwqps6BG9ghC5iOK5Gy2TkS+0EwDzt0Ups0PmjiDWz/tKFySA52b+kFFqwJcyPxQG5dzKq6nY/umvRA5iZjJlQNvthliHTIt3muS8eU7ELHLFpnKCEDqeWXJUM22V0Nr/8/k+xQgJ4FUXv5FmDZg3QI+SmmRdQ4xnEKub6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213422; c=relaxed/simple;
	bh=Ksw5689Q0+U62P+z9GkJK6Sdi+xI/Cv1Y5y/t2SzC94=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Msu4QCYuT8E9765igNIhf9Djf6F6xXjGKedRyrCoa/my4qBQlfJffonId8PNgTUnErnywpnl4ZaeE7HQh1fTGQb8ZIwBuixwkhiXdnLbmyfpRtkGt076Ao66cbS095AjNU3OVn3my3uqwDsIJv76Pykbbd3T1Ct3IjS5h3PBlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cB76x0Yb3z6L5C1;
	Tue, 26 Aug 2025 21:00:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 175E21402F3;
	Tue, 26 Aug 2025 21:03:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Aug
 2025 15:03:30 +0200
Date: Tue, 26 Aug 2025 14:03:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <yangyicong@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@h-partners.com>
Subject: Re: [PATCH v2 1/9] drivers/perf: hisi: Relax the event ID check in
 the framework
Message-ID: <20250826140329.0000146c@huawei.com>
In-Reply-To: <20250821135049.2010220-2-wangyushan12@huawei.com>
References: <20250821135049.2010220-1-wangyushan12@huawei.com>
	<20250821135049.2010220-2-wangyushan12@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 21 Aug 2025 21:50:41 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Event ID is only using the attr::config bit [7, 0] but we check the
> event range using the whole 64bit field. It blocks the usage of the
> rest field of attr::config. Relax the check by only using the
> bit [7, 0].
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

One comment inline but up to you whether you act on it.

> ---
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
>  drivers/perf/hisilicon/hisi_uncore_pmu.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index a449651f79c9..6594d64b03a9 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -234,7 +234,7 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	hisi_pmu = to_hisi_pmu(event->pmu);
> -	if (event->attr.config > hisi_pmu->check_event)
> +	if ((event->attr.config & HISI_EVENTID_MASK) > hisi_pmu->check_event)
>  		return -EINVAL;
>  
>  	if (hisi_pmu->on_cpu == -1)
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> index 777675838b80..6186b232f454 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> @@ -43,7 +43,8 @@
>  		return FIELD_GET(GENMASK_ULL(hi, lo), event->attr.config);  \
>  	}
>  
> -#define HISI_GET_EVENTID(ev) (ev->hw.config_base & 0xff)
> +#define HISI_EVENTID_MASK	0xff

I'd use GENMASK(7, 0) here but this one is obvious enough that it's not important
and clearly you are just moving the definition.

> +#define HISI_GET_EVENTID(ev) ((ev)->hw.config_base & HISI_EVENTID_MASK)
>  
>  #define HISI_PMU_EVTYPE_BITS		8
>  #define HISI_PMU_EVTYPE_SHIFT(idx)	((idx) % 4 * HISI_PMU_EVTYPE_BITS)


