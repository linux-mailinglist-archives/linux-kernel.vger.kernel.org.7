Return-Path: <linux-kernel+bounces-895999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD56C4F77D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7653BEA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31624285C96;
	Tue, 11 Nov 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3Tc09jC"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C28284894
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886330; cv=none; b=Kn4Q+3n2BHQz5Rj8xzloEmEzdSBJb+fGivRudkVgaIx0P0n1+aadFabayfv2nkIF0PMQkmHGZNIVxy9i7u8jezpf1lXNxLAAGCYrJVRlmaPUkO2mYg3kmtZSgLROH44gGRlcM8BXIhRSunQ5AidtKDtpk/DkQSZaCFpJURqG5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886330; c=relaxed/simple;
	bh=a8IowXK89YQn/Sj6N3263aqj0jOs5hKSImdrSc5DxAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSufvv38TbDkFX/nXDupVmcvEao7QNPC3+YiuPsdC8hqXi6wlqDIXvHZauVxqd1NGwHnnMI994bZFgpIfehEXoFbOMOl5dNYro//KJOPZ8+AWKEzArcOeau3mIVlwO9fQvM6ggUq+dyyfWKBb1abtU8N9PesZoEL3hTRgRYYg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3Tc09jC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2980343d9d1so11465ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762886328; x=1763491128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5BxiqIRkPwvooJsbFEa+kYwsukfLSbX1O1u/3khSRA=;
        b=l3Tc09jCxR1Rl71dHSZ84aYfL3mD90/Y7QGC9EOWquLaZ4SyCkrPRWB9aOP5kMm29g
         x5ZilGm4dwogsAAFHdwB2PncoiuITIlWyIliQLJ52SzRYx5eb8bOu/lFrowTKevRbteY
         aVKA84n8Sd+Zqvx08hygrclB+luWksmCv+XvOtG61MWH5qln1ltMGCuUxOVe7gN7oerJ
         g+YQdW5IOiOf9FCdsOe+pq6Er+dZoNrCtP3iRZTp33/NZz1lIoyYOcpBoFA/t0B08fN5
         UZ1I6m+1FQ7U/T62PkWT3hZQMGRMQxzX5+2r3C9PnnwZ4fiqMNGmr7EcNPReaAgpGDD3
         l26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886328; x=1763491128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+5BxiqIRkPwvooJsbFEa+kYwsukfLSbX1O1u/3khSRA=;
        b=e6nnsA7UkP7JCwxzIBSXJnQxb9dBY5E/ruG9aE57CCf6yciz046aDgI+yComVGBFrR
         rcSkg03dm2XHE4ekbR6EQkaM1/gZ1tfK+pf76vkcUJA5NlIphA3uAiCWGGMb9O49zii/
         ljsY8cGbKWfXpnLuP6Q+43WHPkRQyF25K2yP4tMH6cGiuMMhkW4GAcbLKM2TSyk/VLEm
         MO1X4g4fLbMab5zH4zF7A2KFMrwLXsjUZUafzjYLb6SySmrAhOzuUzmH1x3VIY7FcIB8
         f/kjN5zkjEJzzuobTwyy8rmj4iCCeGKRPCDP+o4qG3SPhwz2nOYDg7kNISY4FJ7PeLBL
         uREg==
X-Forwarded-Encrypted: i=1; AJvYcCVYWkxBrtTZGK13/WC7bvUZQlR144CVMszn6dc/hU5kn2Q2ZNHSA2BV/m+OiWX5NWrTdR4QqXJ2hMPp/Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdnP4xN3eaoJnRz2CFa4EEDIdn8U+qMd6Hdl8RE1J80m0JZNh+
	0tGhsdYVijHneZgriRn3EsA/VYaxC/cIOzX9s2KCaY39uk4yDjHB63geL3PiYnmQaiPfYjpO2Mr
	1503EBEdKElk/bEVMzmpB4V35/2wznMf/ElIjUF9/
X-Gm-Gg: ASbGncsarbb3P0EkxFHxLIpgZN1gW9R0LfpV6gRrw5uMuVO625juu7ybRLB1fvx6h+l
	Odt9YBXiy8mBnjuPYEje3KfGA05jxIramVKBEbjxIWMqq/DR5YeQaEjm5JHY0gljId2DGPwnMo0
	GrDLXJ82FKTYX2qx33h8VpPTC12Se0aUZ2ZHiRSEJe1pwhM16XexC/8CgebiN8bcIHYEZl58s77
	dGBw/Eve/ulTT5XYTtzgpR+rsDbwsFFczyPY387HNklQ5krb64SnzF4HxZ5IQ651ONZYt6IFxpA
	5Roj+QPBUWqiKb0/XwQ6DSAvdtAeSDXSNmcg
X-Google-Smtp-Source: AGHT+IFhjPob8WDqv+ZG/3+Iu1IYKjVBkIKdBVuYiZbmFHhcYO0IVOHuazFWFXxR7bWQI6HWJzzUeDyrWe4EoLBTGUA=
X-Received: by 2002:a17:902:c951:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-2984f827a37mr266585ad.6.1762886327463; Tue, 11 Nov 2025
 10:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com> <20251111040417.270945-4-irogers@google.com>
 <aRLZq4Po-1AJ8br4@google.com>
In-Reply-To: <aRLZq4Po-1AJ8br4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 10:38:35 -0800
X-Gm-Features: AWmQ_bkQlT3aFlo_rtdNu9ZIz2FplewCdeib5QUqLzK7Cpy5RfMduS_YwdFUih4
Message-ID: <CAP-5=fVWjjmQxj3OeHMG2qm9Oz0uGOXVpP2j82ZTMttQ5crJXg@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] perf jevents: Add set of common metrics based on
 default ones
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Nov 10, 2025 at 08:04:02PM -0800, Ian Rogers wrote:
> > Add support to getting a common set of metrics from a default
> > table. It simplifies the generation to add json metrics at the same
> > time. The metrics added are CPUs_utilized, cs_per_second,
> > migrations_per_second, page_faults_per_second, insn_per_cycle,
> > stalled_cycles_per_instruction, frontend_cycles_idle,
> > backend_cycles_idle, cycles_frequency, branch_frequency and
> > branch_miss_rate based on the shadow metric definitions.
> >
> > Following this change the default perf stat output on an alderlake look=
s like:
> > ```
> > $ perf stat -a -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >     28,165,735,434      cpu-clock                        #   27.973 CPU=
s utilized
> >             23,220      context-switches                 #  824.406 /se=
c
> >                833      cpu-migrations                   #   29.575 /se=
c
> >             35,293      page-faults                      #    1.253 K/s=
ec
> >        997,341,554      cpu_atom/instructions/           #    0.84  ins=
n per cycle              (35.63%)
> >     11,197,053,736      cpu_core/instructions/           #    1.97  ins=
n per cycle              (58.21%)
> >      1,184,871,493      cpu_atom/cycles/                 #    0.042 GHz=
                         (35.64%)
> >      5,676,692,769      cpu_core/cycles/                 #    0.202 GHz=
                         (58.22%)
> >        150,525,309      cpu_atom/branches/               #    5.344 M/s=
ec                       (42.80%)
> >      2,277,232,030      cpu_core/branches/               #   80.851 M/s=
ec                       (58.21%)
> >          5,248,575      cpu_atom/branch-misses/          #    3.49% of =
all branches             (42.82%)
> >         28,829,930      cpu_core/branch-misses/          #    1.27% of =
all branches             (58.22%)
> >                        (software)                 #    824.4 cs/sec  cs=
_per_second
> >              TopdownL1 (cpu_core)                 #     12.6 %  tma_bad=
_speculation
> >                                                   #     28.8 %  tma_fro=
ntend_bound       (66.57%)
> >              TopdownL1 (cpu_core)                 #     25.8 %  tma_bac=
kend_bound
> >                                                   #     32.8 %  tma_ret=
iring             (66.57%)
> >                        (software)                 #   1253.1 faults/sec=
  page_faults_per_second
> >                                                   #      0.0 GHz  cycle=
s_frequency       (42.80%)
> >                                                   #      0.2 GHz  cycle=
s_frequency       (74.92%)
> >              TopdownL1 (cpu_atom)                 #     22.3 %  tma_bad=
_speculation
> >                                                   #     17.2 %  tma_ret=
iring             (49.95%)
> >              TopdownL1 (cpu_atom)                 #     30.6 %  tma_bac=
kend_bound
> >                                                   #     29.8 %  tma_fro=
ntend_bound       (49.94%)
> >                        (cpu_atom)                 #      6.9 K/sec  bra=
nch_frequency     (42.89%)
> >                                                   #     80.5 K/sec  bra=
nch_frequency     (74.93%)
> >                                                   #     29.6 migrations=
/sec  migrations_per_second
> >                                                   #     28.0 CPUs  CPUs=
_utilized
> >                        (cpu_atom)                 #      0.8 instructio=
ns  insn_per_cycle  (42.91%)
> >                                                   #      2.0 instructio=
ns  insn_per_cycle  (75.14%)
> >                        (cpu_atom)                 #      3.8 %  branch_=
miss_rate         (35.75%)
> >                                                   #      1.2 %  branch_=
miss_rate         (66.86%)
> >
> >        1.007063529 seconds time elapsed
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../arch/common/common/metrics.json           |  86 +++++++++++++
> >  tools/perf/pmu-events/empty-pmu-events.c      | 115 +++++++++++++-----
> >  tools/perf/pmu-events/jevents.py              |  21 +++-
> >  tools/perf/pmu-events/pmu-events.h            |   1 +
> >  tools/perf/util/metricgroup.c                 |  31 +++--
> >  5 files changed, 212 insertions(+), 42 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.js=
on
> >
> > diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/to=
ols/perf/pmu-events/arch/common/common/metrics.json
> > new file mode 100644
> > index 000000000000..d1e37db18dc6
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/common/common/metrics.json
> > @@ -0,0 +1,86 @@
> > +[
> > +    {
> > +        "BriefDescription": "Average CPU utilization",
> > +        "MetricExpr": "(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ i=
f #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (durat=
ion_time * 1e9)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "CPUs_utilized",
> > +        "ScaleUnit": "1CPUs",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Context switches per CPU second",
> > +        "MetricExpr": "(software@context\\-switches\\,name\\=3Dcontext=
\\-switches@ * 1e9) / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "cs_per_second",
> > +        "ScaleUnit": "1cs/sec",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Process migrations to a new CPU per CPU s=
econd",
> > +        "MetricExpr": "(software@cpu\\-migrations\\,name\\=3Dcpu\\-mig=
rations@ * 1e9) / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_=
cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "migrations_per_second",
> > +        "ScaleUnit": "1migrations/sec",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Page faults per CPU second",
> > +        "MetricExpr": "(software@page\\-faults\\,name\\=3Dpage\\-fault=
s@ * 1e9) / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu el=
se software@task\\-clock\\,name\\=3Dtask\\-clock@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "page_faults_per_second",
> > +        "ScaleUnit": "1faults/sec",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Instructions Per Cycle",
> > +        "MetricExpr": "instructions / cpu\\-cycles",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "insn_per_cycle",
> > +        "MetricThreshold": "insn_per_cycle < 1",
> > +        "ScaleUnit": "1instructions"
> > +    },
> > +    {
> > +        "BriefDescription": "Max front or backend stalls per instructi=
on",
> > +        "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycl=
es\\-backend) / instructions",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "stalled_cycles_per_instruction"
> > +    },
> > +    {
> > +        "BriefDescription": "Frontend stalls per cycle",
> > +        "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "frontend_cycles_idle",
> > +        "MetricThreshold": "frontend_cycles_idle > 0.1"
> > +    },
> > +    {
> > +        "BriefDescription": "Backend stalls per cycle",
> > +        "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "backend_cycles_idle",
> > +        "MetricThreshold": "backend_cycles_idle > 0.2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles per CPU second",
> > +        "MetricExpr": "cpu\\-cycles / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "cycles_frequency",
> > +        "ScaleUnit": "1GHz",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Branches per CPU second",
> > +        "MetricExpr": "branches / (software@cpu\\-clock\\,name\\=3Dcpu=
\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock=
@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "branch_frequency",
> > +        "ScaleUnit": "1000K/sec",
>
> We talked it should be 1000M/sec, right?

Thanks! Will fix in v4 - I thought this was fixed in v2, but I must
have missed it.

Ian

