Return-Path: <linux-kernel+bounces-774709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0DB2B65F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08103A58C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9CD258EE5;
	Tue, 19 Aug 2025 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSqKBiW4"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8365257427
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567618; cv=none; b=FWbANeD7kA3S8+ELh8IEkmustTDw8M8fR+1PuCUN5lSjdtFXSkJ8aLJnKr2zBKo1JujjWyJbqyeDsUD5uoncV2vz8XmZDC0QEOkjrhItP2SroXoX65Nag9WdKppiCR/8fBQwpkmPkn5XMjZnHaI8gTCu+h2i2FePRDMEPyS50FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567618; c=relaxed/simple;
	bh=egelazQYZ7onyUWC7gv9948fWZw37+Sw3rZW69y/sqo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ZQGdOC3W4ytItTVG9+XCUrR/v6HxTPzrQuPDaLdDXVFTYVKI/2nNZ95XOTfZNqzFdzLU+0zUFGOnEF5jc416kBWovgTKJTw6Fl8bL1zRhlUBBcV5WZXfm6dYhWw9na3A6K6mNPy51CYwUUsjLN8Kj9U8ZMCuUgvYsV71uH6cfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSqKBiW4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267b6c8eso10568637a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567616; x=1756172416; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sTgK2PqFLn7B6BmEq5Hz23j01dxxBaIzoGkm9EZHT9I=;
        b=kSqKBiW4Ukl4l/PuSyGlx6AsMFZSNQqKPArwFEEKf3Sb6NvaAQpESeTs9t5d+gs/w4
         k/1VW2jEV0Iu5YTYomYRO+5g+uvQLCrqD7z4wHJrRCphAXEUh7Y/KQy0CJuzxuTjzgBj
         UxHYjj4ijboUwM1/hO1EijSAZJG6cGSmeekF0hNDkzND+aGUhsWja0gzGGDe2TU2Ku07
         eR3acGv7prg6tTR5tl4icjtxs3JIhiwph0kXT8GN0K47NLt4x5R1j3WpODHe3yyttWOI
         73Bc5szfsedXbJhR8Y8Heghh0w9wqmjwI5x958B52MlRK7+so/d78ue3VNztuAE/0J7t
         Wlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567616; x=1756172416;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTgK2PqFLn7B6BmEq5Hz23j01dxxBaIzoGkm9EZHT9I=;
        b=a90NU2jYGsQ+5+Rkg8knLE7dtUX2dZMobD7kG41HgbCOgqhTT8ejCAkJEU2/2XMI3q
         rmtwmKLdAgPi+h4pjdmdMCZYbNzNT168X0vczntVAp2Yqwl/FYgvFFAZh4rC4EoN41eW
         gF0hW627oVfnRbjnKeNc3ONbjud6TcEZbEHovBn2+rWi0cji2aHtcOnCMZwrFLOelq9f
         gwI1hCLszYccDWsV+5XVlDfOyzLmPsMZ0Nvh19GQ5BkYut3CFq/qOG5a1GzEoYZfBhdF
         cOJ8Cs5SwCJPsR5V1JJs7UmNWehoFqPs/mwvSGVIbgjXFkRRILzUwfowSIiA0MNAM2gA
         aW8g==
X-Forwarded-Encrypted: i=1; AJvYcCXa9MQrDQHJyZvvzpFQrQ/OWfTKluEc+m3jauTDXlNgHN8y0B2OLD1pNH62WAE/ZsnlV7wTalF7IdRxF2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiLX1BCzAvRoGchQ0qFT0D1AGvgwma5UHh0m2LxL65K6PDgDK
	5XE+pxYpQelWkye7z5HAQ4eMSYTlk3UxONeHmP1oSf/cHGC8vozyzCNbiszzHmqA8d2ZKuBfhKP
	aDFBe9VpJIA==
X-Google-Smtp-Source: AGHT+IE2JGUHW6rEkST2x0EaO9vnngBeIaokxxp9JEuRLzo6SEYqK55eqZ1h4vhBfozgzW871Nidcvjmyv9b
X-Received: from pjxx7.prod.google.com ([2002:a17:90b:58c7:b0:313:245:8921])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5388:b0:31f:b51:eef9
 with SMTP id 98e67ed59e1d1-32476ad4524mr1326167a91.17.1755567616143; Mon, 18
 Aug 2025 18:40:16 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-1-irogers@google.com>
Subject: [PATCH v10 00/11] New perf ilist app
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

This patch series adds a new ilist app written in python using textual
[1] for the UI. The app presents perf PMUs and events, displays the
event information as in `perf list` while at the bottom of the console
showing recent activity of the event in total and across all CPUs. It
also displays metrics, placed in a tree through their metric group,
again with counts being displayed in the bottom panel.

To run it you need the updated perf.cpython.so in your PYTHONPATH and
then execute the script. Expanding PMUs and then selecting events will
cause event informatin to be displayed in the top-right and the
counters values to be displayed as sparklines and counts in the bottom
half of the screen.

There's been feedback on how the app works, simplicity of
implementation has been chosen as the first criteria as the app can be
further refined from what is here. The choice of the name ilist rather
than say istat was deliberate as I wanted the app to encourage PMU,
event and metric discovery, as with perf list. The output counts and
spark lines are just to give an indication of what the event
gathers. ilist comes from interactive list, there's probably a better
name.

[1] https://textual.textualize.io/

v10: Add Howard's reviewed-by and address documentation fix. Rebase
     and drop build up patches merged in v6.17 by Namhyung.

v9: sys metric support and pep8 clean up suggested by Xu Yang
    <xu.yang_2@nxp.com>.

v8: nit fixing of issues caught by Arnaldo and Namhyung. Add Arnaldo's
    tested-by. Fail to repro issue reported by Thomas Falcon but
    encounter textual rendering and DOM query race, add an exception
    handling path to avoid the race being fatal. The change is minor
    in patch 16, so Arnaldo's tested-by is kept.

v7: Better handle errors in the python code and ignore errors when
    scanning PMU/events in ilist.py, improving the behavior when not
    root. Add a tp_pmu/python clean up. Minor kernel coding style
    clean up. Fix behavior of ilist if a search result isn't found but
    then next is chosen.

v6: For metrics on hybrid systems don't purely match by name, also
    match the CPU and thread so that if the same metric exists for
    different PMUs the appropriate one is selected and counters may be
    read. Likewise use evsel maps and not the evlists.

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

Ian Rogers (11):
  perf python: Add more exceptions on error paths
  perf python: Improve the tracepoint function if no libtraceevent
  perf python: Add basic PMU abstraction and pmus sequence
  perf python: Add function returning dictionary of all events on a PMU
  perf ilist: Add new python ilist command
  perf python: Add parse_metrics function
  perf python: Add evlist metrics function
  perf python: Add evlist compute_metric
  perf python: Add metrics function
  perf ilist: Add support for metrics
  perf tp_pmu: Remove unnecessary check

 tools/perf/python/ilist.py | 495 +++++++++++++++++++++++++++++++++++
 tools/perf/util/python.c   | 522 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/tp_pmu.c   |   2 -
 3 files changed, 1004 insertions(+), 15 deletions(-)
 create mode 100755 tools/perf/python/ilist.py

-- 
2.51.0.rc1.167.g924127e9c0-goog


