Return-Path: <linux-kernel+bounces-787619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54BB378A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E409D1B64DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF162FA0DB;
	Wed, 27 Aug 2025 03:43:49 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AB274FF2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266228; cv=none; b=Dn5aIbHXn6bIIgmKSP3StZk9H4qBe6wB2BKNEjSdqCfToLr3ircweQcJ4dXzXPHR1BR10jvwipQXkMaw9KV1yxsUhxePy31oX4LLZWdD5TgbavXqN1q6dI+/YfFYjoXgiuEwXpWBbPUxYnhuQEkFEagiSDuK9CN6aaAUzFl8rK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266228; c=relaxed/simple;
	bh=9TWvdNIfZ8wMcQBUkIuFsuWM7+/b+T7k129wr2IfylY=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rvZ7WKQMV6hoDOKeTqWaXMlDfgkxIHjBFC9GjVZ6S9ybYIRwwS+1/hbVUfHZIvwL5f8HGYh13aElw3F04ssJOexfbfQR8J6qemskmGMn8pTque+/vjXOfNo2dqaCTgoXQXHjfTXE1CLWW6cyp27OAwqfPjMCATcBjfgcsaNIP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cBVdK0LJkzdcBb;
	Wed, 27 Aug 2025 11:39:17 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 143E71401E9;
	Wed, 27 Aug 2025 11:43:43 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 11:43:42 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 11:43:42 +0800
CC: <yangyicong@hisilicon.com>, <robin.murphy@arm.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@h-partners.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 7/9] drivers/perf: hisi: Add support for L3C PMU v3
To: Yushan Wang <wangyushan12@huawei.com>, <will@kernel.org>,
	<mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250821135049.2010220-1-wangyushan12@huawei.com>
 <20250821135049.2010220-8-wangyushan12@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <96237b52-ab01-36f1-0b3c-16e878e71073@huawei.com>
Date: Wed, 27 Aug 2025 11:43:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250821135049.2010220-8-wangyushan12@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/8/21 21:50, Yushan Wang wrote:
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

some minor comments inline. sorry again for not raising them in previous version.

> ---
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 352 +++++++++++++++++--
>  drivers/perf/hisilicon/hisi_uncore_pmu.h     |   2 +-
>  2 files changed, 321 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> index 7928b9bb3e7e..95136c01f17b 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> @@ -55,24 +55,85 @@
>  #define L3C_V1_NR_EVENTS	0x59
>  #define L3C_V2_NR_EVENTS	0xFF
>  
> +#define L3C_MAX_EXT		2
> +
> +HISI_PMU_EVENT_ATTR_EXTRACTOR(ext, config, 17, 16);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_req, config1, 10, 8);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core, config2, 15, 0);
>  
> +struct hisi_l3c_pmu {
> +	struct hisi_pmu l3c_pmu;
> +
> +	/* MMIO and IRQ resources for extension events */
> +	void __iomem *ext_base[L3C_MAX_EXT];
> +	int ext_irq[L3C_MAX_EXT];
> +	int ext_num;
> +};
> +
> +#define to_hisi_l3c_pmu(_l3c_pmu) \
> +	container_of(_l3c_pmu, struct hisi_l3c_pmu, l3c_pmu)
> +
> +/*
> + * The hardware counter idx used in counter enable/disable,
> + * interrupt enable/disable and status check, etc.
> + */
> +#define L3C_HW_IDX(_idx)		((_idx) % L3C_NR_COUNTERS)
> +
> +/* The ext resource number to which a hardware counter belongs. */
> +#define L3C_CNTR_EXT(_idx)		((_idx) / L3C_NR_COUNTERS)
> +
> +struct hisi_l3c_pmu_ext {
> +	bool support_ext;
> +};
> +
> +static bool support_ext(struct hisi_l3c_pmu *pmu)
> +{
> +	struct hisi_l3c_pmu_ext *l3c_pmu_ext = pmu->l3c_pmu.dev_info->private;
> +
> +	return l3c_pmu_ext->support_ext;
> +}
> +
>  static int hisi_l3c_pmu_get_event_idx(struct perf_event *event)
>  {
>  	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
>  	unsigned long *used_mask = l3c_pmu->pmu_events.used_mask;
> -	u32 num_counters = l3c_pmu->num_counters;
> +	int ext = hisi_get_ext(event);
>  	int idx;
>  
> -	idx = find_first_zero_bit(used_mask, num_counters);
> -	if (idx == num_counters)
> +	/*
> +	 * For an L3C PMU that supports extension events, we can monitor
> +	 * maximum 2 * num_counters to 3 * num_counters events, depending on
> +	 * the number of ext regions supported by hardware. Thus use bit
> +	 * [0, num_counters - 1] for normal events and bit
> +	 * [ext * num_counters, (ext + 1) * num_counters - 1] for extension
> +	 * events. The idx allocation will keep unchanged for normal events and
> +	 * we can also use the idx to distinguish whether it's an extension
> +	 * event or not.
> +	 *
> +	 * Since normal events and extension events locates on the different
> +	 * address space, save the base address to the event->hw.event_base.
> +	 */
> +	if (ext) {
> +		if (!support_ext(hisi_l3c_pmu))
> +			return -EOPNOTSUPP;
> +
> +		event->hw.event_base = (unsigned long)hisi_l3c_pmu->ext_base[ext - 1];
> +		idx = find_next_zero_bit(used_mask, L3C_NR_COUNTERS * (ext + 1),
> +					 L3C_NR_COUNTERS * ext);
> +	} else {
> +		event->hw.event_base = (unsigned long)l3c_pmu->base;
> +		idx = find_next_zero_bit(used_mask, L3C_NR_COUNTERS, 0);
> +	}
> +
> +	if (idx >= L3C_NR_COUNTERS * (ext + 1))
>  		return -EAGAIN;
>  
>  	set_bit(idx, used_mask);
> -	event->hw.event_base = (unsigned long)l3c_pmu->base;
> +
> +	WARN_ON(idx < L3C_NR_COUNTERS * ext || idx >= L3C_NR_COUNTERS * (ext + 1));
>  
>  	return idx;
>  }
> @@ -143,7 +204,7 @@ static void hisi_l3c_pmu_write_ds(struct perf_event *event, u32 ds_cfg)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	u32 reg, reg_idx, shift, val;
> -	int idx = hwc->idx;
> +	int idx = L3C_HW_IDX(hwc->idx);
>  
>  	/*
>  	 * Select the appropriate datasource register(L3C_DATSRC_TYPE0/1).
> @@ -264,12 +325,23 @@ static void hisi_l3c_pmu_disable_filter(struct perf_event *event)
>  	}
>  }
>  
> +static int hisi_l3c_pmu_check_filter(struct perf_event *event)
> +{
> +	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	int ext = hisi_get_ext(event);
> +
> +	if (ext < 0 || ext > hisi_l3c_pmu->ext_num)
> +		return -EINVAL;

newline here. similar to other places.

> +	return 0;
> +}
> +
>  /*
>   * Select the counter register offset using the counter index
>   */
>  static u32 hisi_l3c_pmu_get_counter_offset(int cntr_idx)
>  {
> -	return (L3C_CNTR0_LOWER + (cntr_idx * 8));
> +	return (L3C_CNTR0_LOWER + (L3C_HW_IDX(cntr_idx) * 8));
>  }
>  
>  static u64 hisi_l3c_pmu_read_counter(struct hisi_pmu *l3c_pmu,
> @@ -290,6 +362,8 @@ static void hisi_l3c_pmu_write_evtype(struct hisi_pmu *l3c_pmu, int idx,
>  	struct hw_perf_event *hwc = &l3c_pmu->pmu_events.hw_events[idx]->hw;
>  	u32 reg, reg_idx, shift, val;
>  
> +	idx = L3C_HW_IDX(idx);
> +
>  	/*
>  	 * Select the appropriate event select register(L3C_EVENT_TYPE0/1).
>  	 * There are 2 event select registers for the 8 hardware counters.
> @@ -310,28 +384,63 @@ static void hisi_l3c_pmu_write_evtype(struct hisi_pmu *l3c_pmu, int idx,
>  
>  static void hisi_l3c_pmu_start_counters(struct hisi_pmu *l3c_pmu)
>  {
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	unsigned long *used_mask = l3c_pmu->pmu_events.used_mask;
> +	unsigned long bit = find_first_bit(used_mask, l3c_pmu->num_counters);
>  	u32 val;
> +	int i;
>  
>  	/*
> -	 * Set perf_enable bit in L3C_PERF_CTRL register to start counting
> -	 * for all enabled counters.
> +	 * Check if any counter belongs to the normal range (instead of ext
> +	 * range). If so, enable it.
>  	 */
> -	val = readl(l3c_pmu->base + L3C_PERF_CTRL);
> -	val |= L3C_PERF_CTRL_EN;
> -	writel(val, l3c_pmu->base + L3C_PERF_CTRL);
> +	if (bit < L3C_NR_COUNTERS) {
> +		val = readl(l3c_pmu->base + L3C_PERF_CTRL);
> +		val |= L3C_PERF_CTRL_EN;
> +		writel(val, l3c_pmu->base + L3C_PERF_CTRL);
> +	}
> +
> +	/* If not, do enable it on ext ranges. */
> +	for (i = 0; i < hisi_l3c_pmu->ext_num; i++) {
> +		bit = find_next_bit(used_mask, L3C_NR_COUNTERS * (i + 2),
> +				    L3C_NR_COUNTERS * (i + 1));
> +		if (L3C_CNTR_EXT(bit) == i + 1) {
> +			val = readl(hisi_l3c_pmu->ext_base[i] + L3C_PERF_CTRL);
> +			val |= L3C_PERF_CTRL_EN;
> +			writel(val, hisi_l3c_pmu->ext_base[i] + L3C_PERF_CTRL);
> +		}
> +	}
>  }
>  
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
> +		if (L3C_CNTR_EXT(bit) != i + 1)
> +			continue;
> +
> +		val = readl(hisi_l3c_pmu->ext_base[i] + L3C_PERF_CTRL);
> +		val &= ~L3C_PERF_CTRL_EN;
> +		writel(val, hisi_l3c_pmu->ext_base[i] + L3C_PERF_CTRL);
> +	}
>  }
>  
>  static void hisi_l3c_pmu_enable_counter(struct hisi_pmu *l3c_pmu,
> @@ -341,7 +450,7 @@ static void hisi_l3c_pmu_enable_counter(struct hisi_pmu *l3c_pmu,
>  
>  	/* Enable counter index in L3C_EVENT_CTRL register */
>  	val = hisi_l3c_pmu_event_readl(hwc, L3C_EVENT_CTRL);
> -	val |= (1 << hwc->idx);
> +	val |= (1 << L3C_HW_IDX(hwc->idx));
>  	hisi_l3c_pmu_event_writel(hwc, L3C_EVENT_CTRL, val);
>  }
>  
> @@ -352,7 +461,7 @@ static void hisi_l3c_pmu_disable_counter(struct hisi_pmu *l3c_pmu,
>  
>  	/* Clear counter index in L3C_EVENT_CTRL register */
>  	val = hisi_l3c_pmu_event_readl(hwc, L3C_EVENT_CTRL);
> -	val &= ~(1 << hwc->idx);
> +	val &= ~(1 << L3C_HW_IDX(hwc->idx));
>  	hisi_l3c_pmu_event_writel(hwc, L3C_EVENT_CTRL, val);
>  }
>  
> @@ -363,7 +472,7 @@ static void hisi_l3c_pmu_enable_counter_int(struct hisi_pmu *l3c_pmu,
>  
>  	val = hisi_l3c_pmu_event_readl(hwc, L3C_INT_MASK);
>  	/* Write 0 to enable interrupt */
> -	val &= ~(1 << hwc->idx);
> +	val &= ~(1 << L3C_HW_IDX(hwc->idx));
>  	hisi_l3c_pmu_event_writel(hwc, L3C_INT_MASK, val);
>  }
>  
> @@ -374,20 +483,34 @@ static void hisi_l3c_pmu_disable_counter_int(struct hisi_pmu *l3c_pmu,
>  
>  	val = hisi_l3c_pmu_event_readl(hwc, L3C_INT_MASK);
>  	/* Write 1 to mask interrupt */
> -	val |= (1 << hwc->idx);
> +	val |= (1 << L3C_HW_IDX(hwc->idx));
>  	hisi_l3c_pmu_event_writel(hwc, L3C_INT_MASK, val);
>  }
>  
>  static u32 hisi_l3c_pmu_get_int_status(struct hisi_pmu *l3c_pmu)
>  {
> -	return readl(l3c_pmu->base + L3C_INT_STATUS);
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	u32 ext_int, status, status_ext = 0;
> +	int i;
> +
> +	status = readl(l3c_pmu->base + L3C_INT_STATUS);
> +
> +	if (!support_ext(hisi_l3c_pmu))
> +		return status;
> +
> +	for (i = 0; i < hisi_l3c_pmu->ext_num; i++) {
> +		ext_int = readl(hisi_l3c_pmu->ext_base[i] + L3C_INT_STATUS);
> +		status_ext |= ext_int << (L3C_NR_COUNTERS * i);
> +	}
> +
> +	return status | (status_ext << L3C_NR_COUNTERS);
>  }
>  
>  static void hisi_l3c_pmu_clear_int_status(struct hisi_pmu *l3c_pmu, int idx)
>  {
>  	struct hw_perf_event *hwc = &l3c_pmu->pmu_events.hw_events[idx]->hw;
>  
> -	hisi_l3c_pmu_event_writel(hwc, L3C_INT_CLEAR, 1 << idx);
> +	hisi_l3c_pmu_event_writel(hwc, L3C_INT_CLEAR, 1 << L3C_HW_IDX(idx));
>  }
>  
>  static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
> @@ -409,10 +532,6 @@ static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
>  		return -EINVAL;
>  	}
>  
> -	l3c_pmu->dev_info = device_get_match_data(&pdev->dev);
> -	if (!l3c_pmu->dev_info)
> -		return -ENODEV;
> -
>  	l3c_pmu->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(l3c_pmu->base)) {
>  		dev_err(&pdev->dev, "ioremap failed for l3c_pmu resource\n");
> @@ -424,6 +543,46 @@ static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int hisi_l3c_pmu_init_ext(struct hisi_pmu *l3c_pmu, struct platform_device *pdev)
> +{
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	int ret, irq, ext_num, i;
> +	char *irqname;
> +
> +	/* HiSilicon L3C PMU ext should have more than 1 irq resources. */
> +	ext_num = platform_irq_count(pdev);
> +	if (ext_num < 2)

will be more readable using L3C_MAX_EXT:

if (ext_num < L3C_MAX_EXT)
	return -ENODEV;

> +		return -ENODEV;
> +
> +	hisi_l3c_pmu->ext_num = ext_num - 1;
> +
> +	for (i = 0; i < hisi_l3c_pmu->ext_num; i++) {
> +		hisi_l3c_pmu->ext_base[i] = devm_platform_ioremap_resource(pdev, i + 1);
> +		if (IS_ERR(hisi_l3c_pmu->ext_base[i]))
> +			return PTR_ERR(hisi_l3c_pmu->ext_base[i]);
> +
> +		irq = platform_get_irq(pdev, i + 1);
> +		if (irq < 0)
> +			return irq;
> +
> +		irqname = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s ext%d",
> +					 dev_name(&pdev->dev), i + 1);
> +		if (!irqname)
> +			return -ENOMEM;
> +
> +		ret = devm_request_irq(&pdev->dev, irq, hisi_uncore_pmu_isr,
> +				       IRQF_NOBALANCING | IRQF_NO_THREAD,
> +				       irqname, l3c_pmu);
> +		if (ret < 0)
> +			return dev_err_probe(&pdev->dev, ret,
> +				"Fail to request EXT IRQ: %d.\n", irq);
> +
> +		hisi_l3c_pmu->ext_irq[i] = irq;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct attribute *hisi_l3c_pmu_v1_format_attr[] = {
>  	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
>  	NULL,
> @@ -448,6 +607,19 @@ static const struct attribute_group hisi_l3c_pmu_v2_format_group = {
>  	.attrs = hisi_l3c_pmu_v2_format_attr,
>  };
>  
> +static struct attribute *hisi_l3c_pmu_v3_format_attr[] = {
> +	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
> +	HISI_PMU_FORMAT_ATTR(ext, "config:16-17"),
> +	HISI_PMU_FORMAT_ATTR(tt_req, "config1:8-10"),
> +	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_l3c_pmu_v3_format_group = {
> +	.name = "format",
> +	.attrs = hisi_l3c_pmu_v3_format_attr,
> +};
> +
>  static struct attribute *hisi_l3c_pmu_v1_events_attr[] = {
>  	HISI_PMU_EVENT_ATTR(rd_cpipe,		0x00),
>  	HISI_PMU_EVENT_ATTR(wr_cpipe,		0x01),
> @@ -483,6 +655,26 @@ static const struct attribute_group hisi_l3c_pmu_v2_events_group = {
>  	.attrs = hisi_l3c_pmu_v2_events_attr,
>  };
>  
> +static struct attribute *hisi_l3c_pmu_v3_events_attr[] = {
> +	HISI_PMU_EVENT_ATTR(rd_spipe,		0x18),
> +	HISI_PMU_EVENT_ATTR(rd_hit_spipe,	0x19),
> +	HISI_PMU_EVENT_ATTR(wr_spipe,		0x1a),
> +	HISI_PMU_EVENT_ATTR(wr_hit_spipe,	0x1b),
> +	HISI_PMU_EVENT_ATTR(io_rd_spipe,	0x1c),
> +	HISI_PMU_EVENT_ATTR(io_rd_hit_spipe,	0x1d),
> +	HISI_PMU_EVENT_ATTR(io_wr_spipe,	0x1e),
> +	HISI_PMU_EVENT_ATTR(io_wr_hit_spipe,	0x1f),
> +	HISI_PMU_EVENT_ATTR(cycles,		0x7f),
> +	HISI_PMU_EVENT_ATTR(l3c_ref,		0xbc),
> +	HISI_PMU_EVENT_ATTR(l3c2ring,		0xbd),
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_l3c_pmu_v3_events_group = {
> +	.name = "events",
> +	.attrs = hisi_l3c_pmu_v3_events_attr,
> +};
> +
>  static const struct attribute_group *hisi_l3c_pmu_v1_attr_groups[] = {
>  	&hisi_l3c_pmu_v1_format_group,
>  	&hisi_l3c_pmu_v1_events_group,
> @@ -499,16 +691,41 @@ static const struct attribute_group *hisi_l3c_pmu_v2_attr_groups[] = {
>  	NULL
>  };
>  
> +static const struct attribute_group *hisi_l3c_pmu_v3_attr_groups[] = {
> +	&hisi_l3c_pmu_v3_format_group,
> +	&hisi_l3c_pmu_v3_events_group,
> +	&hisi_pmu_cpumask_attr_group,
> +	&hisi_pmu_identifier_group,
> +	NULL
> +};
> +
> +static struct hisi_l3c_pmu_ext hisi_l3c_pmu_support_ext = {
> +	.support_ext = true,
> +};
> +
> +static struct hisi_l3c_pmu_ext hisi_l3c_pmu_not_support_ext = {
> +	.support_ext = false,
> +};
> +
>  static const struct hisi_pmu_dev_info hisi_l3c_pmu_v1 = {
>  	.attr_groups = hisi_l3c_pmu_v1_attr_groups,
>  	.counter_bits = 48,
>  	.check_event = L3C_V1_NR_EVENTS,
> +	.private = &hisi_l3c_pmu_not_support_ext,
>  };
>  
>  static const struct hisi_pmu_dev_info hisi_l3c_pmu_v2 = {
>  	.attr_groups = hisi_l3c_pmu_v2_attr_groups,
>  	.counter_bits = 64,
>  	.check_event = L3C_V2_NR_EVENTS,
> +	.private = &hisi_l3c_pmu_not_support_ext,
> +};
> +
> +static const struct hisi_pmu_dev_info hisi_l3c_pmu_v3 = {
> +	.attr_groups = hisi_l3c_pmu_v3_attr_groups,
> +	.counter_bits = 64,
> +	.check_event = L3C_V2_NR_EVENTS,
> +	.private = &hisi_l3c_pmu_support_ext,
>  };
>  
>  static const struct hisi_uncore_ops hisi_uncore_l3c_ops = {
> @@ -526,11 +743,14 @@ static const struct hisi_uncore_ops hisi_uncore_l3c_ops = {
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
> +	struct hisi_l3c_pmu_ext *l3c_pmu_dev_ext = l3c_pmu->dev_info->private;
>  	int ret;
>  
>  	ret = hisi_l3c_pmu_init_data(pdev, l3c_pmu);
> @@ -549,27 +769,50 @@ static int hisi_l3c_pmu_dev_probe(struct platform_device *pdev,
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
>  static int hisi_l3c_pmu_probe(struct platform_device *pdev)
>  {
> +	struct hisi_l3c_pmu *hisi_l3c_pmu;
>  	struct hisi_pmu *l3c_pmu;
>  	char *name;
>  	int ret;
>  
> -	l3c_pmu = devm_kzalloc(&pdev->dev, sizeof(*l3c_pmu), GFP_KERNEL);
> -	if (!l3c_pmu)
> +	hisi_l3c_pmu = devm_kzalloc(&pdev->dev, sizeof(*hisi_l3c_pmu), GFP_KERNEL);
> +	if (!hisi_l3c_pmu)
>  		return -ENOMEM;
>  
> +	l3c_pmu = &hisi_l3c_pmu->l3c_pmu;
>  	platform_set_drvdata(pdev, l3c_pmu);
>  
> +	l3c_pmu->dev_info = device_get_match_data(&pdev->dev);
> +	if (!l3c_pmu->dev_info)
> +		return -ENODEV;
> +

any reason to move this out of hisi_l3c_pmu_init_data()? it looks unnecessary.

>  	ret = hisi_l3c_pmu_dev_probe(pdev, l3c_pmu);
>  	if (ret)
>  		return ret;
>  
> -	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%d_l3c%d",
> -			      l3c_pmu->topo.sccl_id, l3c_pmu->topo.ccl_id);
> +	if (l3c_pmu->topo.sub_id >= 0)
> +		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%d_l3c%d_%d",
> +				      l3c_pmu->topo.sccl_id, l3c_pmu->topo.ccl_id,
> +				      l3c_pmu->topo.sub_id);
> +	else
> +		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%d_l3c%d",
> +				      l3c_pmu->topo.sccl_id, l3c_pmu->topo.ccl_id);
>  	if (!name)
>  		return -ENOMEM;
>  
> @@ -604,6 +847,7 @@ static void hisi_l3c_pmu_remove(struct platform_device *pdev)
>  static const struct acpi_device_id hisi_l3c_pmu_acpi_match[] = {
>  	{ "HISI0213", (kernel_ulong_t)&hisi_l3c_pmu_v1 },
>  	{ "HISI0214", (kernel_ulong_t)&hisi_l3c_pmu_v2 },
> +	{ "HISI0215", (kernel_ulong_t)&hisi_l3c_pmu_v3 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, hisi_l3c_pmu_acpi_match);
> @@ -618,14 +862,58 @@ static struct platform_driver hisi_l3c_pmu_driver = {
>  	.remove = hisi_l3c_pmu_remove,
>  };
>  
> +static int hisi_l3c_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pmu *l3c_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
> +	int ret;
> +
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
> +	/* If failed to find any available CPU, skip irq migration. */
> +	if (l3c_pmu->on_cpu <= 0)

0 should be a valid cpu for migration, do I miss something here?

thanks.

> +		return 0;
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
>  static int __init hisi_l3c_pmu_module_init(void)
>  {
>  	int ret;
>  
>  	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>  				      "AP_PERF_ARM_HISI_L3_ONLINE",
> -				      hisi_uncore_pmu_online_cpu,
> -				      hisi_uncore_pmu_offline_cpu);
> +				      hisi_l3c_pmu_online_cpu,
> +				      hisi_l3c_pmu_offline_cpu);
>  	if (ret) {
>  		pr_err("L3C PMU: Error setup hotplug, ret = %d\n", ret);
>  		return ret;
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> index 02fa022925d4..0334a797e499 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> @@ -24,7 +24,7 @@
>  #define pr_fmt(fmt)     "hisi_pmu: " fmt
>  
>  #define HISI_PMU_V2		0x30
> -#define HISI_MAX_COUNTERS 0x10
> +#define HISI_MAX_COUNTERS 0x18
>  #define to_hisi_pmu(p)	(container_of(p, struct hisi_pmu, pmu))
>  
>  #define HISI_PMU_ATTR(_name, _func, _config)				\
> 

