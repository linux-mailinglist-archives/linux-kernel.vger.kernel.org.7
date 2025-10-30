Return-Path: <linux-kernel+bounces-877845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7EAC1F2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911133AABB1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917133F379;
	Thu, 30 Oct 2025 09:07:27 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DD2BDC25
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815246; cv=none; b=bx8gJYsvWMmCb5FSdDTiOrbdxljAUUO45FaRFsaPgYEW8RG1FqKaDmaqVamFuWli3p9u6kQDyHjLXgfAKNFKvud1cHKmqUpffITflEH4SSp7/GZDFoL7eIcjvatq9+9FtE4k/4KwqHlqx4m2521r+a2g40xsIxJfiT8QN8u4eSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815246; c=relaxed/simple;
	bh=N4QEasLa/otpHFPwGjaO/bKe6lUNSgfCEg3MSRlRPT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alm6QWsSBXzI2sfvq7IeMMaCaAlxo/n/bSsRsPftLg1Zm/f7AfByzwJJrrYlBD418YnvddijHet+KMJWALfOc1g60JyuEGAx2MgLgk3o2o35wky5MIji5dqidKta76VArV4t+BCfInzsTI6OEetG46EPhVKkkzymuQmBSmIVmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowABn0my_KgNpROYNAA--.676S2;
	Thu, 30 Oct 2025 17:07:13 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] clocksource: ralink: Fix resource leaks in init error path
Date: Thu, 30 Oct 2025 17:07:10 +0800
Message-ID: <20251030090710.1603-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABn0my_KgNpROYNAA--.676S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfJFyUGF47JryDWryDKFg_yoW8Ar1xpr
	4xZay3Cry5Wwn2vFWvyFyDZF9293WvkFWDGFWSk3savrnxJryUtFW5JFyjvF47CFs3CanF
	qr4fArW7uFWjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUVMKAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwLA2kDDd59UgAAsU

The ralink_systick_init() function does not release all acquired resources
on its error paths. If irq_of_parse_and_map() or a subsequent call fails,
the previously created I/O memory mapping and IRQ mapping are leaked.

Add goto-based error handling labels to ensure that all allocated
resources are correctly freed.

Fixes: 1f2acc5a8a0a ("MIPS: ralink: Add support for systick timer found on newer ralink SoC")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-ralink.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ralink.c b/drivers/clocksource/timer-ralink.c
index 6ecdb4228f76..68434d9ed910 100644
--- a/drivers/clocksource/timer-ralink.c
+++ b/drivers/clocksource/timer-ralink.c
@@ -130,14 +130,15 @@ static int __init ralink_systick_init(struct device_node *np)
 	systick.dev.irq = irq_of_parse_and_map(np, 0);
 	if (!systick.dev.irq) {
 		pr_err("%pOFn: request_irq failed", np);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_iounmap;
 	}
 
 	ret = clocksource_mmio_init(systick.membase + SYSTICK_COUNT, np->name,
 				    SYSTICK_FREQ, 301, 16,
 				    clocksource_mmio_readl_up);
 	if (ret)
-		return ret;
+		goto err_free_irq;
 
 	clockevents_register_device(&systick.dev);
 
@@ -145,6 +146,12 @@ static int __init ralink_systick_init(struct device_node *np)
 			np, systick.dev.mult, systick.dev.shift);
 
 	return 0;
+
+err_free_irq:
+	irq_dispose_mapping(systick.dev.irq);
+err_iounmap:
+	iounmap(systick.membase);
+	return ret;
 }
 
 TIMER_OF_DECLARE(systick, "ralink,cevt-systick", ralink_systick_init);
-- 
2.50.1.windows.1


