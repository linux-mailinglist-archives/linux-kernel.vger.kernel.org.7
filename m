Return-Path: <linux-kernel+bounces-885180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE1C32360
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0A454ECD4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261DC339710;
	Tue,  4 Nov 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="OOR5YrpG"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF743314D9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275765; cv=none; b=UStqOkKjTmg+X7lJaZFMUUKdtKoeXwRdwzaDOo+qsjGgvh1s7bPbzOlxSGyfEtSUCTFsZO8xDFSW5/AQjbUAUqawgvwQiqWnocppNHyfiAL4ouUj/RINkYeMR9RF3etaX1BUxxZzete2mD7NlP5kM+WGgcc0hib9gjwcmqoI78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275765; c=relaxed/simple;
	bh=BtXlWrIdumXyM9ib/YUSqbsPX3katm0ADIbgFua83iY=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Content-Type; b=tGQjS/3fimHdrRHJ4OrxsFoq2w8p8r3LFikTBYBIXvMxPYSTgt0rOA66PGcPAb5GzfUEbvz/3z7ygN+9Fu0C1IkzqiboYtPe790mQmCJ/Hlg9737L33K7Jb8ltvXXaKrYU0nj+tVoiakbxBH+nDSHVShlz3X3fBT/1N/cbt87wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=OOR5YrpG; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63fd2b18c40so150017d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1762275761; x=1762880561; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gsedja3EiqBaepnwF7jRsQaoV2IFZXBxn4TXmnZQIKs=;
        b=OOR5YrpGZhOV6HYw8aJSiCu7VbCiryXRsSGMWXFRw4X5RyqboTNg3Z8VVXQLU7cVhx
         k9IFN36s9HQK0FRibaKj+B1Y/jaeE5exr4I1Ru53JSPr05Ia7Npo41grtV9U0FX0RqHF
         GaQpL19BnoJVXmTREgd/oVKWt3Wqnq3oNE+9Cf0eZkhLnpBPFQ0FnazeyjgoNdMl2KfP
         o/FFUczfhLnpUwNRXQZeSnbFGXswZZ2q7JANVBtDShYJarK22e132/B0J6icAcVw8K+B
         xrXH2gE+A5FTMbl61N+6MkCxe2yIPXuYwDmSTkr5wLUKP3YhYQNiPyRZ7hXEBuRw58PS
         E+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275761; x=1762880561;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gsedja3EiqBaepnwF7jRsQaoV2IFZXBxn4TXmnZQIKs=;
        b=mUO7Wiank69jnIS0dtTFYUsK2GF2OLRM8sB0/DrWEdA5y6FqBZCLvhx3FCZRtmJky5
         C8G/x+lG6XUtrNEyJ8qGmSqs4IPGZ/zh9kItwlaTU2ULHoWYwkxYYDw8nAYrvTHvlCHU
         DJxXNZzahAW/pQbRn6KEq1Sq9CXl3G5n0ER3kqnsfcicfJ+jlQ/GMSeZ6o5VKaNePWMO
         TuV/lH4bwUIZIwH0TcBo6IMpfSoxn4eAlVrOLcjlkSBN/fMGwGwo1+3spac8JnsmKB2+
         AM4euN63+LlPHysPIgAHyUc3XvFqh6eafbcpQC+uabv6w6icnU6yJB/uqvXh6k8/fSFx
         M1Yw==
X-Gm-Message-State: AOJu0YxzmMOw8eAHf8aUXH84hXq9zeJlVNa67FWBb6XORmPY0kd2lzwi
	5jApKRKafDmVkKJPVf3LoS+m/dP+ei7uwHJwuTxWiUWdPiqzaU84T8pBwrBShROHyxAW3iF1kSq
	3NIhM2tjMjJeDLMuBrhzODWzGivvDRf28hg13JsFc6hFpf9v82qImdA==
X-Gm-Gg: ASbGnctx0U8zjnnK22HGfeGU0aKStDNv2P23/jK+VSIOMpsFd5UQwtZ5cTN5JoIm1Qs
	yhhaTgLfEbHFHribfJNOylfyw9NdIRVQX4UCX61E8pEjA4MUd4aqf8ona5N0VRU6owcVIZ08huK
	s4g0Jx/YPQArjt4jS1a3xYtbvjs5RVBjp4tiYfFm6Yw46jfjqZw/ijeqbBrrd6NTDCelHzFXenz
	PCmqK4bpecEMcMDWA5g+Et+rrdv+qLRcsjXMRXDDZ5PLi3RqIDRwOP6JksDFg==
X-Google-Smtp-Source: AGHT+IFLs/6mbSUM74f5TICiUV1UvBT35zpaFwUDHe0UvDMIm3TxGQ6DS/MkZ62zOWDE2G0VKbRhzIY6XoZ9MmDpNnM=
X-Received: by 2002:a05:690e:151c:b0:63f:b590:305 with SMTP id
 956f58d0204a3-63fd34bb3d3mr168093d50.4.1762275761011; Tue, 04 Nov 2025
 09:02:41 -0800 (PST)
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:38 -0500
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 12:02:38 -0500
X-Gm-Features: AWmQ_bl7UmLNoQkdYl0LBGY8F70Q2NR0PnW2nOU_3E-pI2ixNAor0W4NmTNiqqo
Message-ID: <CABtds-3V0qP2S-Zcco8D9SsEioNbKyXCmddAkEc9eS2+TCOucQ@mail.gmail.com>
Subject: [PATCH] drivers/memstick/rtsx_usb_ms: throttle idle card polling
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From e7dca663b4e5aa347db010e34c7e53795f489486 Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 15:43:42 +0000
Subject: [PATCH 1/5] drivers/memstick/rtsx_usb_ms: throttle idle card polling

Track the poll interval in the memstick host and queue the work on
system_wq so we can switch between a 50 ms cadence when requests or
events are pending and a 1 s cadence while idle. Reset the interval
after power-on so newly inserted cards are still detected promptly.

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>
Cc: Luo Qiu <luoqiu@kylinsec.com.cn>
Cc: Jiayi Li <lijiayi@kylinos.cn>
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/memstick/host/rtsx_usb_ms.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c
b/drivers/memstick/host/rtsx_usb_ms.c
index beadc389f15f..73677638a3f6 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
+#include <linux/jiffies.h>
 #include <linux/memstick.h>
 #include <linux/kthread.h>
 #include <linux/rtsx_usb.h>
@@ -21,6 +22,9 @@
 #include <linux/completion.h>
 #include <linux/unaligned.h>

+#define RTSX_USB_MS_POLL_INTERVAL	msecs_to_jiffies(50)
+#define RTSX_USB_MS_IDLE_POLL_INTERVAL	msecs_to_jiffies(1000)
+
 struct rtsx_usb_ms {
 	struct platform_device	*pdev;
 	struct rtsx_ucr	*ucr;
@@ -30,6 +34,7 @@ struct rtsx_usb_ms {
 	struct mutex		host_mutex;
 	struct work_struct	handle_req;
 	struct delayed_work	poll_card;
+	unsigned long		poll_interval;

 	u8			ssc_depth;
 	unsigned int		clock;
@@ -635,8 +640,11 @@ static int rtsx_usb_ms_set_param(struct memstick_host *msh,
 	if (param == MEMSTICK_POWER && value == MEMSTICK_POWER_ON) {
 		usleep_range(10000, 12000);

-		if (!host->eject)
-			schedule_delayed_work(&host->poll_card, 100);
+		if (!host->eject) {
+			host->poll_interval = RTSX_USB_MS_POLL_INTERVAL;
+			queue_delayed_work(system_wq, &host->poll_card,
+					host->poll_interval);
+		}
 	}

 	dev_dbg(ms_dev(host), "%s: return = %d\n", __func__, err);
@@ -723,6 +731,7 @@ static void rtsx_usb_ms_poll_card(struct work_struct *work)
 	struct rtsx_ucr *ucr = host->ucr;
 	int err;
 	u8 val;
+	bool event_pending = false;

 	if (host->eject || host->power_mode != MEMSTICK_POWER_ON)
 		return;
@@ -747,13 +756,20 @@ static void rtsx_usb_ms_poll_card(struct
work_struct *work)
 	if (val & MS_INT) {
 		dev_dbg(ms_dev(host), "MS slot change detected\n");
 		memstick_detect_change(host->msh);
+		event_pending = true;
 	}

 poll_again:
 	pm_runtime_put_sync(ms_dev(host));

-	if (!host->eject && host->power_mode == MEMSTICK_POWER_ON)
-		schedule_delayed_work(&host->poll_card, 100);
+	if (!host->eject && host->power_mode == MEMSTICK_POWER_ON) {
+		bool request_active = READ_ONCE(host->req) != NULL;
+		unsigned long delay = (event_pending || request_active) ?
+			RTSX_USB_MS_POLL_INTERVAL : RTSX_USB_MS_IDLE_POLL_INTERVAL;
+
+		host->poll_interval = delay;
+		queue_delayed_work(system_wq, &host->poll_card, delay);
+	}
 }

 static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
@@ -784,6 +800,7 @@ static int rtsx_usb_ms_drv_probe(struct
platform_device *pdev)
 	mutex_init(&host->host_mutex);
 	INIT_WORK(&host->handle_req, rtsx_usb_ms_handle_req);

+	host->poll_interval = RTSX_USB_MS_POLL_INTERVAL;
 	INIT_DELAYED_WORK(&host->poll_card, rtsx_usb_ms_poll_card);

 	msh->request = rtsx_usb_ms_request;
-- 
2.51.0

