Return-Path: <linux-kernel+bounces-752064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6DB170EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C286274EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F9223DED;
	Thu, 31 Jul 2025 12:16:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BD8F66
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964165; cv=none; b=a8JaKOmO01Us+ElgkcPmTwnBlHd4Zp10kdTYFzzHxOcDmnVj6Kyb4exFW7cKUbMFyn/IQIvMksAIqgN79BUu7LCS7n3ccBlIlFH6nJk4LjdoNR8vkW33GY2mVjpWTzqXYJpv/ofmSv5SbJqnKc7liW4BvMMf+K5Ifd0+WQx5xr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964165; c=relaxed/simple;
	bh=2byjMYq9zflnptUBybKRNoXcRMUV0Mg1f0wnv7b1FyM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkcT0v+7Ym1J2G8gnEdi7dTZeg9SgyaZ51QOP2d1OTwqoFwPUcBbVgdD+x8ToOcISnrr4dQsmE0NChm5ya+pzfGBu2knkxZAyxe5ntYsz88yn9uUV2na/5VjT4PLwu/fpA/89kbqmNAk6Md7fEPjJHlhuPdl9K1qAQaap5BBjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt7H56H4Dz6HJg3;
	Thu, 31 Jul 2025 20:11:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F18B1402EA;
	Thu, 31 Jul 2025 20:16:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 14:16:00 +0200
Date: Thu, 31 Jul 2025 13:15:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>
Subject: Re: [PATCH 2/8] drivers/perf: hisi: Export hisi_uncore_pmu_isr()
Message-ID: <20250731131559.00005001@huawei.com>
In-Reply-To: <20250729153823.2026154-3-wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
	<20250729153823.2026154-3-wangyushan12@huawei.com>
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

On Tue, 29 Jul 2025 23:38:17 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently Uncore PMU framework assume one PMU device only have one
> interrupt and will help register the interrupt handler. It cannot
> support a PMU with multiple interrupt resources.  An uncore PMU may
> have multiple interrupts that can share the same handler.  Export
> hisi_uncore_pmu_isr() to allow drivers register the irq handler by
> their own routine.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 3 ++-
>  drivers/perf/hisilicon/hisi_uncore_pmu.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index 3050899ddf17..ff20ad54f51b 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -149,7 +149,7 @@ static void hisi_uncore_pmu_clear_event_idx(struct hisi_pmu *hisi_pmu, int idx)
>  	clear_bit(idx, hisi_pmu->pmu_events.used_mask);
>  }
>  
> -static irqreturn_t hisi_uncore_pmu_isr(int irq, void *data)
> +irqreturn_t hisi_uncore_pmu_isr(int irq, void *data)
>  {
>  	struct hisi_pmu *hisi_pmu = data;
>  	struct perf_event *event;
> @@ -178,6 +178,7 @@ static irqreturn_t hisi_uncore_pmu_isr(int irq, void *data)
>  
>  	return IRQ_HANDLED;
>  }
> +EXPORT_SYMBOL_NS_GPL(hisi_uncore_pmu_isr, "HISI_PMU");
>  
>  int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
>  			     struct platform_device *pdev)
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> index 50a97e79076a..40aac70352e9 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> @@ -163,6 +163,7 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node);
>  ssize_t hisi_uncore_pmu_identifier_attr_show(struct device *dev,
>  					     struct device_attribute *attr,
>  					     char *page);
> +irqreturn_t hisi_uncore_pmu_isr(int irq, void *data);
>  int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
>  			     struct platform_device *pdev);
>  void hisi_uncore_pmu_init_topology(struct hisi_pmu *hisi_pmu, struct device *dev);


