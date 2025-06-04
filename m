Return-Path: <linux-kernel+bounces-672537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9F9ACD0AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 02:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E6316EFF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5414409;
	Wed,  4 Jun 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHy2/VSs"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD994C6E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996812; cv=none; b=r3WUAmfmMWZ4mDgjwoMKCuaATUEZ4GW3DQ03Xkhq90T3WTe5OioYI/EvKdkXggjoTVm40lp8zp72i9LbMGqEkVtW/T5APS7z9k3hocaH4fPR6zut29k0AO6QaXGbCMagsA14g9tFXIlLPLG/TgGXaagrhjMHJnTFhSkAv594Rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996812; c=relaxed/simple;
	bh=deXNHd1uEBMLP/I5aAgAx4Km9BD8Cu2CkIXG9FrVrzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwxp9zcQRaegGVE8i8o0vcQKSxHPoSVdUbMfa9bhc52feVeut1r2/6szkyVw2GwF4YRrlaTmJ/LxRrD6dVyOGRUwOQux8R2pn/Rca2e1DZMKlxesnegGF0mXgj/Phfts4IpOjc8sq52l8z/k8wEYCF/aPRWbwqhLGHw6CQKM1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHy2/VSs; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso63675ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 17:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748996809; x=1749601609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGJkClMqGZSaYuCxa0aJjyag7e0HBeJlKh2hqQSUBrk=;
        b=kHy2/VSsX5j73QfFn/wfyLxWD0xEb8FTDr25BYZwJV4kvCEvXJZ/A1JrzRL6SNrvk5
         8uxH4JNaFycTKgX+LwIUXDFAqwREzlMA9TmK5gIutj4iM59LsyV2tfNtk/WDdM6qtAjC
         V43lc7P9yEwluAZcQQtj6ws7Jtpr2/EkNcxY3sSF5i9ckNcYzxvF5vXsJQg8kQ01wA/k
         XI6GJkZViqIApHuZWrdWkHDf14PHsd5ULHTxJzTpq+IT7Jf+NmX7oV0qD11AO9mOiBn0
         ERs8WwkC85a+OWhvJubo2tseaHGyTUM8T5MrkIfKHCxuoGUrq4q1EA+gaq6lJlUyL20y
         okKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748996809; x=1749601609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGJkClMqGZSaYuCxa0aJjyag7e0HBeJlKh2hqQSUBrk=;
        b=DNgXxDaDy5X2jQUM2dqJ6U9UPfiOCrfoH1tfSgSyI96OqVqgvMzYw9NCSVhXm2zUIl
         Oa3VvVGXWmCRscCb6FLwi78NSM76xqlApYlzPMmYr1POzKnbyDIXdU8USdKaffoVJMwz
         VupGLbNFvTVeQBtVKEss61VI8qsgYj/LirclOZkdF80AIjWQelijYBP+pZO6WPXzJVFj
         +4MfNIitF55IfWY1Sq8RgmQ45Riz0o+uPmLBFs8iOiNXtGGCdOAicWKgmD5PRhSJO7m2
         kj4AtUMyuyxi86GYVgUU/c+Jc0UMeipa9IGOSsowr8t3y8ADSMgSQlVf3QzZdqMYCvKo
         Tw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6g1NTgGwUGYjtUrkEbgms47XbM2zCZxDApuwcjUsAlh2ifM8yGeLsITompmgeQkDjqhU+4or7J52m2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhCpQlM0huq6QbLYShN2IrDjq36+UEGrrb0q6eweCOkBkGaUoO
	RJiGLv4T9g34N/4vkB2XZdD2TdcB4TIFmTzniRyoJ4cGsNywhk4xCz1BMi5X63w4lMsCJ9M8bWX
	OtvTa/3+Ln0q/t+c6vOhBawIOvays2eq5yL+yG+Yg
X-Gm-Gg: ASbGncvQiIYqyhs8m4Mg/ouVoQix8qN2oREMrq6YknZMcqQfQaffh2luWqFdOx3Hsni
	qpwFT9vnhwzVNyYh2Maxq9VtfdjUcNGfLeDw22VOhb3Sn0Bxuc1NV84l2iS7eCpiz3rAI3ySKuS
	4yJJHClrquPkPbX+Z8+ZKWeOCil2u5OgFYcXMV5m31+T1yyqqNiVzKuWDpEaI/OwgJ3tXT6dzE
X-Google-Smtp-Source: AGHT+IEESjfgp/Q+Op6c4Chwt99/56jGEcTbmMe+aSKUwc74gaeSuzBVZN5IOO0bdeF6pbxqVtef6jlkae2BdGs2ZV8=
X-Received: by 2002:a05:6e02:2169:b0:3dd:a7a1:9f14 with SMTP id
 e9e14a558f8ab-3ddbe7b13bemr1588985ab.4.1748996809096; Tue, 03 Jun 2025
 17:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416045117.876775-1-irogers@google.com> <CAP-5=fU3VW1MjHMiaPG+JirLCCunMC6bEWpsJ3h0E7bTDkh9cA@mail.gmail.com>
 <aD54ptuIFHcKPkRQ@google.com> <CAP-5=fWSfFa6ncV6JkKSN4ByQ9HR+2ff4+uzwpMO5n-GaNbwxQ@mail.gmail.com>
 <aD98NFhyTcEU_qim@google.com> <CAP-5=fW0LKk1UyJr=feQd6nbNZC-ZLtUde=qX=-c9nqvDoqu-A@mail.gmail.com>
 <aD-MdTsb40kIXSBE@google.com>
In-Reply-To: <aD-MdTsb40kIXSBE@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Jun 2025 17:26:37 -0700
X-Gm-Features: AX0GCFsOq0oytAtXVSIaI_qLxVAo9fsnsTeKd2OGDOQtBjUTxeNAC9bYBNkd_YY
Message-ID: <CAP-5=fUrQJR93UBN-rtGPqVHQsHmPcGzEmc9O2PKsQpuy+NY7w@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 4:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Jun 03, 2025 at 04:36:34PM -0700, Ian Rogers wrote:
> > On Tue, Jun 3, 2025 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Mon, Jun 02, 2025 at 11:08:34PM -0700, Ian Rogers wrote:
> > > > On Mon, Jun 2, 2025 at 9:23=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > On Tue, May 27, 2025 at 01:50:32PM -0700, Ian Rogers wrote:
> > > > > > On Tue, Apr 15, 2025 at 9:51=E2=80=AFPM Ian Rogers <irogers@goo=
gle.com> wrote:
> > > > > > >
> > > > > > > At the RISC-V summit the topic of avoiding event data being i=
n the
> > > > > > > RISC-V PMU kernel driver came up. There is a preference for s=
ysfs/JSON
> > > > > > > events being the priority when no PMU is provided so that leg=
acy
> > > > > > > events maybe supported via json. Originally Mark Rutland also
> > > > > > > expressed at LPC 2023 that doing this would resolve bugs on A=
RM Apple
> > > > > > > M? processors, but James Clark more recently tested this and =
believes
> > > > > > > the driver issues there may not have existed or have been res=
olved. In
> > > > > > > any case, it is inconsistent that with a PMU event names avoi=
d legacy
> > > > > > > encodings, but when wildcarding PMUs (ie without a PMU with t=
he event
> > > > > > > name) the legacy encodings have priority.
> > > > > > >
> > > > > > > The situation is further inconsistent as legacy events are ca=
se
> > > > > > > sensitive, so on Intel that provides a sysfs instructions eve=
nt, the
> > > > > > > instructions event without a PMU and lowercase is legacy whil=
e with
> > > > > > > uppercase letters it matches with sysfs which is case insensi=
tive. Are
> > > > > > > there legacy events with upper case letters? Yes there are, t=
he cache
> > > > > > > ones mix case freely:
> > > > > > >
> > > > > > > L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|=
LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|b=
tb|bpc|node
> > > > > > >
> > > > > > > meaning LLC that means L2 (which is wrong) both match as part=
 of a
> > > > > > > legacy cache name but llc and l2 would only match sysfs/json
> > > > > > > events. The whole thing just points at the ridiculous nature =
of legacy
> > > > > > > events and why we'd want them to be preffered I don't know. W=
hy should
> > > > > > > case of a letter or having a PMU prefix impact the encoding i=
n the
> > > > > > > perf_event_attr?
> > > > > > >
> > > > > > > The patch doing this work was reverted in a v6.10 release can=
didate
> > > > > > > as, even though the patch was posted for weeks and had been o=
n
> > > > > > > linux-next for weeks without issue, Linus was in the habit of=
 using
> > > > > > > explicit legacy events with unsupported precision options on =
his
> > > > > > > Neoverse-N1. This machine has SLC PMU events for bus and CPU =
cycles
> > > > > > > where ARM decided to call the events bus_cycles and cycles, t=
he latter
> > > > > > > being also a legacy event name. ARM haven't renamed the cycle=
s event
> > > > > > > to a more consistent cpu_cycles and avoided the problem. With=
 these
> > > > > > > changes the problematic event will now be skipped, a large wa=
rning
> > > > > > > produced, and perf record will continue for the other PMU eve=
nts. This
> > > > > > > solution was proposed by Arnaldo.
> > > > > > >
> > > > > > > v8: Change removing of failed to open events that are trackin=
g so that
> > > > > > >     the tracking moves to the next event. Make software event=
s able to
> > > > > > >     specified with a PMU. Change the perf_api_probe to not lo=
ad all
> > > > > > >     PMUs through scanning, specify a PMU when parsing events.
> > > > > > >
> > > > > > > v7: Expand cover letter, fix a missed core_ok check in the v6
> > > > > > >     rebase. Note, as with v6 there is an alternate series tha=
t
> > > > > > >     prioritizes legacy events but that is silly and I'd prefe=
r we
> > > > > > >     didn't do it.
> > > > > > >
> > > > > > > v6: Rebase of v5 (dropping already merged patches):
> > > > > > >     https://lore.kernel.org/lkml/20250109222109.567031-1-irog=
ers@google.com/
> > > > > > >     that unusually had an RFC posted for it:
> > > > > > >     https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
> > > > > > >     Note, this patch conflicts/contradicts:
> > > > > > >     https://lore.kernel.org/lkml/20250312211623.2495798-1-iro=
gers@google.com/
> > > > > > >     that I posted so that we could either consistently priori=
tize
> > > > > > >     sysfs/json (these patches) or legacy events (the other
> > > > > > >     patches). That lack of event printing and encoding incons=
istency
> > > > > > >     is most prominent in the encoding of events like "instruc=
tions"
> > > > > > >     which on hybrid are reported as "cpu_core/instructions/" =
but
> > > > > > >     "instructions" before these patches gets a legacy encodin=
g while
> > > > > > >     "cpu_core/instructions/" gets a sysfs/json encoding. Thes=
e patches
> > > > > > >     make "instructions" always get a sysfs/json encoding whil=
e the
> > > > > > >     alternate patches make it always get a legacy encoding.
> > > > > > >
> > > > > > > v5: Follow Namhyung's suggestion and ignore the case where co=
mmand
> > > > > > >     line dummy events fail to open alongside other events tha=
t all
> > > > > > >     fail to open. Note, the Tested-by tags are left on the se=
ries as
> > > > > > >     v4 and v5 were changing an error case that doesn't occur =
in
> > > > > > >     testing but was manually tested by myself.
> > > > > > >
> > > > > > > v4: Rework the no events opening change from v3 to make it ha=
ndle
> > > > > > >     multiple dummy events. Sadly an evlist isn't empty if it =
just
> > > > > > >     contains dummy events as the dummy event may be used with=
 "perf
> > > > > > >     record -e dummy .." as a way to determine whether permiss=
ion
> > > > > > >     issues exist. Other software events like cpu-clock would =
suffice
> > > > > > >     for this, but the using dummy genie has left the bottle.
> > > > > > >
> > > > > > >     Another problem is that we appear to have an excessive nu=
mber of
> > > > > > >     dummy events added, for example, we can likely avoid a du=
mmy event
> > > > > > >     and add sideband data to the original event. For auxtrace=
 more
> > > > > > >     dummy events may be opened too. Anyway, this has led to t=
he
> > > > > > >     approach taken in patch 3 where the number of dummy parse=
d events
> > > > > > >     is computed. If the number of removed/failing-to-open non=
-dummy
> > > > > > >     events matches the number of non-dummy events then we wan=
t to
> > > > > > >     fail, but only if there are no parsed dummy events or if =
there was
> > > > > > >     one then it must have opened. The math here is hard to re=
ad, but
> > > > > > >     passes my manual testing.
> > > > > > >
> > > > > > > v3: Make no events opening for perf record a failure as sugge=
sted by
> > > > > > >     James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. A=
lso,
> > > > > > >     rebase.
> > > > > > >
> > > > > > > v2: Rebase and add tested-by tags from James Clark, Leo Yan a=
nd Atish
> > > > > > >     Patra who have tested on RISC-V and ARM CPUs, including t=
he
> > > > > > >     problem case from before.
> > > > > >
> > > > > > Ping. Thanks,
> > > > > > Ian
> > > > > >
> > > > > > > Ian Rogers (4):
> > > > > > >   perf record: Skip don't fail for events that don't open
> > > > > > >   perf parse-events: Reapply "Prefer sysfs/JSON hardware even=
ts over
> > > > > > >     legacy"
> > > > > > >   perf parse-events: Allow software events to be terms
> > > > > > >   perf perf_api_probe: Avoid scanning all PMUs, try software =
PMU first
> > > > >
> > > > > Sorry for the delay.  But I think we wanted to move to this inste=
ad:
> > > > >
> > > > > https://lore.kernel.org/linux-perf-users/20250312211623.2495798-1=
-irogers@google.com/
> > > >
> > > > Hi Namhyung,
> > > >
> > > > The preference for sysfs/json over legacy was done as a bug fix and
> > > > because ARM (Mark Rutland) argued strongly that it was the most
> > > > sensible priority. Intel (Kan Liang) approved the change in priorit=
y.
> > > > RISC-V have wanted this behavior as it enables the migration of eve=
nt
> > > > mappings from the driver to the tool. As the primary maintainer of =
the
> > > > event parsing and metric code I prefer the priority as legacy event=
s
> > > > are weird, for example they aren't case insensitive in their naming=
.
> > > > For example, on Intel with legacy events as the priority cpu-cycles
> > > > would be a legacy event, but cpu-Cyles a sysfs one. On ARM cpu_cycl=
es
> > > > would be a sysfs event, but cpu-cycles a legacy one. A minor charac=
ter
> > > > difference and very different and imo surprising event encodings.
> > >
> > > Yeah, but it has worked like that for a long time.
> > >
> > > >
> > > > On your RFC thread Arnaldo and James said that legacy events someho=
w
> > > > enabled a form of drill down. As event parsing is mapping a name to=
 a
> > > > perf_event_attr I completely don't see this as the mapping is opaqu=
e.
> > >
> > > Is it opaque?  (I'd say it standard event rather than legacy event.) =
 I
> > > think the mapping for the standard events are clearly defined.
> >
> > Which standard events? Going through them (abbreviated to avoid repetit=
ion):
> >  - PERF_COUNT_HW_CPU_CYCLES, ok.
> >  - PERF_COUNT_HW_INSTRUCTIONS, well does that include speculatively
> > executed instructions or not?
> >  - ...
> >  - PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, what does this count on an
> > in order CPU?
> >  - ...
>
> I mean the mapping from event name to event encoding (PERF_COUNT_HW_...).
> I think the internal event mapping is the driver's business.
>
> >
> > The hardware cache events are far worse as things like LLC mean the L2
> > cache, however, it is far more typical for this to mean L3 these days.
> > Standard and clearly defined, sorry absolutely not. They are a
> > minefield of well intentioned event name components waiting to explode
> > when a vendor inadvertently creates a combination that happens to
> > match a combination perf thinks is significant.
>
> Again, it belongs to the driver.

But we know there are broken drivers. That is why this started. The
Apple-M core PMU had broken mappings and was reliant on being treated
as an uncore PMU so that legacy encodings weren't used. By forcing the
use of legacy encodings you'd break new perf tools on v6.6 kernels on
Apple-M IIRC.

When an event is encoded in json it can have a description. The
description can identify what the exact behaviors wrt speculation,
what LLC means, etc. are. The legacy event names are a minefield and
ambiguous.

Why are they a minefield? We import metrics from sources like the TMA
spreadsheet:
https://github.com/intel/perfmon/blob/main/TMA_Metrics-full.csv
The events named in here are intended for use across a range of tools
like vtune and emon. When we import event names in the perf build we
assume they are case insensitive and match them by lower-casing them:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/jevents.py?h=3Dperf-tools-next#n326
Legacy cache events are made up of components:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n258
```
lc_type (L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L=
2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bp=
c|node)
lc_op_result (load|loads|read|store|stores|write|prefetch|prefetches|specul=
ative-read|speculative-load|refs|Reference|ops|access|misses|miss)
```
If legacy events have the priority then an event that accidentally
combines these components can switch from using the event json that
comes with the metric to using a legacy event that has a different
behavior. It may also result in parse errors.

We are avoiding stepping on mines by luck currently and the approach
of using legacy first is essentially error prone. (It also breaks
Apple-M and is the opposite of what RISC-V have requested)

> >
> > There was a similar attempt for raw events where you can go r123 for
> > the hex 123 event config, it was missed that rEAD is a valid hex raw
> > event as well as a useful event name. The event parsing now has a lot
> > of special handling to avoid exploding on this - and yes the priority
> > is that sysfs/json has priority over the raw event encoding.
>
> Agreed, the raw encoding can be a problem and it makes sense the sysfs/
> JSON has the priority.
>
> >
> > > >
> > > > I strongly believe we need consistency. If `perf stat -e cycles .. =
`
> > > > prints cpu_core/cycles/ as the event name on a hybrid Intel, then
> > > > `perf stat -e cpu_core/cycles/ .. ` should have the same
> > > > perf_event_attr. Both patch series achieve this but this one does i=
t
> > > > with consistency, and from what I see it, the support of 3 vendors.
> > >
> > > Right, it's not consistent.  Maybe we need a different uniq event nam=
e
> > > for extended (standard) events.  How about "cycles(cpu_core)"?  I gue=
ss
> > > we don't want to add a space between the PMU and event names to avoid
> > > potential user impact when they parse the output.
> >
> > We could and it would very likely break tooling. The intent is that
> > cpu-cycles matches cpu_core/cpu-cycles/ and cpu_atom/cpu-cycles/ and
> > they are expected to all be the same event. Currently with the PMU
> > they are sysfs encoded but without a PMU they are legacy encoded but
> > printed (uniquified) as if they were with a PMU and sysfs encoded.
> > This is misleading.
>
> Hmm.. I don't know what's the correct way to handle this.  Can we
> change it not to use extended standard events and to convert to sysfs
> events then?

Tbh, I think a lot of this is coming down to 1 event, cycles. It is
the only unambiguous legacy event. If we make cycles only mean core
PMU cycles (ie cpu_core, cpu_atom on hybrid, cpu on non-hybrid) then I
think this is matching what you are expecting to happen. I mean we
only match cycles as legacy first and everything else is sysfs/json
first and legacy last. I think other legacy events cpu-cycles aren't
special and don't get legacy first treatment. Having just 1 special
legacy only event cycles is a lot less offensive to me than having say
branch-prefetch-read also be legacy. We accept cycles is a minefield
and special, but it is unique in this.

Thanks,
Ian

> Thanks,
> Namhyung
>

