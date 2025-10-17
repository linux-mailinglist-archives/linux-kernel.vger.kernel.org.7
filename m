Return-Path: <linux-kernel+bounces-858487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC53FBEAFBA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8317443BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE02F12BC;
	Fri, 17 Oct 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x4uy4Tr9"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DB2F12B5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720278; cv=none; b=uQe+rG5qqiuHX0ZKn1sSE+7BLgcRAcRHEviFsSlECpwyhhArPxx0NPt/eVTkdzGqX+PaUq7lrCk55XgJ2z327nnag6o63XkgLIiL9YIx+cXPYCCfnstsbBV72tZi5RCeL3wPbyHmX2TzXJoGqCOrjSbn8UcHZbMBQzKw8eUgAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720278; c=relaxed/simple;
	bh=ua0uEFBMOTBb3uoJb6buV9MgTsEsoaNYNcEGlTINduc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ZVhlb64p5YWFWmZfXLJgXkdeX/xmjQvfqmdWPCuHQL94BRQfRNTqdSMUBcTUx1zXQv9IwD1L6I6RJfjlDyAQOK6UG0WaHB9Ihq82PPpVeoF4Dy4KF0B46HIMFntaRLQBK33EV4cEtgzSNniVvdRW5fTgWT6C6jYAi8QClWxZJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x4uy4Tr9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7810289cd5eso4659165b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760720277; x=1761325077; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QSw4ow8SL+lOWVzRuPCyfduZDAlfxtyF/2Y5Nj25vlg=;
        b=x4uy4Tr9BoVHfmDHxA/Dbf9iThxa+8r8AB6iIB6vG6tcjLLLj8oRlYTZB7WhTTy18C
         O9W+MN0BgiXNyfqEN74HqqYEwoqRWOCABmTY/AKlYk7PVpOol7oYuqFOEYbHaiMLU9Vs
         5E3L4/q5ribHEHEMJFetNCE0GSZbT8c4iii7/Rgm517zF6sm6HG45tkB7SPLPDunKC3/
         8wEtZNayk2YVmvOow91bZ7iBpOxLZAJrQ8uQxDh9GlSWmSWqGwwMXnLUSc0mwlIf1E8e
         4qJRa0EY32lvOXHPe+cIyL5RYvxUF+2xHNs6ci4pqlEN4xY0i2i2904C6QOtA1EN053l
         +PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720277; x=1761325077;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSw4ow8SL+lOWVzRuPCyfduZDAlfxtyF/2Y5Nj25vlg=;
        b=TbBp5JAeYFBEheR+tVNR8HIE6/6uf/6f2H5ULR7m2GmpFNV7P8mbzMkPmt7mVGD4TJ
         kJ5X8ebiclscPsHdUIbZIcQ/O2tEWrkbDEVFhtn05+P2uHWOQkoNjP8OaqhIGc4aO9ar
         PuqlGHNfxAeXvm3l0crtyeuFRFRCse/zYaJLkK0xa7H4zSK9XgcsfS+0HbkcNOR70FOL
         oMlaJ3KkF6+mhaQeLPlzs5/wPRb6SEZEr/IXKPzcA/zQd7SkVAUc5bxjUUi7Xbg6DHwd
         zIxxFdtjShNv6JYE+BkF/aipH5mij4pMVMhU6mU442NJ+AbyTrOQ7LfCXG0+RDXMpaJb
         2q1A==
X-Forwarded-Encrypted: i=1; AJvYcCWNgSZ8qprFbnb8DMzCRvpnHJ+Qr6LnSumdCFWqtGrnZGRkYcEMqf0hAVdwZW4lq/8FY8Athj4UEQ3R2wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZ1vgXIATOl1dYYy0/ZEKoXjNG0g22FMf9EKIRUfxxqc0WvH+
	bVIMT5RxlRZNAu6WJjURHO0wO2Es7+EZeP5Hi7Kh3ohgj8Ou/aPZdB15c/9LMCHxa3vauOr4M0D
	887l9iDzogg==
X-Google-Smtp-Source: AGHT+IGfjrL+hct3mrv+6u3bwjvnZk+wFOTbMml7Ea8QfE0vvXsNXKrgmmggrkZ/GDL0+op+kepFE8GFUP9v
X-Received: from pgmj24.prod.google.com ([2002:a63:5958:0:b0:b6a:62df:89fc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8a:b0:334:a180:b7ac
 with SMTP id adf61e73a8af0-334a8616ff5mr6025742637.39.1760720276506; Fri, 17
 Oct 2025 09:57:56 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:57:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017165753.206608-1-irogers@google.com>
Subject: [PATCH v1] perf parse-events: Make X modifier more respectful of groups
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
index 3aec86aebdc6..1a5da93f4094 100644
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
+			cur_leader = pos_leader;
+			cur_leaders_grp = &cur_leader->core;
 			if (pos_force_grouped)
 				force_grouped_leader = pos;
 		}
-- 
2.51.0.858.gf9c4a03a3a-goog


