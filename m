Return-Path: <linux-kernel+bounces-673629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE48ACE3E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 19:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D292E18969E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8CB1FA85A;
	Wed,  4 Jun 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IP5s7DrQ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF51388
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059161; cv=none; b=A9gMVz79JRco6aPoWPRLqhIs/+XEwp4pSYVHBMKh5D7sY0jnQhqOx0MdroHTnwZ8L9v7CvnRCvnHLo22OJfUBrJy4JIe+pQWtuPpj18p86OQbsTvwlfEouLyhylfdHPIuBS3Uctg6rliWepV08+hEcN6gKiVkpWSihIlvcFmlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059161; c=relaxed/simple;
	bh=qOvvciBxwW1inYl/V0OhUBXDZSpSnXUyvZeA1lLf+PY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=oqs/C+5Ueaf1h3tzwvwyeVT+dqC915fTF9e8jQ+atGsLkTeowzWx7Sg2pfw867fP0eWp7LkBKJze2E/UQU91jphmdrU69ukm/UmEDcRIsblf4vP8jRpyKzBgwd7lzFD4uF373dbMZ1PE1uVgQAIUVh3OGRvjnw0QFxnDBH9ey64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IP5s7DrQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22aa75e6653so661155ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059158; x=1749663958; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9QaFBLjYOuvDC3/QdBACigYzXP7h80yd3aL1h2SKHY=;
        b=IP5s7DrQ5gCmLTbQKKFmV08a4EzdoWrocsjkf7e9ucNGkc3W7PZtmlGy+aSCgvvatc
         T8jexCRtPqp4S5e7bRyAzEPT5wkxIV7ODt9OWREhQaGvUOojyRPVOkvOv1ssPITEvPdY
         /fWh8FSv/t6oELZSU5qVz1MD2vGbm9b1we0042lRYCBm0OjqehSBOkxKz3SzGfYT4gmP
         cch4QqF3QIsGQIjOq4IowkK7K4EQ8PUDH/u3ZgyoVTLaWP7gnYFd6l09iAMDY8XQ27kp
         CIVQRmglF9MKrf9zXihBY7OCLtoVDI+L2G3ucAZxru1v1pVFYDMzHr9d3eOlBbQlb3jJ
         B23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059158; x=1749663958;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9QaFBLjYOuvDC3/QdBACigYzXP7h80yd3aL1h2SKHY=;
        b=JDmGlP7predP+apa+Vah3VOYBhahKBtGgAPnpCZPkYerBey+iHpmn57FkpIQS+eWst
         KLSHieSUWKHE71SuApPF1LZUtCd0jM6LlyH/8WiFn8+1s8Enltq0081r3q3KvrtZxbOB
         jK+3VfXLYpGN9sCYcfmnaqa/FtNOqS99kaIT7kKvlrBy+hYSzF5uhfZwghos08SjHCL8
         ts7mCoZ3atSIzYWRPzDbxriU8JhAdIfOVgujgrkoGZtBB5k+Omdrk6OyB0qEvLbhwVY8
         kD/eqjVDSl736YcHj6u+DpwGDxd6fasAd1kAkDJz1fx0j1aV6kybYO8TTThYv1l3mkma
         rxsw==
X-Forwarded-Encrypted: i=1; AJvYcCVRb7Lh5f+HXkn4PtGTiMHYwsi3tK9QY7MCfKwKSeCosJvJFMO4OsryOQXdA1MU+zu/k98GK8mG8KeD/RA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hwq/ZOlgnw9zWi1qMhVm13wbxQAeAHXS1/DuM40NbEJiy/Vm
	CZwoOKkB5E/O/jCbCwrF+ht7IBO4L9zG3IkC9xHbdDTFChzm2s3in+tzD3bayXm7X0TUT101/U6
	opo3OSOmWgQ==
X-Google-Smtp-Source: AGHT+IEDlB53AvhsCJwecps6nf/89lwn6FIydGbmAws37kN03WJuqK9+Jo0wPuncznBgMWyX+Lpa1rROiB2b
X-Received: from plgc13.prod.google.com ([2002:a17:902:d48d:b0:234:9673:1d13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8e:b0:21a:8300:b9d5
 with SMTP id d9443c01a7336-235e114f0e6mr51959625ad.23.1749059158178; Wed, 04
 Jun 2025 10:45:58 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-1-irogers@google.com>
Subject: [PATCH v4 00/10] Move uid filtering to BPF filters
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than scanning /proc and skipping PIDs based on their UIDs, use
BPF filters for uid filtering. The /proc scanning in thread_map is
racy as the PID may exit before the perf_event_open causing perf to
abort. BPF UID filters are more robust as they avoid the race. The
/proc scanning also misses processes starting after the perf
command. Add a helper for commands that support UID filtering and wire
up. Remove the non-BPF UID filtering support given it doesn't work.

v4: Add a warning message on top of Namhyung's BPF filter error message:
https://lore.kernel.org/lkml/20250604054234.23608-1-namhyung@kernel.org/
    in the parse_uid_filter helper. In TUI the warning is shown then
    the BPF error shown, with stdio the warning appears below the BPF
    errors.

v3: Add lengthier commit messages as requested by Arnaldo. Rebase on
    tmp.perf-tools-next.

v2: Add a perf record uid test (Namhyung) and force setting
    system-wide for perf trace and perf record (Namhyung). Ensure the
    uid filter isn't set on tracepoint evsels.

v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.com/

Ian Rogers (10):
  perf parse-events filter: Use evsel__find_pmu
  perf target: Separate parse_uid into its own function
  perf parse-events: Add parse_uid_filter helper
  perf record: Switch user option to use BPF filter
  perf tests record: Add basic uid filtering test
  perf top: Switch user option to use BPF filter
  perf trace: Switch user option to use BPF filter
  perf bench evlist-open-close: Switch user option to use BPF filter
  perf target: Remove uid from target
  perf thread_map: Remove uid options

 tools/perf/bench/evlist-open-close.c        | 36 ++++++++------
 tools/perf/builtin-ftrace.c                 |  1 -
 tools/perf/builtin-kvm.c                    |  2 -
 tools/perf/builtin-record.c                 | 27 ++++++-----
 tools/perf/builtin-stat.c                   |  4 +-
 tools/perf/builtin-top.c                    | 22 +++++----
 tools/perf/builtin-trace.c                  | 27 +++++++----
 tools/perf/tests/backward-ring-buffer.c     |  1 -
 tools/perf/tests/event-times.c              |  8 ++-
 tools/perf/tests/keep-tracking.c            |  2 +-
 tools/perf/tests/mmap-basic.c               |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  1 -
 tools/perf/tests/openat-syscall.c           |  2 +-
 tools/perf/tests/perf-record.c              |  1 -
 tools/perf/tests/perf-time-to-tsc.c         |  2 +-
 tools/perf/tests/shell/record.sh            | 26 ++++++++++
 tools/perf/tests/switch-tracking.c          |  2 +-
 tools/perf/tests/task-exit.c                |  1 -
 tools/perf/tests/thread-map.c               |  2 +-
 tools/perf/util/bpf-filter.c                |  2 +-
 tools/perf/util/evlist.c                    |  3 +-
 tools/perf/util/parse-events.c              | 47 +++++++++++++-----
 tools/perf/util/parse-events.h              |  1 +
 tools/perf/util/python.c                    | 10 ++--
 tools/perf/util/target.c                    | 54 +++------------------
 tools/perf/util/target.h                    | 15 ++----
 tools/perf/util/thread_map.c                | 32 ++----------
 tools/perf/util/thread_map.h                |  6 +--
 tools/perf/util/top.c                       |  4 +-
 tools/perf/util/top.h                       |  1 +
 31 files changed, 164 insertions(+), 182 deletions(-)

-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


