Return-Path: <linux-kernel+bounces-861244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE29BF2288
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A9144FACE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756D426F2B0;
	Mon, 20 Oct 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="1wfIh5dD"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A626C3AE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974699; cv=none; b=nkI88KNkr3HEya8WxcvHiV41Z4lTDBC8x4d7+UN/cU3zWcHxhT6/EJLDH/9r118CHGL3I5YFZS7JJBOZ6WwBD0ND+eXY5xmJQ5rhh5hz0qg5onMY8vf1Xpkd109+8hLw5ezRBCb2ehsVl2ZkVd8a4MJympmzoiwJlQgAVhvs0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974699; c=relaxed/simple;
	bh=BOim9W/NsB/OSI7iw8/JuwQcBd0s6PyDRJRBxyl0CJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aR92JZEX1hpPxkvb+a9qRwh/4CAcgS+RI1sXNANM/K4rRy9N+9uMPK4pERfnQgIzDVswSHGbyDjexUUtcI/tPy19kHT5TwMkjo6VPtocTaHfwujPSp1UKKGbKS9klKWrKrJPGLhtezmzAoGZzmcaNbPrO1rUo57RL2EOdLROzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=1wfIh5dD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47117f92e32so28388165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1760974696; x=1761579496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1WpPsLi2xewBAoEF0YUxT2xy9Y1Dmcopa55uXgVTvg=;
        b=1wfIh5dD8QQv5JW19honM7z3UHWbZWLRjXCS1Qo33CwGCxiuULX5PxjVnlxNjYeqHn
         kLGwmijJggK9FNedN2+oMfE4LoMMlG3RfyCdmzPPWquKdpjInD8Dn8HUeaKdlPhPUq3V
         mcQ71oJ2mNV5yztbaH4Aatfx8Rgn2Ax2EiaXr4koLKqgBfQoQzhdS9GL2mhUKSIJ1/fz
         pj6/2Iywt8bvd+lfQdhL7AZv2WsicwfY8gTI1RKhVLiA3Jo/iJH5snsQJHrjj7SWqS0O
         7Jx1uK+L8Jb/CpEC6pZ2WY1ydxpU7MQ+cUHdefsthCAjlEUGKhQ4iGhcHb6RJpH5JjS+
         SrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974696; x=1761579496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1WpPsLi2xewBAoEF0YUxT2xy9Y1Dmcopa55uXgVTvg=;
        b=f57I35wp63r1Pn1XzLNybxYa/WOoXZIhIflvAMqLM60JBnY8ICv35dekq9MTNPVzut
         0QU/3cL1h6yQLitjE6o44WUfiSChKmPySUuJvfSkYJq8z6/SrfQpmCViV1IqvwlGpi9D
         /9y7OipHsJs2/2BznR0/cPinURdhPZiGUeJ8wwkArIoA2/wsrL1JGDZUyQxCbwGj1pLB
         a1pEfUe3vtlGu4D47UCW+A9Y4dFSXwx+4D9En43oGcf3fx1XixXiLjV2Q2YUOQnljmvF
         x7TwmKS+NfXkLz5qCGCJhExAE11iib/d3ShSTpyBhLRZX/Lzn56ZqeE4ClTLbLj/Hkk8
         xSJA==
X-Gm-Message-State: AOJu0YyLWR4cGFgTg8hoo9PmEAuMMKaR2CMK+EtnKx89zlUKDYcS4xsr
	GMDqY+moMuNMF14CCdtNAzVtnAlJ2coyuuHa39aLQuOqNIWMWwPPhrydSaezpKzS9pq6P4vwSTA
	DYn4PRm9jc/IG
X-Gm-Gg: ASbGncvLn6MpCh0IETUvBFDNeHN/HMptNUmv4VQCL2b/vyzgIVgspRjJeld7YyyfrpL
	96RvTVSgzYQhgrpYGlvOoRuSMjM/Hr+ytIkYte5Yoh81Ep9jjDXTj+AgTzgyW3e57SCTBrb1wxl
	DCgRopSDL0DtlEwPIiHJ8SC+O45PLC7OGUNA6yFH5C+k6RedeJNRjwaPD5YDRBvg8icOxORvFDh
	JyO7j7mB15R09sVuwQGVrvV2iJMMRcPyMa6nBQA+1thsksyjukBXM4/IV4rlb0GCtfGkdA2vSrc
	CDIa/qYbyJtSapvDkhJ+ntnU3v6ZWb8KCphv3ddGRxPiGZ1gGdbiOdi7uVki2DLiXAzTNCn5dWQ
	ycPdDe1RgvPpZda2/BXyXprYtRrjGCzQIdAUwWlyiKzvGz21favs5SFf6m78xiFL6DpAJRnJnSA
	AkhbfGBvEKKzu9HA==
X-Google-Smtp-Source: AGHT+IGdf9VV2wGEvh9arjsxEQ2H3l1LgoR2fW9Wez0KU4UhOZkl4cqnX5kXbHcJxMdREo16G8z+mA==
X-Received: by 2002:a05:600c:828d:b0:471:11a3:a289 with SMTP id 5b1f17b1804b1-4711791c5f5mr92703615e9.27.1760974695705;
        Mon, 20 Oct 2025 08:38:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e8037aasm120631405e9.2.2025.10.20.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:38:15 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 20 Oct 2025 16:38:07 +0100
Subject: [PATCH v3 3/3] printk: Use console_flush_one_record for legacy
 printer kthread
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-printk_legacy_thread_console_lock-v3-3-00f1f0ac055a@thegoodpenguin.co.uk>
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
In-Reply-To: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760974692; l=3981;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=BOim9W/NsB/OSI7iw8/JuwQcBd0s6PyDRJRBxyl0CJQ=;
 b=PHdBALW8Ed7QxtF1Gs4JmXk44Hg+amGSJpEzlUJgM6Jr7zdViAOLR/BIAT5L7/Tw9lVtpVsrd
 CSXkrRGzr3kCBLr9tQrEv0GrvcZeUlyBwvYRpplfvW4JSGwGCfiSz2b
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

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
 kernel/printk/printk.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6c846d2d37d9d20bad58c6e3a7caada3be9552ca..2665a7a59f03b3a357b3346de1735606e77c3496 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3644,17 +3644,26 @@ static bool legacy_kthread_should_wakeup(void)
 
 static int legacy_kthread_func(void *unused)
 {
-	for (;;) {
-		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
+	bool try_again;
+
+wait_for_event:
+	wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
+
+	do {
+		u64 next_seq = 0;
+		bool handover = false;
 
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
2.34.1


