Return-Path: <linux-kernel+bounces-819916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA7B7DF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 213C84E157E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6E2F3C05;
	Wed, 17 Sep 2025 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVHCPY2K"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458028724C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758078714; cv=none; b=lOhArU5t6b/ZthSQWl0w4OQ1gLRtyqm4gLZ2bufJiRsFKNpYUU3uC8ouuBjh74UJVMW0zqYELoegKFGXyVw+bflnuLzLT9iauM6wIk+ZcVfsxB8cIpnPcnLV8nRCCApt2UMqB6P/ncixT2OIBXFjKXCbqnoVNR6wXXkh6/j861w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758078714; c=relaxed/simple;
	bh=5UBef9vu2NhcFxgKr+tAHWOrdUDeityEZoYhhezBZLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G30v966cV+ybhnD/BdjfU0iG8Eq4wSC4oKppqE8EDbfXd0Nx5XyjxhcPpoSfGlEDfTBTDdOkGBzC5xMBk4IUih71ZfB2Z5DT3szPulZ4weB5whnPeQUPYWdZnfgvwm1hnm9MmNQaEphuR7aOmI8oDumLF5gsWIeTKiu5ZmWd2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVHCPY2K; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so369127a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758078712; x=1758683512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2CbSn2515ReZCKkrbmHpp+wPD4QyAtOFfge6YaI3IA=;
        b=gVHCPY2K4K7KnkZRQttji3zUAyB2i1XkuRzILPoIdEXlj0Vd8DASgjvFFo9mhVMt4N
         ZtbQPMcb+BRsXXTNB+GJXK/9YmDFJrE5XkwVaWt9A/PFNoLytPq1dbHbyNk3tyFiQgZf
         O9jB4b6Bw66HTGxqTZqLi3P/Pzkxk+kHCAT96pvta9JxRh2mKJ6Uyi3YFynOjUJDKLTj
         Dysbuo6Eppax3ng2RXRRVV/rEFFFxercCkr9D0dbB0iMO4osgb1f8JFPqHyZrL2eH1JL
         d4PaX62gOJik1WPmsTiz/qBH256Hd+5FMQNHe3p2Wv2tZvJXzdbxjqm40K665EB18Dej
         2ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758078712; x=1758683512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2CbSn2515ReZCKkrbmHpp+wPD4QyAtOFfge6YaI3IA=;
        b=KUlym8Udxpoaa5Y590NKS9G4vJ12rmVnGNRiDl9PiBnPFSepIvCprkzC6T9TsxqBfV
         YmOOXDL/YXR6PpTPmMPalA4QvfD2mLPaYaGWo1I+jLjClZNkvHUyY5JBM+zUE6ZlSfxQ
         2d5qTxVcMvbOgcCKpQhkqh62GCH3r0vzSE4icTosFJSVP3j5ThzZLjVYcTY6C2dYdukS
         rf0bJoLLsRz9N++VnNda060hOz7LV4p74k7bYAR/2wldmrDfmXV9JQsmUkK6x34WZQ6e
         nXFYsI8xvPB7Hp3zviOSuz166K/9DcwDBcVTqR4N/GyX90hFvvqclRwVrnpSq1bfGlQ8
         ISww==
X-Gm-Message-State: AOJu0Ywgyjpef3E/+TU8cdMy01D9IUo7HIgBidFYqsJXmtuYeVbCyil3
	cw4dqzbYxzgjVbrJRZ28NfihswB48OZcGlfD2jY3zQrHE03dHpk/UiHV
X-Gm-Gg: ASbGncsF6zVchggqp9saTDDIwxbrSbR5D9oXFcanGEWGZZ1awhRalDDCeNHGUVhaKAW
	u0L6lEG6n5I9FMw6L1aZjCM05gPZkZ5+EgWvNigLy1HVyXkXo5wTKakeKVfC+M8kGVhh6YHg71/
	eS5VZnQKbjNWiKvZZntDxwZUZO3g9ZJwImZuVBMA+FWT4o2alUzrGfR7GtCoUHjyzgaJVxk/Fgs
	tbcNGi8QFBsTLEdvKegbJ/r1pKTa0edvaZJwzm3613m18Xx/OI6ey/NfFytqeF7CigfDIYMC/T/
	e91vq9OcMGFdq25MkUprCDtF39gx/pBRgepXS5PR60gIJEghi33g5/5jLS8cFLor6YTwqb8PHqx
	C7PfCwl2mNazWGnQLozGMbOknv1zUCoynNRpBgkY=
X-Google-Smtp-Source: AGHT+IFxgl/BG5mxjVo8thexM0dPU/TMGuSPr1BRaMhSuK4W+0tVzFU74sMYhTzjjHSX4kIO/Wb12Q==
X-Received: by 2002:a17:903:2f87:b0:24b:1585:6350 with SMTP id d9443c01a7336-2681095771emr8388975ad.11.1758078711935;
        Tue, 16 Sep 2025 20:11:51 -0700 (PDT)
Received: from cortexauth ([2402:e280:2313:10b:d917:bfec:531b:9193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-265819a6212sm82217505ad.57.2025.09.16.20.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 20:11:51 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com
Subject: [PATCH] drivers: core: Fix synchronization of removal of device with rpm work
Date: Wed, 17 Sep 2025 08:39:55 +0530
Message-ID: <20250917030955.41708-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reports a use-after-free at `rpm_suspend`, while the free
occurs at the `usb_disconnect`

All line numbers references will be for commit ID
d69eb204c255c35abd9e8cb621484e8074c75eaa

This points to a possible synchronization issue. In `usb_disconnect`
there's a call to `pm_runtime_barrier` but it does nothing more than
acting as a sort of "flush" (while cancelling what's the pending
rpm actions not started yet). There does not seem to be any increase
in device usage count either in this stacktrace after this stacktrace

Then we have an eventual call to `device_del`, which further leads
to a call to `device_pm_remove`. No code synchronizing in any way
so far with the PM system after that `pm_runtime_barrier`

Let's say now that the timer expiration queued work for `rpm_suspend`
executed in this period of absent synchronization. We can create few
interesting situations here, I will address one

Let's say that we unlock the `dev->power.lock` at `rpm_suspend`
work at `drivers/base/power/runtime.c:723` and then the code
`device_pm_remove` proceeds as normal clearing up the device.
Any further calls are not going to cancel the tasks we have pending
and since the lock has been given up, we will proceed, and end up
deleting the device too, which will lead to a use-after-free
as observed.

So at the device removal, we could add a `pm_runtime_forbid`,
followed by a `pm_runtime_barrier`. This leads to the completion of
any pending work and forbids any other new work to be added.

Once we return, we can do `device_pm_remove`. `pm_runtime_forbid`
does not seem to influence the behavior of `device_pm_remove`
(tho it does lead to a call to `pm_runtime_get_noresume()` which
touches the device usage count, but it would still work the same)

Reported-by: syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c905ab800f20cf4086c
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
 drivers/base/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..616fd02d18ed 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3876,7 +3876,13 @@ void device_del(struct device *dev)
 	device_remove_file(dev, &dev_attr_uevent);
 	device_remove_attrs(dev);
 	bus_remove_device(dev);
+	/* We need to forbid and then proceed with a barrier here,
+	 * so that any pending work is flushed 
+	*/
+	pm_runtime_forbid(dev);
+	pm_runtime_barrier(dev);
 	device_pm_remove(dev);
+	pm_runtime_allow(dev);
 	driver_deferred_probe_del(dev);
 	device_platform_notify_remove(dev);
 	device_links_purge(dev);
-- 
2.51.0


