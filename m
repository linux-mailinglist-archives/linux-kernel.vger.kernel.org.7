Return-Path: <linux-kernel+bounces-840235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553ABB3E78
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6EA3C0FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E346030FC25;
	Thu,  2 Oct 2025 12:36:12 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856F12B94
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408572; cv=none; b=rRI3PzxFZO9Xw7/XLyC2Y0eb6W7TMVC6aYmreBI5YmhsXzWVuFpiWtg9z4KhHUseU/uVLDoddzb6XZQQAxYJzws8J4EkxPYSuK6cLZLOKtWi9glSi9wEsT+3MdTNayMh/POfciGtl+0scY7k/zER0ljRDovEsZJuqLhOfkG2LqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408572; c=relaxed/simple;
	bh=Tju1grRPgRjIwOw8Hb9bnDgMQM1wWtnIOLV+NzozbwI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=durUGZ1kpXbHh1M4XZbrwEl+gHgHuL7lwkjg7UN4HCJN2vvrlsR3h19n+jyra/i9GLuRGvLazJMz3dxlBvisCiOjJHtWpvZE2PjCA+uBlYqf3pJAAOYHr5hrn2Yfb5p1TlNGMwpxOnNfsi0r1Wafs66GqA+VkOYvsZGguqgDLPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so4033925e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408568; x=1760013368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQQFYDEO2PrKkMHz7aHq73gVixuOAgPEENPnpuPmN/k=;
        b=AOnVYLMhgNcduMfIObSFw43Y8vinyp8VwjzgfjFgQqsY6Iy3qzadlOv/Lb+BVnkzlJ
         CJ5f/z/sK7kkEej7iuq1bjTP0Eojf/HfsCUYyow0pH1FzW8BsQeW63Aqj8KLwfzlNT9D
         f0Ep8cMwajHcuZTtWWZKftYpbmN/QJEeHZpKoa2y3WTqyGzj8QIJxjhyOAOziDBMLIdQ
         wbjZ8CJLGg1A4eKDGMCdT08onr+JSY3O0C/akEBRDVJBsY1/jT2dC2ibOOcNTVeBSwGk
         YMxKHHQJm9OuOT/Cg/t2vL/7MqwGLT0QabC8iNugqlRHQBCzkeQPWPQBliC30Rg/1lsV
         AvWg==
X-Forwarded-Encrypted: i=1; AJvYcCVWd11UnHFoFnYtr+gddVDeHZ/T3p8R5ZHwHQMZEf6JG/t4re0vvZR0ZryRztYkxZWsAzyMHgCNhX2dmpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vI1VBXCf8HtXX1Ug1+J/liijrZ6JwQFiloi6fnyEw2wIi35H
	mmUzPlEa/1ppuA8pt56or++FGbyeipdYcdaE85Z+IaefxlQEAc51lXjv
X-Gm-Gg: ASbGncvzZajCBLxuo4coW44y+bQMBOih43OkGBtRkvGbgoWcEGeRIEQvdigXS0uM/y4
	C5JAV3+06dWicjuhwAp+kxDganrn+whMU5q25n7OzUWea+E2ArIeeiD/onirlxvWNI9XjNKudD/
	jUk5sj41XmuhQKBJze7Z/NuZiCvjp4ynvdsLHHUSsi34vtkvCbsXqdhTVuGY98p2kS754nUIjQI
	fpWc0P7IQnQoXh8VmKRhGU4fQH0y5U6yRzi1LPGp3AmecrQx+va3xi+JRJ9KmEAa1n2e04N+FTs
	Zczt8kv8MPeVVGH3Us2r+S4TzIBG7DdirZH2yfAaMDoWmJMHOY5eHj+056g14b6OWf0nZUGBbK/
	EiALPOcbTxJ4Fdh++puTPenHR6vKJ6RASnxQf1k8/DFpDZli9pzc4SmA+TjAVhy10
X-Google-Smtp-Source: AGHT+IEpP2Ro8/lRQq3RIlzDW2fG/yYAl/ri4ta7GQdD6Oa14SiEUNVHwT+6CtjhdaRNMNpucVcS8w==
X-Received: by 2002:a05:600c:3b28:b0:46b:932f:9201 with SMTP id 5b1f17b1804b1-46e611dd1c9mr57148965e9.0.1759408568302;
        Thu, 02 Oct 2025 05:36:08 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693c33adsm32449075e9.18.2025.10.02.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:36:07 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] tools/rtla: Add for_each_monitored_cpu() helper
Date: Thu,  2 Oct 2025 15:35:38 +0300
Message-ID: <20251002123553.389467-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtla tools have many instances of iterating over CPUs while
checking if they are monitored.

Add a for_each_monitored_cpu() helper macro to make the code
more readable and reduce code duplication.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.h        |  4 ++++
 tools/tracing/rtla/src/osnoise_hist.c  | 28 ++++++----------------
 tools/tracing/rtla/src/osnoise_top.c   |  4 +---
 tools/tracing/rtla/src/timerlat.c      |  9 ++------
 tools/tracing/rtla/src/timerlat_hist.c | 32 +++++++-------------------
 tools/tracing/rtla/src/timerlat_top.c  |  4 +---
 6 files changed, 23 insertions(+), 58 deletions(-)

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 355f113a14a3..68cf1c20cb5c 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -107,6 +107,10 @@ struct common_params {
 	struct timerlat_u_params user;
 };
 
+#define for_each_monitored_cpu(cpu, nr_cpus, common) \
+	for (cpu = 0; cpu < nr_cpus; cpu++) \
+		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
+
 struct tool_ops;
 
 /*
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index dffb6d0a98d7..844f0468953c 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -247,9 +247,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -278,9 +276,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -292,9 +288,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -307,9 +301,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -325,9 +317,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -362,9 +352,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-			if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-				continue;
+		for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 			if (!data->hist[cpu].count)
 				continue;
@@ -400,9 +388,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 95418f7ecc96..defa1eb63bee 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -243,9 +243,7 @@ osnoise_print_stats(struct osnoise_tool *top)
 
 	osnoise_top_header(top);
 
-	for (i = 0; i < nr_cpus; i++) {
-		if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(i, nr_cpus, &params->common) {
 		osnoise_top_print(top, i);
 	}
 
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index b69212874127..28ea4f6710c1 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -126,9 +126,7 @@ int timerlat_enable(struct osnoise_tool *tool)
 
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
-		for (i = 0; i < nr_cpus; i++) {
-			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
-				continue;
+		for_each_monitored_cpu(i, nr_cpus, &params->common) {
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
 				return -1;
@@ -221,10 +219,7 @@ void timerlat_free(struct osnoise_tool *tool)
 	if (dma_latency_fd >= 0)
 		close(dma_latency_fd);
 	if (params->deepest_idle_state >= -1) {
-		for (i = 0; i < nr_cpus; i++) {
-			if (params->common.cpus &&
-			    !CPU_ISSET(i, &params->common.monitored_cpus))
-				continue;
+		for_each_monitored_cpu(i, nr_cpus, &params->common) {
 			restore_cpu_idle_disable_state(i);
 		}
 	}
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 606c1688057b..02d3ffd2cf4b 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -305,9 +305,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -359,9 +357,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -383,9 +379,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -413,9 +407,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -443,9 +435,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -490,9 +480,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	sum.min_thread = ~0;
 	sum.min_user = ~0;
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -639,9 +627,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-			if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-				continue;
+		for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 				continue;
@@ -679,9 +665,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fc479a0dcb59..607b57f2f231 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -459,9 +459,7 @@ timerlat_print_stats(struct osnoise_tool *top)
 
 	timerlat_top_header(params, top);
 
-	for (i = 0; i < nr_cpus; i++) {
-		if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
-			continue;
+	for_each_monitored_cpu(i, nr_cpus, &params->common) {
 		timerlat_top_print(top, i);
 		timerlat_top_update_sum(top, i, &summary);
 	}
-- 
2.51.0


