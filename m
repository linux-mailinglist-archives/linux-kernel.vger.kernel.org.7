Return-Path: <linux-kernel+bounces-853595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21297BDC0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD41D4F8540
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5062FE055;
	Wed, 15 Oct 2025 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="geTbAUeC"
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BE308F24
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493094; cv=none; b=jpArSCgjV98282XCiZeRTw4WK0C65uqeNaJpJizz4FxTzW6TP5I5WN7Nuqzh11XoBng6fmcD0BiCi/pjjBeuAu+tZuu+bORWmSFiqvodewQLHzNMtAiUWTjVS2jPQu/P0GcbXdoQ07LS2+40lDzydTiIkjuPlYii4O0DOwEVqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493094; c=relaxed/simple;
	bh=R2+LBJcGpaX9ucssfsf2PUhwPoWfyabmrZfSyq8bHp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j9KtV0QjDpr0HpjvmSVbmN7hlZEaVQyuIYVHErwe1FZFn63NaolrmExceLqoI1TC6sMxFwKrMC/qNBQwse7bM7N9bEQf+4wIvd1nb9KA6V6o0074LrCynfftIbo9aiGLY1/nPXz7V+FGqHjEUyJbnS7LIT9m5otH8BZ+qf8EyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=geTbAUeC; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Jl+5RZeFBk+pr/p9vanuwuluPhZLhmoKhOeQh4zuqNw=;
	b=geTbAUeCf4qQnUgryWw+oZ+ZdntZcjyDNulWMVby+lpd50ne72UeEtoZ2yN48ZKn68Q14wLT8
	2E2BQ6FNaX1LDeGiD670+iZDTuFo0gE9Okg0yrh6GMTeven7dmCzTdoHzC42UWDlPsa/AAW+p3K
	4fYqi/lzy+CHY/KgJ8/+suM=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cmYvL70vvz1T4GB;
	Wed, 15 Oct 2025 09:50:38 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 1289A1800EB;
	Wed, 15 Oct 2025 09:51:23 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 09:51:22 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 09:51:22 +0800
Message-ID: <4de90207-65d6-4526-9489-ecc9760077dc@huawei.com>
Date: Wed, 15 Oct 2025 09:51:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 drm-dp 0/4] Fix hibmc driver bugs
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <libaihan@huawei.com>, <shenjian15@huawei.com>,
	<shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <shiyongbang@huawei.com>
References: <20250926011500.2545817-1-shiyongbang@huawei.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20250926011500.2545817-1-shiyongbang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq100007.china.huawei.com (7.202.195.175)

Gently ping, any further comments on these patches?
Are these good to be applied?

Thanks，
Baihan.


> From: Baihan Li <libaihan@huawei.com>
>
> There are some bugfix for hibmc-drm driver.
> ---
> ChangeLog:
> v7 -> v8:
>    - fix build errors reported by kernel test robot <lkp@intel.com>
>      Closes: https://lore.kernel.org/oe-kbuild-all/202509241625.o4mNleVb-lkp@intel.com/
> v6 -> v7:
>    - add the check about branch devices, suggested by Dmitry Baryshkov.
> v5 -> v6:
>    - use HPD status in DP detect_ctx(), suggested by Dmitry Baryshkov.
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
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 ++
>   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  2 +
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 31 ++++++++-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  8 +++
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  3 +
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 67 ++++++++++++++++++-
>   6 files changed, 111 insertions(+), 4 deletions(-)
>

