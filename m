Return-Path: <linux-kernel+bounces-821646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8865B81D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB34A3134
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D7F2264C0;
	Wed, 17 Sep 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mor+XBOY"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244682D94BA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142819; cv=none; b=ETu4p3E2lELLOJmo3Z40YU81RMCUglBIbre5SFmzFt4FrsefDy7Wf910FdyBiKnWkcBTkBk9sy/Jf2qSXA9q9AMmxxKAXzGHY388YoPxHc5i7s2sqCdQ5hM++g4U/qI3TbRsdWjCPpFtLTL+JRrhb2scAiTeBcAFgYISNmtXbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142819; c=relaxed/simple;
	bh=zfNwRSC2hr7WCZH/kgeNDGErdjsYMrY6wYew19pfj/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pY8v43aweKiMRy5/ESaWHnsAmzLwCIJ33cYjkbmamTlItmIMM9X78kDrgKbKGIOCuwIc3TvcTPaRq+uaaETV/gbwUhfj1xOlgryLZXwbtXXIfccL6S6MW7tsN0CbQuSxZLrMeDE6+HD3O6kIgDyDWIahx/ChYAKHRw6uQXq32SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mor+XBOY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so197661a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758142816; x=1758747616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INe0qCQ3tlR6kgjMSNcBEMbA+zEE3o+6uOpu7E7tB7A=;
        b=Mor+XBOY9ptXGAQYQ69WKjP5lE61BTq6w4HiJOTu4SAIgI/DrtBu2CYSJvbjjaJsEy
         fbUkSYLhJBwP0IiHmSB9WDJ4IySD3M6ZSp+OrfceZZNmFHtLyuJKNCFSzaOPnWdwfKgp
         UejpEJVkqqRc4tmXXPnawkDbbirUAT0vuRz3Jq8rap6gvCPdA/HiAACac73nQ7ktcHoQ
         Pn6mJrF9xye5Aa8yk3z06fUkWXcBVi5ZVw/hrNNF6csCsy5DiIE/cgpugQxb+pzcJcsq
         Pa+Zx2CKBKN58pYej6FaC6gvV12HBrBqaN+zTKl212F1AHnVqHNA5y3YXX/tPrHMYDr2
         /Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142816; x=1758747616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INe0qCQ3tlR6kgjMSNcBEMbA+zEE3o+6uOpu7E7tB7A=;
        b=Hn+FVRc0oAlwoolFWs8EKmt1vMp2sl5jJebSr6c6e13cTjols/xGf+S65NtJOH2D+V
         HtTrRs7B613fPo8NGUn7qJU+wTPyiRAnEHBcqJMY+oCGQfukmRKzS6DtfGEtNEVA7z27
         9/xKByEXVwwyUouPjaM7lvnTMpo/6PY3bv8UDouRdCiGASnN883i0Al8AxxviUwEUXCO
         t3roV/HgTFEqqEzG6lH3EjUwZpPoP5ThdWtOkUdV2+2JzYxIJ9sQO4RmM970AM5eR+oR
         xxNuoanIdtsYW+mw57qZenc7+vVqUWv62431QM6IfY+cRZowJouXTDdxVBQnw1McR20T
         3oWg==
X-Forwarded-Encrypted: i=1; AJvYcCX19d6MBynzrZj3hSnL71DnyXCVvhNvx4ZSCacdZGTBBkJzAMatyuG1j3Q0U+rKxDrtwiYNjIrcPWPhnC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHaThLWK/Jl04lWLFjQm27Oz575bIm+kvxxRd+iTIZDNiQuqOP
	41l326WVYR4PMe6++OzoQGnEySBDaXikTa8q0gx56l/t0kOjpd1ErN5Tnz9uZQ6GcXQwAL01Lme
	yTVd0NMjC1e091NRVZyOTv3a7+sq/td8=
X-Gm-Gg: ASbGncuOZiNI1sp6H0h7Zp7EvkD4Bd2hS0Dh3RK5vI0VGs5q+kSUCIvfo+u0Yv8Icmh
	MO378VVTM0n1QlLEHsxJraw1COxdDr3Y9X6KGAetzBfYXO6T9Z1nBBsuwRkxxdeoOMfkcPd0eDQ
	q+e5PdVlV3C7h3m9F3UHclqsCs3+hKoVIilvEvwl9CNoc9KnWkfVn0yeNOurBcHtpqyAO6pI70R
	62KBRp3RvEUoWx4NmitR41QIIDOI4+zlQ==
X-Google-Smtp-Source: AGHT+IFxq1VQtFeyA1l57OVybXGRuDi6kUk+l9dv55Nhpk548RUa508nI9pnyps23QBuJ7V4FJmn8X0y7r+Cqs2vcks=
X-Received: by 2002:a17:90b:2787:b0:32e:749d:fcc3 with SMTP id
 98e67ed59e1d1-32ee3ec58bdmr3963627a91.1.1758142816375; Wed, 17 Sep 2025
 14:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917034732.1185429-1-chen.dylane@linux.dev>
 <20250917034732.1185429-2-chen.dylane@linux.dev> <523d8d6c-de99-435f-a01b-1bac72810d53@kernel.org>
In-Reply-To: <523d8d6c-de99-435f-a01b-1bac72810d53@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 14:00:04 -0700
X-Gm-Features: AS18NWCB_PJ_0Rz6o0xAh3-HjaWH7SpgF3ns55lingyjoH0ZWTa0WmVtZ8959vk
Message-ID: <CAEf4BzY3CiVLce-pB9yevsUqFZexbno+AX1j4mGYN1G+JVO+pA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpftool: Fix UAF in get_delegate_value
To: Quentin Monnet <qmo@kernel.org>
Cc: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:30=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2025-09-17 11:47 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> > The return value ret pointer is pointing opts_copy, but opts_copy
> > gets freed in get_delegate_value before return, fix this by free
> > the mntent->mnt_opts strdup memory after show delegate value.
> >
> > Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >  tools/bpf/bpftool/token.c | 75 +++++++++++++++++----------------------
> >  1 file changed, 33 insertions(+), 42 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> > index 82b829e44c8..05bc76c7276 100644
> > --- a/tools/bpf/bpftool/token.c
> > +++ b/tools/bpf/bpftool/token.c
> > @@ -28,15 +28,14 @@ static bool has_delegate_options(const char *mnt_op=
s)
> >              strstr(mnt_ops, "delegate_attachs");
> >  }
> >
> > -static char *get_delegate_value(const char *opts, const char *key)
> > +static char *get_delegate_value(char *opts, const char *key)
> >  {
> >       char *token, *rest, *ret =3D NULL;
> > -     char *opts_copy =3D strdup(opts);
> >
> > -     if (!opts_copy)
> > +     if (!opts)
> >               return NULL;
> >
> > -     for (token =3D strtok_r(opts_copy, ",", &rest); token;
> > +     for (token =3D strtok_r(opts, ",", &rest); token;
> >                       token =3D strtok_r(NULL, ",", &rest)) {
> >               if (strncmp(token, key, strlen(key)) =3D=3D 0 &&
> >                   token[strlen(key)] =3D=3D '=3D') {
> > @@ -44,24 +43,19 @@ static char *get_delegate_value(const char *opts, c=
onst char *key)
> >                       break;
> >               }
> >       }
> > -     free(opts_copy);
> >
> >       return ret;
> >  }
> >
> > -static void print_items_per_line(const char *input, int items_per_line=
)
> > +static void print_items_per_line(char *input, int items_per_line)
> >  {
> > -     char *str, *rest, *strs;
> > +     char *str, *rest;
> >       int cnt =3D 0;
> >
> >       if (!input)
> >               return;
> >
> > -     strs =3D strdup(input);
> > -     if (!strs)
> > -             return;
> > -
> > -     for (str =3D strtok_r(strs, ":", &rest); str;
> > +     for (str =3D strtok_r(input, ":", &rest); str;
> >                       str =3D strtok_r(NULL, ":", &rest)) {
> >               if (cnt % items_per_line =3D=3D 0)
> >                       printf("\n\t  ");
> > @@ -69,38 +63,39 @@ static void print_items_per_line(const char *input,=
 int items_per_line)
> >               printf("%-20s", str);
> >               cnt++;
> >       }
> > -
> > -     free(strs);
> >  }
> >
> > +#define PRINT_DELEGATE_OPT(opt_name) do {            \
> > +     char *opts, *value;                             \
> > +     opts =3D strdup(mntent->mnt_opts);                \
> > +     value =3D get_delegate_value(opts, opt_name);     \
> > +     print_items_per_line(value, ITEMS_PER_LINE);    \
> > +     free(opts);                                     \
> > +} while (0)
>
>
> Thanks! The fix looks OK to me, but why do you need to have
> PRINT_DELEGATE_OPT*() as macros? Can't you just use functions instead?

right, function or just a loop, that will allow to also avoid
repeating jsonw_name or printf calls:

struct { const char *header, key; } sets =3D {
    {"allowed_cmds", "delegate_cmds"},
    {"allowed_maps", "delegate_maps"},
    ...
};

for (i =3D 0; i < ARRAY_SIZE(sets); i++) {
    ... use sets[i].header and sets[i].key ...
}

pw-bot: cr

>
> Quentin

