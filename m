Return-Path: <linux-kernel+bounces-592630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4690CA7EF91
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55B27A5ABE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 21:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4322223707;
	Mon,  7 Apr 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3r3a0Kij"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306712C499
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060221; cv=none; b=OD6DRnvgUR/8emJVgOuF5/4EoinboVBgKdzjR6ZQbgT9krVlO8WP+fcXS9szp4rFvYvxKlK2dEufhAqr5HDgPd4GwyYrkqdhjFriqWziKJ62sPFdiOG7ZyV0cFcQw4FTL+52Liiksb8ypGMA8GCSw2R2lZXxTm9ESbQ8bpQNmKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060221; c=relaxed/simple;
	bh=9X96HmKAWEM4zBqkqwQy8V0Jw+GK5cr8MOnq9PKjuZ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=NHl6ovnwP3aC+qpxSTl302cJkAy9es4quDn4lico8LSmDUSQz/mChTMRu3GWn0QwjBE/InOPm+Yq1hQMNuhk4O0S6Xk7F+mGcVjjB9Pn8U3uTRdH81ecwx2ILwm08F2yACpQSt7qSgfXRbsBCOfHjfZaabwZ/Zx7M8awcRMYcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3r3a0Kij; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-afd3f1adff7so1597873a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060219; x=1744665019; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OljvANJsHobV72YfnacPOQcCYlCgGGmmSDxS5ifwPLg=;
        b=3r3a0KijM2lKgaoh+0nBwS0OBytBoCnMGYTlJnj+v9JwaB/XwfWiS8jiZgtQ7ojd05
         IXtcKgluV4SLykFPbpPrgl5JebXFyaczscOXdJ05NnC8/k+4/MefbtIaXVlf4+tQwHth
         YRvx4Ok09gdpMTWdzjRSNs2z4T+cJ3Kde/xXoU9osJLdxf2SB4trf/vr1Ta9qzFdijz1
         1h0L0obh4ZDhLSiVtZ9PcHJEOhwO8d8BK8Em8EYYSskHLFylGdP83nFGyEt/PLRlMehi
         H56CR5/ss860qPrcKkBVr8GGzly75R4OYdbBRAG3KzH3lI3XZOeCl6253dqYzXtY92st
         eSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060219; x=1744665019;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OljvANJsHobV72YfnacPOQcCYlCgGGmmSDxS5ifwPLg=;
        b=mvlvPzfTVfhGH8HAEi+bLWJsG4Z83YrolSVtGEWi8iu1SqqVuKwRHPDiWN/EZCHY/A
         201Stn3TdKzpdUYGVlU6BO8QNymmI2qjawd80UThKa5fOvvF2Lj+xmSOaba2OfQP4Boj
         P6blzGW+1nDR2mK+aXNVg7GYyOsX7M+Zqt1q72s0O+mwqRtv1NcS6siwcKH/n4DChY4A
         iZPaexcQ8AVr7FZQcbB5N14+OyV/izF7GVUiaVTthTGdmbkr0fJs39A509Db7+G66Cu4
         PdQIr0VvJ2nZe83XjAcnA3qfitVRjj3GiCatvwp51veeu+sRsaHqlgtBFbvypouEtMku
         8CFw==
X-Forwarded-Encrypted: i=1; AJvYcCVQcW3+u8OjIfU1YZi5/pAGTESNKuQXj4eEH7YVmcdRCJEscoe/7FtHmSIvE95A2xVcQUOhcWZdm6JYtJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr54MpmA2T2J3JKiwZEMaxX+OFSlqEsv+h+i9bDoHLx2ji37j4
	kAZht9MylUExMYrnmITCVh5/qSa903gixd8+yKAeQ2AZ9nsyqUwed51bcyUkK6uyOQ1qod3OH8w
	d9NWTzQ==
X-Google-Smtp-Source: AGHT+IHTV5gOOrcC8/PeXpkTHvDGVUCqSu8LqpAAF0LopP3y5OdF26Xq/qem5MbyeB64xgBPH3bFzhYoeRrC
X-Received: from pjf11.prod.google.com ([2002:a17:90b:3f0b:b0:305:2d68:2be6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58c7:b0:2fa:6793:e860
 with SMTP id 98e67ed59e1d1-306d0b5118amr1433588a91.0.1744060218804; Mon, 07
 Apr 2025 14:10:18 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-1-irogers@google.com>
Subject: [PATCH v3 00/16] Intel TPEBS min/max/mean/last support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The patches add support to computing the min, max, mean or last
retirement latency and then using that value as the basis for metrics.
When values aren't available, support is added to use the retirement
latency as recorded for an event in the perf json.

Support is added for reading the retirement latency from the forked
perf command more than once. To avoid killing the process commands are
sent through the control fd. Some name handling is changed to make it
more robust.

Rather than retirement latency events having issues with perf record,
make it so that the retirement latency modifier enables sample
weights.

v3: Two fixes from Kan Liang. Ensure min/max statistics don't vary
    when real samples are encountered.

v2: Addition of header cleanup patch originally posted:
    https://lore.kernel.org/lkml/20241210191823.612631-1-irogers@google.com/
    as there are no arch specific reasons not to build this code.
    Fix bug in "perf pmu-events: Add retirement latency to JSON events
    inside of perf" where "t->stats.n != 0" should have been
    "t->stats.n == 0".
    Add patch so that perf record of a retirement latency event
    doesn't crash but instead enables sample weights for the event.

Ian Rogers (16):
  perf intel-tpebs: Cleanup header
  perf intel-tpebs: Simplify tpebs_cmd
  perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
  perf intel-tpebs: Separate evsel__tpebs_prepare out of
    evsel__tpebs_open
  perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
  perf intel-tpebs: Reduce scope of tpebs_events_size
  perf intel-tpebs: Inline get_perf_record_args
  perf intel-tpebs: Ensure events are opened, factor out finding
  perf intel-tpebs: Refactor tpebs_results list
  perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
  perf intel-tpebs: Add mutex for tpebs_results
  perf intel-tpebs: Don't close record on read
  perf intel-tpebs: Use stats for retirement latency statistics
  perf stat: Add mean, min, max and last --tpebs-mode options
  perf pmu-events: Add retirement latency to JSON events inside of perf
  perf record: Retirement latency cleanup in evsel__config

 tools/perf/Documentation/perf-stat.txt   |   7 +
 tools/perf/builtin-stat.c                |  29 +-
 tools/perf/pmu-events/empty-pmu-events.c | 216 +++----
 tools/perf/pmu-events/jevents.py         |   6 +
 tools/perf/pmu-events/pmu-events.h       |   3 +
 tools/perf/util/Build                    |   2 +-
 tools/perf/util/evlist.c                 |   1 -
 tools/perf/util/evsel.c                  |  22 +-
 tools/perf/util/evsel.h                  |   6 +
 tools/perf/util/intel-tpebs.c            | 682 ++++++++++++++---------
 tools/perf/util/intel-tpebs.h            |  40 +-
 tools/perf/util/parse-events.c           |   4 +
 tools/perf/util/pmu.c                    |  52 +-
 tools/perf/util/pmu.h                    |   3 +
 14 files changed, 666 insertions(+), 407 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog


