Return-Path: <linux-kernel+bounces-801556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA8B4469D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AD2A45D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42F12741BC;
	Thu,  4 Sep 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3ti+5b9"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78972271475
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014905; cv=none; b=IXXg3A+WD9YRw80edUog9J3MgfYw4viIqXB8EGSVvVJEFkaxV1z0vICXvmr8skLpaCRFZPsGVAZEVMbWyEOfw6dhkOD+Ont6Z1ijTflJKey7OI2CjRTnx1eNlILrPnrGmS/ps51ncxtNLom+O6AK/Cmc2wV+N+9xenuME3CaaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014905; c=relaxed/simple;
	bh=SD4feEDz099dviVXHxyOJnmYskaSD0WFsGh1W3/IeWA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=YQwtAYL9wJTuHcQmhVVOcB9Rq78s6pss562Ke48koaZUl7mc9/C113n83Sus4fsmd/apqjQIZB7AMY70B2AScyJ0P26eD2Z0SfnmftecvIZbgjiDRiznyxE1NTjrne0xRj87caQJpcUEq4MQlX9YXyOn65LekasMFM4z/xhVs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3ti+5b9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7724877cd7cso1544158b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757014904; x=1757619704; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sZI6kEYna004dMQHYv3cG2ruOvPD+QWfhyKp1dF54qo=;
        b=w3ti+5b92tS3/9ttgRXh6lymS33tH0AjRg02R/r7uitrGuR43RTYubUOgjR6GVOiz0
         WbuEVbtjY1EmnoYXBs0PjvNbuA8p7m0C2q8zdk9x+e/WPdli0Q0vh2wFZ8/Z2FkMe/w+
         a2fjCAX0+P2mF5rhKzsDVhr0jzvqySvMKus+4Ezb0kU73gZDuER4KN2DvaV6e5BMXFnA
         Smah31p+oa+O+nuq+QN+ZbJwcMcwzzg2+Wj5ph52uI2Au50MSmBC2O9lBJcv930kOWuJ
         MzogLvTemG5afm0OTEHgYl4fSH4PbzegBQG2Z22xQ4aRNHMEZEOF3j/xAnfYdZO1vdWh
         fAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014904; x=1757619704;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZI6kEYna004dMQHYv3cG2ruOvPD+QWfhyKp1dF54qo=;
        b=g8ttf1M5G1OrcyeBHAbZ/Ga4rdWlf1PEMzrlWBde94aNbwUEZJI5ldDNBe27q4nWCV
         6jVPA1Fy2GkMWqn3csnkRg5hrKE07TV8Sbrho6VPJrUmXwKpqc9XyjogAUw5Io06O1Y8
         ExBkpYbVO0ROGEx+kPLz6zYu52VXSP43WnOp+8Wpp3yHvFtf179U4drV9W0vHP0+siau
         XBv2WTDEY9KOPzwVVMBDNqUvdlA/9+LHxC7B9MNKCD3behuSzyrLAi042il55YXgYEVO
         Hc4kEWpgdEn9K7/Azzq/4+1f2JtVJ34CiXNS/v4M707O+OrRxLQM8x4xr+tg2oViCug+
         TZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXM05zrPjGC5x0v5xbJzv7E9Yegu29LPlF1XXxFGqrU/Wo39CSc2w/wFwOwMjdgIYubRXoDvoZSIezq6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7xM5iUH7s5CJ7qQFfYhuymIySG/R7q7WM5T1rzj1BeiPsNyR
	pcaoZ1VtWjOixua+0AZRGB4lJE0eaIDNNyvWf6RPOPymmJfgP4Daowfc3+MexWm4AHzp6QwNHHp
	EbhP4F6sqag==
X-Google-Smtp-Source: AGHT+IE1H8VQAHCJZX4Y7Cwj4lyrd5TBeC4C5GhnJyBBPCvuKee3ZYnlSCzy2xRXiTk0Hv76dlXXZYSJt7uk
X-Received: from pfbdk10.prod.google.com ([2002:a05:6a00:488a:b0:771:ea87:e37d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d55:b0:772:260f:d7b1
 with SMTP id d2e1a72fcca58-7723e3604bcmr23194999b3a.16.1757014903745; Thu, 04
 Sep 2025 12:41:43 -0700 (PDT)
Date: Thu,  4 Sep 2025 12:41:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904194139.1540230-1-irogers@google.com>
Subject: [PATCH v7 0/3] Python generated Arm64 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Generate two sets of additional metrics for Arm64, where the topdown
set decomposes yet further. The metrcs primarily use json events,
where the json contains architecture standard events. Not all events
are in the json, such as for a53 where the events are in
sysfs. Workaround this by adding the sysfs events to the metrics but
longer-term such events should be added to the json.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20250904044653.1002362-1-irogers@google.com/

v7. Switch a use of cycles to cpu-cycles due to ARM having too many
    cycles events.

v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.
    https://lore.kernel.org/lkml/20250904045253.1007052-1-irogers@google.com/

v5. Rebase. Address review comments from Leo Yan
    <leo.yan@arm.com>. Prefix all metric names with lpm_ (short for
    Linux Perf Metric) so that python generated metrics are clearly
    namespaced. Use cpu-cycles rather than cycles legacy event for
    cycles metrics to avoid confusion with ARM PMUs. Add patch that
    checks events to ensure all possible event names are present in at
    least one json file.
    https://lore.kernel.org/lkml/20250829053235.21994-1-irogers@google.com/

v4. Tweak to build dependencies and rebase.
    https://lore.kernel.org/lkml/20240926175709.410022-1-irogers@google.com/

v3. Some minor code cleanup changes.
    https://lore.kernel.org/lkml/20240314055801.1973422-1-irogers@google.com/

v2. The cycles metrics are now made common and shared with AMD and
    Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
    assumes these patches come after the AMD and Intel sets.
    https://lore.kernel.org/lkml/20240301184942.2660478-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001325.4157655-1-irogers@google.com/

Ian Rogers (3):
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
  perf jevents: Validate that all names given an Event

 tools/perf/pmu-events/Build             |   2 +-
 tools/perf/pmu-events/amd_metrics.py    |   3 +
 tools/perf/pmu-events/arm64_metrics.py  | 150 +++++++++++++++++++++++-
 tools/perf/pmu-events/common_metrics.py |  18 +++
 tools/perf/pmu-events/intel_metrics.py  |   2 +
 tools/perf/pmu-events/metric.py         |  36 ++++++
 6 files changed, 206 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

-- 
2.51.0.355.g5224444f11-goog


