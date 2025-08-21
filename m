Return-Path: <linux-kernel+bounces-780756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868EB308FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237B81D05217
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE212EB5A9;
	Thu, 21 Aug 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUelvo9K"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA52E040E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814726; cv=none; b=BidQkkTlcl9qckOoPgzDbgDXgCXhoZG3LP8MWyEE/wg1NHXqyY02dLIgwZuKVZviiyYb3iS/vn7b4xC98sjfv1oHnZXYYHtgvjJaOZMXZt+cGukQjZJhwoPBk6lCODSGR4OOlX478fL3L1DY26bQGq5UU+cIexZK+zdSLYlvKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814726; c=relaxed/simple;
	bh=pC3oTqGmEsbEt4OxH9Elyo+yIbWIxVyDUKn5/mFJws8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tkG24StkSxh7CCM99Kn9oTBfBGqCfeHpM8oiKd7p90kCSaO2sGWdYgGR1e7/7dlioHBXCyWa1Fzg0c1OXaw3V0NZ4xOWBz19IADPIsXiHdRe5kQAWhIRBlOR2WDnN6hNF0IGJq4NoLJcdBfSEyVvIltSJrZLudMBqZRh3B2FcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUelvo9K; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24456ebed7bso17801085ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755814724; x=1756419524; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMK8YRDl6tbueEXroDXpvtDeHvmmbYj4KZWTDPAsswM=;
        b=gUelvo9Kk1LyRp0PFPIR0Fg1J91aJhxaQ5Mfnv98Y73X3jcM4NiXvqZaH1hpU8mFm2
         ZvsBxvT4bQll2QRMKqdknJoKyekbCSK12NegrKvklqd8jtEIR/9m1oxU0ts73L3bV/Ue
         fJ4QllLh99vx3y0w3clbsLyKMTR1EfCEb4Wg8pLhD0g3PJETE6nOmnMq7NgpFTKz3t6G
         fGtJ0vDTb40S0C5jOcTpbeq56SbkEbfY47opXwfKjRFJL1qRf+q1HzwbP3O8x95iK08U
         QF+8XZa4hcTZA2ahTbRfSkqwmQPCd5AVPFSCCh9KbW2MvMRPqCXDNwP7PKymthFLOT/q
         lerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814724; x=1756419524;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMK8YRDl6tbueEXroDXpvtDeHvmmbYj4KZWTDPAsswM=;
        b=Ez0phZS0Q/5E8iujP0Ya1cWur/7xDyXs2oCXskZFmR3smd64SI3+k0KX0ymO30HUhG
         bW5XQu1VBE/SJP2McFG7scMq92LYtkmK6qEZB168Xxg200NaSS9Qm0SiqoI0SmlovQWF
         TShGi6RPVvpzr09JSmii5YJ4PUhO3M6FFPwabDPmkoMIPzKZbolKntid74hH4xsAzlIQ
         DsS/WX6zRsRhz3FTCCAXlqzMNXZH5fRqAtTfuX3kYgBRz+Ic37z/wju/FMUf7j+8m59A
         hXjnys8fXksdAnwHs3oVeQPVOaASf6EW9OTIoP7EDLA2J8zwjTwE1xCyBSnRxpiLzmEw
         8Y1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqt1xQx+VajkiH5t5XKXbWppp72k15QX1aYN9ylk8c4KfkFhmoj6kG2z01QPss2Oz9j4ez0MaRgZ8aGS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97z2S+L62KIHOniZPlmVmucKqSjIBbsn9Vp5F5GTNfKRZHJ1H
	tdPV6G+2ylxQqJu7FGyNwlFLBJ8b8+NpWgDh4ff4Xh6PjMEZQjz/U9f7a21JvohKGL0IU+HiGXh
	BwlsrLmhYdw==
X-Google-Smtp-Source: AGHT+IF5v5/MSMYnzH2Y2uzTNLw3UFS8LArgiun1kOHl2+wczk+rayPaWjc7DoSce7GpVnO+D03KscvOqBa1
X-Received: from plbkz8.prod.google.com ([2002:a17:902:f9c8:b0:242:fd00:6a87])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f44:b0:246:2cb3:5768
 with SMTP id d9443c01a7336-2463406731emr9150605ad.30.1755814724357; Thu, 21
 Aug 2025 15:18:44 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:18:32 -0700
In-Reply-To: <20250821221834.1312002-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821221834.1312002-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821221834.1312002-3-irogers@google.com>
Subject: [PATCH v1 2/4] perf test: Don't leak workload gopipe in PERF_RECORD_*
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
index 0b3c37e66871..8c79b5166a05 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -115,6 +115,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("sched__get_first_possible_cpu: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -126,6 +127,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, &cpu_mask) < 0) {
 		pr_debug("sched_setaffinity: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -137,6 +139,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -149,6 +152,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


