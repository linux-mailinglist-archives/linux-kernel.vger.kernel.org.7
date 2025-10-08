Return-Path: <linux-kernel+bounces-845935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908CABC6859
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D133A5DA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499912BEC2A;
	Wed,  8 Oct 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRLnF0Ga"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEA29B8FE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953606; cv=none; b=KarJTTtdfG1g0XuJtjGWtDXDqKYJSzlFtTtbZkdJoMB3fjySHySYeXp/4a+NMYz9plk5ZQiBw9MSMG0ENjyR4Md6t2jhCYBoniyOiqjMCU5kpMZpTFJRszz9NWVgtsjD5iArLFaEzPq5uH9ByFotanlYv2LCdpp5oJkVoY3MenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953606; c=relaxed/simple;
	bh=TqWu55z+5wYc6F+NJ10bIT+HOTq+7ULpdasuP+yIBq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kga3Wa+4fQV0hcH1mJwEXJJBhtVeo6eWf7j5cKPBdScVUw1ZcLHEaPFrSX3Mhmjc+e+mGeYluJtZ7fKnTGfq7BCi6lgAwReR01/ubdqifAq02SVrEend711uxIlEl+pqID1gAvm2tD9mX5Ne9N9PH0thmh0mT50sMl0sNvXVyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRLnF0Ga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=II5hn3aPlMfjpXnd9vhycCVPNkV61JFwnfuK1k3g2ms=;
	b=jRLnF0Ga8foIsjkQ4cXMveQ/isbNrjpa/DdAxNJiSfB6GOKMUCg3l3ojjULshmoeDsAIzz
	pQr/QZjq7n72gKC1CRUtIIu8eRSeWnUyL/Jlm4vZ6QN8HSBFxq7hS2MABoRfTL3dgYIFWc
	xJSu4Z37/ZxMIbx26cNhnqcLFM/ZjY4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-NqNWfOF2OlWZBtr7E5Ld0A-1; Wed, 08 Oct 2025 16:00:02 -0400
X-MC-Unique: NqNWfOF2OlWZBtr7E5Ld0A-1
X-Mimecast-MFC-AGG-ID: NqNWfOF2OlWZBtr7E5Ld0A_1759953601
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso1766345e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953601; x=1760558401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II5hn3aPlMfjpXnd9vhycCVPNkV61JFwnfuK1k3g2ms=;
        b=gmLfO+FRfskl/l4GaGB3DoiuyeWjOWjo8KiFQei1xvQioByov3ISXXs/VMun9gD6tq
         Lx5rHgON5CdojYFYRcgBIjJWALJjcpfxrWEZ+bTYZomQenIx8htPqbw6t+nwY/yiuBWJ
         naR5q7g538jI5/2Ls50m3Xm4g3shVDrgafqKtlBBeckk1HyvLHDZcgnx2CmEgWW22WeS
         a6lfMezkNfnSj6Nq7cfJWN3FHTyv4Xkf+eqsEJlsOClw6iS4C9ytg3tamarjvT1Wh8Pa
         s7Gd7cPlKDPp7ppcYB8Ru4g1c6+eYS+KoZgegt7Mf7DgD+tVL8oea4KLvn76GvXJGaLN
         SzMA==
X-Forwarded-Encrypted: i=1; AJvYcCVzIKdmt+hK34KxMbGAOEp4wPGHyqzUh75l+1ggwVxRJV3Dgl4MWB9ElUFwiS9WOTP823l3kFePXwtA/HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxua+7UK9D0KBgqxGgZoMCTemZa24xHLvbb5ZAxEa+V3WT0P0Xk
	lK2dsxr77CwBe2b7r0l6NTkQB8xvv69DhbpSmRDeJZFSen7zagbCjdz5G4vG+IiN1WN3eFCvM+w
	6CQOcQWnJkrHMc0pdHY17mfAZ8IORgxBA3dUiQmHZ3JltjRG6PWg90UYXTAzLSoxqFxJxBVQOCq
	xx
X-Gm-Gg: ASbGncul/Kbz/QdmVybdiMFhrpjX463M8enSruPGlkJHMIP9kXZ8RP1w2jmBFIKHT52
	NQ2qL6A8J5ic9OuPZ2uBp8AzUgQKGYwLZFOJfOv6tGkgN6/fZal2/sEHI/RrnA3z8A9105p9bbr
	jZZfD6cZUzpl7DcWRG1LWPuYMjHaqxIVshdIV8EYA4KP4me7BMc4lwfELdGt/rn3YLrtbvnW9dO
	rC3MCYp5TPp98RpoA4SlwnD8pQJ8pjqkI/PJlFiGfzYFG3v2E5wY6Fa6ohc9Kip6TJpBWaDcIZ2
	GRwPUHdJ9/LmR521L2CYhZf66lBIVFqIq9Ep7YANt8PeuOQNlM3XMeRb1xXbzvA=
X-Received: by 2002:a05:600c:c0c3:20b0:46e:39ef:be77 with SMTP id 5b1f17b1804b1-46faef4161fmr8064885e9.14.1759953600713;
        Wed, 08 Oct 2025 13:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlxgZDNU+hfJsuo3gBuETXOFe1aN2DF1fu0vRNbtwpm+xr3TxS17m0h+/cEvx8qvo/IT5uqg==
X-Received: by 2002:a05:600c:c0c3:20b0:46e:39ef:be77 with SMTP id 5b1f17b1804b1-46faef4161fmr8064765e9.14.1759953600318;
        Wed, 08 Oct 2025 13:00:00 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:59 -0700 (PDT)
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
Subject: [PATCH v1 5/5] tools/rtla: Replace osnoise_top_usage("...") with fatal("...")
Date: Wed,  8 Oct 2025 22:59:05 +0300
Message-ID: <20251008195905.333514-6-costa.shul@redhat.com>
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

Replace osnoise_top_usage("...") with fatal("...") on errors.

Remove the already unused 'usage' argument from osnoise_top_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 43fb50b5d936..604a068ed77f 100644
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
+				fatal("\nInvalid -c cpu list\n");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -422,12 +416,12 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				osnoise_top_usage(params, "Invalid -d duration\n");
+				fatal("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
-				fatal("Error alloc trace event");
+				fatal("Error alloc trace event\n");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
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
+				fatal("Period longer than 10 s\n");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				osnoise_top_usage(params, "Invalid -P priority");
+				fatal("Invalid -P priority\n");
 			params->common.set_sched = 1;
 			break;
 		case 'q':
@@ -461,7 +455,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_top_usage(params, "Runtime shorter than 100 us\n");
+				fatal("Runtime shorter than 100 us\n");
 			break;
 		case 's':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -489,7 +483,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				if (retval)
 					fatal("Error adding trigger %s\n", optarg);
 			} else {
-				osnoise_top_usage(params, "--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e\n");
 			}
 			break;
 		case '1': /* filter */
@@ -498,7 +492,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				if (retval)
 					fatal("Error adding filter %s\n", optarg);
 			} else {
-				osnoise_top_usage(params, "--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e\n");
 			}
 			break;
 		case '2':
@@ -520,7 +514,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
-			osnoise_top_usage(params, "Invalid option");
+			fatal("Invalid option\n");
 		}
 	}
 
-- 
2.51.0


