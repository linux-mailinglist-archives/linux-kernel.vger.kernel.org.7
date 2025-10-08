Return-Path: <linux-kernel+bounces-845931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E6BBC684C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74B284EBF8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B3E27814C;
	Wed,  8 Oct 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPnL2XYd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A072765D4
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953587; cv=none; b=bV/V7aVFCCo6pcQzqx/P/DUBpTIZNJyDjx1h6lqoBVqr4wG1bPeUm0/EzjTklOnRMJLHLzmBnifhOsb1ukNmf0n3VbdWt01Hu2nSuNlX8bYkNsN2R3yYqWVxq8embkeHUD/5h37fnHCopBjJ9qr0ccL9f/g76Gr2cj2lVQeuSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953587; c=relaxed/simple;
	bh=CRKT0zHaJsmMMPFRY30kXvlz/uFynjoNQgPPm8aii/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCuBt+27YAylKcuZF7/KU8tmFFdkfDVSS+oSPSVP7NokQUCt0VpGtdHjCYXZ6F7R+FVRLJssr5BfausyHM+GXNXLhKKwFWMnAuVUSZCXo1zZv9M7tFFoP41EDAhHi6ZNLUn4Owi3pJ2JCvDq4IdM1+nlaQwu4WYCs64ikBLHkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPnL2XYd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cZMwP8GHtA17xgNAph6/8ACuSnK7f/y0DObajTtxvg=;
	b=MPnL2XYdl87AmU1XaBsigNqu5xwXM9KJkBoVd6OlsQWsoCybSkspCe+OczCvyGofQZfQod
	PD3HEMXXgGW6HutKCDxNgLEpsFdlgze/OzlPyMRwZZBmrdEjO5h9saimaLgYXfWDHhdcY/
	Us+SF7g0cdGifTk7DCF1SNMbd4QZaFo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-PQ3pN9GsP76w_z-yv9acOQ-1; Wed, 08 Oct 2025 15:59:42 -0400
X-MC-Unique: PQ3pN9GsP76w_z-yv9acOQ-1
X-Mimecast-MFC-AGG-ID: PQ3pN9GsP76w_z-yv9acOQ_1759953581
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee888281c3so297763f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953581; x=1760558381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cZMwP8GHtA17xgNAph6/8ACuSnK7f/y0DObajTtxvg=;
        b=QTL4USTsQ/PHFYoiw1dwjb58Dy1xUuGf1e2cw6hcdHaY4KnwLB5UQcQen3qVBYP95E
         mBdVhrYpXUma2ZTwaV9pbDmR0FiCrBTaijdTqwTc9IdmZmDu6mXNV2qGYrycFvDERDdp
         M8ICcM0KwzVp6GOhA475r5WLi+nQKsoKtQzzXYPTpxkbNEXu0GpXRvt+CcOa68xOhf+9
         KbUAbAmDAJC9SbA2KHa/QDwyCQ1G9TJvEZPd8pyaPe8lEf3QqLGOu7wPouWmmPVF5Uxb
         pcN+laGTzbu/1Bbq8iX/xd0ikdCL+t6I8fdxIBV2m5acDpV+gnHgXX20BHcY/BR05I0U
         BYow==
X-Forwarded-Encrypted: i=1; AJvYcCUHF6eGe2y+24p/Y+p3LP0hBP0/FjN8FSXbEgxAvfg5lWWhE3nAVaqtTo9lPv8bIVTKp5RtSW9KY+eVtW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKt/wgHpRD8hJPmhB5FoRrm0LP/cy7pbaCGqamwLKOSX6O39EM
	huQpGqYEbojMSMIernhxPgsdZdwk/ENyDRF+MdkgCyvxBHW7SuKKfPUBgvbxWPjgi4mshNbDwlL
	aWJk7lsTVtH1P9my3K21oS6cTMnEXJmjaxOPUC2dTZohaZGycR3qDDNGg3wpEXWD8pw==
X-Gm-Gg: ASbGncs11OgkXMiPiL6Z0UUQ+05QqzbCM8+ymevgNgYpaXCpMFtkHE5+aOqnobcrwmj
	+i6OsRh57iVvCstAQu948V+mYlPRL4uV78M2fC44vHwL8YzfYoxYRp49ZXz6CPYaZl7GgqqnJOg
	TQcaLNBKp0PlaqXcn364youjBtiEU1zqUwF45n9nx1nGFA9FZW6ZgIzCE+Sa1nC3FayrwkLkTEL
	9rdRNMNII7/gMoPGa9hTMLBX8X//rN9RYBTtztC2HUvuXO0pM5cVhUL8xqEt/HsMtXMoTGN/cHH
	g86OtgrC4fJINU2ieYTMaXLlvQ8g51uHlFzNc9q2gxwUGZHdH5/NuVoWHMu8tCI=
X-Received: by 2002:a05:6000:2285:b0:3ec:8c8:7b79 with SMTP id ffacd0b85a97d-4266e8e0bdfmr3310577f8f.61.1759953580689;
        Wed, 08 Oct 2025 12:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfAwACgTy90U+LNji26blXmsunNiKU4IHbAI1WMq5TErQiyIORWBh+WcrtQFB96YvpUkvMug==
X-Received: by 2002:a05:6000:2285:b0:3ec:8c8:7b79 with SMTP id ffacd0b85a97d-4266e8e0bdfmr3310560f8f.61.1759953580176;
        Wed, 08 Oct 2025 12:59:40 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:39 -0700 (PDT)
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
Subject: [PATCH v1 1/5] tools/rtla: Add fatal() and replace error handling pattern
Date: Wed,  8 Oct 2025 22:59:01 +0300
Message-ID: <20251008195905.333514-2-costa.shul@redhat.com>
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

The code contains some technical debt in error handling,
which complicates the consolidation of duplicated code.

Introduce an fatal() function to replace the common pattern of
err_msg() followed by exit(EXIT_FAILURE), reducing the length of an
already long function.

Further patches using fatal() follow.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 42 ++++++++--------------
 tools/tracing/rtla/src/osnoise_top.c   | 42 ++++++++--------------
 tools/tracing/rtla/src/timerlat_hist.c | 50 +++++++++-----------------
 tools/tracing/rtla/src/timerlat_top.c  | 48 +++++++++----------------
 tools/tracing/rtla/src/timerlat_u.c    | 12 +++----
 tools/tracing/rtla/src/utils.c         | 14 ++++++++
 tools/tracing/rtla/src/utils.h         |  1 +
 7 files changed, 80 insertions(+), 129 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index dffb6d0a98d7..43c323521f55 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -592,10 +592,8 @@ static struct common_params
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-			if (!tevent) {
-				err_msg("Error alloc trace event");
-				exit(EXIT_FAILURE);
-			}
+			if (!tevent)
+				fatal("Error alloc trace event");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -615,10 +613,8 @@ static struct common_params
 		case 'H':
 			params->common.hk_cpus = 1;
 			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
-			if (retval) {
-				err_msg("Error parsing house keeping CPUs\n");
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Error parsing house keeping CPUs\n");
 			break;
 		case 'p':
 			params->period = get_llong_from_str(optarg);
@@ -671,10 +667,8 @@ static struct common_params
 		case '4': /* trigger */
 			if (params->common.events) {
 				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval) {
-					err_msg("Error adding trigger %s\n", optarg);
-					exit(EXIT_FAILURE);
-				}
+				if (retval)
+					fatal("Error adding trigger %s\n", optarg);
 			} else {
 				osnoise_hist_usage("--trigger requires a previous -e\n");
 			}
@@ -682,10 +676,8 @@ static struct common_params
 		case '5': /* filter */
 			if (params->common.events) {
 				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval) {
-					err_msg("Error adding filter %s\n", optarg);
-					exit(EXIT_FAILURE);
-				}
+				if (retval)
+					fatal("Error adding filter %s\n", optarg);
 			} else {
 				osnoise_hist_usage("--filter requires a previous -e\n");
 			}
@@ -699,18 +691,14 @@ static struct common_params
 		case '8':
 			retval = actions_parse(&params->common.threshold_actions, optarg,
 					       "osnoise_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s\n", optarg);
 			break;
 		case '9':
 			retval = actions_parse(&params->common.end_actions, optarg,
 					       "osnoise_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
 			osnoise_hist_usage("Invalid option");
@@ -720,10 +708,8 @@ static struct common_params
 	if (trace_output)
 		actions_add_trace_output(&params->common.threshold_actions, trace_output);
 
-	if (geteuid()) {
-		err_msg("rtla needs root permission\n");
-		exit(EXIT_FAILURE);
-	}
+	if (geteuid())
+		fatal("rtla needs root permission\n");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
 		osnoise_hist_usage("no-index set and with-zeros not set - it does not make sense");
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 95418f7ecc96..43fb50b5d936 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -426,10 +426,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-			if (!tevent) {
-				err_msg("Error alloc trace event");
-				exit(EXIT_FAILURE);
-			}
+			if (!tevent)
+				fatal("Error alloc trace event");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -443,10 +441,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'H':
 			params->common.hk_cpus = 1;
 			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
-			if (retval) {
-				err_msg("Error parsing house keeping CPUs\n");
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Error parsing house keeping CPUs\n");
 			break;
 		case 'p':
 			params->period = get_llong_from_str(optarg);
@@ -490,10 +486,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case '0': /* trigger */
 			if (params->common.events) {
 				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval) {
-					err_msg("Error adding trigger %s\n", optarg);
-					exit(EXIT_FAILURE);
-				}
+				if (retval)
+					fatal("Error adding trigger %s\n", optarg);
 			} else {
 				osnoise_top_usage(params, "--trigger requires a previous -e\n");
 			}
@@ -501,10 +495,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case '1': /* filter */
 			if (params->common.events) {
 				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval) {
-					err_msg("Error adding filter %s\n", optarg);
-					exit(EXIT_FAILURE);
-				}
+				if (retval)
+					fatal("Error adding filter %s\n", optarg);
 			} else {
 				osnoise_top_usage(params, "--filter requires a previous -e\n");
 			}
@@ -518,18 +510,14 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case '4':
 			retval = actions_parse(&params->common.threshold_actions, optarg,
 					       "osnoise_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s\n", optarg);
 			break;
 		case '5':
 			retval = actions_parse(&params->common.end_actions, optarg,
 					       "osnoise_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
 			osnoise_top_usage(params, "Invalid option");
@@ -539,10 +527,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	if (trace_output)
 		actions_add_trace_output(&params->common.threshold_actions, trace_output);
 
-	if (geteuid()) {
-		err_msg("osnoise needs root permission\n");
-		exit(EXIT_FAILURE);
-	}
+	if (geteuid())
+		fatal("osnoise needs root permission\n");
 
 	return &params->common;
 }
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 606c1688057b..6504556be5e4 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -913,10 +913,8 @@ static struct common_params
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-			if (!tevent) {
-				err_msg("Error alloc trace event");
-				exit(EXIT_FAILURE);
-			}
+			if (!tevent)
+				fatal("Error alloc trace event");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -936,10 +934,8 @@ static struct common_params
 		case 'H':
 			params->common.hk_cpus = 1;
 			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
-			if (retval) {
-				err_msg("Error parsing house keeping CPUs\n");
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Error parsing house keeping CPUs\n");
 			break;
 		case 'i':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -1005,10 +1001,8 @@ static struct common_params
 		case '6': /* trigger */
 			if (params->common.events) {
 				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval) {
-					err_msg("Error adding trigger %s\n", optarg);
-					exit(EXIT_FAILURE);
-				}
+				if (retval)
+					fatal("Error adding trigger %s\n", optarg);
 			} else {
 				timerlat_hist_usage("--trigger requires a previous -e\n");
 			}
@@ -1016,20 +1010,16 @@ static struct common_params
 		case '7': /* filter */
 			if (params->common.events) {
 				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval) {
-					err_msg("Error adding filter %s\n", optarg);
-					exit(EXIT_FAILURE);
-				}
+				if (retval)
+					fatal("Error adding filter %s\n", optarg);
 			} else {
 				timerlat_hist_usage("--filter requires a previous -e\n");
 			}
 			break;
 		case '8':
 			params->dma_latency = get_llong_from_str(optarg);
-			if (params->dma_latency < 0 || params->dma_latency > 10000) {
-				err_msg("--dma-latency needs to be >= 0 and < 10000");
-				exit(EXIT_FAILURE);
-			}
+			if (params->dma_latency < 0 || params->dma_latency > 10000)
+				fatal("--dma-latency needs to be >= 0 and < 10000");
 			break;
 		case '9':
 			params->no_aa = 1;
@@ -1049,31 +1039,25 @@ static struct common_params
 		case '\5':
 			retval = actions_parse(&params->common.threshold_actions, optarg,
 					       "timerlat_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s\n", optarg);
 			break;
 		case '\6':
 			retval = actions_parse(&params->common.end_actions, optarg,
 					       "timerlat_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
-			timerlat_hist_usage("Invalid option");
+			fatal("Invalid option\n");
 		}
 	}
 
 	if (trace_output)
 		actions_add_trace_output(&params->common.threshold_actions, trace_output);
 
-	if (geteuid()) {
-		err_msg("rtla needs root permission\n");
-		exit(EXIT_FAILURE);
-	}
+	if (geteuid())
+		fatal("rtla needs root permission\n");
 
 	if (params->common.hist.no_irq && params->common.hist.no_thread)
 		timerlat_hist_usage("no-irq and no-thread set, there is nothing to do here");
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fc479a0dcb59..03ecc38d0719 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -671,10 +671,8 @@ static struct common_params
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-			if (!tevent) {
-				err_msg("Error alloc trace event");
-				exit(EXIT_FAILURE);
-			}
+			if (!tevent)
+				fatal("Error alloc trace event");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -687,10 +685,8 @@ static struct common_params
 		case 'H':
 			params->common.hk_cpus = 1;
 			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
-			if (retval) {
-				err_msg("Error parsing house keeping CPUs\n");
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Error parsing house keeping CPUs\n");
 			break;
 		case 'i':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -741,10 +737,8 @@ static struct common_params
 		case '0': /* trigger */
 			if (params->common.events) {
 				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval) {
-					err_msg("Error adding trigger %s\n", optarg);
-					exit(EXIT_FAILURE);
-				}
+				if (retval)
+					fatal("Error adding trigger %s\n", optarg);
 			} else {
 				timerlat_top_usage("--trigger requires a previous -e\n");
 			}
@@ -752,20 +746,16 @@ static struct common_params
 		case '1': /* filter */
 			if (params->common.events) {
 				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval) {
-					err_msg("Error adding filter %s\n", optarg);
-					exit(EXIT_FAILURE);
-				}
+				if (retval)
+					fatal("Error adding filter %s\n", optarg);
 			} else {
 				timerlat_top_usage("--filter requires a previous -e\n");
 			}
 			break;
 		case '2': /* dma-latency */
 			params->dma_latency = get_llong_from_str(optarg);
-			if (params->dma_latency < 0 || params->dma_latency > 10000) {
-				err_msg("--dma-latency needs to be >= 0 and < 10000");
-				exit(EXIT_FAILURE);
-			}
+			if (params->dma_latency < 0 || params->dma_latency > 10000)
+				fatal("--dma-latency needs to be >= 0 and < 10000");
 			break;
 		case '3': /* no-aa */
 			params->no_aa = 1;
@@ -785,18 +775,14 @@ static struct common_params
 		case '9':
 			retval = actions_parse(&params->common.threshold_actions, optarg,
 					       "timerlat_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s\n", optarg);
 			break;
 		case '\1':
 			retval = actions_parse(&params->common.end_actions, optarg,
 					       "timerlat_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
 			timerlat_top_usage("Invalid option");
@@ -806,10 +792,8 @@ static struct common_params
 	if (trace_output)
 		actions_add_trace_output(&params->common.threshold_actions, trace_output);
 
-	if (geteuid()) {
-		err_msg("rtla needs root permission\n");
-		exit(EXIT_FAILURE);
-	}
+	if (geteuid())
+		fatal("rtla needs root permission\n");
 
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index 01dbf9a6b5a5..2f85c242e1d5 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -51,10 +51,8 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 
 	if (!params->sched_param) {
 		retval = sched_setscheduler(0, SCHED_FIFO, &sp);
-		if (retval < 0) {
-			err_msg("Error setting timerlat u default priority: %s\n", strerror(errno));
-			exit(1);
-		}
+		if (retval < 0)
+			fatal("Error setting timerlat u default priority: %s\n", strerror(errno));
 	} else {
 		retval = __set_sched_attr(getpid(), params->sched_param);
 		if (retval) {
@@ -78,10 +76,8 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 	snprintf(buffer, sizeof(buffer), "osnoise/per_cpu/cpu%d/timerlat_fd", cpu);
 
 	timerlat_fd = tracefs_instance_file_open(NULL, buffer, O_RDONLY);
-	if (timerlat_fd < 0) {
-		err_msg("Error opening %s:%s\n", buffer, strerror(errno));
-		exit(1);
-	}
+	if (timerlat_fd < 0)
+		fatal("Error opening %s:%s\n", buffer, strerror(errno));
 
 	debug_msg("User-space timerlat pid %d on cpu %d\n", gettid(), cpu);
 
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index d6ab15dcb490..bf3662313cde 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -38,6 +38,20 @@ void err_msg(const char *fmt, ...)
 	fprintf(stderr, "%s", message);
 }
 
+/*
+ * fatal - print an error message to stderr and exit with ERROR
+ */
+void fatal(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+
+	exit(ERROR);
+}
+
 /*
  * debug_msg - print a debug message to stderr if debug is set
  */
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index a2a6f89f342d..1be095f9a7e6 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -19,6 +19,7 @@
 extern int config_debug;
 void debug_msg(const char *fmt, ...);
 void err_msg(const char *fmt, ...);
+void fatal(const char *fmt, ...);
 
 long parse_seconds_duration(char *val);
 void get_duration(time_t start_time, char *output, int output_size);
-- 
2.51.0


