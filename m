Return-Path: <linux-kernel+bounces-835090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB900BA63C3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519A8189CC71
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E48B241673;
	Sat, 27 Sep 2025 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="qx+gbvql"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF723D290
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759010759; cv=none; b=V9DaTloRvFSDODoZlE4xsK8qrEVXpY0NfaMTLoDUx3FS8DaiR6Bf0uwbp817JfqDjUGvWeVuP8VxoO0vhcAeF47kqK9VM6Ix+lfNYPou4wyDxCu4T4FczVK4+8eDnGa0P4JG1nxgAiTG8FeQBQDxe/9m517/Q2X1vJwrBQ1arv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759010759; c=relaxed/simple;
	bh=iRRIRcCO6to7StUlEIsN+miyvowwCexvmjuZd0Cvz0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZ9wgPoVHDZ7e5vB/ZXyjVX/lcU5vheosSeoVHxh9gfLxbm8LG3LbWzz/LvKhvCn+Psbaz6NwZupzpN+4G15yCJtNFVvccECW+u1VOgLZK8xU0pW8/lypFSQv+Pa4kNaT3uHImf93hEF1HC3ViJjeVSO8kAuWwanyQRHBTqx0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=qx+gbvql; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso20130725e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759010756; x=1759615556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OepS14psY5rWOXHn3HlFtsint7dVhh7F+68SEkY7ueU=;
        b=qx+gbvqlx4RtNlrh0vnTAvC6KaHmT7D1kskVz9PbUVwTzdOsGPmFT0pYkv8Jm6CC1m
         4+tbHE+uTbK3FuzkZBqtVKghXpS/C50OMZCZRzRb8uQj3xwrhO03NNe428U1Ffw5W81E
         UEL5MLiCkuYJsOuKyvIL0buSqsK9U+KJCjboV8P0sA2s8cnLNu6Zjd2NLKwxzgZ+Tavb
         ktj7JasXF/y/WsF8XW9G+FO8SpjhDZlqejrnepAgzOjtJLYqDyzhe1yh9zvsurdyocdM
         7ewDPrjF4A1znyoibpSbTx54XN7py1oaOmw5KprNgrco2fK4lMRKuZvcYUYpJWWw98Q9
         tEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759010756; x=1759615556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OepS14psY5rWOXHn3HlFtsint7dVhh7F+68SEkY7ueU=;
        b=EZHNZeLkWQzSIfqHSR1NP+5IUZ5Zpb5DLutsUuv/DewSvpyzbm3ZvgkrApG/D/Qew/
         SMJW3mN46szLdhQ7bx+eX8bZ9ftR0ZnshTjZPy0mn/+me1vrNiWowq8RG6iCQyfMieh+
         jc/hU/MFMUEmZ/SyQ2FyQX3e9k3VzyTc8ghxKmLP4tJBCJdQo2MLvfEKT0kLl7+b6+VE
         3KKA2tg6HV/Hk2LQBKBq+YmW0valD29JXIuHAvdM9FHe6kDJFPlOlfIeMY+UwOgxPQXF
         NS0dkMPofUhmc4vsFocKa10wQLuAN8OZKZwOXZcrMTxcNf6fHl3Dqvx20UgcLkhBUMpG
         3i3Q==
X-Gm-Message-State: AOJu0Yy448QYbALmFrTE9fz6ko3gdO7RtDzh/Sq4MD93+0OHN9Lyl6Ug
	DSzvUVHBvfdw0OMmMp2sDro8Tz3qvNRUwpa8rsAsVdAfo6+/i3rs3D6ueCwSmhM2wvY=
X-Gm-Gg: ASbGnct2lI1CuLWn0yQ7JwZwRDufXpt3wO64ndbausf+LxHCMS09Ppvuqw3nmMUwcpQ
	BdpbOEWb07Bfo09eHIk57gbFdAF6TrTd/QgVgxYt6/TzZN500yeFBDNmuGbm7CLSwVdvFtcOriw
	927uasyEa1ixkyDJyYlNQjeKG5my7GEPPtO/h1DFphGAv9lRyMuM8JBHc4K09o6GyQFVuoVuVMi
	MVs7/HcQa+RYx22/YLgqtXEjyMZXAJwzG7O9nua+PybI19832ZaZ49uacxFYQHDFPAcpWFw7BFQ
	hbWp5w/zz+MTBqVcGIg/rvbcWRvWsgZZLesmC9+Cu6AfJ8SRPDuaXc9ssRGp1Ht5QOKUDFTQPBT
	iEqlnRvE3zzYOa5hCj7IVSfW2Aj5AZ7TIPgnM
X-Google-Smtp-Source: AGHT+IFuCZkH4xeasbCOTD5CcnTc6ihgAt5Zdq3ygLNU9i8ZplsZptkliPo9c4TLjgw2kFqHys5MQQ==
X-Received: by 2002:a05:600c:4ec6:b0:46c:7097:6363 with SMTP id 5b1f17b1804b1-46e329b441cmr101671235e9.13.1759010755894;
        Sat, 27 Sep 2025 15:05:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb264sm12463730f8f.20.2025.09.27.15.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 15:05:55 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sat, 27 Sep 2025 23:05:37 +0100
Subject: [PATCH v2 3/3] printk: Use console_flush_one_record for legacy
 printer kthread
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-printk_legacy_thread_console_lock-v2-3-cff9f063071a@thegoodpenguin.co.uk>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
In-Reply-To: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759010750; l=4038;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=iRRIRcCO6to7StUlEIsN+miyvowwCexvmjuZd0Cvz0w=;
 b=DN9wdv7NhTa8M+k1N+NFp4j/1vsnnKnat2zU0oGYNgaJVWHU7TuH6TNFB9zxZdnMWEm9YhOnU
 twNfh54iPwWDU9KdnkTIAHIWEjs5y9uFC56ZHAS/zekM+2QqZz+nr4H
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
 kernel/printk/printk.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e2c1cacdb4164489c60fe38f1e2837eb838107d6..2c9b9383df76de956a05211537264fd6e06366da 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3668,17 +3668,29 @@ static bool legacy_kthread_should_wakeup(void)
 
 static int legacy_kthread_func(void *unused)
 {
-	for (;;) {
-		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
+	bool any_progress;
+
+wait_for_event:
+	wait_event_interruptible(legacy_wait,
+				 legacy_kthread_should_wakeup());
+
+	do {
+		bool any_usable;
+		bool handover = false;
+		u64 next_seq;
 
 		if (kthread_should_stop())
-			break;
+			return 0;
 
 		console_lock();
-		__console_flush_and_unlock();
-	}
+		any_progress = console_flush_one_record(true, &next_seq,
+						&handover, &any_usable);
+		if (!handover)
+			__console_unlock();
 
-	return 0;
+	} while (any_progress);
+
+	goto wait_for_event;
 }
 
 static bool legacy_kthread_create(void)

-- 
2.34.1


