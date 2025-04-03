Return-Path: <linux-kernel+bounces-586838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49346A7A486
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 16:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943B93B87B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ACE250BF2;
	Thu,  3 Apr 2025 13:59:38 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521D2500CF;
	Thu,  3 Apr 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688777; cv=none; b=XYx16YyniOy+zns9RiYaRL8bQ2H3Vxjval8FeZOe4PONXZHeDNwy2FIULpDhTGWcFJncllDhO3gHA0/ntzeUjV+RHOjmD2bQ/yJxI1jD3F/7acZzwMAdE3rYvW/+IDVAl2SwJ6a+RlpwkupNEglAgoCF07oaB+tDpwYh2pg2G9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688777; c=relaxed/simple;
	bh=qYbrNhR2CusQb1SmRQb2ywkd4VIoINGw3PjXJTfZL/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=in2vyanFSAOm1KkzIIghst2rPuUBqG+Y90kjTETR0p2Un39+/XsWIEI19LIw/G/3vJo649SFlcDXR+hkCGkibPuUnN4WrKyc+BfzVAORQpSPphNvogdx1IFhefX+SZ7AgPxPwni2ZJt9HDHL1Fk+fl3gn6vsqEns0B9mWZmTYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZT3G90NV0z1R7XK;
	Thu,  3 Apr 2025 21:57:37 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EC6C21A0188;
	Thu,  3 Apr 2025 21:59:27 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 21:59:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v2 4/7] net: hibmcge: fix wrong mtu log issue
Date: Thu, 3 Apr 2025 21:53:08 +0800
Message-ID: <20250403135311.545633-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250403135311.545633-1-shaojijie@huawei.com>
References: <20250403135311.545633-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)

A dbg log is generated when the driver modifies the MTU,
which is expected to trace the change of the MTU.

However, the log is recorded after WRITE_ONCE().
At this time, netdev->mtu has been changed to the new value.
As a result, netdev->mtu is the same as new_mtu.

This patch modifies the log location and records logs before WRITE_ONCE().

Fixes: ff4edac6e9bd ("net: hibmcge: Implement some .ndo functions")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index e5c961ad4b9b..2e64dc1ab355 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -203,12 +203,12 @@ static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev))
 		return -EBUSY;
 
-	hbg_hw_set_mtu(priv, new_mtu);
-	WRITE_ONCE(netdev->mtu, new_mtu);
-
 	dev_dbg(&priv->pdev->dev,
 		"change mtu from %u to %u\n", netdev->mtu, new_mtu);
 
+	hbg_hw_set_mtu(priv, new_mtu);
+	WRITE_ONCE(netdev->mtu, new_mtu);
+
 	return 0;
 }
 
-- 
2.33.0


