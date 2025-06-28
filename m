Return-Path: <linux-kernel+bounces-707385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F1DAEC362
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 02:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C0D442BDF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 00:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52C1854;
	Sat, 28 Jun 2025 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPFBh5Cj"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA098634
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069375; cv=none; b=PBqVKO1ng2fr5KGN5pfvObUxBQEquEJ4FGJWgZQa2O5D6Bo3uQYzOHcmJHUbIGgJ2vpSM2eJwZVYL48n00s1AhgYeYaYTbXKVJ9q2pHPMDSGqjJjjUuhTisywBBNGtHUbs3DzClgBDfJft8DXZgX5j80pW+55zD48/cgEi9/CNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069375; c=relaxed/simple;
	bh=P6DnWmBkVtsfcmSCv0Tmky1jTs6U/MlgEXv0N69lKH0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=V7vBTwHmSYfkHq8vxgpeE8vCQkYNR6Kfk4bNVY7zd5TgrIBI4B9IJexOwIaFKkfnk5skutaAo/Q73KiY5AeIWZmxqk/hLd2XGXRskCdEryQZ4RUfoUvq/UoL87v7XI2yTjSHFEHWR0Erl5wXVZv9mt5cSBKq+eLy6WdwI1/o0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPFBh5Cj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748e1e474f8so845665b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 17:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069373; x=1751674173; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cQ6py8YyTA5edQBe5gZaCd4Je3r3oqAKBpXvDGlotkU=;
        b=aPFBh5CjIFkZy99IjP+beWPk4Y07qhaSYVJR+Wn6BnhmQDmKh4765uQiIvqPhZUn+V
         9O8nWWk3Dsr1jAvY48at6af5AIMmYhG/VhPjOfKwmXgP4RlljxS1iYQDTA6slUPgpS0j
         o362suEHbIFxjdQCCpcckggyESpQwRxQHtrvfJgUrzNbnlj4od7iM4gZ8gV2ZtkVzfVX
         12sx2MUSSukWm1PdUAov8xFw9yzU/MA6HlDqULlel9iSeOGJHBFOOQwLEOg3maUJgYMo
         5FMQbl6TDv6H0FRYO3sVOCdAMUxSp2gWwpZ3MUK9cKl8gAY7fE+c3OWnR9mYzKRBd7F9
         r+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069373; x=1751674173;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQ6py8YyTA5edQBe5gZaCd4Je3r3oqAKBpXvDGlotkU=;
        b=Gr86VqVUbVl82Chl+LCj9cqNi/6rrrzK+BQSE6w2ek+bECOPPkkyT4xGZjEkiK7J1d
         3BjI2hVTr7t3V1I0xHrTJ7hHjmAXCHXMjB8LqNr+jMxB9CDBJ+oPH+KQ0jIIJ864wI20
         7JbXay+jtyLzLx0kSv3hGmL6UGxafMCqNqtRSFt4gF2nO6gtKXE88CrTzzA/Xf0zgn8J
         GIq8C9RuzrPhk+ifpYrUxbArBebHVrOjK83ycV+pgDXO+LdZJJqIqzWW27QkH+gCTnKz
         kYuN6nHVueYdmPUS6U0w119hyQISADAC9V1ILUVVKDXw7AaLd0ZgSUMc6E93/0dwaxzg
         7HAg==
X-Forwarded-Encrypted: i=1; AJvYcCUIEJi8gH0p14x9wKYeL6LzZYa0cWMDxDVVJtirS60BcBnOzzzKMZaESMApT3zhy0ohVLW95ORkrcLdj6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7+d3lhfNmXkfe8Jp/48Q2+Xg01tItPIHGb32uGFIvugSwnV9
	tpz8GPdru0zXFNIHGinDML69ybAr9GsfoyD1TnrvwSAb1TJvWd9lqV+t1cR7FqdoSY802g1bfiL
	18fnGMo/vbw==
X-Google-Smtp-Source: AGHT+IFY4CjbN0QNQ8jJjx6YJFV9ML628lYH7hKJN1gUIhv5ovypDCMmEAtoXjHW5ukcNSZNTqu2lFzaYgt7
X-Received: from pfbca7.prod.google.com ([2002:a05:6a00:4187:b0:747:a4c0:983d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:856:b0:747:bd28:1ca1
 with SMTP id d2e1a72fcca58-74af6ebdfa8mr7840533b3a.3.1751069373101; Fri, 27
 Jun 2025 17:09:33 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-1-irogers@google.com>
Subject: [PATCH v4 00/15] New perf ilist app
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series builds up to the addition of a new ilist app written
in python using textual [1] for the UI. The app presents perf PMUs and
events, displays the event information as in `perf list` while at the
bottom of the console showing recent activity of the event in total
and across all CPUs.

The first part of the patches are a few perf and perf python C API
fixes, most importantly the counter reading in python supports tool
PMUs.

The second part of the patches adds event json for the software PMU
and makes the tracepoint PMU support iteration of events and the
like. Without these improvements the tracepoint and software PMUs will
appear to have no events in the ilist app. As the software PMU moves
parsing to json, the legacy hard coded parsing is removed. This has
proven controversial for hardware events and so that cleanup isn't
done here.

The final patch adds the ilist command. To run it you need the updated
perf.cpython.so in your PYTHONPATH and then execute the
script. Expanding PMUs and then selecting events will cause event
informatin to be displayed in the top-right and the counters values to
be displayed as sparklines and counts in the bottom half of the
screen.

Some thoughts on the series:

 - The PMU changes will conflict with the addition of the DRM PMU:
   https://lore.kernel.org/lkml/20250403202439.57791-1-irogers@google.com/
   when these two are merged together ilist will show yet more
   counters. It'd be nice if the DRM stuff could land and then I can
   rebase these patches.

 - The parse-events clean up of the software and tracepoint PMU. The
   software PMU hard coding to be legacy first has similar issues and
   will conflict with the clean up in:
   https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
   Moving the software work to json means we don't need special parse
   events terms for software events, etc. We can just treat things
   like regular PMUs with json, etc. I'd much rather we had less
   special case logic so that series is best rebased on top of this
   work and it should drop the changes for software terms, etc. which
   this series removes. Maybe one day the whole event parsing can be
   much more regular in how PMUs are treated but there's always
   "cycles".

 - Should python libraries have feature tests? How does this get
   packaged outside the kernel tree? I think these are open
   questions. Clearly textual is kind of a big dependency and we've
   largely been moving in the direction of fewer dependencies
   recently. Hopefully the app makes it clear why I think this one is
   worth carrying. We carry libslang as a dependency and I think
   textual clearly far surpasses it.

 - How to launch? Currently I run tools/perf/python/ilist.py but it
   would be much nicer if we could do `perf ilist` much as we do for
   perf-archive.sh. There are probably other scripts that should be
   perf commands like flamegraph and gecko. It'd be nice to follow up
   the series with something to make using these commands easy.

 - Additional thoughts were captured on the mailing list:
   https://lore.kernel.org/lkml/CAP-5=fWC+doaVd5rEMWJXSQi_db_Wu2tyAe5Lm6jnQjcwXkF+w@mail.gmail.com/
 
[1] https://textual.textualize.io/

v4: No conflict rebase. Picks up perf-tools-next DRM PMU which
    displays as expected.

v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
    keys. No changes in the ground work first 14 patches.

v2: In the jevents event description duplication, some minor changes
    accidentally missed from v1 meaning that in v1 the descriptions
    were still duplicated. Expand the cover letter with some thoughts
    on the series.

Ian Rogers (15):
  perf hwmon_pmu: Avoid shortening hwmon PMU name
  perf parse-events: Minor tidy up of event_type helper
  perf python: In str(evsel) use the evsel__pmu_name helper
  perf python: Fix thread check in pyrf_evsel__read
  perf python: Correct pyrf_evsel__read for tool PMUs
  perf python: Add basic PMU abstraction and pmus sequence
  perf python: Add function returning dictionary of all events on a PMU
  perf jevents: If the long_desc and desc are identical then drop the
    long_desc
  perf jevents: Add common software event json
  perf pmu: Tolerate failure to read the type for wellknown PMUs
  perf parse-events: Remove non-json software events
  perf tp_pmu: Factor existing tracepoint logic to new file
  perf tp_pmu: Add event APIs
  perf list: Remove tracepoint printing code
  perf ilist: Add new python ilist command

 tools/perf/builtin-list.c                     |  47 ++-
 .../arch/common/common/software.json          |  92 +++++
 tools/perf/pmu-events/empty-pmu-events.c      | 266 ++++++++-----
 tools/perf/pmu-events/jevents.py              |  18 +-
 tools/perf/python/ilist.py                    | 376 ++++++++++++++++++
 tools/perf/util/Build                         |   1 +
 tools/perf/util/evsel.c                       |  21 +-
 tools/perf/util/hwmon_pmu.c                   |   2 +-
 tools/perf/util/parse-events.c                | 225 ++++-------
 tools/perf/util/parse-events.h                |   3 +-
 tools/perf/util/parse-events.l                |  38 +-
 tools/perf/util/parse-events.y                |  29 +-
 tools/perf/util/pmu.c                         |  44 +-
 tools/perf/util/print-events.c                |  95 -----
 tools/perf/util/print-events.h                |   1 -
 tools/perf/util/python.c                      | 248 +++++++++++-
 tools/perf/util/tp_pmu.c                      | 209 ++++++++++
 tools/perf/util/tp_pmu.h                      |  19 +
 18 files changed, 1282 insertions(+), 452 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100755 tools/perf/python/ilist.py
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

-- 
2.50.0.727.gbf7dc18ff4-goog


