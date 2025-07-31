Return-Path: <linux-kernel+bounces-751533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F9B16AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D8C3A7817
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F86238C2C;
	Thu, 31 Jul 2025 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvzORfuq"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A093719CC28
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930898; cv=none; b=CazYvpd76MbJdp99aPVwl4hc02k0vj/t+3K28qDZpsk0/s/CjxSxn2RBomXwDptBdFVx0RIU6wg6ES1Ks0IV62aR9xorv3SPyhQcr0noy5dP8LtfyElFocTATDFZYHHJ4bXfpEnJKuoLRIDOlIb5x7w80G6Pp7cPE0hfXSiCUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930898; c=relaxed/simple;
	bh=QdQlM5yMQAEwRneaaxLhcq9g0/bjhiVLJ3LCkWRWd2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wn5rLGxV4+iOMklCy4o38L3QBm6Lja/W29/NomAyQI53/XkwZxfIB1VNcqwoIL7Yw6YtrNJERPttcZO86dDnd4LRH+LiEvP+5im5f8/igLypdpuEFJa9cSrNsMlCp6r877WDO1WziNXxzzQsfhlXLpHCXSfQ6FygNcOdJIVJ+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EvzORfuq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74b52bf417cso311090b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753930896; x=1754535696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WphqwsREfEv0c6rKHtoH+E0qlMlDl7K7sqJR1TqWs4g=;
        b=EvzORfuqEkML2k/kZwd8Pr/3DBSm4z5pNwnvbTGalbEl/Cs3XqLpcGPjLAEBzeAxzv
         Byyf4OSCBvT3DAQI/3N1RPRWU/3QLUsNhWI410DpIPKAkIgfLLSl8HtnRFY1X53j6rcG
         xPPEvIqnlwGOyCjsawAgVGSzrjW8zuXKKuf6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753930896; x=1754535696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WphqwsREfEv0c6rKHtoH+E0qlMlDl7K7sqJR1TqWs4g=;
        b=LxOtO7gpxA5YrOZoM0Et5hccCIM/A87qU1lKVM5vbpSr3/Y1dpIhC/tiWctY07LRC7
         a3sRm9p0egdT6u+TFbu98TUsuHjXUrn7A86as48A9/9VcLpTTNDUMY2l/W4u5XmhMXf8
         XaJnrrAH3nUshwuUDTfx31cvGpNYcu3oBpLCSywsWbCYIucg/PU44zEG8HHGhVARX8+A
         thMuSRqrLTDtOQV+8g2Rrm49TCPcDo9br/J1lQ7jYQjVK7kPglFiBVOdPH4LtNgXPt0L
         sbfdxXHpsglWYobNo//2Z9Wxs5wKgsBzT4Zg2RA4DsD/hztlvaCeuHo1JcCbb5pM+DuU
         zepg==
X-Forwarded-Encrypted: i=1; AJvYcCV38oG0QPvkxhO8vXvNTY56Mui+QeKZVYdna91qekBMWcfpB1w7C7Fu95dQuBSbq4IdXsiE3x8WTO1vSeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZC8CX+FLSRudJ5Ob6wnYZK6V+Wg+7Sb8dGiNH/W6iHiEbsxg
	cBC5Zc5zZ+6p/mYql+eGQnD/khW+dvHUCtxUdrA65UmjqVq5v10z2IvJLvC6iOjYKw==
X-Gm-Gg: ASbGncv4k9XoeEVMUBiWZFOoOhBWclWDkIrkikacIQLTw07aspa4Mi7ismfw5dvzN8r
	DCxxBozIVgktT5PfK7rwpYlBsDR3b+GQAZVoIWDaO28SSQkpjDfWCwMT6YOf+EteH8YwONaSk7K
	+ou5ptyRrBY084aMORjLG/qfvkTkise+KH7U5TLMp2ynNRTkYssrPMtZkPWUxGk8TImiEGwNMPx
	p/PdrzddhByR4Ig6fqv8BPkJ+ZqamGyq2ckc1wpTMq4o7Icl8J0j9LzmuO1b093i6jeAuBe5Ekk
	uoMOKEgPpzSYVg8qQg/hdvZmDkJWR2SRGPWF1/yQhfvpGUF+IFUmp8N5OXeAJNH7wGrB/+4+klK
	C5KQIWj/iyAiG/9zt8N8Xn1IIYh95ScywJbXY2efnZW6o700=
X-Google-Smtp-Source: AGHT+IGf1Elb5/v72sFdHsDdA3IITX1NlNAge4BGlFtV8tf2Eu+DVvC9IJvUfXSKnV02Hza0sTy7yQ==
X-Received: by 2002:a05:6a21:32a6:b0:21d:a9d:ba3b with SMTP id adf61e73a8af0-23dc10a54edmr8712455637.39.1753930895774;
        Wed, 30 Jul 2025 20:01:35 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7ccsm4531435ad.57.2025.07.30.20.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:01:35 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] PM: dpm: add module param to backtrace all CPUs
Date: Thu, 31 Jul 2025 12:01:08 +0900
Message-ID: <20250731030125.3817484-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
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
index dbf5456cd891..23abad9f039f 100644
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
+			trigger_allbutcpu_cpu_backtrace(this_cpu);
 		panic("%s %s: unrecoverable failure\n",
 			dev_driver_string(wd->dev), dev_name(wd->dev));
 	}
-- 
2.50.1.565.gc32cd1483b-goog


