Return-Path: <linux-kernel+bounces-581485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C441A7607C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 09:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914F81887CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A089B1D5175;
	Mon, 31 Mar 2025 07:50:21 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08381C5D5E
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743407421; cv=none; b=VZZluRwS/qgmfKto6yD+w+/pyUpYB/DLNUU9v2Ae7YA14P+bONDxSF3zJVZKPySrSNU42c+uy0Kbabt7gFW5UM0UP+JSlWtufxBiEtHPe+rgSHL0eLQbZJl5/lpjd8Rtgyxpw5u1r1x9vxJhi49F+rO3UEIPNz4TVaZ1BFef78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743407421; c=relaxed/simple;
	bh=1FqDj0OhqdsjtPV/YAP2TsPWiUL25+noUerfuOl3njE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oLVhGXW/6yJROr7rN9snyZUwXKyzbdedsLNK2ZRZE9b5J1lI97skZGk156o3f+5vsNp5P3i3XI3JYmLUpUNDUmUbpXuQgXcurRjgqH2ju39j8/x3YRu29YcY12l65rIYEkcXpheJR8gJDExgupbggD9cGJGsGJmGYjFNaJT7etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZR39J4tP0zWfll;
	Mon, 31 Mar 2025 15:46:28 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C64801401F0;
	Mon, 31 Mar 2025 15:50:09 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 31 Mar 2025 15:50:08 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<jani.nikula@linux.intel.com>, <dmitry.baryshkov@oss.qualcomm.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 drm-dp 0/9] Add HPD, getting EDID, colorbar features in DP function
Date: Mon, 31 Mar 2025 15:42:03 +0800
Message-ID: <20250331074212.3370287-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500013.china.huawei.com (7.221.188.12)

From: Baihan Li <libaihan@huawei.com>

To support DP HPD, edid printing, and colorbar display features based on
the Hisislcon DP devices.
---
ChangeLog:
v8 -> v9:
  - modify the adaptation of hibmc_dp_link_reduce_rate().
  - fix the leak problem in hibmc_dp_aux_init(), suggested by Jani Nikula.
  v8: https://lore.kernel.org/all/20250320101455.2538835-1-shiyongbang@huawei.com/
v7 -> v8:
  - use drm_edid_read() in hibmc_dp_connector_get_modes(), suggested by Jani Nikula
  v7: https://lore.kernel.org/all/20250319032435.1119469-1-shiyongbang@huawei.com/
v6 -> v7:
  - add if statement about drm aux in hibmc_dp_connector_get_modes(), suggested by Jani Nikula
  v6: https://lore.kernel.org/all/20250310040138.2025715-1-shiyongbang@huawei.com/
v5 -> v6:
  - fix the DP_SERDES_VOL2_PRE0 value after electrical test.
  - move the detect_ctx() to the patch 7/9.
  - add detect_ctx with 200ms delay, suggested by Dmitry Baryshkov.
  v5: https://lore.kernel.org/all/20250307101640.4003229-1-shiyongbang@huawei.com/
v4 -> v5:
  - add commit log about hibmc_kms_init(), suggested by Dmitry Baryshkov.
  - fix the format of block comments, suggested by Dmitry Baryshkov.
  - add hibmc_dp_get_serdes_rate_cfg() to correct transferring serdes cfg.
  - separate the vga part commit, suggested by Dmitry Baryshkov.
  - remove pci_disable_msi() in hibmc_unload()
  v4: https://lore.kernel.org/all/20250305112647.2344438-1-shiyongbang@huawei.com/
v3 -> v4:
  - fix the serdes cfg in hibmc_dp_serdes_set_tx_cfg(), suggested by Dmitry Baryshkov.
  - move the dp serdes registers to dp_reg.h, suggested by Dmitry Baryshkov.
  - add comments for if-statement of dp_init(), suggested by Dmitry Baryshkov.
  - fix the comment log to imperative sentence, suggested by Dmitry Baryshkov.
  - add comments in hibmc_control_write(), suggested by Dmitry Baryshkov.
  - add link reset of rates and lanes in pre link training process, suggested by Dmitry Baryshkov.
  - add vdac detect and connected/disconnected status to enable HPD process, suggested by Dmitry Baryshkov.
  - remove a drm_client, suggested by Dmitry Baryshkov.
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202502231304.BCzV4Y8D-lkp@intel.com/
  v3: https://lore.kernel.org/all/20250222025102.1519798-1-shiyongbang@huawei.com/
v2 -> v3:
  - restructuring the header p_reg.h, suggested by Dmitry Baryshkov.
  - add commit log about dp serdes, suggested by Dmitry Baryshkov.
  - return value in hibmc_dp_serdes_init(), suggested by Dmitry Baryshkov.
  - add static const in the array of serdes_tx_cfg[], suggested by Dmitry Baryshkov.
  - change drm_warn to drm_dbg_dp, suggested by Dmitry Baryshkov.
  - add explanations about dp serdes macros, suggested by Dmitry Baryshkov.
  - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
  - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
  - split the patch into two parts, suggested by Dmitry Baryshkov.
  - Capitalized EDID and AUX, suggested by Dmitry Baryshkov.
  - rewrite the commit log, suggested by Dmitry Baryshkov.
  - move colorbar debugfs entry to this patch, suggested by Dmitry Baryshkov.
  - change binary format to integer format, suggested by Dmitry Baryshkov.
  - remove mdelay(100) hpd function in ISR, suggested by Dmitry Baryshkov.
  - remove enble_display in ISR, suggested by Dmitry Baryshkov.
  - change drm_kms_helper_connector_hotplug_event() to
    drm_connector_helper_hpd_irq_event(), suggested by Dmitry Baryshkov.
  - move macros to dp_reg.h, suggested by Dmitry Baryshkov.
  - remove struct irqs, suggested by Dmitry Baryshkov.
  - split this patch into two parts, suggested by Dmitry Baryshkov.
  v2: https://lore.kernel.org/all/20250210144959.100551-1-shiyongbang@huawei.com/
v1 -> v2:
  - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
  - changing all names of dp phy to dp serdes.
  - deleting type conversion, suggested by Dmitry Baryshkov.
  - deleting hibmc_dp_connector_get_modes() and using drm_connector_helper_get_modes(), suggested by Dmitry Baryshkov.
  - add colorbar introduction in commit, suggested by Dmitry Baryshkov.
  - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
  - using debugfs_init() callback, suggested by Dmitry Baryshkov.
  - splittting colorbar and debugfs in different patches, suggested by Dmitry Baryshkov.
  - optimizing the description in commit message, suggested by Dmitry Baryshkov.
  - add mdelay(100) comments, suggested by Dmitry Baryshkov.
  - deleting display enable in hpd event, suggested by Dmitry Baryshkov.
  v1: https://lore.kernel.org/all/20250127032024.1542219-1-shiyongbang@huawei.com/
---
Baihan Li (9):
  drm/hisilicon/hibmc: Restructuring the header dp_reg.h
  drm/hisilicon/hibmc: Add dp serdes cfg to adjust serdes rate, voltage
    and pre-emphasis
  drm/hisilicon/hibmc: Add dp serdes cfg in dp process
  drm/hisilicon/hibmc: Refactor the member of drm_aux in struct hibmc_dp
  drm/hisilicon/hibmc: Getting connector info and EDID by using AUX
    channel
  drm/hisilicon/hibmc: Add colorbar-cfg feature and its debugfs file
  drm/hisilicon/hibmc: Enable this hot plug detect of irq feature
  drm/hisilicon/hibmc: Add MSI irq getting and requesting for HPD
  drm/hisilicon/hibmc: Add vga connector detect functions

 drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   |  16 ++-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  10 +-
 .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |   2 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  91 +++++++++++-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  36 +++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  |  90 +++++++++---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   | 130 +++++++++++++-----
 .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    |  71 ++++++++++
 .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 104 ++++++++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  74 +++++++++-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  87 +++++++++---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  12 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |   3 +
 14 files changed, 636 insertions(+), 93 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c

-- 
2.33.0


