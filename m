Return-Path: <linux-kernel+bounces-621122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E394A9D442
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 23:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B33D4C2285
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45D922617F;
	Fri, 25 Apr 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ixQNTXaA"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFF20C000
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617224; cv=none; b=bS1xQWpM1fVVAw/EQSmAhGJh1irnbSHRyDYQzQaRr2nLtB9rb1FChNw1dSPwSTzXXl/QQP1+hKupe8dldDcFULN9RohLCeqIq5zbbDGuC3wzwfCPaS6RsB2iz003+ZLpxuGp2IgcsjpvmHK2uOGuz0l9VxDhYjHKCtjDDC5Gz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617224; c=relaxed/simple;
	bh=sPm1j0kNASqcjC28KQkcio0SRLyxLR8PwRMkFcnheZc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hPkDjIc9ddjb75MZTV7JKJ1YNxAU5tWPHG/BkD7+jsF9jgeUT6Q2owo5nKNX41pzi/9uwGvvszC02pCaxq3IUUD21TS+n4ul+xFRnifcqvQzXRLKkF3vxX2osa9ejc52V0G9VO7puhK/d600G1WoHG7UD4kt+HW1ezCw6ntXDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ixQNTXaA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ce15cc3so24570155ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617222; x=1746222022; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JZkT3hJLfXWyZhwGuTx/lA7lkjVFZuKbFGJdA8gIfD0=;
        b=ixQNTXaAiJWVFbt01REqm6IjOEpJxiyk2FzLpew4JDc/YrSi3jrEhf7qex03eID/sR
         6JSMu8nNT+S6zkk7AaL4GsbuNIOgMGmNTP1xagzKdMmpgI1WKUfNHzDMk/j03UViAG26
         aHfeRw7fDzYe5qehUGnGBK30nf/CJuQr3YTZHMC05mPh4+2OIwmIIlFu+GxEjhVCMh5/
         4qY3jv243+BPS/PSYvfcV5ufTxLE2yAzFrOOBg5ob2WyBdZKuqvD3bLl/c/lkJcZI5Vz
         GFJbggfwJy+KAQG0/kCB69LDFFWmJX4UGvYJbiB6W2iG509lwJSJ67MpPe0d8FlOdbY7
         T4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617222; x=1746222022;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZkT3hJLfXWyZhwGuTx/lA7lkjVFZuKbFGJdA8gIfD0=;
        b=OI4feHIMEyNkFLt6khuR85p6VuJhbBnXdVihEg6PPqdLi14BGHgKIF/eQrob6On7d2
         yqL6VrJyGenRW9qlCh7Q0VJCT6vaCEszwFuLEUk/dO4Ggcu8nEMMUjHm6/SXDrnU0xuv
         H+PATz/0cnHk5qySqeoI+9Qfk5omnAEOB6fZ2vKtiTQ3pnXYi8XcipYcfbQBxzt4l/bw
         40vMUfTD3s+HUrcGwOh43cx70WsG3Oyy4fX59FMvcb1zNext0tnbIggOx3binfCqrZrV
         KhKFWbnioUZq267rW8H+xIrWebLOnSr61JJxxBVO4nenNF5i0MWILNx4GAnAj5w/N8oR
         dlWA==
X-Forwarded-Encrypted: i=1; AJvYcCXhlIECcSAFlLQcBk6jXQu/0oCEDQJmTm3iBXdRO5ZKdrYATvU1VvoOfm+xC8c8xs18oWiEJn9Rk01wHXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAvMsLRc2N5OptJbiJkkmJ88T6WTEb0l+lNJ9UkGNKZubj8Nz
	uuJ1J/SuDwblHoYy5595pHyhPuW0fQVKz9pqQPfRLiN+6Z5aGxlXLL/jm+ZlJoNlVV4LVWanSKj
	hy9omRQ==
X-Google-Smtp-Source: AGHT+IHNnoSH+LJKc6L1xuZYAFnUOhlnqaRx2yzHzgCCWPjFmVxdahJT3uariE4SGmNSIj2Gs6T10wsSIiz3
X-Received: from plbiz4.prod.google.com ([2002:a17:902:ef84:b0:223:34ac:396f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aaf:b0:21f:988d:5758
 with SMTP id d9443c01a7336-22dbf63a198mr66131555ad.35.1745617221875; Fri, 25
 Apr 2025 14:40:21 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:39:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-1-irogers@google.com>
Subject: [PATCH v3 00/10] Move uid filtering to BPF filters
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
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
 tools/perf/util/parse-events.c              | 33 ++++++++-----
 tools/perf/util/parse-events.h              |  1 +
 tools/perf/util/python.c                    | 10 ++--
 tools/perf/util/target.c                    | 54 +++------------------
 tools/perf/util/target.h                    | 15 ++----
 tools/perf/util/thread_map.c                | 32 ++----------
 tools/perf/util/thread_map.h                |  6 +--
 tools/perf/util/top.c                       |  4 +-
 tools/perf/util/top.h                       |  1 +
 31 files changed, 150 insertions(+), 182 deletions(-)

-- 
2.49.0.850.g28803427d3-goog


