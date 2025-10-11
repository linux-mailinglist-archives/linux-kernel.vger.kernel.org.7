Return-Path: <linux-kernel+bounces-849067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C65BCF242
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DC4EA043
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06FC23E347;
	Sat, 11 Oct 2025 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZM4REZ1R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77523AE9A
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171315; cv=none; b=EovoaMUbH2VPZbRTAgXs0tZXdsg2FLP2tt08qHcFMMMGMcpSk8dhPJs7HV0VPNsRGXEigzQpNyIN6bBb3CZAjl2dqMka/iuAZMrf4lbC3hG1xl/KdL1w3VpWJV8qlXUzHPOa9I/yTC06Pqq4O7yz6hm5LsP+TXiwLGnjj7SJRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171315; c=relaxed/simple;
	bh=LRfI47UB2UnyFYw/FWC26NL7Yq0N9R5zYg3HcLRgkdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCCKgkWBDlARYys6K03L43mfPpB1QeTmL9orey9wp/gN816V+cx1u7QGm95vBnnknfOktCHOR8wpRbLUrQ61agNSnzm9yerWCATEDBfIeoBne4gLb3Cn8OdqyAYJPsRz2KVEjP3umjSElVzwO0CV76fBGI9dOFqthcF9vdO58Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZM4REZ1R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHj98cou2Y19csOC6HqCSeOGSHvHBg7RYgMNCaj5iUM=;
	b=ZM4REZ1RUaVDjhOsW/6NfWsVufy6YL+hOdT4mVaz/DlG7EtRpgLtklsvRPQf/vvlCMnghT
	ORZopC3rq675yQ+YdHPXZ+6O3TVRNirtyxkgejA/SBUjZJnH/GAuH04yNBWMosgt2iMC5Y
	4IYloiWGnX3vg4ZROKff0azw/e41NUc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-dytZ8QJDPaWMDnCZlGNPKg-1; Sat, 11 Oct 2025 04:28:27 -0400
X-MC-Unique: dytZ8QJDPaWMDnCZlGNPKg-1
X-Mimecast-MFC-AGG-ID: dytZ8QJDPaWMDnCZlGNPKg_1760171306
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4fa584e7so15385735e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171306; x=1760776106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHj98cou2Y19csOC6HqCSeOGSHvHBg7RYgMNCaj5iUM=;
        b=q9horJUFLVBo5QvZHtlhOrYW8mwsdrbpS7f5QFF4uwpzywvIRVKwTYO7fdzWDM4MuO
         tnDnu68YxE33eITtpofN3b17xqCf5zaacHSCgQNps6Zu3/ZO2hrtwj8HILTMAjx64SBJ
         cpo52HAvDAJbmsK9RAt1sK6q1jXooOziSZwalFXwN62Y1iu1lJ5vHXuFF4b+yxmDnewk
         0Zrmsn4NcH0GoJ12EB4ZUj2E8mSNEvd3Ls1rLlbeztfwg5F45+C4MukOv/cg0Y+dc2A0
         xtexiR5jrQ6k26v04uK0G3NeDZa/h6lx7Nl77RGNZMYOr2czTgt4s+G8zHLLyqdCVOIw
         A0ug==
X-Forwarded-Encrypted: i=1; AJvYcCVQS9Q/0SFn3HZT4SyfnsjgQjd745P4/gpEgOet+Qmv5/tLB+hSsKtSca5za58qq471BmYE7hcXsQ27548=@vger.kernel.org
X-Gm-Message-State: AOJu0YypszC02yrrhPfmg4Me9gAWs9Um7ybq1QW7G5gb8int34kFfak9
	mJyux9ZNEI/aPzaFJAXRP6tj03te7dQx/b62Sf05/SyC1FsZeaYbE+G1IFW/Ot1xAtIvyt5spkr
	dTr8EOvOA4t4/GjZOQFURcwkOR7lcXFXHc/+O98mi1dtSa79OhnVrIM5xINglL0TlyA==
X-Gm-Gg: ASbGncuYD/2uneLQACPLAVXwCxlQEiU6/+2aLHFLIbQMqgThrHm0U5N/VACI1oCpQEw
	ginVB8QHtZNfkJZIbc35nXuZvXU2AOwEG0jj7GRx2dNz84eWvTyFZIrfEyF0i0iw7PgQpUBMClf
	AzfaYEvcIXB8/Sr82Xy3QPLv15vQ2MU6/G5H3QfK9i9p13QCr+xGnkMHMliUHVHNVC5WzyRxVgm
	ifDM7c67goPu3cXBLgCJCpwmUhQa7gSMMZvo21aMrL4MUWsFhebgZafnr0G+wI02Fw9YWrFHOKQ
	ZS2ojwCXbRRpro+llJyANiuMq0ZB2+QYy1oKEIInSDZq
X-Received: by 2002:a05:6000:4305:b0:3ec:d78d:8fcc with SMTP id ffacd0b85a97d-42666ab85a7mr8999682f8f.14.1760171305776;
        Sat, 11 Oct 2025 01:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqokUQUSflqj2ie1uzhEOzTJOaDkXEKNoBKE1a5t+pgJEbZNk3LxtrY+4KW6G+rzLsLPIdSg==
X-Received: by 2002:a05:6000:4305:b0:3ec:d78d:8fcc with SMTP id ffacd0b85a97d-42666ab85a7mr8999670f8f.14.1760171305390;
        Sat, 11 Oct 2025 01:28:25 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:25 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
Date: Sat, 11 Oct 2025 11:27:36 +0300
Message-ID: <20251011082738.173670-4-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011082738.173670-1-costa.shul@redhat.com>
References: <20251011082738.173670-1-costa.shul@redhat.com>
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

Replace timerlat_hist_usage("...\n") with fatal("...") on errors.

Remove the already unused 'usage' argument from timerlat_hist_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes since v1:
- fatal() prints "\n" insteasd of caller as suggested by Crystal Wood
---
 tools/tracing/rtla/src/timerlat_hist.c | 32 +++++++++++---------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index ab5d8ca4593c..71557f5751a6 100644
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
+				fatal("Invalid -c cpu list");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -901,7 +895,7 @@ static struct common_params
 			params->common.hist.bucket_size = get_llong_from_str(optarg);
 			if (params->common.hist.bucket_size == 0 ||
 			    params->common.hist.bucket_size >= 1000000)
-				timerlat_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
+				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
 		case 'D':
 			config_debug = 1;
@@ -909,7 +903,7 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				timerlat_hist_usage("Invalid -D duration\n");
+				fatal("Invalid -D duration");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
@@ -925,11 +919,11 @@ static struct common_params
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
 			    params->common.hist.entries > 9999999)
-				timerlat_hist_usage("Entries must be > 10 and < 9999999\n");
+				fatal("Entries must be > 10 and < 9999999");
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
+				fatal("Period longer than 1 s");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				timerlat_hist_usage("Invalid -P priority");
+				fatal("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
 		case 's':
@@ -1004,7 +998,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s", optarg);
 			} else {
-				timerlat_hist_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e");
 			}
 			break;
 		case '7': /* filter */
@@ -1013,7 +1007,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s", optarg);
 			} else {
-				timerlat_hist_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e");
 			}
 			break;
 		case '8':
@@ -1060,10 +1054,10 @@ static struct common_params
 		fatal("rtla needs root permission");
 
 	if (params->common.hist.no_irq && params->common.hist.no_thread)
-		timerlat_hist_usage("no-irq and no-thread set, there is nothing to do here");
+		fatal("no-irq and no-thread set, there is nothing to do here");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
-		timerlat_hist_usage("no-index set with with-zeros is not set - it does not make sense");
+		fatal("no-index set with with-zeros is not set - it does not make sense");
 
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
@@ -1072,7 +1066,7 @@ static struct common_params
 		params->no_aa = 1;
 
 	if (params->common.kernel_workload && params->common.user_workload)
-		timerlat_hist_usage("--kernel-threads and --user-threads are mutually exclusive!");
+		fatal("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
-- 
2.51.0


