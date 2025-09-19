Return-Path: <linux-kernel+bounces-825263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9620B8B725
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 351F17AB70F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565D22BE7AA;
	Fri, 19 Sep 2025 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPzEreIy"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8C2C21D8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319869; cv=none; b=uVVkjx5OmKibaavTvC4VwZAUzAhQCX9rEfakL9PutW+hzFISNsCvBgPjRQWXtbtA1oEzDJaiue/Z1yY5Nldb2llw8XPI4vKBNthklE1FWaQE3z8AHuDxr40nGD3wX4SzX76yliRQ1GmgLI0/1XERL+RfPHljA9jWBOQIDE4fNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319869; c=relaxed/simple;
	bh=w3oJMiMy/aLfHezdZGx/BpfVJ2MO14O0I8TbLPG1uS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upR7hClPwhg2aycNTwG8de3FBOYyGTwRuucbGkx0Wh8nXE5u1l7NR77Fg41/G/8L6x/3ytqeNKqWmDufH0DfTP2vsJ9Oa+6SYphmEe8wqLUlNPBUxWUlpd/CL0d4ideRjuAKz6jIkU4g/496pEloP98DKJybUyHddxd6mu5STH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPzEreIy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-267c90c426dso22945ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319867; x=1758924667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX4JHkNOYAmPpt72XdQ/NCCC4rGEcC8ljrTMPvj15/8=;
        b=XPzEreIy18lK7so8IsZyKT9XCMHe8JLN/rE4zTKylXqg1lcKJsdEiGYGvulmu7SoKT
         G/YOtmlCbmKibM55luMDeusqj54iXpubl34KCavaRLEooHgA5oztlYzPKPH829Ou2wX8
         lWFTnjWnzF6YCYhQPOuuXsFmdMZ9/9zndcqXS6GkOM1aUtNwT6OygDWDNP1hGDmcnGXa
         GFlFtd7ecjIIPzcsnZebKmxbtYGy9LLdJbTeOVOkYFG8iXPmV/sle2XY4qT80sOfG+Ho
         GyzuMNFjTj/LHG9AyAg8Hca3m3mQurCHBiGkmMF3Q5Z4lEtp2hQheo43YBVu/zbFB1c6
         WpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319867; x=1758924667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX4JHkNOYAmPpt72XdQ/NCCC4rGEcC8ljrTMPvj15/8=;
        b=nFBY9ql08H08W88WFBf85qS2QVdfVoCzSH4yGJfbUqdBaewHYsk5qIKAYj4pzN1JWt
         wzGm6plu/5+w9M8mZQBR/0Cbn5JZvZB1HoBc0bYrH3aD7qmIy9AO5MtOp19xRUqZ0hMh
         FOV2uW3mukWbyweTIJUDkx++MV0fdCHPwnljOO4f7EqVbZvMYat0cJgfmIQOMAKLgSx1
         XO4+e0yLVlErkca5XdHsLs/3bOOGgi3okybAIsFBINGJ9LbFjrR8aPN41fdXfLTaop9J
         Izk/bInICvrtZSSP19YVP+FCsOCwPVXf1onC2ZkXYYPy25goapEwMjKvMx9TmBPd/5vA
         Dvbg==
X-Forwarded-Encrypted: i=1; AJvYcCVkLTwZtJRX9v1uUl89gbMXsfrgil5o6oDgZAQkIgYbHzpFW62GKbnsw4ptnmRyBBww5VsdyXT35fmipVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXAHU9iux3bMQDJKLU+oLSIp7+Y9Hq5Ir7fNCgxnRZUMDAB1I
	NDTAa8l8oc5slNZ2LBI8mPh9tD6L/Sg1kfC97m/pBZPcZoosU+mTlm3SjB6Ud8uabQbCKsK+jJP
	tM5NCeJagKrEYXk14F1Alp2agb5ZSymSOKE4HcYNs
X-Gm-Gg: ASbGncsTkj6fnEIwmh/L7ccLgTRfdPHbcojRcR/4PKMNm36bNIi2Ap6ikZClNhCUJdL
	98ceQkUiliHBMEJe8aQzh1sqyTWGZyTGq2LWyunFoWZ3ezhEbcRY3zYUBb2UH23HsZpC4QSfOd1
	4LqARcGzij2huOjUde7lt4pVExD2cqLXZCzq9LvHO4RmHO9RgU6DYp6XA+uY3mt3wxRLUe/SEcx
	svMQsgb
X-Google-Smtp-Source: AGHT+IF/XR6LN5y4L+t7CKVYTAqBZoNs51oFnPwlGtIk3O6dMLUK9rU8e8/WIsxecWYhSWgoXJllAjBjq2aRcxX2H7g=
X-Received: by 2002:a17:903:8cc:b0:268:cc5:5e44 with SMTP id
 d9443c01a7336-2680cc56199mr15292315ad.6.1758319867269; Fri, 19 Sep 2025
 15:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919210654.317656-1-acme@kernel.org> <aM3SCGOXZsP3GZal@google.com>
In-Reply-To: <aM3SCGOXZsP3GZal@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Sep 2025 15:10:55 -0700
X-Gm-Features: AS18NWBEtBFiKxbXwIB2OP1ZK_tima4hdB102zVpZWyZu-THdQ6NV1-Ttk8CJ_E
Message-ID: <CAP-5=fX6=7Ycp=Su2ahZS1R0wS9s4eozPPcBgMBG25UCaC6uBA@mail.gmail.com>
Subject: Re: [PATCH 0/2] LIBBPF_DYNAMIC=1 fixes
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Sep 19, 2025 at 06:06:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi,
> >
> >       Please take a look, noticed after processing a patch from Ian
> > for another such issue, on a hurry now, haven't checked when that
> > emit_string was introduced.

emit_strings was added in Linux v6.17 and libbpf was tagged as version
1.7 prior to that.

Thanks,
Ian

> >
> > - Arnaldo
> >
> > Arnaldo Carvalho de Melo (2):
> >   perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
> >   perf bpf: Check libbpf version to use
> >     btf_dump_type_data_opts.emit_strings
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
> >
> >  tools/perf/util/bpf-event.c  | 2 ++
> >  tools/perf/util/bpf-filter.c | 5 +----
> >  tools/perf/util/bpf-utils.h  | 5 +++++
> >  3 files changed, 8 insertions(+), 4 deletions(-)
> >
> > --
> > 2.51.0
> >

