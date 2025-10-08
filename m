Return-Path: <linux-kernel+bounces-845933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D7BC6853
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD3719E4776
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29E8278156;
	Wed,  8 Oct 2025 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3T3gU7h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AF27BF7D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953596; cv=none; b=cxcFAd1dmVz1nfrbfU26NL7qtBJJSi5utE0fd+pRatHulddLmwCZKH4qDth0nuil97LJ5cbXbB1Yt3A1mSO44CxQStaU42FiwzHUgOTrFKYs5H3D1yrA6cv54NzJVNFJArCvIOcw//WJAYzr5W7ImPXJlL/DlfbeU5Y4Pvc/E84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953596; c=relaxed/simple;
	bh=eC6iWnNBNyM2qZxYKEtLZwJZLXCisj1zl5uKGzp7UB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP2R1dtYAYYDh0aUTU25RjgSN/NbJ4T92TOWY09RLlbhb4HL7nf/eUkIF/CWRW8axrOA6V3tLTsoMDFqNqrtUm4FYqAl6/50SenW2TYGSnV2MHPyrN+Sb7Z1hEsKaCy+YgJAEupBfMCnvXi3O6UvQlKS5FAn6Ib3+xo5vJTVnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3T3gU7h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFfsvgXlRSf6rwDo6xn40BqTVmK62+JiqJARnqqZUVw=;
	b=D3T3gU7hwczcHYq2wu5BHZnaO6BzbMEoTkczKJNDQ/hEXySmcA+VTCZuy7umjFglYnnUsv
	aMSI3fDP+LqnG8R51hda9mTNqmfeJN+7KPTo5Nan714tdcYYZhuCHyJBHxXZsfYhS20cNN
	TbKzyRiHW2vE1GcfPWZP7EmGCwTAAiQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-QSSoH3eEOECV2Tiw0FWKyg-1; Wed, 08 Oct 2025 15:59:52 -0400
X-MC-Unique: QSSoH3eEOECV2Tiw0FWKyg-1
X-Mimecast-MFC-AGG-ID: QSSoH3eEOECV2Tiw0FWKyg_1759953591
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42421b15185so224089f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953591; x=1760558391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFfsvgXlRSf6rwDo6xn40BqTVmK62+JiqJARnqqZUVw=;
        b=RSn9ia0y37ou+QjyXezUrUPJu7IcFFG3TVCUlJv0m+gysVLjLj91GdSsYs0owM03uk
         svzUuwx6VF7Dw/OIdqsXiG7QzzXZxZFZ9uwRw22cc5gGccgRs80Dajlu5asemZI6sym3
         CdqfCCLF8smNUGPCZz8eu8msXe7RzmM9gCC6+ACTDiiuh14ijEv+B8sMQgc8gj+jZ+SD
         0dw7/3MT+tQIfs3bVZTi+c0CPhOx7OGeujGtxjzFZxsYL15vt7Gxxt5LADA8+jssJZhG
         12aTyg/NyZ5Uhad31z0sPpp0nghEIzPkjZATxdE77BOJjXNo4ogznD6wUYFFalu1DXvs
         i6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWiU6wDRO2rhfsQBpPe3it3fn823lPBuSdLvRb5OClSLImtU4HIWdQo24bd9vf14Okt2Cap5e9O4seqRWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwNmfQnr3DBr5dpPCSZqvRuSWcPhprxaJApgTrBlZSrLjwPn0
	r76jH0XaYOGxMV3CuBtShg1uFDUibMkYdJ98lqtBggvYHHGeemnZ5rHEdkveUnGWndtHMhHJhxz
	sS4K/5Mq534WFfSG6Bgjp/tOfjreHLMa8fiClmwbsb14Uqjg+k1CFReBAW7p70V/+ow==
X-Gm-Gg: ASbGncttVfT+Od86HBHNKdJCIe8bSjDsuG+RZlpR39hj8OW7JUI1NDkhtZbjmXy+k1U
	U7K9U0r5I44CYWH59MWHo/5iY7LyTh5Ds7h44WxwDdY12GhxuBS+XvrdytrcehQkW3ITLACzusR
	pVlFGVPr0Qg9EGMER3fFXTN9pUEfPkswZTp5UX8JFOufjqfoYJ/O0gcO547ygjn50OErZJyrtWb
	fGxKbsnKbbR1150IPnLUtc6QYa4vuZzZn5bwB0BFdPw7SL+kjrOHx9RFvRODhtoeFzi8A/16X74
	6toD56Y1IPYcw+QVdENrFcjSbkAJ55+PKJA5gAMobTRYtQJuIuk10PVZQmCeKiQ=
X-Received: by 2002:a05:6000:2210:b0:407:77f9:949f with SMTP id ffacd0b85a97d-4266e7c61aemr2522386f8f.28.1759953591302;
        Wed, 08 Oct 2025 12:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDzNUKc6b/ceMuaj4GD/u+xwcihuiULQIOyPD0gPH1NRrkBwWHaQIL25rVPGtipU8o4UOfBw==
X-Received: by 2002:a05:6000:2210:b0:407:77f9:949f with SMTP id ffacd0b85a97d-4266e7c61aemr2522377f8f.28.1759953590902;
        Wed, 08 Oct 2025 12:59:50 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:50 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
Date: Wed,  8 Oct 2025 22:59:03 +0300
Message-ID: <20251008195905.333514-4-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008195905.333514-1-costa.shul@redhat.com>
References: <20251008195905.333514-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A long time ago, when the usage help was short, it was a favor
to the user to show it on error. Now that the usage help has
become very long, it is too noisy to dump the complete help text
for each typo after the error message itself.

Replace timerlat_hist_usage("...") with fatal("...") on errors.

Remove the already unused 'usage' argument from timerlat_hist_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 36 +++++++++++---------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 6504556be5e4..fcc4f2e9213b 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -710,7 +710,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 /*
  * timerlat_hist_usage - prints timerlat top usage message
  */
-static void timerlat_hist_usage(char *usage)
+static void timerlat_hist_usage(void)
 {
 	int i;
 
@@ -766,18 +766,12 @@ static void timerlat_hist_usage(char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	fprintf(stderr, "rtla timerlat hist: a per-cpu histogram of the timer latency (version %s)\n",
 			VERSION);
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -884,7 +878,7 @@ static struct common_params
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				timerlat_hist_usage("\nInvalid -c cpu list\n");
+				fatal("\nInvalid -c cpu list\n");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -901,7 +895,7 @@ static struct common_params
 			params->common.hist.bucket_size = get_llong_from_str(optarg);
 			if (params->common.hist.bucket_size == 0 ||
 			    params->common.hist.bucket_size >= 1000000)
-				timerlat_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
+				fatal("Bucket size needs to be > 0 and <= 1000000\n");
 			break;
 		case 'D':
 			config_debug = 1;
@@ -909,12 +903,12 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				timerlat_hist_usage("Invalid -D duration\n");
+				fatal("Invalid -D duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
-				fatal("Error alloc trace event");
+				fatal("Error alloc trace event\n");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -925,11 +919,11 @@ static struct common_params
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
 			    params->common.hist.entries > 9999999)
-				timerlat_hist_usage("Entries must be > 10 and < 9999999\n");
+				fatal("Entries must be > 10 and < 9999999\n");
 			break;
 		case 'h':
 		case '?':
-			timerlat_hist_usage(NULL);
+			timerlat_hist_usage();
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -949,12 +943,12 @@ static struct common_params
 		case 'p':
 			params->timerlat_period_us = get_llong_from_str(optarg);
 			if (params->timerlat_period_us > 1000000)
-				timerlat_hist_usage("Period longer than 1 s\n");
+				fatal("Period longer than 1 s\n");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				timerlat_hist_usage("Invalid -P priority");
+				fatal("Invalid -P priority\n");
 			params->common.set_sched = 1;
 			break;
 		case 's':
@@ -1004,7 +998,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s\n", optarg);
 			} else {
-				timerlat_hist_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e\n");
 			}
 			break;
 		case '7': /* filter */
@@ -1013,13 +1007,13 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s\n", optarg);
 			} else {
-				timerlat_hist_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e\n");
 			}
 			break;
 		case '8':
 			params->dma_latency = get_llong_from_str(optarg);
 			if (params->dma_latency < 0 || params->dma_latency > 10000)
-				fatal("--dma-latency needs to be >= 0 and < 10000");
+				fatal("--dma-latency needs to be >= 0 and < 10000\n");
 			break;
 		case '9':
 			params->no_aa = 1;
@@ -1060,10 +1054,10 @@ static struct common_params
 		fatal("rtla needs root permission\n");
 
 	if (params->common.hist.no_irq && params->common.hist.no_thread)
-		timerlat_hist_usage("no-irq and no-thread set, there is nothing to do here");
+		fatal("no-irq and no-thread set, there is nothing to do here\n");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
-		timerlat_hist_usage("no-index set with with-zeros is not set - it does not make sense");
+		fatal("no-index set with with-zeros is not set - it does not make sense\n");
 
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
@@ -1072,7 +1066,7 @@ static struct common_params
 		params->no_aa = 1;
 
 	if (params->common.kernel_workload && params->common.user_workload)
-		timerlat_hist_usage("--kernel-threads and --user-threads are mutually exclusive!");
+		fatal("--kernel-threads and --user-threads are mutually exclusive!\n");
 
 	/*
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
-- 
2.51.0


