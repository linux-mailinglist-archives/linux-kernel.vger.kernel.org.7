Return-Path: <linux-kernel+bounces-786684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095F9B36288
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FBC68615F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC56C2D0606;
	Tue, 26 Aug 2025 13:12:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF05299A94
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213963; cv=none; b=JpQ0dPQAWCimnyXqtHJKrJ0FyTnPziPLzjaObW+sK0aCAoZUPTfW9T5M0OqqW0CXN4kFOTJbuPrrjocfvVEp6WiGdx7N8IjBTktwN1RYmcFmXyoXHGLas4CfJeAwXbvkP3wGIXUm9chILs6JqwJqWUlc9RGW42tQDi0JLAbVX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213963; c=relaxed/simple;
	bh=VP5M8WH6xnVYuIRD2ga8fKdso4IcBD9RLEMTk3guef8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwblnfNXODjxadAm7QRDzyEGHxTbLm3ELr1ppM6LsLCrQJACUaTjw1OwCD4zT2hNSFk0ytna/TE8voN/Fef7ZED8/MUr+kwSwNq/xZb92sRf1Oxo1YdAdsyXVxZbCUtZyl9Vx4wo/MvyQqLjL5zwBspSCRHDNHociq0bepdA4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cB7Lj6dCHz6LD83;
	Tue, 26 Aug 2025 21:10:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E8F9B14010D;
	Tue, 26 Aug 2025 21:12:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Aug
 2025 15:12:37 +0200
Date: Tue, 26 Aug 2025 14:12:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <yangyicong@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@h-partners.com>
Subject: Re: [PATCH v2 7/9] drivers/perf: hisi: Add support for L3C PMU v3
Message-ID: <20250826141235.000028b8@huawei.com>
In-Reply-To: <20250821135049.2010220-8-wangyushan12@huawei.com>
References: <20250821135049.2010220-1-wangyushan12@huawei.com>
	<20250821135049.2010220-8-wangyushan12@huawei.com>
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

On Thu, 21 Aug 2025 21:50:47 +0800
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
One minor formatting thing I missed in internal reviews. With that
tidied up (check other patches for this as well)

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

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

Brackets not adding anything here and inconsistently applied.
Please clean these up.

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


