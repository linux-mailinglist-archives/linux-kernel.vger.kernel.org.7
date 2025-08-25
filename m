Return-Path: <linux-kernel+bounces-785563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB612B34DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7164A4841AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DD73002C1;
	Mon, 25 Aug 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUMxC6Bd"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA829A9FA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156340; cv=none; b=D5R/Mg2JwGYY9yMhvub/rSKExQXh7N7XkwhwsCzg53kq6YpIE3Tbtf4uHWU6lmGnEDrXyF6wA8rpheCg2DbS0XdHc31etWZLDQUVi1NGGjlHNoC4B6Rb9nJXx3DFGgg6R5ydQllZAMtDJwViemODoBIq28Zq17K3b+E+M0x8x/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156340; c=relaxed/simple;
	bh=5c12GW5uW54RCp4fC3zBzGwrDpAxY2DPvKafZkM0t+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l0V5ZEHkMAbFZPgOJtJfQvgno7q4lgBp5ju21B+fryced6WpOFkSyRmhfuVHxY+mxecRGU5Hw/Ub93enJCvw6IO7KxMTjObDmc27REtVaoR6AKpTahmD8onJQUoSd5juLZk5wFAeF8cteiEjZgBwAX7pTaOJYxYaKGq/WhQkpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CUMxC6Bd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce13aso89514695ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756156337; x=1756761137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+nlrKUtv7jO/bAmeO/87u7JkQohuUh/Ui3QeA1Ivfo=;
        b=CUMxC6BdKkMuNjXWErLr+cAENCqyOsLX7mvEJ+SE8ZODEJhhD9YssPxQYUUqi/T7Rr
         CQORqGcw0PUmxqSSDAeSNmfcI61LX7r+UKDSIp2vhqB2gPiMvJubwbZW5jop9roCE4FE
         B3z4KLO0Vr06P+JBpXOA2Ulewu2MLt9wIwp+vy08bkSStH2IFMOok7z3Vlnkvu2IJ2g4
         GzWDpBjgZL+CS1tH3dO5jVvcBo6pB3ZkOhx3m4N3AvaDkVT8TzSLsV7Eq7K9y+eQn1HD
         oasnmDYFDqAizhArD9i8f/GCJ+loQNCPV+H9rFj/STSVoJBBGAmzIJvJfyCk+JB0l4ze
         Ox0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156337; x=1756761137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+nlrKUtv7jO/bAmeO/87u7JkQohuUh/Ui3QeA1Ivfo=;
        b=C04WqV7mFGNPxyEeBidqu8vX4CcEuEBdiap4cJDecUUz8CXdC0p3qvXIPiztS4TSEV
         NOQ+W3000T6dbBrg0DqELlU/i9FxM93qNQNYvV9XRAzVflprBAAUlyS6qiveiRVTr87Y
         1QMJOj8SC+tI/VzlCPATn+G6gb84+gdOuork9xBY0NaXiWSvDeZodHzL1obcQz7f0B64
         Gdz0WuT23dPnBh7O9pZaUliiehCraNOj0Sj89sQ1k/b/Plcpg+ulZqCprDj5W58LfRJG
         wKWG67yYmoB/6510ksieLTDXCWiOXkcpx91s9lr2SpQAusdW1XWJix6j1VHg25r4cLdp
         Y4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZhKWmfNRXY7mFST+6nqSfJU+sbmzFTRXN6V0dqMTzyNYh7dcFOhv69SudpHmUpuodu4r/EawawNARmA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaj2mWkqkZOcesMenk3Geh0ytVXljG+dWnV2ZwmOJ/H1paoRLT
	GkYof/nB+X1YCLNcAwq8Ey+iLVL4k4+wu/N2V2fBXc7Y22wnLdhrC6X2RhTgZRsZauBN3Ie4UVh
	lRNc/i4KHow==
X-Google-Smtp-Source: AGHT+IFC1+eJDKxR+1N1NPkEm4OgKei4TCoV2Sfh3ijf8Zy0FF8kbXPiqkttltdkqM0g5Yucik+hDcSDbPGv
X-Received: from plblb13.prod.google.com ([2002:a17:902:fa4d:b0:246:5661:c356])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc5:b0:246:255a:1915
 with SMTP id d9443c01a7336-2462eea840emr160319835ad.27.1756156337145; Mon, 25
 Aug 2025 14:12:17 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:12:04 -0700
In-Reply-To: <20250825211204.2784695-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825211204.2784695-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825211204.2784695-4-irogers@google.com>
Subject: [PATCH v1 3/3] perf parse-events: Add 'X' modifier to exclude an
 event from being regrouped
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"

The function parse_events__sort_events_and_fix_groups is needed to fix
uncore events like:
```
$ perf stat -e '{data_read,data_write}' ...
```
so that the multiple uncore PMUs have a group each of data_read and
data_write events.

The same function will perform architecture sorting and group fixing,
in particular for Intel topdown/perf-metric events. Grouping multiple
perf metric events together causes perf_event_open to fail as the
group can only support one. This means command lines like:
```
$ perf stat -e 'slots,slots' ...
```
fail as the slots events are forced into a group together to try to
satisfy the perf-metric event constraints.

As the user may know better than
parse_events__sort_events_and_fix_groups add a 'X' modifier to skip
its regrouping behavior. This allows the following to succeed rather
than fail on the second slots event being opened:
```
$ perf stat -e 'slots,slots:X' -a sleep 1

 Performance counter stats for 'system wide':

     6,834,154,071      cpu_core/slots/                                                         (50.13%)
     5,548,629,453      cpu_core/slots/X                                                        (49.87%)

       1.002634606 seconds time elapsed
```

Reported-by: Xudong Hao <xudong.hao@intel.com>
Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Closes: https://lore.kernel.org/lkml/20250822082233.1850417-1-dapeng1.mi@linux.intel.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 1 +
 tools/perf/util/evsel.h                | 1 +
 tools/perf/util/parse-events.c         | 5 +++--
 tools/perf/util/parse-events.h         | 1 +
 tools/perf/util/parse-events.l         | 5 +++--
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 28215306a78a..a5039d1614f9 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -73,6 +73,7 @@ counted. The following modifiers exist:
  e - group or event are exclusive and do not share the PMU
  b - use BPF aggregration (see perf stat --bpf-counters)
  R - retire latency value of the event
+ X - don't regroup the event to match PMUs
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e927a3a4fe0e..03f9f22e3a0c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -89,6 +89,7 @@ struct evsel {
 		bool			use_config_name;
 		bool			skippable;
 		bool			retire_lat;
+		bool			dont_regroup;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8282ddf68b98..43de19551c81 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1892,6 +1892,8 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
 			evsel->bpf_counter = true;
 		if (mod.retire_lat)
 			evsel->retire_lat = true;
+		if (mod.dont_regroup)
+			evsel->dont_regroup = true;
 	}
 	return 0;
 }
@@ -2188,13 +2190,12 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		 * Set the group leader respecting the given groupings and that
 		 * groups can't span PMUs.
 		 */
-		if (!cur_leader) {
+		if (!cur_leader || pos->dont_regroup) {
 			cur_leader = pos;
 			cur_leaders_grp = &pos->core;
 			if (pos_force_grouped)
 				force_grouped_leader = pos;
 		}
-
 		cur_leader_pmu_name = cur_leader->group_pmu_name;
 		if (strcmp(cur_leader_pmu_name, pos_pmu_name)) {
 			/* PMU changed so the group/leader must change. */
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 62dc7202e3ba..a5c5fc39fd6f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -216,6 +216,7 @@ struct parse_events_modifier {
 	bool guest : 1;		/* 'G' */
 	bool host : 1;		/* 'H' */
 	bool retire_lat : 1;	/* 'R' */
+	bool dont_regroup : 1;	/* 'X' */
 };
 
 int parse_events__modifier_event(struct parse_events_state *parse_state, void *loc,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 2034590eb789..294e943bcdb4 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -206,6 +206,7 @@ static int modifiers(struct parse_events_state *parse_state, yyscan_t scanner)
 		CASE('e', exclusive);
 		CASE('b', bpf);
 		CASE('R', retire_lat);
+		CASE('X', dont_regroup);
 		default:
 			return PE_ERROR;
 		}
@@ -251,10 +252,10 @@ term_name	{name_start}[a-zA-Z0-9_*?.\[\]!\-:]*
 quoted_name	[\']{name_start}[a-zA-Z0-9_*?.\[\]!\-:,\.=]*[\']
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /*
- * If you add a modifier you need to update check_modifier().
+ * If you add a modifier you need to update modifiers().
  * Also, the letters in modifier_event must not be in modifier_bp.
  */
-modifier_event	[ukhpPGHSDIWebR]{1,16}
+modifier_event	[ukhpPGHSDIWebRX]{1,17}
 modifier_bp	[rwx]{1,3}
 lc_type 	(L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node)
 lc_op_result	(load|loads|read|store|stores|write|prefetch|prefetches|speculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
-- 
2.51.0.261.g7ce5a0a67e-goog


