Return-Path: <linux-kernel+bounces-745490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4FB11AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF06B3AB716
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1DC2C324D;
	Fri, 25 Jul 2025 09:16:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FC278E7C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435009; cv=none; b=rUCP/PbFZmB9q6pU7wXi+Or3YFCY+Ud5yonrfsdxx2oJVrPLMVnctmOmeHWKvQih4zON6p3jaqez+HpC3FXcwMG9tn2jcPN7/hpMAfFxfmXQ7kYgwLoFbiHA36GIXdl0NLXjeSODLcTsag5JQ/lTVtt3F8jTsHlv6AA0pN7OZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435009; c=relaxed/simple;
	bh=Ui5gSzUByY8htEPUM/weu2brKmH1FKZpZa4uznBtzYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A6vX/0FNB4adM0m0LkBZaXMP4xBB5iObauQPik6EcbqePtzaRr2lDWgl1xBY8/ezb3g3ex6ejS4pdN8vFj/PezW+oyIQJYMAsxDo3ieU8GwSa/upMRtYQ0ft572mg1yi1gZKO3D54+natr/P2+1NJUvH3zld8YWw/0jr51bnPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bpMfg65STztSnd;
	Fri, 25 Jul 2025 17:15:39 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F8A718006C;
	Fri, 25 Jul 2025 17:16:43 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Jul 2025 17:16:43 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Jul 2025 17:16:42 +0800
Message-ID: <3cf2c010-4ea2-42c8-9bdd-deaa854d1af3@huawei.com>
Date: Fri, 25 Jul 2025 17:16:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 drm-dp 00/11] Fix hibmc driver bugs
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <libaihan@huawei.com>, <shenjian15@huawei.com>,
	<shaojijie@huawei.com>, <jani.nikula@linux.intel.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20250718065125.2892404-1-shiyongbang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq100007.china.huawei.com (7.202.195.175)

Gentle ping for review !


> From: Baihan Li <libaihan@huawei.com>
>
> There are some bugfix for hibmc-drm driver.
> ---
> ChangeLog:
> v2 -> v3:
>    - fix hibmc_connector_get_modes() and hibmc_vdac_detect() to realize BMC KVM, suggested by Dmitry Baryshkov.
>    - fix the issue commit ID, suggested by Dmitry Baryshkov.
>    - split into 2 commits, suggested by Dmitry Baryshkov.
>    - add more comments in commit log, suggested by Dmitry Baryshkov.
> ---
>
> Baihan Li (11):
>    drm/hisilicon/hibmc: fix the i2c device resource leak when vdac init
>      failed
>    drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD
>      irq
>    drm/hisilicon/hibmc: fix irq_request()'s irq name variable is local
>    drm/hisilicon/hibmc: fix the hibmc loaded failed bug
>    drm/hisilicon/hibmc: fix rare monitors cannot display problem
>    drm/hisilicon/hibmc: add dp mode valid check
>    drm/hisilicon/hibmc: fix dp and vga cannot show together
>    drm/hisilicon/hibmc: fix no showing when no connectors connected
>    drm/hisilicon/hibmc: fix no showing problem with loading hibmc
>      manually
>    drm/hisilicon/hibmc: adapting modification for the former commit
>    drm/hisilicon/hibmc: modification for the former commit
>
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 +-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 51 ++++++++++----
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  8 +++
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 33 +++++++---
>   .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    | 12 ----
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 64 ++++++++++++++++--
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 22 ++++---
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  5 ++
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   |  5 ++
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 66 +++++++++++++------
>   10 files changed, 201 insertions(+), 69 deletions(-)
>

