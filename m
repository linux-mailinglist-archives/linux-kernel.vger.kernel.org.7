Return-Path: <linux-kernel+bounces-744110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3AB1081D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A661895FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ABA2690F9;
	Thu, 24 Jul 2025 10:50:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3747F9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354234; cv=none; b=eyapkw/SPXBmEepHmcQ/DEX40ZqHdOyPUUDMNJ+M8qWhMjhdGlS2Jm5dm1S09z3fWh7HaIYbl3aSQiRP7mPoXPJmPcuzh7nv2LO119m4+kIIICXFH+JJ3nCRMVtt4sC7FB/lqH3H/9UpQh3OhxUTCgSj5nROc3dR1SrVLDB6bNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354234; c=relaxed/simple;
	bh=ykcQpgO0/pkuAK8xsMOxAVXbR2Qf5eM2MPzTaPEjSlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skYybV2yb+/YoYO3ppb31odAcc6AqV+zglxaaGayYONKMbYpNvKcSPsj+YxiKQhRoi4wsNwUOxTURgGtnLk5Wt8HNbSeLiKGL4tyFM0K819s4I4N4xznYRIc3lECu9TsjjPp7i1hwWOaud+r4pPGZvNVl4bd1dDEJuv92T0z+V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70D352B;
	Thu, 24 Jul 2025 03:50:25 -0700 (PDT)
Received: from [10.57.84.166] (unknown [10.57.84.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79EEF3F5A1;
	Thu, 24 Jul 2025 03:50:28 -0700 (PDT)
Message-ID: <e2d5cc53-b2d5-42d7-97cb-b21180361c1c@arm.com>
Date: Thu, 24 Jul 2025 11:50:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/36] ACPI / MPAM: Parse the MPAM table
Content-Language: en-GB
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-11-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250711183648.30766-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/07/2025 19:36, James Morse wrote:
> Add code to parse the arm64 specific MPAM table, looking up the cache
> level from the PPTT and feeding the end result into the MPAM driver.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/arm64/Kconfig          |   1 +
>   drivers/acpi/arm64/Kconfig  |   3 +
>   drivers/acpi/arm64/Makefile |   1 +
>   drivers/acpi/arm64/mpam.c   | 365 ++++++++++++++++++++++++++++++++++++
>   drivers/acpi/tables.c       |   2 +-
>   include/linux/arm_mpam.h    |  46 +++++
>   6 files changed, 417 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/acpi/arm64/mpam.c
>   create mode 100644 include/linux/arm_mpam.h
[snip]
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> new file mode 100644
> index 000000000000..f4791bac9a2a
> --- /dev/null
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +/* Parse the MPAM ACPI table feeding the discovered nodes into the driver */
> +
> +#define pr_fmt(fmt) "ACPI MPAM: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/platform_device.h>
> +
> +#include <acpi/processor.h>
> +
> +/* Flags for acpi_table_mpam_msc.*_interrupt_flags */
> +#define ACPI_MPAM_MSC_IRQ_MODE_EDGE                    1
> +#define ACPI_MPAM_MSC_IRQ_TYPE_MASK                    (3 << 1)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                   0
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER BIT(3)
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID               BIT(4)
> +
> +static bool frob_irq(struct platform_device *pdev, int intid, u32 flags,
> +		     int *irq, u32 processor_container_uid)
> +{
> +	int sense;
> +
> +	if (!intid)
> +		return false;
> +
> +	/* 0 in this field indicates a wired interrupt */
> +	if (flags & ACPI_MPAM_MSC_IRQ_TYPE_MASK)
> +		return false;
> +
> +	if (flags & ACPI_MPAM_MSC_IRQ_MODE_EDGE)
> +		sense = ACPI_EDGE_SENSITIVE;
> +	else
> +		sense = ACPI_LEVEL_SENSITIVE;
> +
> +	/*
> +	 * If the GSI is in the GIC's PPI range, try and create a partitioned
> +	 * percpu interrupt.
> +	 */
> +	if (16 <= intid && intid < 32 && processor_container_uid != ~0) {
> +		pr_err_once("Partitioned interrupts not supported\n");
> +		return false;
> +	}
> +
> +	*irq = acpi_register_gsi(&pdev->dev, intid, sense, ACPI_ACTIVE_HIGH);
> +	if (*irq <= 0) {
> +		pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
> +			    intid);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void acpi_mpam_parse_irqs(struct platform_device *pdev,
> +				 struct acpi_mpam_msc_node *tbl_msc,
> +				 struct resource *res, int *res_idx)
> +{
> +	u32 flags, aff = ~0;
> +	int irq;
> +
> +	flags = tbl_msc->overflow_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff = tbl_msc->overflow_interrupt_affinity;
> +	if (frob_irq(pdev, tbl_msc->overflow_interrupt, flags, &irq, aff)) {
> +		res[*res_idx].start = irq;
> +		res[*res_idx].end = irq;
> +		res[*res_idx].flags = IORESOURCE_IRQ;
> +		res[*res_idx].name = "overflow";
> +
> +		(*res_idx)++;
> +	}
> +
> +	flags = tbl_msc->error_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff = tbl_msc->error_interrupt_affinity;
> +	else
> +		aff = ~0;
> +	if (frob_irq(pdev, tbl_msc->error_interrupt, flags, &irq, aff)) {
> +		res[*res_idx].start = irq;
> +		res[*res_idx].end = irq;
> +		res[*res_idx].flags = IORESOURCE_IRQ;
> +		res[*res_idx].name = "error";
> +
> +		(*res_idx)++;
> +	}
> +}
> +
> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
> +				    struct acpi_mpam_resource_node *res)
> +{
> +	int level, nid;
> +	u32 cache_id;
> +
> +	switch (res->locator_type) {
> +	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
> +		cache_id = res->locator.cache_locator.cache_reference;
> +		level = find_acpi_cache_level_from_id(cache_id);
> +		if (level < 0) {
> +			pr_err_once("Bad level (%u) for cache with id %u\n", level, cache_id);
> +			return -EINVAL;
Nit: More robust to check for level <= 0.

Thanks,

Ben


