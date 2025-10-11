Return-Path: <linux-kernel+bounces-849066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5B8BCF23C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738A0426909
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9AF23C4E9;
	Sat, 11 Oct 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsQSZVV0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED039239E81
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171312; cv=none; b=g8JwU2jekqON8zJM2QQGxPPQmV5AbguBxoyMeEgmAs37mI/PAmln2904DYFi81a6gofmTIqJwoF24y5axBYdWmXGCLkSn9LCjLK0//J+++JYx0VUTl8eRLdrbjREthCu1JjPumV+KEKi+dqU7h3lZmgHtM7BBXFe7jp1maW8ARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171312; c=relaxed/simple;
	bh=bK9ZbbRSu/RcSrw1tHd8Ioosrltuz2a83Oe9kALhMi0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqyFRt1MmodDGKPATsuwV7SMALKn2pGKi+DmPb0QbHDD1DlgIluU4mc6E4JmFvtNpKnhvJs2cxYmOzA1Th3m0XkrPiyZ+kyU6deWO+lEfkMBne5kWv/68UABvFx53sOMx73giDSLOhXI1T7NyCJlqEKvioW5Yp4Hs8grTpQKRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsQSZVV0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBAgrUtuAZgF1r3Y0+9jCP35gSNzVvlFmIc27nq44Uk=;
	b=FsQSZVV08HllJ9V0bq5smicJRwHIpVVRzWo4B4h9k11bDWIc0L3qx6Lr/ghNPgVsqqByOc
	t92erbgwAO+ecleGQB02bTcVXuBSoayuSJ3LZoK3LD2mPZ+pqtpPas49nbHRSYEFVyD2yS
	B2kG7Kc2BENEGlKjD1VhH4D80xrTKgM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-GX7HhJG0M4y795EJvzNw7w-1; Sat, 11 Oct 2025 04:28:24 -0400
X-MC-Unique: GX7HhJG0M4y795EJvzNw7w-1
X-Mimecast-MFC-AGG-ID: GX7HhJG0M4y795EJvzNw7w_1760171303
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso2291987f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171303; x=1760776103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBAgrUtuAZgF1r3Y0+9jCP35gSNzVvlFmIc27nq44Uk=;
        b=rW0MK1lhXLIlp8NFuUMLqapMitry3WkDu3/J9DniW+OiwNOErD043sBhyZf9WG8B15
         yHNz/1EjIcV+AvVQyl5HftnK3uGgFpkLwRQpMO1KgvXgzWonC/HVd4H6vAbzk8pGV7Bt
         3CVu16CHzEZuMWVwV5wDmjAJVM+O6WskjEVGN+ThdmCXlGIx8hlX14on6FZej+NiQ1eo
         sVMx9WWBnloNAAQSjLk4Jl61ZiH6gaNFZmBsrwDSXPI/qTOIy7+vPhYhx/i9cKV6mjmt
         Y9Vqd2Rb5mwD3psOyFix9Y2Gi6OcJB8vPVk3tWsuhZ21RtSSXE8w1SfZyfWd7La4FMv5
         7hjA==
X-Forwarded-Encrypted: i=1; AJvYcCUivQqO719VKI/pDbW/nl+034tjFmsUtRmeIOFlcyqQPOyfatqmvZ29dLkYF1yyGrCm3K+l0Rr9kNpokmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0qO//mdCe7Mzatvt39DQNjZ+uACJisZyI86bib0SDQwQjoxg
	5exCNtTA6ipfR/l105oSDGB0cCZhKdtczYC56oHOuLw9TUmRzqcctwgIQ3gb9SJdgF/HFY+apNO
	XZpPQ6jyxxTZhJIciwqu0uKT0IypB9oPpMR0/mwqqysPzLXzTNCga1Cep8tVdwVzUMg==
X-Gm-Gg: ASbGnctmSg/jSRZ9QKybmC71D+zrL5A7N3F06Az6C0vsOjs0rxItuInM/FprBd9Y0Na
	jYrpXY/amo8A/ecd5c61uULXB3gbtc6b88sStJ6zPcXU05OV7U07ftMp5bGeSvviuX+oBtB7h5v
	L4IoVUg+uiDLQqqOj1HtJjP+8FvuP4pGPiAPpQIC/4eO/EnXdTdrkvFuynW78YNcrM1RE7zSZlZ
	ycCuN25n5zrxe/6i3Y/Se5DK5imlPDmFBrWublFjZRnjJjxlQGQVO9mw+zsagr0TK2Ezp5IuT9T
	eIOExe+rSKz3X1agxLC8ZJR8MM9bC4fF3GNQ21OesXBk
X-Received: by 2002:a05:6000:659:10b0:426:d82f:889e with SMTP id ffacd0b85a97d-426d82f88cbmr276600f8f.14.1760171303106;
        Sat, 11 Oct 2025 01:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrOrLxL1eNdz8ZKW238q93rZX5VW6RjLN0F6KEdjI7rPURwhL8djYrNs8pRcGaxQcWksUQkg==
X-Received: by 2002:a05:6000:659:10b0:426:d82f:889e with SMTP id ffacd0b85a97d-426d82f88cbmr276582f8f.14.1760171302720;
        Sat, 11 Oct 2025 01:28:22 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:22 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
Date: Sat, 11 Oct 2025 11:27:35 +0300
Message-ID: <20251011082738.173670-3-costa.shul@redhat.com>
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

Replace timerlat_top_usage("...\n") with fatal("...") on errors.

Remove the already unused 'usage' argument from timerlat_top_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes since v1:
- fatal() prints "\n" insteasd of caller as suggested by Crystal Wood
---
 tools/tracing/rtla/src/timerlat_top.c | 28 +++++++++++----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d8e60f823b25..27b64bdc5b18 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -476,7 +476,7 @@ timerlat_print_stats(struct osnoise_tool *top)
 /*
  * timerlat_top_usage - prints timerlat top usage message
  */
-static void timerlat_top_usage(char *usage)
+static void timerlat_top_usage(void)
 {
 	int i;
 
@@ -524,18 +524,12 @@ static void timerlat_top_usage(char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	fprintf(stderr, "rtla timerlat top: a per-cpu summary of the timer latency (version %s)\n",
 			VERSION);
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -648,7 +642,7 @@ static struct common_params
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				timerlat_top_usage("\nInvalid -c cpu list\n");
+				fatal("Invalid -c cpu list");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -667,7 +661,7 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				timerlat_top_usage("Invalid -d duration\n");
+				fatal("Invalid -d duration");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
@@ -680,7 +674,7 @@ static struct common_params
 			break;
 		case 'h':
 		case '?':
-			timerlat_top_usage(NULL);
+			timerlat_top_usage();
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -700,12 +694,12 @@ static struct common_params
 		case 'p':
 			params->timerlat_period_us = get_llong_from_str(optarg);
 			if (params->timerlat_period_us > 1000000)
-				timerlat_top_usage("Period longer than 1 s\n");
+				fatal("Period longer than 1 s");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				timerlat_top_usage("Invalid -P priority");
+				fatal("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
 		case 'q':
@@ -740,7 +734,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s", optarg);
 			} else {
-				timerlat_top_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e");
 			}
 			break;
 		case '1': /* filter */
@@ -749,7 +743,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s", optarg);
 			} else {
-				timerlat_top_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e");
 			}
 			break;
 		case '2': /* dma-latency */
@@ -785,7 +779,7 @@ static struct common_params
 				fatal("Invalid action %s", optarg);
 			break;
 		default:
-			timerlat_top_usage("Invalid option");
+			fatal("Invalid option");
 		}
 	}
 
@@ -802,10 +796,10 @@ static struct common_params
 		params->no_aa = 1;
 
 	if (params->no_aa && params->common.aa_only)
-		timerlat_top_usage("--no-aa and --aa-only are mutually exclusive!");
+		fatal("--no-aa and --aa-only are mutually exclusive!");
 
 	if (params->common.kernel_workload && params->common.user_workload)
-		timerlat_top_usage("--kernel-threads and --user-threads are mutually exclusive!");
+		fatal("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
-- 
2.51.0


