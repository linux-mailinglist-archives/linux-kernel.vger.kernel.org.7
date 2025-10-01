Return-Path: <linux-kernel+bounces-839486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D550BB1B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F4F4C2B35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F693019B6;
	Wed,  1 Oct 2025 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnEJoigf"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39BC148
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352150; cv=none; b=k1mNuqvbSMFUjgPp6AiW3/WwjkxyhLpY+gvqggnivWSAZMT+6SjJqEAJ99rAWXJr7FKwgrvY9mei8yGMqoej/w5HPKWvUIKBDWEXu2zrqHvoWz+AyTkUsVvK0rhSx+ESzPlbiQjriMIvrYIGAxi4wDxq27ZI77rHOTu85FH4c9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352150; c=relaxed/simple;
	bh=/38h0tsn+UT1JnooHB53Dj2uKmOpOBk0kU35QdTpcdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo2hPf35Pe6MivRDOB3Tas2cpFT9UhcNVL84pBqb1e6Q5GB3U0W5RLI/Z0c9tRMf0/kurNgOhDptWpE5wUIhJQSuTLxqlNGwycaXo5YnBjcSylBAWYpp15L3vF9DNG7zCrfyLWpyQyCza+F5FlQAyVA+ThmFb0N1zR/4z4NLM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnEJoigf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eeafd4882so61575ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 13:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352148; x=1759956948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aeh0L7LeHLsu26VqM8P/Q+nKLUX6e3y4imw4wBkZZP4=;
        b=PnEJoigfKBciu1yEcd78PRX2ly/2RR34lL+itfThz2QFkgIezCJpnTF22gpaqKyTHY
         ih2pdCy10D5JShAfrLjPCuV/5sWDBoVt/ZzXiIlyEo6uslF8MZa0+C47rEhe8aim2sgM
         D/kc1+B2EnsIDnsku61rinPQvrrpB4RBTIpp6loycfYP96Y+UAZjqs67UXHggm6j46kp
         ukqwS9Zc8hZsXLzkIy6v0lbhJd7vdeJ3gv8YOx+KKOq0SUR+83GGfJTDr/ctuyFt0wLa
         OGbE/MAqbQODbQ5tQ5Q4fj2uDwsSAfY+CQcqObPWYTxHogqyTAWOxgjao7ocIy0laM5A
         fJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352148; x=1759956948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aeh0L7LeHLsu26VqM8P/Q+nKLUX6e3y4imw4wBkZZP4=;
        b=f5Ww2R/k4ioFLDckLmxObzN1b32y9Y5YBkwfTclCbPVZBa2K5W+cx00KXecLyI9q4/
         3cRl4xfYjZC2jB26fAdbO6YjH0XxSVf5hpqsjWHvNUob7cXMJvXipWpEds9l4Af8Iawf
         f7/KLXuH4gFR6SgzjKyEpgoVAvgJBT1zV+9V3CaftfbRJ9Gc/+E4BtzBVak6t4vbj2JO
         Eg+cNZJ0D3AbYnHe5zlHzUlSddDmLheROLPMF9f/uEg+WtOuqow9Pd360RtcyAkb6HR/
         ISPxFgA4x/C/mjHxWSP1y1wY0XPlbI907u7JW9pGuvXwN5NsJWc2VdO2aJ9PM8/yUM9t
         P6bg==
X-Forwarded-Encrypted: i=1; AJvYcCVfwWAZ1chxDJBks8bYJQDGhmtTrUYbQWd/W03pYQZi6GVRWw5ZXT80pwYlbbRsID0T8mmXX73l2yGmbu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkPD/PKEJlfE8DIZxw7QXLlZekEnxUHJCWe6dII6bdNqbT1GV
	ETYfy2nwSlP5bN6KCjrwx87x1bl9Xhxy6Yofn4oFft805AD/L01ZFbS9nI8BU0g3XlxQ3RObMai
	GNVAnhs0jv9Mqt4Vh4BgYDjLbjuWgXMdoj+zi2PLs
X-Gm-Gg: ASbGncuFScZABMKi5882mGkmo45mXmK6+qGWgPwUX2/8UaMwRtZktYTWYNM3aswVuTe
	JZn66Q4wtiifVcqgV+gv/4+rM6Zq3m353g8GuhXOL1bJeanHtPl0J5PqBqHT68YgCW+r29MI6Q3
	Q5ANAmx+fuWzWGZxehWG5f6PXqnWHuGZwDMTQ8cHvm9TjDCTDewaCFYdzyM2YseEuiR4UBn4su8
	jvUg7TcaDgQzZM3e+9UlE/KToc/YXBau8T/8V89fu07m5l8nw163lXvQxeDsa5MXVrH/sml/nwr
	YQ==
X-Google-Smtp-Source: AGHT+IGhSngtD0/oivAzYFWFevOfFRN3UwPblfcxijN5MAOxlgGclXwfomyQo+NU+3Ar43tIH3PXELICwYvdoFZ14D0=
X-Received: by 2002:a17:903:3c2f:b0:264:1805:df20 with SMTP id
 d9443c01a7336-28e8d954347mr1296795ad.4.1759352147382; Wed, 01 Oct 2025
 13:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com> <ca47d298-331d-420c-8c4f-83cd29bae902@linaro.org>
 <CAP-5=fWUYH2eji2SNp37_2uHu55qEfRxuhhROYsMZeCixjda+g@mail.gmail.com>
In-Reply-To: <CAP-5=fWUYH2eji2SNp37_2uHu55qEfRxuhhROYsMZeCixjda+g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Oct 2025 13:55:36 -0700
X-Gm-Features: AS18NWCnCwepsKODvkz1Gv05JIEYVdYbUwKLYl0fqLW9QmOLctE1KVsrwUMois8
Message-ID: <CAP-5=fWUVycpDss_+MNQ_DM93AYKWED8aYOUBKLziYTOn68QJA@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:12=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Oct 1, 2025 at 6:38=E2=80=AFAM James Clark <james.clark@linaro.or=
g> wrote:
> >
> >
> >
> > On 23/09/2025 11:32 pm, Ian Rogers wrote:
> > > Mirroring similar work for software events in commit 6e9fa4131abb
> > > ("perf parse-events: Remove non-json software events"). These changes
> > > migrate the legacy hardware and cache events to json.  With no hard
> > > coded legacy hardware or cache events the wild card, case
> > > insensitivity, etc. is consistent for events. This does, however, mea=
n
> > > events like cycles will wild card against all PMUs. A change doing th=
e
> > > same was originally posted and merged from:
> > > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > > and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> > > parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> > > his dislike for the cycles behavior on ARM with perf record. Earlier
> > > patches in this series make perf record event opening failures
> > > non-fatal and hide the cycles event's failure to open on ARM in perf
> > > record, so it is expected the behavior will now be transparent in per=
f
> > > record on ARM. perf stat with a cycles event will wildcard open the
> > > event on all PMUs, however, with default events the cycles event will
> > > only be opened on core PMUs.
> > >
> > > The key motivation for these patches is so that if, for example, you
> > > run `perf stat -e cpu-cycles ...` on a hybrid x86 and the results are
> > > printed out with "cpu_core/cpu-cycles/" and "cpu_atom/cpu-cycles/",
> > > the perf_event_attr for cpu-cycles and cpu_core/cpu-cycles/ be the
> > > same, similarly for the cpu_atom event. Prior to these patches the
> > > event with a PMU prefers sysfs/json over legacy encodings while with
> > > no PMU legacy encodings are preferred - these are different encodings
> > > on x86.
> > >
> > > The change to support legacy events with PMUs was done to clean up
> > > Intel's hybrid PMU implementation. Having sysfs/json events with
> > > increased priority to legacy was requested by Mark Rutland
> > >   <mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken legacy
> > > events on that PMU. It is believed the PMU driver is now fixed, but
> > > this has only been confirmed on ARM Juno boards. It was requested tha=
t
> > > RISC-V be able to add events to the perf tool json so the PMU driver
> > > didn't need to map legacy events to config encodings:
> > > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc=
.com/
> > > This patch series achieves this.
> > >
> > > A previous series of patches decreasing legacy hardware event
> > > priorities was posted in:
> > > https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.c=
om/
> > > Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
> > > software events can be implemented similarly:
> > > https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/
> > > and this patch series achieves this.
> > >
> > > Note, patch 2 (perf parse-events: Fix legacy cache events if event is
> > > duplicated in a PMU) fixes a function deleted by patch 17 (perf
> > > parse-events: Remove hard coded legacy hardware and cache
> > > parsing). Adding the json exposed an issue when legacy cache (not
> > > legacy hardware) and sysfs/json events exist. The fix is necessary to
> > > keep tests passing through the series. It is also posted for backport=
s
> > > to stable trees.
> > >
> > > The perf list behavior includes a lot more information and events. Th=
e
> > > before behavior on a hybrid alderlake is:
> > > ```
> > > $ perf list hw
> > >
> > > List of pre-defined events (to be used in -e or -M):
> > >
> > >    branch-instructions OR branches                    [Hardware event=
]
> > >    branch-misses                                      [Hardware event=
]
> > >    bus-cycles                                         [Hardware event=
]
> > >    cache-misses                                       [Hardware event=
]
> > >    cache-references                                   [Hardware event=
]
> > >    cpu-cycles OR cycles                               [Hardware event=
]
> > >    instructions                                       [Hardware event=
]
> > >    ref-cycles                                         [Hardware event=
]
> > > $ perf list hwcache
> > >
> > > List of pre-defined events (to be used in -e or -M):
> > >
> > >
> > > cache:
> > >    L1-dcache-loads OR cpu_atom/L1-dcache-loads/
> > >    L1-dcache-stores OR cpu_atom/L1-dcache-stores/
> > >    L1-icache-loads OR cpu_atom/L1-icache-loads/
> > >    L1-icache-load-misses OR cpu_atom/L1-icache-load-misses/
> > >    LLC-loads OR cpu_atom/LLC-loads/
> > >    LLC-load-misses OR cpu_atom/LLC-load-misses/
> > >    LLC-stores OR cpu_atom/LLC-stores/
> > >    LLC-store-misses OR cpu_atom/LLC-store-misses/
> > >    dTLB-loads OR cpu_atom/dTLB-loads/
> > >    dTLB-load-misses OR cpu_atom/dTLB-load-misses/
> > >    dTLB-stores OR cpu_atom/dTLB-stores/
> > >    dTLB-store-misses OR cpu_atom/dTLB-store-misses/
> > >    iTLB-load-misses OR cpu_atom/iTLB-load-misses/
> > >    branch-loads OR cpu_atom/branch-loads/
> > >    branch-load-misses OR cpu_atom/branch-load-misses/
> > >    L1-dcache-loads OR cpu_core/L1-dcache-loads/
> > >    L1-dcache-load-misses OR cpu_core/L1-dcache-load-misses/
> > >    L1-dcache-stores OR cpu_core/L1-dcache-stores/
> > >    L1-icache-load-misses OR cpu_core/L1-icache-load-misses/
> > >    LLC-loads OR cpu_core/LLC-loads/
> > >    LLC-load-misses OR cpu_core/LLC-load-misses/
> > >    LLC-stores OR cpu_core/LLC-stores/
> > >    LLC-store-misses OR cpu_core/LLC-store-misses/
> > >    dTLB-loads OR cpu_core/dTLB-loads/
> > >    dTLB-load-misses OR cpu_core/dTLB-load-misses/
> > >    dTLB-stores OR cpu_core/dTLB-stores/
> > >    dTLB-store-misses OR cpu_core/dTLB-store-misses/
> > >    iTLB-load-misses OR cpu_core/iTLB-load-misses/
> > >    branch-loads OR cpu_core/branch-loads/
> > >    branch-load-misses OR cpu_core/branch-load-misses/
> > >    node-loads OR cpu_core/node-loads/
> > >    node-load-misses OR cpu_core/node-load-misses/
> > > ```
> > > and after it is:
> > > ```
> > > $ perf list hw
> > >
> > > legacy hardware:
> > >    branch-instructions
> > >         [Retired branch instructions [This event is an alias of branc=
hes].
> > >          Unit: cpu_atom]
> > >    branch-misses
> > >         [Mispredicted branch instructions. Unit: cpu_atom]
> > >    branches
> > >         [Retired branch instructions [This event is an alias of
> > >          branch-instructions]. Unit: cpu_atom]
> > >    bus-cycles
> > >         [Bus cycles,which can be different from total cycles. Unit: c=
pu_atom]
> > >    cache-misses
> > >         [Cache misses. Usually this indicates Last Level Cache misses=
; this is
> > >          intended to be used in conjunction with the
> > >          PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss=
 rates.
> > >          Unit: cpu_atom]
> > >    cache-references
> > >         [Cache accesses. Usually this indicates Last Level Cache acce=
sses but
> > >          this may vary depending on your CPU. This may include prefet=
ches and
> > >          coherency messages; again this depends on the design of your=
 CPU.
> > >          Unit: cpu_atom]
> > >    cpu-cycles
> > >         [Total cycles. Be wary of what happens during CPU frequency s=
caling
> > >          [This event is an alias of cycles]. Unit: cpu_atom]
> > >    cycles
> > >         [Total cycles. Be wary of what happens during CPU frequency s=
caling
> > >          [This event is an alias of cpu-cycles]. Unit: cpu_atom]
> > >    instructions
> > >         [Retired instructions. Be careful,these can be affected by va=
rious
> > >          issues,most notably hardware interrupt counts. Unit: cpu_ato=
m]
> > >    ref-cycles
> > >         [Total cycles; not affected by CPU frequency scaling. Unit: c=
pu_atom]
> > >    branch-instructions
> > >         [Retired branch instructions [This event is an alias of branc=
hes].
> > >          Unit: cpu_core]
> > >    branch-misses
> > >         [Mispredicted branch instructions. Unit: cpu_core]
> > >    branches
> > >         [Retired branch instructions [This event is an alias of
> > >          branch-instructions]. Unit: cpu_core]
> > >    bus-cycles
> > >         [Bus cycles,which can be different from total cycles. Unit: c=
pu_core]
> > >    cache-misses
> > >         [Cache misses. Usually this indicates Last Level Cache misses=
; this is
> > >          intended to be used in conjunction with the
> > >          PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss=
 rates.
> > >          Unit: cpu_core]
> > >    cache-references
> > >         [Cache accesses. Usually this indicates Last Level Cache acce=
sses but
> > >          this may vary depending on your CPU. This may include prefet=
ches and
> > >          coherency messages; again this depends on the design of your=
 CPU.
> > >          Unit: cpu_core]
> > >    cpu-cycles
> > >         [Total cycles. Be wary of what happens during CPU frequency s=
caling
> > >          [This event is an alias of cycles]. Unit: cpu_core]
> > >    cycles
> > >         [Total cycles. Be wary of what happens during CPU frequency s=
caling
> > >          [This event is an alias of cpu-cycles]. Unit: cpu_core]
> > >    instructions
> > >         [Retired instructions. Be careful,these can be affected by va=
rious
> > >          issues,most notably hardware interrupt counts. Unit: cpu_cor=
e]
> > >    ref-cycles
> > >         [Total cycles; not affected by CPU frequency scaling. Unit: c=
pu_core]
> > > $ perf list hwcache
> > >
> > > legacy cache:
> > >    branch-load-misses
> > >         [Branch prediction unit read misses. Unit: cpu_atom]
> > >    branch-loads
> > >         [Branch prediction unit read accesses. Unit: cpu_atom]
> > >    dtlb-load-misses
> > >         [Data TLB read misses. Unit: cpu_atom]
> > >    dtlb-loads
> > >         [Data TLB read accesses. Unit: cpu_atom]
> > >    dtlb-store-misses
> > >         [Data TLB write misses. Unit: cpu_atom]
> > >    dtlb-stores
> > >         [Data TLB write accesses. Unit: cpu_atom]
> > >    itlb-load-misses
> > >         [Instruction TLB read misses. Unit: cpu_atom]
> > >    l1-dcache-loads
> > >         [Level 1 data cache read accesses. Unit: cpu_atom]
> > >    l1-dcache-stores
> > >         [Level 1 data cache write accesses. Unit: cpu_atom]
> > >    l1-icache-load-misses
> > >         [Level 1 instruction cache read misses. Unit: cpu_atom]
> > >    l1-icache-loads
> > >         [Level 1 instruction cache read accesses. Unit: cpu_atom]
> > >    llc-load-misses
> > >         [Last level cache read misses. Unit: cpu_atom]
> > >    llc-loads
> > >         [Last level cache read accesses. Unit: cpu_atom]
> > >    llc-store-misses
> > >         [Last level cache write misses. Unit: cpu_atom]
> > >    llc-stores
> > >         [Last level cache write accesses. Unit: cpu_atom]
> > >    branch-load-misses
> > >         [Branch prediction unit read misses. Unit: cpu_core]
> > >    branch-loads
> > >         [Branch prediction unit read accesses. Unit: cpu_core]
> > >    dtlb-load-misses
> > >         [Data TLB read misses. Unit: cpu_core]
> > >    dtlb-loads
> > >         [Data TLB read accesses. Unit: cpu_core]
> > >    dtlb-store-misses
> > >         [Data TLB write misses. Unit: cpu_core]
> > >    dtlb-stores
> > >         [Data TLB write accesses. Unit: cpu_core]
> > >    itlb-load-misses
> > >         [Instruction TLB read misses. Unit: cpu_core]
> > >    l1-dcache-load-misses
> > >         [Level 1 data cache read misses. Unit: cpu_core]
> > >    l1-dcache-loads
> > >         [Level 1 data cache read accesses. Unit: cpu_core]
> > >    l1-dcache-stores
> > >         [Level 1 data cache write accesses. Unit: cpu_core]
> > >    l1-icache-load-misses
> > >         [Level 1 instruction cache read misses. Unit: cpu_core]
> > >    llc-load-misses
> > >         [Last level cache read misses. Unit: cpu_core]
> > >    llc-loads
> > >         [Last level cache read accesses. Unit: cpu_core]
> > >    llc-store-misses
> > >         [Last level cache write misses. Unit: cpu_core]
> > >    llc-stores
> > >         [Last level cache write accesses. Unit: cpu_core]
> > >    node-load-misses
> > >         [Local memory read misses. Unit: cpu_core]
> > >    node-loads
> > >         [Local memory read accesses. Unit: cpu_core]
> > > ```
> > >
> > > v6. Fix x86 hybrid mismatched number of evsels for the case a PMU is
> > >      specified. Add patches to make failures in the parse-events test
> > >      easier to diagnose. Reorder the perf stat default events patch t=
o
> > >      come earlier.
> > >
> > > v5. Add patch for retrying default events, fixing regression when
> > >      non-root and paranoid. Make cycles to cpu-cycles test event chan=
ge
> > >      (to avoid non-core ARM events) the default on all architectures
> > >      (suggested by Namhyung). Switch all non-test cases to specifying=
 a
> > >      PMU. Improvements to the parse-events test including core PMU
> > >      parsing support for architectures without a "cpu" PMU.
> > >      https://lore.kernel.org/lkml/20250923041844.400164-1-irogers@goo=
gle.com/
> > >
> > > v4: Fixes for matching hard coded metrics in stat-shadow. Make the
> > >      default "cycles" event string on ARM "cpu-cycles" which is the
> > >      same legacy event but avoids name collisions on ARM PMUs. To
> > >      support this, use evlist__new_default for the no command line
> > >      event case in `perf record` and `perf top`. Make
> > >      evlist__new_default only scan core PMUs.
> > >      https://lore.kernel.org/lkml/20250914181121.1952748-1-irogers@go=
ogle.com/#t
> > >
> > > v3: Deprecate the legacy cache events that aren't shown in the
> > >      previous perf list to avoid the perf list output being too verbo=
se.
> > >      https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@go=
ogle.com/
> > >
> >
> > Hi Ian,
> >
> > Did you drop the change to ignore failures to open events in favour of
> > switching the default from "cycles" to "cpu-cycles" instead? I'm trying
> > to follow the changelog but couldn't see it.
>
> Hi James,
>
> your example is using `perf stat` whilst the behavior to ignore
> failing to open events is for `perf record` and added in:
> https://lore.kernel.org/lkml/20250923223312.238185-6-irogers@google.com/
> Changing the behavior for `perf stat` hasn't been in scope for making
> the behavior of legacy events consistent in any patch series. The
> whole '<not counted>' vs '<not supported>' vs an early exit is
> something where not changing behavior has been the name of the game
> for many years due to potential reliance on the behavior.
>
> Fwiw, this series migrates legacy events to json we should be able to
> do the same with the legacy hard coded metrics in `perf stat` once it
> lands. Removing the hard coded metrics will give better metrics as we
> can use event groups, share events between metrics, .. and only
> display requested metrics when metrics are requested. My point is that
> there is further `perf stat` clean up that this work moves us toward
> but at 28 patches already I'd like not to start work on making perf
> stat a better place. Getting consensus on what that better place is
> given the existing fragmentic behavior will be a challenge, but at
> least these days we have some form of tests, albeit they tend to flake
> all the time. To solve your problems below where you're specifically
> picking an event that can wildcard, give the PMU or use cpu-cycles, or
> one of the many other names ARM already has to mean this. Overloading
> the event 'cycles' wasn't something introduced in this series and the
> fact changing the name hasn't happened in the drivers is really very
> frustrating.
>
> Thanks,
> Ian
>
>
> > In v3 I got <not supported> for the uncore cycles event, but in v6 I ge=
t
> > a complete failure:
> >
> >   -> sudo perf-v3 stat -e cycles -- true
> >
> >   Performance counter stats for 'true':
> >
> >             1732478      cycles
> >
> >     <not supported>      arm_cmn_0/cycles/
> >
> >
> >   -> sudo perf-v6 stat -e cycles -- true
> >   Error:
> >   Invalid event (cycles) in per-thread mode, enable system wide with '-
> >   a'.
> >
> > The verbose output shows that it tries both, but doesn't ignore the
> > error on arm_cmn_0 anymore:
> >
> > -> sudo perf-v6 stat -e cycles -vvv -- true
> > Control descriptor is not initialized
> > Opening: cycles
> > ------------------------------------------------------------
> > perf_event_attr:
> >    type                             0 (PERF_TYPE_HARDWARE)
> >    size                             136
> >    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >    sample_type                      IDENTIFIER
> >    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNI=
NG
> >    disabled                         1
> >    inherit                          1
> >    enable_on_exec                   1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 9646  cpu -1  group_fd -1  flags 0x8 =3D 3
> > Opening: cycles
> > ------------------------------------------------------------
> > perf_event_attr:
> >    type                             11 (arm_cmn_0)
> >    size                             136
> > Required parameter 'wp_dev_sel' not specified
> > Required parameter 'wp_dev_sel' not specified
> >    config                           0x3 (cycles)
> >    sample_type                      IDENTIFIER
> >    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNI=
NG
> >    disabled                         1
> >    inherit                          1
> >    enable_on_exec                   1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 9646  cpu 0  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -22
> > switching off exclude_guest for PMU arm_cmn_0
> > Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit,
> > falling back to no-inherit.
> > Warning:
> > cycles event is not supported by the kernel.
> > Error:
> > Invalid event (cycles) in per-thread mode, enable system wide with '-a'=
.

Re v3 vs v6:

v3 series here has no changes to perf stat:
https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/
the v6 does change perf stat in the "add_default_events" function:
https://lore.kernel.org/lkml/20250923223312.238185-5-irogers@google.com/
but you are reporting an issue with an event specified, so not using
default events. The evsel changes in v6 are for the evsel__match
function that isn't used during event opening.

Thanks,
Ian

> >
> > > v2: Additional details to the cover letter. Credit to Vince Weaver
> > >      added to the commit message for the event details. Additional
> > >      patches to clean up perf_pmu new_alias by removing an unused ter=
m
> > >      scanner argument and avoid stdio usage.
> > >      https://lore.kernel.org/lkml/20250828163225.3839073-1-irogers@go=
ogle.com/
> > >
> > > v1: https://lore.kernel.org/lkml/20250828064231.1762997-1-irogers@goo=
gle.com/
> > >
> > > Ian Rogers (28):
> > >    perf stat: Allow retry for default events
> > >    perf parse-events: Fix legacy cache events if event is duplicated =
in a
> > >      PMU
> > >    perf perf_api_probe: Avoid scanning all PMUs, try software PMU fir=
st
> > >    perf stat: Avoid wildcarding PMUs for default events
> > >    perf record: Skip don't fail for events that don't open
> > >    perf jevents: Support copying the source json files to OUTPUT
> > >    perf pmu: Don't eagerly parse event terms
> > >    perf parse-events: Remove unused FILE input argument to scanner
> > >    perf pmu: Use fd rather than FILE from new_alias
> > >    perf pmu: Factor term parsing into a perf_event_attr into a helper
> > >    perf parse-events: Add terms for legacy hardware and cache config
> > >      values
> > >    perf jevents: Add legacy json terms and default_core event table
> > >      helper
> > >    perf pmu: Add and use legacy_terms in alias information
> > >    perf jevents: Add legacy-hardware and legacy-cache json
> > >    perf print-events: Remove print_hwcache_events
> > >    perf print-events: Remove print_symbol_events
> > >    perf parse-events: Remove hard coded legacy hardware and cache par=
sing
> > >    perf record: Use evlist__new_default when no events specified
> > >    perf top: Use evlist__new_default when no events specified
> > >    perf evlist: Avoid scanning all PMUs for evlist__new_default
> > >    perf evsel: Improvements to __evsel__match
> > >    perf test parse-events: Use evsel__match for legacy events
> > >    perf test parse-events: Without a PMU use cpu-cycles rather than
> > >      cycles
> > >    perf test parse-events: Remove cpu PMU requirement
> > >    perf test: Switch cycles event to cpu-cycles
> > >    perf test: Clean up test_..config helpers
> > >    perf test parse-events: Add evlist test helper
> > >    perf test parse-events: Add evsel test helper
> > >
> > >   tools/perf/Makefile.perf                      |   21 +-
> > >   tools/perf/arch/x86/util/intel-pt.c           |    2 +-
> > >   tools/perf/builtin-list.c                     |   34 +-
> > >   tools/perf/builtin-record.c                   |   97 +-
> > >   tools/perf/builtin-stat.c                     |  171 +-
> > >   tools/perf/builtin-top.c                      |    8 +-
> > >   tools/perf/pmu-events/Build                   |   24 +-
> > >   .../arch/common/common/legacy-hardware.json   |   72 +
> > >   tools/perf/pmu-events/empty-pmu-events.c      | 2771 ++++++++++++++=
++-
> > >   tools/perf/pmu-events/jevents.py              |   32 +
> > >   tools/perf/pmu-events/make_legacy_cache.py    |  129 +
> > >   tools/perf/pmu-events/pmu-events.h            |    1 +
> > >   tools/perf/tests/code-reading.c               |    2 +-
> > >   tools/perf/tests/keep-tracking.c              |    2 +-
> > >   tools/perf/tests/parse-events.c               | 2010 ++++++------
> > >   tools/perf/tests/perf-time-to-tsc.c           |    4 +-
> > >   tools/perf/tests/pmu-events.c                 |   24 +-
> > >   tools/perf/tests/pmu.c                        |    3 +-
> > >   tools/perf/tests/switch-tracking.c            |    2 +-
> > >   tools/perf/util/evlist.c                      |   18 +-
> > >   tools/perf/util/evsel.c                       |   21 +-
> > >   tools/perf/util/parse-events.c                |  282 +-
> > >   tools/perf/util/parse-events.h                |   22 +-
> > >   tools/perf/util/parse-events.l                |   54 +-
> > >   tools/perf/util/parse-events.y                |  114 +-
> > >   tools/perf/util/perf_api_probe.c              |   27 +-
> > >   tools/perf/util/pmu.c                         |  309 +-
> > >   tools/perf/util/print-events.c                |  112 -
> > >   tools/perf/util/print-events.h                |    4 -
> > >   29 files changed, 4523 insertions(+), 1849 deletions(-)
> > >   create mode 100644 tools/perf/pmu-events/arch/common/common/legacy-=
hardware.json
> > >   create mode 100755 tools/perf/pmu-events/make_legacy_cache.py
> > >
> >

