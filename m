Return-Path: <linux-kernel+bounces-799936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4080B43168
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F34169E04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777E2309B2;
	Thu,  4 Sep 2025 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRafrtwg"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C291F1921
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961584; cv=none; b=gi7eE7esTFpjCpcPdlBTZzVN85PCfu2K+ROIPk1O58nhoh6qNM+eNbfaEtXedSRYk4LMZpydVy8Myuzh7Ra61zkDPaa93481i3uqmQPGJ7557NAouWV6bQExE8nZRzi3ohiYvO/rs5GkwjyY/LiRsFIPW7asGjNrc7fyfuxAu6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961584; c=relaxed/simple;
	bh=iX5MkaW6uk2g2lp1n8rPFpVA3WPaSAFcOC8TE7e0L0w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=jGqFuWPPA2ClD3TtGs57bzjWA+zWIF1fj0SlHmDQJ2QMjaA/aIwXwkQgyIs/Tb5tLt2hIkuDAsVNSFzoPeVKub1Bxfn0NPds9ZtaoivKl1bM67LH6Aw+0Uxpfj9mOgTYfMj1nJhx7tT/UY83B7y0w0IhFQE+v81/us2bHhD6uwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRafrtwg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329ee88fb47so883770a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961582; x=1757566382; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zVVIKL+/pBsUpr0JnoqQzJtxWBTWc3EqNQldVIetYY8=;
        b=rRafrtwgYjsbM7Go2FmbTKMlk5xiYou02jEZ4uLplXaq/fUMxeLkiZfpnXC6/eJXFw
         4YRXtGZeg8UpZMa64xT1HoCKL6C9+RLVcxsx9F66mEvr578ESkD0LYBCaa1We8Su2mGe
         EOs0S2i/ALabPVBK/tSc0rZtvEzKt7O+Qma3PN2RJ+CunHr82IN8QDE6B7yPEaYF0GN5
         Ul9OtyrC3LKBX99+MPKHjzklXAi4MeQ6hu5+b8Mb0AtI7psYp3aMIvCaHsdHQzSGNfT5
         TnQlVgm+OHuokZzMKiP3UnwKgcQLRvnk+dFyMSI3pEeYFCOeVhzb+K8VVpS4bjP5m/PS
         r8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961582; x=1757566382;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVVIKL+/pBsUpr0JnoqQzJtxWBTWc3EqNQldVIetYY8=;
        b=kUTn2I6stgZpt7OnxxXLYYMWMbLqK+aHvZX/o78kXi5j+zYpjZPWYHtH8ntrC9l8w4
         051YuExJe5yW19wjiWTkP/yC4JaS4IvER5lEXGejI54LWzTg3TsULQf+bouW3MJ24PG3
         vxf1CqHtUS50mMpdu7eY9bTlV3u5JCAzyk/e0oNryYefnHLn8RfJv0k7kfiqVoa5GhcB
         pgGqgWTipCTGOXq4Fg1VXBwSmoqylnWNF6LsnCUw31ivCniId62VrQD771k5arRegC8m
         D8Mv10GE1HRxF7lfxFeVt6K0/B2KuglEsTz0XtmxxYkQurz2VEC42uarQQPbghtvbPz3
         gHAA==
X-Forwarded-Encrypted: i=1; AJvYcCXst7YiLlWHiY+dGkXWqdy+qTHNsFXUxwyUMsFLOMoqVHQUQLtwW2e4sklf7DAAiNEP4J4qQ3CK5xperUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2aCS/3e3xwIWe2TIEPqS4VcKWUgzm0Y6/jPSYCD/ZA+oV9qoI
	MO47phxS6MnQU1/JqYhweWnRAhN1a1ltHbZBFkbMCR7b6nePj+AGT0iD19yb4vTpETCACLDN8Hz
	cLeglRLA42A==
X-Google-Smtp-Source: AGHT+IFrE+natmbYsPcjQsXWeAo4BZIt168836F2jRX8boByU9B0l1AypBGUCYZiBK3q+16r6SUw+H44qT+v
X-Received: from pjbov14.prod.google.com ([2002:a17:90b:258e:b0:321:c2a7:cbce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52ce:b0:327:8c05:f8b6
 with SMTP id 98e67ed59e1d1-328156df7b8mr21371154a91.28.1756961582264; Wed, 03
 Sep 2025 21:53:02 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:52:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904045253.1007052-1-irogers@google.com>
Subject: [PATCH v6 0/3] Python generated Arm64 metrics
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

v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.

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
2.51.0.338.gd7d06c2dae-goog


