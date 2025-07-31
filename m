Return-Path: <linux-kernel+bounces-752098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF72FB17130
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C1E586D59
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817242D0C60;
	Thu, 31 Jul 2025 12:25:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDB2C327D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964745; cv=none; b=KCAOL8lsjwP3FltgbOPmQtRwc76JJGo/BkrDFOllYLwGrSLMJBqXtROhD1TULxxI6NVVwjb/qJ6SQ/RCRNX90YOjV6g/YQtXAxSEn38Wd8ZrIQXmicfK8qQl9KQ/CYdLzyDa/mm9UNBnu/762z9fQoRcBPtX2Y6GK1LouxniTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964745; c=relaxed/simple;
	bh=RnjkfR9G+z3UI9czRgN7BimLTS4h6WePQUrVJtx/yNg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qz629ggLp8bX9/b3jdXoPv+oqNYHpcsqXn97GXy4zDes1kjZfwBx2+i77E9WGdyFvDedEHuXyQOa6I+munLs4GhzRNC3HR82JooHghXFYXZmptB56xIfvoTPWvKRbfz5ANtWjwEnTHlpeLow4/hXgAn/aD0SmH94FVK/sKIIfrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt7VF3y20z6L4sF;
	Thu, 31 Jul 2025 20:21:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 42B651402F2;
	Thu, 31 Jul 2025 20:25:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 14:25:40 +0200
Date: Thu, 31 Jul 2025 13:25:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>
Subject: Re: [PATCH 6/8] drivers/perf: hisi: Refactor the event
 configuration of L3C PMU
Message-ID: <20250731132538.000043a3@huawei.com>
In-Reply-To: <20250729153823.2026154-7-wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
	<20250729153823.2026154-7-wangyushan12@huawei.com>
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

On Tue, 29 Jul 2025 23:38:21 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The event register is configured using hisi_pmu::base directly since
> only one address space is supported for L3C PMU. We need to extend if
> events configuration locates in different address space. In order to
> make preparation for such hardware, extract the event register
> configuration to separate function using hw_perf_event::event_base as
> each event's base address.  Implement a private
> hisi_uncore_ops::get_event_idx() callback for initialize the event_base
> besides get the hardware index.
> 
> No functional changes intended.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
One tiny thing inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 128 ++++++++++++-------
>  1 file changed, 83 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> index 39444f11cbad..6ac0ea74cda3 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> @@ -60,51 +60,86 @@ HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core, config2, 15, 0);
>  
> -static void hisi_l3c_pmu_config_req_tracetag(struct perf_event *event)
> +static int hisi_l3c_pmu_get_event_idx(struct perf_event *event)
>  {
>  	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
> +	unsigned long *used_mask = l3c_pmu->pmu_events.used_mask;
> +	u32 num_counters = l3c_pmu->num_counters;
> +	int idx;
> +
> +	idx = find_first_zero_bit(used_mask, num_counters);
> +	if (idx == num_counters)
> +		return -EAGAIN;
> +
> +	set_bit(idx, used_mask);
> +	event->hw.event_base = (unsigned long)l3c_pmu->base;

Trivial but blank line here.

> +	return idx;
> +}


