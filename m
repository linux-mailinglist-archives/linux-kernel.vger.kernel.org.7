Return-Path: <linux-kernel+bounces-811072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C9B523ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3F9175CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33291311C27;
	Wed, 10 Sep 2025 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4yZzaBp"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86E3101A2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541499; cv=none; b=j3XvjOKsSneX/GhD649GgONgIATwxH8bdZ6LHLIij7f6zrk8x/NOQd77Lh0U1WuArrrWr7TOJhHrTKw0fcGrrVZmqBdt+mPojCi9UsECmAGZ/Az8WAnCNtVVELfHCJj9AT12Lm9GmgL06RMBh6N5pkL3ki4R24kfEUqieeXQGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541499; c=relaxed/simple;
	bh=j7pl9XXhdsCQAwARPPrGx688mBvn56VXJjv7N3QOlEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE9ZLZjIonPTSYfuk5/qQBGLiVhQO56PlgmGqdfmuCdYZEQoBgUGyktfbxebPr0dV90GECO/VKMp6rjLUKT9kAUOXHLGAZBIgbSSkJMNQ8mYj2aGuwpbNSqOTEF1C/ZHowgymT+xWXaK+/iCSkusNXNZiojaABLMVR6MdB057oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4yZzaBp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24b2d018f92so31955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757541497; x=1758146297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNdDRzKVh+fbCQLnYIIu8p5ojZ83V5zU4hVRTP5bI5Y=;
        b=Y4yZzaBpOucQ71O6Dd6TdaXSX7RnV7VzhYexY89HZRhEweXy0ZZtPFNAGTabtjIwK7
         pr40abNSFuWmF7yzbpxzDl6gby3u/a3dc/y8FmGbJX5EmtOBp8y/A9nQPN0qASrwgkZw
         jilALEIT/BQlsgyO6zbpUOansF0I69p66XMX7keKXyqjFnrnxK0XiCUjuQDqkGuD08pu
         M/3DM7Xvn+wfBm5WfljPZLZoalu8bx02Y7v9V/fIp4Cr3h5I5M4olWDei3/EWOB3nLTQ
         uzfKPg6iz2OIgWVwiiVfSG+Pwq79/i0vZpb7bbGigBDkUPChijCDM51v0LLx/+zqf+qv
         92uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757541497; x=1758146297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNdDRzKVh+fbCQLnYIIu8p5ojZ83V5zU4hVRTP5bI5Y=;
        b=H7H4BLDiU9PN1L6MaFmaNR0XLOu/vTAOkf12nU17xRtGZnxY7HgZgs2sps/FqERKva
         qgNtD3x6E9Wp7htdUWp+BvLHfdTiSbkzf9sWS7+Z8QwFTCu8v9Cwmh8qmIEkoMRltEEq
         auOMLq2L0WSmuiz6ItY54gdn+q/piG4mF7r5s9h+QT+PoG3EDrbgZQYPAH9o1nbQRagA
         SsXH3/rws+VN6jI1ft7pYTFGx9P4/dBD6YBmO4hALaVhxRLj+wujfDPkxp/OYtr9IJL9
         ZdLoGzbYkwBl+D+HRWlc1spH3DB859v2H8b8PbbHSmn9IAEfLMvpPZLrFovemX8+m6//
         LHKg==
X-Forwarded-Encrypted: i=1; AJvYcCV3/44DGCZKwqMGFXExqrSH6Nnk2r9nMiaP09vW0WHbsOrYoN5g90TjsMYQgbUtbLZpjfoObiVMlle+uxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFnbUY4yb6h67b4ypD3emaJXzapHwDVSJah5hI6i8oVXTficU
	Iek/Tp9UMwicPHUONJBd/102MaUg78cjwOzb5wOml+fg4jzJ6ZkKMah90j2H+MBTF2pMS6FwKom
	oJ+AJS4tqp3N6o3PKCu8Kk26KW+2c8Wn9kYnb5h66
X-Gm-Gg: ASbGncu1Z1ATAnjU0YjC5yEpUGNDrwYGZFGN8glfXGARKfMWs6Ln1Gpm7ABBvo9311m
	9JLiLiO8TxW7c3uvuDwmKK+fSiAC2rcTEblXAO/2RkIBIr1++OdbaKIwij3bw7UJoHA3f4bEn/9
	aDglG6GB1avHtbhREZimMX7rGFewDSyj0JAgPFJ/0i7gDPvXBUAdZvaEBOuglxGbgLcHAWL8Q2Y
	AJADsz1oT01sU3rUEprc9v+jecVqqvKue7PdY/nudhk
X-Google-Smtp-Source: AGHT+IEH6cRYjS/H4UkebncduhV5SqeLugTSt+pUOgu5WRqiICr3JjsSOdXXMEsz+rjxO5AscA4visSN2D+r+MgsGDs=
X-Received: by 2002:a17:903:1a67:b0:249:2f1e:5d0c with SMTP id
 d9443c01a7336-25a7eafc3d9mr5940505ad.7.1757541497060; Wed, 10 Sep 2025
 14:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com> <aMHbIGRFeQlq9ABx@google.com>
In-Reply-To: <aMHbIGRFeQlq9ABx@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Sep 2025 14:58:05 -0700
X-Gm-Features: Ac12FXweAPm2rEaL-lypGqnYe4BTRKYfusZ0zI1g_R5qT3kAjhqD0e1kQf6qMoc
Message-ID: <CAP-5=fXN5oe7tLCnuBnoYKm68GhuMXP00AjszRyPc_XpDkacxQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> A nit.  Can we have one actual event and an alias of it?
>
> I think 'branch-instructions' will be the actual event and 'branches'
> will be the alias.  Then the description will be like
>
>   branch-instructions
>       [Retired branch instructions.  Unit: cpu_atom]
>   ...
>
>   branches
>       [This event is an alias of branch-instructions.]
>
> The same goes to 'cycles' and 'cpu-cycles'.

Similar 'cs' and 'context-switches' in
tools/perf/pmu-events/arch/common/common/software.json.

So there are a few different ways to do this:

1) In perf list detect two events have the same encoding and list them toge=
ther.
2) In the json have a new aliases list then either:
2.1) gets expanded in jevents.py as part of the build,
2.2) passes into the pmu-events.c and the C code is updated to use an
alias list associated with each event.

Option (1) will have something like quadratic complexity, but a fast
perf list isn't a particular goal I've heard of.
Option (2.2) will mean the existing binary searches for events will
become a binary search for an event and then linear searches through
the aliases. To make this not a slowdown we'd likely need more lookup
tables to avoid the linear searches.
Option (2.1) feels the most plausible. I was hoping the json and the
sysfs layout would kind of match, this would be true after the
jevents.py expands the aliases. This option is already kind of already
done in the legacy cache case as the
tools/perf/pmu-events/make_legacy_cache.py is making this. We'd still
need option (1) with this.

Anyway, I'm not sure these downsides are countered by a slightly
smaller hardware.json and software.json, or maybe we should just go
with option 1 if the perf list output is all you care about. Let me
know if you see a different way of making it happen. I don't think the
vendors will be particularly happy for their upstream formats to
change given other tools will rely on them.

Thanks,
Ian

