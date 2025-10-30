Return-Path: <linux-kernel+bounces-878788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A8C21789
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAE954E64D3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04883678D5;
	Thu, 30 Oct 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vi7jXVev"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75902E339B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844906; cv=none; b=sTkZeoJGGLCwZsIYVmi9VB4hw/FONeIggqhEle44YXxDZDGn5XTxkrFRNRzqn7FOS6CjF9B/xa2MaKdaWHS6BCoG8Q9iyl7ts5k74fUcjnKCb+Yzl7GeJJIo1HLdwpTyHgtR+HvS2UaoO0ztQczzhmKy8X32SMpMQAvs4Q6Rn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844906; c=relaxed/simple;
	bh=M+lkD0z2101EZTsNHSvQtIO2IpVhP4TmImyUnZxYJlQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=XCA+tsJrQ1GRJsvPBgcRyJObSFCV7XhExS5xW6jPg5ptukoSIwVqFBjDZv6g4hYy+3VSEbrA5sXbThXuHVNcTrKfbPAa2xZDJ8EgG6lT1rchZoSINn8pD8TZQ3fOrMddrcwhKwwJXJHNd8fS6bPnmdHpG41GH1Np/Y8hGhgrn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vi7jXVev; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so2865692a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761844904; x=1762449704; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1PEydywGHVT2WukPesarSlbXobm+ff+b++EOi4BTyU8=;
        b=vi7jXVevZSYwu8yma4nYdS0WzksLMTwUE9Xhi2rM8JugnJkjky4Q0bpahAU33QPdo2
         T7bZ3aDqOcxbQRHOuaAecmHevdGH5z2n/2gZy9w6jHrtSgE07hh5kxbexIl6AvYRjST4
         nJmImpzX3BEzJFm4UW/IXAoXstSFRUT09TtxxKmQBv7nal7EsklH7ps6mxhgy+E9sKiO
         BQcCd/Wsbys6TNK2OFL4/fLiYfLHSC/6dITqL0UDECzPx7O8jl1KNrF8tNv5qr4ei1X4
         38pb7CehW/SqGuEpa4FHbMZJUf5SWxvNSEyma1pqQS8qiRshxZjouklVMFmtOajNBtQ3
         s/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844904; x=1762449704;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PEydywGHVT2WukPesarSlbXobm+ff+b++EOi4BTyU8=;
        b=vLMT/2ffdXnQGz3wDzhhtSgmZ/Y8+eVh+R7iCO+Xl3MrWWEk19TRTm+Hzk8qSe/TmU
         Cluy3tV8rmqoxYGNJFyeb1p28wOJCfObyEfLlpjyjW6U//pcz5Y9+T5DX5F/6gUkBins
         gHNvtfU8BicTlq041pkt6Cpi4MaxP9f5nDoCJcyyuvmaUx0muND2AUHuWSYifKuEZPr1
         d4kVWNhEod+zjzpW5/GkHzNvm7jqf5Z57MrnKDFicoaivJoadFV9980p+qzEckDdKm+o
         QUPBMMS2DidmkUFtSkH+q8F00DJtHNCP/JU90hyeYbtgtxrRwVFZrAb3is1pE+Y71REy
         PARg==
X-Forwarded-Encrypted: i=1; AJvYcCVyvFxxaI4YlrOttNqU/j7UwqCeJVDWwVlwsm20wxPbB4bXlQBgdWHELCIYfTv6peczFISV9OeCHqN/4fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEUqz7Wdxit3eHaW5lB7xKTPMhf5HQXLnJXftE5hub32J5mee
	NoKd1JwSji1AwZFolHjdziKseeS7x0WzGZxSXbJVtdsjlHrV0jh1EjcZWPpOSVxOyFABo+g34SX
	p/3DR8Dyztg==
X-Google-Smtp-Source: AGHT+IGUU15B7H38ssSxFVgrFeKI92IY5bfaTIKG3VRo7CD4WQ2pJO8GQ1DIaBrFloEwYObPEcH0tuSm3K9v
X-Received: from pjzb21.prod.google.com ([2002:a17:90a:e395:b0:332:4129:51b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40c:b0:32b:623d:ee91
 with SMTP id 98e67ed59e1d1-34083070e35mr580511a91.27.1761844904010; Thu, 30
 Oct 2025 10:21:44 -0700 (PDT)
Date: Thu, 30 Oct 2025 10:21:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030172140.1113556-1-irogers@google.com>
Subject: [PATCH v2] perf s390-sample-raw: Cache counter names
From: Ian Rogers <irogers@google.com>
To: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Searching all event names is slower now that legacy names are
included. Add a cache to avoid long iterative searches.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Closes: https://lore.kernel.org/linux-perf-users/09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
--
v2: Small tweak to the cache_key, just make it match the wanted event value.
---
 tools/perf/util/s390-sample-raw.c | 56 ++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 335217bb532b..f5acf6dfa8d0 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -19,12 +19,14 @@
 
 #include <sys/stat.h>
 #include <linux/compiler.h>
+#include <linux/err.h>
 #include <asm/byteorder.h>
 
 #include "debug.h"
 #include "session.h"
 #include "evlist.h"
 #include "color.h"
+#include "hashmap.h"
 #include "sample-raw.h"
 #include "s390-cpumcf-kernel.h"
 #include "util/pmu.h"
@@ -132,8 +134,8 @@ static int get_counterset_start(int setnr)
 }
 
 struct get_counter_name_data {
-	int wanted;
-	char *result;
+	long wanted;
+	const char *result;
 };
 
 static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
@@ -151,12 +153,22 @@ static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
 
 	rc = sscanf(event_str, "event=%x", &event_nr);
 	if (rc == 1 && event_nr == data->wanted) {
-		data->result = strdup(info->name);
+		data->result = info->name;
 		return 1; /* Terminate the search. */
 	}
 	return 0;
 }
 
+static size_t get_counter_name_hash_fn(long key, void *ctx __maybe_unused)
+{
+	return key;
+}
+
+static bool get_counter_name_hashmap_equal_fn(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 /* Scan the PMU and extract the logical name of a counter from the event. Input
  * is the counter set and counter number with in the set. Construct the event
  * number and use this as key. If they match return the name of this counter.
@@ -164,17 +176,51 @@ static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
  */
 static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 {
+	static struct hashmap *cache;
+	static struct perf_pmu *cache_pmu;
+	long cache_key = get_counterset_start(set) + nr;
 	struct get_counter_name_data data = {
-		.wanted = get_counterset_start(set) + nr,
+		.wanted = cache_key,
 		.result = NULL,
 	};
+	char *result = NULL;
 
 	if (!pmu)
 		return NULL;
 
+	if (cache_pmu == pmu && hashmap__find(cache, cache_key, &result))
+		return strdup(result);
+
 	perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/ true,
 				 &data, get_counter_name_callback);
-	return data.result;
+
+	if (data.result)
+		result = strdup(data.result);
+
+	if (cache_pmu == NULL) {
+		struct hashmap *tmp = hashmap__new(get_counter_name_hash_fn,
+						   get_counter_name_hashmap_equal_fn,
+						   /*ctx=*/NULL);
+
+		if (!IS_ERR(cache)) {
+			cache = tmp;
+			cache_pmu = pmu;
+		}
+	}
+
+	if (cache_pmu == pmu) {
+		char *old_value = NULL, *new_value = strdup(result);
+
+		if (new_value) {
+			hashmap__set(cache, cache_key, new_value, /*old_key=*/NULL, &old_value);
+			 /*
+			  * Free in case of a race, but resizing would be broken
+			f  * in that case.
+			  */
+			free(old_value);
+		}
+	}
+	return result;
 }
 
 static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
-- 
2.51.1.930.gacf6e81ea2-goog


