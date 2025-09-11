Return-Path: <linux-kernel+bounces-812142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E300B5338B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CBF5869C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46FF322DCA;
	Thu, 11 Sep 2025 13:22:42 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507F320CD9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596962; cv=none; b=rmq5sHCHU5re7CwizZdVvpuig44V9++y8OjkGNAzMAOUD2npyhgB3mO19oXSyPKR3PRSb2vw+pdpsn60Zi0hmFHt3UuQHEc1899IPsyQa2455zlhLEmCDnywZngUSPm4O7E1fwkTU+vUxSeOgS2l6qUq4Q8m2PALfd3L3mLgnyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596962; c=relaxed/simple;
	bh=Yd2EJLm8t0kF+CBlgDQcCM+kwX0M3TihxOMA7uYg4F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Amy910g19jDUIS+Qk5pHA+fYn6vgJRirNgalLSssiLyMcJYhTyNFVC6kDak3MzzqF0RBPsLQ7MoCYkHM5BcxCB9/YYeYUbGvoyRXropX5mbubWXgQw092IajO5hPMirXdqO7N5MI4rOzEYZomQXRekOlN4ROwxUlXjFcSCJ3CvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cMyth6Tbwz3tZbc;
	Thu, 11 Sep 2025 21:23:40 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 94B701A0188;
	Thu, 11 Sep 2025 21:22:31 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 21:22:31 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 21:22:30 +0800
Message-ID: <54fb6d7e-3c42-4dff-9bc7-b98cba75e3e1@huawei.com>
Date: Thu, 11 Sep 2025 21:22:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] Updates of HiSilicon Uncore L3C PMU
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <robin.murphy@arm.com>, <yangyicong@huawei.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@h-partners.com>, <fanghao11@huawei.com>, Linuxarm
	<linuxarm@huawei.com>
References: <20250829101427.2557899-1-wangyushan12@huawei.com>
Content-Language: en-US
From: wangyushan <wangyushan12@huawei.com>
In-Reply-To: <20250829101427.2557899-1-wangyushan12@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100008.china.huawei.com (7.202.194.111)

A gentle ping...

On 8/29/2025 6:14 PM, Yushan Wang wrote:
> Support new version of L3C PMU, which supports extended events space
> which can be controlled in up to 2 extra address spaces with separate
> overflow interrupts.  The layout of the control/event registers are kept
> the same.  The extended events with original ones together cover the
> monitoring job of all transactions on L3C.
>
> That's said, the driver supports finer granual statistics of L3 cache
> with separated and dedicated PMUs, and a new option `ext` to give a
> hint of to which part should perf counting command be delivered.
>
> The extended events is specified with `ext=[1|2]` option for the driver
> to distinguish:
>
> perf stat -e hisi_sccl0_l3c0_0/event=<event_id>,ext=<ext>/
>
> Currently only event option using config bit [7, 0]. There's still
> plenty unused space. Make ext using config [16, 17] and reserve
> bit [15, 8] for event option for future extension.
>
> With the capability of extra counters, number of counters for HiSilicon
> uncore PMU could reach up to 24, the usedmap is extended accordingly.
>
> The hw_perf_event::event_base is initialized to the base MMIO address
> of the event and will be used for later control, overflow handling and
> counts readout.
>
> We still make use of the Uncore PMU framework for handling the events
> and interrupt migration on CPU hotplug. The framework's cpuhp callback
> will handle the event migration and interrupt migration of orginial
> event, if PMU supports extended events then the interrupt of extended
> events is migrated to the same CPU choosed by the framework.
>
> A new HID of HISI0215 is used for this version of L3C PMU.
>
> Some necessary refactor is included, allowing the framework to cope with
> the new version of driver.
>
> Depends-on: drivers/perf: hisi: Add support for HiSilicon NOC and MN PMU driver
> Depends-on: Message-ID: <20250717121727.61057-1-yangyicong@huawei.com>
>
> ---
>
> Changes:
>
> v2 -> v3:
>    - Refactor made for better readability.
>    - Fixed failure examination in cpu offline callback.
>    - Some minor reword of documentation, and droped subsection titles as
>      suggested by Yicong.
>    - Link to v2: https://lore.kernel.org/all/20250821135049.2010220-1-wangyushan12@huawei.com/
>
> v1 -> v2:
>    - Don't call disable_irq() and simply return success when there is no
>      CPU available for irq migration.
>    - Documentation patch split.
>    - Fix of a few other issues etc. per Jonathan.
>    - Link to v1: https://lore.kernel.org/all/20250729153823.2026154-1-wangyushan12@huawei.com/
>
> Yicong Yang (7):
>    drivers/perf: hisi: Relax the event ID check in the framework
>    drivers/perf: hisi: Export hisi_uncore_pmu_isr()
>    drivers/perf: hisi: Simplify the probe process of each L3C PMU version
>    drivers/perf: hisi: Extract the event filter check of L3C PMU
>    drivers/perf: hisi: Extend the field of tt_core
>    drivers/perf: hisi: Refactor the event configuration of L3C PMU
>    drivers/perf: hisi: Add support for L3C PMU v3
>
> Yushan Wang (2):
>    Documentation: hisi-pmu: Fix of minor format error
>    Documentation: hisi-pmu: Add introduction to HiSilicon V3 PMU
>
>   Documentation/admin-guide/perf/hisi-pmu.rst  |  38 +-
>   drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 528 +++++++++++++++----
>   drivers/perf/hisilicon/hisi_uncore_pmu.c     |   5 +-
>   drivers/perf/hisilicon/hisi_uncore_pmu.h     |   6 +-
>   4 files changed, 481 insertions(+), 96 deletions(-)
>


