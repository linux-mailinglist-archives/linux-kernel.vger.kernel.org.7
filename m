Return-Path: <linux-kernel+bounces-821151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C7B808F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 294C14E32A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82BF30C0F0;
	Wed, 17 Sep 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SK2Q3UgN"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3930C0E8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122979; cv=none; b=TbNI2eMvYPQtLYn/8s4wnQBYmjr8MemHxu3+ebTnLzkUrKkNmSnOyHOn5aBhR//NePHA62Um1cjYFSGFiAof2e9faJ+MTYWB6LJJ6mo9GyZlx/z39HdCTn2rblKqzilc/xrZ0oAbzGAoeszapjgupL68J5Ja8HtLEcds9v8Nyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122979; c=relaxed/simple;
	bh=GDwHPJq0q38T0Jr6OSSSYfjFVzwUOx5bOImepeuOTyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY28ODHhQD3Xk2Dn4o/i9PF2fpIBM5hAHcaWcDNOgWLblDKi1YEa9mFeixwuNsDf/i8DmsMvs3dYtve8nEgj2F+X4XMNAUlE6mFzcl5jaA3n0wx3Xa9kqwKwUZMH/U24HTyeSHLoTxjVxSW9Fs2hdcKzjpHCqx1Llk/xPAUgXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SK2Q3UgN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-265f460ae7bso192795ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758122977; x=1758727777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMxAjLuuDkMnizvwWJVXJDUetp9qiaCCJ0xivBfeA3Q=;
        b=SK2Q3UgNMa4G79wnV7k/vLZw6GG5lEljA4FgL7uiuqKGxiKgVX5UaXOrnFR3ykgd82
         FomqFsNaDOyYWLhDYlD1RcvcSn1srh57p3uB/c16z5HQcRd9LdKZsipRBDGtInFqbuFy
         lb65dZaQeQShBim/UZ+H4Q5F0t+owrM68ZlCdGM/9e/mYHOIlZSoLZSKF1nGjoyqKp4x
         T9TlIsEqU4hGIkcqAyloAKhSnhw2gflPvzWBYMrmyuCWZopqf4CguNd3P/cULAObk2tG
         UbAn3znQm/RQWaXJxdcP3JWniHkqqUY/VhkCXQByp6/VnQvyEwFLCPy3jIAw7N0IBgeK
         GAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122977; x=1758727777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMxAjLuuDkMnizvwWJVXJDUetp9qiaCCJ0xivBfeA3Q=;
        b=Yl6lud3ffL6sPStlFF0GdBGEqViDPvwgTwJgbk3duSSFMeRmLhOhD+BRJgKMDNHcyl
         ha2vLNAz+x1FgymbkLXmh+d0sXhJDl/QjLwCPqla8H0iBdXrZb/exJIVXMiDwrOOnRTF
         KAQOyZr/XR32rag/+xfSOxjON0Vcx7wgGs7yG/LJsrHoB7fesgE8A5o6hBTqiWJo4Kdo
         e+tEPIVrwsxpJkQA9bqwFZYXIFXen0pxXu5poR+3uwdvgEz2fLNZZ+4odCk0QzTYLvtv
         XST85HxJn98MnkhQKmTlFgP7hfiU6EQNx9lG/n+PU99KKY1lJIa/R2cWYuJF2kE/S8T3
         nxdA==
X-Forwarded-Encrypted: i=1; AJvYcCUz8oICawhIMpoU44sVW3rIsRNgWS3tmqV5tz7gTZOfCJj8EhG60IR7eOfIGTyZSY3iP87eQAGtzfmzGqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vfAPpHSHYpoGlqs0VuJbigrPfFyo6Fa1Nah+jClKelqahcM2
	/VqOVlI9SW8VNYaInM5vQ2KaKghPj7Xy5fnaXCc9Pmafj2fC3B7q1x7jsa+xaTGsIlmgRnSWNbm
	9TxKueqUQuPz2VrBumzK/EA3MVbpaFl5vIenHjH0I
X-Gm-Gg: ASbGncthr2riIL9k3mGDAHqejuZBZXCpTd2a8fI3LGlCgm69gF+nLRfpwJkvgfVHdc8
	63wEZU2KuerHsje0xZRUnU7ar1FsXVlPo70Ek1aj1wTxjESfX7RYV+vz2F0AGXuYC/cbFtRwxep
	M1qIN1qabwzSKf25HU7Hjj+T9w4grMBizckL4IwF9UKlmk6Puj70mIHbQ09oSw9kB6zKCH5s84C
	Luxj5Ebg7sJA4UwQ+fDeLDZRXeP/Pe2RokGdbcaWDpqYiScSzuRFw==
X-Google-Smtp-Source: AGHT+IEu5bTFqGbWEEWlRTNRW4OpqN3cCmobToF3V3eLzmTEu5d1MFMRS/pi2zER693ymPpprifjc2cb6F8Jwsr9GvA=
X-Received: by 2002:a17:903:22c6:b0:261:83d2:9d91 with SMTP id
 d9443c01a7336-26808af1b83mr3581005ad.15.1758122976798; Wed, 17 Sep 2025
 08:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728055937.58531-1-gautam@linux.ibm.com> <aMlmiHATn5WHUcSM@mac.in.ibm.com>
 <aMm5uvPsMfXEv8Oo@x1> <CAP-5=fW4JQYJ2NCRsRVePidCcZ9+JcQbfY=xQ00xZG-bSn96ew@mail.gmail.com>
 <aMqrmmDG65BGeZp0@x1>
In-Reply-To: <aMqrmmDG65BGeZp0@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Sep 2025 08:29:24 -0700
X-Gm-Features: AS18NWDkvSHJLNz9aprvKv7LSv3mgibe4uveJXarzHUkDmpgDV7sV8WBeCIO1hg
Message-ID: <CAP-5=fXnM15Zj5mCYcsd9usUMtHoPOd3Wz8-L1N5UaB-YvKuHQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	maddy@linux.ibm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 5:37=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Sep 16, 2025 at 01:07:43PM -0700, Ian Rogers wrote:
> > On Tue, Sep 16, 2025 at 12:25=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 07:00:48PM +0530, Gautam Menghani wrote:
> > > > Hi Ian/Arnaldo,
> > > >
> > > > Can you please review this series and let me know if any changes ar=
e
> > > > needed?
> > >
> > > Looking at it now, sry for the delay,
> >
> > I think the patches look good. I'm a little concerned that the python
> > APIs are a chance to do something better than the C APIs that have
> > evolved. For example, we removed UID out of target recently [1] as the
> > BPF alternative was better. Had this patch come earlier then it seems
> > likely we'd have had target with UIDs. I wonder rather than having a
> > kwlist of:
> >
> > + static char *kwlist[] =3D { "target", "inherit_stat", "no_buffering",
> > "no_inherit",
> > + "no_inherit_set", "no_samples", "raw_samples",
> > + "sample_address", "sample_phys_addr", "sample_data_page_size",
> > + "sample_code_page_size", "sample_weight", "sample_time",
> > + "sample_time_set", "sample_cpu", "sample_identifier",
> > + "sample_data_src", "period", "period_set", "running_time",
> > + "full_auxtrace", "auxtrace_snapshot_mode",
> > + "auxtrace_snapshot_on_exit", "auxtrace_sample_mode",
> > + "record_namespaces", "record_cgroup", "record_switch_events",
> > + "record_switch_events_set", "all_kernel", "all_user",
> > + "kernel_callchains", "user_callchains", "tail_synthesize",
> > + "overwrite", "ignore_missing_thread", "strict_freq", "sample_id",
> > + "no_bpf_event", "kcore", "text_poke", "build_id", "freq",
> > + "mmap_pages", "auxtrace_mmap_pages", "user_freq", "branch_stack",
> > + "sample_intr_regs", "sample_user_regs", "default_interval",
> > + "user_interval", "auxtrace_snapshot_size", "auxtrace_snapshot_opts",
> > + "auxtrace_sample_opts", "sample_transaction", "use_clockid",
> > + "clockid", "clockid_res_ns", "nr_cblocks", "affinity", "mmap_flush",
> > + "comp_level", "nr_threads_synthesize", "ctl_fd", "ctl_fd_ack",
> > + "ctl_fd_close", "synth", "threads_spec", "threads_user_spec",
> > + "off_cpu_thresh_ns",  NULL };
> >
> > but then just using this subset:
> >
> > +    opts =3D perf.record_opts(freq=3D1000, target=3Dtgt, sample_time=
=3DTrue,
> > +                            sample_cpu=3DTrue, no_buffering=3DTrue,
> > no_inherit=3DTrue)
> >
> > The kwlist should be kept to just those necessary values for the
> > example to work? I kind of see this as Arnaldo's baby, so he may just
> > want everything, so this needn't be a blocker.
> >
> > Bigger picture I wonder about migrating the `perf script` code to just
> > being regular python programs like the example here.
>
> You mean:
>
> acme@number:~/git/perf-tools-next$ ls -la tools/perf/scripts/python/
> total 452
> drwxr-xr-x. 1 acme acme    902 Aug 20 14:18 .
> drwxr-xr-x. 1 acme acme     30 Sep 17 09:27 ..
> -rwxr-xr-x. 1 acme acme  11865 Aug 20 14:06 arm-cs-trace-disasm.py
> drwxr-xr-x. 1 acme acme   1640 Aug 20 14:18 bin
> -rw-r--r--. 1 acme acme   2461 Apr 16 10:06 check-perf-trace.py
> -rw-r--r--. 1 acme acme   7923 Apr 16 10:06 compaction-times.py
> -rw-r--r--. 1 acme acme   7497 Apr 16 10:06 event_analyzing_sample.py
> -rwxr-xr-x. 1 acme acme 157369 Aug 20 14:18 exported-sql-viewer.py
> -rw-r--r--. 1 acme acme  39845 Apr 16 10:06 export-to-postgresql.py
> -rw-r--r--. 1 acme acme  24671 Apr 16 10:06 export-to-sqlite.py
> -rw-r--r--. 1 acme acme   2173 Apr 16 10:06 failed-syscalls-by-pid.py
> -rwxr-xr-x. 1 acme acme  10377 Aug 20 14:18 flamegraph.py
> -rw-r--r--. 1 acme acme   1717 Apr 16 10:06 futex-contention.py
> -rw-r--r--. 1 acme acme  13302 Apr 16 10:06 gecko.py
> -rw-r--r--. 1 acme acme  14636 Apr 16 10:06 intel-pt-events.py
> -rw-r--r--. 1 acme acme   3395 Apr 16 10:06 libxed.py
> -rw-r--r--. 1 acme acme   4230 Aug 20 14:13 mem-phys-addr.py
> -rw-r--r--. 1 acme acme  15420 Aug 20 14:05 netdev-times.py
> -rwxr-xr-x. 1 acme acme   1833 Apr 16 10:06 net_dropmonitor.py
> -rwxr-xr-x. 1 acme acme  30683 Aug 20 14:05 parallel-perf.py
> drwxr-xr-x. 1 acme acme     34 Sep 17 09:27 Perf-Trace-Util
> -rw-r--r--. 1 acme acme   4509 Apr 16 10:06 powerpc-hcalls.py
> -rw-r--r--. 1 acme acme  12095 Apr 16 10:06 sched-migration.py
> -rw-r--r--. 1 acme acme   2183 Apr 16 10:06 sctop.py
> -rwxr-xr-x. 1 acme acme   4408 Apr 16 10:06 stackcollapse.py
> -rw-r--r--. 1 acme acme   2444 Apr 16 10:06 stat-cpi.py
> -rw-r--r--. 1 acme acme   2055 Apr 16 10:06 syscall-counts-by-pid.py
> -rw-r--r--. 1 acme acme   1673 Apr 16 10:06 syscall-counts.py
> -rwxr-xr-x. 1 acme acme  34014 Apr 16 10:06 task-analyzer.py
> acme@number:~/git/perf-tools-next$
>
> And then make:
>
> acme@number:~/git/perf-tools-next$ perf script -l
> List of available trace scripts:
>   compaction-times [-h] [-u] [-p|-pv] [-t | [-m] [-fs] [-ms]] [pid|pid-ra=
nge|comm-regex] display time taken by mm compaction
>   event_analyzing_sample               analyze all perf samples
>   export-to-postgresql [database name] [columns] [calls] export perf data=
 to a postgresql database
>   export-to-sqlite [database name] [columns] [calls] export perf data to =
a sqlite3 database
>   failed-syscalls-by-pid [comm]        system-wide failed syscalls, by pi=
d
>   flamegraph                           create flame graphs
>   futex-contention                     futext contention measurement
>   gecko                                create firefox gecko profile json =
format from perf.data
>   intel-pt-events                      print Intel PT Events including Po=
wer Events and PTWRITE
>   mem-phys-addr                        resolve physical address samples
>   net_dropmonitor                      display a table of dropped frames
>   netdev-times [tx] [rx] [dev=3D] [debug] display a process of packet and=
 processing time
>   powerpc-hcalls
>   sched-migration                      sched migration overview
>   sctop [comm] [interval]              syscall top
>   stackcollapse                        produce callgraphs in short form f=
or scripting use
>   syscall-counts-by-pid [comm]         system-wide syscall counts, by pid
>   syscall-counts [comm]                system-wide syscall counts
>   task-analyzer                        analyze timings of tasks
>   failed-syscalls [comm]               system-wide failed syscalls
>   rw-by-file <comm>                    r/w activity for a program, by fil=
e
>   rw-by-pid                            system-wide r/w activity
>   rwtop [interval]                     system-wide r/w top
>   wakeup-latency                       system-wide min/max/avg wakeup lat=
ency
> acme@number:~/git/perf-tools-next$
>
> And make:
>
> perf script rwtop
>
> Just call 'python PATH_TO_PYTHON_SCRIPTS/rwtop.py' transparently?

Yeah, that's it. The perf script libpython stuff is just providing
trace_begin, process_event and trace_end. Using the sampling
mechanism, as shown in Gautum's patches, it is pretty easy to migrate
them to being stand alone bits of python.

> That looks interesting indeed, that way we would stop linking with
> libpython, etc.
>
> I wonder if there are out of tree scripts using the current tools/perf/ut=
il/scripting-engines/trace-event-python.c
> mechanism...
>
> But even that can fallback to a python based mechanism, right?

I think so. Like I said about the use of a Dict for process_event, we
may want to streamline things so there is a tension with what the API
should be and compatibility. We can always have 2 APIs and try to
deprecate one of them.

> Import the script, if it has a given structure, use the new way, if not,
> call a glue that reads the events and feed to the old style code.
>
> Seems doable and would save code on the main perf binary and headaches
> with the libpython and libperl build processes.

So I see this for libpython, and I think it'd be pretty cool if we
could have things work like this for say "perf script ilist" and
Alice's textual flamegraph work. I worry what the work for libperl
would be like and whether it is worth it (hence sending the patch to
at least start to make it opt-in rather than opt-out).

Do you need my tags for these changes or wdyt about making the
kwlist/API surface smaller?

Thanks!
Ian

> - Arnaldo
>
> > I sent out
> > deprecating the libperl code to this ends (looking for reviews):
> > https://lore.kernel.org/linux-perf-users/20250908181918.3533480-1-iroge=
rs@google.com/
> > The issue is that `perf script` being the main thread inhibits things
> > like textual running until trace_end. This means we can't do things
> > like incremental loading support. We may want to make the perf events
> > support something like an asyncio interface for that.
> >
> > Refactoring that support will likely raise backward compatibility
> > concerns. It'd be a really nice thing to do as the API has some fairly
> > major overheads like turning everything in a sample into a Dict
> > whether needed or not:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/perf/util/scripting-engines/trace-event-python.c#n838
> > I mention this just to say why I'd like to minimize the API when possib=
le.
> >
> > Thanks,
> > Ian
> >
> > [1] https://lore.kernel.org/r/20250604174545.2853620-10-irogers@google.=
com

