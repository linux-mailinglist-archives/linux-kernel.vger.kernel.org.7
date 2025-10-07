Return-Path: <linux-kernel+bounces-843826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEACDBC0599
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD675188C62A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AFF2253A1;
	Tue,  7 Oct 2025 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PqDoZN3I"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645792248B8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818965; cv=none; b=gkyf2uKV7ZSZ58gfJBV6HBeDEW1zhYl2IwdhIYEggGbK/I1PGUOJhoWgaRaR80Gtv7eb8qxSpAX60UENTfa1+CWXdJtREkrf2lN4uxtzEuL9CbxvpW33gnusCx3oLoU1yYs+4U+oQojrqTIupiCZClwDQvCV298cpUILVdUuED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818965; c=relaxed/simple;
	bh=uAmhgQ3KcHHqItUYD3sg9xQu/w0vMlXFEkJv6A8Zca0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bG99JblTE3v9b1CSH8atHJw7jXJalwdkfFt3HOi85WQImr22l+gASWyesCjlAHfQLt9J6fpmZVtxj6+f2ncImZj2BNiJzVGVqcpchI0CU8lsCEW4HZO3U2ejYZCgbMsFtVhXgelkLuWw1lz9QjbWdMQvGKQfFP9Ia44wnGCMEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PqDoZN3I; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so4914516b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759818963; x=1760423763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ubg0Ay//TT+HCi0Uhp5LLbc5vBMN2YTOmzPGYDLqqyQ=;
        b=PqDoZN3IDgO9VvaXrLCG+jkb4uRxVeuMkcN3Wn1FJJnTP9jwbqg1KSlcAxEOOPe19c
         heIctDefINfeCOhBxOIor/xshu+lyjwzsZPTVI/ixlf5cS+FKhEUZaqUgDuewdARZUFy
         Lk16oxqzXy9NuVp7ytXQ6i0Cytm789xF6hWYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759818963; x=1760423763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ubg0Ay//TT+HCi0Uhp5LLbc5vBMN2YTOmzPGYDLqqyQ=;
        b=oT7qe2WeWcL1IAhOTCp/rIRCFWkk+uOdbgKrOFnHjEBf4uyrbNhHFeO87+QgyD4qvI
         Oz5c94hyAplC0SJI0bVJP4XMhJR8esZvtjXxw4arHLMFMuai4uRKXlURPZfX+t2kUsXj
         RqW0hTx6JJCkduU0vo0exabKpYLpiQvt/MB2mvNCe3Zcdxg1BnlMduzFyH4Xs8GG+vc6
         MRLhcSQ44xhJgT04JY3WNNnmMP72tRrYXNyV9ejRTZ4kM7VV/cLtF+PpdxCXeve6v40f
         qEfZ5mp6jqvcDRJSquyysf+Y/FwW65pnU0eHfSLvoievAbbp7sviuomq+70u01chMPbS
         ulzg==
X-Forwarded-Encrypted: i=1; AJvYcCWvOD6wqBOWahufl1GFtEU3/hc4xpPZ2K34E9YPTs7oYw5ineY6KUHQTXN9osh3fI3HqMasxKwVRc14360=@vger.kernel.org
X-Gm-Message-State: AOJu0YygEBH1nueiO3Gu8EfPMijHaLlCI4eYwCqEtTDMeoV2j3b3O78F
	+aPIujM1Ut1fIvP4X7g1WPvb5VUqpvv4HFwdd1NU3TJ+ZUs4VHi/cGa/BlUMQMihuA==
X-Gm-Gg: ASbGnctd7BHRKNVC3SWhyXBwKvM2a7DJlF97TvSTPmMDUxmbSQgDMhcEnsnp01bVLn/
	ngwuqYKkI53kKGwrfMulg5y7ClQjMp4IoWSjIXsOBqLa7XHgvKyD2h0YxJ+F1vQbBVfy9jL5X3d
	PS4+W/JSqTHwDXbDjdIxD/VtfM5eGhE2cVY4RFRd2ElBGqj8/WYC8mzZM+rlhuq12PO7X7gipxQ
	U5z5O4ZTw3gvnpd0BaP7AhipOHrhSNvLO3k5NdBSYrgZdkwYigyiUCZyAWol8xQ7pJ9wpj4q/pI
	Pg4JAJXCO0CvE38d6zW3MA3w053gtuk5oMgJ8WFMzYFWjiXgT+/e42HzFaOJ9sc7CNKjPjfe//u
	fpCjIoSG7tHlWCr7Y0b2JEOnVMkuaJZJLIlY0XidZW3glP4gFlK/OnHqRn3HCtcyKIZprcYSp
X-Google-Smtp-Source: AGHT+IHvsjv1a9nNOfsdkOgaNDaeaTcF+IkFphTj0pje34rtST+ioTAIoakbqOW00hKZRXsG5OCW2A==
X-Received: by 2002:a17:902:c407:b0:27c:a35a:1321 with SMTP id d9443c01a7336-28e9a66446amr176001465ad.51.1759818962726;
        Mon, 06 Oct 2025 23:36:02 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:51c1:81ab:3622:439f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d11080csm153402495ad.1.2025.10.06.23.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 23:36:02 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
Date: Tue,  7 Oct 2025 15:35:40 +0900
Message-ID: <20251007063551.3147937-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dpm_watchdog_all_cpu_backtrace module parameter which
controls all CPU backtrace dump before DPM panics the system.
This is expected to help understanding what might have caused
device timeout.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/base/power/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e83503bdc1fd..7a8807ec9a5d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -34,6 +34,7 @@
 #include <linux/cpufreq.h>
 #include <linux/devfreq.h>
 #include <linux/timer.h>
+#include <linux/nmi.h>
 
 #include "../base.h"
 #include "power.h"
@@ -515,6 +516,11 @@ struct dpm_watchdog {
 #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
 	struct dpm_watchdog wd
 
+static bool __read_mostly dpm_watchdog_all_cpu_backtrace;
+module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
+MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
+		 "Backtrace all CPUs on DPM watchdog timeout");
+
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
  * @t: The timer that PM watchdog depends on.
@@ -530,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *t)
 	unsigned int time_left;
 
 	if (wd->fatal) {
+		unsigned int this_cpu = smp_processor_id();
+
 		dev_emerg(wd->dev, "**** DPM device timeout ****\n");
 		show_stack(wd->tsk, NULL, KERN_EMERG);
+		if (dpm_watchdog_all_cpu_backtrace)
+			trigger_allbutcpu_cpu_backtrace(this_cpu);
 		panic("%s %s: unrecoverable failure\n",
 			dev_driver_string(wd->dev), dev_name(wd->dev));
 	}
-- 
2.51.0.618.g983fd99d29-goog


