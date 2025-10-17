Return-Path: <linux-kernel+bounces-857783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BBCBE7EED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 442164E2932
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D5330C62A;
	Fri, 17 Oct 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lha+wQUm"
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE492D595F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695483; cv=none; b=Qrc+IH0GIE4gM5UOf6H2DJogNiXrdAStohO4qcff4jfmZ8pnF/9psYchuPoVldClnHIHXNITBZl5iYo+yA7+q8uhZOfrB8iH3iUeEXvM6uHLBBiZfjj1z8LXixF8JaLtQA5pMkY/kK3V68drlrGU/+mi4Qqs4wgAV6QRm8IxkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695483; c=relaxed/simple;
	bh=l4I0iEjFH80fqwuuE4TYkvgAugXBH3M12TxXS8aC0g8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sEo7I2Y5CI08WhqVLoc5jT2UWHB2qEi70hjKg026ve3b3mGuxi2oFXvipdzKDPxj9CJzRkSJBwF5A7W/P7/0JA7skeKJ9ES5wz69ll2clW7DghkjhGbFw11Pfz3X7dhF4DPYXySJgTD4B9lGxuI8ctfE1SkjY+c/kthgebDVWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lha+wQUm; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TXcZtgHR5zt5EXn2eorWpBW0vMox209p/qv72YegbV8=;
	b=lha+wQUmnxVrQGUtmHA0DXOAXrbMQ5GQlIrVsc6uOHmZNfYVyk4L0bsZzrYtld9rWYyy5LaRm
	03PcZ2oIcpCXlgSWBcKNRhZkxW9yDLfxyc6g4CJmHYrX9UhTgYe7SgaBRQ1PUZoP2BtUWPwtlcv
	Z9GkNlwiVfgDTP1TTzyy94Q=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cp0lz5wcvzRhs2;
	Fri, 17 Oct 2025 18:04:15 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 906A01402DB;
	Fri, 17 Oct 2025 18:04:37 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 18:04:36 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 18:04:36 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 drm-dp 0/4] Fix hibmc driver bugs
Date: Fri, 17 Oct 2025 17:59:03 +0800
Message-ID: <20251017095907.2060834-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

There are some bugfix for hibmc-drm driver.
---
ChangeLog:
v8 -> v9:
  - refactor the hibmc_dp_check_hpd_status(), and add some checks
    in dp_encoder_enable.
v7 -> v8:
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202509241625.o4mNleVb-lkp@intel.com/
v6 -> v7:
  - add the check about branch devices, suggested by Dmitry Baryshkov.
v5 -> v6:
  - use HPD status in DP detect_ctx(), suggested by Dmitry Baryshkov.
v4 -> v5:
  - Because some of patches are applied, this series only contains the rest of them.
  - fix the commit and DP detect_ctx(), suggested by Dmitry Baryshkov.
  - fix bugfix commit ID, suggested by Dmitry Baryshkov.
  - remove the 08/11 patch, I'll add in next series.
  - combined 9 and 11 patch together, suggested by Dmitry Baryshkov.
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

Baihan Li (4):
  drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD
    irq
  drm/hisilicon/hibmc: add dp mode valid check
  drm/hisilicon/hibmc: fix no showing problem with loading hibmc
    manually
  drm/hisilicon/hibmc: Adding reset colorbar cfg in dp init.

 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 +
 .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  2 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 40 +++++++++-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  8 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  3 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 77 ++++++++++++++++++-
 6 files changed, 128 insertions(+), 6 deletions(-)

-- 
2.33.0


