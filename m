Return-Path: <linux-kernel+bounces-730328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2253BB0432E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E146F167348
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7686E2609D4;
	Mon, 14 Jul 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvA8E5fd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA6260582
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505901; cv=none; b=JZvB22wmB4g1WKaRHkjmIGx0qwEYwGxxYGdJV8JvVk4dJMbMyZdRTcREU0Z/AZlfWgQYPt+/ZoE5oIjEsJhScc/s5twHSFIbjjDNTJF4PnB/j6nSNPgt8R3a9weaQy68447wzco5MzT3oWEkw3KvPZMdocRn9+hnJJZE4gc+o1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505901; c=relaxed/simple;
	bh=OoveOS18V+H9a1dqKkOQiPA6wT3JMHnInuThtr8wR30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxt4DrQiJTdid4AAvNVFqaUYJdowK6LY8pZYqWEFR1uvb9GCW88WWLYWjhYpRVUqkgcq8qr1sbkYM0Nxrws0iG0H21Q38eyFzlF4jEWFeEaS22NigPZmKtQ5avlpeN1+WTjI0a+LTD2FbkUtgdRNa6hk090sAGnbzv9ExSxN+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvA8E5fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC507C4CEF0;
	Mon, 14 Jul 2025 15:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505901;
	bh=OoveOS18V+H9a1dqKkOQiPA6wT3JMHnInuThtr8wR30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvA8E5fdSyrwQ9Ro7U7nMpZ35yl8CGgsCk6EPpeiKzrgdxLB95qqb0K7KakbkcVGO
	 PNVqgAf6mxILpGxw558Gbc/9SAFw0KKIHAF0OFU9lb2HWwgyq2f3lkx3IoJuPGQ1CH
	 AAAQ4xeCQZWaYZl2mzWSEeOzD1mgU5oSHWiJBDynYirXCBYkxvzqslDuZKL6eNa+F8
	 S2M3IA/WtxSpaSc/qBSBiUYb57UDek3NrziiTzhd6KP27nl8BHPASwu58qOOLn6sir
	 9xsc1eQVdEuClBdcKuU92/cUdOHOmswwJrxV5bgGm/5teTawobMQQkXZYuJTz6mH1c
	 +fqxe1+zcCnaw==
Date: Mon, 14 Jul 2025 16:11:35 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, hejunhao3@huawei.com,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, yangyicong@hisilicon.com,
	wangyushan12@huawei.com
Subject: Re: [RESEND PATCH v3 7/8] drivers/perf: hisi: Add support for
 HiSilicon NoC PMU
Message-ID: <aHUeJ1ovziG1rTyW@willie-the-truck>
References: <20250619125557.57372-1-yangyicong@huawei.com>
 <20250619125557.57372-8-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619125557.57372-8-yangyicong@huawei.com>

On Thu, Jun 19, 2025 at 08:55:56PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Adds the support for HiSilicon NoC (Network on Chip) PMU which
> will be used to monitor the events on the system bus. The PMU
> device will be named after the SCL ID (either Super CPU cluster
> or Super IO cluster) and the index ID, just similar to other
> HiSilicon Uncore PMUs. Below PMU formats are provided besides
> the event:
> 
> - ch: the transaction channel (data, request, response, etc) which
>   can be used to filter the counting.
> - tt_en: tracetag filtering enable. Just as other HiSilicon Uncore
>   PMUs the NoC PMU supports only counting the transactions with
>   tracetag.
> 
> The NoC PMU doesn't have an interrupt to indicate the overflow.
> However we have a 64 bit counter which is large enough and it's
> nearly impossible to overflow.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  Documentation/admin-guide/perf/hisi-pmu.rst  |  11 +
>  drivers/perf/hisilicon/Makefile              |   3 +-
>  drivers/perf/hisilicon/hisi_uncore_noc_pmu.c | 392 +++++++++++++++++++
>  3 files changed, 405 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c

[...]

> +static int hisi_noc_pmu_dev_init(struct platform_device *pdev, struct hisi_pmu *noc_pmu)
> +{
> +	hisi_uncore_pmu_init_topology(noc_pmu, &pdev->dev);
> +
> +	if (noc_pmu->topo.scl_id < 0)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get scl-id\n");
> +
> +	if (noc_pmu->topo.index_id < 0)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get idx-id\n");
> +
> +	if (noc_pmu->topo.sub_id < 0)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get sub-id\n");
> +
> +	noc_pmu->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(noc_pmu->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(noc_pmu->base),
> +				     "fail to remap io memory\n");
> +
> +	noc_pmu->on_cpu = -1;
> +	noc_pmu->dev = &pdev->dev;
> +	noc_pmu->ops = &hisi_uncore_noc_ops;
> +	noc_pmu->pmu_events.attr_groups = hisi_noc_pmu_attr_groups;
> +	noc_pmu->num_counters = NOC_PMU_NR_COUNTERS;
> +	noc_pmu->counter_bits = NOC_PMU_COUNTER_BITS;
> +	noc_pmu->check_event = NOC_PMU_EVENT_CTRL_TYPE;
> +	noc_pmu->identifier = readl(noc_pmu->base + NOC_PMU_VERSION);

Would it be worth going straight to an ACPI-based lookup for this lot?
The earlier patches in the series rework the existing drivers to go in
that direction as it's easier to extend, so it seems a little odd for
new driver code to revert back to e.g. reeading the version number.

Same for the misc node driver in the next patch.

Will

