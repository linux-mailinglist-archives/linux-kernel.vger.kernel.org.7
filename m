Return-Path: <linux-kernel+bounces-845932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 629E0BC6850
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB05B4EEA0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3783277026;
	Wed,  8 Oct 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAqPrCTu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327292797BD
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953591; cv=none; b=DE8MVB/vIIjnQtvlfpQePA5BQfROC/TcY/eP6sBsmtFT/DMB32YakZXJ0B1MP7EzvC1skd4tW36DnLJkzEyW6HfeQCXbEFi/SJWU8Gn2J/983AV3CMzklAu7zF8MPgozOOpjNl55nXcV+JZSJ/Os9+yefVQneeAYtAaROk4WfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953591; c=relaxed/simple;
	bh=R01JDrYPf3T7tS3r0JRwFP7avSmaK3pXhJTdNJHaQRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXuRWZU4AYfVH9xqMjP4ULkYt+8CjbWvkoVNQajNiDK46MEPA43V58enk03JcC7Hx3MCacKxxxELrazUuksssILi1mTcQx6iRLpty7iqZo14l6FdsMnO8e7k2dhDIaeGCgk31d7RuTYx5q2LcTdIH1dUcmRm4180CW57Tvr79Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAqPrCTu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+sd0fKPLWAqOh4kQ/TQyBqgyJmAhPlQ/8KNnD12Elio=;
	b=CAqPrCTuiKJizR/5ZPhVBTJvL6Mc9iX01X9TGhciHZUwDSsSKo3IVeN1ptB3BjI9JyMWMF
	HBfMFIUNEIJtPft4uVmtYNBl0v/ab7xPtYgACyezuNGQS9ftdAl/yNNm7hZb8weoSFJEzO
	srDXPeJznEmHeLPs0WnxwRTtrzM3zkM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-QCRKHeMxOoul_pAMrlT0Tg-1; Wed, 08 Oct 2025 15:59:48 -0400
X-MC-Unique: QCRKHeMxOoul_pAMrlT0Tg-1
X-Mimecast-MFC-AGG-ID: QCRKHeMxOoul_pAMrlT0Tg_1759953587
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so223769f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953587; x=1760558387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sd0fKPLWAqOh4kQ/TQyBqgyJmAhPlQ/8KNnD12Elio=;
        b=DS/Pzb0VhasPguXN5n15+MG02DhOB2B12WtLuM8x6baynM7l2bA6zLFW2CAG0/W6CY
         2Ui22xz93e0AnOAW9m8NwO3w/cN8jE1S58fud1sB8bSb3Z29MDxL3Qg0Vu4uqAAbYlqS
         zIX0UxWik9hyBrVZBrZHg6b5MH1PseYV2/cdS/KhtPFZsC0Z8Phi498/xyMVdIU7OfiZ
         +2nsT+4dhgePOEXrLZ0Kmrh18/Vsi+PsNrz2V1OmLtjEYM7IMqrtzusACHbuw95xC7V4
         8Xq22rfOX77/S9GQ7fsFb5HJGxesudEd9wgXLxGpSJxdAXylJGo9yT0s9Dh456Hl/BSV
         T0kg==
X-Forwarded-Encrypted: i=1; AJvYcCXsMz82QFt/d+pK7XT7u9fThQn/uInJH+pZIO4si3aJLiH7s1lvKchORclIqW0OKE4PTFA+4C2Z0FlOAbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oKwMvMU+fGAfd8AQfgawBa/d1tuYCPobQlRbhKCL/7Pv/DDd
	VnHHA2KmHzkw3i0A9kYhLU/z1z0OzuPZQnMPGrH3lHlH81zOeJwSsSSxc6cfeDBgU+0KLJP12Ed
	+I+anUFwYK8qGhJKTe2DRvPx+5gTcp+TPDUv0ccSie48IUrEqfo2yzFNifN8ZZhS4GQ==
X-Gm-Gg: ASbGncs5X3RVOIZogfzRQ/rrMXbWSrQzwH7cFodZrzfynyF3wnkpyNHDZ2JcjOKz14L
	T5/gn8oi3vvEruOYhBtUtvYrS+PKHZf5qYwChKvO4vCm+4weDVGT2pdv+EeVSh2rRWi8ChEFQsY
	eqnp6FbK37NIIsLMEtF0vqqizemdwX7Q0279Fd3tO7ZDI4z6rxbOeC18GXfJDujBvi5AXGkTyBk
	H335GWvNwpjfay8A5jfDlyVuL0/McL74w7FjkHfCRIrcoipAwpwSJaCEdKGGv+IXZHj9geWrbSZ
	i5bBqmbOk/FeXw802HANc3cbXOfI+vOyozMqHIisOaC7FRK19aKA9304CAAej5o=
X-Received: by 2002:a5d:5d85:0:b0:3d6:4596:8a3a with SMTP id ffacd0b85a97d-4266e7bf18emr3491659f8f.17.1759953586773;
        Wed, 08 Oct 2025 12:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEikjmlhNc/NKttcfoUG4lvNDzYLqq7gREx7dIbaipV6H4Hv0NV9ovVs6yS45bS8y/EUjzCng==
X-Received: by 2002:a5d:5d85:0:b0:3d6:4596:8a3a with SMTP id ffacd0b85a97d-4266e7bf18emr3491651f8f.17.1759953586318;
        Wed, 08 Oct 2025 12:59:46 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:45 -0700 (PDT)
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
Subject: [PATCH v1 2/5] tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
Date: Wed,  8 Oct 2025 22:59:02 +0300
Message-ID: <20251008195905.333514-3-costa.shul@redhat.com>
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

Replace timerlat_top_usage("...") with fatal("...") on errors.

Remove the already unused 'usage' argument from timerlat_top_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 32 +++++++++++----------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 03ecc38d0719..81b9c8c59c06 100644
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
+				fatal("\nInvalid -c cpu list\n");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -667,12 +661,12 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				timerlat_top_usage("Invalid -d duration\n");
+				fatal("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
-				fatal("Error alloc trace event");
+				fatal("Error alloc trace event\n");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
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
+				fatal("Period longer than 1 s\n");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				timerlat_top_usage("Invalid -P priority");
+				fatal("Invalid -P priority\n");
 			params->common.set_sched = 1;
 			break;
 		case 'q':
@@ -740,7 +734,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s\n", optarg);
 			} else {
-				timerlat_top_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e\n");
 			}
 			break;
 		case '1': /* filter */
@@ -749,13 +743,13 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s\n", optarg);
 			} else {
-				timerlat_top_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e\n");
 			}
 			break;
 		case '2': /* dma-latency */
 			params->dma_latency = get_llong_from_str(optarg);
 			if (params->dma_latency < 0 || params->dma_latency > 10000)
-				fatal("--dma-latency needs to be >= 0 and < 10000");
+				fatal("--dma-latency needs to be >= 0 and < 10000\n");
 			break;
 		case '3': /* no-aa */
 			params->no_aa = 1;
@@ -785,7 +779,7 @@ static struct common_params
 				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
-			timerlat_top_usage("Invalid option");
+			fatal("Invalid option\n");
 		}
 	}
 
@@ -802,10 +796,10 @@ static struct common_params
 		params->no_aa = 1;
 
 	if (params->no_aa && params->common.aa_only)
-		timerlat_top_usage("--no-aa and --aa-only are mutually exclusive!");
+		fatal("--no-aa and --aa-only are mutually exclusive!\n");
 
 	if (params->common.kernel_workload && params->common.user_workload)
-		timerlat_top_usage("--kernel-threads and --user-threads are mutually exclusive!");
+		fatal("--kernel-threads and --user-threads are mutually exclusive!\n");
 
 	/*
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
-- 
2.51.0


