Return-Path: <linux-kernel+bounces-758611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5920B1D15F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1A75651D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673CF1E520E;
	Thu,  7 Aug 2025 04:00:09 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0CB1B0F1E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754539209; cv=none; b=TKfjArOdyQBjEYQKjs6nhAFqPyLnHH9++L97GdLf5P/CADzxS/3NmNMJmlMcY63bJBdGNSVTS3AsuXHOEob1vFGM017ISSFBSOrJoO3EXNBw6rOvvAGj0ZcdUsftgrSecdH0V7CYy7VCaAUYEZii7EZjzSEA4IzpdIXD5EMEvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754539209; c=relaxed/simple;
	bh=IxAokOYjdka6Q8GQ4OaCmhnX7CjdHItGK4MHiGtNU2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jWZh1b3SDcLLvVYM8/iGmyEtcNeHmLqTsUK0/HTMGcfvxCzl1sZaWpg+V20YcvPN/jNridHk9v3q/gIdGmWpb+G3eFsnLqYtVPn6675lMEBoaybfJUoBvO6BHDzeWU95SNdjvahb+la0sK7ZbLJ0fb4E8JnZf/m0knfh0MeLewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxnOK7JJRoUD06AQ--.13459S3;
	Thu, 07 Aug 2025 11:59:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxvsG7JJRovgs6AA--.44367S2;
	Thu, 07 Aug 2025 11:59:55 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tick: Remove unreasonable detached state set in tick_shutdown()
Date: Thu,  7 Aug 2025 11:59:54 +0800
Message-Id: <20250807035954.2412399-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxvsG7JJRovgs6AA--.44367S2
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
is offline. In guest VM system, timer interrupt will prevent vCPU to sleep
if vCPU is hot removed.

Here remove state set before calling clockevents_exchange_device(),
its state will be set in function clockevents_switch_state() if it
succeeds to do so.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
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

base-commit: 7e161a991ea71e6ec526abc8f40c6852ebe3d946
-- 
2.39.3


