Return-Path: <linux-kernel+bounces-770813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C643B27F40
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1177F1CE8A26
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B332F90C7;
	Fri, 15 Aug 2025 11:33:16 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C9285CA6;
	Fri, 15 Aug 2025 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257595; cv=none; b=CQCycjiIFdr7L51ukqsEfcq8kBlwFwxs7Ah5MLPN0e3IlvD0rZ94A08MRMPCqRoppmykZrmu3l+jxWVxyg6g2PB121OKcxJOoeEhhpUryCb/xZZPfomrRSIrFqmGIduWPnkSKksF21BQG2CPRU+GzFNIMvGbR7KxKYtcSx7VJyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257595; c=relaxed/simple;
	bh=sNIZoIZfS2w5CLOuw0MqduQTL+xYkQ//GpdGIbEaXSM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrlAVL3EYLXsx0QuFv/Zvyy0Su05n4k9DvQ6vCAknOEL+noqcJqwhKwAU/HmWlAA94qDEh/ugOL04azoyiuhg4NMes2gFVripb2BuhD3f7D8QYp4rnyGUyi9VB0X/e8F2ELwrhDVft+9i1IbDMcb5hQw7jZGV5Zjlzk7n6pqdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3KfQ60rmz6H7hy;
	Fri, 15 Aug 2025 19:30:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BF57F1402E9;
	Fri, 15 Aug 2025 19:33:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 13:33:08 +0200
Date: Fri, 15 Aug 2025 12:33:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Koichi Okuno <fj2767dz@fujitsu.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>, Linu Cherian
	<lcherian@marvell.com>, Robin Murphy <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, Bjorn Andersson
	<quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio
	<konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "=?ISO-8859-1?Q?N=EDcolas?= \"F. R. A. Prado\""
	<nfraprado@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Message-ID: <20250815123307.000032db@huawei.com>
In-Reply-To: <20250815034751.3726963-2-fj2767dz@fujitsu.com>
References: <20250815034751.3726963-1-fj2767dz@fujitsu.com>
	<20250815034751.3726963-2-fj2767dz@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Aug 2025 12:47:28 +0900
Koichi Okuno <fj2767dz@fujitsu.com> wrote:

> This adds a new dynamic PMU to the Perf Events framework to program and
> control the Uncore MAC PMUs in Fujitsu chips.
> 
> This driver was created with reference to drivers/perf/qcom_l3_pmu.c.
> 
> This driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
> 
> perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls
> 
> FUJITSU-MONAKA PMU Events Specification v1.1 URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Signed-off-by: Koichi Okuno <fj2767dz@fujitsu.com>

Hi, just one slight doubt inline around interrupt affinities.
I can't quite remember what breaks when those don't move with the
perf state and so can't immediately see if relevant here.

Anyhow, if that is resolved (either by you saying it's definitely
not an issue) or adding the irq_set_affinity() calls, then

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Jonathan

> diff --git a/drivers/perf/fujitsu_mac_pmu.c b/drivers/perf/fujitsu_mac_pmu.c
> new file mode 100644
> index 000000000000..1031e0221bb2
> --- /dev/null
> +++ b/drivers/perf/fujitsu_mac_pmu.c
> @@ -0,0 +1,552 @@

> +#define MAC_EVENT_CYCLES                        0x000
Maybe drop the lading 0 on all these values? 0x00
etc as we don't go beyond 0xa0

> +#define MAC_EVENT_READ_COUNT                    0x010
> +#define MAC_EVENT_READ_COUNT_REQUEST            0x011
> +#define MAC_EVENT_READ_COUNT_RETURN             0x012
> +#define MAC_EVENT_READ_COUNT_REQUEST_PFTGT      0x013
> +#define MAC_EVENT_READ_COUNT_REQUEST_NORMAL     0x014
> +#define MAC_EVENT_READ_COUNT_RETURN_PFTGT_HIT   0x015
> +#define MAC_EVENT_READ_COUNT_RETURN_PFTGT_MISS  0x016
> +#define MAC_EVENT_READ_WAIT                     0x017
> +#define MAC_EVENT_WRITE_COUNT                   0x020
> +#define MAC_EVENT_WRITE_COUNT_WRITE             0x021
> +#define MAC_EVENT_WRITE_COUNT_PWRITE            0x022
> +#define MAC_EVENT_MEMORY_READ_COUNT             0x040
> +#define MAC_EVENT_MEMORY_WRITE_COUNT            0x050
> +#define MAC_EVENT_MEMORY_PWRITE_COUNT           0x060
> +#define MAC_EVENT_EA_MAC                        0x080
> +#define MAC_EVENT_EA_MEMORY                     0x090
> +#define MAC_EVENT_EA_MEMORY_MAC_WRITE           0x092
> +#define MAC_EVENT_EA_HA                         0x0a0
> +
> +struct mac_pmu {
> +	struct pmu		pmu;
> +	struct hlist_node	node;
> +	void __iomem		*regs;
> +	struct perf_event	*events[MAC_NUM_COUNTERS];
> +	unsigned long		used_mask[BITS_TO_LONGS(MAC_NUM_COUNTERS)];
> +	cpumask_t		cpumask;
> +};

> +static void fujitsu_mac_counter_update(struct perf_event *event)
> +{
> +	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +	u64 prev, new;
> +
> +	do {
> +		prev = local64_read(&event->hw.prev_count);
> +		new = readq_relaxed(macpmu->regs + MAC_PM_EVCNTR(idx));
> +	} while (local64_cmpxchg(&event->hw.prev_count, prev, new) != prev);
> +
> +	local64_add(new - prev, &event->count);
> +}



> +static int fujitsu_mac_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *acpi_dev;
> +	struct mac_pmu *macpmu;
> +	struct resource *memrc;
> +	char *name;
> +	int ret;
> +	u64 uid;
> +
> +	acpi_dev = ACPI_COMPANION(dev);
> +	if (!acpi_dev)
> +		return -ENODEV;
> +
> +	ret = acpi_dev_uid_to_integer(acpi_dev, &uid);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "unable to read ACPI uid\n");
> +
> +	macpmu = devm_kzalloc(dev, sizeof(*macpmu), GFP_KERNEL);
> +	if (!macpmu)
> +		return -ENOMEM;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "mac_iod%llu_mac%llu_ch%llu",
> +			      (uid >> 8) & 0xF, (uid >> 4) & 0xF, uid & 0xF);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	macpmu->pmu = (struct pmu) {
> +		.parent		= dev,
> +		.task_ctx_nr	= perf_invalid_context,
> +
> +		.pmu_enable	= fujitsu_mac__pmu_enable,
> +		.pmu_disable	= fujitsu_mac__pmu_disable,
> +		.event_init	= fujitsu_mac__event_init,
> +		.add		= fujitsu_mac__event_add,
> +		.del		= fujitsu_mac__event_del,
> +		.start		= fujitsu_mac__event_start,
> +		.stop		= fujitsu_mac__event_stop,
> +		.read		= fujitsu_mac__event_read,
> +
> +		.attr_groups	= fujitsu_mac_pmu_attr_grps,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
> +	};
> +
> +	macpmu->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &memrc);
> +	if (IS_ERR(macpmu->regs))
> +		return PTR_ERR(macpmu->regs);
> +
> +	fujitsu_mac__init(macpmu);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, ret, fujitsu_mac__handle_irq, 0,
> +			       name, macpmu);

It's been a while since I wrote a perf driver, but I'm a bit surprised to not
see irq affinity management in here.  I remember running into issues with
per cpu variables deep in perf when we didn't ensure the perf state and
the irq remain on the same cpu core.  

There might be something different here though.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Request for IRQ failed for slice @%pa\n",
> +				     &memrc->start);
> +
> +	/* Add this instance to the list used by the offline callback */
> +	ret = cpuhp_state_add_instance(mac_pmu_cpuhp_state, &macpmu->node);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error registering hotplug");
> +
> +	ret = perf_pmu_register(&macpmu->pmu, name, -1);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to register MAC PMU\n");
> +
> +	dev_dbg(dev, "Registered %s, type: %d\n", name, macpmu->pmu.type);
> +
> +	return 0;
> +}


