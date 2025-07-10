Return-Path: <linux-kernel+bounces-726450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBF0B00D35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B117A4A01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A828C02A;
	Thu, 10 Jul 2025 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/J01oFS"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13BB275B08
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179825; cv=none; b=BFDOFTbj/N7X6uJ3/ejEMW07U56eLXlhf8yr8pMMAmf5sS1eGzscDor8QddTTqlex2ZCoHJ7vKozPLShDEUYy0TPHLcCk7ZxpNxsyUPzBCSQnVPGSMXmkcNKMV6e8bsgcF73AGa6hN+dDQZbw4Bbzcwri3mIvpj06A5PShwzcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179825; c=relaxed/simple;
	bh=PYYT/70vh0lAIbm7Qt9+FHOf9CuUkv0EGe0SLQIktEY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=aNQXo5sRGbHPQJtYaQltS27xL+126SRkOlkcIG/3rdoUcC+7lMnLTjJfDlv4XGDqv/G9v3156WphLQ2yKb7b0m+cwku+mZtcqFc2EKF3IztljxtyCHwwYEm8JGK+DQdLXQA3ToIgA24QdxfYElVldmoYlwk98GO80MOoXEynnrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/J01oFS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c37558eccso1190541a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179823; x=1752784623; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ygsyz4U/nGkQ+jb+lQMrfpzM4xKYhjxpg6/J7tNcp0Q=;
        b=u/J01oFSlsk8qZKb6B4TLWSFAskWWu/mGJad8i41oqhhzbZzEvlNafxAzyNHVLbGAb
         CXks1ssdrnmNCcHUT6pN7C+5M7mrQhS8h+MMLvSih53I+xRZbxseOWFxrQUxTpzQaAEr
         1ZIlY9/Z1NxeaxHf23u9CWU9fLLzagbCuTjlLABg7ldZ7/Tj60vCNWzGBv6MZiF5NTi8
         BIXNOU1x0T8Vv4rcveNny4JB4x8+jolMgq95nPTzC+N3hyMuPeaiMiY8ny/7hibWgrmR
         TaDz8H1tjgDjXk4cvWP+X0ir/k6uc/K1EWl68X7QqqG78sg0BSahl/mFfP8bS78uEp5I
         /owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179823; x=1752784623;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ygsyz4U/nGkQ+jb+lQMrfpzM4xKYhjxpg6/J7tNcp0Q=;
        b=TVyctj69uzi4mk2rNSIafD8xIUeV30Q0xCqxt0zFdAhqu9LcgWA/UptV2zQU64jPV/
         pklHdOZ0uL+NMQWS6dIVbcfpl2o76z8eA77lyjmGjkuL6jyEag15+vFemTzeQlZaU38F
         jwlEfUWnR30pPDU24fKdIUYK98Wq9rPllppdEzZ3B/cBZ/cSlgqXGEefP2g15BDjQBB7
         9W8CFIvN1a71SES87SyJdUkxTIoofW0Kxjltg819P8IGqFL4WGYbnn/iAqJxizTi8YAE
         +zk0X3LutC9F9tYRfjMP/nYQSCnkqBYzJ1EgoxmrCWW0NH/LGF9CB6An4mhmOuJYthpS
         Wswg==
X-Forwarded-Encrypted: i=1; AJvYcCX1nsYCe9w0XpK56GJK2VFHmxZvSRqlKj4bjlUxz/ROsLwzppMrK5h9A94RLdGacxcVBfVEuvWvoXN+B4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoT+l108QEgot5iA2aLZKCo+JTpkVnQM+yHz3ghYTOb7KJQ/o
	JEIYhXAbhWZV7DjeTLF0b3/neBtakSOeK5jRGBUFqKjwgqczqV5zRxbUoyKp2m4W87A6NqKR5Tz
	0Tmh2Oy4unw==
X-Google-Smtp-Source: AGHT+IGcpMN8TZUnE2Kv2NtfrSwS7M9wPRBHMv2C7ZkxmR2wJeSNj1bP8eIUO+GWt9Cls3PlBWMBDMPBflDz
X-Received: from pjv16.prod.google.com ([2002:a17:90b:5650:b0:31c:32f8:3f88])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2708:b0:311:e8cc:425d
 with SMTP id 98e67ed59e1d1-31c4ccc0e50mr1056854a91.10.1752179822978; Thu, 10
 Jul 2025 13:37:02 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-1-irogers@google.com>
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

(Resend, accidentally move 2 patches in a rebase and sent those
patches twice)

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


