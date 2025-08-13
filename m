Return-Path: <linux-kernel+bounces-766410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD5B24656
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0E31BC3327
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D165B2F49F8;
	Wed, 13 Aug 2025 09:53:10 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1692F0C73
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078790; cv=none; b=GqsyuImN2RukZUh5rifEjccNuP4Xat8VQ+t20EgwCgY+8jEtPZ+OpDTLmX0nCft3oYBUUpevbrJRYU7O4Rp3p++XJkXv0L9LVkBCE4FdVGvi4hmlQmodPQabpsbYmbNeibF/xF/PdbzM3/UMxWvcOO1z8ikFnmSgVRTtZEk5aRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078790; c=relaxed/simple;
	bh=9hd3AafoOxNYV9VRpSAqk9Dsb2z8P9mnnt830gzDeGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EjRN3R4KusOx5JoyW+OEpbo/fQ8U3Q9oBR+85vPEsIw0UlDzuXEesNebSrtsMfuLEwnrljxVEIe1HoXJpYCUZotQXCraPh7xk24rHLRhPO9r9XLBUbMqQWK9TBjCLSBcnP89asGpm4vDamVDhrNDN358hcI6XuItNCqC3nU9jGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c23cH6cyFz3TqYK;
	Wed, 13 Aug 2025 17:54:07 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id DB30A1401F0;
	Wed, 13 Aug 2025 17:53:03 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:03 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:02 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 drm-dp 00/11] Fix hibmc driver bugs
Date: Wed, 13 Aug 2025 17:42:27 +0800
Message-ID: <20250813094238.3722345-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

There are some bugfix for hibmc-drm driver.
---
ChangeLog:
v3 -> v4:
  - remove link training process in hibmc_dp_detect(), suggested by Dmitry Baryshkov.
  - remove if (dev->registered), suggested by Dmitry Baryshkov.
  - remove non-related changes, suggested by Dmitry Baryshkov.
  - Remove the clock check, suggested by Dmitry Baryshkov.
  - ( I'll add them in next series after redesigning this part)
  - add KVM edid in commit message, suggested by Dmitry Baryshkov.
  - fix magic values, suggested by Dmitry Baryshkov.
  - fix the commit subjects, suggested by Dmitry Baryshkov.
v2 -> v3:
  - fix hibmc_connector_get_modes() and hibmc_vdac_detect() to realize BMC KVM, suggested by Dmitry Baryshkov.
  - fix the issue commit ID, suggested by Dmitry Baryshkov.
  - split into 2 commits, suggested by Dmitry Baryshkov.
  - add more comments in commit log, suggested by Dmitry Baryshkov.
---

Baihan Li (11):
  drm/hisilicon/hibmc: fix the i2c device resource leak when vdac init
    failed
  drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD
    irq
  drm/hisilicon/hibmc: fix irq_request()'s irq name variable is local
  drm/hisilicon/hibmc: fix the hibmc loaded failed bug
  drm/hisilicon/hibmc: fix rare monitors cannot display problem
  drm/hisilicon/hibmc: add dp mode valid check
  drm/hisilicon/hibmc: fix dp and vga cannot show together
  drm/hisilicon/hibmc: fix no showing when no connectors connected
  drm/hisilicon/hibmc: fix no showing problem with loading hibmc
    manually
  drm/hisilicon/hibmc: Adding reset colorbar cfg in dp init.
  drm/hisilicon/hibmc: moving HDCP cfg after the dp reset operation.

 .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  2 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 18 ++++-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  3 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 14 +++-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 48 ++++++++++--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 24 +++---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  8 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   |  5 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 73 +++++++++++++------
 9 files changed, 154 insertions(+), 41 deletions(-)

-- 
2.33.0


