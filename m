Return-Path: <linux-kernel+bounces-741825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177ECB0E964
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368474E808A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E98C214A94;
	Wed, 23 Jul 2025 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MGwntqo8"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FFC211A15
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753243207; cv=none; b=k9En0erRT9NRdXJXZWrSUggY1b+cZ5dKZIdw2x3SDczrExxhvTgKIsBGmkAF74FwgJk0ZWXBFecgYB0Dwo9IIwpQj2IuU3xSp+lEfp1TRn8xZC4fQwsLVfwZ5VqfGtGriSlfF3j1pzibTuOd0FoAvwoagsdNd31F+caqVadI9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753243207; c=relaxed/simple;
	bh=hg5ud6emYgmoK5RBRutraaTajbsQ45n0nXZERgtt2A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgenFXeXuBIgjbgOsIhDwe5Ny8U1mwwwpQx77lXXevy+0UtrzqBvivJ/iqUIAJ8TFPq6Qb8PVUOWcTD14EwHGJHFolFmyH+siRREzPcGz2Ky9IVxEvdZ2N12ER/CDfR4hhxEaa7FS1LyVApYOXlXYSInesqHZWrhWsh71qc+Tko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MGwntqo8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31d489a76dso5385788a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753243206; x=1753848006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q1k3jv3HqfKIyxYBUIJcZUhZRCNRS0iqmlesPw3pT8=;
        b=MGwntqo8iIefx9jpb14XmbocsUdxaIDEbpL5FfLQQCQOSgJ21g4unuBdmzCyuzRNaE
         qlHt/b2uvu2YxgIz8Su4iBaUk+i03FVDjeTlr9CNrYRxmcNchaIZ1p0BKPq7NnWtR4mA
         9LG7k/O6G0CVoGAaK45wQ7Og3jk+i226c6W2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753243206; x=1753848006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Q1k3jv3HqfKIyxYBUIJcZUhZRCNRS0iqmlesPw3pT8=;
        b=tisW/RcdYShcoQZe/jv24Ce08tKyyD7gZilhOMVJv34yI8lO/sqnGBCZail7Ytju9y
         SZPe+7YqtC5L4SS8cvL0J4zDBHf4CH6NJQdiUTqQUQ/JpY2NJbwL7SwcMa0+JxHr5UrE
         id5vfSc2fkpCF4MfN9pyr5IvBtOO3o5telzBGlA/X9jeyVF/SWHx8gqGn+eNAsO9VUR5
         cWnqLTAeENfZw4TmGpt9k4a05e5SvQxGiCgKZqCC9+cqs2hyWwLQQSTqjozljfMX1wlT
         PpRVC8zwH6EKrix6u0fFOEAuz345JcOThN/5SU6TTd61MRmeqSMDXFvunqG8/evi6yiF
         h39g==
X-Forwarded-Encrypted: i=1; AJvYcCVPUhttUGTEy1M8T3XMY3rMl8AbvZdDqKsbtnLg/eEnxP4ugxxQu9LBSk3rgZtnsr3hi2BwLN6zLNP00/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2JIwPRF7ZP1CR6ewt8J+MBMgOiPT4gFJqPbBbOgBTVUP6Hmnk
	rS7RaUjqBITBEpumRmW6vDFHNlFm0+cMQp2fT+NQs6eSz+tuIRoAiFgLXsnLcKQtjZosPg5FE3g
	aWVA=
X-Gm-Gg: ASbGncvLOwBPUIUKPT3SCdE3OMnuZ8uFIkgaBfBJe/B5h+s0ey3lXxw3jDGQKp9fkAp
	KfytKwPnquITS+93vEJc4wxslkkNuQwheSWS0R+H1DsnyYj53R7cDmsKzaDbvx7di5TjYqeXun4
	uvAsxjG4QdDFyPdfzgZxPahB3dTLSsisg+6hPWsZ6GiUJHJObIuO9M4qeHKnKh8Pct61rBrtq2O
	I+LdOY4Gr+j9Sl05m7BXd5yQFJFYGDlkxd96qliZ1oa3krHuBPAmL74PSNYDb1t1dFDUAI9PRQo
	af9rq4Hjj2D+kuT64PAcLNxLdGBHoIZyoi8CV3dK3qSPEE3azrTa77znf1L8g0rRtUTlsI3mJdX
	3hWnBh85OsSXQSeWlcBRzMW4wv+ABPM/GxUp20TBN+qMWYc2Xas0KPLShdrE=
X-Google-Smtp-Source: AGHT+IEH9eMZc6hbX2Xrl+JGcJWKA5qC6jOj++iObkwiTrt7IqrXEtcvBb/9AVmmw2w+4cnjnKAdyw==
X-Received: by 2002:a17:90b:5845:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-31e50817303mr2488633a91.18.1753243205187;
        Tue, 22 Jul 2025 21:00:05 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:fad8:2894:2c8d:4d33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51a2bc1bsm527225a91.37.2025.07.22.21.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 21:00:04 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH] PM: dpm: add module param to backtrace all CPUs
Date: Wed, 23 Jul 2025 12:59:09 +0900
Message-ID: <20250723035955.486688-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dpm_all_cpu_backtrace module parameter which controls
all CPU backtrace dump before DPM panics the system.  This
is expected to help understanding what might have caused
device timeout.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/base/power/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index dbf5456cd891..9fb943afe246 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -34,6 +34,7 @@
 #include <linux/cpufreq.h>
 #include <linux/devfreq.h>
 #include <linux/timer.h>
+#include <linux/nmi.h>
 
 #include "../base.h"
 #include "power.h"
@@ -517,6 +518,9 @@ struct dpm_watchdog {
 #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
 	struct dpm_watchdog wd
 
+static bool __read_mostly dpm_all_cpu_backtrace;
+module_param(dpm_all_cpu_backtrace, bool, 0644);
+
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
  * @t: The timer that PM watchdog depends on.
@@ -532,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *t)
 	unsigned int time_left;
 
 	if (wd->fatal) {
+		unsigned int this_cpu = smp_processor_id();
+
 		dev_emerg(wd->dev, "**** DPM device timeout ****\n");
 		show_stack(wd->tsk, NULL, KERN_EMERG);
+		if (dpm_all_cpu_backtrace)
+			trigger_single_cpu_backtrace(this_cpu);
 		panic("%s %s: unrecoverable failure\n",
 			dev_driver_string(wd->dev), dev_name(wd->dev));
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog


