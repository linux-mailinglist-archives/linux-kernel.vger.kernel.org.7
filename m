Return-Path: <linux-kernel+bounces-644834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE38AB4516
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0087B863684
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800A29898D;
	Mon, 12 May 2025 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+1r64b+"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6429826C
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747078718; cv=none; b=RPQ0IsdvISck6VtOgB6JISiL9iZHS7TlL8aHi4vhGzSDyEsLH1V+BA8DY9mmcuAOAOkptOfe5qM8FwEZHGHPgcTcYpSlbpLoo5Sqb/4n2GRUZGApz/fzFI9bjiIxOlKV4MTpAj51GjJ3KjBI7bFB5kZI4hCTOSDAkmzDxHnkQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747078718; c=relaxed/simple;
	bh=XqEGdfsUGkO19mTxKg2E3payd8kgE0M8puWXFDBpZR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7vaYbbBx2Up7jFy2h7IlKjBD61Sf5ELAnEZldr20/43kas/0G7WVYKxy+AfagqJdS8X7hUNNB2vGlgXf3iKAzcCXa9aTAZKl8wf2E6WvTh5S4dtux2Y5AqqK2gSUdCZ0aLUW+n+jmBAULKlQmCU+B7lvzlA0PmpsUntUg3ur/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+1r64b+; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da73d35c11so3295ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747078715; x=1747683515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZgqvnAFQAowltKv4MUMv8LmXy9URPFUmzmA7urdx5o=;
        b=c+1r64b+IiTvKDNiDa5WP6E0NiJV7k3kNa5QVj7sa9/RWhpJKbVJ3qgZ4fe+jItoyy
         ylbWBnlT9bCbp3iZCq0ZNCNjVU9vfxhVOEooAT7SWQ2b6HDEQ2/tjCMnLS+Pi/oeEHaG
         oKSNV9+3WBlxA2O8k8QPUPSP6QluuuD05gFmhwDQi+q3k4RnQwBoG/UJYlKYp5fM3/3l
         RidyFCf9JATBfA4VzRMq4ZGTekYtYhd7KW84Gh91E1FvJMrDAnNn76W3MoA5w2CE260h
         Y2fvyVOFJJlpbuOQs/u68OHHFNubVe4KaS2kjXg2/ZPg/fGChMEWtnJvVrWqu8tqqhCY
         gleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747078715; x=1747683515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZgqvnAFQAowltKv4MUMv8LmXy9URPFUmzmA7urdx5o=;
        b=V07e+uy0/TAseecJwQ510TunuGST/FsOjCfiVtKQkKRml1gJtrRxskl6DDc/jchlW0
         m7SmD7YNs9Yb0YH6XK5P2CoGwdIEfgZtbsbkmDMhzM+YbFGALV9TJasWuZ2vOBmfs2FH
         x7IurMZDFJszNzWfGflN9qIEoR3nPJsdfdjNYxn5k+u6VJrqEdPyqEvwBqUDYMvhfSj2
         ehhTkao19/GCpvqh2hWB32Jhr7iSYloNIx+NtncVaeJmsMgqTJBjemGU4cGfOZ1ZJlLY
         3B3wXolrwixAA0iDTRKdXMzUQDorm0cGq4EPrqnh8HrU9T4mfbt4tENj5IdYjdbBzNxx
         21fA==
X-Forwarded-Encrypted: i=1; AJvYcCUez/8RDeFuSMY+3U0P/OWzf8DypOEabPrlTkDgUnL4EN0yYE6/t+jR05YrtTlLgnNt9a7xlBjR1qnDK10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hh2/3My0KYqVTz9ZZfHqvN7KMTTi8xCf+7kUdIOPFJTuaUwm
	/uAO1jzeCbcNyO+ZFVA2moD+0TIOVFV5TdBTsI8XK5uXuUWF8WjCcoAlluV6epnTABbQwenE2K3
	igqTSyIaeGNVDfqIdF+yTMGJkbeB/JPOhtMTIjgWj
X-Gm-Gg: ASbGnctMJhWlEJzakoJtbyrH47elDwH9CBAWtuf/DeTV+zU8Sy6F5R5nBD6Bk9MPrI7
	GAcikOXDsI3YFwroQF2zqSoelCwOe0I+mSEFkvG4P/+8a0beSdsUzRK4Qd8ezAArX+SCVp5ipJB
	pVdmjmNQQO4/EW+qYVjkG81v9ISJLVvKCEIkBq5geA5ndHOSaF5YzN5Ges4zBcYggmjCFk0P3B
X-Google-Smtp-Source: AGHT+IFrKDVWmTu4QBNU3Dr+1Blr0vP06f5LkC9U0WmWSt+1gL6Ehj6McIF3PQQCfNjxXcfiDjTSfhOcA7cYcwDOoAw=
X-Received: by 2002:a05:6e02:1707:b0:3d9:64e3:60d with SMTP id
 e9e14a558f8ab-3db66928053mr507155ab.20.1747078714735; Mon, 12 May 2025
 12:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512055748.479786-1-gautam@linux.ibm.com> <20250512055748.479786-5-gautam@linux.ibm.com>
 <CAP-5=fWb-=hCYmpg7U5N9C94EucQGTOS7YwR2-fo4ptOexzxyg@mail.gmail.com> <aCI0oDBSz86S9fz-@x1>
In-Reply-To: <aCI0oDBSz86S9fz-@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 May 2025 12:38:23 -0700
X-Gm-Features: AX0GCFtzM5CEYYKnrd7gMGrMVs73MKrzoUVJrZgnpDoBSkWMk-0hEDLTIn3Kn2I
Message-ID: <CAP-5=fVYXRzQjRzcDX0aJv5yg3bwDO+PWHfP-Laig0s3cnzcaQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf python: Add counting.py as example for
 counting perf events
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Gautam Menghani <gautam@linux.ibm.com>, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:49=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 12, 2025 at 10:23:39AM -0700, Ian Rogers wrote:
> > On Sun, May 11, 2025 at 10:58=E2=80=AFPM Gautam Menghani <gautam@linux.=
ibm.com> wrote:
> > > Add counting.py - a python version of counting.c to demonstrate
> > > measuring and reading of counts for given perf events.
>
> > > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > > ---
> > > v1 -> v2:
> > > 1. Use existing iteration support instead of next
> > > 2. Read the counters on all cpus
> > > 3. Use existing helper functions
> > >
> > >  tools/perf/python/counting.py | 34 +++++++++++++++++++++++++++++++++=
+
> > >  1 file changed, 34 insertions(+)
> > >  create mode 100755 tools/perf/python/counting.py
>
> > > diff --git a/tools/perf/python/counting.py b/tools/perf/python/counti=
ng.py
> > > new file mode 100755
> > > index 000000000000..e535e3ae8bdf
> > > --- /dev/null
> > > +++ b/tools/perf/python/counting.py
> > > @@ -0,0 +1,34 @@
> > > +#!/usr/bin/env python3
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# -*- python -*-
> > > +# -*- coding: utf-8 -*-
> > > +
> > > +import perf
> > > +
> > > +def main():
> > > +        cpus =3D perf.cpu_map()
> > > +        thread_map =3D perf.thread_map(-1)
> > > +        evlist =3D perf.parse_events("cpu-clock,task-clock", cpus, t=
hread_map)
>
> > Thanks Gautam! I think this is really good. Perhaps the events could
> > be a command line option, but I can see why you want to keep this
> > similar to counting.c.
>
> > > +
> > > +        for ev in evlist:
> > > +            ev.read_format =3D perf.FORMAT_TOTAL_TIME_ENABLED | perf=
.FORMAT_TOTAL_TIME_RUNNING
> > > +
> > > +        evlist.open()
> > > +        evlist.enable()
> > > +
> > > +        count =3D 100000
> > > +        while count > 0:
> > > +            count -=3D 1
> > > +
> > > +        evlist.disable()
> > > +
> > > +        for evsel in evlist:
> > > +            for cpu in cpus:
> > > +                for thread in range(len(thread_map)):
>
> > I kind of wish, for the reason of being intention revealing, this could=
 just be:
>
> > for thread in thread_map:
>
> > I can see the problem though, the counts lack the thread_map and the
> > thread_map is needed to turn a thread back into an index. Perhaps when
> > the python counts is created we hold onto the evsel so that this is
> > possible. I also suspect that in the code:
>
> > for cpu in cpus:
>
> > The CPU number is being used rather than its index, which is a similar
> > story/problem.
>
> Lemme see the rest of this code...
>
> +static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
> +                                 PyObject *args, PyObject *kwargs)
> +{
> +       struct evsel *evsel =3D &pevsel->evsel;
> +       int cpu_map_idx =3D 0, thread =3D 0;
> +       struct perf_counts_values counts;
> +       struct pyrf_counts_values *count_values =3D PyObject_New(struct p=
yrf_counts_values,
> +                                                              &pyrf_coun=
ts_values__type);
> +
> +       if (!PyArg_ParseTuple(args, "ii", &cpu_map_idx, &thread))
> +               return NULL;
> +
> +       perf_evsel__read(&(evsel->core), cpu_map_idx, thread, &counts);
> +       count_values->values =3D counts;
> +       return (PyObject *)count_values;
> +}
>
> Yeah, it is expecting the cpu_map_idx but the cpu number is being used,
> that is a bug.
>
> The way perf_evsel__read() is implemented:
>
> int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int threa=
d,
>                      struct perf_counts_values *count)
>
> It expects a cpu_map index, not a cpu and then a thread that in its
> prototype seems to imply its not an index? But it is an index as it ends
> up being the 'y' for:
>
>   xyarray__entry(_evsel->mmap, _cpu_map_idx, _thread))
>
> :-/

Yeah. In the C code we've pretty much committed to notions of cpu map
index and CPU. We're more ambiguous with threads, but generally thread
is actually thread index into the thread map. As you say it is for the
xyarray so that we can densely pack things by index rather than having
huge gaps, say between PIDs. For the python we don't have to have a
1:1 mapping with the C code, so I was wondering if we could just
remove the notions of index and have them be implementation details?
This would lead to an unfortunate O(log n) translation between
thread/CPU and index (perf_cpu_map__idx) at the API boundary in
python.c.

> So probably its best to do it using indexes and when needing to know the
> pid or cpu number then use some helper to get the entry at the given
> entry? At least for the perf_evsel__read() API that seems to be the
> case, right?
>
> > Arnaldo, could you give some input on what to do wrt indices, threads
> > and CPUs at the API level? Perhaps we need a refactor and objects for
> > perf CPU and perf thread, similar to the use of struct perf_cpu in the
> > C code. The original API all pre-dates that change. The issue is that
> > changing the API could break existing scripts and we can only fix
> > those that ship with perf.
>
> So the original user of the perf python binding was:
>
> https://git.kernel.org/pub/scm/utils/tuna/tuna.git/tree/tuna/gui/procview=
.py
>
> That does basically what the above example does:
>
>     def perf_init(self):
>         self.cpu_map =3D perf.cpu_map()
>         self.thread_map =3D perf.thread_map()
>         self.evsel_cycles =3D perf.evsel(task=3D1, comm=3D1, wakeup_event=
s=3D1, \
>             watermark=3D1, sample_type=3Dperf.SAMPLE_CPU | perf.SAMPLE_TI=
D)
>         self.evsel_cycles.open(cpus=3Dself.cpu_map, threads=3Dself.thread=
_map)
>         self.evlist =3D perf.evlist(self.cpu_map, self.thread_map)
>         self.evlist.add(self.evsel_cycles)
>         self.evlist.mmap()
>         self.pollfd =3D self.evlist.get_pollfd()
>         for f in self.pollfd:
>             GObject.io_add_watch(f, GObject.IO_IN, self.perf_process_even=
ts)
>         self.perf_counter =3D {}
>
> Then:
>
>     def perf_process_events(self, source, condition):
>         had_events =3D True
>         while had_events:
>             had_events =3D False
>             for cpu in self.cpu_map:
>                 event =3D self.evlist.read_on_cpu(cpu)
>                 if event:
>                     had_events =3D True
>                     if event.type =3D=3D perf.RECORD_FORK:
>                         if event.pid =3D=3D event.tid:
>                             try:
>                                 self.ps.processes[event.pid] =3D procfs.p=
rocess(event.pid)
>                             except: # short lived thread
>                                 pass
>                         else:
>                             if event.pid in self.ps.processes:
>                                 try:
>                                     self.ps.processes[event.pid].threads.=
processes[event.tid] =3D procfs.process(event.tid)
>                                 except (AttributeError, KeyError):
>                                     try:
>                                         self.ps.processes[event.pid].thre=
ads =3D procfs.pidstats("/proc/%d/task/" % event.pid)
>                                     except:
>                                         pass
>                     elif event.type =3D=3D perf.RECORD_EXIT:
>                         del self.ps[int(event.tid)]
>                     elif event.type =3D=3D perf.RECORD_SAMPLE:
>                         tid =3D event.sample_tid
>                         if tid in self.perf_counter:
>                             self.perf_counter[tid] +=3D event.sample_peri=
od
>                         else:
>                             self.perf_counter[tid] =3D event.sample_perio=
d
>
>         self.evlist_added =3D True  # Mark that event arrived, so next pe=
riodic show() will refresh GUI
>         return True
>
>
> So it was more for catching new/dead threads without having to process /p=
roc.

Yeah. I think the sampling API is okay. The nice thing with Gautum's
patches is adding support for counters for use-cases like perf stat.

Thanks,
Ian

