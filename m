Return-Path: <linux-kernel+bounces-823696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5263B87383
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8804D1C286A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8D302769;
	Thu, 18 Sep 2025 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j76WnC9L"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA502FB081
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234130; cv=none; b=Ki741OU1Nuswd6HVnXaHHOR93Fa1i6e+I0ceLcnrkYZ63KkdBAOs2UqtlQjINdNT0KzrSku8Apnjn1gyl3DeV+kl2zFEjX9012ebBApAfAG0vHjzTQ+MaH09XqQ01sG8l3YFbVUr3XNw7Ce+fl9pDQphmMfGiC07VjpMa0uzLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234130; c=relaxed/simple;
	bh=B1qncqkGZBlGmoRjWSdOLv2hw8gFwrEhONtGaXyf8dg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RiG2JsvdHsyssyJwymQIIZxmUfjKHf98GOi/RROHvXhGzlSMWzUd8nA9xfW2xl77TjZCXmCzQ3VfwCKkkWOsDHdUALhTMykgq/3ksx7zVFCjVmIss8NYJkCELf5SHnSNZsuk8JFecYMg6Bm4gGhlvfFF2pgQ9ajL02BCEDTSGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j76WnC9L; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so1421030b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758234128; x=1758838928; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKYJvBahvbkcM2QwKRyULEXALXOTmp7qcHJNyKe9Ay8=;
        b=j76WnC9LapzL/aoJ4uRXcqAFx09djFjEJAAAT9m1mkRAkhNNPLsiLJCzUOQ6UYpkdV
         r0a/3hjPcdydaLUyIH9Y2nzMREUMoIiks3vxt/6b6Jr2G8zAoYLCLLvEPvaHijOALvET
         v6YlnmDoIfmSyxlMcf5uhpeU+3lMkwUxpNfsjaotsyBg2c+zH3zDV1OM2/HSV7D/K2mL
         ceaZ4avrIQdRjgYUYnEskzYPhlLksQtdrOphll8U+TaLQjHWXDAEZDD2nI+QvYNprw2B
         in72+dW643zkiF4W96Gol0B4FTXYITK73a/s5eU3y9JEbMF7EPUhBHK3oq+77eLg8DvH
         ETrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234128; x=1758838928;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKYJvBahvbkcM2QwKRyULEXALXOTmp7qcHJNyKe9Ay8=;
        b=Ijya9hokKGi1l76cYBmY1uRXPgDIIfKoZVmNsRFkMjxzxZjHQi5KuvD/EE10Bvckbw
         2ClRqu83Zn62p+NiaSuM+ONO3DDJLBjyFoDJztAyojJpZDkpyVHkZ8AwllSoSqfTAQTl
         YFgZbVzgSEPa94GIeb/S/T1WRTzWAJDjfqgL+geQEH1gwKr2ZMD4yBKex8ZsZSHVbTPv
         1HRazlJ0Z0zJ+vJWryqMJBCgkWayDTh+IGfrcsl0bTOXcPg6rNtY1AAW9jZSO9QF9+uf
         O/zq0ML9/trP5so6NVSEIs/3kW0AZffkhp+vap3/isFjKX3P/ys+3leVGnZ0vNtozFm3
         SC9A==
X-Forwarded-Encrypted: i=1; AJvYcCXgjBAUeGZ9ntdjJduLm6skVCShL95s8gpTU1jp8OMVPfKb9iQm3zNtNoB/ua6nAFSA9TFEsme2gvw7GDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGmS9QKOrd3cqrXiSWgiHosp2jQNljtXvZJoNtRgaCa2BOu/qh
	BrSYIGoH6/JKC4rmJT2o4mCwBvgXBtGEv3WnjQJCl34fBl5ugYaxEff0in/LPrkDBm8LV+twfNz
	yQv8eCSDNuA==
X-Google-Smtp-Source: AGHT+IGyVyZpa+TsJ31qkvSyn/bfX+ssskli1JTbTQJdQOR6kUCT2UtSkRRnK/WsF8nvoUuZaQhOwxbAcvJh
X-Received: from pfblo12.prod.google.com ([2002:a05:6a00:3d0c:b0:77e:40c7:d12e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e1b:b0:76e:99fc:dde7
 with SMTP id d2e1a72fcca58-77e4eaa9a5amr1230546b3a.22.1758234127950; Thu, 18
 Sep 2025 15:22:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:22:00 -0700
In-Reply-To: <20250918222202.1353854-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918222202.1353854-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918222202.1353854-2-irogers@google.com>
Subject: [PATCH v2 1/3] perf test: Don't leak workload gopipe in PERF_RECORD_*
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test starts a workload and then opens events. If the events fail
to open, for example because of perf_event_paranoid, the gopipe of the
workload is leaked and the file descriptor leak check fails when the
test exits. To avoid this cancel the workload when opening the events
fails.

Before:
```
$ perf test -vv 7
  7: PERF_RECORD_* events & perf_sample fields:
--- start ---
test child forked, pid 1189568
Using CPUID GenuineIntel-6-B7-1
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0xa00000000 (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
  disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -13
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0xa00000000 (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
  disabled                         1
  exclude_kernel                   1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0x400000000 (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
  disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -13
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0x400000000 (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
  disabled                         1
  exclude_kernel                   1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
Attempt to add: software/cpu-clock/
..after resolving event: software/config=0/
cpu-clock -> software/cpu-clock/
------------------------------------------------------------
perf_event_attr:
  type                             1 (PERF_TYPE_SOFTWARE)
  size                             136
  config                           0x9 (PERF_COUNT_SW_DUMMY)
  sample_type                      IP|TID|TIME|CPU
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  enable_on_exec                   1
  task                             1
  sample_id_all                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
  { wakeup_events, wakeup_watermark } 1
------------------------------------------------------------
sys_perf_event_open: pid 1189569  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -13
perf_evlist__open: Permission denied
---- end(-2) ----
Leak of file descriptor 6 that opened: 'pipe:[14200347]'

---- unexpected signal (6) ----
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
    #0 0x565358f6666e in child_test_sig_handler builtin-test.c:311
    #1 0x7f29ce849df0 in __restore_rt libc_sigaction.c:0
    #2 0x7f29ce89e95c in __pthread_kill_implementation pthread_kill.c:44
    #3 0x7f29ce849cc2 in raise raise.c:27
    #4 0x7f29ce8324ac in abort abort.c:81
    #5 0x565358f662d4 in check_leaks builtin-test.c:226
    #6 0x565358f6682e in run_test_child builtin-test.c:344
    #7 0x565358ef7121 in start_command run-command.c:128
    #8 0x565358f67273 in start_test builtin-test.c:545
    #9 0x565358f6771d in __cmd_test builtin-test.c:647
    #10 0x565358f682bd in cmd_test builtin-test.c:849
    #11 0x565358ee5ded in run_builtin perf.c:349
    #12 0x565358ee6085 in handle_internal_command perf.c:401
    #13 0x565358ee61de in run_argv perf.c:448
    #14 0x565358ee6527 in main perf.c:555
    #15 0x7f29ce833ca8 in __libc_start_call_main libc_start_call_main.h:74
    #16 0x7f29ce833d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
    #17 0x565358e391c1 in _start perf[851c1]
  7: PERF_RECORD_* events & perf_sample fields                       : FAILED!
```

After:
```
$ perf test 7
  7: PERF_RECORD_* events & perf_sample fields                       : Skip (permissions)
```

Fixes: 16d00fee7038 ("perf tests: Move test__PERF_RECORD into separate object")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/perf-record.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index d895df037707..efbd9cd60c63 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -130,6 +130,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("sched__get_first_possible_cpu: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -141,6 +142,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, cpu_mask) < 0) {
 		pr_debug("sched_setaffinity: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -152,6 +154,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -164,6 +167,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
-- 
2.51.0.470.ga7dc726c21-goog


