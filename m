Return-Path: <linux-kernel+bounces-849065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A451BBCF239
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B0742802C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D223A58B;
	Sat, 11 Oct 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcBx+BtF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD4233707
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171307; cv=none; b=TgolMTOiqhEMDprGtb1jroQsJNZHRYFKkunYc0DEzaaDZz8Ffm5CQNWSqAe8MPUJ82eOIvx7hZLifNYxe8lgK9hv93kCSX+fi9OFI0RoU207mfW1XHmwj+v8JVy6h9sr9MCzL/G2NFGwqsALq4RWyrPMOANRDiqsKCutduced3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171307; c=relaxed/simple;
	bh=sw/eUhg7ntrMyVMWEv6qjvW/NWC36Ul4rMRtgOWP1SU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+6SGd6puyACefov2A3t/3bOTbvuTQftjDJRQKTKfm5mE3UbtpBpk2k4wy2tOE3jKfaQhlkhQU4sBD1exURdo/s/OGwD0JXbyzrUvq/+ovaeYD5wkjqzsbDiPHMsqnjjhpySi1JTt1T+JaB3N//xtStc4rSPXKnIoH6ccF21QZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcBx+BtF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdAbsTu/nbtO3/GQV0uj3bpCPqqqyHXpfr0jY1rXrBE=;
	b=ZcBx+BtFEYYstzU0xC4BLVM22DKLzthWYcNz0CCv/NCireaDWZ2Rj2DPQGY7lVEj1Frlrp
	om7hach+/+sgZvGOo5KcakVlDy89z501UYsabC95a7LMhzXqpAL6yknfDxSJ340FD0enuh
	d5HGJf9Q4JJF6yhW9ZQhvOiBbfCBmV8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-pT_w50abMfqbZREVw7qwVg-1; Sat, 11 Oct 2025 04:28:19 -0400
X-MC-Unique: pT_w50abMfqbZREVw7qwVg-1
X-Mimecast-MFC-AGG-ID: pT_w50abMfqbZREVw7qwVg_1760171298
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee888281c3so3149134f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171298; x=1760776098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdAbsTu/nbtO3/GQV0uj3bpCPqqqyHXpfr0jY1rXrBE=;
        b=QfXmudTY8RfHkZhrLLSLkoicGBAml4b5Ch+/+6vXLuTtjElyeeI+974iuR4AqXBERD
         CW1adIDoj6lvHdN4ZOlpy4Z3nHa4OGK0lgqL1y1/gtc+fSaxsVYWKBgbGRLnzUfQ1wjy
         b3ufayAL3gKxQt5D38hHf19m6866Iv2K+5nTV8sccUmRKzrJicLni81Q6uwzHdQH5RlA
         FS3ofmY3GsHB1kg7ttQqhY/pWlF8ZLOSL8Vv3Tz1mKAS3RZ5zCPKzp6KeQEw9voN992Q
         6MFmE0YA8PK1Z4SRdpW9IXQ/DAJq5yA7hqGDzqviiEQbaVZ+7NbAwYEwXvSJMj9lL0Ii
         N/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKavtcf9SODBKOWMb1wwzqurENbvNJd+1VpxVxiV6P/1xBvYgLva6QvxxcQWcH/FOqTrTpDgGek0BxMEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpktlzYY7o6WTEhmL5essEy3tYh2/fZkLiPJAa+xGwj9h/VDv
	0Pp/k32kK4OW0SoefCkUzUg58JDYAHCgh4dcuWyBpa9wJAOKqCTJGRc3/Jg9UTpvVtXyMUKatqo
	iOziZsYvXVKD2vLV4ZPr5P1MjOxQJZtRbPqlWO9TjK+ACwEWxKEoUG1Jj6tkNEnw1/Q==
X-Gm-Gg: ASbGncttyAX2L7bwy67hamWJlrhQ9vKXjicopOYHVk1dC12Yzv69OCX21g0CLH3znVn
	Wqo74qachkdBEndZ7Au97elr1BkT9AsLdf85gNU2NtNlMg9XWPUtvvdfS78378QznCmphJkbraC
	aB6MfAENn7TTrD4w4OCdgh7glElmFNIXd1G5D3l9lhPdWQyE6RawLCAvF0hsZNljs1yycOjSYLn
	u7XxKgF5CCoktBDfD8QHU3SBYG1Zpl64g8mvAuGyWXT3YHVB16i2R9lBvGoUfnPojYO/CkW0+m6
	qfLNHZx+Qn/N+UX92hEkP4nDh1RsZTeV/2kHSU5lF3SP
X-Received: by 2002:a05:6000:26c2:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-4266e7d917bmr10008616f8f.39.1760171297907;
        Sat, 11 Oct 2025 01:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIs00Fs2VZIdBz4nLKaEWYSTXqidn//HOPAo/VlO7701RgYJ0tYfNy8TrDMU86pcLnNhghTA==
X-Received: by 2002:a05:6000:26c2:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-4266e7d917bmr10008599f8f.39.1760171297411;
        Sat, 11 Oct 2025 01:28:17 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:17 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] tools/rtla: Add fatal() and replace error handling pattern
Date: Sat, 11 Oct 2025 11:27:34 +0300
Message-ID: <20251011082738.173670-2-costa.shul@redhat.com>
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

The code contains some technical debt in error handling,
which complicates the consolidation of duplicated code.

Introduce an fatal() function to replace the common pattern of
err_msg() followed by exit(EXIT_FAILURE), reducing the length of an
already long function.

Further patches using fatal() follow.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes since v1:
- fatal() prints "\n" insteasd of caller as suggested by Crystal Wood
---
 tools/tracing/rtla/src/osnoise_hist.c  | 42 ++++++++--------------
 tools/tracing/rtla/src/osnoise_top.c   | 42 ++++++++--------------
 tools/tracing/rtla/src/timerlat_hist.c | 50 +++++++++-----------------
 tools/tracing/rtla/src/timerlat_top.c  | 48 +++++++++----------------
 tools/tracing/rtla/src/timerlat_u.c    | 12 +++----
 tools/tracing/rtla/src/utils.c         | 15 ++++++++
 tools/tracing/rtla/src/utils.h         |  1 +
 7 files changed, 81 insertions(+), 129 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index dffb6d0a98d7..31a2c9cf97f5 100644
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
+				fatal("Error parsing house keeping CPUs");
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
+					fatal("Error adding trigger %s", optarg);
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
+					fatal("Error adding filter %s", optarg);
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
+				fatal("Invalid action %s", optarg);
 			break;
 		case '9':
 			retval = actions_parse(&params->common.end_actions, optarg,
 					       "osnoise_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s", optarg);
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
+		fatal("rtla needs root permission");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
 		osnoise_hist_usage("no-index set and with-zeros not set - it does not make sense");
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 95418f7ecc96..87f282e8c145 100644
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
+				fatal("Error parsing house keeping CPUs");
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
+					fatal("Error adding trigger %s", optarg);
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
+					fatal("Error adding filter %s", optarg);
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
+				fatal("Invalid action %s", optarg);
 			break;
 		case '5':
 			retval = actions_parse(&params->common.end_actions, optarg,
 					       "osnoise_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s", optarg);
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
+		fatal("osnoise needs root permission");
 
 	return &params->common;
 }
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 606c1688057b..ab5d8ca4593c 100644
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
+				fatal("Error parsing house keeping CPUs");
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
+					fatal("Error adding trigger %s", optarg);
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
+					fatal("Error adding filter %s", optarg);
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
+				fatal("Invalid action %s", optarg);
 			break;
 		case '\6':
 			retval = actions_parse(&params->common.end_actions, optarg,
 					       "timerlat_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s", optarg);
 			break;
 		default:
-			timerlat_hist_usage("Invalid option");
+			fatal("Invalid option");
 		}
 	}
 
 	if (trace_output)
 		actions_add_trace_output(&params->common.threshold_actions, trace_output);
 
-	if (geteuid()) {
-		err_msg("rtla needs root permission\n");
-		exit(EXIT_FAILURE);
-	}
+	if (geteuid())
+		fatal("rtla needs root permission");
 
 	if (params->common.hist.no_irq && params->common.hist.no_thread)
 		timerlat_hist_usage("no-irq and no-thread set, there is nothing to do here");
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fc479a0dcb59..d8e60f823b25 100644
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
+				fatal("Error parsing house keeping CPUs");
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
+					fatal("Error adding trigger %s", optarg);
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
+					fatal("Error adding filter %s", optarg);
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
+				fatal("Invalid action %s", optarg);
 			break;
 		case '\1':
 			retval = actions_parse(&params->common.end_actions, optarg,
 					       "timerlat_trace.txt");
-			if (retval) {
-				err_msg("Invalid action %s\n", optarg);
-				exit(EXIT_FAILURE);
-			}
+			if (retval)
+				fatal("Invalid action %s", optarg);
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
+		fatal("rtla needs root permission");
 
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index 01dbf9a6b5a5..ce68e39d25fd 100644
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
+			fatal("Error setting timerlat u default priority: %s", strerror(errno));
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
+		fatal("Error opening %s:%s", buffer, strerror(errno));
 
 	debug_msg("User-space timerlat pid %d on cpu %d\n", gettid(), cpu);
 
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index d6ab15dcb490..54334c676a22 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -56,6 +56,21 @@ void debug_msg(const char *fmt, ...)
 	fprintf(stderr, "%s", message);
 }
 
+/*
+ * fatal - print an error message and EOL to stderr and exit with ERROR
+ */
+void fatal(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+
+	exit(ERROR);
+}
+
 /*
  * get_llong_from_str - get a long long int from a string
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


