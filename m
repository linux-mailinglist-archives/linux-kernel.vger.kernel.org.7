Return-Path: <linux-kernel+bounces-887920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BA5C395D9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67D3C4FE671
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A0E2DF15F;
	Thu,  6 Nov 2025 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nQDTx10"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9992EACEF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413182; cv=none; b=Hv9wyVBF53G79AWLxOIyKFC5bOeQKtNLeTh3U+623j08XAkhF/P3A+UaZE1CA/U96GVCDg1U/VT6hu7G+tT9LPRErY5nJi2urCQ1IxmKVm+O1QEAorCxX2CFtbeetzSZ9WAnfhd6c4MGU3WqefxD/nZNI0FBpILMZQJAQoX4wvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413182; c=relaxed/simple;
	bh=iP5yCD4lNJBZ54VXCnLo6TAsw5GH2qBuAbNIhmsoFCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HJ3gslKMLh4xjR5R4/VL/r2M1Q4liBICtmw+uo7WBnlzDzyikJESL035RrJ4dlXJdIcVnMUaZNrc6bXd8PP8JRVwQ6/DoXv2+eR5PnxXUAQKa5KY1cj7PG3fu6YHz1mS5Dv/QZ0Rc2z0QZ1LedtcNQCmC5arFmLJzmH9QK0kEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nQDTx10; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471737e673so130409a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413180; x=1763017980; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3mUC9sPFouhj1rBALiYO4Qb6Uq1xN1oWTquV7EiCFw=;
        b=0nQDTx103mQetrXofg38pcjMLu542t1FIGiGdwXf/ssWhgwIoEoieHlAA296Z18Yho
         ri8fSQpu6h3I8hCcQkorsnUj8kDuw/IAXsXqmXqB+LwHQToBQkN2NXvfNlgRaUJc9DkM
         xlGj3qINbxGIOVRUzYemXGtVFHh62OVJrBf0gBWe/SsgMaHnHMGsD+dPq0YsKfeq+ZL7
         sDmR5WJqiC+j44Og47LxJgWrVBcTnVvBi4yN/YFJiBm1D6IWBmW/SzWFxCjhD0cWc9L9
         xK995CYIBj18uweCyMOVUiCZykqRUN25kC3jHv01IycVzeXm9/vbCiZXotly1okHY63w
         ATKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413180; x=1763017980;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3mUC9sPFouhj1rBALiYO4Qb6Uq1xN1oWTquV7EiCFw=;
        b=sns6cd1fLBF8HjwUITgG5fUDfsbz9xI9fI4GINCb/MPwtycTUD/7zBI/iFmnwHLW8U
         eVV3eScdADwIyXI4VO8mnLbS+fRzw5f+SzuUnjW+R1avBv8MV2DtBqDOF7Yv3XXNn/gV
         xEyrf7Qrzs8xsV8607PAKBxYpcRpSJGjq2GXosK/jf8ck/XGpZk+fzxtkECQfh1R8OSN
         2G4HTiS8NeEB/+32661IaOnNQe1s1vg8X0HONSD/8HwuniHgfgHVb3xQxgZyJdYrt0RN
         +2sMR1XvINqoxjAwpFD+deX8P4qKKG6R1pELiguDykgLHnr3HNBcasl7aFfubZauIFSU
         5lYw==
X-Forwarded-Encrypted: i=1; AJvYcCXR/Bo8E3U2/Qg2iqhkTJm1OJCzYbF6jTX43J7YTlHPGEdQj7atr8s4Zwwk9x8qBYIi61bxG3tHKPo04F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOeIDI3qBm8pEWv7erhVl572Ugf81HkFpQZyf8i9uTKQn98ZH
	ncCe4xDiwnCJPuTd1J4gpJuOnhMZOnCNbYlAhrWEAcxWy4fRwIwYPuvRa2G3oFfR6Qn6GeIxIyZ
	yTD8Tap/25Q==
X-Google-Smtp-Source: AGHT+IG4sIhbJsW2cMjujNFWdXTnrQvTWPxQtMzU7mQ4Vd/UmEodRv7ANnAPYqSxmGy75vD+p+QmxdkA76f1
X-Received: from dlbdt2.prod.google.com ([2002:a05:7022:2582:b0:119:49ca:6b8d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4306:b0:346:331:97e4
 with SMTP id adf61e73a8af0-34f87301a42mr8511687637.56.1762413180476; Wed, 05
 Nov 2025 23:13:00 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:39 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-9-irogers@google.com>
Subject: [PATCH v3 8/9] perf stat: Read tool events last
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When reading a metric like memory bandwidth on multiple sockets, the
additional sockets will be on CPUS > 0. Because of the affinity
reading, the counters are read on CPU 0 along with the time, then the
later sockets are read. This can lead to the later sockets having a
bandwidth larger than is possible for the period of time. To avoid
this moving the reading of tool events to occur after all other events
are read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 29 ++++++++++++++++++++++++++++-
 tools/perf/util/evlist.c  |  4 ----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5f31cd5bb03b..75ff08c5f0ed 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -373,6 +373,9 @@ static int read_counters_with_affinity(void)
 		if (evsel__is_bpf(counter))
 			continue;
 
+		if (evsel__is_tool(counter))
+			continue;
+
 		if (!counter->err)
 			counter->err = read_counter_cpu(counter, evlist_cpu_itr.cpu_map_idx);
 	}
@@ -396,6 +399,24 @@ static int read_bpf_map_counters(void)
 	return 0;
 }
 
+static int read_tool_counters(void)
+{
+	struct evsel *counter;
+
+	evlist__for_each_entry(evsel_list, counter) {
+		int idx;
+
+		if (!evsel__is_tool(counter))
+			continue;
+
+		perf_cpu_map__for_each_idx(idx, counter->core.cpus) {
+			if (!counter->err)
+				counter->err = read_counter_cpu(counter, idx);
+		}
+	}
+	return 0;
+}
+
 static int read_counters(void)
 {
 	int ret;
@@ -409,7 +430,13 @@ static int read_counters(void)
 		return ret;
 
 	// Read non-BPF and non-tool counters next.
-	return read_counters_with_affinity();
+	ret = read_counters_with_affinity();
+	if (ret)
+		return ret;
+
+	// Read the tool counters last. This way the duration_time counter
+	// should always be greater than any other counter's enabled time.
+	return read_tool_counters();
 }
 
 static void process_counters(void)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b6df81b8a236..fc3dae7cdfca 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -368,10 +368,6 @@ static bool evlist__use_affinity(struct evlist *evlist)
 	struct perf_cpu_map *used_cpus = NULL;
 	bool ret = false;
 
-	/*
-	 * With perf record core.user_requested_cpus is usually NULL.
-	 * Use the old method to handle this for now.
-	 */
 	if (!evlist->core.user_requested_cpus ||
 	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
 		return false;
-- 
2.51.2.1041.gc1ab5b90ca-goog


