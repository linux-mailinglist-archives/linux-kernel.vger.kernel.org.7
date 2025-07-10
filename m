Return-Path: <linux-kernel+bounces-726415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B2B00D00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422403B856E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4492FD87C;
	Thu, 10 Jul 2025 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+LopDd8"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A05286435
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179108; cv=none; b=HHD9vxV+JjTctog7tdtT3+IcxZyKVKqBzPW28IqKDz00wtcBl5hxB+App2EAVk/fU790N3GEm35v4ANv5bzyyAcd0BLaSpUdCxWBQ7Va+8pSQEUqDiV0FYf7/zfaNwJeBcJKWG29wdNlftiPAPr2zQavjXx25qRqWo8hnX9QsTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179108; c=relaxed/simple;
	bh=zOaQyoxnE+xDhPXR1x4blu88UkOV6rraBslIiq6+tFI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=PZ2rEr7Ru2XxhW6nFwnjAVnD/FYq2esLM2g5pEI+I91v2Qq+Nhkf8BUjOFcDL74hQwMhmu1zRMcLuBKYDqZuAtbKi5zRXze0czhIacg2ZUWUqQ5zF+dXVWhe6dtliJZv48Sr40DoLMJcQpKH5p8LPiX/N7/BXH+RjnEPLfLK1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+LopDd8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23827190886so16052655ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179106; x=1752783906; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YTddIZXbrNDbU24UlcjqgIm+Nfj26hRfAfDhm3Dwurc=;
        b=b+LopDd8aKbOtEuMKPqwY/QgN4ShpwjrMTkYQUoxX6vKnmJoUqJLiPQIVpKIp650+M
         IWydjBJi/A7eP+RLS9DWXJNkl5J3LMR1NHxJZYQ0wVF9p7SoGHZWeXuJC3CWKwEHJGB6
         cRDlY2UVsw1rGlOrNuR6iqyTuWW40wWWJGMeCGqTxui+LW9O5ywc7wUTmvpTqcjgTana
         bsSt3WWB8gu1FAMlbKQfaisvuQxQkkNtXYqD08g43r0/fQ30EoBKVCKhailrgJikPZYa
         fHcQZXexSCZux6NCvmDGnmhM07189YxhWouWaE/xBPa/m2XIw29oo3J7pUFcSRYBr/DR
         eOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179106; x=1752783906;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTddIZXbrNDbU24UlcjqgIm+Nfj26hRfAfDhm3Dwurc=;
        b=PZL3s6ZKef9H0ZNNfGBd3PqGY/Or3lbBpEPgdMf6QBT6M3ZYg4VCv05Ur5OQI1tZxC
         P8Px0gJzJ+s55B9jkmKzFAw0IdvwwQxHlfOuIjoLy2d2qZ7rfF9lWnI8JCu563WMa5cl
         GlyWpdPQMSdQgPtG9OEL7HcDHUo1YIWqGVG4jmblo7of9X/c06spXjuQFrYi5LinvfJd
         sOsjQnry8KUFupSROkeT6ljS9zpPkr+adwTgG3ktEz7dlKcqYxVqzgH7NWZkPcAslggt
         oNWBFlLns59LmwRlxi1v+3anslzGy6eLQiI2CLP83lWgwhh5zuJdVcjkGBgpsl5mHAUg
         kseQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjHJeHq+9Sdu3JOMKd20sXNAwa9cjlfMoTkW7/X7SaCSwfiNahzNmzkHVjREXTsWv7ysmv3LdSGbWO1XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDNJVPTSDbS5G2rM1Mv7u8Q4vYaFNcCXO+ny1Fu/Axw2jrG0XL
	IOyaonsU0C+BbB3Vlv5e4EgwduOmQfIP/X2RsoVby0P6louQww1w7FS9vA0kV8dfVip+C5Gf33g
	UyBT/+67LNg==
X-Google-Smtp-Source: AGHT+IEWFKPnmD46VKI+lhUUDWCXtdwaJMheYFCgsG5e880rpkm/PxWQiBEE/l1y0BIG2ua/3mfmk7qpWv7Q
X-Received: from plbkp15.prod.google.com ([2002:a17:903:280f:b0:234:b3fc:8229])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3df1:b0:235:be0:db53
 with SMTP id d9443c01a7336-23dede98446mr6329845ad.51.1752179106260; Thu, 10
 Jul 2025 13:25:06 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:24:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-1-irogers@google.com>
Subject: [PATCH v5 00/14] New perf ilist app
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series builds up to the addition of a new ilist app written
in python using textual [1] for the UI. The app presents perf PMUs and
events, displays the event information as in `perf list` while at the
bottom of the console showing recent activity of the event in total
and across all CPUs. It also displays metrics, placed in a tree
through their metric group, again with counts being displayed in the
bottom panel.

The first ground work patches of fixes, cleanup and refactoring were
separated into their own series here:
https://lore.kernel.org/lkml/20250709214029.1769089-1-irogers@google.com/

The second part of the patches adds event json for the software PMU
and makes the tracepoint PMU support iteration of events and the
like. Without these improvements the tracepoint and software PMUs will
appear to have no events in the ilist app. As the software PMU moves
parsing to json, the legacy hard coded parsing is removed. This has
proven controversial for hardware events and so that cleanup isn't
done here.

The final patches expand the perf python APIs and add the ilist
command. To run it you need the updated perf.cpython.so in your
PYTHONPATH and then execute the script. Expanding PMUs and then
selecting events will cause event informatin to be displayed in the
top-right and the counters values to be displayed as sparklines and
counts in the bottom half of the screen.
 
[1] https://textual.textualize.io/

v5: Split the series in two. Add metric support. Various clean ups and
    tweaks to the app in particular around the handling of searches.

v4: No conflict rebase. Picks up perf-tools-next DRM PMU which
    displays as expected.

v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
    keys. No changes in the ground work first 14 patches.

v2: In the jevents event description duplication, some minor changes
    accidentally missed from v1 meaning that in v1 the descriptions
    were still duplicated. Expand the cover letter with some thoughts
    on the series.

Ian Rogers (14):
  perf jevents: Add common software event json
  perf parse-events: Remove non-json software events
  perf tp_pmu: Factor existing tracepoint logic to new file
  perf tp_pmu: Add event APIs
  perf list: Remove tracepoint printing code
  perf list: Skip ABI PMUs when printing pmu values
  perf python: Add basic PMU abstraction and pmus sequence
  perf python: Add function returning dictionary of all events on a PMU
  perf ilist: Add new python ilist command
  perf python: Add parse_metrics function
  perf python: Add evlist metrics function
  perf python: Add evlist compute_metric
  perf python: Add metrics function
  perf ilist: Add support for metrics

 tools/perf/builtin-list.c                     |  65 ++-
 .../arch/common/common/software.json          |  92 ++++
 tools/perf/pmu-events/empty-pmu-events.c      | 266 ++++++----
 tools/perf/pmu-events/jevents.py              |  15 +-
 tools/perf/python/ilist.py                    | 486 ++++++++++++++++++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/evsel.c                       |  21 +-
 tools/perf/util/parse-events.c                | 198 +++----
 tools/perf/util/parse-events.h                |   1 -
 tools/perf/util/parse-events.l                |  38 +-
 tools/perf/util/parse-events.y                |  29 +-
 tools/perf/util/pmu.c                         |   7 +
 tools/perf/util/pmus.c                        |   2 +
 tools/perf/util/print-events.c                | 100 +---
 tools/perf/util/print-events.h                |   4 +-
 tools/perf/util/python.c                      | 484 +++++++++++++++++
 tools/perf/util/tp_pmu.c                      | 209 ++++++++
 tools/perf/util/tp_pmu.h                      |  19 +
 18 files changed, 1609 insertions(+), 428 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100755 tools/perf/python/ilist.py
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

-- 
2.50.0.727.gbf7dc18ff4-goog


