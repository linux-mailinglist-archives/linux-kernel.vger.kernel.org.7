Return-Path: <linux-kernel+bounces-727849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D614DB0209D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6D04A5888
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BFA2ED873;
	Fri, 11 Jul 2025 15:40:32 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6542ED160;
	Fri, 11 Jul 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248431; cv=none; b=WOoYRTPx8oHeVfssT8SDK5HqxrNt+bTWOHaBlEOmbln4ZQBLFnWyWScleKu3g3j3yTmS2JpJ2KOC9pYq62HdtAyx2iVvkeLIPvSCAjmt3pU0UzIudYRpk+oyZQxHqJN1VdiIxGE6BgyuKyXyVUHxc6Wb6fZqN8h4pRoqVbLKaUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248431; c=relaxed/simple;
	bh=HaQOLJQQuclMlLLNemF5yVy60Z2HFjGPKuNXEndcjbA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6k1Kl3mH31lVwMhYHcpzPYDiG2iUplEK6w6GYzkjImzAja/bYDsOa9RN3mLzTJSBbH1/FJFIQw3eFjeT5B9TQlVnNtt5tHewwVdNY1NbTDHMMjQnicONDntKkM6oBEnPuloIB5UUqVc6wGbpHQIXw/BI8bxuAHGoEAykFI9piI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdwnG30Qlz6L563;
	Fri, 11 Jul 2025 23:37:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D2EA5140279;
	Fri, 11 Jul 2025 23:40:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:24 +0200
Date: Fri, 11 Jul 2025 16:40:22 +0100
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
Subject: Re: [PATCH v6 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Message-ID: <20250711164022.000059b9@huawei.com>
In-Reply-To: <20250711071404.2138816-2-fj2767dz@fujitsu.com>
References: <20250711071404.2138816-1-fj2767dz@fujitsu.com>
	<20250711071404.2138816-2-fj2767dz@fujitsu.com>
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

On Fri, 11 Jul 2025 16:13:39 +0900
Koichi Okuno <fj2767dz@fujitsu.com> wrote:

> This adds two new dynamic PMUs to the Perf Events framework to program
> and control the Uncore MAC PMUs in Fujitsu chips.
> 
> These drivers were created with reference to drivers/perf/qcom_l3_pmu.c.
> 
> These drivers export formatting and event information to sysfs so they can
> be used by the perf user space tools with the syntaxes:
> 
> perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls
> 
> FUJITSU-MONAKA PMU Events Specification v1.1 URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Signed-off-by: Koichi Okuno <fj2767dz@fujitsu.com>
Hi

We may have discussed on an earlier version and I've forgotten about it
(in which case sorry!) but why can't this be modular?

Given the chances are we will want it in standard distributions, a
bool kconfig seems to ensure bloat that people are not going to want to
see.

A few other minor comments inline.

Thanks,

Jonathan

> ---
>  .../admin-guide/perf/fujitsu_mac_pmu.rst      |  73 +++
>  Documentation/admin-guide/perf/index.rst      |   1 +
>  drivers/perf/Kconfig                          |   9 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/fujitsu_mac_pmu.c                | 569 ++++++++++++++++++
>  5 files changed, 653 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
>  create mode 100644 drivers/perf/fujitsu_mac_pmu.c
> 
> diff --git a/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
> new file mode 100644
> index 000000000000..383f3c1bbde7
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
> @@ -0,0 +1,73 @@
> +====================================================
> +Fujitsu Uncore MAC Performance Monitoring Unit (PMU)
> +====================================================
> +
> +This driver supports the Uncore MAC PMUs found in Fujitsu chips.
> +Each MAC PMU on these chips is exposed as a uncore perf PMU with device name
> +mac_iod<iod>_mac<mac>_ch<ch>.
> +
> +The driver provides a description of its available events and configuration
> +options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/.
> +This driver exports:
> +- formats, used by perf user space and other tools to configure events
> +- events, used by perf user space and other tools to create events
> +  symbolically, e.g.:
> +    perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls
> +- cpumask, used by perf user space and other tools to know on which CPUs
> +  to open the events
> +
> +This driver supports the following events:
> +- cycles
> +  This event counts MAC cycles at MAC frequency.

Trivial but you could shorten all these by rewording to drop the This Event and counts
as both obvious from context.

  - cycles
    MAC Cycles at MAC frequency.
  - read-count
    Number of read requests to MAC.
etc

> +- read-count
> +  This event counts the number of read requests to MAC.
> +- read-count-request
> +  This event counts the number of read requests including retry to MAC.
> +- read-count-return
> +  This event counts the number of responses to read requests to MAC.
> +- read-count-request-pftgt
> +  This event counts the number of read requests including retry with PFTGT
> +  flag.
> +- read-count-request-normal
> +  This event counts the number of read requests including retry without PFTGT
> +  flag.
> +- read-count-return-pftgt-hit
> +  This event counts the number of responses to read requests which hit the
> +  PFTGT buffer.
> +- read-count-return-pftgt-miss
> +  This event counts the number of responses to read requests which miss the
> +  PFTGT buffer.
> +- read-wait
> +  This event counts outstanding read requests issued by DDR memory controller
> +  per cycle.
> +- write-count
> +  This event counts the number of write requests to MAC (including zero write,
> +  full write, partial write, write cancel).
> +- write-count-write
> +  This event counts the number of full write requests to MAC (not including
> +  zero write).
> +- write-count-pwrite
> +  This event counts the number of partial write requests to MAC.
> +- memory-read-count
> +  This event counts the number of read requests from MAC to memory.
> +- memory-write-count
> +  This event counts the number of full write requests from MAC to memory.
> +- memory-pwrite-count
> +  This event counts the number of partial write requests from MAC to memory.
> +- ea-mac
> +  This event counts energy consumption of MAC.
> +- ea-memory
> +  This event counts energy consumption of memory.
> +- ea-memory-mac-write
> +  This event counts the number of write requests from MAC to memory.
> +- ea-ha
> +  This event counts energy consumption of HA.
> +
> +  'ea' is the abbreviation for 'Energy Analyzer'.
> +
> +Examples for use with perf::
> +
> +  perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> +
> +Given that these are uncore PMUs the driver does not support sampling, therefore
> +"perf record" will not work. Per-task perf sessions are not supported.

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 278c929dc87a..269bf72a512a 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -178,6 +178,15 @@ config FSL_IMX9_DDR_PMU
>  	 can give information about memory throughput and other related
>  	 events.
>  
> +config FUJITSU_MAC_PMU
> +	bool "Fujitsu Uncore MAC PMU"

We may have discussed this in an earlier version but why not
tristate? + module_init() 

> +	depends on (ARM64 && (ACPI || COMPILE_TEST))
> +	help
> +	 Provides support for the Uncore MAC performance monitor unit (PMU)
> +	 in Fujitsu processors.
> +	 Adds the Uncore MAC PMU into the perf events subsystem for
> +	 monitoring Uncore MAC events.
> +
>  config QCOM_L2_PMU
>  	bool "Qualcomm Technologies L2-cache PMU"
>  	depends on ARCH_QCOM && ARM64 && ACPI

> diff --git a/drivers/perf/fujitsu_mac_pmu.c b/drivers/perf/fujitsu_mac_pmu.c
> new file mode 100644
> index 000000000000..3c5e838b9894
> --- /dev/null
> +++ b/drivers/perf/fujitsu_mac_pmu.c
> @@ -0,0 +1,569 @@

> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/list.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +/* Number of counters on each PMU */
> +#define MAC_NUM_COUNTERS  8
> +/* Mask for the event type field within perf_event_attr.config and EVTYPE reg */
> +#define MAC_EVTYPE_MASK   0xFF
> +
> +/* Perfmon registers */
> +#define MAC_PM_EVCNTR(__cntr) (0x000 + (__cntr) * 8)
> +#define MAC_PM_CNTCTL(__cntr) (0x100 + (__cntr) * 8)
> +#define MAC_PM_EVTYPE(__cntr) (0x200 + (__cntr) * 8)
> +#define MAC_PM_CR         0x400
> +#define MAC_PM_CNTENSET   0x410
> +#define MAC_PM_CNTENCLR   0x418
> +#define MAC_PM_INTENSET   0x420
> +#define MAC_PM_INTENCLR   0x428
> +#define MAC_PM_OVSR       0x440

> +
> +/* MAC_PM_INTENCLR */
> +#define PMINTENCLR(__cntr)    BIT(__cntr)
> +#define PM_INTENCLR_RESET     0xFF
> +
> +/* MAC_PM_OVSR */

I'd rather see the macros named to make it clear which register
they apply to sufficiently that the comments aren't needed.
Also in my view good to put them directly under the register definine.

> +#define PMOVSRCLR(__cntr)     BIT(__cntr)
Not used.
> +#define PMOVSRCLR_RESET       0xFF


> +/*
> + * We must NOT create groups containing events from multiple hardware PMUs,
> + * although mixing different software and hardware PMUs is allowed.
> + */
> +static bool fujitsu_mac__validate_event_group(struct perf_event *event)
> +{
> +	struct perf_event *leader = event->group_leader;
> +	struct perf_event *sibling;
> +	int counters = 0;

Value never used.

> +
> +	if (leader->pmu != event->pmu && !is_software_event(leader))
> +		return false;
> +
> +	/* The sum of the counters used by the event and its leader event */
> +	counters = 2;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (is_software_event(sibling))
> +			continue;
> +		if (sibling->pmu != event->pmu)
> +			return false;
> +		counters++;
> +	}
> +
> +	/*
> +	 * If the group requires more counters than the HW has, it
> +	 * cannot ever be scheduled.
> +	 */
> +	return counters <= MAC_NUM_COUNTERS;
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
> +			  (uid >> 8) & 0xF, (uid >> 4) & 0xF, uid & 0xF);
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
> +						   name, macpmu);

Unusual indentation.  Normally second line of parametes should just be
aligned under first set of parameters.  E.g.

	ret = devm_request_irq(dev, ret, fujitsu_mac__handle_irq, 0,
			       name, macpmu);

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Request for IRQ failed for slice @%pa\n",
> +							 &memrc->start);

Similar for this second line set of parameters.

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


> +static int __init register_fujitsu_mac_pmu_driver(void)
> +{
> +	int ret;
> +
> +	/* Install a hook to update the reader CPU in case it goes offline */
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +				      "perf/fujitsu/mac:online",
> +				      fujitsu_mac_pmu_online_cpu,
> +				      fujitsu_mac_pmu_offline_cpu);
> +	if (ret < 0)
> +		return ret;
> +
> +	mac_pmu_cpuhp_state = ret;
> +	return platform_driver_register(&fujitsu_mac_pmu_driver);
> +}
> +device_initcall(register_fujitsu_mac_pmu_driver);

Perhaps add a comment on why this can be a module? Would need a trivial
exit plus to use module_init() / module_exit()
 



