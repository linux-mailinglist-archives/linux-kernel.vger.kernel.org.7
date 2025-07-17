Return-Path: <linux-kernel+bounces-735090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E308B08ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723111C23B80
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F429AB02;
	Thu, 17 Jul 2025 10:37:34 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED62046B3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748654; cv=none; b=enjdX/iCkJCnu+K2JEPGwUAKvrwIMR6rumd0yCLIQd19k7ccEtTagdf6nAYKYXvbNuyDQ5zHt+5VOiadAOPlEvT6MBKXogN4FQldXcKOVEcx8rKNj5MxfA4pQkvS9Obe2yAF3gefCtAYhBw44K+SkO8pFL01WPqXRliX5EOVsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748654; c=relaxed/simple;
	bh=C2ARp+VWs/I9rnrwn79nC1LLD7FNb7tYDp2tzXUd5n0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJX14wKT/EC4/4c/s9bbA9QIaGdF5BPirP6Jcv9IIlTIASK9r8EhE/G8G69pQL3b28MCtOZgGwB4YlOkDtAHUJpjcnMtc/FRI+4V8Bch/8IRr0yS4hR+E9ONUPqXJrKgV7KFFC8hXSMuYMBGzxoeEbvBZgL0QXYhz0JnVGy82MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bjTqL3vS6z6K5qc;
	Thu, 17 Jul 2025 18:36:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 560581402F7;
	Thu, 17 Jul 2025 18:37:28 +0800 (CST)
Received: from localhost (10.48.159.214) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Jul
 2025 12:37:27 +0200
Date: Thu, 17 Jul 2025 11:37:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH v4 1/2] drivers/perf: hisi: Add support for HiSilicon
 NoC PMU
Message-ID: <20250717113725.000075fb@huawei.com>
In-Reply-To: <20250717074138.39903-2-yangyicong@huawei.com>
References: <20250717074138.39903-1-yangyicong@huawei.com>
	<20250717074138.39903-2-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 15:41:37 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

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
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Hi.

Just one trivial thing that I missed in internal review yesterday.
Not worth a respin though!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/perf/hisilicon/hisi_uncore_noc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_noc_pmu.c
> new file mode 100644
> index 000000000000..2e3eb7881caa
> --- /dev/null
> +++ b/drivers/perf/hisilicon/hisi_uncore_noc_pmu.c

> +
> +static struct hisi_noc_pmu_regs hisi_noc_v1_pmu_regs = {
> +	.version = NOC_PMU_VERSION,
> +	.pmu_ctrl = NOC_PMU_GLOBAL_CTRL,
> +	.event_ctrl0 = NOC_PMU_EVENT_CTRL0,
> +	.event_cntr0 = NOC_PMU_EVENT_COUNTER0,
> +	.ovflow_status = NOC_PMU_CNT_INFO,

Trivial but if you are spinning a v5 for some I'd just spell out
as .overflow_status.

I've never seen any consistency in abbreviations for overflow!

> +};
> +
> +static const struct hisi_pmu_dev_info hisi_noc_v1 = {
> +	.attr_groups = hisi_noc_pmu_attr_groups,
> +	.counter_bits = 64,
> +	.check_event = NOC_PMU_EVENT_CTRL_TYPE,
> +	.private = &hisi_noc_v1_pmu_regs,
> +};


