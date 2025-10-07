Return-Path: <linux-kernel+bounces-844671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991BBC2763
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D494189E2AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455372E975F;
	Tue,  7 Oct 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGn/01XP"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48221207A32
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863512; cv=none; b=nfnyNWGyxTbI76hxOCghb5hA8uKtBcVV93/9bcOtW4Qgma2w+kX1FRBa3vUaBpWL5n4T55bAAjkaXvygzlfaXcQpkVeJ30ek9Oqg7OZi+5tdcRFy4bbTxugMXFjZNMxJQ16PkWupm5ru7uU+gYDDKVHwKAJu12edgMFRhtEqoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863512; c=relaxed/simple;
	bh=4Mi7uRK7A1S38mqbmd/1UsnjkPnCPmWXsk+4pk4VVTs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=VUbNVcHSr+RhuBswM8GRKbVpJPyR35D0aQD+rsrM/lS0QcbFxo7C6OnBi0hJTrkmkCj5yybVKFj0h+9jq0i1gmlGBrAMQLKBbAs9bq/ihOEwOGpSPXHW2/jRw/b+3yk/YQxTffGELdhQ8p9GorrcXpdipl0PsOy36zMGK7S9uuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mGn/01XP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b522037281bso4621295a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759863510; x=1760468310; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9l2SyKdGNaaltnxA95zYj9HNyU/24ObaiyQuMAUtumQ=;
        b=mGn/01XP1fVvds0BtY9Rg+uIfFXjFrpxgDsTi1Fx8Jy8KAlJ7rLZbN6tFK3STowmEi
         U4x5R4CgdD7okkp7HC9R1Y4kct7XRe42sj623K4uDBxW9dlhRP6TsGn/Y8MOPylf1SPQ
         evHuRKFHG2eMJvA5RDGv9OSzamg1fbBiqByl3ZfgYKKvqWKL6vsKEz4gyfkiLKcSmn6t
         pvlXHjXi6R39/8+Bd+TwT5Ek7n/9XvaAkPkh3jNWuQrnEcJnz/ihYGjdqNdiA3/avDa6
         DiwugApt8EKVdN+4MtCS1IRtMBmhKJ/CZB6nsOjRNBvdyFDdC8b8jlPl8jssLi9kU7+t
         qw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863510; x=1760468310;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9l2SyKdGNaaltnxA95zYj9HNyU/24ObaiyQuMAUtumQ=;
        b=BGBXJfByLjityUnOy201trU2od5YJJHqVRG+eS4ldJ1UbmeZwWeHRLkAy6JSRDp4ty
         Atw7i7/UkfovicbDX78qV+Z5fOFVd48BkZvOuKR7Z3yAKHStUKD7U7hUP+RcGGbWNVvG
         n69QYwGdP4MDCDe5EGVxq/Vu74Wef0d1ChdBo0vEw6AVQqc/Nh0Tt6QfqiVYYHhZqhMD
         tsAOPa6Gzw+MFmkA9hgS5PX2qtJtSsvNZKJ724k+mJTJvPn+Od/dZRzYNtlhS/54bILE
         mAVXOkHXm/Zhn5MeTdg8Ppo0PrV9Gw8OHD1fdEQta0s1j+EaVqRu9k2CkG1ZaxZxD7a1
         RSRw==
X-Forwarded-Encrypted: i=1; AJvYcCXo0ItBQNlAS11mKbc5cKdC/OY9rq17RyvWeh8BzTaZTWhHhXiQ2uPhg3vbNhrGWA7asgyOjqeKv07GDeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywGRuZEGlXQlAZAcxZzyF9yA+Mt4URmSPaKA+6aOamE/tZ1xBT
	2tEMX6K2VGo64/4cDHE6ahnYii3hKyAvebPO0+ErCiZe+cvPonuf0/S90U6BaNJSgILUeas9/di
	jHBMK4xMB/A==
X-Google-Smtp-Source: AGHT+IHZy0Sj/O8eRFg4d0/zb0YyjfprMYz78i+5iwxXo621yPeZXXsoeFbTafZQjs7ObLXeCVfQc1QmDIGE
X-Received: from pgau5.prod.google.com ([2002:a05:6a02:2d85:b0:b62:c5e4:3f80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1590:b0:2e6:a01e:f212
 with SMTP id adf61e73a8af0-32da839f8c6mr638859637.35.1759863510661; Tue, 07
 Oct 2025 11:58:30 -0700 (PDT)
Date: Tue,  7 Oct 2025 11:58:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007185826.3674908-1-irogers@google.com>
Subject: [PATCH v1] perf bpf_counter: Fix opening of "any"(-1) CPU events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
wanting to aggregate a count against a CPU, which avoids the need for
atomics. Force evsels used for BPF counters to require a CPU when not
in system-wide mode so that the "any"(-1) value isn't used during map
propagation and evsel's CPU map matches that of the PMU.

Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 12 ++++++++++++
 tools/perf/util/bpf_counter.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7006f848f87a..7fdc7f273a48 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2797,6 +2797,18 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
+	if (target.use_bpf && !target.system_wide) {
+		/*
+		 * Setup BPF counters to require CPUs as any(-1) isn't
+		 * supported. evlist__create_maps below will propagate this
+		 * information to the evsels.
+		 */
+		struct evsel *counter;
+
+		evlist__for_each_entry(evsel_list, counter)
+			counter->core.requires_cpu = true;
+	}
+
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ca5d01b9017d..d3e5933b171b 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -495,6 +495,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	 * following evsel__open_per_cpu call
 	 */
 	evsel->leader_skel = skel;
+	assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
 	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
 
 out:
-- 
2.51.0.710.ga91ca5db03-goog


