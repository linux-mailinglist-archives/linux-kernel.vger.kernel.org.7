Return-Path: <linux-kernel+bounces-740872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6652B0DA74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BABB1C24088
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7587D2EA49D;
	Tue, 22 Jul 2025 13:01:45 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620582E975D;
	Tue, 22 Jul 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189305; cv=none; b=s2XirOF7ALWkQ4cjeh6ETGrNjtF8x03gR7XNR8x8zFLNuLU/b32AaKAOuwF1L+RdnmRayJh+aJs9ZplLn48LSlVFT+oS5hl8rE/kmq9Tpi4Z+5sFFxT/uJq//Vw5d8tQ8ExUSZKcoylwg6Vack1rJUdQ3X/nblLaCKg6Q6wMv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189305; c=relaxed/simple;
	bh=5oIIhlbl+2DGNSyqMdjoxh9Ako399cWFxdG0eUVCIPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uek1VnHjecWfd3TTW9/Ycfu9uJucl8O0G0BL0W9ypdtkujuYhN/VNKTzH56zfZC0c22cxH2w2+yUlUpQpgVJfZEufraWMtZRAvb86Ixtrb1MxXx8We+vny9WpIAGi+Ox7jTftqkYdGlhMtHF1F0oFVxXM3jlwYo0dQq5mm8Z+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bmcqy2kJtz16THr;
	Tue, 22 Jul 2025 21:02:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 173131402CC;
	Tue, 22 Jul 2025 21:01:37 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 21:01:36 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 2/4] net: hns3: disable interrupt when ptp init failed
Date: Tue, 22 Jul 2025 20:54:21 +0800
Message-ID: <20250722125423.1270673-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250722125423.1270673-1-shaojijie@huawei.com>
References: <20250722125423.1270673-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Yonglong Liu <liuyonglong@huawei.com>

When ptp init failed, we'd better disable the interrupt and clear the
flag, to avoid early report interrupt at next probe.

Fixes: 0bf5eb788512 ("net: hns3: add support for PTP")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index ec581d4b696f..4bd52eab3914 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -497,14 +497,14 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to init freq, ret = %d\n", ret);
-		goto out;
+		goto out_clear_int;
 	}
 
 	ret = hclge_ptp_set_ts_mode(hdev, &hdev->ptp->ts_cfg);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to init ts mode, ret = %d\n", ret);
-		goto out;
+		goto out_clear_int;
 	}
 
 	ktime_get_real_ts64(&ts);
@@ -512,7 +512,7 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to init ts time, ret = %d\n", ret);
-		goto out;
+		goto out_clear_int;
 	}
 
 	set_bit(HCLGE_STATE_PTP_EN, &hdev->state);
@@ -520,6 +520,9 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 
 	return 0;
 
+out_clear_int:
+	clear_bit(HCLGE_PTP_FLAG_EN, &hdev->ptp->flags);
+	hclge_ptp_int_en(hdev, false);
 out:
 	hclge_ptp_destroy_clock(hdev);
 
-- 
2.33.0


