Return-Path: <linux-kernel+bounces-787542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE7CB377A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977BE208098
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADF225F995;
	Wed, 27 Aug 2025 02:15:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E925C83A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260919; cv=none; b=IeUiVMRq4MaTxPF/y0LEbNXw+cuNyhksCk8vdIb75cQXp55onRFmBJBcHYplMhU/gBdv3jPcywz3UkdHxR4NdjAJb6YKRzCBbQqDutiuQ/2Gn2fwoLeZLPEMWqh/UZjr/vcoxcJbBJcpl412QoeQVFdM9Rl58feWq4Zyw5P2JDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260919; c=relaxed/simple;
	bh=t7m7Vjr0mlgsF5Zl+Zrv2/s8Ahx3RYSp4oHny4ZVA3E=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pi+KVVbKn9fPvgrzpPOSY3tZwdjxf/j39XcShNrXRG662RYWcqEh9lTFS3rs5/M3Qs7VP+dzvvfwAdpXkMNpM+KWF0yp25eoKBFpRzd2fa7VBDqthrLoeI928FJZ6ZNJ1H6tLEMFJNveg+WVe+xRm/OJrTRnUnrqgkBoaPxUE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cBSmB5GnYz14MLH;
	Wed, 27 Aug 2025 10:15:06 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 851AD1401E9;
	Wed, 27 Aug 2025 10:15:13 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 10:15:13 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 10:15:12 +0800
CC: <yangyicong@hisilicon.com>, <robin.murphy@arm.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@h-partners.com>
Subject: Re: [PATCH v2 8/9] Documentation: hisi-pmu: Fix of minor format error
To: Yushan Wang <wangyushan12@huawei.com>, <will@kernel.org>,
	<mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250821135049.2010220-1-wangyushan12@huawei.com>
 <20250821135049.2010220-9-wangyushan12@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <3e19cbc9-7a23-dcde-af94-9afee42f044b@huawei.com>
Date: Wed, 27 Aug 2025 10:15:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250821135049.2010220-9-wangyushan12@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/8/21 21:50, Yushan Wang wrote:
> The inline path of sysfs should be placed in literal blocks to make
> documentation look better.
> 
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>

Acked-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  Documentation/admin-guide/perf/hisi-pmu.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
> index 48992a0b8e94..a307bce2f5c5 100644
> --- a/Documentation/admin-guide/perf/hisi-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pmu.rst
> @@ -18,9 +18,10 @@ HiSilicon SoC uncore PMU driver
>  Each device PMU has separate registers for event counting, control and
>  interrupt, and the PMU driver shall register perf PMU drivers like L3C,
>  HHA and DDRC etc. The available events and configuration options shall
> -be described in the sysfs, see:
> +be described in the sysfs, see::
> +
> +/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>
>  
> -/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>.
>  The "perf list" command shall list the available events from sysfs.
>  
>  Each L3C, HHA and DDRC is registered as a separate PMU with perf. The PMU
> 

