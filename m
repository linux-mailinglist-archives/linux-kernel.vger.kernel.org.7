Return-Path: <linux-kernel+bounces-849069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813ABCF245
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0042E4269FB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08424502C;
	Sat, 11 Oct 2025 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I592Bp9Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69223D7CA
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171319; cv=none; b=QdTvdJFAJ8qNTCv1fMzMp5uNWZuws5C6v3x2HnbW73yEk6kPv8K4f3qIa4cTkENTWDo6g87oJVp78YJSQpCqfyxWUBSL/xeQVtzVJULNiHaVHBSMpAfX6IbrAdws5s6YZyTaJSLmEcIyV9O52aWaSD1A3CjDdHdTALw5OX4tq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171319; c=relaxed/simple;
	bh=lMxJsTBvYIIRzV2ysIaeaApJyW/Xxwl8lAvSVzlHlhs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gU8TwigpvOd8WWMlFVZiLkk6UIjTnoaXvsrjmNvwtlIP9E7S3f+9FR0cBOmycqMeHJtAlUY5AiMZa/MUbRKo3KuXGc3cmYwjGtdttuG80Ax6EfTlAqvDkzA6g58MV7fLSJwGQEwG6eRLd5MMT5MNkLKLHsxw3NMhqyUTxxAk62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I592Bp9Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOj4qrsjoSEV40FZCa/GgcbP7ZbPD06dUm2Vl71DoUE=;
	b=I592Bp9QcB4bXuDrx1dutBzAwOzTC9tTPH8+We2nUR6i05WSGF3QYU03qokyllxghaR5kk
	Qp08GWMcWqBBMZiw44zGP9mEiV3MnYgRCI0Ou6A4yzj8tkRQb1ra0Ap5SP0MOFz+0RHQ7O
	ME+N/9TDKCysL8OKrID0sWHuKIkdOH0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-kw7vALKyP-KUq3WxGQHQpA-1; Sat, 11 Oct 2025 04:28:31 -0400
X-MC-Unique: kw7vALKyP-KUq3WxGQHQpA-1
X-Mimecast-MFC-AGG-ID: kw7vALKyP-KUq3WxGQHQpA_1760171311
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4c8fa2b1so12112695e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171311; x=1760776111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOj4qrsjoSEV40FZCa/GgcbP7ZbPD06dUm2Vl71DoUE=;
        b=MqYzY9I2OLYF9/nJLPL2TnIrdrnpiNqxLq5fG7Nb3Iy/C1EG9UEfpBqPBjiBaZHE4J
         rq/8oHfodQre6BN6V8Ri3bK4nhlEV9GQWZt/gixoB85LT/+1OqUl1+BIP9z04y9dvPmQ
         gESjGemCDeG68OsAmzcfxgV4YSckxLB1zPKVGl7zSdaWTTq/4Th/pfU3MW5MTM660Wiu
         bA1x4Tk0aRWaJ1/hWXtLsXlinNjXWjaLMXe27a/5D0STjoC34/MO0BP4iZ8XYP0p+FCw
         9zMQ/mIRZ/HOHG5N3IDzzhDXZZiWaGiuZ4tCZL6Ufgyiq8nYpWflCD5q64bDRNvQ7QQJ
         Hl1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+ptRZqHW6CNYlxzLdqYIZEUXYBGgl0da34ILNQcrFqYNTDHUJTrPDFdOuY3LkZA+DsLPheHrX3/+9BFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvvFa8sJBT7RXZU4Mb7yDoex+e3WHE8GYw54Pc2PZhHcaq/4e
	U6ri/FgDhCK1Dcaf1ikJbmS6nz+6d7+7c+61lLLi51Zo5zMZA+rcqPCnzQM8NfuIF3BYNZLKAWk
	5V7agLqhQTstLlriwpSry/1xVCIGj63/2rrOAQUxOUEgsOftnkz0hV3G0PWd1WiJbHA==
X-Gm-Gg: ASbGncv2tOTkYmqS/lkJ0OP5qCo1wteWTC6IhRShk0jsfoBgDvWPyAVXj5G+RHmCk4D
	+JG0Wmcij5yciSJZPfd1V3fy3T/cYvuwcmpyF/m2FgUKnrthYK/23v69QquARAJqstnlLcf73eJ
	yeUQTFsiNCqJn5J5EL2XTBzsWNzcrcqtX8XeXYxA6wCzIcLrHgYcGgC9JgKIVA9DWf084bWR5yP
	K10ZkaHL6mfPaNN2a48neOnAKMP1m4fHBNlpfYZDRW2XDYujxPrRY86O4/EKxwAYVMZqJWFU5Hi
	bN2tjmkBggGlWGSIiu/Emh2SrpEjV8sWLCvRTWdn4Q3G
X-Received: by 2002:a05:600c:5306:b0:46e:3d41:5fe7 with SMTP id 5b1f17b1804b1-46fa9afbd48mr94401205e9.29.1760171310582;
        Sat, 11 Oct 2025 01:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK5DqK5p00Q8fy/jT6hCAziOfIB4t7V7rJVh/6m2CXm+TH90wdKa0CBAPVz1Kvu+HBjsP2vw==
X-Received: by 2002:a05:600c:5306:b0:46e:3d41:5fe7 with SMTP id 5b1f17b1804b1-46fa9afbd48mr94400995e9.29.1760171310146;
        Sat, 11 Oct 2025 01:28:30 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:29 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")
Date: Sat, 11 Oct 2025 11:27:38 +0300
Message-ID: <20251011082738.173670-6-costa.shul@redhat.com>
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

Replace osnoise_hist_usage("...") with fatal("...") on errors.

Remove the already unused 'usage' argument from osnoise_hist_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes since v1:
- fatal() prints "\n" insteasd of caller as suggested Crystal Wood
---
 tools/tracing/rtla/src/osnoise_hist.c | 32 +++++++++++----------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 31a2c9cf97f5..b0b7f04c3871 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -421,7 +421,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 /*
  * osnoise_hist_usage - prints osnoise hist usage message
  */
-static void osnoise_hist_usage(char *usage)
+static void osnoise_hist_usage(void)
 {
 	int i;
 
@@ -467,18 +467,12 @@ static void osnoise_hist_usage(char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	fprintf(stderr, "rtla osnoise hist: a per-cpu histogram of the OS noise (version %s)\n",
 			VERSION);
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -564,12 +558,12 @@ static struct common_params
 			params->common.hist.bucket_size = get_llong_from_str(optarg);
 			if (params->common.hist.bucket_size == 0 ||
 			    params->common.hist.bucket_size >= 1000000)
-				osnoise_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
+				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				osnoise_hist_usage("\nInvalid -c cpu list\n");
+				fatal("Invalid -c cpu list");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -588,7 +582,7 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				osnoise_hist_usage("Invalid -D duration\n");
+				fatal("Invalid -D duration");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
@@ -604,11 +598,11 @@ static struct common_params
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
 			    params->common.hist.entries > 9999999)
-				osnoise_hist_usage("Entries must be > 10 and < 9999999\n");
+				fatal("Entries must be > 10 and < 9999999");
 			break;
 		case 'h':
 		case '?':
-			osnoise_hist_usage(NULL);
+			osnoise_hist_usage();
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -619,18 +613,18 @@ static struct common_params
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
-				osnoise_hist_usage("Period longer than 10 s\n");
+				fatal("Period longer than 10 s");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				osnoise_hist_usage("Invalid -P priority");
+				fatal("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_hist_usage("Runtime shorter than 100 us\n");
+				fatal("Runtime shorter than 100 us");
 			break;
 		case 's':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -670,7 +664,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s", optarg);
 			} else {
-				osnoise_hist_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e");
 			}
 			break;
 		case '5': /* filter */
@@ -679,7 +673,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s", optarg);
 			} else {
-				osnoise_hist_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e");
 			}
 			break;
 		case '6':
@@ -701,7 +695,7 @@ static struct common_params
 				fatal("Invalid action %s", optarg);
 			break;
 		default:
-			osnoise_hist_usage("Invalid option");
+			fatal("Invalid option");
 		}
 	}
 
@@ -712,7 +706,7 @@ static struct common_params
 		fatal("rtla needs root permission");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
-		osnoise_hist_usage("no-index set and with-zeros not set - it does not make sense");
+		fatal("no-index set and with-zeros not set - it does not make sense");
 
 	return &params->common;
 }
-- 
2.51.0


