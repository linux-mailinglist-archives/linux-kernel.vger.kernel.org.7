Return-Path: <linux-kernel+bounces-884593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C24C308D2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E4E84EAFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC72D7D27;
	Tue,  4 Nov 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T72qNEmv"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586D2D73A7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252798; cv=none; b=V0O+jlrBfOqeJbM07FZo161qZaKeQez6+SUuS6j4drlLEC0q+a/UfkI9jnMgdBgD0Fs1+ARHtFOMqffi3ZiPmW0Bg4n5kA0VfZi3S39uHY2lYxfXnF0YIfv1b02ilYOdxm7TkqSXqVKOgxcRPsF1RPWK0vJsxToCYBgwYSIRAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252798; c=relaxed/simple;
	bh=mBQcfulaULMJs9Ri80bCniWF9vmb1TTMZvnFi9RYStw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PchayiquLmhedLFFEZ6kKPihx4njCP/Ld7L4UBWpVugN7GV20HUh1eX0apLloUJtJR3ZtD9N+ewRDkBhohTQxWcP9D1vxnc1XI/IshE4ivO0A9pIebZ5CR+OIC8xX6ZX1qs7gPOB9JUw2CQTvhc4BPGbEFhHReY0nzShV5xOoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T72qNEmv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d3effe106so838956966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762252794; x=1762857594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QqlXXzI8Au0XTieknIe+lDfj6CC3yKlLay1p36P5BWA=;
        b=T72qNEmv5Kq0iloI8U6PLRTeQrGSSe6DiJ0qzj/+kxrFtQ4WIsKXw1qqDPRk3DVxyQ
         PtdrIDtMA5hVmIYRO6xmarcRo+bK4VLipOm+BWGADMQA2eBJzFhFlLup6Wa/wxcVU8Ra
         eTnxzsGfIMAlOsncxoniZ4vTn+CPBUMYQwbKkjaOJnRjTAVDV6EU8adV6+POFG0BkjbG
         /UIOdxqu32whtkOhJzHMKAN+DTsPM21HfEapTbBRvaLgnabyljD21g9g/v3dulqgx7hZ
         T4cvaJi2xUnZbAZI1bRXaw0vmXuasOwB24ufix4TiXpao/LRKtA7/TuTTBojnDnzOxEE
         hNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762252794; x=1762857594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqlXXzI8Au0XTieknIe+lDfj6CC3yKlLay1p36P5BWA=;
        b=ILhEljAa1XQ58MwA443r3uY19bPXC+Dfrxg+DFaSN9lveTd88/XTG3K/fg+fAKdfPR
         ySEfysmESNb+vgVpmvTDsc0fHND2N2lXaeEmk+odiGQkSBuV5LYbvFzvVUO8KciF6/JG
         CcfiP5rQLbwLrJwgwwQA9CrsWYFcVh86jLovNHNbjKAy+PeuQPYrnkxwBhI7aXPf1NWE
         yJvndkIsbwRBlAJrE9+emIpAfXmjuxRaQU4eyr2R2YfSMiVXBQTNINWaYqg80mL47Ct2
         iZWtNyH+bRQIrw77kJmrW4ynC/eX2eKwE0a0LWzljKYkvjz/PQ2CfjsspE4ZCIJ409mS
         f70w==
X-Gm-Message-State: AOJu0Yznq3NPYwHSfd2Oykz2TxMeS0CefGdbZCaRr/FJQnDMJd9dtr2f
	04mmxgxmkPpy4RnQVHLDp3/PwY+8Ho5oEHeTy0eY3TgeRBa09HfmAM2eZvgzw/FEyBgAxoGXSUJ
	EFO3w
X-Gm-Gg: ASbGncuDjRqT3CWQ6Bsm8Y+q4hoS18XvLt4EgVVlSAsD4HqKSvA3YDWj1FQUmAGEY/J
	Chllk229p217MIRPQ6jZd78AeeXxNCSdQfRTUqTH7Yy2lHZDTSaYspmG6a3BBl+ZKsnlrAYNAKu
	jnWK1bWjrr7rCFqQjxrYFwT4qM/V3sYk4Qv2O5VOAgjXayQTjdoyjTqfNAO/KwzPVtKulYwq+pI
	U5AZiF0IC75BheyS81ERDHvi+R/DYnLWZOiGg+TMRkMaH9O2bfQiLea8JB+U2wF1MOLYMQJEbLv
	SbzU3bpLhNg8/51X4+J7PvoFvou5Y808lU/osyYdOn8RGJ9jEK87IiiQGtOwwBxv0VIBw8Yu/GG
	Bk/MXX74Umj06mxURrh7F9QSidLcaymU7Y9kbpZhAu19u7sy/L2KDFHb5aAsZ0HLyTtLctLk65p
	u4xSU=
X-Google-Smtp-Source: AGHT+IFHdu3jVlRRTgt2EsjZoNbWOzlzZQBq47hjinpGHe0X6AXDR+UMU39LFk/i2FqEqJ1vPcxfFQ==
X-Received: by 2002:a17:907:9628:b0:b6d:62e4:a63a with SMTP id a640c23a62f3a-b70704c3ec7mr1537809466b.40.1762252794102;
        Tue, 04 Nov 2025 02:39:54 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26e7sm175960366b.41.2025.11.04.02.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:39:53 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH] soc/xilinx: replace use of system_unbound_wq with system_dfl_wq
Date: Tue,  4 Nov 2025 11:39:42 +0100
Message-ID: <20251104103942.96647-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

system_dfl_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/soc/xilinx/zynqmp_power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index ae59bf16659a..6145c4fe192e 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -82,7 +82,7 @@ static void subsystem_restart_event_callback(const u32 *payload, void *data)
 	memcpy(zynqmp_pm_init_restart_work->args, &payload[0],
 	       sizeof(zynqmp_pm_init_restart_work->args));
 
-	queue_work(system_unbound_wq, &zynqmp_pm_init_restart_work->callback_work);
+	queue_work(system_dfl_wq, &zynqmp_pm_init_restart_work->callback_work);
 }
 
 static void suspend_event_callback(const u32 *payload, void *data)
@@ -95,7 +95,7 @@ static void suspend_event_callback(const u32 *payload, void *data)
 	memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
 	       sizeof(zynqmp_pm_init_suspend_work->args));
 
-	queue_work(system_unbound_wq, &zynqmp_pm_init_suspend_work->callback_work);
+	queue_work(system_dfl_wq, &zynqmp_pm_init_suspend_work->callback_work);
 }
 
 static irqreturn_t zynqmp_pm_isr(int irq, void *data)
@@ -140,7 +140,7 @@ static void ipi_receive_callback(struct mbox_client *cl, void *data)
 		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
 		       sizeof(zynqmp_pm_init_suspend_work->args));
 
-		queue_work(system_unbound_wq,
+		queue_work(system_dfl_wq,
 			   &zynqmp_pm_init_suspend_work->callback_work);
 
 		/* Send NULL message to mbox controller to ack the message */
-- 
2.51.1


