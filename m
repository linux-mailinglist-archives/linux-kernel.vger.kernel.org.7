Return-Path: <linux-kernel+bounces-597201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA535A8365B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 04:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623CF3B56D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 02:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9B1D5CF2;
	Thu, 10 Apr 2025 02:20:03 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9815624D;
	Thu, 10 Apr 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251602; cv=none; b=Cfd+qLYQNGE80yrcLAH0L9tM1JM041gY1qRxo9DCOTFTrNWksinPqF6b0HlHDjNLn9v60029O+FoIsAaSoCHJJzMv3Bf4FE7tmuBccr0qNTx98auPZrfvdRi/aLnSPSt8Dl8KI5abr6EJ6bpoyuLs012wkmyRGR4MGy1XqeNd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251602; c=relaxed/simple;
	bh=1klD8Y7z2hJ9GGeD0Xcot7B/BqnqJoDYxKvvJ1xL8e0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/+FahWNyXn4mUiSBjgBi38F2Bimjr7/4uB0EFNzu7MovXfzeOvMdPu2zZSyo5OdfvW2q1rvHvxwZWnEoEpCXlwZJwoA+17ogqMfXACrx0qo3vCcKEL4fYiSqvWhAlCkNOqPCG/gAEekl2BUn+XU6bCrrYHC0xz50vNrr73Q0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZY3Sk140Mz27hVH;
	Thu, 10 Apr 2025 10:20:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A087140230;
	Thu, 10 Apr 2025 10:19:57 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 10:19:56 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v3 0/7] There are some bugfix for hibmcge driver
Date: Thu, 10 Apr 2025 10:13:20 +0800
Message-ID: <20250410021327.590362-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There are some bugfix for hibmcge driver

---
ChangeLog:
v2 -> v3:
  - Add more details in commit log for patch6, suggested by Jakub.
  v2: https://lore.kernel.org/all/20250403135311.545633-7-shaojijie@huawei.com/
v1 -> v2:
  - Add more details in commit log for patch1, suggested by Simon Horman.
  v1: https://lore.kernel.org/all/20250402133905.895421-1-shaojijie@huawei.com/
---

Jijie Shao (7):
  net: hibmcge: fix incorrect pause frame statistics issue
  net: hibmcge: fix incorrect multicast filtering issue
  net: hibmcge: fix the share of irq statistics among different network
    ports issue
  net: hibmcge: fix wrong mtu log issue
  net: hibmcge: fix the incorrect np_link fail state issue.
  net: hibmcge: fix not restore rx pause mac addr after reset issue
  net: hibmcge: fix multiple phy_stop() issue

 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  8 ++++---
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 11 +++++----
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.c |  2 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  |  3 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  7 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 24 ++++++++++++-------
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  8 +++----
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 11 ++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  3 +++
 9 files changed, 55 insertions(+), 22 deletions(-)

-- 
2.33.0


