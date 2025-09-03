Return-Path: <linux-kernel+bounces-797576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB4AB41210
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8041A807AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05F81DE3B5;
	Wed,  3 Sep 2025 01:50:17 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DAA1A5B9E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756864217; cv=none; b=GGtmNcPJLsorbUgzPbDy1wmUCXfzrYghrm5HPKRAgJkQEfkYLOqRmvaeipmJsNc3D2afhUaBCEdZxgMMzj1OBeFFhD1QGplWb5hiqUbZRFMq5PjjmvAOo0aPFrM5UQlXgDZtmG8ShkAv4TiowmJQW2dSLYQGMVdrQEYhP7h0s1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756864217; c=relaxed/simple;
	bh=fB1NVzgigMO7OnnXXWJquR/Vsex3iGmO70VV/xABy+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j6xDcth9jIvP7NT21naoyrkDTuX4qisIpeWdnP+a/1uzM/LZ02Ka40xmwT/fo3HNSbMnH8Gieo3ZW2FV3wLfD5/HbJm/NDZ0a/Z1k2Nk3gKiw65Y2nr9o5Mh0G/c0qhxrXGFBfLNAk56YVt2CcPin3JseMKUkDJWN66SXHzfoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cGlvW3gn3z27jCl;
	Wed,  3 Sep 2025 09:51:19 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B23ED140145;
	Wed,  3 Sep 2025 09:50:11 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 09:50:11 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 09:50:10 +0800
Message-ID: <bcd18421-1361-4c0a-bd3b-4eee8dc66ec4@huawei.com>
Date: Wed, 3 Sep 2025 09:50:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 drm-dp 0/4] Fix hibmc driver bugs
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <libaihan@huawei.com>, <shenjian15@huawei.com>,
	<shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20250826021744.3237574-1-shiyongbang@huawei.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20250826021744.3237574-1-shiyongbang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq100007.china.huawei.com (7.202.195.175)

Gently ping,
Thanks!

> From: Baihan Li <libaihan@huawei.com>
>
> There are some bugfix for hibmc-drm driver.
> ---
> ChangeLog:
> v4 -> v5:
>    - Because some of patches are applied, this series only contains the rest of them.
>    - fix the commit and DP detect_ctx(), suggested by Dmitry Baryshkov.
>    - fix bugfix commit ID, suggested by Dmitry Baryshkov.
>    - remove the 08/11 patch, I'll add in next series.
>    - combined 9 and 11 patch together, suggested by Dmitry Baryshkov.
> v3 -> v4:
>    - remove link training process in hibmc_dp_detect(), suggested by Dmitry Baryshkov.
>    - remove if (dev->registered), suggested by Dmitry Baryshkov.
>    - remove non-related changes, suggested by Dmitry Baryshkov.
>    - Remove the clock check, suggested by Dmitry Baryshkov.
>    - ( I'll add them in next series after redesigning this part)
>    - add KVM edid in commit message, suggested by Dmitry Baryshkov.
>    - fix magic values, suggested by Dmitry Baryshkov.
>    - fix the commit subjects, suggested by Dmitry Baryshkov.
> v2 -> v3:
>    - fix hibmc_connector_get_modes() and hibmc_vdac_detect() to realize BMC KVM, suggested by Dmitry Baryshkov.
>    - fix the issue commit ID, suggested by Dmitry Baryshkov.
>    - split into 2 commits, suggested by Dmitry Baryshkov.
>    - add more comments in commit log, suggested by Dmitry Baryshkov.
> ---
>
> Baihan Li (4):
>    drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD
>      irq
>    drm/hisilicon/hibmc: add dp mode valid check
>    drm/hisilicon/hibmc: fix no showing problem with loading hibmc
>      manually
>    drm/hisilicon/hibmc: Adding reset colorbar cfg in dp init.
>
>   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  2 ++
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 19 ++++++++++--
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  2 ++
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 31 ++++++++++++++++++-
>   4 files changed, 51 insertions(+), 3 deletions(-)
>

