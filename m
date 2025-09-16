Return-Path: <linux-kernel+bounces-819460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FD9B5A0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA388523888
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD002DE6F8;
	Tue, 16 Sep 2025 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OM7Q+LBG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B62D4806
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049755; cv=none; b=byMcfAA0cwOKIsj+/khs3IvcqPAjjNvRTKF6WMXTK3mu2V83fO8OQVqDmBhn3vUIpw49k4yG3xyUKkMAGyXb72qfHTZpJQMnfbAc3sT4+hyKcg7x0232IFfd+WUjHkn9GM3A8D2WuvHzQbGsF4USVcz+94Rlg3C2EX04Ap4ST5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049755; c=relaxed/simple;
	bh=gDgBd7oIJjnAGnml4JKrj9hUBgWH01BbWUxIqxPOfWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxjAnvkJS6DAGiFyjdeklBxkUyD7twyM07b9qW45zp/sqENpeJ1jVrJYrtw66I0Z8mNu42jlVgsUqvp5Rr5WBAHDaxd0+w9thSkn3CnnKCyP+4V4b6MsvA7rjPl5T/Uut3uFcSi8Xadif2x/8+3FgvwmEmxTx8H5arpJFxO8FbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OM7Q+LBG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2637b6e9149so39705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758049750; x=1758654550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5GWnHtcFt1BNkCReHFNnU/aXlqNcIwBUpU5vbc/YpE=;
        b=OM7Q+LBGGrN+Nu6xUeghKurkLNFtn2K6uEqy1Xx6jeQ/T8TFIEqX2/yks6TybPtjoY
         yc1Lhjg/lFvn3NuFD4tHNG8Np/wqXQzz+iQQD5wW+MA8izjo621TmrvPyHL7kb1ycX7E
         zRAh1KRSqoEWxsP/7+Li81z+ZNQKQP8v3q8jTgtOknWp3QTCQpQ34L0ymfO0u0UIU+WQ
         s+Nh+IUHvAfukFUNMI6XpxQTPYU4OkUlmrB8GMjvnNNF1pmOnfWFkqAV6ktHrDs+6fcB
         m0jnsT8ZrXnGeh5ua3TsVeqK/ChfaK6D2qEC+YRbltkNLMi2M4KhuQFx5BORXLL+7Y6J
         4Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758049750; x=1758654550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5GWnHtcFt1BNkCReHFNnU/aXlqNcIwBUpU5vbc/YpE=;
        b=O1m60HbgKetU5qCERndJwiecyf/X6woJY28lvErFriGAg6srMiwc8KdD4dGKLcuHnd
         ZbPvdkoNjb/EVo2Xf1mbYfxxqGXoK8O/ILFp2WbHsRlZASdoD0pX9Rv0+w/8+8RU3Sh8
         s3bOe5bYJYCkB5sVWvIk7W83Yt2z6oKwqXf+VwpF4+NnWsOi4pkWf52z88yXjPBZOZ9w
         K31L/QN1oQoyxdAZOmLu4yw+vKVJ8vJ8ayT1MPNxPuFbdLTiD9kQr+4icVm2HT9Bo4P0
         VP0Ywh153YEXaK50YcT4K5i0g9hb8bqh2l9yr6Oh4V64a47wbU1MrGhK+O+4ACKdudgq
         1yyA==
X-Forwarded-Encrypted: i=1; AJvYcCUpNSU70xadS2n6fSwuN07uMSFwgBX0+kOqsRaJCpBtvKt0Y1rNI3Pye8+Gl57WHsbHI4hSTOcipk65SHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgXUYU0aA8CAr+ptvvF8WfWCKp4W4sZthsFSOfaXG7fqkz1kp
	HoVfgTSNEHCy7CZ7G+ky4xIO95LMM6Eec06Vxqpbnly5yv+RgHylyIH224xNcxvXefg29H5y8pe
	jOb9yyx4SjXxEil6GBNnyJgJJ7x6Mu61gN9cbsbyY
X-Gm-Gg: ASbGncsfM/U63Y60t/1OWoffV19bXnrD5weZJhN4f2cSeYbJg7YfPC1rDzd2XPeqesI
	3b9KNtj9i/FIMlUGPbXpoh47iq4aaNLBzWXNG9TWKa6c5fQtP6HcVZd52He3g7tfyDFOBPfU6sr
	1jejjWXPR1/kNtwM384g2Ej6uonIOmoulA6vaiBbKHsmyk3YrCWzNc7uGmPH2PxE0Rpzx/VdgR/
	P9A1b3UBOSm6tOdsbFPmLO5UfODuxRbL+HLTbX2lQGs
X-Google-Smtp-Source: AGHT+IGq1HTtZu40xUa2NY7c7FiFRDtN7uU0OkSXjbMJZserLy3vpQE/fGL+wYuLNr3A7nBntoCA3Il4CzM721+30s8=
X-Received: by 2002:a17:902:da89:b0:240:6076:20cd with SMTP id
 d9443c01a7336-26801295907mr771895ad.15.1758049749441; Tue, 16 Sep 2025
 12:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821221834.1312002-1-irogers@google.com> <20250821221834.1312002-3-irogers@google.com>
 <aMm0qUcdeDJmwuyI@x1>
In-Reply-To: <aMm0qUcdeDJmwuyI@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Sep 2025 12:08:58 -0700
X-Gm-Features: AS18NWAkSTFha9L4A5hQRM2mmJRNQINB2wG_5T6T7jo8wX-J1HZctrKwLmV-8WQ
Message-ID: <CAP-5=fU8NXY+mbnkmhq15yncXx0TxE7Zc1zu23o+d+3ZyXjSjA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf test: Don't leak workload gopipe in PERF_RECORD_*
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:04=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 21, 2025 at 03:18:32PM -0700, Ian Rogers wrote:
> > The test starts a workload and then opens events. If the events fail
> > to open, for example because of perf_event_paranoid, the gopipe of the
> > workload is leaked and the file descriptor leak check fails when the
> > test exits. To avoid this cancel the workload when opening the events
> > fails.
> >
> > Before:
> > ```
> > $ perf test -vv 7
> >   7: PERF_RECORD_* events & perf_sample fields:
> > --- start ---
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ patch -p1 < b
> patching file tools/perf/tests/perf-record.c
> Hunk #1 succeeded at 130 (offset 15 lines).
> Hunk #2 succeeded at 142 with fuzz 1 (offset 15 lines).
> Hunk #3 succeeded at 154 (offset 15 lines).
> Hunk #4 succeeded at 167 (offset 15 lines).
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git log --oneline -5 tools/perf/=
tests/perf-record.c
> 576bd7a8c90c48e9 (x1/perf-tools-next, x1/HEAD, five/perf-tools-next, five=
/HEAD) perf tests record: Update testcase to fix usage of affinity for mach=
ines with #CPUs > 1K
> b4c658d4d63d6149 perf target: Remove uid from target
> dc6d2bc2d893a878 perf sample: Make user_regs and intr_regs optional
> fd8d5a3b076c033f perf tests: Add missing event.h include
> 9823147da6c893d9 perf tools: Move 'struct perf_sample' to a separate head=
er file to disentangle headers
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> Can you please check that it is still ok?
>
> I processed the first in the series and now I'm going thru the other
> two.

Thanks Arnaldo! I'm not seeing the patch on:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/log/?h=3Dtmp.perf-tools-next
I'm happy to check.

Ian

> - Arnaldo
>
> > test child forked, pid 1189568
> > Using CPUID GenuineIntel-6-B7-1
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   config                           0xa00000000 (cpu_atom/PERF_COUNT_HW_=
CPU_CYCLES/)
> >   disabled                         1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -13
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   config                           0xa00000000 (cpu_atom/PERF_COUNT_HW_=
CPU_CYCLES/)
> >   disabled                         1
> >   exclude_kernel                   1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   config                           0x400000000 (cpu_core/PERF_COUNT_HW_=
CPU_CYCLES/)
> >   disabled                         1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -13
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   config                           0x400000000 (cpu_core/PERF_COUNT_HW_=
CPU_CYCLES/)
> >   disabled                         1
> >   exclude_kernel                   1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
> > Attempt to add: software/cpu-clock/
> > ..after resolving event: software/config=3D0/
> > cpu-clock -> software/cpu-clock/
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             1 (PERF_TYPE_SOFTWARE)
> >   size                             136
> >   config                           0x9 (PERF_COUNT_SW_DUMMY)
> >   sample_type                      IP|TID|TIME|CPU
> >   read_format                      ID|LOST
> >   disabled                         1
> >   inherit                          1
> >   mmap                             1
> >   comm                             1
> >   enable_on_exec                   1
> >   task                             1
> >   sample_id_all                    1
> >   mmap2                            1
> >   comm_exec                        1
> >   ksymbol                          1
> >   bpf_event                        1
> >   { wakeup_events, wakeup_watermark } 1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 1189569  cpu 0  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -13
> > perf_evlist__open: Permission denied
> > ---- end(-2) ----
> > Leak of file descriptor 6 that opened: 'pipe:[14200347]'
> >
> > ---- unexpected signal (6) ----
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> > Failed to read build ID for //anon
> >     #0 0x565358f6666e in child_test_sig_handler builtin-test.c:311
> >     #1 0x7f29ce849df0 in __restore_rt libc_sigaction.c:0
> >     #2 0x7f29ce89e95c in __pthread_kill_implementation pthread_kill.c:4=
4
> >     #3 0x7f29ce849cc2 in raise raise.c:27
> >     #4 0x7f29ce8324ac in abort abort.c:81
> >     #5 0x565358f662d4 in check_leaks builtin-test.c:226
> >     #6 0x565358f6682e in run_test_child builtin-test.c:344
> >     #7 0x565358ef7121 in start_command run-command.c:128
> >     #8 0x565358f67273 in start_test builtin-test.c:545
> >     #9 0x565358f6771d in __cmd_test builtin-test.c:647
> >     #10 0x565358f682bd in cmd_test builtin-test.c:849
> >     #11 0x565358ee5ded in run_builtin perf.c:349
> >     #12 0x565358ee6085 in handle_internal_command perf.c:401
> >     #13 0x565358ee61de in run_argv perf.c:448
> >     #14 0x565358ee6527 in main perf.c:555
> >     #15 0x7f29ce833ca8 in __libc_start_call_main libc_start_call_main.h=
:74
> >     #16 0x7f29ce833d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:12=
8
> >     #17 0x565358e391c1 in _start perf[851c1]
> >   7: PERF_RECORD_* events & perf_sample fields                       : =
FAILED!
> > ```
> >
> > After:
> > ```
> > $ perf test 7
> >   7: PERF_RECORD_* events & perf_sample fields                       : =
Skip (permissions)
> > ```
> >
> > Fixes: 16d00fee7038 ("perf tests: Move test__PERF_RECORD into separate =
object")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/perf-record.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-rec=
ord.c
> > index 0b3c37e66871..8c79b5166a05 100644
> > --- a/tools/perf/tests/perf-record.c
> > +++ b/tools/perf/tests/perf-record.c
> > @@ -115,6 +115,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >       if (err < 0) {
> >               pr_debug("sched__get_first_possible_cpu: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > +             evlist__cancel_workload(evlist);
> >               goto out_delete_evlist;
> >       }
> >
> > @@ -126,6 +127,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >       if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, &cpu_m=
ask) < 0) {
> >               pr_debug("sched_setaffinity: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > +             evlist__cancel_workload(evlist);
> >               goto out_delete_evlist;
> >       }
> >
> > @@ -137,6 +139,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >       if (err < 0) {
> >               pr_debug("perf_evlist__open: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > +             evlist__cancel_workload(evlist);
> >               goto out_delete_evlist;
> >       }
> >
> > @@ -149,6 +152,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >       if (err < 0) {
> >               pr_debug("evlist__mmap: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > +             evlist__cancel_workload(evlist);
> >               goto out_delete_evlist;
> >       }
> >
> > --
> > 2.51.0.rc2.233.g662b1ed5c5-goog

