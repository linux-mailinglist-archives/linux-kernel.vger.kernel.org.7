Return-Path: <linux-kernel+bounces-752124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89BB1717B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE5E7AC99E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B0239E89;
	Thu, 31 Jul 2025 12:48:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DFF5234
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966086; cv=none; b=Tfjiwll42Ae+VkhK9ASmmr4TEJyjyQBJZ+3AjA6EmAF6PsKDj9J3uASwAKGmTRYzWMG+kY3vYvMBrTmzh/MpaNXlC32O+A2mYU6WBugRNxknwZNlKoM0n9cDwzqC6D3njXZWhE2T2Udh1F731zzt0e80TQ3Yqy8PPF6C4FuG/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966086; c=relaxed/simple;
	bh=dhLXZRPRNG4amiW8YAoI8Q50FpVZtG8GhTi/+KNYzuQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCdhoSLuX4wonhZUej9Jzfk7BQ66EutQsW8U/XlIifVZ3gyLuQ48Q0pdYPk0/d4QLtx76huj3ZxIP9uBMEEbm0BwhWKmE69xWn68kOjivr8UWmadq3fcjWkxEGarKl7rE21a7v5r7oBEDkBypULmjGIf7qyKJPyZNKauB3Uki24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt82g6P8Yz6L534;
	Thu, 31 Jul 2025 20:46:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CB7421402EA;
	Thu, 31 Jul 2025 20:48:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 14:48:00 +0200
Date: Thu, 31 Jul 2025 13:47:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>
Subject: Re: [PATCH 8/8] Documentation: hisi-pmu: Add introduction to
 HiSilicon V3 PMU
Message-ID: <20250731134759.00000c74@huawei.com>
In-Reply-To: <20250729153823.2026154-9-wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
	<20250729153823.2026154-9-wangyushan12@huawei.com>
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

On Tue, 29 Jul 2025 23:38:23 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> Some of HiSilicon V3 PMU hardware is divided into parts to fulfill the
> job of monitoring specific parts of a device.  Add description on that
> as well as the newly added ext operand for L3C PMU.
> 
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
There is one fixlet hiding in here that maybe could have been done
as a precursor.  I doubt anyone cares though!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  Documentation/admin-guide/perf/hisi-pmu.rst | 43 +++++++++++++++++++--
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
> index 48992a0b8e94..4c7584fe3c1a 100644
> --- a/Documentation/admin-guide/perf/hisi-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pmu.rst
> @@ -12,15 +12,16 @@ The HiSilicon SoC encapsulates multiple CPU and IO dies. Each CPU cluster
>  called Super CPU cluster (SCCL) and is made up of 6 CCLs. Each SCCL has
>  two HHAs (0 - 1) and four DDRCs (0 - 3), respectively.
>  
> -HiSilicon SoC uncore PMU driver
> --------------------------------
> +HiSilicon SoC uncore PMU v1
> +---------------------------
>  
>  Each device PMU has separate registers for event counting, control and
>  interrupt, and the PMU driver shall register perf PMU drivers like L3C,
>  HHA and DDRC etc. The available events and configuration options shall
> -be described in the sysfs, see:
> +be described in the sysfs, see::
> +
> +/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>
>  
> -/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>.

This is fixing existing stuff so maybe should be a separate patch.

>  The "perf list" command shall list the available events from sysfs.
>  
>  Each L3C, HHA and DDRC is registered as a separate PMU with perf. The PMU


