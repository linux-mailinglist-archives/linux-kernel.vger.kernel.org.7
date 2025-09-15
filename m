Return-Path: <linux-kernel+bounces-816969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765C2B57B84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C041A24C32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790230E0F2;
	Mon, 15 Sep 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="I+QRWG+K"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE230DD19
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940203; cv=none; b=LJ3I59Va5fyZtGWjLPV7U3LkEmAarm87GAX4JNRnvFbmTxA9IMr5k3r1muI+X0k+I/xvFQHKWElxTOaWVFj4XTzQ9PG7UErPlboVGtaPjCby598Fu12u2FUjL9COIvIVyoswUtBVLCcXN2VXf24YSU3FhrHPYvt4/NzY351OGpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940203; c=relaxed/simple;
	bh=KQsZ7wbrasFYh0HAkLIVZmFlfxbgs4SQOHZ/1seu2OM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a2Mh+8qMNXFykY4t1KG9WzBOnA0XvGAYC6P2AK1KNqnqTkf7lPrZ1k/WWS9WDGZJTCKsnuGMBb1HMoEmlNZmPCTsZeBLVd41AO5lzrMXExoTgQ0nQSVk4rtZLMMb8P47Fxy6ee83mc7wy090sdkpBXALNvqcXEsk3bAN6N3mtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=I+QRWG+K; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso33155635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1757940200; x=1758545000; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZx8ezcCR0TkH1+KA5xzMhiZbK7cxbphMWhXf4EoaKw=;
        b=I+QRWG+K+f51rsVl2hP4a2XIeoaj9gPV1HTDSM8cCAlS0+KtwFpFRKPA3DoMujD+bG
         qH40G8swMtV3d7h1OMYLmlZS68qSub7yq1GrKjs43TcoR5lDIyrlc5NqBRVfvbFbS7V7
         ohtLTJSZmLkk93viGeZjnC4R2oo6Db60ftWKgI1xXX3Vhb/5uhY1mrJePxkTUPXrPhS1
         zG/Mt3m2bdwn0qoxIIUGv6lkiFSii6oWHJkOqrzWAJSnLD3Cm/wh2WrCu0LowQbJcVHA
         ibd4nRKOMRhJzN5LUEkLB+o2mtu9ELL4ru9pCSKfckb1977E7yGXX4NBvfcQkxfLXCUb
         j3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757940200; x=1758545000;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZx8ezcCR0TkH1+KA5xzMhiZbK7cxbphMWhXf4EoaKw=;
        b=H/e9ubswJ8Y7Rc+XEGa71ghSz2Xvig6tPwMl7QJr4Pbhqdh0syV2do5h+lp8hJ88Lt
         mIZMTaJTmi6uSu7827oASOeOkt9sf0ogULgv1kaCY13gYBtAGHJ+IkBM4KTGlsLRYnir
         tKjB6AO++Ac4wgSmk6Ji5LVF6gQ23cC5Fq2gDPBLwbF+W6svin2aYDiHN85/AxvbtDFT
         sevmeE45+e1GWc/zaOVTQWEJOoZv5lKwm1PxY+4imG54xCrXHsvzWjDCNWApr/uC82jE
         KjCJxK3YRyxH46A8MfPomsb/r4TT9gaUcTUwKzAhKz8WtkrTIa40qk1g2LNTpmd8BB8W
         eIow==
X-Gm-Message-State: AOJu0YyKUCQ/q5fGqEoT/np0ZZQvUXHxNMi17+FHEiTMZd48JS7Cbvhl
	sBV72Z605hGq8t2WOIOF8tThyB8szbyzGRmfcJtqwZiF3O5GycMRjtO5JO1lj7sXVQmXQ7KREBo
	/FBRwe/A=
X-Gm-Gg: ASbGncvwqET69V0aqo0vq2x7kR74qAtX58L7+povy1mcgvTPIHKgM38n08SEdmNreCY
	SpBGQx4BvMV6+CvBwEmoL0jaYUTIxpAYsDhYc9feGzytP2vBmsVAXaS8DmlFNqEylQ73v/SU2f0
	KukNqxrWOgcZZ1sK74sxFRmaX0i9fS/LcZ1SiwJxXQD85wPFID7cs+HHPe6fw4l5ioO1n+oCMp4
	KhAVdxFBNAjEBPUL07VdP8mT+8DI7jM78JPxfm20KkuOV6CpLu13aGcv+0Pr7zOwgKBQ7J2gGFx
	eCiNyE8/XiA6/D/ULcddCsQ2ksi/faZZgR/FxUvevrcbzmNGDriiFCYJqTZRC4HXHvcqEo6w+0v
	0ctAQQxwCRMIA2/MtOA5i+vOBqPusiEZAR6lywuVtTOTx+r0=
X-Google-Smtp-Source: AGHT+IHWtqps3Uq//Mh/z4U79R+xEhoAjxO2ioWl2B7d+s4BuVweCWGhTOjkH3t3hFAmztUcd3H2cQ==
X-Received: by 2002:adf:a385:0:b0:3eb:b7bf:cf3b with SMTP id ffacd0b85a97d-3ebb7bfd11amr932925f8f.9.1757940199596;
        Mon, 15 Sep 2025 05:43:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b4222sm178839265e9.20.2025.09.15.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:43:19 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH RFC 0/2] printk: Release console_lock between printing
 records in legacy thread
Date: Mon, 15 Sep 2025 13:43:04 +0100
Message-Id: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkJyGgC/x3NQQrCMBBA0auUWRtIgkXiVvAAbouEOJ20Q0NSJ
 kWU0rsbXL7N/ztUEqYK124HoTdXLrnBnDrAOeSJFI/NYLXttTNntQrnbfGJpoBfv81CYfRYci2
 JfCq4KIP2Env3is5paJ1VKPLn/xjgcb/B8zh+uXUJaHgAAAA=
X-Change-ID: 20250914-printk_legacy_thread_console_lock-1c27f59bf990
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757940198; l=2872;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=KQsZ7wbrasFYh0HAkLIVZmFlfxbgs4SQOHZ/1seu2OM=;
 b=wMyIo5UGKa9z9xa8C1GJj1/MDA8QqPwqbgQOAWOsTBaSUydVL7PaX9FZB0OcqQXyRPuemsYG8
 D/BUgRNZUeuC0mT5n+oN4/xZG6Ot6JLo4RPCDGhI2ORUHNFocZONbi2
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The legacy printer kthread uses console_lock and
__console_flush_and_unlock to flush records to the console which
holds the console_lock being held for the entire flush. This
results in large waiting times for console_lock waiters
especially where there is a large volume of records or where the
console is slow (e.g. serial). During boot, this contention causes
delays in the filp_open call in console_on_rootfs.
   
Let's instead release and reacquire console_lock in between
printing individual records.

I've tested this on a PocketBeagle 2, with the following boot args:
"console=ttyS2,9600 initcall_debug=1 loglevel=10"

Without the patches:

[    5.276850] +console_on_rootfs/filp_open
[    5.311995] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
[    5.313665] probe of 2b300050.target-module returned 517 after 1179 usecs
[    5.315279] probe of fa00000.mmc returned 0 after 263618 usecs
[    5.383935] mmc1: new ultra high speed SDR104 SDHC card at address 5048
[    5.394496] mmcblk1: mmc1:5048 SD32G 29.7 GiB
[    5.417837]  mmcblk1: p1 p2
[    5.423320] probe of mmc1:5048 returned 0 after 36996 usecs
[    5.425531] probe of 2b300050.target-module returned 517 after 1312 usecs
[   15.339051] probe of 2b300050.target-module returned 517 after 1062 usecs
[   15.424672] platform 2b300050.target-module: deferred probe pending: (reason unknown)
[  145.531229] -console_on_rootfs/filp_open

and with:

[    5.090776] +console_on_rootfs/filp_open
[    5.316895] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
[    5.318994] probe of 2b300050.target-module returned 517 after 1092 usecs
[    5.320578] probe of fa00000.mmc returned 0 after 333601 usecs
[    5.390914] mmc1: new ultra high speed SDR104 SDHC card at address 5048
[    5.405461] mmcblk1: mmc1:5048 SD32G 29.7 GiB
[    5.429104]  mmcblk1: p1 p2
[    5.434603] probe of mmc1:5048 returned 0 after 41200 usecs
[    5.436515] probe of 2b300050.target-module returned 517 after 1040 usecs
[    7.203025] -console_on_rootfs/filp_open

Where I've added a printk surrounding the call in console_on_rootfs to filp_open.
For reference, where loglevel=1 the console_on_rootfs delay is negligible.

Please let me know if there are other ways I can measure the impact of this.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
Andrew Murray (2):
      printk: Introduce console_flush_one_record
      printk: Use console_flush_one_record for legacy printer kthread

 kernel/printk/printk.c | 202 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 147 insertions(+), 55 deletions(-)
---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250914-printk_legacy_thread_console_lock-1c27f59bf990

Best regards,
-- 
Andrew Murray <amurray@thegoodpenguin.co.uk>


