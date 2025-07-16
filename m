Return-Path: <linux-kernel+bounces-733953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480D1B07B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950681892079
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8460D2F548A;
	Wed, 16 Jul 2025 16:26:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD32523F26B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683219; cv=none; b=P9RQJBqU27VXtB/3dzOZ6jlG+ufGFnYZ3htISelUAthwg3sMRk1IzP+5rlSHRG+K9dlvLwvFj8CwiR1UNlhfiFtt4KQhrrri9HHeS7CjClhbk6IHpbFmFYoc2fsTCnYgaIAgNAKQWdQ9xgKL3DptP+poKIuZ/HH/qt9NcJlwmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683219; c=relaxed/simple;
	bh=SlIt4yue8sni+eVZVFWgBtZRE/trYcuDittuEsSpMsI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEcgZo4OeZYUItUZQANwEy0ye1VeHBM6O9ISwDTmN9/gb8a/EmYOCEhBALs1DvfnxQl5TaU/mDMm1Iyel36YXGvUlk1gHrWhsCQRbUdXQARO1A5eHqeXlsmqv8MiJMnJRhei0oWPM4MgiKagz16sHdqt9IebrkjujyEVxFcUZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bj1d30ZsCz6L5BC;
	Thu, 17 Jul 2025 00:25:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ED361402F4;
	Thu, 17 Jul 2025 00:26:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 18:26:53 +0200
Date: Wed, 16 Jul 2025 17:26:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Rob Herring" <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>, Rohit
 Mathew <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	"Zeng Heng" <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
	"Carl Worth" <carl@os.amperecomputing.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <lcherian@marvell.com>,
	<bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, Koba Ko
	<kobak@nvidia.com>
Subject: Re: [RFC PATCH 09/36] arm64: kconfig: Add Kconfig entry for MPAM
Message-ID: <20250716172652.00005a76@huawei.com>
In-Reply-To: <20250711183648.30766-10-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
	<20250711183648.30766-10-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 18:36:21 +0000
James Morse <james.morse@arm.com> wrote:

> The bulk of the MPAM driver lives outside the arch code because it
> largely manages MMIO devices that generate interrupts. The driver
> needs a Kconfig symbol to enable it, as MPAM is only found on arm64
> platforms, that is where the Kconfig option makes the most sense.
> 
> This Kconfig option will later be used by the arch code to enable
> or disable the MPAM context-switch code, and registering the CPUs
> properties with the MPAM driver.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Seems like a reasonable help test so FWIW

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  arch/arm64/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 55fc331af337..5f08214537d0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2058,6 +2058,23 @@ config ARM64_TLB_RANGE
>  	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>  	  range of input addresses.
>  
> +config ARM64_MPAM
> +	bool "Enable support for MPAM"
> +	help
> +	  Memory Partitioning and Monitoring is an optional extension
> +	  that allows the CPUs to mark load and store transactions with
> +	  labels for partition-id and performance-monitoring-group.
> +	  System components, such as the caches, can use the partition-id
> +	  to apply a performance policy. MPAM monitors can use the
> +	  partition-id and performance-monitoring-group to measure the
> +	  cache occupancy or data throughput.
> +
> +	  Use of this extension requires CPU support, support in the
> +	  memory system components (MSC), and a description from firmware
> +	  of where the MSC are in the address space.
> +
> +	  MPAM is exposed to user-space via the resctrl pseudo filesystem.
> +
>  endmenu # "ARMv8.4 architectural features"
>  
>  menu "ARMv8.5 architectural features"


