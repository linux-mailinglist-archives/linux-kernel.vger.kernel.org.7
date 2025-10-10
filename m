Return-Path: <linux-kernel+bounces-847652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC8EBCB5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C871C345D18
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77F31E5B88;
	Fri, 10 Oct 2025 01:26:10 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509934BA58
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059570; cv=none; b=h8PzCYujOaCd6j7BRo6GcnwwmskFpByTWoSObwci58PHoFaYDzq+gV4kbCVz7L8AcjsWZSysVnW8ubY7hKpDOC+XXsjNiIZQjqkIKqxBWF0k7DmG/9j9QWqADsNb5sUdwtBbdo+4Bmzsb4cQ96Izi87BVcrzGcrCEdgqcq/sA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059570; c=relaxed/simple;
	bh=fHGmNbICEwTy22p73vvXAOjdUsQGSlFtMggtmJJF5OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5ZJm5upddGvlFJiXoeqJ8+p/CtqR0Lc05uZlrr5onrEBr5wyY5wahJoRAgObG8MIFQkI66Dx7jsiU0QbSPhKy+3rB//wwLjJcYiqUTwTBoDyhThnyCBVXcMQDqsXc+m4D/svp30MiFAJbDuCoXLmMPsciuqjGwdmfvmLoMgAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAXfRbWXuhoiyxYDQ--.24290S2;
	Fri, 10 Oct 2025 09:18:16 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] mfd: da9055: Fix missing regmap_del_irq_chip() in error path
Date: Fri, 10 Oct 2025 09:17:36 +0800
Message-ID: <20251010011737.1078-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXfRbWXuhoiyxYDQ--.24290S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWDXr4UJw15Xr45Gr48WFg_yoWfurc_Wr
	48ur1xuFWktrWSkr1IkF1rZryxtFn2g395ZFs7tFZ3G3WxtFnxXFWq9FZ7Wr1UGwn09r9r
	Gw4UXrW2y3yakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8KA2jnztuSQAABsG

When da9055_device_init() fails after regmap_add_irq_chip()
succeeds but mfd_add_devices() fails, the error handling path
only calls mfd_remove_devices() but forgets to call
regmap_del_irq_chip(). This results in a resource leak.

Fix this by adding regmap_del_irq_chip() to the error path so
that resources are released properly.

Fixes: 2896434cf272 ("mfd: DA9055 core driver")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/mfd/da9055-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index 1f727ef60d63..8c989b74f924 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -388,6 +388,7 @@ int da9055_device_init(struct da9055 *da9055)
 
 err:
 	mfd_remove_devices(da9055->dev);
+	regmap_del_irq_chip(da9055->chip_irq, da9055->irq_data);
 	return ret;
 }
 
-- 
2.50.1.windows.1


