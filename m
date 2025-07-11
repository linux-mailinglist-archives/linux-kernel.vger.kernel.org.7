Return-Path: <linux-kernel+bounces-726997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA0B013C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932F7B41112
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7D1F03C5;
	Fri, 11 Jul 2025 06:37:13 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A301EFFB4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215832; cv=none; b=DUciUMsPEA15wvHV4+6QEeSnvP+IQMRSVVfgMGcAwkBBwOU0+bQshQyRHvAOLN4V9DxX/b3J+ajibaOhmfKFMyRpuN7cAi8w5s1UUf57sY7zzL4viD2kss/742Qy5iXrAltLxmR/e4QgCZ4hDGGZYC0cfwfUWOKi5hyz18Wq4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215832; c=relaxed/simple;
	bh=CCL6U9EQyj9rDsBGNQKAxeOLyUVQ+WOzkSXDeUujvAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UuGAA4zFDjAbcSYhjhp5TD81y40kifFtBp84KL8ukiStRU3pKUh+Dsz6aOPud552W5YSuxLEaPCv9jrk5yiqhhJVgCoJKMui8zEzUt41EmUbTJb9pxr/U79L+L7mA6EFUygQI/XFXMnjG5bnXik8kU2r61/ffknGnMaW+/shzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bdhlw6PS6z2Bcp0;
	Fri, 11 Jul 2025 14:35:08 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D308140119;
	Fri, 11 Jul 2025 14:37:07 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 14:37:07 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 14:37:06 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH] soc: hisilicon: kunpeng_hccs: Fix incorrect log information
Date: Fri, 11 Jul 2025 14:37:06 +0800
Message-ID: <20250711063706.3121253-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The hccs_get_all_spec_port_idle_sta() will tell user which port
is busy when firmware doesn't allow to decrease HCCS lane number.
However, the current log prints the index of die and port instead
of the hardware ID user perceived.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 7fc353732d55..65ff45fdcac7 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1295,11 +1295,11 @@ static int hccs_get_all_spec_port_idle_sta(struct hccs_dev *hdev, u8 port_type,
 				if (ret) {
 					dev_err(hdev->dev,
 						"hccs%u on chip%u/die%u get idle status failed, ret = %d.\n",
-						k, i, j, ret);
+						port->port_id, chip->chip_id, die->die_id, ret);
 					return ret;
 				} else if (idle == 0) {
 					dev_info(hdev->dev, "hccs%u on chip%u/die%u is busy.\n",
-						k, i, j);
+						 port->port_id, chip->chip_id, die->die_id);
 					return 0;
 				}
 			}
-- 
2.33.0


