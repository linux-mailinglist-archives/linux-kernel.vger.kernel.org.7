Return-Path: <linux-kernel+bounces-625393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF13AA10E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 17:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457E74A62A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7BB23E330;
	Tue, 29 Apr 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZD5MG7xe"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991DA21ADC4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941659; cv=none; b=nnZPkTGqFQm6/cyb1RVaT4BTV5DJhXMhjmrkv3i646uc0avwhqXaIRUjMr5/OR70Wkf65Xg0V5zzNvg4IxoasxwGWOBeOkj6Vgfwj+CJkYUCeL4BX+Xyp9UQvtnHEBUeU/QcAaqYT7LcbwHgqnXpAL+RohNL3L3ZY3QNHBlypfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941659; c=relaxed/simple;
	bh=FbcSnOoCa0wvh7pCaEnEphnJHhhSEautrrFIMqym6Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eryUlS50l16RcGYECdUfjVz0V7jcacWds+KZ5Bd0Rt/YrresQOSUq48YtUktbNGfdlFquUX6k4vfVRMp46NE+lZj1JWHtLMGit1PjzO6SwV2d4NjfriHjJVIlCXTdYm0S6F51jwYW1GbQOmDd860y1nz/R0Gliz0HOzcLOVI5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZD5MG7xe; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d44cb27ef4so16715ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745941656; x=1746546456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xbf6yXNNkTSMsRnalVCuWOHXU+tlgRiNUj0W+IJp9k=;
        b=ZD5MG7xeCls/aQngQ7Irf5FAJMoQ0TtYEX9L8gtg5HA9aQeLg4bgL93MSbwQPAB4d1
         n1CStBTeJpvPorL1HEwn7g6qNNNXuUlb/y0hm8OxWjKvoK0SQjywNZshJSYLfD5KgLKN
         k4UX3VMpqjtF9NK5J3+sQYVL96QbDvrVTQf/wI0uuaqrN2idjuEm9z68Q7pGhaIpDiET
         u1Azu/3e/lk5uM4vWHALSFej3yDYj9kKy0SdtwsIRlbGRFHZUm4hs1VdumqSVNgeofGO
         xPRtzvYNd6zZv1Qd47hfhv5gtn5sP+UnvoELYYtFTB0KuIGYYWYoeN6Zd9+tAm3rb641
         Zx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941656; x=1746546456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xbf6yXNNkTSMsRnalVCuWOHXU+tlgRiNUj0W+IJp9k=;
        b=VxGEBYMqXS6GFH5L43zCz97h2mU2Fnp2vEZYTFVwh2eSIHWoNFiqUJH3ZJ+MKcVm9G
         GuqpPzU6fYMezl6cepZ5bVX03b3lPzCnc0CpHlQUsBmDV6iG+7+XpsvWMw4eARIF4AUP
         NInpw/FKjB3yj7SLKyG/Lf5EDk8WRDEXvW37n/ZSrIzkahz4CJgdYjar3yzbx4JN5Mtz
         EAlMB3Ulv9aw54jjd9i1yE/0oI6wfgfUdRLoc6aqLznAcoSsgIB1bAVgyONOD2FyWryn
         450juGpEsOaCkSCUYaTDUdw7SMiNYmWLE+VOgIOHbLglJehO+PCGMMh3rBWSGbqYq2y5
         vaPw==
X-Forwarded-Encrypted: i=1; AJvYcCVrTZ4wvqFdEqnFJUy9ndjgNMFOllr3K2M+tsUf7rlBofmNoZC+/ZN4lTcSK06ctYEbsrSuRxTpqSjhrKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcYyaj1//y55MmeNR+jAQaYo9J14EtHRKMMk9r/jtqK1zsV82
	5EVqtN2/2JFXGByqqUnQeXjSVPPYKJUFDPymW/xKvt/7WJDHosw599UDHFXgc+mv3xfce2XVgrh
	boW2qEO0TdTCQrNrn7TOwE979lV6nKmACfcCg
X-Gm-Gg: ASbGncu/mKRFnH8KzxSfw0XdTFlnly/KyrNSqQSee433DEcN5XfTrd21I1AzB3VbYha
	5RFLvZ6y2x6Vbh8HVZQAirdee509PZsRJci+45lX3JA48ZnznUXa91RHTqXbUi1Zc4d66aeqUTS
	H2hdbhyQgrRTPyNBNr4Fjk5/jP8+1ulHjzIQrclwZQ/KBJBqMwYvo=
X-Google-Smtp-Source: AGHT+IEFQaxkKs0T9ppoZLafefhCpeTNBISMKftoGitq7N47y9f/m2EDeEl/MMXvk4v8fYJ2QPsDkDZ6/NIwYlUb+MA=
X-Received: by 2002:a05:6e02:b44:b0:3d4:6f05:dfde with SMTP id
 e9e14a558f8ab-3d95d91724bmr4034695ab.22.1745941656385; Tue, 29 Apr 2025
 08:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324164543.62574-1-irogers@google.com> <CAP-5=fWr8EUyro8ckxfMYWR3BhiXgzkjejTjmTb=8PR1p+wvWA@mail.gmail.com>
 <aBDsyY-iMT5CBg4i@x1>
In-Reply-To: <aBDsyY-iMT5CBg4i@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 29 Apr 2025 08:47:25 -0700
X-Gm-Features: ATxdqUH05BlKp34S2vRe27cZXACp3sdHgyg9MH4TKlrFnEGGklS56teFO5edamA
Message-ID: <CAP-5=fVSNyFtuPxRQCDbsn8QZ9ENTjq6kMNcbxBb-Tr4WqLVwQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Prefer sysfs/JSON events also when no PMU is provided
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:14=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Mar 27, 2025 at 12:13:45PM -0700, Ian Rogers wrote:
> > On Mon, Mar 24, 2025 at 9:46=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > At the RISC-V summit the topic of avoiding event data being in the
> > > RISC-V PMU kernel driver came up. There is a preference for sysfs/JSO=
N
> > > events being the priority when no PMU is provided so that legacy
> > > events maybe supported via json. Originally Mark Rutland also
> > > expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> > > M? processors, but James Clark more recently tested this and believes
> > > the driver issues there may not have existed or have been resolved. I=
n
> > > any case, it is inconsistent that with a PMU event names avoid legacy
> > > encodings, but when wildcarding PMUs (ie without a PMU with the event
> > > name) the legacy encodings have priority.
> > >
> > > The patch doing this work was reverted in a v6.10 release candidate
> > > as, even though the patch was posted for weeks and had been on
> > > linux-next for weeks without issue, Linus was in the habit of using
> > > explicit legacy events with unsupported precision options on his
> > > Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> > > where ARM decided to call the events bus_cycles and cycles, the latte=
r
> > > being also a legacy event name. ARM haven't renamed the cycles event
> > > to a more consistent cpu_cycles and avoided the problem. With these
> > > changes the problematic event will now be skipped, a large warning
> > > produced, and perf record will continue for the other PMU events. Thi=
s
> > > solution was proposed by Arnaldo.
> > >
> > > v6: Rebase of v5 (dropping already merged patches):
> > >     https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@goog=
le.com/
> > >     that unusually had an RFC posted for it:
> > >     https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
> > >     Note, this patch conflicts/contradicts:
> > >     https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@goo=
gle.com/
> > >     that I posted so that we could either consistently prioritize
> > >     sysfs/json (these patches) or legacy events (the other
> > >     patches). That lack of event printing and encoding inconsistency
> > >     is most prominent in the encoding of events like "instructions"
> > >     which on hybrid are reported as "cpu_core/instructions/" but
> > >     "instructions" before these patches gets a legacy encoding while
> > >     "cpu_core/instructions/" gets a sysfs/json encoding. These patche=
s
> > >     make "instructions" always get a sysfs/json encoding while the
> > >     alternate patches make it always get a legacy encoding.
> >
> > So another fun finding. Sysfs and json events are case insensitive:
> > ```
> > $ perf stat -e 'inst_retired.any,INST_RETIRED.ANY' true
> >
> > Performance counter stats for 'true':
> >
> >           129,134      cpu_atom/inst_retired.any:u/
> >     <not counted>      cpu_core/inst_retired.any:u/
> >                         (0.00%)
> >           129,134      cpu_atom/INST_RETIRED.ANY:u/
> >     <not counted>      cpu_core/INST_RETIRED.ANY:u/
> >                         (0.00%)
> >
> >       0.002193191 seconds time elapsed
> >
> >       0.002354000 seconds user
> >       0.000000000 seconds sys
> > ```
> > But legacy events match in lex code that is case sensitive. This means
> > (on x86) the event 'instructions' is currently legacy, but the event
> > 'INSTRUCTIONS' is a sysfs event. The event CYCLES is a parse error as
> > there is no sysfs/json version. Given legacy events don't follow the
> > case insensitivity norm this is more evidence we need to reduce their
> > priority by merging these patches.
>
> root@number:~# perf trace -e perf_event_open perf stat -C 1 -e INSTRUCTIO=
NS,instructions,cycles sleep 1
>      0.000 ( 0.025 ms): :620592/620592 perf_event_open(attr_uptr: { type:=
 4 (cpu), size: 136, config: 0xc0 (instructions), sample_type: IDENTIFIER, =
read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1=
 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CLOEXEC) =3D 3
>      0.030 ( 0.004 ms): :620592/620592 perf_event_open(attr_uptr: { type:=
 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x1 (PERF_COUNT_HW_INSTRUCTIONS=
), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNN=
ING, disabled: 1, inherit: 1 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CL=
OEXEC) =3D 8
>      0.035 ( 0.003 ms): :620592/620592 perf_event_open(attr_uptr: { type:=
 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), s=
ample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING,=
 disabled: 1, inherit: 1 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CLOEXE=
C) =3D 9
>
>  Performance counter stats for 'CPU(s) 1':
>
>          1,499,102      INSTRUCTIONS
>          1,498,883      instructions                     #    0.81  insn =
per cycle
>          1,850,082      cycles
>
>        1.001553577 seconds time elapsed
>
> root@number:~#
>
> So the behaviour if "instructions" is specified, since perf started, is
> to have this:
>
>      0.030 ( 0.004 ms): :620592/620592 perf_event_open(attr_uptr: { type:=
 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x1 (PERF_COUNT_HW_INSTRUCTIONS=
), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNN=
ING, disabled: 1, inherit: 1 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CL=
OEXEC) =3D 8
>
> And this is what we continue to obtain.
>
> At some point we started supporting sysfs/JSON and then INSTRUCTIONS
> started being accepted and we are getting:
>
>      0.000 ( 0.025 ms): :620592/620592 perf_event_open(attr_uptr: { type:=
 4 (cpu), size: 136, config: 0xc0 (instructions), sample_type: IDENTIFIER, =
read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1=
 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CLOEXEC) =3D 3
>
> Which is what is expected, no change in behaviour over time.

I'm not sure what the point of this comment is. With perf we use
strcasecmp to match events:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n473
```
static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
   const char *name,
   bool load)
{
struct perf_pmu_alias *alias;
...
list_for_each_entry(alias, &pmu->aliases, list) {
if (!strcasecmp(alias->name, name))
return alias;
...
```
We even lower case event names during the json parsing:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/jevents.py?h=3Dperf-tools-next#n326

We don't use case insensitive pattern matching when matching legacy events:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n392
```
...
cpu-cycles|cycles { return sym(yyscanner, PERF_TYPE_HARDWARE,
PERF_COUNT_HW_CPU_CYCLES); }
stalled-cycles-frontend|idle-cycles-frontend { return sym(yyscanner,
PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
stalled-cycles-backend|idle-cycles-backend { return sym(yyscanner,
PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
instructions { return sym(yyscanner, PERF_TYPE_HARDWARE,
PERF_COUNT_HW_INSTRUCTIONS); }
cache-references { return sym(yyscanner, PERF_TYPE_HARDWARE,
PERF_COUNT_HW_CACHE_REFERENCES); }
cache-misses { return sym(yyscanner, PERF_TYPE_HARDWARE,
PERF_COUNT_HW_CACHE_MISSES); }
branch-instructions|branches { return sym(yyscanner,
PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
branch-misses { return sym(yyscanner, PERF_TYPE_HARDWARE,
PERF_COUNT_HW_BRANCH_MISSES); }
bus-cycles { return sym(yyscanner, PERF_TYPE_HARDWARE,
PERF_COUNT_HW_BUS_CYCLES); }
ref-cycles { return sym(yyscanner, PERF_TYPE_HARDWARE,
PERF_COUNT_HW_REF_CPU_CYCLES); }
cpu-clock { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_CPU_CLOCK); }
task-clock { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_TASK_CLOCK); }
page-faults|faults { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_PAGE_FAULTS); }
minor-faults { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_PAGE_FAULTS_MIN); }
major-faults { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
context-switches|cs { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_CONTEXT_SWITCHES); }
cpu-migrations|migrations { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_CPU_MIGRATIONS); }
alignment-faults { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_ALIGNMENT_FAULTS); }
emulation-faults { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_EMULATION_FAULTS); }
dummy { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
bpf-output { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_BPF_OUTPUT); }
cgroup-switches { return sym(yyscanner, PERF_TYPE_SOFTWARE,
PERF_COUNT_SW_CGROUP_SWITCHES); }
...
```

This means the behavior of instructions,INSTRUCTIONS,cpu/instructions/
all vary when parsed. I am working to change the metric parsing so
that rather than matching strings it works off of the config values,
this fixes the problem that metrics cannot handle tracepoints without
the need to reinvent event parsing. As the config values vary for some
if not all of instructions,INSTRUCTIONS,cpu/instructions/ then it will
impact de-duplicating events. There's generally an expectation that
events are case insensitive and when that's not true it looks like a
bug to me.

Just to repeat for clarity. Legacy events were mapped to fixed
encodings and had priority. Intel/Arnaldo/Jiri changed that to make it
so that legacy encodings would wildcard match. I cleaned that up in
making metrics work, including with Intel hybrid CPUs, for the support
of topdown metrics and so the Intel hybrid approach was made generic
and not hard coded to Intel PMUs. My change broke Apple-M as they had
been reliant on not having their PMUs spotted as core legacy
supporting PMUs, with events programmed as if they were uncore PMUs.
Mark Rutland argued that sysfs/json should be made the priority and I
made it so, focussing first on the case where a PMU is specified as
that matched the bug. The later changes are just following through on
that priority change. RISC-V supports this change given the variable
nature of how they encode events.

Note, there is a newer version of this patch series:
https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
it addresses problems with tracking events and perf_api_probe using
wildcarding. The patches are applied in:
https://github.com/googleprodkernel/linux-perf/

Thanks,
Ian

> - Arnaldo

