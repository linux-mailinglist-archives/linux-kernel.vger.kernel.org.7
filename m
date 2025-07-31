Return-Path: <linux-kernel+bounces-752062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D633B170EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16EA1AA61C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255221FF3C;
	Thu, 31 Jul 2025 12:15:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730FD239E94
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964111; cv=none; b=TTGt8vJA6Q3oNySC+D+cY1Nx3XdcjuONqE7McLgE2g31l40lW2LcWiUGFCnwXhTCFTpqK9BH5gHhEZ6nEuhCket3f88PTEVSCLqzwu+IPmQQFY3DxXW0bAeDNBIUxL/yuQIMfMg2MFpfJORW1TTieGKkopM1HIvRQmiYpyuT5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964111; c=relaxed/simple;
	bh=j3EHXE0LQ1M848U/FiZrnOiD84uHfeV0s+PctNfaYEI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx+EOAfGUKFd8EWJlSDkNZR/J/nm/B9gIKqaEnHyMFieyeAqw/9/kTGhQaPyXur0p7ToN2Pj8hpLvDKC38a+E13QouvY6RhhguWkIvI3ijcUZl6qsN/z9MYZTQgw5+ezG0NLDZ4VwLAOtkONIxICujdoC6I82RnJLycSjhHpY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt7Jg20bKz67kb7;
	Thu, 31 Jul 2025 20:13:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 236C71402EA;
	Thu, 31 Jul 2025 20:15:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 14:15:05 +0200
Date: Thu, 31 Jul 2025 13:15:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>
Subject: Re: [PATCH 1/8] drivers/perf: hisi: Relax the event ID check in the
 framework
Message-ID: <20250731131503.0000740f@huawei.com>
In-Reply-To: <20250729153823.2026154-2-wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
	<20250729153823.2026154-2-wangyushan12@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Jul 2025 23:38:16 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Event ID is only using the attr::config bit [7, 0] but we check the
> event range using the whole 64bit field. It blocks the usage of the
> resident field of attr::config. Relax the check by only using the
> bit [7, 0].
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>

Reviewed-by: Jonathan Csmeron <Jonathan.Cameron@huawei.com>

This seems sensible clean up even without the rest of the series.


> ---
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
>  drivers/perf/hisilicon/hisi_uncore_pmu.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index ef058b1dd509..3050899ddf17 100644
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
> index f4fed2544877..50a97e79076a 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> @@ -43,7 +43,8 @@
>  		return FIELD_GET(GENMASK_ULL(hi, lo), event->attr.config);  \
>  	}
>  
> -#define HISI_GET_EVENTID(ev) (ev->hw.config_base & 0xff)
> +#define HISI_EVENTID_MASK	0xff
> +#define HISI_GET_EVENTID(ev) ((ev)->hw.config_base & HISI_EVENTID_MASK)
>  
>  #define HISI_PMU_EVTYPE_BITS		8
>  #define HISI_PMU_EVTYPE_SHIFT(idx)	((idx) % 4 * HISI_PMU_EVTYPE_BITS)


