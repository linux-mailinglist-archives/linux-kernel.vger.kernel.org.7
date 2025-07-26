Return-Path: <linux-kernel+bounces-746556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A2B12834
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FABF3AD65A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6073D1547CC;
	Sat, 26 Jul 2025 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvfJPXFb"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEB129E6E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490533; cv=none; b=ubmFw4mAF81o815vSr1dbf/Dg8X+b3TvrVW7WuzKsYrXsdTxLsuWplC0nYigstBQ7SkeJyNHlgwI3Fk6mBJlFPFx2yFcpWO0LnHICRBA/FMAxfXF4g4TykMGYK2vKPkcjF7uyNK9kdfsfbIn5Ub0Uoxg7Dv/2fSwJEAbBy4X+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490533; c=relaxed/simple;
	bh=i2KMGB5jXlYrZOEVyEEtlYkBMWkUvJBvYvMLMWjqryY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVcDYr9P4zcjpl+MoPYsBBOwqi7I3lRqso1r+V9FCYsOPhGHnHPoIuMYpncmBmwAukuIxKo5Vzt2AXY19A1VJDz8siVmaR8v8DmvVHasOSEz4CSi/B2TdIXoBai/2TSTSQg8PoXWJg07jpmAsy58yR9oI1SxerkvicQvIb4y0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvfJPXFb; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-87f161d449dso1724536241.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490531; x=1754095331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2KMGB5jXlYrZOEVyEEtlYkBMWkUvJBvYvMLMWjqryY=;
        b=EvfJPXFb+WTFp+kudxv6YHLf0TPkAJgThkffhKdWGbmjz30u3nn9Zduz8zDqdlAlOM
         j84jklBeCiSyQDNfKpHoY5KNobAq6ly+8cqJzhXgfvrDLMLhOd5Q5uKfRcYjfGDNgRZz
         ogAL316jEF7qhlCIN0GxRdmjwnvYEup+IgHiRL5ctFSsMTZL6akOHKtSdMMO4JJiCdIV
         TvRPGEx/yWQS5hFrEuaWpx/B5s5KwO9XHoz3ODbAkAPDR5f8SRt3NE8Jincs43nR3SAU
         WYSMBjATDMryH65U06Fb6gbmMPWUSEXJolRVXv+99OhwGwr47TCESyJEYVYy555ouxuH
         U7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490531; x=1754095331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2KMGB5jXlYrZOEVyEEtlYkBMWkUvJBvYvMLMWjqryY=;
        b=lFvxfs+tv2O4K3JOp1j6pRu9Oe5YApR9cjrtLQfO963xQaDp150OOre6tsVQOHgPY0
         6ae5UL87fSPt7377KVkmXZN7xSJIyGy9btZfgK0n6BoJvkGi1Z9IZ68XgzCrAASPby6O
         6CIkgQ2h6lFELqsHkEWcAxVzkV4N9y4Ec7nfipSKr0rFBrhCTGAMniITZ8ljHWPF0HoN
         X/l2gC3Muv5d10YU/pQX3McOOwmi2u9kezDyrtYsVvNTAVM1loHWmZJ3qo9telBPvJ9p
         vqWMyQYyVXdLUdkO+60RoewIrQdrawB9dB+266QBvkkKdPmRnnMzIObiINLAtborVNrG
         APdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwZ9OM/nNQUIzmrVDG6I4IRrxCz+XEjGxytKgEHDqms55Sr78qfNyjQoE1feYUi2fxchOckET7oKfthsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBuH9RJpGduh0AIE6whSmF/QgCAHvRQnvhdIeqBkwILW5cN3W
	Uqv7yHbyxOQA0wl0+Or5WWE/XxpRDOCgv/nm8QD4K2ZbdbfdSpPbR5ib3Uq1fqxPkqSVLwSOTGp
	5yZ09zLtVYqGEv95/JTOk3DZekbsuuNOcX01orYs9
X-Gm-Gg: ASbGncvzY1ti4kpQ280avikhqYFUiaE22aQWR6SAahK78YXijLUosRix22zt+SqP4fQ
	d0t+DpXQVS0sbzVw9eGn2Pga6MNOJIuTrSuvlxA34GuGaJ1kjWJtnTqU+qUl5Znkew9zBUwRKMS
	jIofFKIzF1ntUvAYDd1MjqF+8SCq/Uk2GRSqKthCQOq3MBJpbxxVXIwzeRbENHECtt0vOIFeebl
	TrnXj0=
X-Google-Smtp-Source: AGHT+IHrA3GZZD0wwju8aMv9Qz7fcPczk9FABOxxb3E5ADsq04AqPwLpKjr7JRvL4/0iuqFoC974FPIiSp+z8XfswSE=
X-Received: by 2002:a05:6102:8087:b0:4e9:c652:6a1e with SMTP id
 ada2fe7eead31-4fa3fa67872mr2000007137.3.1753490530877; Fri, 25 Jul 2025
 17:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-5-blakejones@google.com> <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
 <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com> <CAP-5=fWuU8Xhzvjx8FgQpOJCJXewOw9S3Vdm+aXYgw64bsq0UA@mail.gmail.com>
In-Reply-To: <CAP-5=fWuU8Xhzvjx8FgQpOJCJXewOw9S3Vdm+aXYgw64bsq0UA@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Fri, 25 Jul 2025 17:41:59 -0700
X-Gm-Features: Ac12FXz0LtMLKb3jLJLRjLCQ4NRMLoH85zHPh6h6oQV6X5PeOP12nXzMnjePzzA
Message-ID: <CAP_z_CjEzaPo=V+rzyDWFgnnHfNGAe_jHm7g=++V72GPs1A-fw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just sent https://lore.kernel.org/linux-perf-users/20250726004023.3466563=
-1-blakejones@google.com/T/#u
to address this issue. Sorry for the delay.

On Wed, Jul 9, 2025 at 2:45=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Jul 9, 2025 at 2:08=E2=80=AFPM Blake Jones <blakejones@google.com=
> wrote:
> >
> > On Wed, Jul 9, 2025 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > > > +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> > > > @@ -0,0 +1,76 @@
> > > > +#!/bin/sh
> > > > +# SPDX-License-Identifier: GPL-2.0
> > >
> > > The 2nd line in a shell test script is taken to be the name of the te=
st, so
> > > ```
> > > $ perf test list 108
> > > 108: SPDX-License-Identifier: GPL-2.0
> > > ```
> > >
> > > > +#
> > > > +# BPF metadata collection test.
> > >
> > > This should be on line 2 instead.
> >
> > Oof, that sure wasn't on my radar. Should I do a followup patch, or is
> > it not worth bothering?
>
> The patch has been in perf-tools-next for a few weeks:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/?h=3Dperf-tools-next&id=3Dedf2cadf01e8f2620af25b337d15ebc584911b=
46
> so modifying it is probably not a good idea (it'd need a forced push
> and break people downstream). If you could send a follow up, that'd be
> great just so that we have >1 person in the
> author/reviewer/signed-off-by tag!
>
> Thanks,
> Ian

