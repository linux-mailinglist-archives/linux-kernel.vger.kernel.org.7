Return-Path: <linux-kernel+bounces-878505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8CC20D74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCA0A4EDB57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D8C281531;
	Thu, 30 Oct 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRKZQ3uk"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6C635975
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836896; cv=none; b=kA8C4+iAQluGphagEK4cNjUGmH+7PMYkwaOvo+6Th0Yi54A4Ez60DG9pyk9IAsOEPhxosocaj9frTOXuZr4STvhudZ6yNyE6dV9rDFcpRoWTYGefs03H5m8fZ6DxcGjCvGYvkBBH2/mynO6LL42nqlsBRlK6uAKelYQm/Fyxe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836896; c=relaxed/simple;
	bh=w09wSAyKXW3qBD6pcz9lGlMTHirxjNuyqDGC+xjvZWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9fE5udHLbbHMTBrxNqC5D3uWpse/LjnqoPkfLET94yUB1AF4nlNwR9hgdxT1vXGbFYs0WKQK8xHviwvsWbYvAi861o0jUZWCs4EL3kr1yzkhu+J+sYlGJPFOMnN7wWG5khQfdu6SV8v2HqAPVNoJr0J3M6J+6RxV5yIKMPP1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRKZQ3uk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eeafd4882so196165ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761836894; x=1762441694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtgDL4CNzIRWFeWdzUwa9l0ZhfF8MlQxcBiXG+FT3wM=;
        b=KRKZQ3uk9burkfqxgBqW5bGLF9KBYd1hgljl4LFOykYrhfmyyDVOWHdH7xsJ6bFwY1
         /GuER+YBOfQKWAfOYiwrP3OkRze5Jtnc64fWiV5MOx5vgAqGvbPIMpvLFh7aNMRjGMNH
         TU8XBvrXSMXrxAnF6TBqoP1hy/IU26mY7DqmfEM5+wAAagafwsdyYLtc8V4xOvPSMqpn
         mcmnb6puRMT87Bt7eLcC9jx29HFoQkcN2gB0JBiK9D8zF3slEXumxUTEOANqKHrFckbh
         zQO/e+zPQ2/VSN1l4tlDitf2zU13+GgCP5cpC0l/cC0d2lAGEQuBE2uRblddc71nf70j
         ObEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836894; x=1762441694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtgDL4CNzIRWFeWdzUwa9l0ZhfF8MlQxcBiXG+FT3wM=;
        b=r00QJmkkITgqaktPbBVTAkBR4EajM/AsxucfJw/jf0WVfNCCOTnDBe3QhLx8iLvN70
         fv6Pm0xmWqgc0Fs96tB6CYBm41BUNr773zKKdfzhx8Zs9ntNNOuT8nS25P7IUwbGjg2d
         BdHUDLaiGXBAVidETPirEbZ6ME5/y+kEtWHzwL8JEY8qlJRvNdfEqC0A+zWBmeopgEcY
         6W8Grd+KJRw1e+h6CwEPlZrepsXWe2WyhyUtKc8hJorOgs8on9JuLgjRthr5lC3QkCy/
         ItBwqk5WhCJQClWocm7T8UzXga0QSIk2susSL9SdnNxQdObYamCuYxZ+xUx+Z2wLzFD9
         YiuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvFWIZL5ZXE1tpzoErz8OrYXv0vyjmpubrYEEE97YQK4FlkluzLTK7tjpCw6vh3a9TFHmKtxC8E/5DdRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2bPwqirBL0qqYz6kiiXbIvu/jpTj1Nd4rjQjhhEe39kczxQoa
	oPSHX1Niq6dlmSu/INue9BBQlOiMAsW8ryUinA53k5ShgZ2jhn4IBH2I0ANKnjo9Wpy51SRxY52
	aaiCj6hjN7lyU+W/BNdwQTI2ijEdZ9PAWVT5Q1pnAOslmXBFW3tBbH59WCmE=
X-Gm-Gg: ASbGncsMr4Wonj9VC5flbMIuyD3Yb9JuzxFsF9lvT9HlFqIpSlhch+cjXBvzpWjqgS0
	PDtjShuXsMfDpnyfnUEoxZEtgcGvV+Wrlg+rXbAz5jMrB600k/4xcYb7t9zWsWXVqly/EzeaPAo
	WSpctvCJsEWuHDZO9Zv2B5xSc8dA7CWK2gxwp++GZjI3tSsyPJNh04n2gZflzkQCZcw1gXqDnrf
	LI7cJYwAMouLpsEE40bzvfwxpK2vD6PycdsblTrxP6Abum50qaciofNIdJWFs6mjJB7zfr9/H5P
	yl2QrFrcyiyqt1U=
X-Google-Smtp-Source: AGHT+IFigT5X65ypvqb7uJDHxLvHz+Pz9Zc6xIoSJ0A8R/77e4JiyI3k+FWsZr+FCoJ0cb8ItFvdlcAVhU60h7DWiDs=
X-Received: by 2002:a17:903:189:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-294ee38bca0mr5466275ad.6.1761836893656; Thu, 30 Oct 2025
 08:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029222638.816100-1-irogers@google.com> <aQL70qlYohRT7cT8@google.com>
In-Reply-To: <aQL70qlYohRT7cT8@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Oct 2025 08:08:02 -0700
X-Gm-Features: AWmQ_bkg9LolVxgNEq3vV2njLdXKB6-BbL1B0cR15fquDCMb7mdBNgL9i5BdA20
Message-ID: <CAP-5=fU1pJ_7ewrxwCLUu_OkjZ2Z_bSzkaZxREG8uKnwop6JYw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf pmu: Make pmu_alias_terms weak again
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Wed, Oct 29, 2025 at 03:26:37PM -0700, Ian Rogers wrote:
> > The terms for a json event should be weak so they don't override
> > command line options.
>
> Can you please give an example command line and the error?

Sure, it is also covered in the test.

Before:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   200003
 { sample_period, sample_freq }   2000003
 { sample_period, sample_freq }   1000
```

After:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
```

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Fixes: 84bae3af20d0 ("perf pmu: Don't eagerly parse event terms")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index d597263fab4f..f14f2a12d061 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -802,6 +802,7 @@ static int pmu_aliases_parse_eager(struct perf_pmu =
*pmu, int sysfs_fd)
> >  static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_h=
ead *terms)
> >  {
> >       struct parse_events_terms alias_terms;
> > +     struct parse_events_term *term;
> >       int ret;
> >
> >       parse_events_terms__init(&alias_terms);
> > @@ -812,6 +813,13 @@ static int pmu_alias_terms(struct perf_pmu_alias *=
alias, struct list_head *terms
> >               parse_events_terms__exit(&alias_terms);
> >               return ret;
> >       }
> > +     list_for_each_entry(term, &alias_terms.terms, list) {
> > +             /*
> > +              * Weak terms don't override command line options,
> > +              * which we don't want for implicit terms in aliases.
> > +              */
> > +             term->weak =3D true;
> > +     }
> >       list_splice_init(&alias_terms.terms, terms);
> >       parse_events_terms__exit(&alias_terms);
> >       return 0;
> > --
> > 2.51.1.851.g4ebd6896fd-goog
> >

