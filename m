Return-Path: <linux-kernel+bounces-800114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8BB4338C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522D8162C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9299929B78E;
	Thu,  4 Sep 2025 07:17:42 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB62877EE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970262; cv=none; b=g4yVPR7Z/CzpH9EAiEjYjK6JLgZOpEge77GDRMdKU/Vxg8IxE99zcmlKCGdFwE9vrRfiqkLWjUTPxjUx8z4778AV0yUTQWCIwbKFYVe0gNRTrs0+xnltbHS5nK3ehxmQewviOFLV/6mG4HxRGphwUW66g2mWOaQR/8VOIrtZVWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970262; c=relaxed/simple;
	bh=Xjaa/4KIvlEb0Eb8QUjZKXufKO7jQ3AcbZtE0SnZ4yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnYLwVMWWWhdFdXV691flaHNRuFnEMbjF10S/vr2PPqUpwU5KJA3xpqlD0/v9fDXhybE65sy9HPgsWyHfEdrgl7g0olW3Y2NaIDhymbDbe4RfA7k+JeCyXnusYtcVdCoQBzBmJOhLbGCkxeHG2DAh646/NZMUE1wv3osmj+Sql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxXNISPbloTo8GAA--.13794S3;
	Thu, 04 Sep 2025 15:17:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDx_8MNPbloS2h9AA--.2519S3;
	Thu, 04 Sep 2025 15:17:37 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 1/2] tick: Remove unreasonable detached state set in tick_shutdown()
Date: Thu,  4 Sep 2025 15:17:31 +0800
Message-Id: <20250904071732.3513694-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250904071732.3513694-1-maobibo@loongson.cn>
References: <20250904071732.3513694-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8MNPbloS2h9AA--.2519S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Function clockevents_switch_state() will check whether it has already
switched to specified state, do nothing if it has.

In function tick_shutdown(), it will set detached state at first and
call clockevents_switch_state() in clockevents_exchange_device(). The
function clockevents_switch_state() will do nothing since it is already
detached state. So the tick timer device will not be shutdown when CPU
is offline. In guest VM system, timer interrupt will prevent vCPU to
sleep if vCPU is hot removed.

Here remove state set before calling clockevents_exchange_device(),
its state will be set in function clockevents_switch_state() if it
succeeds to do so.

Fixes: bf9a001fb8e4 ("clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining")
Fixes: cd165ce8314f ("clocksource/drivers/qcom: Remove clockevents shutdown call on offlining")
Fixes: 30f8c70a85bc ("clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining")
Fixes: ba23b6c7f974 ("clocksource/drivers/exynos_mct: Remove clockevents shutdown call on offlining")
Fixes: 15b810e0496e ("clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining")
Fixes: 78b5c2ca5f27 ("clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on offlining")
Fixes: 900053d9eedf ("ARM: smp_twd: Remove clockevents shutdown call on offlining")

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 9a3859443c04..eb9b777f5492 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -424,11 +424,6 @@ void tick_shutdown(unsigned int cpu)
 
 	td->mode = TICKDEV_MODE_PERIODIC;
 	if (dev) {
-		/*
-		 * Prevent that the clock events layer tries to call
-		 * the set mode function!
-		 */
-		clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
 		clockevents_exchange_device(dev, NULL);
 		dev->event_handler = clockevents_handle_noop;
 		td->evtdev = NULL;
-- 
2.39.3


