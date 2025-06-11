Return-Path: <linux-kernel+bounces-682154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBB7AD5C51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699FF7ADB05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1BB21147B;
	Wed, 11 Jun 2025 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3OlUx7Cu"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795A20E70B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659687; cv=none; b=d/lZpM11yuYIIMn0/vrs9NbhDf6oqWfabwYUDFGFzoUaWfmVELw+7bc4XGRl3jPoG4TsBAzNsl0PM0e1pPvDsHgbjBMntmXe0vi0v8g1X6CDDVr3t4S4W63AooIXqgRPPb00o4WEx41oyYw2H15zw2OjPGg9/VvGfgv581YyZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659687; c=relaxed/simple;
	bh=mbIIuZuXsk8BtnF3xW7j/7Zir3sexa6SLZptvq/m6/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SAKNOSybJn0ElWqSAlC77fcqyDjDDKaW45nRwhtiB3uBWdnaExnDlcE1rknBdD3c6JT3QDxUyvMDg8fWZMi8GJlHAzVSzm92/me/8uhjbfln5Yd22F9xGpLayHEu2AHmoTSHW97KcYLeanROFGE9MzRhEkvqLtXxWvsPQWBdHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3OlUx7Cu; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so164575ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749659684; x=1750264484; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkBwmXKDCmkZmq8tDnjPEVuHAVyvcz2YHx5IjGyY7E0=;
        b=3OlUx7CuuzilzTVZxOMGlXRo2KOU1+wIT65NRxjO3vvN8cGXiE/YGKgzf/rQG7B4aX
         3gIKivWfteu3GgLB0bMawED5AUOdOat1s22OcqX2BKrukPQztOSvvd5Dp581LNdjZJsi
         qOXF1ClthmQG3oVb4IyXRq3sBiK06anmuZuLm3eZcNK670PfFPHyd8DmuppViXwnIF9q
         aLTzcxMiFUJvFtUdVLvWCrOpjt2UZlnNoWrZ7IBnbGQqnYTSThep1ksvyYqV9T+lF/if
         M/SbaVdzaOGkabZWdKmUBUIiEizbxgo8V9ECmD/j3LYe45BcotB19Ai4zM9nojJX/2/k
         y+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749659684; x=1750264484;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkBwmXKDCmkZmq8tDnjPEVuHAVyvcz2YHx5IjGyY7E0=;
        b=YAftwKF7gp0ginOkwzgnJEnIvAQ2s6hv3q8un9qTdSqvej26z6/WvTjH8Y2nyu+uVy
         wZS5DOyQWkm/cA3d6fKvD0xZ3Ij0uafmYDYift9LdP0pXKV2Mud7kBLma8n66gAGbNba
         ViI61eClLQEOTMZ7J6EKMG6RD3S7j1H6qq17uLsF0g48eJ+g+aFVZmU+DhWBSxrkZK9b
         0S26OCYC7SRs95Re8HaIXDzwvqrv/FJAsw2RbT1zikCBSb0jftPL2tJYrvnlX8AvFnRo
         76PVTbgNMNcIquftV3LlKDcRHJe2liIwoKBnwubGVKQBMqKXnbUzKPZriKzb06/0GW7+
         /1cg==
X-Forwarded-Encrypted: i=1; AJvYcCVKDXjVAIgOM/fwPDSOekdQN0yEgClIathlbIDZ9vcBe8fUjOH86R+kv8/oYVq7qAg14JisKuGmZLVCYK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxD5gQkIUif0SiVlB3G+jAKJ5tmce5T0wDMT8YnZmzYvY8LaU
	a/Pe+UEunevOeQgPKuI1jjxmwz7AHEO4jEEPgcx9sdIxd+FyfvzJczs4hN7b7SjccuBCLdtHw+4
	SKV+1LCmO5TSulJulKNq0gYFyYbMax+dWEM4XO4EM
X-Gm-Gg: ASbGncvnrvYhYkwcAyHwlamQzfc4uHMjgU2k5zG1rtAz2psvJ+ZCq4N4dEjJXumP9as
	eiSV6F96wf+XGAs0b12k/cX6CcTKVpquZZzYn/tDUFKI3jvycLZR0ZulfnS6YDtRxz7OMr+Gm3c
	9y33KOe/KZCXSzSFjCI0NYgaubDPRpxgSNvD1A8eTfnlbxjViTGFa/n5zmIBA4I37uxs8W7OcZG
	KP38n9weQ==
X-Google-Smtp-Source: AGHT+IGqxSMXUvEfETSpT+5PxTvAtMzZguwXKe2j9dZe76RzJXaMiWmm2tM870jUEnAiZpohFjz2U6912nnWhgcvGcc=
X-Received: by 2002:a05:6e02:1c06:b0:3dc:5c65:75f8 with SMTP id
 e9e14a558f8ab-3ddf5d34548mr3411005ab.11.1749659684347; Wed, 11 Jun 2025
 09:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Jun 2025 09:34:33 -0700
X-Gm-Features: AX0GCFvavzaFt4IKavvNUXSgpyjP16GBPN8teViN5j5b3bmqk0ToKERWN0QVqNY
Message-ID: <CAP-5=fWC+doaVd5rEMWJXSQi_db_Wu2tyAe5Lm6jnQjcwXkF+w@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] New perf ilist app
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
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 9:02=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> This patch series builds up to the addition of a new ilist app written
> in python using textual [1] for the UI. The app presents perf PMUs and
> events, displays the event information as in `perf list` while at the
> bottom of the console showing recent activity of the event in total
> and across all CPUs.
>
> The first part of the patches are a few perf and perf python C API
> fixes, most importantly the counter reading in python supports tool
> PMUs.
>
> The second part of the patches adds event json for the software PMU
> and makes the tracepoint PMU support iteration of events and the
> like. Without these improvements the tracepoint and software PMUs will
> appear to have no events in the ilist app. As the software PMU moves
> parsing to json, the legacy hard coded parsing is removed. This has
> proven controversial for hardware events and so that cleanup isn't
> done here.
>
> The final patch adds the ilist command. To run it you need the updated
> perf.cpython.so in your PYTHONPATH and then execute the
> script. Expanding PMUs and then selecting events will cause event
> informatin to be displayed in the top-right and the counters values to
> be displayed as sparklines and counts in the bottom half of the
> screen.
>
> Some thoughts on the series:
>
>  - The PMU changes will conflict with the addition of the DRM PMU:
>    https://lore.kernel.org/lkml/20250403202439.57791-1-irogers@google.com=
/
>    when these two are merged together ilist will show yet more
>    counters. It'd be nice if the DRM stuff could land and then I can
>    rebase these patches.
>
>  - The parse-events clean up of the software and tracepoint PMU. The
>    software PMU hard coding to be legacy first has similar issues and
>    will conflict with the clean up in:
>    https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.co=
m/
>    Moving the software work to json means we don't need special parse
>    events terms for software events, etc. We can just treat things
>    like regular PMUs with json, etc. I'd much rather we had less
>    special case logic so that series is best rebased on top of this
>    work and it should drop the changes for software terms, etc. which
>    this series removes. Maybe one day the whole event parsing can be
>    much more regular in how PMUs are treated but there's always
>    "cycles".
>
>  - Should python libraries have feature tests? How does this get
>    packaged outside the kernel tree? I think these are open
>    questions. Clearly textual is kind of a big dependency and we've
>    largely been moving in the direction of fewer dependencies
>    recently. Hopefully the app makes it clear why I think this one is
>    worth carrying. We carry libslang as a dependency and I think
>    textual clearly far surpasses it.
>
>  - How to launch? Currently I run tools/perf/python/ilist.py but it
>    would be much nicer if we could do `perf ilist` much as we do for
>    perf-archive.sh. There are probably other scripts that should be
>    perf commands like flamegraph and gecko. It'd be nice to follow up
>    the series with something to make using these commands easy.

Some more thoughts:
 - The number of events can be quite extensive and so a search UI
would be a good addition. I'd rather it be follow up work.
 - The legacy events for hardware and hardware cache lack json, PMU
alias data, .. and so only partially show up. Ugh, legacy events.
 - A dialog is shown when an event fails to open, it should probably
mention more things related to perf permissions, run as root, etc.
More follow up work imo.
 - Showing metrics would be great. Follow up work.
 - Textual web (https://github.com/Textualize/textual-web) integration
so you can see the output in a browser would be great. Follow up work.
 - The sparklines are against the max in the counts recently read,
maybe this should be something smarter like the maximum possible, or
over time, or over all CPUs.. Follow up work.
 - People likely have thoughts on the way the UI is, like should the
counts be after the spark lines, etc. I think with the python being
only 238 lines (stat-display.c and stat-shadow.c are over >2000 lines)
things should be pretty hackable and we can work on things over time.
The patch is something of a proof-of-concept for that reason, but it
is also something useful, hence posting it.

Thanks,
Ian


> [1] https://textual.textualize.io/
>
> v2: In the jevents event description duplication, some minor changes
>     accidentally missed from v1 meaning that in v1 the descriptions
>     were still duplicated. Expand the cover letter with some thoughts
>     on the series.
>
> Ian Rogers (15):
>   perf hwmon_pmu: Avoid shortening hwmon PMU name
>   perf parse-events: Minor tidy up of event_type helper
>   perf python: In str(evsel) use the evsel__pmu_name helper
>   perf python: Fix thread check in pyrf_evsel__read
>   perf python: Correct pyrf_evsel__read for tool PMUs
>   perf python: Add basic PMU abstraction and pmus sequence
>   perf python: Add function returning dictionary of all events on a PMU
>   perf jevents: If the long_desc and desc are identical then drop the
>     long_desc
>   perf jevents: Add common software event json
>   perf pmu: Tolerate failure to read the type for wellknown PMUs
>   perf parse-events: Remove non-json software events
>   perf tp_pmu: Factor existing tracepoint logic to new file
>   perf tp_pmu: Add event APIs
>   perf list: Remove tracepoint printing code
>   perf ilist: Add new python ilist command
>
>  tools/perf/builtin-list.c                     |  47 ++--
>  .../arch/common/common/software.json          |  92 ++++++
>  tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++++++++-------
>  tools/perf/pmu-events/jevents.py              |  18 +-
>  tools/perf/python/ilist.py                    | 238 ++++++++++++++++
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/evsel.c                       |  21 +-
>  tools/perf/util/hwmon_pmu.c                   |   2 +-
>  tools/perf/util/parse-events.c                | 225 +++++----------
>  tools/perf/util/parse-events.h                |   3 +-
>  tools/perf/util/parse-events.l                |  38 +--
>  tools/perf/util/parse-events.y                |  29 +-
>  tools/perf/util/pmu.c                         |  44 ++-
>  tools/perf/util/print-events.c                |  95 -------
>  tools/perf/util/print-events.h                |   1 -
>  tools/perf/util/python.c                      | 248 +++++++++++++++-
>  tools/perf/util/tp_pmu.c                      | 209 ++++++++++++++
>  tools/perf/util/tp_pmu.h                      |  19 ++
>  18 files changed, 1144 insertions(+), 452 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/software.jso=
n
>  create mode 100755 tools/perf/python/ilist.py
>  create mode 100644 tools/perf/util/tp_pmu.c
>  create mode 100644 tools/perf/util/tp_pmu.h
>
> --
> 2.50.0.rc0.642.g800a2b2222-goog
>

