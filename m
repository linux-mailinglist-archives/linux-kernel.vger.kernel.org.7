Return-Path: <linux-kernel+bounces-858835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE10BEBF7E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1236E71CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510663128CA;
	Fri, 17 Oct 2025 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFyt/6ay"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3F2D3750
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742255; cv=none; b=urYNM6JmQKI67gjY0VWChfEQt0UqDqMdAOPOVMxMr8nhWQQfYbOF/RmXdJgpoya4w0+C5k1SGlqTGIfnT0LC/qUPSBglYKuPoJ3wBfHUmqMa7H8QNFg0M1sU1e7MMXiXGQdC2T7UF4MGzUtpWz038B8WmdtyHZXr1y/l+Ko/WFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742255; c=relaxed/simple;
	bh=i8hrEKHJUIgVQVWD0OgBI/SQp27vpOUUG35N/5EJfgE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=J72TZwF1e/xjuIWx8uTA0ascU2k3JRYgp62fBGC0XNBYhN6bd6/5hLn69zdoJqKAdi5QP0innjrvO4lUhu6xFnNefkXbALjHnMb9pa9If07MKbJXMpFDaMWS91a/QEshD2gK82trP0cPUHLnXxgjo4fRypCbomHxGwFUgvDwt/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFyt/6ay; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2924b3b9d47so720895ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760742253; x=1761347053; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AzD0fpnckg8jWbZQ4jUwVcqQTJ9vmG7SI/LJT+caamI=;
        b=kFyt/6aymn6kOb0POpepDTT5wcB/Y4cgtFceNY+Jrk/4VcmYi1o1WOWP27IuGxbBHl
         4CxNVAqKpJm27vcgHgceWYkwh838PlwuQSTISYw5rGHAFSvb0gZqKUkDm44BVPe9QdHJ
         7MqC62NKrHcLkL0Hp8g+GMWCAJk0saxHKTlc5Aesz/Mo7+TAh/4is5QwiRrcDnfwR5Um
         vQzmI4WCQEHxOu+pbRX2Q0gPh2DiA9b6pkMAwJ1J8r+3XTbOEHTVPKid85VNFgqMWWyt
         FKry63Cyf7FFxFjp9Pge9bmy7chF605mRu4aELuWPm2iGKfj+QbcQUbKX3AzAiYCGZI4
         EraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760742253; x=1761347053;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzD0fpnckg8jWbZQ4jUwVcqQTJ9vmG7SI/LJT+caamI=;
        b=oxOu2ZfsWThQ1yXgSqwT+obELx5sCgaOTAxsSF5UA7Jxofw+HxgFPOAv3wsWxkVdzF
         EJ6y6x2eaLcTbzowWptCQpr9JOBQi/mO2ZWEcvU2AA6EgLWoHCjdvSe8EXtRRjiz/8XC
         qBFyZKL+diE0vv0MCQVkeA+fQ0YRyLUOvuLwPNQCWpeXpBlJO6RULLQ3PDWNiC7u/Pet
         hqIa32+0J/lUDdghgp1WUhVHruFwzibQ2a7F7vE1hIp+Y2T62ddnULj3NC6RsGlSWUNu
         O/qGI4GwG/wEEuHNzkAj1rWQTEnJZ8iq2Za9vYHefXBDaxgDdKhx+z6SuNeAZp7VXaFn
         QX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJplFiin4c3WKFSnbpV7AyTr8HDgx2wAMpB3imOkQyGj/WElseuqWvNsKJ2R25DmzvPq4VG/8BF2Noiec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBmnaR7vo5MhTcwlXGJ4ODGVqdHNK9jPYUdYcSYArYndPgjNBE
	tbePjXZaTKkeAuwMASAbVEsTneuYnC+T0k4axm/WebbC8Jutryqnu9gST+ThZAhznQwjmClaGKG
	lwbQq90ft2Q==
X-Google-Smtp-Source: AGHT+IFx3VaV4oEkTi3FWP0Aq4AqnROHtqpso3n6ZcyFQpXBwS438EUTG8fyxaxI8u1r++yMVb/Mljz9N+Yk
X-Received: from plqs22.prod.google.com ([2002:a17:902:a516:b0:28e:82ea:1815])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d505:b0:27d:69bd:cc65
 with SMTP id d9443c01a7336-290cb079f3amr56675185ad.45.1760742253368; Fri, 17
 Oct 2025 16:04:13 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:03:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017230357.15663-1-irogers@google.com>
Subject: [PATCH v2] perf parse-events: Make X modifier more respectful of groups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Events with an X modifier were reordered within a group, for example
slots was made the leader in:
```
$ perf record -e '{cpu/mem-stores/ppu,cpu/slots/uX}' -- sleep 1
```

Fix by making `dont_regroup` evsels always use their index for
sorting. Make the cur_leader, when fixing the groups, be that of
`dont_regroup` evsel so that the `dont_regroup` evsel doesn't become a
leader.

On a tigerlake this patch corrects this and meets expectations in:
```
$ perf stat -e '{cpu/mem-stores/,cpu/slots/uX}' -a -- sleep 0.1

 Performance counter stats for 'system wide':

        83,458,652      cpu/mem-stores/
     2,720,854,880      cpu/slots/uX

       0.103780587 seconds time elapsed

$ perf stat -e 'slots,slots:X' -a -- sleep 0.1

 Performance counter stats for 'system wide':

       732,042,247      slots                (48.96%)
       643,288,155      slots:X              (51.04%)

       0.102731018 seconds time elapsed
```

Closes: https://lore.kernel.org/lkml/18f20d38-070c-4e17-bc90-cf7102e1e53d@linux.intel.com/
Fixes: 035c17893082 ("perf parse-events: Add 'X' modifier to exclude an event from being regrouped")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3aec86aebdc6..0c0dc20b1c13 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1973,14 +1973,18 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
 	 * event's index is used. An index may be forced for events that
 	 * must be in the same group, namely Intel topdown events.
 	 */
-	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)) {
+	if (lhs->dont_regroup) {
+		lhs_sort_idx = lhs_core->idx;
+	} else if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)) {
 		lhs_sort_idx = *force_grouped_idx;
 	} else {
 		bool lhs_has_group = lhs_core->leader != lhs_core || lhs_core->nr_members > 1;
 
 		lhs_sort_idx = lhs_has_group ? lhs_core->leader->idx : lhs_core->idx;
 	}
-	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)) {
+	if (rhs->dont_regroup) {
+		rhs_sort_idx = rhs_core->idx;
+	} else if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)) {
 		rhs_sort_idx = *force_grouped_idx;
 	} else {
 		bool rhs_has_group = rhs_core->leader != rhs_core || rhs_core->nr_members > 1;
@@ -2078,10 +2082,10 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	 */
 	idx = 0;
 	list_for_each_entry(pos, list, core.node) {
-		const struct evsel *pos_leader = evsel__leader(pos);
+		struct evsel *pos_leader = evsel__leader(pos);
 		const char *pos_pmu_name = pos->group_pmu_name;
 		const char *cur_leader_pmu_name;
-		bool pos_force_grouped = force_grouped_idx != -1 &&
+		bool pos_force_grouped = force_grouped_idx != -1 && !pos->dont_regroup &&
 			arch_evsel__must_be_in_group(pos);
 
 		/* Reset index and nr_members. */
@@ -2095,8 +2099,8 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		 * groups can't span PMUs.
 		 */
 		if (!cur_leader || pos->dont_regroup) {
-			cur_leader = pos;
-			cur_leaders_grp = &pos->core;
+			cur_leader = pos->dont_regroup ? pos_leader : pos;
+			cur_leaders_grp = &cur_leader->core;
 			if (pos_force_grouped)
 				force_grouped_leader = pos;
 		}
-- 
2.51.0.858.gf9c4a03a3a-goog


