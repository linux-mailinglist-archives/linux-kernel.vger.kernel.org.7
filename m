Return-Path: <linux-kernel+bounces-895907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34A2C4F3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772F6189D103
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60263393DE9;
	Tue, 11 Nov 2025 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8H6e6lj"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABE30AAD2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881840; cv=none; b=rHWFUIroP9UicBEzsPbje60MLF5vLRNpc00qW0L5cuB0MmvKT05Rug5tzERKvO9a+Rc8MW4+mrgEHpTawiVug5bnSKmmYI4gG9wqs1bznBJmRAJtBIZ1hxbf9tSHjEu7Jrhf7Od3aIaid9juowcinvYj9vDUUwmgscuN8RfeC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881840; c=relaxed/simple;
	bh=lNVhfpf7d9Am5nP/Z6axMns1abjlSd9ejEvIxT++ytE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLIBNUVEMUqXXqmfl84L5jdnfktNRWdU++Uc0Ey4VeVS7AG5kUWD2zdCr7q6/2QrVNjAh2Zlz3sC+jWFBd7PSyAKMzLCX+Icfn7uz2r0K6YFFIJQGJ99oabZ0CYoF5kBbkzWJSP3qsw8A3yYrnm8DHezHEiitcqvfI6gZBk73ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8H6e6lj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2959197b68eso218425ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762881838; x=1763486638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAJ6YVpNkf2Gv0KJsuCdOmMqxzHI2QJkBtyUEfA5t0w=;
        b=g8H6e6ljnK0CtyU0Sd7V+GKUOXlmjxjCRRZHdJmERg96MSxJhqLmF9LTE6abe7SouA
         v2Pk4ok1Thw5pU7x0ECVyoYu5RZTp5krkzbvgoU5mdlgCKEGecwIDBh6WT7iDZYd4Jp9
         uFL2wmrUOqqyzZ+60PktuIhnzFsTSOZWW9E3Hu4PyJXW21IepHEL1BB6KLGLT4NNP0Nl
         hAl3WNWEd7ngoOUjUX0CMUbN9bJzh2q0rwtsQaZtMHr/MtyP9XXhHKlRgufZVKBPwbZf
         9lDMFxfPBBLr2fT55kfeG7UYVI75Oq5C5MMvuOIXrva3SAzT/1G1FRPJTfzjwIsfv/mI
         iBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881838; x=1763486638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAJ6YVpNkf2Gv0KJsuCdOmMqxzHI2QJkBtyUEfA5t0w=;
        b=AZv/Fh57CMR9Mv0hxpwXJZAflyIXCHme2W7XqHNpv/fiFTpkrk6mfY8CcR1hS2wcPp
         Mtcs5/zZOjId+D4kxq9YIIwaKC7NOakMplv1v+g/nGx+gjEBoMNRtHRQo5ffB+D5N4ve
         CE2HVg347DZRWh7fMXws9ytivgKaDge3ie8un90JSnbCiJeeZ3Dy0jOyChtly5Q2ASJw
         etAnj0++qjLfhj3QtA3SMFKlpREoOO9zNNN/nBfaTrevn3Wrn5NANAgVthbr8p3HElSc
         c79XXmsIlD4TtOlFe+kr7p0MPyvbPjqB+JK2tJv7Nsp6WrFPAVJ8ztN3j9X06iYjTIr6
         vWfg==
X-Forwarded-Encrypted: i=1; AJvYcCVF1DTOcIGef2jxPNIBwWW4zTQzTU+3N9qmSmv9cZrfT87Vhnq8W5FvCCgT/2D+CZk2lpc0zhYJV/kza+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JlSFmyEU1TRSGjwRMlyFPP7LommTAMgs5KL65vBDC0Bc4qI0
	GKxXc9L5rNOdolpysdS7Xq+78IhJvHgfvSA4g0+dp5ZWLFn671R0R52cr7Kli21QupLxTMkRG6m
	PgeqJvizPQfNWrb1Q84HM7kRJtBWV13NLkhJS8F+T
X-Gm-Gg: ASbGncvD9HDiXNT84VOmzhpURy0Bh+cKzAKbUKRVeQDy/mJdk6gg8G/N21F2HCyiG67
	HlxaIUeTK4zYsw32kKVTamyoG+FIaoQ8zHiSs5R6Vw6canf9TrjrNoaAgSSqAVp5PwgtHer7TOU
	RlXR5ncitZm7E7Za8IGCduXvdIlySah2qxUBlP5nN3FeHTMNn4yKmEP0afpBb8Z4J8soPsLq1RY
	vdA0mSFeNv2Br7OKbcVT2VBG+tSczhSaDOWjL0mHfDcJgj7xE1ZewY4e8ZJtKFyUMlfQbpXsidN
	SaufKVZrHL/yP/1g7QZpMvCy5ejBYST55KCI
X-Google-Smtp-Source: AGHT+IGuFQvCfN89aPDS0sVSoP5Nq4dis3KF3F0tOG94P0T2IRt07auDm0fMSJVtFZLEu6Ig+HM9CePrYJF3TYZAAiY=
X-Received: by 2002:a17:902:ecd2:b0:297:f2a0:e564 with SMTP id
 d9443c01a7336-29842837055mr5796675ad.11.1762881838255; Tue, 11 Nov 2025
 09:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com> <20251111040417.270945-8-irogers@google.com>
 <aRLfiZ4MCBZJGUlz@google.com>
In-Reply-To: <aRLfiZ4MCBZJGUlz@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 09:23:47 -0800
X-Gm-Features: AWmQ_bnE9FmnEietrY6UBXCBQKGBm6YnoiJVoV6A1hURllOC36DLI6RysXCPv6Y
Message-ID: <CAP-5=fVJu=ke1415KQ2V_o7XpSwFwpGYRFrx=34D8Ze_vxKiVg@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] perf stat: Remove hard coded shadow metrics
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

On Mon, Nov 10, 2025 at 11:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Nov 10, 2025 at 08:04:06PM -0800, Ian Rogers wrote:
> > Now that the metrics are encoded in common json the hard coded
> > printing means the metrics are shown twice. Remove the hard coded
> > version.
> >
> > This means that when specifying events, and those events correspond to
> > a hard coded metric, the metric will no longer be displayed. The
> > metric will be displayed if the metric is requested. Due to the adhoc
> > printing in the previous approach it was often found frustrating, the
> > new approach avoids this.
> >
> > The default perf stat output on an alderlake now looks like:
> > ```
> > $ perf stat -a -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >              7,932      context-switches                 #    281.7 cs/=
sec  cs_per_second
> >              TopdownL1 (cpu_core)                 #     10.3 %  tma_bad=
_speculation
> >                                                   #     17.3 %  tma_fro=
ntend_bound
> >              TopdownL1 (cpu_core)                 #     37.3 %  tma_bac=
kend_bound
> >                                                   #     35.2 %  tma_ret=
iring
> >              5,901      page-faults                      #    209.5 fau=
lts/sec  page_faults_per_second
> >        418,955,116      cpu_atom/cpu-cycles/             #      0.0 GHz=
  cycles_frequency       (49.77%)
> >      1,113,933,476      cpu_core/cpu-cycles/             #      0.0 GHz=
  cycles_frequency
> >                                                   #     14.6 %  tma_bad=
_speculation
> >                                                   #      8.5 %  tma_ret=
iring             (50.17%)
> >                                                   #     41.8 %  tma_bac=
kend_bound
> >                                                   #     35.1 %  tma_fro=
ntend_bound       (50.31%)
>
> I'd like to merge the alignment fix for this.
>
> https://lore.kernel.org/r/20251106072834.1750880-1-namhyung@kernel.org

I'm happy with that fix but if merges before these changes then I need
to rewrite all my commit messages :-) Not a big deal, I'll add my tag.

> >         32,196,918      cpu_atom/branches/               #      1.1 K/s=
ec  branch_frequency     (60.24%)
> >        445,404,717      cpu_core/branches/               #     15.8 K/s=
ec  branch_frequency
> >                235      cpu-migrations                   #      8.3 mig=
rations/sec  migrations_per_second
> >     28,160,951,165      cpu-clock                        #     28.0 CPU=
s  CPUs_utilized
> >        382,285,763      cpu_atom/cpu-cycles/             #      0.4 ins=
tructions  insn_per_cycle  (60.18%)
> >      1,114,029,255      cpu_core/cpu-cycles/             #      2.3 ins=
tructions  insn_per_cycle
> >          1,768,727      cpu_atom/branches-misses/        #      6.5 %  =
branch_miss_rate         (49.68%)
> >          4,505,904      cpu_core/branches-misses/        #      1.0 %  =
branch_miss_rate
> >
> >        1.007137632 seconds time elapsed
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-script.c    |   1 -
> >  tools/perf/util/stat-display.c |   4 +-
> >  tools/perf/util/stat-shadow.c  | 392 +--------------------------------
> >  tools/perf/util/stat.h         |   2 +-
> >  4 files changed, 6 insertions(+), 393 deletions(-)
>
> Nice work!

Thanks,
Ian

> Thanks,
> Namhyung

