Return-Path: <linux-kernel+bounces-590474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6DDA7D34B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 07:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F176B16F6E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 05:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7DD225A2C;
	Mon,  7 Apr 2025 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShrBdcFG"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD041225760
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002098; cv=none; b=nIgitfBFICKG4yc4LzgfjIZBjCdcjz1GA2nGJrNxhk4uIMJnlbbSZVr/bi9SKqLAKpoHeNTxUpQbAyJhZim1LpdLTcuPxdsjNzuCPJ5ZUEFS0qAqRJW0S4I+AmxFSZH5gmO/7mAL4QqCmLROYeVGihX/Jweo+ZbNauJ+gb2hQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002098; c=relaxed/simple;
	bh=cdG1DckkHDj22sHpK9HS7gWTsrY/18LLLL+7/8X5MXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=h9dE0WZdz4Tvu2WP/cabZcBuNwGnkKRrpgRxy5uyEmni8ftEt03GckhE5TTW6sjhXSLdQc4OCcc+u96FvhLfl7wFgE2UAYzVRG+o9jNUyiiKsf4HiWh/y243xox++SZGej8ajJ1ukbYrAOTeqtTlkUc63Ar1m3u7VSXNDaltF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShrBdcFG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso6263989a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Apr 2025 22:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002096; x=1744606896; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UO5h79lqUTXSxHoC3YRlFA2RD9CJ36+9ihWt0OUyzC8=;
        b=ShrBdcFGkKQ6De+Za/nMr75nm0uaeChwouipPXqfrgk0ZhS6JFGvS7n7srB8/LIwrx
         /obZ2+Kvp3MgTrLJ8Godr98MW98LAtNnwEwZNefVU5BACZ+wBgRlLQSCo7b1uvEgblN9
         xiFS7bmvIzxL+aSZAIQy2q2Ckoz8Px+DDvpRvnPK5CFbU4WqrhaaA43VVHjbmkw/5nTL
         6l9Gj9Pv3vRHyPXUkQsEOEw5lDjXh8710TKKiMt/ZgSLmIsCUN+Ak0wDQ5TCq+1CXpnC
         EQ5UehezGdUBPXcXX9xjiL6IEW0jRfr6tvnhJtYT8yVcM5EYXNp7glKE4U1BGp4NPzKb
         0jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002096; x=1744606896;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UO5h79lqUTXSxHoC3YRlFA2RD9CJ36+9ihWt0OUyzC8=;
        b=xRjlhFgMNh0ZkPrGHjIvvm6gtiSxPDYcA0YD05Nw/p8349ZkN7CYO6O38bkqSGM3yb
         mYedD6Bee21R5pIkx2mVIc2mEQv02KaUkepBzOmm/BNj6i4ys2tM68cClUhABKQCamiq
         gTtTSWtvoTDUFG14QaLUiXCrgv5s1twBtqEKHH8WG1WnOuG0uW8RrciT8qK3LyumKMrn
         wXXW0bFPcXd9lb7DXZVhLxBMJzbaJ42F3zoJ4j7/ZU+UihxRBD96Zq+/dLf4tocJv0eT
         4Bpxg+RIAXbv9RFNZzQrV+2PtcUYKoYU5ChPDYjETOqFjk5WrC/EWJ2/yCQe1Dw1ysFc
         I5cA==
X-Forwarded-Encrypted: i=1; AJvYcCXTj2UNo4Pe5a6M0mfEm1T3Yudciv25620QJ8BeHxSVqyJfuKURf18TFDk3ATuIwAfz/YGw32BX3EIhHA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGlPBDhsXnjnYmztuqGleXIGcReiunXgXuxKLl/1pq/SemHUj
	t37B1ya/voL+w4uqXT1mK0LpkiOx5SLeYyRy7nERZ3H9ctr9PSw70mJmXGbVzYpOo6oW/TFsMpA
	3h1drgw==
X-Google-Smtp-Source: AGHT+IEUIVPhcPoDAWrNPs1N4IkmDKTBlxiHPpQRkoSscSY32F0ELyCbQNdYtUVIauqh3ttX3+wf1XVVEG9S
X-Received: from pjbph11.prod.google.com ([2002:a17:90b:3bcb:b0:2fc:3022:36b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3503:b0:2ee:5958:828
 with SMTP id 98e67ed59e1d1-306af7303c1mr11734046a91.9.1744002095763; Sun, 06
 Apr 2025 22:01:35 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:00:59 -0700
In-Reply-To: <20250407050101.1389825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-15-irogers@google.com>
Subject: [PATCH v2 14/16] perf stat: Add mean, min, max and last --tpebs-mode options
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
index f9584b00fb05..e1bdab4bba6f 100644
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
+		val = rint(t->stats.mean);
+		break;
+	case TPEBS_MODE__MAX:
+		val = rint(t->stats.mean);
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


