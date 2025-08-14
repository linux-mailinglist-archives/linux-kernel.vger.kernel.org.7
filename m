Return-Path: <linux-kernel+bounces-768689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2332CB2643A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168FE1C23BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426532F999E;
	Thu, 14 Aug 2025 11:25:18 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF192EAB6A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170717; cv=none; b=Ow5736BWbyf2EovIuBgg36RpBm1ftNdYAwgTGN8w+PNq8yGAZyueU2tgdtMSLzcn7DMFS6rsIg5Felpw9hkS5l+n60D+dKatT/86c9wAOLceMKJqu48byLhElECALyN6jmW6eI+StECpx9JoG3kqbrE0CTh0s2UGiuceIDRxhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170717; c=relaxed/simple;
	bh=t78vSFuZXseEJ8um9x1LZbLR/KNoX6EoIVymTqIzf2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcqtJFZrl2+D2n+dLI8FvJQ+zfZ2GYzb+0qVYZpTPCjSyfDNsTrxEZyO2RldOqgFypfAkUkiwTjCt0VWrL170Bo16NyW7s3wGVxCxerOPgVzFG34A7nQ/ylgBaM9VsMotetRFyDj9qlEr9YFGPpfMLT490y9+O7gzvbJ2XuHshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c2jc93c8mz2dMJh;
	Thu, 14 Aug 2025 19:26:17 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 412681A016C;
	Thu, 14 Aug 2025 19:25:13 +0800 (CST)
Received: from kwepemq200012.china.huawei.com (7.202.194.183) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 19:25:13 +0800
Received: from huawei.com (10.175.112.208) by kwepemq200012.china.huawei.com
 (7.202.194.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 19:25:12 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<tglx@linutronix.de>, <saravanak@google.com>, <robh@kernel.org>,
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <chenjun102@huawei.com>, <wangwensheng4@huawei.com>
Subject: [PATCH 3/3] irqchip/mbigen: Use fw_devlink_relax_consumers() helper
Date: Thu, 14 Aug 2025 19:10:23 +0800
Message-ID: <20250814111023.2693-4-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250814111023.2693-1-wangwensheng4@huawei.com>
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200012.china.huawei.com (7.202.194.183)

Use this to prevernt the consumer devices of mbigen to be probed too
later.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 6f69f4e5dbac..4e96eb9b6a6a 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -252,6 +252,8 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 
 		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip))
 			return -ENOMEM;
+
+		fw_devlink_relax_consumers(&child->dev);
 	}
 
 	return 0;
-- 
2.22.0


