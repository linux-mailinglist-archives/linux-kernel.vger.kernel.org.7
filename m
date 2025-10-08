Return-Path: <linux-kernel+bounces-845748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB94BC602B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE6994E730D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC54C29AB07;
	Wed,  8 Oct 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iy7y2qa+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A02288529
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940635; cv=none; b=XWYokIqGqh+pPay5HpjgWFtVSpgV9cOi720rNTas1o/0WmF07y2wshMp4eq5JRGfsOtFe9Nv54zDQZFJsgWXSCWWxFNJe2npjxmIuIp00MTVnrjZrBP7uA+25aQAbWQLyN9kKTlFMokTUMsuaXS2/M821Zk+33DgK+WTGIE35Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940635; c=relaxed/simple;
	bh=R96bbATMZSPb9OIoAzn4ym9WVGJOuOpN7eTc3TttFUU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ChlIuWOFGfrIzdDzpeaCbyZ4e0b5M9pa73PLUa8cg5sTqG8TvFeowpReGsRSxaUYvjGiIbY7Gwl7QphpUbxOG+OKLeX65rDffZpuN526+TEC6lJ5YagqVk1p35Uh8uEIvi4aei89A0x9lnJBmc51jKt1ri558iv9/f2+fMQk0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iy7y2qa+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2711a55da20so28095ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759940633; x=1760545433; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wRJXz112Re1ju3vdnrYT2DZaPKwj05gRwzq+1yeUNKs=;
        b=iy7y2qa+qFPnh/GNdnES7DUT+XWqeKyU7leSrWj7r+av4drQg3hluMvf3ekwaf8wh9
         JqIsZghLlaz42PQI0AhOMDdEyW9OGaZZ+zD/PA+DVZAGg7g++e8XkhySoyM2whKc/wM5
         dDj++rTiM4TKRZzBRMT4Sq8+DRIjkgUZ2Ms0oEsli3ulBnp0nv+uzuF6NEwD90xLyAfJ
         4P0EVj9A7JzPGAL/ZPDZvAuX7OpxV4AS4BShOp9iUlt3SJB+rOFqKWJEyTJkx0PyqakX
         HSxC7UrO7AUDdUBRMM/WuduL14fqWubS7fJ9QYOSdhu5m2k1JxaQPMRnc5jBeeFrRy73
         9p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940633; x=1760545433;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRJXz112Re1ju3vdnrYT2DZaPKwj05gRwzq+1yeUNKs=;
        b=RixByaOzGZe/36N94DcQvjUsGlgmmSMKta4Y16apmuk/gLtVVjzwitXzrVH3OSEVIm
         zNkbdEOt7D4FATegKZIXLV+5fvdCHTFz9lS2oLai4+wlOovVZ2+sQUU1APoel+/6TkXx
         QWj83i/G7++VGPM7+jvnA5rXtUMiD9rDD0TOXYqpR7AXHGS/cir/jcqIqhBEs2oRvUUR
         jBcNG7Qf8Du9nYrU14+rNUB4Tk0uOiHwqHX8sAuWpnrLySxQsphccpkAFH6m81kuYRAw
         bi6TrUzSk6Jng5NiJKLi8RqcR7oGUeJKGXBf0GfHWWNt8/zFMhjkoGiIxIf2QCIDiwpX
         SjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbSQFUzz4Z/yqd4ZF/plBpJSGPzN8uuLmeRZk9u9dZeUKl4/85/bEKxo6EYQywLsVakIZTx4oNZkx05b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBY1bO4+aAZVgdT1sVk89dtkrLkTzx1B8do0m8alrIeIbmr/H7
	ugJ485att5PCGkh/B012SkV5QJrBKqpHOiV6qUxhOHVW8teZpuAyPL5DtP+JDdmGdIzpCTSzMZE
	LU/08T/+Pxg==
X-Google-Smtp-Source: AGHT+IGKggukMuWythYr3qzc7hKbOfyUWxXaNl2ZkzSjXOY2nzoCMvWkDw+/XtALg86o1p0QKnOwEdiv1B2m
X-Received: from plez12.prod.google.com ([2002:a17:902:cccc:b0:26a:23c7:68d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef10:b0:27e:eabd:4b41
 with SMTP id d9443c01a7336-29027216505mr56267885ad.7.1759940632569; Wed, 08
 Oct 2025 09:23:52 -0700 (PDT)
Date: Wed,  8 Oct 2025 09:23:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008162347.4005288-1-irogers@google.com>
Subject: [PATCH v2] perf bpf_counter: Fix opening of "any"(-1) CPU events
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
atomics so let's not change that. Force evsels used for BPF counters
to require a CPU when not in system-wide mode so that the "any"(-1)
value isn't used during map propagation and evsel's CPU map matches
that of the PMU.

Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 13 +++++++++++++
 tools/perf/util/bpf_counter.c |  1 +
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7006f848f87a..0fc6884c1bf1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2540,6 +2540,7 @@ int cmd_stat(int argc, const char **argv)
 	unsigned int interval, timeout;
 	const char * const stat_subcommands[] = { "record", "report" };
 	char errbuf[BUFSIZ];
+	struct evsel *counter;
 
 	setlocale(LC_ALL, "");
 
@@ -2797,6 +2798,18 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
+	evlist__for_each_entry(evsel_list, counter) {
+		/*
+		 * Setup BPF counters to require CPUs as any(-1) isn't
+		 * supported. evlist__create_maps below will propagate this
+		 * information to the evsels. Note, evsel__is_bperf isn't yet
+		 * set up, and this change must happen early, so directly use
+		 * the bpf_counter variable.
+		 */
+		if (counter->bpf_counter)
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


