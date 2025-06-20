Return-Path: <linux-kernel+bounces-695284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A171FAE17E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 11:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3187AE682
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445FA2882A9;
	Fri, 20 Jun 2025 09:40:38 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A5283FEF
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412436; cv=none; b=P3tWy+yOBHBIDP0SQrOoRLTvh5scorUfa723iUPewCFWKUsEGfFOdIoBBT3DyQJ53FG2MqL6oc91SkiCLYlABnIwTTAAnVnazm2G7iY6rYJSboTPCmpr6C70jrih8JsMuWP/37ybYvuv68IV5STOFluuaql177GSNv7PG8dGIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412436; c=relaxed/simple;
	bh=ghqP4BKuSLffyOj08ZqVjGFdk4r9kdA4DyiGyptY0aI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TSZJx7JQS/vOPyy7337BKDrqgD7Z/cXtX//ZzIfxyfUbj5csgFLfDcnX2CwDGAy5EGH49vuHAnbcb74APHAtyTqwYZr1sAY8dA24WwrYZCfb5LVQeiaX2XhYiZfuZIUhp6NfOWvbBEJ1bDv2Ib4g1oa9CwU+oeAq/lfen71n5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bNsql0FXdz27g2D;
	Fri, 20 Jun 2025 17:38:59 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 93FD3180043;
	Fri, 20 Jun 2025 17:40:30 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Jun 2025 17:40:30 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Jun 2025 17:40:29 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<jani.nikula@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 drm-dp 00/10] Fix hibmc driver bugs
Date: Fri, 20 Jun 2025 17:30:54 +0800
Message-ID: <20250620093104.2016196-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

There are some bugfix for hibmc-drm driver.
---
ChangeLog:
v1 -> v2:
  - use the hibmc_ddc_del() in hibmc_connector_destroy(), suggested by Dmitry Baryshkov.
  - fix the tag, suggested by Dmitry Baryshkov.
  - don't use the flag, and use more checks in detect_ctx(), suggested by Dmitry Baryshkov.
  - delete if (dev->registered), suggested by Dmitry Baryshkov.
  - add explanations in commit, suggested by Dmitry Baryshkov.
  - delete if (!dp->is_connected) in hibmc_dp_mode_valid(), suggested by Dmitry Baryshkov.
  - don't tie VGA and DP status, suggested by Dmitry Baryshkov.
  - use crtc clone to let 2 connectors can display simultaneous
  - separate the patch, suggested by Dmitry Baryshkov.
---

Baihan Li (10):
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
  drm/hisilicon/hibmc: adapting modification for the former commit

 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 48 +++++++++----
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  8 +++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 33 ++++++---
 .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    | 12 ----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 70 +++++++++++++++++--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 22 +++---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   |  5 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 12 ++--
 10 files changed, 163 insertions(+), 52 deletions(-)

-- 
2.33.0


