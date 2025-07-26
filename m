Return-Path: <linux-kernel+bounces-746552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B47B1280F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4891CC7992
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A213790B;
	Sat, 26 Jul 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Lie0Dgo"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69084126C1E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490101; cv=none; b=iTItAN80e8prnNfFPf3M3EBV7gH6sW3twWIV4lRGT4PvMwIRy40q2fbapIdYBn17vF/+FwtwTmv6YNpkiBA3YoLKHRKGYpmYV9ec5vPXXtZArOgKRweYjHrmzjwDzrFjsIa0JUTWArVTfpGzuBhhnn2DkvwQNBP0uZp3WpBXARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490101; c=relaxed/simple;
	bh=CEMeBZezoOjzuH4XZ0JSOAau1ciA8YndvA6qZcE0mw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEfc0Io1dWjfnaHEro+ufCFwV3yFP5ZLpr8XdY41XBa5lGEgQkKnVT/cVA2VWIZOJz8FjfMJq1+CwlcQRtHSyN9BSirU+1P530ufMchB0xw6ZWqlPOwEBm+vFhZim1bJ/QsV5lSmopuTJZNNb7b/INbNRW/ZNmSIeZHuJe7Ftfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Lie0Dgo; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e283b2d065so44145ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490099; x=1754094899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZPCpsnOFMzo8Dy5wKM/rmboR8jCseogtU4sWxCBrbc=;
        b=3Lie0DgondpI9jSHwdx8kgY11y5kBQFqU9xLhd6wEdwXL1cx3DDIsh4fCaH6EOlAgx
         +cowVhB+ahHmv/oUQZ4P/+geexZH83C5YyKafDjD06g7nK1AT6nZXcIyRcn+doS46XFI
         DEkT/51Xh22+1tkau+OjnD8VsP4vxui56weJjS4lW7yVdrsEcD2I6DVRj3V4rqg87kKl
         5EHNyHjv9BUuU+QKJ+9pnhrJs1Qvww714shTTMJb3WhiXkXevJeVp8TFgHOxSFJqac4T
         dt/rdJOTnEFqgpBuBgfplbnnhdFAzN+Q92tZLLjN6ei34m+RvXoyBQt1dpx2h0Mw3XgF
         2egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490099; x=1754094899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZPCpsnOFMzo8Dy5wKM/rmboR8jCseogtU4sWxCBrbc=;
        b=oltpObjrNK9jNkY+/SQ2pJjFFrlOoZi/lRxVTBWS2M37CJwpLm1WqdKbvvvnxtVWlv
         H7By25+sK3A0iRIBhNHc6GW9yLOPDnRmog/wX7yoQH3Px727nMBzY7rLjAFbXB0M9CSS
         Gdg0AaV47JY19EXaKndzTMesHgVlyGZAmEaKJsCbCLm03vbuvaSRW7uWjgfQtMDGSPzz
         p/WQ/wP8aIWpEEeo25xfJjqSiiVwb5vPs2p6dZ/dymWNSOxlPzOnI06q6XvCeG3fcjqS
         D7goZUu/5UdnIY0TSrw//k2drKlamn2jIlG/tfJNY+vAM9Zvm8BmIULGmCU8nf0eTWyT
         vllw==
X-Forwarded-Encrypted: i=1; AJvYcCVHQEApqSyva01Z6rtPUUVwEU3r4D3D5biZusU2c6RD9yWbJZ2MtuCBBd9M9NKfCQ8QL4LN5CuK0Q/fbDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4svQUVnMGZfchx+MwEvkXjkkUYR9mGPWIhPmrYSnRL56JrR60
	t8pOJWeLbacMFDo3TEMpiZVJRA+ZcEa9CSsOAw6FCa1Xgl7LSHs4a9brU4CegIsYj7lCSKN9y8i
	l5lKD2LoO3HtfLmS1mV3Hst5VS+QCf54aO/EKW0gd
X-Gm-Gg: ASbGncuIOLnOO9gT738ms3tcYUKsIp7f0fovgEq/Ls2hgkbJlLhmC8swQ6rrR0mtJ6B
	s9MQRYkMPcz3gR6zs50Fx+S2PrnsgU6PCPsEBz7sty+SE4zstXwd7hr0GOO3WGVb6pZ6YyYtD5q
	o8gTcFj0rhs2h61qVD/BkeKkkk+NxZQyiy4DumzhwyqNIdLRX32Lv4LhwEZsOcXuGcvMPy2JzOc
	jPtILKr
X-Google-Smtp-Source: AGHT+IFP/+PLw/W7PC5xdHYXpvVc7MsNmqcrVmuoK0wFuNmDMht3hAFpkSertLVeZn69lRiXAthCkoCVShx5VL3fM74=
X-Received: by 2002:a92:c24e:0:b0:3e2:86d2:fed6 with SMTP id
 e9e14a558f8ab-3e3cce953b7mr803435ab.21.1753490099216; Fri, 25 Jul 2025
 17:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-7-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-7-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:34:47 -0700
X-Gm-Features: Ac12FXxWrsAPv-GxYhX7HwrLIGTvf8k6Uj4evVlKPj9FmmNbbIUDtXzDMsCfWU0
Message-ID: <CAP-5=fUZk4Fvo+E88C+o4TCyBsZCAGNwbpi5XMWX0ttbgAA00A@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] perf annotate: Add 'T' hot key to toggle data type display
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Support data type display with a key press so that users can toggle the
> output dynamically on TUI.  Also display "[Type]" in the title line if
> it's enabled.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index cdee1969f3131a7c..4b059e0bafd33fcf 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -525,9 +525,10 @@ static void ui_browser__init_asm_mode(struct ui_brow=
ser *browser)
>  static int sym_title(struct symbol *sym, struct map *map, char *title,
>                      size_t sz, int percent_type)
>  {
> -       return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name,
> +       return snprintf(title, sz, "%s  %s [Percent: %s] %s", sym->name,
>                         dso__long_name(map__dso(map)),
> -                       percent_type_str(percent_type));
> +                       percent_type_str(percent_type),
> +                       annotate_opts.code_with_type ? "[Type]" : "");
>  }
>
>  /*
> @@ -901,7 +902,8 @@ static int annotate_browser__run(struct annotate_brow=
ser *browser,
>                 "b             Toggle percent base [period/hits]\n"
>                 "B             Branch counter abbr list (Optional)\n"
>                 "?             Search string backwards\n"
> -               "f             Toggle showing offsets to full address\n")=
;
> +               "f             Toggle showing offsets to full address\n"
> +               "T             Toggle data type display\n");
>                         continue;
>                 case 'r':
>                         script_browse(NULL, NULL);
> @@ -1021,6 +1023,12 @@ static int annotate_browser__run(struct annotate_b=
rowser *browser,
>                 case 'f':
>                         annotation__toggle_full_addr(notes, ms);
>                         continue;
> +               case 'T':
> +                       annotate_opts.code_with_type ^=3D 1;
> +                       if (browser->dbg =3D=3D NULL)
> +                               browser->dbg =3D debuginfo__new(dso__long=
_name(map__dso(ms->map)));

browser->dbg =3D dso__debuginfo(map__dso(ms->map));

There was a conversation about dso not necessarily having to have
long_name in the future, etc.

Thanks,
Ian

> +                       annotate_browser__show(&browser->b, title, help);
> +                       continue;
>                 case K_LEFT:
>                 case '<':
>                 case '>':
> @@ -1115,8 +1123,7 @@ int __hist_entry__tui_annotate(struct hist_entry *h=
e, struct map_symbol *ms,
>
>         ret =3D annotate_browser__run(&browser, evsel, hbt);
>
> -       if (annotate_opts.code_with_type)
> -               debuginfo__delete(browser.dbg);
> +       debuginfo__delete(browser.dbg);
>         if (not_annotated && !notes->src->tried_source)
>                 annotated_source__purge(notes->src);
>
> --
> 2.50.1
>

