Return-Path: <linux-kernel+bounces-764198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3740B21FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A09504C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB812D7803;
	Tue, 12 Aug 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB48C4KB"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86381A9F99
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754984524; cv=none; b=ejk6sB9Ql0S3cNGtkr+Z969Aq9ovPlXAWtIQEC+WP3CjDfAQqrEtws1d9sGknCWpXLNcv8VS6JJ0To4QKinTd/O+wTe5VWMXgoGU2+v8MENxLn9+AVk046aWecR1OoD75mSaHmeeVN9w54FkAVxDY1e44Vi1Xs/3TtqOEqNSFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754984524; c=relaxed/simple;
	bh=+49DWXrfhN657dha6xI2fqhhRcYzq0kFnIT7YL3Gtew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+122+AioXOvxZHJN06vB4lc87MDU5gMj9hTnrP1ZrXCUTYsRrUXV1LLuPiUm6Tm+HfmeWJvK+lTEEWANjUmob0GuH9gkhQ/rb8u5P7sw+er2Et/JBiZ7jY+J0Eh+ach9wb8MuYiR3lslIKJCU7IuSVoM2VPrOWNROW57KHwroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB48C4KB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-321a5d6d301so1480106a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754984522; x=1755589322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2usP4TJRBl0R4HFxzOwnETO15gJ9qQezUfLPVB9501c=;
        b=gB48C4KBzIwvnmu2Ixjxqi+F1icgSou54MWnOnxOHfE7cw6OS/P+HFqY0rtoKLNZwM
         h2iGXjGBOgKQDSEkbgvtIFA6sPns0QU43R7J684xgwQRpke6O2EWH72bTDUXJH2x3acF
         CoqynaHP5icDHds1RYBKOlmquqsfaVF5l66lDM05nOiizmc9Tm0AmsC9Q/nJdg0xEFxi
         5JNE/DWYQq3yWLwIXXJND4W3SzKstCDNPp3AbB6A/yGCBKjU3DUnfFjo57X9BX73319b
         7cD9BpVza80rhfklAiHP9+wGdoHZLbbc+FwVITsQoSxwC++iHfB1PrO+XqfyScEkBhW+
         1URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754984522; x=1755589322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2usP4TJRBl0R4HFxzOwnETO15gJ9qQezUfLPVB9501c=;
        b=goyk9H/WqbeJotOfNujfNswdDvW736vZDMKIjbLOcI6CNJbDONvHkUzikIajZTdPLz
         hjxiDNy0z6f1zm2c2mV6QlKaZJyJDoAroBTpyJTsdTwjsRmawvd/Tun3IqOqhig2CXea
         m5S1SZTC1VeTOK9m1oRrmov8VjOUqRs5hXL5empG6T3msu5L16Yt/43NtICjOPOzcUng
         IecrEHn4Rq1M4ofXuCUzna4vQRNoFqCT4BJh9PGRQiWA/mfvtJnw35sBK6/nG8R10IxX
         jniuivJkhuGq1NGWkaZazPLC748nzeSEMxZipy+hlCyE+6lD4ffMEU9dGfkOh84u5crT
         yu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8yOBkHaf1/5VnfB0tpGtsCr0IamRTPLQD85edvzBnExvaBLljMyERpGNqKiApd9eKGtBUIo14NluEVD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXOXIbclkiNXR87RH79VlD3pY+YMBLK7KTgNV3x+JTuFz/qF+
	thZcwulXGT657tqiY+praGtkeApBheXWXiV5x6GWLPbeyz4KyhN2gyDY
X-Gm-Gg: ASbGncvOfChWaQ2r5HwsLDGfQ18OHP52j+g9qJix+fxpM5O74cm0YnQJMuc9lVyqT8K
	A2hXkgMLOn3Ek0MU/M/RLHqymcimGdnB6Y3zuJRRx9YbH3KJ/kgF2YIOPtrxeW9+iTlqiSNrgDy
	ERh/INKqLNmZcSgu2nsgSEh1G/T3ubvcBYpSuBmJSNUow9JpSt7i/I0geNTZKCOizcuemXzxFGG
	eBOUpkjvdmSbpTVVteQ1r+RTuTdmL2jVzsEFzbikKGM3xA8/P5AotMq2Ryuo6b+3tEqmRE/WACP
	zF1Lc0fZPntg/hIXqDFQ3gOa25tHwpDgXBFB36IDMsp9qWPnE9R6MylvcOGKVv7gn0HqroWGsvZ
	BBpq0+lFZeA9FyK4li2tQZnJ8Wyq6xLIwBM4XD/belQ==
X-Google-Smtp-Source: AGHT+IFG26EXpuER/wCjLeHOwcnArS39F+L5FUFGkrr1EOswZWiAUtIlDmGAln1pS7Xn+ypZt9hzxQ==
X-Received: by 2002:a17:90a:d603:b0:321:1680:e056 with SMTP id 98e67ed59e1d1-321839ec009mr23028178a91.9.1754984521824;
        Tue, 12 Aug 2025 00:42:01 -0700 (PDT)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe29:0:2:4699])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321c25f3063sm1234347a91.32.2025.08.12.00.41.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Aug 2025 00:42:01 -0700 (PDT)
From: yaozhenguo <yaozhenguo1@gmail.com>
X-Google-Original-From: yaozhenguo <yaozhenguo@jd.com>
To: tglx@linutronix.de,
	yaoma@linux.alibaba.com,
	akpm@linux-foundation.org
Cc: max.kellermann@ionos.com,
	lihuafei1@huawei.com,
	yaozhenguo@jd.com,
	linux-kernel@vger.kernel.org,
	ZhenguoYao <yaozhenguo1@gmail.com>
Subject: [PATCH] watchdog/softlockup: fix wrong output when watchdog_thresh < 3
Date: Tue, 12 Aug 2025 15:41:32 +0800
Message-Id: <20250812074132.27810-1-yaozhenguo@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ZhenguoYao <yaozhenguo1@gmail.com>

When watchdog_thresh is below 3, sample_period will be less than 1 second.
So the following output will print when softlockup:

CPU#3 Utilization every 0s during lockup

Fix this by changing time unit from seconds to milliseconds.

Signed-off-by: ZhenguoYao <yaozhenguo1@gmail.com>
---
 kernel/watchdog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 80b56c002c7f..9c7134f7d2c4 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -455,17 +455,17 @@ static void print_cpustat(void)
 {
 	int i, group;
 	u8 tail = __this_cpu_read(cpustat_tail);
-	u64 sample_period_second = sample_period;
+	u64 sample_period_msecond = sample_period;
 
-	do_div(sample_period_second, NSEC_PER_SEC);
+	do_div(sample_period_msecond, NSEC_PER_MSEC);
 
 	/*
 	 * Outputting the "watchdog" prefix on every line is redundant and not
 	 * concise, and the original alarm information is sufficient for
 	 * positioning in logs, hence here printk() is used instead of pr_crit().
 	 */
-	printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n",
-	       smp_processor_id(), sample_period_second);
+	printk(KERN_CRIT "CPU#%d Utilization every %llums during lockup:\n",
+	       smp_processor_id(), sample_period_msecond);
 
 	for (i = 0; i < NUM_SAMPLE_PERIODS; i++) {
 		group = (tail + i) % NUM_SAMPLE_PERIODS;
-- 
2.43.5


