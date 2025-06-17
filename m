Return-Path: <linux-kernel+bounces-690935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E77ADDE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 23:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BC117E045
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 21:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F832F532E;
	Tue, 17 Jun 2025 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rimej2YY"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E982F5326
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195972; cv=none; b=pFVlZUHqjj6cIXa9zQmS5fDVBOWuzNFetydGsgx2dDJU5ZO8cG7H9vZIPOmGMXYxGYuS71RWrXSFZUMQ9DF6gDdG9rkffIkvt50bNa6qVlWA9io3nW+Doa9j9T6FBN7qD7YkQqYtfAxJcd9EipTFPYUnbzd+MX2FqrH2we4jSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195972; c=relaxed/simple;
	bh=+dQzldI3l+YCshnHKj8sBC4H5jm9nNWxJVIh0BFGxkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faf/xKP0el4fxIlLMkAcwaytLRYpBdJgWqTQfeMNCiaTygf0QqBu0sQ0Nzp/Yzu5yG76D3Pm7TkZU3XsnOI/4cUcfWrMACDdWj3ANCamNsPpJX4xs/T0zHAR+1X0ZCkAT+BomeGOzZVL0kiILelDosdMljU0b1Wfs8Nci+EisSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rimej2YY; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so58795ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750195970; x=1750800770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqdykBY7DVhypou87Iet/QJUaHzMEymD/U9IMKOWwOE=;
        b=rimej2YYc6+5o3NpzrMu41zhPUkx16iUL+UVHcQ9347wY/DunYiPOb/St3KaNVnpxR
         BGXrYvMvsQO9X4Nycq0BSjzl7ZY0wXJoasdjSL622lYmenafwzAKJeoOq8NIu2ZLNIvr
         VgMd7RdtYK0qcZx7sbts1cRIjpZq/wfrIb8QYFbeN9AodO0fFR2dQ7f/5wYNrr0MgKnd
         uq/OmTk2fAksHwa80tHfEs3e2G3L5aGcmYZ/FwYT0x8K8Kxr2jz+TL0qjsfxzFDbGeXP
         h7dIIDObiiIQFMsjEqWog7PEtxJbW1bY9ruauWW7vfwSlHYy+iwvRCTiKYiziY4y94zM
         Kzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195970; x=1750800770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqdykBY7DVhypou87Iet/QJUaHzMEymD/U9IMKOWwOE=;
        b=tv+FC8pH1cNbwcQmbt9v70LptfHVboboTyaIKjsjwefGrK+tmz9LCSfJFWe9myvfxT
         IY1MpXoRUZYrB9bO8QFC6ZRxiyoFpYZUVo1ir6uKwkddI5pS+JkNGju/Il5ptloZTHpE
         /EOjyxEIacX2FSjg9qYJv//0xQbja1g071eut5aa/7FPVazyitakJQwNZaH72f5MsZ2i
         UFxkdzIFWv01q0tnxZcHnjnafUz3EYkseV5/RG45MzTLj0838uA5xzCzVdxKu4fYhmhn
         qmi5kmAKuJIQZxfQ3+0Rf5ECbC5arIdNiXbsWE4L5nu0H2mvCCeRQE9H6XNv1lc8EVdA
         3bSg==
X-Forwarded-Encrypted: i=1; AJvYcCX8afKDdS94seqvxWDG9M6hmczjYjETH/IzOw9GsN7wVwPM1aBg7rrbOlIY0aI5P3Tj8IITeXgwxVjx0CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3259lNZMRhpsqTECWSWktfrOlPGts8abgHrKsoh3CkHPis0iO
	vfvq4IrqanXOcYBFRorb/8f6K5ic/cGXmfJUZQcnVU91pelIOpTkOMXrHle9iL4DLoQNxPdf6AV
	yBUYjA9ZDnHQ47EJNx9b24HpxQl3skuflftJdVA05
X-Gm-Gg: ASbGncuVhgt03plA6Bnf9echT83nIqydIv2xAj+3Nl+HBDRaMOgNviADVrNiSpHoBzK
	9FUTyjsPHNxAALMrAKwx8GiWR0xJ5GKkh6OtASmaGD5jYt9hWk1P51K+T2V91fJaFnHBP8BQ3Ki
	NhB6bdR0hhnBPi+9IlHRdxIPNNRLbMizAkbumaY3WZyqin2Oh/4gospJxhZ53Af0wGI0Rk3Cw=
X-Google-Smtp-Source: AGHT+IHvhlN3SYyM1bOGzAMaDqWq+K1HNaUusQt27G5eI5JxhZYTwQViUAEjkKqxw25bSKRAHNOSd8uHeKrKTYIMT3w=
X-Received: by 2002:a05:6e02:12cf:b0:3dd:a7f3:a229 with SMTP id
 e9e14a558f8ab-3de08d93a32mr12575725ab.4.1750195969918; Tue, 17 Jun 2025
 14:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614004108.1650988-1-irogers@google.com> <20250614004108.1650988-3-irogers@google.com>
 <CAH0uvojjfOcoZmxPL+bG5NEid8xcAVth7UxOUc=aYjgF5nqs2A@mail.gmail.com>
 <aFBF1ejZQBBvX7F4@x1> <aFHeY_-hVNKtXPAD@x1>
In-Reply-To: <aFHeY_-hVNKtXPAD@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Jun 2025 14:32:37 -0700
X-Gm-Features: AX0GCFvLgzyxJiUKqAwyHdPu599y1UdcRpyRohblD-xb4XhMdMjispr2JuhwpV8
Message-ID: <CAP-5=fWXQBdg8Uq1hFgRPC4z4vQAvUuT6TnUkPHSBfdGPNaYwg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] perf trace: Add missed freeing of ordered events
 and thread
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Andi Kleen <ak@linux.intel.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Jun 16, 2025 at 01:27:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jun 13, 2025 at 09:16:26PM -0700, Howard Chu wrote:
> > > TL;DR: (definitely lost: 5,248 bytes in 17 blocks, 3,586 bytes in 12
> > > blocks) -> (definitely lost: 4,992 bytes in 16 blocks, indirectly
> > > lost: 0 bytes in 0 blocks), the leak of thread__new() is fixed.
> > >
> > > Thank you so much for fixing this.
> > >
> > > On Fri, Jun 13, 2025 at 5:41=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > Caught by leak sanitizer running "perf trace BTF general tests".
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Acked-by: Howard Chu <howardchu95@gmail.com>
> >
> > Small enough, applied to perf-tools.
>
> root@number:~# perf trace -e *sleep ls
> anaconda-ks.cfg  bin  bla  commands  dtel  firefly  logind.conf  perf-ins=
tall.txt  python
> perf: Segmentation fault
> Obtained 11 stack frames.
> perf() [0x5c595e]
> perf() [0x5c59f9]
> /lib64/libc.so.6(+0x19c30) [0x7fd43ce27c30]
> perf() [0x5dc497]
> perf() [0x492d54]
> perf() [0x49860e]
> perf() [0x49890e]
> perf() [0x413413]
> /lib64/libc.so.6(+0x35f5) [0x7fd43ce115f5]
> /lib64/libc.so.6(__libc_start_main+0x88) [0x7fd43ce116a8]
> perf() [0x413a45]
> Segmentation fault (core dumped)
> root@number:~#

Thanks, I'll take a look to see if I can spot what's broken. Seeing
this stack trace makes me remember we haven't landed:
https://lore.kernel.org/lkml/20250611221521.722045-1-irogers@google.com/

Ian

> =E2=AC=A2 [acme@toolbx perf-tools]$ git bisect good
> e340815ea559052d8d590a145bab7d7105608e7d is the first bad commit
> commit e340815ea559052d8d590a145bab7d7105608e7d
> Author: Ian Rogers <irogers@google.com>
> Date:   Fri Jun 13 17:41:06 2025 -0700
>
>     perf trace: Add missed freeing of ordered events and thread
>
>     Caught by leak sanitizer running "perf trace BTF general tests".
>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Acked-by: Howard Chu <howardchu95@gmail.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Andi Kleen <ak@linux.intel.com>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Kan Liang <kan.liang@linux.intel.com>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Michael Petlan <mpetlan@redhat.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
>     Link: https://lore.kernel.org/r/20250614004108.1650988-3-irogers@goog=
le.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
>  tools/perf/builtin-trace.c | 2 ++
>  1 file changed, 2 insertions(+)
> =E2=AC=A2 [acme@toolbx perf-tools]$
>
> Removing it:
>
> root@number:~# perf trace -e *sleep sleep 1
>      0.000 (1000.057 ms): sleep/2693449 clock_nanosleep(rqtp: { .tv_sec: =
1, .tv_nsec: 0 }, rmtp: 0x7fffedc43ab0) =3D 0
> root@number:~#
>
> - Arnaldo

