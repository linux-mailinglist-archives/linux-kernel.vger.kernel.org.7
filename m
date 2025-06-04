Return-Path: <linux-kernel+bounces-673635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BE3ACE3EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 19:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29078166E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1465F213E7B;
	Wed,  4 Jun 2025 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ygM3e3pH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1920F079
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059171; cv=none; b=u2odwYRVXO70LqRdSHzxkrpnNOdbpac706XqMHQ9bIKcirl4nHlddDH6K7QrmbWvhN02oeRTuNFdNxnh30qfW1Wd0FCi24ZquBRrrNeN1l9Rk2vV3BX0RVlCqut1FzBOrhhZw47bzZ43cbLF3/0JEVOhhBgk7SZwFF6idXLshts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059171; c=relaxed/simple;
	bh=d9juix98O43SIeDaPmSOphkP7ZXR2ZbNDk+z7RkJZkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dmVpAwU/IIwrBSPppDONzPvTkfkr9/oeYmq5D1TSFSjMa6HoEKthURaSwbM2Wnhx/6ha3+Lm24cPQkAKbArvbiJlJuWoY6+OqqEQE3/T+KVQv8IKcNArhPnZlCc73ABMmViMuJXdKfOzczYgqrPbJhTP17EcSW4oh1Plws2+NGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ygM3e3pH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-310c5c2c38cso96899a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059169; x=1749663969; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAlx8zNG9Ixb3Z/jfW3REJxbhMy4ISbpvyCxG91X8vI=;
        b=ygM3e3pHN/3DbEtIjcwSC1D+jhrnFVW/5+eD3pRX76HA6PBlvfK7Z+gaf2Lzb0BDAh
         qN3aFrfS1x65ka9FLPhy/iM3g/exN7cKupf/91iH3doam+h3EvDWckxZ2nX2cK/q6x3D
         KOjsJqWbYJdAUjZUk2xM+bf+9wKVKYR7nxGUFzQQNJg7ZQGi4tZ7LB1vqQpB2KKu7ueh
         f6pfV8AgLylHxBnDdM4F0h8eh+gPT5Mvl1jQL+Pp8TRQ0OUVWLY/V3DRvwRBkHxwnp6I
         DF/tp26onCW2EO3lCKtf8Z4tYwATno89mSrwb4DL93mVRbXjVGNJZ+1TJBvcxecdp8tC
         mAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059169; x=1749663969;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAlx8zNG9Ixb3Z/jfW3REJxbhMy4ISbpvyCxG91X8vI=;
        b=Ky//6bLCE93WRNIcBNXW87IoXsdZx3UkzT0r5SruL1UqCrzoYW6WuSfjuc1EUeNM92
         XroWLt8mEiJJI6y42wLR5G5M5Cb9V43+XqBvvT5BctYJ1uICA3vPOzGk4/jYqrSjcAcs
         klP7b8tWO5+bSVtyrFzJyBcrWuH8J8Vrl9yqHE5CKGGSRYfEVvSBmsaKfDpvdIY9Kmwb
         a8N6oVs2ljSKI0LBW1Ef1S4RjPJnk9GbujBcIWoa8QLweSTvkMETPBlDpuw2/aRQozHa
         1dFHTVpRbGhNxjy7LB2zih9WRHKoHcfQeeW45mWs3+7URqepbq4KFk7E3VTpO33beJm/
         1evg==
X-Forwarded-Encrypted: i=1; AJvYcCXMpgSgiSDo35L0e2gpAJTBj2DddJN/XP9PmWbnGlCQs4I7EPvP7GlGGQiTyv6fUX79BIDdhE3/YkUYtdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyliY36byPovjZovVhy7ZKe5M7fNzxzcwwCDlspJt+56NtZCXfQ
	/pRDTXhoBfQJ6yIWUIF/U6sLXEopbfOYj0qhTwfrN7GFGAoFJHVQxJLnrGe/3+jPzFffGbaP5zF
	BloczUIvgkw==
X-Google-Smtp-Source: AGHT+IHUp4wLf3y4OcqJf4camFo5SZWceEct0rB/6bCOouHb4ABfjjX1omDtqmZJ8nOhmTxqcz04b2Rgomb8
X-Received: from pjbnb5.prod.google.com ([2002:a17:90b:35c5:b0:312:1900:72e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c12:b0:311:eb85:96f0
 with SMTP id 98e67ed59e1d1-3130cd4d794mr5696673a91.29.1749059169329; Wed, 04
 Jun 2025 10:46:09 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:40 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-7-irogers@google.com>
Subject: [PATCH v4 06/10] perf top: Switch user option to use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 22 ++++++++++++----------
 tools/perf/util/top.c    |  4 ++--
 tools/perf/util/top.h    |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7b6cde87d2af..051ded5ba9ba 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -643,7 +643,7 @@ static void *display_thread_tui(void *arg)
 	 */
 	evlist__for_each_entry(top->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
-		hists->uid_filter_str = top->record_opts.target.uid_str;
+		hists->uid_filter_str = top->uid_str;
 	}
 
 	ret = evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
@@ -1571,7 +1571,7 @@ int cmd_top(int argc, const char **argv)
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
 	OPT_STRING(0, "prefix-strip", &annotate_opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
-	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
+	OPT_STRING('u', "uid", &top.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
 		     "Don't show entries under that percent", parse_percent_limit),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
@@ -1762,15 +1762,17 @@ int cmd_top(int argc, const char **argv)
 		ui__warning("%s\n", errbuf);
 	}
 
-	status = target__parse_uid(target);
-	if (status) {
-		int saved_errno = errno;
-
-		target__strerror(target, status, errbuf, BUFSIZ);
-		ui__error("%s\n", errbuf);
+	if (top.uid_str) {
+		uid_t uid = parse_uid(top.uid_str);
 
-		status = -saved_errno;
-		goto out_delete_evlist;
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", top.uid_str);
+			status = -EINVAL;
+			goto out_delete_evlist;
+		}
+		status = parse_uid_filter(top.evlist, uid);
+		if (status)
+			goto out_delete_evlist;
 	}
 
 	if (target__none(target))
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 4db3d1bd686c..b06e10a116bb 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -88,9 +88,9 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	else if (target->tid)
 		ret += SNPRINTF(bf + ret, size - ret, " (target_tid: %s",
 				target->tid);
-	else if (target->uid_str != NULL)
+	else if (top->uid_str != NULL)
 		ret += SNPRINTF(bf + ret, size - ret, " (uid: %s",
-				target->uid_str);
+				top->uid_str);
 	else
 		ret += SNPRINTF(bf + ret, size - ret, " (all");
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 4c5588dbb131..04ff926846be 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -48,6 +48,7 @@ struct perf_top {
 	const char	   *sym_filter;
 	float		   min_percent;
 	unsigned int	   nr_threads_synthesize;
+	const char	   *uid_str;
 
 	struct {
 		struct ordered_events	*in;
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


