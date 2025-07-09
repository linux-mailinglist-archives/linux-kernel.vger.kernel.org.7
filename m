Return-Path: <linux-kernel+bounces-724544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F92AFF41A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A6177810
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A2242D8D;
	Wed,  9 Jul 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9zOKqmu"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C672080C8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097505; cv=none; b=rj8jRSYDJl5Kp8RDDJHxdV+65V5dJLsdLZ5kgXXhN2kwOdGkVMwyM/CTtdJ6DHrB/MUN7gZG4idoVyrkDgsHhtvhD1PgRDe8XFe+IDur2qO/V+dYWQM3MDldx/fDBADxAYwxWRXySlDKIgEjhrKJWIAU+kgh6eb0iMPmfy5nsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097505; c=relaxed/simple;
	bh=01CE7K4ho1r55YJJxScMbaBt5qLzuHA3R4MFUcguS6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfOHGd/b61zlyG8ttEmeXCavqooDcpA+at50zTK+B1GXW6yI7+EJvSQQkzsXPP76h5AtjlVIHU1yZLotNhaMSAibsSiQ7HSWszJoCiIn8ty0YFFL9N/dzjGws96JqDw7ao66d2kJaXpt9wurOd0chzLzOngpLRUN752ZK0ti8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9zOKqmu; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so27975ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097503; x=1752702303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01CE7K4ho1r55YJJxScMbaBt5qLzuHA3R4MFUcguS6Q=;
        b=e9zOKqmuxujH8ZRJY2hFqqVGnoQ9ruCzy5vQHAz94w+CuInpJWCxyROAdSoKvdSxWO
         KnDilMxnnLYYzsz4ipYSSwg4Cf9klV3bL2H46lZNz4hid2WCLYgbs5YcFX5rBwh+MmaT
         6RBWhF9a89n6dWRg+ZUeWvGVvrhXjGXLjyvuKjTaawbPOVxTe32iacljTBic+LuyvN55
         lrFdO7UCvCKDYxRDp3uYss1XHfvwKYWU45yke42LkWfQsnsrY4uPqI25FA8u+lR/1ISz
         mjAi+W/eaKUmEbQImxdXf8ZudJ1BoAvL+h8yOZcw0D4mzpMZudnpxkRn8NX+Ok0RuYwB
         hU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097503; x=1752702303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01CE7K4ho1r55YJJxScMbaBt5qLzuHA3R4MFUcguS6Q=;
        b=GylZM6Uq5ykyzxZUYYSkgDXPO5jGeR/9H2DbJRFFv2gXt8cTDJh8gtk0DKJtqmXIFJ
         7Mc2I726KWatVuuJsEAtZ0SsDwKuvq9TR92JVhQcw+sTApCPpI6/UmyxG6NC9VVGRHSx
         R+xD+TMzKnP5mY8+y3Tan1yFZQ39t5ErHVMb9931vwhgYUAfJZ2YgVu+5rBPcipjI/3P
         b6k1nGP0e4lJfX3ZYbT3iPYRfXLxlNoXHLFQe4pDTPV46elTbFNtG2P2y9dAzBJnmhNq
         zphodZ0odG3wgDCASltuftNu6b9OpVoWMjBnMJNOnsmYRTMd94sJEGQL3gVJf2If2mzX
         ONQA==
X-Forwarded-Encrypted: i=1; AJvYcCWGrwdHjxB3ibHgPRoM1N/X9e0JCmA93mrzKB2Ngny+AvoAXRswHZlvU0tsXpBUL5Uu7h5IYHdwDBkfnKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywffbA8cBLvkYsV03Gz50ekZTpwTxkrtClytBw/msdUTZdXfqV
	mEJvVOk9/5MZSay1Oey2FCUS6iVpDXqwKoDTXGt5qHn+alwMxXMUNUEj/j+Fhs+elhXA+j7qsSu
	9yLmTGbvc0VyGbq0hiJtTq+znF/lUrI50uVtgQKug
X-Gm-Gg: ASbGncui/OPknu2wP33CPUy44wYp6ixmTOIvSuphyXdvukYTOotMK73UWFCS8Tdjs75
	YzMeN+0L8qnb7sqrbcjXQL2XC28hk3fk2oGzDK/ucBtW1bW5P4KtU8JNBUp/ZG7kJORKzWVkWet
	JohkpQtzQsCfWP3ebE92F5Pr7Dw/SYcP5w5GeaIBeaK32Z9HtEBbc0bh0JKXYUxAgXs49cHbl3c
	g==
X-Google-Smtp-Source: AGHT+IGDvj8bx1fUmHxUSGQwiRfqgJ6KJHVT7FwiSP+jXeC2yBdD2wVOmYrSlzEzt+sNBRZD1B3BeFp1DsOQ9W/wMMU=
X-Received: by 2002:a05:6e02:190c:b0:3dc:866b:e8b5 with SMTP id
 e9e14a558f8ab-3e24511ba21mr1237475ab.16.1752097502734; Wed, 09 Jul 2025
 14:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-5-blakejones@google.com> <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
 <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com>
In-Reply-To: <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Jul 2025 14:44:51 -0700
X-Gm-Features: Ac12FXxX2i29FTlYpzGRKLDLjekPcUXfK3HNPeuDfy_kcrXMjcag4_NirKBxz6g
Message-ID: <CAP-5=fWuU8Xhzvjx8FgQpOJCJXewOw9S3Vdm+aXYgw64bsq0UA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Blake Jones <blakejones@google.com>
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

On Wed, Jul 9, 2025 at 2:08=E2=80=AFPM Blake Jones <blakejones@google.com> =
wrote:
>
> On Wed, Jul 9, 2025 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> > > +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> > > @@ -0,0 +1,76 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > The 2nd line in a shell test script is taken to be the name of the test=
, so
> > ```
> > $ perf test list 108
> > 108: SPDX-License-Identifier: GPL-2.0
> > ```
> >
> > > +#
> > > +# BPF metadata collection test.
> >
> > This should be on line 2 instead.
>
> Oof, that sure wasn't on my radar. Should I do a followup patch, or is
> it not worth bothering?

The patch has been in perf-tools-next for a few weeks:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3Dedf2cadf01e8f2620af25b337d15ebc584911b46
so modifying it is probably not a good idea (it'd need a forced push
and break people downstream). If you could send a follow up, that'd be
great just so that we have >1 person in the
author/reviewer/signed-off-by tag!

Thanks,
Ian

