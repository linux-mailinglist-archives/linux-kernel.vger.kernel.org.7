Return-Path: <linux-kernel+bounces-746971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A76B12DAB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 05:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625274A0B39
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 03:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2657183CC3;
	Sun, 27 Jul 2025 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoWw0OQR"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB429CE6
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753586728; cv=none; b=qrotwt5MNNAsEUPvFV6XNAChzu2Mnmhq6OoI6VdEIZ7Nph5N7PT4dJFckLNyfpp2jMnDWIzItYlVpOxuriITcRzqvc4XnIqh0DMZLy9WNAqiuS/44jsCIUj3ZtvmjXfFFFAqmAu+IUgpj76xxQsEw5c3zs+CKcKYoSGPftZNams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753586728; c=relaxed/simple;
	bh=y1RIxtGvWWvrlmikRl5H3U+Pml+D9VOhbLDADRcVMwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mge0YKcGzF/b8iCGYwa7TnJ/nHsReShVvHqaoWQqtf+n3qFJ/oxmuNVd/b8+gXdMYhdrARY+IrjmMktKCDh3j+2YADAR0ClBJx0OPv+YmbbCTSoSdJkNr2CtFaHJ0glGZCKuCjHx2jOMxW5KZyNwZ+1k9i/1mvLC3lMsZXZNVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoWw0OQR; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-23e210ebd5dso33571305ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 20:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753586726; x=1754191526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wZ+SgJzjmChh4mBsT5RpVMAecVqcrYD5cf5cn7K+Ok=;
        b=UoWw0OQR2Y17RtwZJPHeTB5oZojFA7sfzORL3XCM+Uq6yQU5HKZKQTHxP4vynAjLNk
         TFwfNtdUcS5dukDo+Tnjz/wBX3qZsC9c3yuVYtZQdrRVStIKFCyHAHce0n0yS1AKRm4i
         0Lo0Pfonw93e3+O3Za+yNlef37FvMcgh/9FEfFuwCG3iDT11wMJPKZIdKu7F2EcqSN+t
         Kh5sPT93wd6v7t8huTR+CTNZthLBwZ/xhiA28is2mU/6vvXCfGgx+HECL2oC7lkz1Evc
         mtBBBCGMoBs0AvjkEVGZUDWcgV2HhOwbfRHpl5kxO7+2r1utGv+S9CXVVqRcy1DFrbgY
         vfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753586726; x=1754191526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wZ+SgJzjmChh4mBsT5RpVMAecVqcrYD5cf5cn7K+Ok=;
        b=tVVH7TS/YML/JMV79GJK8G6YYGKQ8JG+IWiwWt+pjY2wtHJ2Y3sBbdO2tDLmxdeFOX
         X+Y/cY9b1Pic4F5ogy0NLcLbR7Z4KZbeAc20BzzhIE0ymzUH36KfFpHFK5ezTFoYtqO/
         uQkxDA6F6dUL0SdRGzVDdLmGILpRsieYcymhbPNDWs8Qk5S5VtEfRl1N4mJYzdbN+++K
         Hj04Qej8LxnQMw79no7Ek4Vb1/u1J9LTHlM80RoMkWE2PID+iG/Y9g2pB9zvVuE4VzbE
         50UGsRNcFUBolVCUNnRGu0V6CxdgQYot6v+Vnru9GiDZ01pvluXog/4wRwsre5TelVhs
         TpZg==
X-Forwarded-Encrypted: i=1; AJvYcCXkBHY6Sx/L9D1tIX+1I3QlPSLS7U5D1o7C2e3Ke1HBgw/S2feejK7Zl6AJmMHxjovvhdObBSgD2XY0ZfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytbgAjGWQcSclQCQ6FY1NcN8X4L05yedbwYQlgzqZwrN6wGjsZ
	xSY9BqtIAOj/WPOCTCgNSW5e0Q8KQivojerfZtB7AN/AGtIwLLWa7Quh
X-Gm-Gg: ASbGnctpc6oLQSkJcrpEvtpXM449CmJrNJxLWR2eA+6E4bNXnm3HFuQH4jHzYNOkA1D
	pSktU5sCpVUHTUFfSNkTs8JlZHzANWK+8IOkTYvU3Tq9mJ9rM7GRci/qEkzR6bUHzDq0Cx5mANt
	yGC7+EMGh//MZ9tItHwfxdGAxvDZcI7wB0++issZYGrkILveAwztwOlLIwHu6DCeRR5Eyy2iOsM
	4ZJyNwk3s3wXnR9hQLw44gzPTtSeeFPbXM9gHEZcfy05H+EH0JozryczOvoGN/1zbruexvWxFsJ
	7lPMrfSE/HN9G/h8lX6i9tsURgPPWN9RcitFp/E97KVikOZdC8cN9NZipo5h3cSAw0sjZ/VywO1
	aAi6VFxvPqBx9fOdIQTgdRkPnceLT9LbPW2mObZZB2wyLjA==
X-Google-Smtp-Source: AGHT+IGs5+yU2ROTXVn8HefkWA1Bx9Z84pviyuwvum4hCmF9WFDx/o2lFnINhgQ3R9qUUNMOOae6Tw==
X-Received: by 2002:a17:902:d2ca:b0:237:e3bc:7691 with SMTP id d9443c01a7336-23fb2b5c130mr117655195ad.13.1753586725786;
        Sat, 26 Jul 2025 20:25:25 -0700 (PDT)
Received: from DESKTOP-ILBT5MC.localdomain ([27.38.215.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe4fd249sm26244675ad.89.2025.07.26.20.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 20:25:25 -0700 (PDT)
From: Qing Wong <wangqing7171@gmail.com>
To: peterz@infradead.org,
	linux-kernel@vger.kernel.org
Cc: mingo@kernel.org,
	akpm@linux-foundation.org,
	song@kernel.org,
	Qing Wang <wangqing7171@gmail.com>
Subject: [PATCH] watchdog: Don't need a definition of the perf fallback-attr
Date: Sun, 27 Jul 2025 11:25:16 +0800
Message-ID: <20250727032516.10063-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Qing Wang <wangqing7171@gmail.com>

The 'hardlockup_config_perf_event()' only overwrites the type and
config of the perf attr. It's wasteful that redefining a big static
variable to fallback. It’s just a matter of simply fallback these
two variables.

Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 kernel/watchdog_perf.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 75af12ff774e..08b9acbd2aa4 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -92,14 +92,6 @@ static struct perf_event_attr wd_hw_attr = {
 	.disabled	= 1,
 };
 
-static struct perf_event_attr fallback_wd_hw_attr = {
-	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
-	.size		= sizeof(struct perf_event_attr),
-	.pinned		= 1,
-	.disabled	= 1,
-};
-
 /* Callback function for perf event subsystem */
 static void watchdog_overflow_callback(struct perf_event *event,
 				       struct perf_sample_data *data,
@@ -114,6 +106,12 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	watchdog_hardlockup_check(smp_processor_id(), regs);
 }
 
+static void fallback_wd_hw_attr(void)
+{
+	wd_hw_attr.type = PERF_TYPE_HARDWARE;
+	wd_hw_attr.config = PERF_COUNT_HW_CPU_CYCLES;
+}
+
 static int hardlockup_detector_event_create(void)
 {
 	unsigned int cpu;
@@ -133,8 +131,7 @@ static int hardlockup_detector_event_create(void)
 	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
 					       watchdog_overflow_callback, NULL);
 	if (IS_ERR(evt)) {
-		wd_attr = &fallback_wd_hw_attr;
-		wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
+		fallback_wd_hw_attr();
 		evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
 						       watchdog_overflow_callback, NULL);
 	}
-- 
2.43.0


