Return-Path: <linux-kernel+bounces-724528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EEAFF402
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B60170075
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7B323E344;
	Wed,  9 Jul 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z5DZf2j8"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523321FF39
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097235; cv=none; b=KEp3o2SJ0vhbQo4YgBN8rBHGtUeQBs9HEU/vMy+FRXlNx49SM+aXE7pJqQdlYOVZjs4A2h2grHxR7EkIEHcdmY+eKOIUor3ox/87tcy3pKdgjxeuMQl/ZmUHPB92bsxPixK+UR9e6+g/7lE8XeUSTbZNAxAvwSqSiBYY3TPs9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097235; c=relaxed/simple;
	bh=dAx/9BHHk2gp6RbxbMCNF3YyX8iXzA6yqSrF1kGWbs0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=MV5+Rp3BP1dMalstZ14eHjFKU4kGNZNAxS9X2jYSOMY6N5jkTqb1cNmg9C+Z5brfTxwjLYbLISh5OE/jUPiH7LGOb2/DUPjoXeiu7wG8RL1joeCpZ/vgmH4/vq2X7cjAaaekVw2ZQ+6ncf2ns2Ppv0ZmM4yL2S87DUwUiXanwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z5DZf2j8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-236725af87fso5126955ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097233; x=1752702033; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xW/jUGxNTN0mrL6/OLpy7P8Qk2WaeRoeDZDx7KoSzjo=;
        b=z5DZf2j8FjlgU/fBo6sL598Zv3bIoh9La682PPstn4VXGVADrevfvF+xtg992Y84Ng
         M8+4tSar0FMkWWIhTNGewWm2lC+m79r2CiAM7+p5fjTGXo0tT+9a0lToHHuwEJkqBG7Q
         WMBLSUDWr1wnwBGCT50jdo/1FDksp9tyufoNUWUOp2GheQ9+wMdEJLo637nLzOVUbtaT
         za7kEPqF0nta6zP8BvPOrl9AKIQNLnoKRW3evbqzR7W3OjZI+RgY2lTVuxgPHoMExovI
         +xjrsqaw9e0RXTMVMj9OuEm9WwRIy6+Wg3m4djpfXo4cYeChc2Pc5AmuQB6MiVa4+ml2
         UJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097233; x=1752702033;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xW/jUGxNTN0mrL6/OLpy7P8Qk2WaeRoeDZDx7KoSzjo=;
        b=rRJlVFaIjnLi8K5AjXNEKKi1KTz6KaVdU/rkoyV8cNqcGMu114RoACI2WS3qnhk2ds
         MbizzsAo1Fudtt5RiZGHqycZA6LdKKSB0ZvIXZGdM18O4Zm05iUzeuHKQLhcmobY/Y5z
         k9zdewGy8PwPhT+zP6Wic7317P8C7hSFE+nwWLOz3vVpMjf0oR+GkeMkJLdY8lsBmd7M
         C0t34Pea/zDi5GFbEQPBip9JINZ+kpIc76laNODsClezcmqdDTv/tVmZQg0J8aeDNDxw
         fRjV8UbUu7AwICClfyMS9zwXnK32UxfyZMClWh4kmHN9kF5Zi4NIua4FopeDdLYdfrBB
         YfaA==
X-Forwarded-Encrypted: i=1; AJvYcCVzGUS0vNnV64LLVkyy2vT1Wvm8JAotcs8CjngM6W29WYxDcyH1Wv/Op4NPZkzSgXYwwGMVDE0gZlXED5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyehDLhBdfEZkcScAgH1goWg4QcTBujUe7j9gFAJmQdDMrO/wVb
	leQehlkhdRs++nPFp+2zEWulvcbJM/HML+nEdeXniegOKlJ4SMELRvzYYSiSIKwE7t5qU17BYs3
	TlErDEdmD8Q==
X-Google-Smtp-Source: AGHT+IEjv5yfrOnuSh9ELqkUNKnwmKE8U+2+0r4wrCq2uBQvE9VogBqclCPRDDIkeTGiNeskN9VwecG8hPYK
X-Received: from plup7.prod.google.com ([2002:a17:903:4b27:b0:22e:4c89:97c7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f707:b0:236:8df9:ab38
 with SMTP id d9443c01a7336-23ddb2fce7bmr60676095ad.34.1752097233391; Wed, 09
 Jul 2025 14:40:33 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-1-irogers@google.com>
Subject: [PATCH v1 00/12] Python motivated fixes and cleanup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Various fixes and clean ups done as part of creating the ilist app,
the v4 patch series of which is posted here:
https://lore.kernel.org/lkml/20250628000929.230406-1-irogers@google.com/

These patches are separated out to give something smaller to review
before adding features. As requested by Namhyung.

Ian Rogers (12):
  perf hwmon_pmu: Avoid shortening hwmon PMU name
  perf parse-events: Minor tidy up of event_type helper
  perf spark: Fix includes and add SPDX
  perf pmu: Tolerate failure to read the type for wellknown PMUs
  perf metricgroup: Factor out for-each function and move out printing
  perf stat: Move metric list from config to evlist
  perf expr: Accumulate rather than replace in the context counts
  perf jevents: If the long_desc and desc are identical then drop the
    long_desc
  perf python: In str(evsel) use the evsel__pmu_name helper
  perf python: Fix thread check in pyrf_evsel__read
  perf python: Correct pyrf_evsel__read for tool PMUs
  perf python: Improve leader copying from evlist

 tools/perf/builtin-script.c              |   3 +-
 tools/perf/builtin-stat.c                |  25 ++-
 tools/perf/pmu-events/empty-pmu-events.c | 128 +++++------
 tools/perf/pmu-events/jevents.py         |   3 +
 tools/perf/tests/expand-cgroup.c         |  24 +--
 tools/perf/tests/parse-metric.c          |  16 +-
 tools/perf/tests/pmu-events.c            |  30 +--
 tools/perf/util/cgroup.c                 |  23 +-
 tools/perf/util/cgroup.h                 |   3 +-
 tools/perf/util/evlist.c                 |   3 +
 tools/perf/util/evlist.h                 |   6 +
 tools/perf/util/expr.c                   |   6 +-
 tools/perf/util/hwmon_pmu.c              |   2 +-
 tools/perf/util/metricgroup.c            | 261 ++++-------------------
 tools/perf/util/metricgroup.h            |  10 +-
 tools/perf/util/parse-events.c           |  31 ++-
 tools/perf/util/parse-events.h           |   2 +-
 tools/perf/util/pmu.c                    |  37 +++-
 tools/perf/util/print-events.c           | 133 ++++++++++++
 tools/perf/util/print-events.h           |   2 +
 tools/perf/util/python.c                 |  91 +++++++-
 tools/perf/util/spark.c                  |   8 +-
 tools/perf/util/spark.h                  |   1 +
 tools/perf/util/stat-display.c           |  16 +-
 tools/perf/util/stat-shadow.c            |  13 +-
 tools/perf/util/stat.h                   |  12 +-
 26 files changed, 443 insertions(+), 446 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


