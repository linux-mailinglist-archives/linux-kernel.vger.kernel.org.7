Return-Path: <linux-kernel+bounces-841499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD77BB788A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA2614E67DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679FE2C027A;
	Fri,  3 Oct 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fZ+F8RN9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E782130A73
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508799; cv=none; b=qTAhxuxl30dVhWMzbW7YVJePIjnYScCxXU99eCqIInD+sf5sro1wkd/XHgFvolgxgqNepgeJuBpZwiSCApm09LvP9a6Esf5OupaKEk9DhHEnC0kYC1mM92sA6yL818BOHTfjhWKQKOJWrlMtIiKLswo8iFSmMLs9hjR1xh2hUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508799; c=relaxed/simple;
	bh=YLy/X3lNzn3nVcwkl0b2LiWaCGpiuRz3iDAK9a1gj2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nt8zyEeoCr84bhGRsJAvzbS4gjXILJOWlsZhM8xwryohGmCwujkwvDVMQdLE1K6suDctq/oPCkaN4uYD3PX1CZ2viJXKfWM/AfJMjrJupjNGzclNSCVkhe/LvC3RC3LPStx3lWtIn8exdcXIumnHnzKmp9j2UeJfmpqN1cArFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fZ+F8RN9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so22161005e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759508796; x=1760113596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gajxlSuluihePqHCqKt5fZIHJ2HLGhm6McvjLThFIMU=;
        b=fZ+F8RN9ru9TzGMHlCuT9+HPi42LfLPKPDCSqzY7qJRgCpLgrxc/MiB205foXhpRL9
         uHViYTsoZj+0ZjcoRoI2UZs7lzwXzvSELH4n6Hv6vWUWfqPcycvEymgc6qZG7u74ZJwg
         VXtTbnl0aX5+C8NnvbS8PS+Cs9KPEt1wA2sFrHKqJ3QXAGLkzInmtytMai/if6+FWXB/
         f5e1JbCWDGiK49jk4cf65u2jb/BL9M5z7/2GXewByNiVwUWq5EoLsW5OOY5V9pPxxJUV
         SLsG2Wwewkkbz4FkrXSMB5/5ZGviYq7QtLzCRY6OwhBTMlTJz0UOlvJJrtaXQVpsugXf
         JU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508796; x=1760113596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gajxlSuluihePqHCqKt5fZIHJ2HLGhm6McvjLThFIMU=;
        b=c6vzl584MgJ/ra6YcuhQp6f8a9fmmYpSU0wozEJaSguSFKb5694S2XF5QI+kpUqn9q
         wDwGytQ7Voudk4c63BTeZCP6ulmyJYsL2cBYxOJzSDYzbEXQ51aralgMq1APkuuI4sEE
         Xlm+6x9srycGxpOHAsweZ4W/zFORT/4m4i9j2umHKyQq6EFKwr3Ls6FEA0wfTYFo9OZE
         0xkizxMtZnMc5dXwA61Nmwtb9YFOXJhadSY4EiJvsaIHkUro7t33p94vZizXZ0HAXhyo
         8eQVOzo5Yi3XQ9cEpONLIt0FiPRaCS6XgZ+q0KAKfSZTmadjjC7Obc7AxE8DfyTKExtf
         qdkg==
X-Forwarded-Encrypted: i=1; AJvYcCX9N3GTI0WRTRr/u9sfGCVxFh3JABwZSQ/0E3Qa2bYltMl9Rxy3t+Ks42v14XoPaBz73CJ/5liM88zdjvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8o1H8dOg0LFZxzk2KOq+r4qUyzkGNqznqPGgVgdHo1e/si7Nq
	1M02EJyHhyIvxxh74BBBPtIAOdUZu4O2jAF9tYPxnsSo+1Xg9vB1X5vqHcXtqsUxVGk=
X-Gm-Gg: ASbGnctfHlr9zE6ijKbbuVxRXnuvR/5AuN/xVwv79/X6LyTHFlPsxd6fzANxTGopDzA
	uV0UN1safLMgReLmYXVsAkwN92+Wm9LOeB76EKOhWggQlrmNiZeO+2XqCUbRXT9d5CreTQQB34w
	7M5y6kODbPJAou4qzZinjh9V5PLJJMzFgo9bnw6R/IvNWBZv/Jg+7VVfkJMnhfegJAKHK1cLs8j
	UbPKhmnbYf6wzY93x504hC5F9lIRGflFp2l5co4X/dyYCUpKF5NDL/yAFmOWs3Q7nJPJpDOz8qQ
	5EJxZNI8+rl/6kuvcFiL2mObVxguW1cV1QGVkHUhv84JqRlPaK4li6/W8TtDA2FWnEXerJN5dgc
	IRQyzOMisrvaR4NBBN20XGHbGw4dqfkFPktE4M3Iutb5NcwG4SQ==
X-Google-Smtp-Source: AGHT+IHeh3njeIyHzhc0USq3s+/qrNkY7oSu40NYptDlyKWJ1rM71U3xf7eOBrvqlhJdcpAEBYZ3kQ==
X-Received: by 2002:a05:600c:c16e:b0:46e:33c8:ec62 with SMTP id 5b1f17b1804b1-46e7110c4a1mr27175135e9.15.1759508795641;
        Fri, 03 Oct 2025 09:26:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f69bsm41698845e9.8.2025.10.03.09.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:26:35 -0700 (PDT)
Date: Fri, 3 Oct 2025 18:26:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] printk: Use console_flush_one_record for legacy
 printer kthread
Message-ID: <aN_5OQkomghqQVwH@pathway.suse.cz>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-3-cff9f063071a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927-printk_legacy_thread_console_lock-v2-3-cff9f063071a@thegoodpenguin.co.uk>

Here is the same patch with the alternative semantic of
console_flush_one_record() as proposed at
https://lore.kernel.org/all/aN_3id2CF7ivC42R@pathway.suse.cz/

The return value from console_flush_all() can be ignored.
It is enough to check whether @try_again is true.

I hope that this semantic is more straightforward.

Here to go:

From 51667c506c13f662d222c7907e6a055ae77639a0 Mon Sep 17 00:00:00 2001
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sat, 27 Sep 2025 23:05:37 +0100
Subject: [PATCH 3/3] printk: Use console_flush_one_record for legacy printer
 kthread

The legacy printer kthread uses console_lock and
__console_flush_and_unlock to flush records to the console. This
approach results in the console_lock being held for the entire
duration of a flush. This can result in large waiting times for
those waiting for console_lock especially where there is a large
volume of records or where the console is slow (e.g. serial). This
contention is observed during boot, as the call to filp_open in
console_on_rootfs will delay progression to userspace until any
in-flight flush is completed.

Let's instead use console_flush_one_record and release/reacquire
the console_lock between records.

On a PocketBeagle 2, with the following boot args:
"console=ttyS2,9600 initcall_debug=1 loglevel=10"

Without this patch:

[    5.613166] +console_on_rootfs/filp_open
[    5.643473] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
[    5.643823] probe of fa00000.mmc returned 0 after 258244 usecs
[    5.710520] mmc1: new UHS-I speed SDR104 SDHC card at address 5048
[    5.721976] mmcblk1: mmc1:5048 SD32G 29.7 GiB
[    5.747258]  mmcblk1: p1 p2
[    5.753324] probe of mmc1:5048 returned 0 after 40002 usecs
[   15.595240] ti_sci_pm_domains 44043000.system-controller:power-controller: sync_state() pending due to 30040000.pruss
[   15.595282] ti_sci_pm_domains 44043000.system-controller:power-controller: sync_state() pending due to e010000.watchdog
[   15.595297] ti_sci_pm_domains 44043000.system-controller:power-controller: sync_state() pending due to e000000.watchdog
[   15.595437] ti_sci_pm_domains 44043000.system-controller:power-controller: sync_state() pending due to 30300000.crc
[  146.275961] -console_on_rootfs/filp_open ...

and with:

[    5.477122] +console_on_rootfs/filp_open
[    5.595814] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
[    5.596181] probe of fa00000.mmc returned 0 after 312757 usecs
[    5.662813] mmc1: new UHS-I speed SDR104 SDHC card at address 5048
[    5.674367] mmcblk1: mmc1:5048 SD32G 29.7 GiB
[    5.699320]  mmcblk1: p1 p2
[    5.705494] probe of mmc1:5048 returned 0 after 39987 usecs
[    6.418682] -console_on_rootfs/filp_open ...
...
[   15.593509] ti_sci_pm_domains 44043000.system-controller:power-controller: sync_state() pending due to 30040000.pruss
[   15.593551] ti_sci_pm_domains 44043000.system-controller:power-controller: sync_state() pending due to e010000.watchdog
[   15.593566] ti_sci_pm_domains 44043000.system-controller:power-controller: sync_state() pending due to e000000.watchdog
[   15.593704] ti_sci_pm_domains 44043000.system-controller:power-controller: sync_state() pending due to 30300000.crc

Where I've added a printk surrounding the call in console_on_rootfs to filp_open.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 kernel/printk/printk.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6c846d2d37d9..885506fa0178 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3644,17 +3644,27 @@ static bool legacy_kthread_should_wakeup(void)
 
 static int legacy_kthread_func(void *unused)
 {
-	for (;;) {
-		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
+	bool try_again;
+
+wait_for_event:
+	wait_event_interruptible(legacy_wait,
+				 legacy_kthread_should_wakeup());
+
+	do {
+		bool handover = false;
+		u64 next_seq;
 
 		if (kthread_should_stop())
-			break;
+			return 0;
 
 		console_lock();
-		__console_flush_and_unlock();
-	}
+		console_flush_one_record(true, &next_seq, &handover, &try_again);
+		if (!handover)
+			__console_unlock();
 
-	return 0;
+	} while (try_again);
+
+	goto wait_for_event;
 }
 
 static bool legacy_kthread_create(void)
-- 
2.51.0


