Return-Path: <linux-kernel+bounces-797603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F1B41262
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E27207F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2F1DE3DC;
	Wed,  3 Sep 2025 02:33:48 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3E288D6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866828; cv=none; b=SmnxgL2Y6HJiDN9uE7laMyVd6fUGiHGkPweMxB79VKv/RwLlUlppSQcDvPwdwkoYRaj5plV21cIsUIpTzb3tCEs22BKmKFioz0MTn6VYL36g8YhpGvKNqD+NxCkTImHWVueZzHfKlTGHh0Jk8nl4ki29HpuoGxVoFw0d70sePP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866828; c=relaxed/simple;
	bh=3pMGDurL+rajU9YAnsbcqfmO3CshcnmybXh55FuO4XU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bPMvZqngnXJso8TqdlTZo852vEVRHVhFlhnplN4CkACGOxoH/4rAtCTzg5ySHkNBTnBqRTXYGOukamOvb4/STT2uwaTJMaWJy5JMIRUfDp1NhrMEdguB0Tcr/G01lsDkA67Xu0PAEocO7SJrCGEjKs4a6B76rXiAiN/QBe/WBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cGml03k74zPqLR;
	Wed,  3 Sep 2025 10:29:00 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 16DEA1401F2;
	Wed,  3 Sep 2025 10:33:37 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 10:33:36 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <maz@kernel.org>, <lpieralisi@kernel.org>, <tglx@linutronix.de>,
	<wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v5: Remove the redundant ITS cache invalidation
Date: Wed, 3 Sep 2025 10:33:19 +0800
Message-ID: <20250903023319.1820-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200017.china.huawei.com (7.202.194.83)

An ITS cache invalidation has been performed immediately after programming
the L2 DTE in gicv5_its_device_register(). No need to perform it again
right after a successful gicv5_its_device_register().

Remove it.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v5-its.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 2fb58d76f521..554485f0be1f 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -768,8 +768,6 @@ static struct gicv5_its_dev *gicv5_its_alloc_device(struct gicv5_its_chip_data *
 		goto out_dev_free;
 	}
 
-	gicv5_its_device_cache_inv(its, its_dev);
-
 	its_dev->its_node = its;
 
 	its_dev->event_map = (unsigned long *)bitmap_zalloc(its_dev->num_events, GFP_KERNEL);
-- 
2.33.0


