Return-Path: <linux-kernel+bounces-885940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D6AC34566
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 510464E5C74
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9E28D830;
	Wed,  5 Nov 2025 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VzMNRaSZ"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D76223DC1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328896; cv=none; b=S9kQalLPa7ebqm3rU71d97kKzn8MmtvSI9PGOIybznBY62eeFzARqiAO1LuI9ohSX+IwyLI5jqByFR5N1MPPbkbVefVnx1d9rwTwst4LGx0t84nZKxMjJH7yf450Y1engilIWKyZpgwQM25TLU9nFFHTIok9Moxsxqu379F9GLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328896; c=relaxed/simple;
	bh=yZ+LZGEzWDj1hbaIelgMVwQsX9OTqCs36J9oxxaOHe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NIAsJRAUgZ691PVGWbzDR23wmIARtk7DPZQ7ajH1+kVLvE7ni1EHU2X3FA0+jaX9N/ecwh8w7lA2YKe/RuIediC3BBgcq1+bF5bqF36b/SHNgqcJb8zECsOkEZ3w8+vHX+NMQWBTA0UdUVqHxhX/k8oF9xGTE+O3xVg5WNzTIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VzMNRaSZ; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FSvxpard0HoYpObyaKRQSED2eQFZNpC67juTQyAXQP4=;
	b=VzMNRaSZAK1+UZeC/FOn/pnT0pHf9SMW9Wr920WcLgu4W2dBHnDVyJEURP30T0VAyN1hsipP+
	0ZhLfYAf49ypWYKSpIeCxSHfMxTmzNsZ4kXFMBtetmbhy3ryNbqahoCG6L5F8hIkFngwx4MTLqi
	rQpHyDDj4GR2CAvGL6BCJe8=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d1cpD3pwKz12LDq;
	Wed,  5 Nov 2025 15:46:28 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 195401400CD;
	Wed,  5 Nov 2025 15:48:04 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 15:48:03 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 15:48:03 +0800
Message-ID: <43a4d870-bb0e-4fdb-acac-6b564b4ea542@huawei.com>
Date: Wed, 5 Nov 2025 15:48:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 drm-dp 0/4] Fix hibmc driver bugs
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <libaihan@huawei.com>, <shenjian15@huawei.com>,
	<shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <shiyongbang@huawei.com>
References: <20251017095907.2060834-1-shiyongbang@huawei.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20251017095907.2060834-1-shiyongbang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100007.china.huawei.com (7.202.195.175)

Gently ping.

Thanks,
Baihan.


> From: Baihan Li <libaihan@huawei.com>
>
> There are some bugfix for hibmc-drm driver.
> ---
> ChangeLog:
> v8 -> v9:
>    - refactor the hibmc_dp_check_hpd_status(), and add some checks
>      in dp_encoder_enable.
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
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 +
>   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  2 +
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 40 +++++++++-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  8 ++
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  3 +
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 77 ++++++++++++++++++-
>   6 files changed, 128 insertions(+), 6 deletions(-)
>

