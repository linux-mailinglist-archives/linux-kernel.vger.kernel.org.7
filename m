Return-Path: <linux-kernel+bounces-847717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B6BCB801
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C03A37AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAD224B0E;
	Fri, 10 Oct 2025 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="T2TJglwi"
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE028F5
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760066647; cv=none; b=kBpbq0lPqMjsXv9ee+/6hCHHtWCAxfxvalurkVFWN5Pz8CV5imwdKqxw9Zc/AEcL1IFsSYZLi3f9QOI/Et3APoXD/GcAngfdPqcFYB4gyUVLdG7rm5KVzjPBYolEGs779LrUlXMYBCIOR5GqPp2tqkrx7PnMBXV1jXYln6ulsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760066647; c=relaxed/simple;
	bh=KcZsV/BRaqXceNIvABEmbQuxiZVdOSozcLc6PO+2VdI=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cmG7Tf/NbN2aj+xhn+Z2Rc7YGXv437xounufOPTRoRED6qZGN9Fnl5VsqOpDz2aB2p1aci2KK8Mqag8CEwM/On0A41qT8mz93lu9pQUOmiWMYk85WnemotGXSAGq52rYBYSuYhVgcSWVRawxHju3zL4Wke7WYtY+NdeI96vbDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=T2TJglwi; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eL9OBTX7exVlHZ+j/VeoTs13ur7IISJ94UDW65z/ugY=;
	b=T2TJglwipJVdW3I2L8NtQWg0ImrMa0WZoYoaCvwcf3sJe4MNf/CpS8k0JygHH5IU2yCp4D41d
	2g21aNpIzf2+oC8H60v/dp6uu6wsa80P3calCu3Y8obvs1c40M0GwPpDDdDLPiUsyEc1z0YPvjm
	1C1Aol0b2pNB0/mQ56ZqohA=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cjXBM5WGGznTWt;
	Fri, 10 Oct 2025 11:23:07 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D13B11800CF;
	Fri, 10 Oct 2025 11:23:55 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Oct 2025 11:23:44 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Oct 2025 11:23:43 +0800
CC: <yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <fanghao11@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PTT driver maintainer
To: Yang Shen <shenyang39@huawei.com>
References: <20251010014847.2747140-1-shenyang39@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <81d63996-41e3-029a-7de4-cb78c9bbfb26@huawei.com>
Date: Fri, 10 Oct 2025 11:23:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251010014847.2747140-1-shenyang39@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200018.china.huawei.com (7.202.195.108)

+cc Suzuki.

as ptt patches are usually kindly processed through coresight tree, many appreciations.

On 2025/10/10 9:48, Yang Shen wrote:
> Add Yang Shen as the maintainer of the HiSilicon PTT driver,
> replacing Yicong Yang.
> 
> Signed-off-by: Yang Shen <shenyang39@huawei.com>

good luck :)

Acked-by: Yicong Yang <yangyicong@hisilicon.com>

thanks.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a6f4ef1cca3..e9a40db0f368 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11278,8 +11278,8 @@ F:	drivers/perf/hisilicon
>  F:	tools/perf/pmu-events/arch/arm64/hisilicon/
>  
>  HISILICON PTT DRIVER
> -M:	Yicong Yang <yangyicong@hisilicon.com>
>  M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Yang Shen <shenyang39@huawei.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
> 

