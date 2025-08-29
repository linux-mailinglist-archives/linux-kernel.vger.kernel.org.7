Return-Path: <linux-kernel+bounces-791155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA171B3B293
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158CC1C84DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B1217F3D;
	Fri, 29 Aug 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0NtR0LG"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8677111
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445568; cv=none; b=fUuub3jmub0cyquHIJAyqijjPuGuX1Fi9g3XZfHfs3H3+jM+mus15qscAqCdjO5F/oDtTk7E7R+OMjKLlMEHrF92PQesNwfIgM78jsKUtPIP08+N5zyofPsVgGq+HyrwT8MX6U0dV9qS4MerBa0rjSo5cITJz29OCmjxOnBqXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445568; c=relaxed/simple;
	bh=I4QACpBICmQCZ3S3+6kNYNVqT3g7uhIV3rIB9wDjn0Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=KxLA4x2cJ7cS4iJLnfiAxTEOKvpUA2s0CzxgDomBZnPBLweFOyG2FUvN/rxh86/0ujzsTytLOS+FUplBDJX26vyrr9o4wER7WVx3vsntToZm/YpTUNZJdarcJLWbqLQhwADhkOxzRg00CWhUQHaeVku9FWySR1PXow7FshV7XAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0NtR0LG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581ce13aso29869565ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756445566; x=1757050366; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dJ7X49u7UEhmM6SEYeosieinrxfPKdIK7XnxPLDzBZA=;
        b=U0NtR0LGRb8KcGgWj2uwz9LbuOkP1NkmYc/0Q3Fs4hTa7djhwTtMPnLwD75Zbcysun
         HPID4RvDEqu8MWEBlF95Pc0CILKU+HSoSyddkZLfQBZDnmuzmlbR6t23lXB+90nYPoMQ
         jkL3ozjQRt/EJ0XU5633H0UVOecV2Vpwxo+WXxCtNRoYnkwUY9uBu0swCkNhO29iHwi1
         MPUXhh4Cb2Dy/LT/OoGJ0FWHALYO2510OrDeyTPpRdqNpUQXZVrBjyW7+P1e1lid28u8
         FSoYq7G0V1z77gGBtHRSlODNJkoFScuATUDPcRTWUfnGVm7yfZjRv5ap07h1HgjANuQf
         8Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756445566; x=1757050366;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJ7X49u7UEhmM6SEYeosieinrxfPKdIK7XnxPLDzBZA=;
        b=ZWOAcSEgcEtwdHR87ItjJOXTQJihyNXcybRCkDnO3lIic3N3VuX3yEXe6OLP5dglzz
         QY//shaZrbqlm78t43MiV7tvXeT7Nt6W/7QCTBJ728gXfLC0oLs5+oRz48OMSaujUMmB
         RAnLXThsLZ1uQjf+wNNKk0iXz4kuGZf31fnfXSzEBtc5509G3homdDA63PIP/GUzOcz6
         ag5jUSdM3pLWyjyiRLoJhOjf3hzj8bwe/qgFvNhWVWyxiPL1MImIYZY/LY+gcCbbzkbQ
         Wle3V4+gidJ9FXOzDkMovKtdlHyNZLh1mbQsNpr3mTYVd2mj1oY8Vuxx+mqsUj7huuCe
         ss/g==
X-Forwarded-Encrypted: i=1; AJvYcCX8/wUcEboREM9lkRc+q+0H+Qy/wdv1fFkatHvPSVpNR1YxPyFFpjKrtQEExi1PMWgq4kvGIhGM5mAPwKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQwxIOYgK65vPAjVynM9zYR18tjbp0ZwLuw+bOxnT4GfEGTbb
	aen2P/LceUreMG6SYdfERRxp9KnRtdY2s7KzGWEKmmyH2XqQpaLILzJSKUPzSxNMwauVA+ipa2Y
	k3aBJZua5Gg==
X-Google-Smtp-Source: AGHT+IEN14rLTCmLlMH2oT9k8izuGJ0QZ4GViZai6MMVnBcx2oVyIfxAYI54jTZklbOPpkrCRBszj6EDXpzq
X-Received: from plha14.prod.google.com ([2002:a17:902:ecce:b0:248:9ee8:cee5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a45:b0:246:ddd6:f8b9
 with SMTP id d9443c01a7336-246ddd6fd04mr238874905ad.43.1756445566290; Thu, 28
 Aug 2025 22:32:46 -0700 (PDT)
Date: Thu, 28 Aug 2025 22:32:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829053235.21994-1-irogers@google.com>
Subject: [PATCH v5 0/3] Python generated Arm64 metrics
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
https://lore.kernel.org/lkml/20250829041104.4186320-1-irogers@google.com/

v5. Rebase. Address review comments from Leo Yan
    <leo.yan@arm.com>. Prefix all metric names with lpm_ (short for
    Linux Perf Metric) so that python generated metrics are clearly
    namespaced. Use cpu-cycles rather than cycles legacy event for
    cycles metrics to avoid confusion with ARM PMUs. Add patch that
    checks events to ensure all possible event names are present in at
    least one json file.

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
 tools/perf/pmu-events/metric.py         |  37 ++++++
 6 files changed, 207 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

-- 
2.51.0.318.gd7df087d1a-goog


