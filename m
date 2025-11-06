Return-Path: <linux-kernel+bounces-889012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7DBC3C858
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4238507F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04E434E744;
	Thu,  6 Nov 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DzMctB0F"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FF2E0934
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446659; cv=none; b=tvTdxNP2/NYAXUgmTus8uWhQB+eINnKufiRah00fd6ZLylPeB922G2W1eMiSUzZ+AMXmM3B2DYMOwDXHnZGyu1gfooqnffaRwMUhq+ehpsWHqobB2PLgO+73mO0ycD0HsqjTlo34pdXJsYiuxU+2Qey9DrdHqMh1EAmcLle8oNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446659; c=relaxed/simple;
	bh=gYhjnJntf8e+exsJBV77E183bZwo8jng5Ik3yHGybh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qf1c1ONeO8yWsWH9lSBrlu0dig2+yBupaHFoEDAZXLS8uhX8royl0DUZ6xPAlaRT9Kj9TlzoK6eHcKAXSrZUeK1gTTEgmvhzdmwFyZVStWsFPQgVWDcq5D/afUjaEonLaqaKVl6D7GcbZzOH09vC/EkTNq6aOnEuXgPzffr5KnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DzMctB0F; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426fc536b5dso813421f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762446655; x=1763051455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ghiagejTGAm40hy8FcdWAPhWPo7jDH7uEYc+z80yAhg=;
        b=DzMctB0F3XMYrXzFbuSr6KqtjSknfbntsKDF4LO1l/zPK4uDh132zEkR6FchpUuVfg
         Dqg/C3qMkTRRu4MWGDo8KPwy8tPP5YoyFMs8LRr+ah5gSXopITSUG+zEHluXNcOwG2Ly
         2R7vSZw8nu76YO2SgUsAmtvDLm9eBG/tAdVnEipxO0x2mclVdcEWWT8AFcbywJdqwQPa
         NUxyQf/8buXMYY8J2IFYV3bPQKe4h9Nx1849i09JqVJ0NJJaaAdtek57OaJgw/3qT2Ux
         zKQzv5aSOEAw+dPkqOTms2X1AH0aCrsp4UVTnkjHysLIZIzQxH2pmOAqtYa0dca3RBTp
         Dzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446655; x=1763051455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghiagejTGAm40hy8FcdWAPhWPo7jDH7uEYc+z80yAhg=;
        b=Btx6boBTy2WcQuh+uyE70r/B9dL00YxwpjlHbkn9alTx91D6M5cNtO6PJURJFWXQ3N
         pmqJ/Ncrioyh794ZC/5hbu4sKpBEWkQ3eLSjYNTmH9Al3AlPtYrAt3/SfhTjGX957Z6R
         O++PxMcabWlbaIodCvkA0+CjC82ykAoD5kTUwEaDPY2uuKFJ7tx915wD5A4hu1aCiqk6
         afh3AfViqgx/BAgWAs9q+OjkIy9SoX6XgXBZW4j/6LIyo2MkHMK/JUkxHTiVJAWAUB21
         1Qx4afLBMlqkucI17WzNIyou3Ob0YgEj8mN2owFt69SY7LFYtyNzU0CDQU/DlI36iUPY
         QaeQ==
X-Gm-Message-State: AOJu0Yz1B3Wh8kmBiYxJc+nJ+15s59rqxEdM14HmjXGfHWL3bfgN3U7S
	ZPDj9x1KqLjbtY+KEjhkDnrXZMY8OmJz4BuL5PAG/rPcKj86b4CoLO695efk8YsNmr4igFt8U+k
	Dq2eN
X-Gm-Gg: ASbGncvu7tEkPHKfgL8Twu2f0goEIctm9Yx78ySC99TYyDo3+Ktp2QcSuyKY/8pkCOQ
	0sd7OAxr612aGVkdqeQVgFMB3YL9srwI9URRo4P/x62sHq0E/iALiBV8gu88dqCza6BsHHbY52u
	eUKMtQlEDhMBk6QzPRs9AEhgP8s89Kr9qdc+ViRQQ1wFV6SRbxGTnGBJC0fQonHqmafgCk8AiGf
	da9K0zfc/jAfHLzInpCn438n0/wMsD9mQODcLZ0uxf/7VpY3tbJD3k49ik4a4penp1sdY4AKnZN
	nh8iXuT4NsnjPD/HnSBaJ+iE9o4bxcPpYuRGsqMyiBDFC/8QE6L86W4xkdtO3wTZ0C4g6m+VO9d
	6uFkY5XmgSfucPkN8Xbf1lWNPJIJe4s4Ytlw1Abxu83DaDRDRd7N0ofeANQnd4mNlEXihd7islm
	8NBbcLn/Pm3wQzLbkbB7JAEqtf7Z3CxKv8Vw==
X-Google-Smtp-Source: AGHT+IEc5gkMpVdBV8M7lAC4j7fERrfSkwEAcK3366zhuwEaU9kZ0HyWbVnnd22K2dINc1XX15z5gw==
X-Received: by 2002:a05:6000:616:b0:429:d2a9:5df8 with SMTP id ffacd0b85a97d-429e330655bmr7186591f8f.40.1762446654870;
        Thu, 06 Nov 2025 08:30:54 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm5947037f8f.31.2025.11.06.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:30:54 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Eli Billauer <eli.billauer@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] char: xillybus: add WQ_PERCPU to alloc_workqueue users
Date: Thu,  6 Nov 2025 17:30:48 +0100
Message-ID: <20251106163048.334400-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/char/xillybus/xillybus_core.c | 2 +-
 drivers/char/xillybus/xillyusb.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
index efb1ae834265..5f04963482e7 100644
--- a/drivers/char/xillybus/xillybus_core.c
+++ b/drivers/char/xillybus/xillybus_core.c
@@ -1973,7 +1973,7 @@ EXPORT_SYMBOL(xillybus_endpoint_remove);
 
 static int __init xillybus_init(void)
 {
-	xillybus_wq = alloc_workqueue(xillyname, 0, 0);
+	xillybus_wq = alloc_workqueue(xillyname, WQ_PERCPU, 0);
 	if (!xillybus_wq)
 		return -ENOMEM;
 
diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 45771b1a3716..2a29e2be0296 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -2163,7 +2163,7 @@ static int xillyusb_probe(struct usb_interface *interface,
 	spin_lock_init(&xdev->error_lock);
 	xdev->in_counter = 0;
 	xdev->in_bytes_left = 0;
-	xdev->workq = alloc_workqueue(xillyname, WQ_HIGHPRI, 0);
+	xdev->workq = alloc_workqueue(xillyname, WQ_HIGHPRI | WQ_PERCPU, 0);
 
 	if (!xdev->workq) {
 		dev_err(&interface->dev, "Failed to allocate work queue\n");
@@ -2275,7 +2275,7 @@ static int __init xillyusb_init(void)
 {
 	int rc = 0;
 
-	wakeup_wq = alloc_workqueue(xillyname, 0, 0);
+	wakeup_wq = alloc_workqueue(xillyname, WQ_PERCPU, 0);
 	if (!wakeup_wq)
 		return -ENOMEM;
 
-- 
2.51.1


