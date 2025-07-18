Return-Path: <linux-kernel+bounces-736350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3AB09BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC5117697C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7DE215F72;
	Fri, 18 Jul 2025 07:01:29 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8BD517
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822088; cv=none; b=rg9lhec983w1vJqPn3a/Rz4/vXCsfdi2u7iWgRdMB686nv7eHxLvvvfKuqBN/djpQ658HsWSiHwZDHmBnpH4meqAKfk4gNYtbQ6JJAizgEBqvWTX8gU/etrvv7K1ABwKc4ptipKAk//TdS/9WtEqi5du3WQqev2YPuGzLTtdriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822088; c=relaxed/simple;
	bh=EmA/pTSUnGAjKw3FytFmhhLYNoB0KTwXWqtLMz4rB6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pMKG/lGg/faohx+VEmPRSC+YBX+uAMVjkYRbq8Ml5FYyHlyFtBd1SqNmWaSYzCuPZMhsL90e2haXlQVvNRSTLvrslwnP3bt3zxQPdIUHTqZCVsCDeNrJzDx5WJnt0lEGUUGCAshOiwjror7e0CRijyfoG8z2Mfom+RRL88ql1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bk0yW6FPRz2RVFY;
	Fri, 18 Jul 2025 14:59:15 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A4021400FD;
	Fri, 18 Jul 2025 15:01:22 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 15:01:22 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 15:01:21 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<jani.nikula@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 drm-dp 00/11] Fix hibmc driver bugs
Date: Fri, 18 Jul 2025 14:51:14 +0800
Message-ID: <20250718065125.2892404-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

There are some bugfix for hibmc-drm driver.
---
ChangeLog:
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
  drm/hisilicon/hibmc: adapting modification for the former commit
  drm/hisilicon/hibmc: modification for the former commit

 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 51 ++++++++++----
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  8 +++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 33 +++++++---
 .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    | 12 ----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 64 ++++++++++++++++--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 22 ++++---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  5 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   |  5 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 66 +++++++++++++------
 10 files changed, 201 insertions(+), 69 deletions(-)

-- 
2.33.0


