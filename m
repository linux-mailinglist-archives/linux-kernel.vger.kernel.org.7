Return-Path: <linux-kernel+bounces-592646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C36A7EFA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D66618984E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F63B2566E3;
	Mon,  7 Apr 2025 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXZQH6Rh"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19072561BB
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060249; cv=none; b=IjRQkTYdKQL3sCmepAA5R1YKbwJu0fAylYZyDdHsym8YKq/JzlJeSlTFShtzhHraAB/rEXILodhBZpPTbGWA/VoKCWedNUeAxgJu4NQirzjBTuxpbWtoDpHq8vcIdaCT1WSJ5LxSdqV2kPtOuaLNtBNYFZ7wUNo9rJ3a+YjxKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060249; c=relaxed/simple;
	bh=j+ajFhze8XNvNedW0+qQsxa4xJpNyLgqbtH3uNHZnh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sLf6q0KMc814U5PcrT6yC6vAFFhVgOcPBtSI9L+dgbtMuann2YTLHyIiA3JV+lID/nbF5viynfOh6kEcdvdWqeJgDA5trXzLLcFTDveEO8FeP8WVB3f9e0I5pKlpqnNeTghe4YBf3r2avP4KGsV5VL58G6Lg2PPWrPKlJaQs1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXZQH6Rh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af91ea9e885so4197482a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060247; x=1744665047; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHpmhSJgyl8CfNQkTk9ozGn6lbmpXan8KmxzNdnU62A=;
        b=SXZQH6Rhw68T0VZ1RYwjBm+YCrN1K5CHQJ8oD+lV/710ZjJWGZq21ThaVOCEbt7vvx
         LgAe4AO+ASMkEyMBFrsP1hqSZA9H33CduUvbVwJBYRu9DclyRXuS47dXZTDQkqVd1o2r
         gmJ4BqVS4wo8LtvWpkYs2A8ArdrliDu4ylZw7wjSk+o+Er4Sjub2DDRE9iM3YY14UG8/
         9lBi3ZpzU4WNVLF30ijvjmqi+AoH78d9YH9JeN6f2TG3YU+zqkiBUYS0qQJHj7tsEIGF
         //ue5StwhfLf6T06OQcqnVo+NsN0LXjR994hMsDd+txqkVdzOnegY+nFm/yndMwLKPGm
         4YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060247; x=1744665047;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHpmhSJgyl8CfNQkTk9ozGn6lbmpXan8KmxzNdnU62A=;
        b=CjZIXcY+Q+KZyCDalRvTVx74zWyFuya/djXz6ZV6ionqcmJ4Zx24SBz5X6aoaApZS9
         xIrarkvh27eKiuYTVPdWEY8zUwwI8BoIjbcIO6PrCbZhkiathwK3gwxWfnUjna4nO78x
         Ril4bGEcEFJ4COQkYARod0BP2GB/SHOAH4mTR3DKmYEy1NgC3RIcvTAkmTlJYdoSbSmG
         dZaNlI81EHHqvkdEIEfZfcQgpC/pm9M773j//jCDmVhV55DQASGi6XPM5TeNhGva1e+1
         eNfy2QbsO7mNybyhovrrpb+L1n/v9c1aufcumOJ7aD9NImSf7RQigov6aBqFkgvjoPEs
         0nCg==
X-Forwarded-Encrypted: i=1; AJvYcCUTQb+F1h/EeL7P3OAI30nlk/Xzh/f34SZ2eB6ODO8Zn9rYunt1pk3Njb7ncwmV+EZV90qFPWnWwUbyasY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5L/wFKh9+TP8mq40qtyIKlv9kkemhxy+PMksDMn9DAPh0G72
	i+nrt87y3f3ZC7yWO6uzFShnE6Ctl2UW0PXnvgFh3Z0rCij3uLql4Yqx7BBbBKwDFknkaFbGv2Z
	PmUKW2g==
X-Google-Smtp-Source: AGHT+IEwSvokNi/bh76gbjqrB9lCNL67U9jQB6qnUBpqgfqIQSvWOOeL5/jsukJeGPYmZaTV7kgFf9IZb7nR
X-Received: from plhu6.prod.google.com ([2002:a17:903:1246:b0:223:f321:1a96])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98b:b0:224:1074:63a2
 with SMTP id d9443c01a7336-22a8a8cf281mr180860945ad.43.1744060247123; Mon, 07
 Apr 2025 14:10:47 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:35 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-15-irogers@google.com>
Subject: [PATCH v3 14/16] perf stat: Add mean, min, max and last --tpebs-mode options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add command line configuration option for how retirement latency
events are combined. The default "mean" gives the average of
retirement latency. "min" or "max" give the smallest or largest
retirment latency times respectively. "last" uses the last retirment
latency sample's time.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt |  7 +++++++
 tools/perf/builtin-stat.c              | 27 ++++++++++++++++++++++++++
 tools/perf/util/intel-tpebs.c          | 20 ++++++++++++++++++-
 tools/perf/util/intel-tpebs.h          |  8 ++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 2bc063672486..61d091670dee 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -506,6 +506,13 @@ this option is not set. The TPEBS hardware feature starts from Intel Granite
 Rapids microarchitecture. This option only exists in X86_64 and is meaningful on
 Intel platforms with TPEBS feature.
 
+--tpebs-mode=[mean|min|max|last]::
+Set how retirement latency events have their sample times
+combined. The default "mean" gives the average of retirement
+latency. "min" or "max" give the smallest or largest retirment latency
+times respectively. "last" uses the last retirment latency sample's
+time.
+
 --td-level::
 Print the top-down statistics that equal the input level. It allows
 users to print the interested top-down metrics level instead of the
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 80e491bd775b..4adf2ae53b11 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2327,6 +2327,30 @@ static void setup_system_wide(int forks)
 	}
 }
 
+static int parse_tpebs_mode(const struct option *opt, const char *str,
+			    int unset __maybe_unused)
+{
+	enum tpebs_mode *mode = opt->value;
+
+	if (!strcasecmp("mean", str)) {
+		*mode = TPEBS_MODE__MEAN;
+		return 0;
+	}
+	if (!strcasecmp("min", str)) {
+		*mode = TPEBS_MODE__MIN;
+		return 0;
+	}
+	if (!strcasecmp("max", str)) {
+		*mode = TPEBS_MODE__MAX;
+		return 0;
+	}
+	if (!strcasecmp("last", str)) {
+		*mode = TPEBS_MODE__LAST;
+		return 0;
+	}
+	return -1;
+}
+
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
@@ -2431,6 +2455,9 @@ int cmd_stat(int argc, const char **argv)
 #ifdef HAVE_ARCH_X86_64_SUPPORT
 		OPT_BOOLEAN(0, "record-tpebs", &tpebs_recording,
 			"enable recording for tpebs when retire_latency required"),
+		OPT_CALLBACK(0, "tpebs-mode", &tpebs_mode, "tpebs-mode",
+			"Mode of TPEBS recording: mean, min or max",
+			parse_tpebs_mode),
 #endif
 		OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
 			"Set the metrics level for the top-down statistics (0: max level)"),
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index de9fea601964..6b00bd5b0af1 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -31,6 +31,7 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
+enum tpebs_mode tpebs_mode;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
@@ -45,6 +46,8 @@ struct tpebs_retire_lat {
 	char *event;
 	/** @stats: Recorded retirement latency stats. */
 	struct stats stats;
+	/** @last: Last retirement latency read. */
+	uint64_t last;
 	/* Has the event been sent to perf record? */
 	bool started;
 };
@@ -142,6 +145,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	 * latency value will be used. Save the number of samples and the sum of
 	 * retire latency value for each event.
 	 */
+	t->last = sample->retire_lat;
 	update_stats(&t->stats, sample->retire_lat);
 	mutex_unlock(tpebs_mtx_get());
 	return 0;
@@ -517,7 +521,21 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 			return ret;
 		mutex_lock(tpebs_mtx_get());
 	}
-	val = rint(t->stats.mean);
+	switch (tpebs_mode) {
+	case TPEBS_MODE__MIN:
+		val = rint(t->stats.min);
+		break;
+	case TPEBS_MODE__MAX:
+		val = rint(t->stats.max);
+		break;
+	case TPEBS_MODE__LAST:
+		val = t->last;
+		break;
+	default:
+	case TPEBS_MODE__MEAN:
+		val = rint(t->stats.mean);
+		break;
+	}
 	mutex_unlock(tpebs_mtx_get());
 
 	if (old_count) {
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 218a82866cee..9475e2e6ea74 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -8,7 +8,15 @@
 struct evlist;
 struct evsel;
 
+enum tpebs_mode {
+	TPEBS_MODE__MEAN,
+	TPEBS_MODE__MIN,
+	TPEBS_MODE__MAX,
+	TPEBS_MODE__LAST,
+};
+
 extern bool tpebs_recording;
+extern enum tpebs_mode tpebs_mode;
 
 int evsel__tpebs_open(struct evsel *evsel);
 void evsel__tpebs_close(struct evsel *evsel);
-- 
2.49.0.504.g3bcea36a83-goog


