Return-Path: <linux-kernel+bounces-585152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE712A79039
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 15:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A5C1892695
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D8223C8D6;
	Wed,  2 Apr 2025 13:46:10 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544D23A9BF;
	Wed,  2 Apr 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601569; cv=none; b=adXaUsiDDV7ajQur2eeY/OC4HZq6f4xaJGoxbFjmxOXTendwJeL0+XPVggTmna+bMiF6kbPe54CTbPuok8b6IiNCObzpPkDGzOOuN46tYUdNoOZfJz49W+M4mJtflH2XKssQIN0serisCviBSryeNl4OKxP3Cv9j2Wvm34tmk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601569; c=relaxed/simple;
	bh=ayi+2RtNbz1gR7WcrLFw26ZRxnOL8sFaE3V8IoKYwbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ny3IycAhhQKUUbzlWq67lM73KDLM0zcFfrKS+OQzr2pykam/b1Qt6oMHnGth8lKhuiOypHUYP99fEgqPxMQtThLeoYZUq4TCYB6jbDgAic3X9b3LwMcthBP7rNd1eGrf0RY0akOzP8jyOO32EZG8s80Y3b3G0cdq8CTYJ+pNEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZSQz21bxDzWfd2;
	Wed,  2 Apr 2025 21:42:22 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 566691800E4;
	Wed,  2 Apr 2025 21:46:04 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 21:46:03 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 6/7] net: hibmcge: fix not restore rx pause mac addr after reset issue
Date: Wed, 2 Apr 2025 21:39:04 +0800
Message-ID: <20250402133905.895421-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250402133905.895421-1-shaojijie@huawei.com>
References: <20250402133905.895421-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)

In normal cases, the driver must ensure that the value
of rx pause mac addr is the same as the MAC address of
the network port. This ensures that the driver can
receive pause frames whose destination address is
the MAC address of the network port.

Currently, the rx pause addr does not restored after reset.

The index of the MAC address of the host is always 0.
Therefore, this patch sets rx pause addr to
the MAC address with index 0.

Fixes: 3f5a61f6d504 ("net: hibmcge: Add reset supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index 4e8cb66f601c..a0bcfb5a713d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -26,12 +26,15 @@ static void hbg_restore_mac_table(struct hbg_priv *priv)
 
 static void hbg_restore_user_def_settings(struct hbg_priv *priv)
 {
+	/* The index of host mac is always 0. */
+	u64 rx_pause_addr = ether_addr_to_u64(priv->filter.mac_table[0].addr);
 	struct ethtool_pauseparam *pause_param = &priv->user_def.pause_param;
 
 	hbg_restore_mac_table(priv);
 	hbg_hw_set_mtu(priv, priv->netdev->mtu);
 	hbg_hw_set_pause_enable(priv, pause_param->tx_pause,
 				pause_param->rx_pause);
+	hbg_hw_set_rx_pause_mac_addr(priv, rx_pause_addr);
 }
 
 int hbg_rebuild(struct hbg_priv *priv)
-- 
2.33.0


