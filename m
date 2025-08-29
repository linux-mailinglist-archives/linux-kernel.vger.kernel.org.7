Return-Path: <linux-kernel+bounces-791037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367DB3B16C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1CE1C837A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595FD2222B7;
	Fri, 29 Aug 2025 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xE6QN7La"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB71DFD8F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436854; cv=none; b=hgGF3fVYk9Lu9Z6mb0UKvMbZ3onr5WB1X74Vg0M1sa4WPVNZnNXYs/PRN+jOE6iYVM6OWw/LM7gKoxV/TTVrHphr9sZF5qp+zp6v93kjfEjJGS9Hs/1QSNMeH5I9Me2qj7hjecMY3J1SvA211cNgBzupeEo5Co2SoXpsLNwVQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436854; c=relaxed/simple;
	bh=myK8Ob4Z+6xtsYGnGS9ULJ3rDZoc2c71W+1gOq8NKi8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ViFMczM/LNosFdQBM27Ynf7jS6RPxp4cxCaGZwHitHqEdJ7pNAdzjARhjVrMvLyUwnQfGRrKOBGrcCYCrIaeOKhcsKd9I3RBUXo9qyGVWvn4c7ivdSAnxfNO8zXIH2yULayrUrpq3esPRZr1N1ZimG3BC7jk5FOOHXmijMC/H98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xE6QN7La; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e96d4ddc8ffso1959207276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436852; x=1757041652; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qh3dRbQ2YjEIVqs97MUtbBBgOVsFDMVUksL5khpmJT8=;
        b=xE6QN7La11NR+OgASaAX/EV3xx++BMVLf+TZo8wLKzHwAvuzuIcNw91Gn+Mcf2YzZY
         CawY1Kbm1KfnTLtshTsxKQT8XYoLS/tek5RDSWA/05u15NkPmnOhwq0+RAVriw9bUgMT
         6T1nnqwhm5+IUdBsiS9C3eTxY91PbGgmWfiujTvfSnzJQL6Ip/EidevRs6k0b5j2D3HA
         AAZoco4igWz8ExOvujUb0YjuwWW8L0Ppvtc0OTE2gbE5/atGO/Ro8OawRahfbboiJcss
         HD1gc2A2vfAs11w3Jmp80amWDnpdKJFEifJSew4UpTNCq0uNcdSSf/JJoNMi+BX/4QaX
         NNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436852; x=1757041652;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qh3dRbQ2YjEIVqs97MUtbBBgOVsFDMVUksL5khpmJT8=;
        b=NxYT5Zw2MRPwnddnKBG2rytREJECc/+GIjoJKy+0+GFZdy9LurDeSZo6NwxDnkgUNH
         SEliAqc/i7L6HBt+LPxa53pQ6qJ661lu0yBe6lF8t6NP9Y9WofWFmdfRo2ImXftdMt26
         FZxFRsPjYnaMOMGQQDaL0A1oRW8ZTx7ou7vTG1ZybfZi6IEpeIzk9bIqNFAr6xTHgcFm
         iVmINHkELtZdGL4re/V8ckjRntfsGugxW6YQxuzCXbeBnLLb/GN3lAiy64O7U5umIuYX
         2T0Y8+f5aE4ifDQ+qMU1rabTQDAxdsKbJ0drZG39sZd2mM6x2ZIbMZHiK/+cgrgPnmV3
         S+vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX12qYGQGqGOdUed47PORIdBnLmFHvJIqxoij154OAYyFZqAHsbiKNfNzXZ2+OqPFSzyaHeowSVCA37nwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVQpjZwXvaKzJGt5zT4ZESVeRBFwyGZMszylbsRpbE0fgnCnz
	xQr36Qo9idjP7buz2YUNGnZBs2RVzGnW78xH6cCiKmuNmwRcYVPzFwGSBIBBbmi7sT/yM/fLQG2
	XFrSRO5GiYA==
X-Google-Smtp-Source: AGHT+IEVlqUOzA+dwPlYTvOtuR3xWLzmYPFD7Sdkj/WOvIopxDYefZlt2klRgo2irI/knjbDpLzFNt5MwzSY
X-Received: from ybey192.prod.google.com ([2002:a25:dcc9:0:b0:e96:dc7f:dbe3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:1083:b0:e96:f9b8:ba7
 with SMTP id 3f1490d57ef6-e96f9b81721mr8563691276.28.1756436852119; Thu, 28
 Aug 2025 20:07:32 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-1-irogers@google.com>
Subject: [PATCH v5 00/12] Foundations for metric generation with Python
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Metrics in the perf tool come in via json. Json doesn't allow
comments, line breaks, etc. making it an inconvenient way to write
metrics. Further, it is useful to detect when writing a metric that
the event specified is supported within the event json for a model.

These patches introduce infrastructure and fixes for the addition of
metrics written in python for Arm64, AMD Zen and Intel CPUs. Later
patches will introduce the metrics split apart by the vendor.

v5. Rebase on top of legacy hardware/cache changes that now generate
    events using python:
    https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/

v4. Rebase and small Build/Makefile tweak
    https://lore.kernel.org/lkml/20240926173554.404411-1-irogers@google.com/

v3. Some code tidying, make the input directory a command line
    argument, but no other functional or output changes.
    https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.com/

v2. Fixes two type issues in the python code but no functional or
    output changes.
    https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.com/

Ian Rogers (12):
  perf jevents: Allow multiple metricgroups.json files
  perf jevents: Update metric constraint support
  perf jevents: Add descriptions to metricgroup abstraction
  perf jevents: Allow metric groups not to be named
  perf jevents: Support parsing negative exponents
  perf jevents: Term list fix in event parsing
  perf jevents: Add threshold expressions to Metric
  perf jevents: Move json encoding to its own functions
  perf jevents: Drop duplicate pending metrics
  perf jevents: Skip optional metrics in metric group list
  perf jevents: Build support for generating metrics from python
  perf jevents: Add load event json to verify and allow fallbacks

 tools/perf/.gitignore                  |   5 +
 tools/perf/Makefile.perf               |   2 +
 tools/perf/pmu-events/Build            |  51 +++++++-
 tools/perf/pmu-events/amd_metrics.py   |  42 +++++++
 tools/perf/pmu-events/arm64_metrics.py |  43 +++++++
 tools/perf/pmu-events/intel_metrics.py |  42 +++++++
 tools/perf/pmu-events/jevents.py       |   7 +-
 tools/perf/pmu-events/metric.py        | 167 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 333 insertions(+), 30 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.51.0.318.gd7df087d1a-goog


