Return-Path: <linux-kernel+bounces-752122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC3FB17178
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50D618C7715
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63342C15A5;
	Thu, 31 Jul 2025 12:45:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC292C15A1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965955; cv=none; b=jsHG3O+NohBu1up8VwE8yl0ckH9CmZ/sz97TSabO5cVKdR7dzuwda9VDy5I3ROHmqfKN5FWPALs7+92OLzGXZzVSpwW7DSUGOdod2iAMlfVyNgpwOjsfxcn42aivyDM0YIawQIRKFrApHQcn1wl8JS+YIZnMKrTrMZVQlJRHj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965955; c=relaxed/simple;
	bh=6aL8dHm3qHflEVcJoghdBRYS/zJk+TxCjKz+uSmVmpE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOAssAINazryGbpRC6bQLE1yd04ifPzcxd6yMTu7F0yfaoXbUnDotNzdn8CK1iuFKwSKw+RCh2w6L7kng/RfQRhsDPZDNmq2vWOog7Z5uml6yRtYKjbgkI5hy4ACGV7vlFw4ZeHTY2TcZfihwgUbJUWq0VeGuan4Om7lQJlGk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt8082rFBz6L53t;
	Thu, 31 Jul 2025 20:43:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D0591400D9;
	Thu, 31 Jul 2025 20:45:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 14:45:50 +0200
Date: Thu, 31 Jul 2025 13:45:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>
Subject: Re: [PATCH 7/8] drivers/perf: hisi: Add support for L3C PMU v3
Message-ID: <20250731134548.000076c3@huawei.com>
In-Reply-To: <20250729153823.2026154-8-wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
	<20250729153823.2026154-8-wangyushan12@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Jul 2025 23:38:22 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> This patch adds support for L3C PMU v3. The v3 L3C PMU supports
> an extended events space which can be controlled in up to 2 extra
> address spaces with separate overflow interrupts. The layout
> of the control/event registers are kept the same. The extended events
> with original ones together cover the monitoring job of all transactions
> on L3C.
> 
> The extended events is specified with `ext=[1|2]` option for the
> driver to distinguish, like below:
> 
> perf stat -e hisi_sccl0_l3c0_0/event=<event_id>,ext=1/
> 
> Currently only event option using config bit [7, 0]. There's
> still plenty unused space. Make ext using config [16, 17] and
> reserve bit [15, 8] for event option for future extension.
> 
> With the capability of extra counters, number of counters for HiSilicon
> uncore PMU could reach up to 24, the usedmap is extended accordingly.
> 
> The hw_perf_event::event_base is initialized to the base MMIO
> address of the event and will be used for later control,
> overflow handling and counts readout.
> 
> We still make use of the Uncore PMU framework for handling the
> events and interrupt migration on CPU hotplug. The framework's
> cpuhp callback will handle the event migration and interrupt
> migration of orginial event, if PMU supports extended events
> then the interrupt of extended events is migrated to the same
> CPU choosed by the framework.
> 
> A new HID of HISI0215 is used for this version of L3C PMU.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Co-developed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>

Hi Yushan, Yicong

A few things inline that I missed during internal reviews.
Sorry about that!

Jonathan

> ---
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 360 +++++++++++++++++--
>  drivers/perf/hisilicon/hisi_uncore_pmu.h     |   2 +-
>  2 files changed, 329 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> index 6ac0ea74cda3..414c923f4ddf 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c

> +struct hisi_l3c_pmu_ext {
> +	bool support_ext;
> +};
> +
> +static inline bool support_ext(struct hisi_l3c_pmu *pmu)

Don't mark this sort of thing inline in a c file.  Let the compiler figure out
whether that makes sense

> +{
> +	return ((struct hisi_l3c_pmu_ext *)pmu->l3c_pmu.dev_info->private)->support_ext;
That's long and complicate enough I'd do something like.


	struct hisi_l3c_pmu_ext *l3c_pmu_ext = pmu->l3c_pmu.dev_info->private;

	return l3c_pmu_ext->supported_ext;

> +}

>  
> +static int hisi_l3c_pmu_check_filter(struct perf_event *event)
> +{
> +	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	int ext = hisi_get_ext(event);
> +
> +	return ext < 0 || ext > hisi_l3c_pmu->ext_num;

If you want to do this, return type of bool. If not 0, or negative error code.


> +}

>  static void hisi_l3c_pmu_stop_counters(struct hisi_pmu *l3c_pmu)
>  {
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	unsigned long *used_mask = l3c_pmu->pmu_events.used_mask;
> +	unsigned long bit = find_first_bit(used_mask, l3c_pmu->num_counters);
>  	u32 val;
> +	int i;
>  
>  	/*
> -	 * Clear perf_enable bit in L3C_PERF_CTRL register to stop counting
> -	 * for all enabled counters.
> +	 * Check if any counter belongs to the normal range (instead of ext
> +	 * range). If so, stop it.
>  	 */
> -	val = readl(l3c_pmu->base + L3C_PERF_CTRL);
> -	val &= ~(L3C_PERF_CTRL_EN);
> -	writel(val, l3c_pmu->base + L3C_PERF_CTRL);
> +	if (bit < L3C_NR_COUNTERS) {
> +		val = readl(l3c_pmu->base + L3C_PERF_CTRL);
> +		val &= ~(L3C_PERF_CTRL_EN);
> +		writel(val, l3c_pmu->base + L3C_PERF_CTRL);
> +	}
> +
> +	/* If not, do stop it on ext ranges. */
> +	for (i = 0; i < hisi_l3c_pmu->ext_num; i++) {
> +		bit = find_next_bit(used_mask, L3C_NR_COUNTERS * (i + 2),
> +				    L3C_NR_COUNTERS * (i + 1));
> +		if (L3C_CNTR_EXT(bit) == i + 1) {

Nesting is getting a bit deep. Consider

		if (L3C_CNTR_EXT(bit) != i + )
			continue

		val =...

> +			val = readl(hisi_l3c_pmu->ext_base[i] + L3C_PERF_CTRL);
> +			val &= ~L3C_PERF_CTRL_EN;
> +			writel(val, hisi_l3c_pmu->ext_base[i] + L3C_PERF_CTRL);
> +		}
> +	}
>  }

>  
>  static u32 hisi_l3c_pmu_get_int_status(struct hisi_pmu *l3c_pmu)
>  {
> -	return readl(l3c_pmu->base + L3C_INT_STATUS);
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	u32 status, status_ext = 0;
> +	u32 ext_int;
> +
> +	status = readl(l3c_pmu->base + L3C_INT_STATUS);
> +
> +	if (!support_ext(hisi_l3c_pmu))
> +		return status;
> +
> +	for (int i = 0; i < hisi_l3c_pmu->ext_num; i++) {

Be consistent on this.  It is becoming more acceptable to declare
i like this, but a driver should chose one style or another. 
*_init_ext declares it at the top for example.

> +		ext_int = readl(hisi_l3c_pmu->ext_base[i] + L3C_INT_STATUS);
> +		status_ext |= ext_int << (L3C_NR_COUNTERS * i);
> +	}
> +
> +	return status | (status_ext << L3C_NR_COUNTERS);
>  }

>  
> +static int hisi_l3c_pmu_init_ext(struct hisi_pmu *l3c_pmu, struct platform_device *pdev)
> +{
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	char *irqname;
> +	int ret, irq;
> +	int ext_num;
> +	int i;
Might as well combine all the int local variables
	int ret, irq, ext_num, i;
and save a few lines.

> +
> +	/* HiSilicon L3C PMU ext should have more than 1 irq resources. */
> +	ext_num = platform_irq_count(pdev);


>  static const struct hisi_uncore_ops hisi_uncore_l3c_ops = {
> @@ -525,11 +740,15 @@ static const struct hisi_uncore_ops hisi_uncore_l3c_ops = {
>  	.clear_int_status	= hisi_l3c_pmu_clear_int_status,
>  	.enable_filter		= hisi_l3c_pmu_enable_filter,
>  	.disable_filter		= hisi_l3c_pmu_disable_filter,
> +	.check_filter		= hisi_l3c_pmu_check_filter,
>  };
>  
>  static int hisi_l3c_pmu_dev_probe(struct platform_device *pdev,
>  				  struct hisi_pmu *l3c_pmu)
>  {
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	struct hisi_l3c_pmu_ext *l3c_pmu_dev_ext =
> +		(struct hisi_l3c_pmu_ext *)l3c_pmu->dev_info->private;

I think private is a void *? If so no need for the cast.

>  	int ret;
>  
>  	ret = hisi_l3c_pmu_init_data(pdev, l3c_pmu);
> @@ -548,27 +767,50 @@ static int hisi_l3c_pmu_dev_probe(struct platform_device *pdev,
>  	l3c_pmu->dev = &pdev->dev;
>  	l3c_pmu->on_cpu = -1;
>  
> +	if (l3c_pmu_dev_ext->support_ext) {
> +		ret = hisi_l3c_pmu_init_ext(l3c_pmu, pdev);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * The extension events have their own counters with the
> +		 * same number of the normal events counters. So we can
> +		 * have at maximum num_counters * ext events monitored.
> +		 */
> +		l3c_pmu->num_counters += hisi_l3c_pmu->ext_num * L3C_NR_COUNTERS;
> +	}
> +
>  	return 0;
>  }

>  
> +static int hisi_l3c_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pmu *l3c_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	int ret;
> +
> +	/*
> +	 * Invoking the framework's online function for doing the core logic
> +	 * of CPU, interrupt and perf context migrating. Then return directly
> +	 * if we don't support L3C_PMU_FEAT_EXT. Otherwise migrate the ext_irq
> +	 * using the migrated CPU.

This seems to be replicating the better placed comment below.  I'm not sure
this comment is adding anything useful.  Maybe just drop it?

> +	 *
> +	 * Same logic for CPU offline.
> +	 */
> +	ret = hisi_uncore_pmu_online_cpu(cpu, node);
> +	if (ret)
> +		return ret;
> +
> +	/* Avoid L3C pmu not supporting ext from ext irq migrating. */
> +	if (!support_ext(hisi_l3c_pmu))
> +		return 0;
> +
> +	for (int i = 0; i < hisi_l3c_pmu->ext_num; i++)
> +		WARN_ON(irq_set_affinity(hisi_l3c_pmu->ext_irq[i],
> +					 cpumask_of(l3c_pmu->on_cpu)));
> +	return 0;
> +}
> +
> +static int hisi_l3c_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pmu *l3c_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	int ret;
> +
> +	ret = hisi_uncore_pmu_offline_cpu(cpu, node);
> +	if (ret)
> +		return ret;
> +
> +	if (l3c_pmu->on_cpu >= nr_cpu_ids) {
> +		disable_irq(l3c_pmu->irq);

This needs a comment.  Not obvious to me why it only matters for this
hisi PMU.

> +		return 0;
> +	}
> +
> +	/* Avoid L3C pmu not supporting ext from ext irq migrating. */
> +	if (!support_ext(hisi_l3c_pmu))
> +		return 0;
> +
> +	for (int i = 0; i < hisi_l3c_pmu->ext_num; i++)
> +		WARN_ON(irq_set_affinity(hisi_l3c_pmu->ext_irq[i],
> +					 cpumask_of(l3c_pmu->on_cpu)));
> +	return 0;
> +}


