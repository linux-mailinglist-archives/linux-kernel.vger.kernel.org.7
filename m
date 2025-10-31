Return-Path: <linux-kernel+bounces-880587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53534C26171
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492AC1B20C61
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BE92FD684;
	Fri, 31 Oct 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqvkS52U"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6BF2FBE1D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927140; cv=none; b=DzGrEjaCMnBRSJpQX+cudL3/W1QuQhfs3d4Xi1jfp/lKYVGW0g7wuIVdRAYH1zndxJfhEJuww9TNC6QHKyPDZi+gpyERrZxt9fTeeZCOccNnCRRZIGiqaAA7ZRaCkjmV9JPN5HujtIFIdDxR6FuGSMjdLcnfrseydVthUHJjabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927140; c=relaxed/simple;
	bh=EWOQMT+JKd/Top0TeRgZ/qc0hM77pODoeMMWw8NLJt4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=p4JYr+ZMr7DWclK7JsF7gTlrZ9kgvEfYMOCx8iPXa9PdqdiEYd+qpzzui/mlMgJm9VmK7DOQ0tpqkpNoaDrSaFeNukSyGnVqQHqCMtr3kQeGdIQtiqy/FyAHZIDJHlKIwb6jXoMlS/Lft4J9Y9cxt/oIE7ILB/dnrZmRbePQYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqvkS52U; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32edda89a37so2360381a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761927138; x=1762531938; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T6/09WGAJAn8LAn4YiRmu+c8rt+gg84XRjAXswJ2pws=;
        b=tqvkS52UhVTYJnE70FsP6akmSiHm21r47RmNU66pR8Ym+SmjyJo+5TkzuisIHRaOaY
         sKmovpnU1E43d7/bQObMzAPy2L70B7K6TjN1YDdmzcQgZ67NviPlzB1K8JeE3vuRd9IW
         GKvQWNLQ3ekL/+ag1+BGse94/043M0x5qGHbiJdPpf1qvb4nqGJjbmuCjsWFu2GoNPxL
         Wwi0Xygu9IgnqMlWzQso6ttfECXOEAP7v/88J+6fV2bZKA9r8pNCHITzlcBas5y66z/X
         ncofEw9uWVtIf9RA5u3BOZp5/d1pMZdbbcbH6UQpnMuQKpAE/XDAdAyn4IWjxeetDOy2
         5rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927138; x=1762531938;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6/09WGAJAn8LAn4YiRmu+c8rt+gg84XRjAXswJ2pws=;
        b=MltQMLjYLJPTT0D2YZlPFga/nflugOs0rtNNsVxtx4T4mlNFrbovLagwJYfwiEKK+p
         cJfN4lQAjrwLf4hGdmUV4DKbSGKe3Y9N/xUXVZv+lrqvT0ywYA7yi4nYDYQwBZ0l1Dx1
         Yl1WPzdB6XObKwA2OSOJVq2awHztLV1eZ6DLFnmqQixUnaVPRW8uR5grh57vBpflDNet
         dEG1XPOPchKS/pexFubLqpDyH3rS5HyJ5upWbkIEDz10Ql+c4fqZoMEO134ZhZLRHtKr
         tSAV4EByyIUjW4rrpEH0kaGZnPjzGrRO5txRJJ2Gj3tDQF6Ed3/dZK621l+ejjIrvOMx
         uYTA==
X-Forwarded-Encrypted: i=1; AJvYcCUO5d7X0Dx2zJIboCfjS6xNu9E1oVfvAmA+5SvEyYQJLtMyTzf/rQSlxBzGHfNoDB9BvXu3+VNJRINGbvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfGfLap/5Tqa42f6cHKWWBnj8PgN/5KzW08wZiezcquuRv0RyM
	sdAY478w82AnhNWf2rOvEwmzsCdo2RjbcIeFSpz3mTKR8sPKmHMaPYbeNHe0QOl9rdjQeH5jyD6
	AoJildQ27Uw==
X-Google-Smtp-Source: AGHT+IG+P7uOq+vIIChbnCVPjpGYOpxHBV+jPCpjRvMqQmt1EZMkXmKHh9vsItuAjQGNAiX686IcQ7lE+bC+
X-Received: from pjsf3.prod.google.com ([2002:a17:90a:6543:b0:33b:51fe:1a97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134e:b0:32e:3830:65d5
 with SMTP id 98e67ed59e1d1-3408308c65cmr4613491a91.36.1761927138475; Fri, 31
 Oct 2025 09:12:18 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:12:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031161213.1452901-1-irogers@google.com>
Subject: [PATCH v3] perf s390-sample-raw: Cache counter names
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
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
v3: Fix minor comment typo, add Thomas' tag.
v2: Small tweak to the cache_key, just make it match the wanted event value.
---
 tools/perf/util/s390-sample-raw.c | 56 ++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 335217bb532b..4f269ea7c93b 100644
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
+			/*
+			 * Free in case of a race, but resizing would be broken
+			 * in that case.
+			 */
+			free(old_value);
+		}
+	}
+	return result;
 }
 
 static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
-- 
2.51.1.930.gacf6e81ea2-goog


