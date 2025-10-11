Return-Path: <linux-kernel+bounces-849068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBABCF23F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E379034C62D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312823C4F3;
	Sat, 11 Oct 2025 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnzaxpOp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567C23BCE4
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171317; cv=none; b=DCbj+vLPyDIBSEijpZw8xwkTl5B7UQq79vLP4K2d0P17MuqCz6FHlj5ROuQWejTh46+N5FnIq9Ufne7uruWaE4lFvJsKl4PwZRdB4T76HG5U/f2J+YP+Xac8dspWRwy58qhBn5xy2CRE82D3Zcwgo4YMKdORtdB9EK6tCGe/zOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171317; c=relaxed/simple;
	bh=jRcrQx61y9kXssdrhnsAAhEbZBbsrGaVtE/xowsZG3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puZzYPrljfh0Jvl0kSUr5Q98nwpPPxFI85K5+XFbxvi6xVzz9HHXZt2i8zfWuU5HwOLwnwTEKOC+E+TrUDOBoVr5tpWf23DxJoYxCPKDgJvx+CULng1khiITocvJNs3UADQKoNJ6MvTIHnMFjrXzw7EU8p6g9tFxNFwciyVgqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnzaxpOp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izEDGnACaGb+UE+AiB6Iu8Q3+pibeALVxmn3zVNoFFk=;
	b=BnzaxpOpgvmnxtctGld9OIFFFhmtCaxpcvn2B0CqTTZIUNAbhIB25xmV2AMoCGeyEn9sZY
	eWHtGaljRO75Jc6RqlmbFqYoYv0QCNh6XqVoj641eTACrnZzgmvfaA22OS2U62/9nmJ61c
	zVZVUCdQtH7RGSr3cHiDviBybbI7X10=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-UqCaJ_ZRM2CK26Q5PcLKmw-1; Sat, 11 Oct 2025 04:28:29 -0400
X-MC-Unique: UqCaJ_ZRM2CK26Q5PcLKmw-1
X-Mimecast-MFC-AGG-ID: UqCaJ_ZRM2CK26Q5PcLKmw_1760171308
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so1720040f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171308; x=1760776108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izEDGnACaGb+UE+AiB6Iu8Q3+pibeALVxmn3zVNoFFk=;
        b=B7ocj51EsEHhQegu9EjPGJNyO40cAPC0VJOKtH/+g/DuZ4ESH3yBPdFNuXnO4TQntj
         C4uLnZdFI8+f0Aez0a5lo8NrQYWOIZ0dHIDvclr5IFZo4zyYeijn1OyJkC4nbU0HYjZ1
         dYwQl/TJk5Xk7UtyLGcwt5Q2Zrqyxfav/TC1InOQzGDgMdauRfjaNXNaBgkq0O2NoGhM
         Zw6/RfvQnZd1Mn6uGThmQtzC3mjo6/vABF7Tk6tEAjrbAj8vtxoYBtMLtA02/Kx5Xv1C
         Z9LZlATca6ZkyL6ACiu0nv+HAXIPNFicXUipQ06jUaA3xeiCW6z8bdZQJ8kmdQrW5PYZ
         EcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Fl/+WKvl0DN2JKOP0gpnK87xBhMGAHu5R1/pTwhN1BDFg2FAC0C+Gb3DMFLrndJ9NqarndqiLoLabMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7p7dU9EkYZrOxuURLwTx/N2QzfqYKwCowNUKwW93QQOAImcK4
	LRRYjc3MYHm54GwcsQR53Qj9BJjWwEeV7Y+BdGWcKl40KM4pjIEYenPkh7VSo7+q0t0AwGI8ZKA
	Qkx+IOQyPdZp7kV3YD5sajJGyVTP2ZzT0EaUXzaLRXzTtIeKoHZbHcOwlYfyefv+xMw==
X-Gm-Gg: ASbGncviqQF746JVBIdxqznRiCVXadTw/A48LU7b5ck1Kd9OGGdFCEJijTe7564kpqG
	pwYKThfztzO1s3dN6Y18+RAD9xkFSVVPrMJzwgbolgS9onrtxRuj1x9xZAmN+rf3JXAiuFEGoPj
	Dcrq7BOtxj4Opy5wdqlDCCNsMG/QiG//hwmsViHovlfhlX1Q89ghqrEPLOIpFil6KnkUTNQITfd
	/D+UnQ0eeNEFwoSAj2lu+8RBqULJcd4JiIkkD3dL9PtdCi3COaySIdJsQquFdtCNv1TiM0khhxs
	C7wch2b/x6vzo/NnH2zYJA/I5Nxx65iiNft/wCyIrwTK
X-Received: by 2002:a05:6000:2f86:b0:404:2fe4:3a80 with SMTP id ffacd0b85a97d-425829ee8c7mr11070489f8f.25.1760171308256;
        Sat, 11 Oct 2025 01:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6+EqJMpQvaelkIXVEWLlIUO2XxTYtzFkl/y1HXogC30uU15snwvq85P0+PcPFAzDMeu1IWA==
X-Received: by 2002:a05:6000:2f86:b0:404:2fe4:3a80 with SMTP id ffacd0b85a97d-425829ee8c7mr11070479f8f.25.1760171307888;
        Sat, 11 Oct 2025 01:28:27 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:27 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] tools/rtla: Replace osnoise_top_usage("...") with fatal("...")
Date: Sat, 11 Oct 2025 11:27:37 +0300
Message-ID: <20251011082738.173670-5-costa.shul@redhat.com>
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

Replace osnoise_top_usage("...") with fatal("...") on errors.

Remove the already unused 'usage' argument from osnoise_top_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes since v1:
- fatal() prints "\n" insteasd of caller as suggested Crystal Wood
---
 tools/tracing/rtla/src/osnoise_top.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 87f282e8c145..f0782c5ed0b1 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -257,7 +257,7 @@ osnoise_print_stats(struct osnoise_tool *top)
 /*
  * osnoise_top_usage - prints osnoise top usage message
  */
-static void osnoise_top_usage(struct osnoise_params *params, char *usage)
+static void osnoise_top_usage(struct osnoise_params *params)
 {
 	int i;
 
@@ -296,9 +296,6 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	if (params->mode == MODE_OSNOISE) {
 		fprintf(stderr,
 			"rtla osnoise top: a per-cpu summary of the OS noise (version %s)\n",
@@ -318,9 +315,6 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -403,7 +397,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				osnoise_top_usage(params, "\nInvalid -c cpu list\n");
+				fatal("Invalid -c cpu list");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -422,7 +416,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				osnoise_top_usage(params, "Invalid -d duration\n");
+				fatal("Invalid -d duration");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
@@ -436,7 +430,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'h':
 		case '?':
-			osnoise_top_usage(params, NULL);
+			osnoise_top_usage(params);
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -447,12 +441,12 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
-				osnoise_top_usage(params, "Period longer than 10 s\n");
+				fatal("Period longer than 10 s");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				osnoise_top_usage(params, "Invalid -P priority");
+				fatal("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
 		case 'q':
@@ -461,7 +455,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_top_usage(params, "Runtime shorter than 100 us\n");
+				fatal("Runtime shorter than 100 us");
 			break;
 		case 's':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -489,7 +483,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				if (retval)
 					fatal("Error adding trigger %s", optarg);
 			} else {
-				osnoise_top_usage(params, "--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e");
 			}
 			break;
 		case '1': /* filter */
@@ -498,7 +492,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				if (retval)
 					fatal("Error adding filter %s", optarg);
 			} else {
-				osnoise_top_usage(params, "--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e");
 			}
 			break;
 		case '2':
@@ -520,7 +514,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				fatal("Invalid action %s", optarg);
 			break;
 		default:
-			osnoise_top_usage(params, "Invalid option");
+			fatal("Invalid option");
 		}
 	}
 
-- 
2.51.0


