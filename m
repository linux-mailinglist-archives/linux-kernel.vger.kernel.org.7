Return-Path: <linux-kernel+bounces-662029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A6AC3485
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C6B176479
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3214E1EFF96;
	Sun, 25 May 2025 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M76wjtDX"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F61D6193
	for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748175595; cv=none; b=F83NFsk+bsITd87MNuuQuFIJ+zC3X5RUV6/T9CHqXsi+XNkqGqYgS0eVXpv0CdBSU0XUevkxU9FXdRGf0ilci9Cue1N+uINRZjr/Y4uXCerpOCLATHUy8yI2LBagtStP9wMkTWAey7t1Rc2uYTvr2b2uOD5PewPDFrSAABoDyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748175595; c=relaxed/simple;
	bh=k8bpytRhIjg65Dymyou2/42y77FUkadB2v0ksKilpCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sda8U9UC5PDVV7GBXzpFg8Lhz5OdM8eajJD1Cjh4xRO0PED8c52BqcYUS6a5RZJiomnWdTpMeubG7YcKYGwvJXe7jO7xftEQiOrKtzKUXvqYrE5KTzM3dU8xpzuOUcgvhDmtA2h/fsCFjCS/M1aSYoCAVQr26OYyXTPwxFAufDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M76wjtDX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso733235a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748175593; x=1748780393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs1otaOuID7K+veTGJFrrE2AYNFfpP6q1AeerfGRbo0=;
        b=M76wjtDXxirF1wi4vjeMx6iU3a5lxgQPkuYyShhUSzn+/mT7QcQgrC0bC+smRRmnzF
         YJlPwezBOwPanZMgkRjTJacNeB08R6FrVsxRpeKA9o33kJt29NZhIUHw5VPS5hPcd70m
         03g7Tqxa1bO/EPAPYb2v7izy55BQPL2stzzytkjW5OWFCVv4tWrEmUODyof1ikFd1Cen
         hRhuza+5TSriGd++TGLoCWANW09BxPQJutbqz7pnFlGfMoi3Fg3PMFFNr+rQh80zkBcN
         PdhPMoYhGEX8eYs7Paj9gvz0zQ2yRqZMOHPOjRdkXOlGTOwEojH/fjmgx3pSfTe6oqvG
         74IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748175593; x=1748780393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qs1otaOuID7K+veTGJFrrE2AYNFfpP6q1AeerfGRbo0=;
        b=wiPgWVcsmp4TInokeyuaVcamtQCfu0aNhoA6zguDQbTCVkOupU++xgQzuMV4b6gqIC
         8jfvi4K4APqWVxC1444jsS6XcHX5xKEKMNFg+yy6mZ+QS51GUqaUnJU+154qI1CrPCNG
         kHZBa7DKKURpl5eMomulYGn0CE6mNpOxeMzXLakwpxCIA2SqH1ri+X2B5hQ0mVH8JtNA
         C0ccomFpPlsnSWYAHmwQmC4qtwqUrCmbXSJzXlvQyODM2Qndo9X/Tk+/XiwpwpFJDZ2F
         brO6nU0ErseJZ4Hu3QR5Iya/8W8ebDjzYsrEDWTBhUP59kDWPuR9G6C5NljL+64aKstt
         284A==
X-Forwarded-Encrypted: i=1; AJvYcCXf6vcSjHOUlRtbgC5m0+s9JI2LyDAFFzYa0unVCbaTMlj3xXWhQ5M7qIQGmk5jRbNM+3WgqWKXyr2OM0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyO/a/tjjHmgTB/BvlSs5dokUG6j5F4fc5FdfXfH/Kp7TJllkX
	5FKUOvFqVR1tIVPmRbnARHKDRuFQPWAhvaj7zlh9/JlVJ78iXgduU1c+sL+JsrKwmJ+qzr1Vlmz
	34TKGDbE=
X-Gm-Gg: ASbGncu+tSTNC3iEc8iHLoSzwGFBpC3TMwEWC6yNjBn6bEUBvRWwvtQmYx2DMOOCuh+
	vsC+IjVwSenSPSJ98fn5qp2ItMa0mRfQFfK7UeJVhNHXeGeT0YJwX5+TBaFashLlATlGQGefLRU
	ZbcM0O6i0lMx6EV7D7UGNgeNmjDnDbLu5Ca7czVfc7nwfUIx4sh/kytzvMSBqjVddgpN9JLghE8
	hEu0Mul4lMktmY47pMypuGoe1DsD+dbUohOVa8ozRTJ/3gFbSMENY/sSqGub6d3uW26DQqsIHO6
	ZI+wvBLZca4UPXW7ZDjj3FN1MvFiVNP/pFs5cjCanEXrayF8FxXQksbp/vStnYBwyhUQuzDzQK4
	qvSSz/VK29PMmxcA3pc96BQ==
X-Google-Smtp-Source: AGHT+IFyRGBaMCJlnglvDJ1QINEq/Rid7XwQ3bZ100bIMRxJ17N2vwhb8uDeMotqbQysB2fT5MenSA==
X-Received: by 2002:a17:90b:3ec6:b0:30a:214e:befc with SMTP id 98e67ed59e1d1-311108a2eebmr8728139a91.27.1748175592730;
        Sun, 25 May 2025 05:19:52 -0700 (PDT)
Received: from FRHGW7W029.bytedance.net ([240e:47e:3070:2d85:7919:a3b6:570e:7716])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31126609ae8sm2218760a91.38.2025.05.25.05.19.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 May 2025 05:19:52 -0700 (PDT)
From: Guixiong Wei <weiguixiong@bytedance.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	weiguixiong@bytedance.com
Subject: [RFC] watchdog: Introduce panic notifier for watchdog device on kdump
Date: Sun, 25 May 2025 20:19:39 +0800
Message-Id: <20250525121939.43112-1-weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog device is not stop after kenrel crash. But the kexec
kernel may not enable watchdog device. This will interrupt the
long-time kdump process(e.g., TDX VMs with large-memory).

So introduce panic notifer for watchdog device. When kernel crashes,
the handler invokes the watchdog stop callback, then the kdump
process will not be interrupted by the watchdog device.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 drivers/watchdog/watchdog_core.c | 22 ++++++++++++++++++++++
 include/linux/watchdog.h         |  9 +++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 6152dba4b52c..7a1ad9935bf7 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>		/* For of_alias_get_id */
 #include <linux/property.h>	/* For device_property_read_u32 */
 #include <linux/suspend.h>
+#include <linux/panic_notifier.h>
 
 #include "watchdog_core.h"	/* For watchdog_dev_register/... */
 
@@ -155,6 +156,22 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
+static int watchdog_panic_notifier(struct notifier_block *nb, unsigned long code, void *data)
+{
+	struct watchdog_device *wdd;
+
+	wdd = container_of(nb, struct watchdog_device, panic_nb);
+	if (watchdog_hw_running(wdd)) {
+		int ret;
+
+		ret = wdd->ops->stop(wdd);
+		if (ret)
+			return NOTIFY_BAD;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int watchdog_reboot_notifier(struct notifier_block *nb,
 				    unsigned long code, void *data)
 {
@@ -334,6 +351,11 @@ static int ___watchdog_register_device(struct watchdog_device *wdd)
 				wdd->id, ret);
 	}
 
+	if (test_bit(WDOG_STOP_ON_PANIC, &wdd->status)) {
+		wdd->panic_nb.notifier_call = watchdog_panic_notifier;
+		atomic_notifier_chain_register(&panic_notifier_list, &wdd->panic_nb);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 99660197a36c..2a74373aed28 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -79,6 +79,7 @@ struct watchdog_ops {
  *		Replaces max_timeout if specified.
  * @reboot_nb:	The notifier block to stop watchdog on reboot.
  * @restart_nb:	The notifier block to register a restart function.
+ * @panic_nb:	The notifier block to register a panic function.
  * @driver_data:Pointer to the drivers private data.
  * @wd_data:	Pointer to watchdog core internal data.
  * @status:	Field that contains the devices internal status bits.
@@ -107,6 +108,7 @@ struct watchdog_device {
 	unsigned int max_hw_heartbeat_ms;
 	struct notifier_block reboot_nb;
 	struct notifier_block restart_nb;
+	struct notifier_block panic_nb;
 	struct notifier_block pm_nb;
 	void *driver_data;
 	struct watchdog_core_data *wd_data;
@@ -118,6 +120,7 @@ struct watchdog_device {
 #define WDOG_HW_RUNNING		3	/* True if HW watchdog running */
 #define WDOG_STOP_ON_UNREGISTER	4	/* Should be stopped on unregister */
 #define WDOG_NO_PING_ON_SUSPEND	5	/* Ping worker should be stopped on suspend */
+#define WDOG_STOP_ON_PANIC	6	/* Should be stopped on panic */
 	struct list_head deferred;
 };
 
@@ -146,6 +149,12 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
 		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
 }
 
+/* Use the following function to stop the watchdog on panic */
+static inline void watchdog_stop_on_panic(struct watchdog_device *wdd)
+{
+	set_bit(WDOG_STOP_ON_PANIC, &wdd->status);
+}
+
 /* Use the following function to stop the watchdog on reboot */
 static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd)
 {
-- 
2.39.5 (Apple Git-154)


