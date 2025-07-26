Return-Path: <linux-kernel+bounces-746553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E73B12815
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826D1AE27CB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFD7136672;
	Sat, 26 Jul 2025 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npZ2jchE"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988B7263B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490332; cv=none; b=dw6CE8pGpJz7Lfu6u7J/vfYCdjDJjG5t15AF59tOM294DSTCgfqLj6h2lhJIjO7SK9no9zlmKcWX5l8HHkpFrQKFuRL1oZx84rwclxk9Z/llx0ed0x96LL2vXGFtpz+W5MggtjvxH+9PFIWECfPpzWHYPgcGIkgZ93zJ8DAfIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490332; c=relaxed/simple;
	bh=mll6hie1Mq4ML6TC02FqupxP90YACegtxU9zsbi/7G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4qo4dUZ8WXyojHRgn/HzfZc8ztkghE2eHz3QgpTh23vmHjA1ye192QdZaqpblOCtTvIdoNU0HsEJIHg2R/s81lz8sJN3MZKz44qS/3MQslY4RNueqsIpsrfF6T00hQ8ePk3T2dHF2aVkCp0oo/+c5VbIuau3d26HOR3MWZ+uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npZ2jchE; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so41995ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490330; x=1754095130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuaIgcl3X75WSddj6wZ3RtTHs/R0aXfKanbVyofyYKE=;
        b=npZ2jchEfv7roAncRW/dVPrZhkfY0QLfws+sJoxF6R4+KJOAEIW1k7eYFUEPW3XiTo
         d2KOZiUmT9G670TAGXls/lT4LVkfVn1YeWBX+mviFhdfuJ988Oh52eR+LMEdIcXl1rz2
         2nEfw86r139JVMu1D74gL68kdOU3XI9DNq/Z2mGHW31rGNZQ1DguHNb1Wb0JjWVkaOpU
         qqO5ngHgg/JQvDyGrOyHsmFr2IQvnGTl+IRAURCu4o9PHD1ltWy+TlOGm0K4cycL7TtE
         0uZbn/i8vlNuQxc4S0RBOuoK25ABDn6EZmKE7KgZh+InLmlgojVcWhwYkC20cyL+igcd
         0Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490330; x=1754095130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuaIgcl3X75WSddj6wZ3RtTHs/R0aXfKanbVyofyYKE=;
        b=tax2+yNIKNttYDaqw/BmVwQj2IQ706az6zJj/BroYxhFDFpyhPHKN+7Qc0JFhPy1Wf
         41pXFK1fbEKVnUOs5q7028Y1exlXcJXACAHTkhPOgSnaoyxL2OGuZgRSB5r9p1o2YXaV
         S51SQ/Lb6hplYZO7AUsA4jXbEPYHJLAxa7yVDMoXI4Hb4OgEIAVD8AcqJ0SDBkRYRrXa
         CS5LLqDcjb99xyrdLVYnmRRcmZ38ZOLe+qKeuPk5aMChx2GurxBc2RZTPBKYcuibdsns
         n3ioA+LURcftyd877xVO5pgaUuUlWplQMldHzrcRkgcs/9Z921/Epr3QFSa9XOQyMMyt
         hWlw==
X-Forwarded-Encrypted: i=1; AJvYcCVT3cmh5RADclME/4a3p/DmO5PSfBSIfdqN80qrcildIwKHJgLz7s3j1JdCnBblSxfboFntHurREut/lTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBF8hkp0nyruEtpLXwd6yLfXRwpmcL8nn1vBU4WuenpZuDXISb
	BIufN1GXodO4lMd8LIENET54aw7+n4mSjlnVoTySNE6r1jjV7rwfsNzX/18Q8DpjPmUDVUEU54E
	lwS14i2sPr+JEeSHQFCKMG0BQiUNL3/HO+96Uk4Lw
X-Gm-Gg: ASbGnctM6XORsEXtQ6MTWg7Ixp+UAgkIiDGmLJuWf+Gw+qr6k/t4F3VKlD7S/YRFQwI
	SnRUjPiUy6crYr/MGNopKhrX+cBiNRLbOMAPwE1yNcWp09qT+oTMNxsiHULfhkJJqNJr187lbZp
	cT/abZhA888fKYk5heF4kpA2XTNTpfPVC8WUY5Zo1oJo0sTFxobnBGSNjDR5GRzmoYaa3NhIUIu
	iqDe2jB
X-Google-Smtp-Source: AGHT+IFcieGaCRG7qfo6dHfmveQH0ddmpCcwRQbPSCAVXEnpGEeO/2mR2nZI2zpfkodZKZpUR2nzXkY7Fh4BV30iGRk=
X-Received: by 2002:a05:6e02:1905:b0:3df:2dd7:19c6 with SMTP id
 e9e14a558f8ab-3e3cbe72ee9mr1586255ab.0.1753490329443; Fri, 25 Jul 2025
 17:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-8-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-8-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:38:37 -0700
X-Gm-Features: Ac12FXx7O2uk0I-ttFB0zfP3-JB9XNw3HvFCKpo66dV1x_lhYhlJ7ys-h8b_MX8
Message-ID: <CAP-5=fWH=KnJwO-LRgkYh4cBmY+9R4V+N=N7qa9XU0_xWRQqDg@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] perf annotate: Show warning when debuginfo is not available
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
> When user requests data-type annotation but no DWARF info is available,
> show a warning message about it.
>
>   Warning:
>   DWARF debuginfo not found.
>
>   Data-type in this DSO will not be displayed.
>   Please make sure to have debug information.
>
>   Press any key...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 17 +++++++++++++++++
>  tools/perf/util/dso.h             | 11 +++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index 4b059e0bafd33fcf..2a4db5bdcdb7e9d8 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -804,6 +804,20 @@ static int annotate__scnprintf_title(struct hists *h=
ists, char *bf, size_t size)
>         return printed;
>  }
>
> +static void annotate_browser__debuginfo_warning(struct annotate_browser =
*browser)
> +{
> +       struct map_symbol *ms =3D browser->b.priv;
> +       struct dso *dso =3D map__dso(ms->map);
> +
> +       if (browser->dbg =3D=3D NULL && annotate_opts.code_with_type &&
> +           !dso__debuginfo_warned(dso)) {
> +               ui__warning("DWARF debuginfo not found.\n\n"
> +                           "Data-type in this DSO will not be displayed.=
\n"
> +                           "Please make sure to have debug information."=
);
> +               dso__set_debuginfo_warned(dso);

If there is a dso__debuginfo then this could be encapsulated there, ie
the browser wouldn't need to change dso variables it'd just be a
property of calling dso__debuginfo.

Thanks,
Ian

> +       }
> +}
> +
>  static int annotate_browser__run(struct annotate_browser *browser,
>                                  struct evsel *evsel,
>                                  struct hist_browser_timer *hbt)
> @@ -834,6 +848,8 @@ static int annotate_browser__run(struct annotate_brow=
ser *browser,
>
>         annotation_br_cntr_abbr_list(&br_cntr_text, evsel, false);
>
> +       annotate_browser__debuginfo_warning(browser);
> +
>         while (1) {
>                 key =3D ui_browser__run(&browser->b, delay_secs);
>
> @@ -1028,6 +1044,7 @@ static int annotate_browser__run(struct annotate_br=
owser *browser,
>                         if (browser->dbg =3D=3D NULL)
>                                 browser->dbg =3D debuginfo__new(dso__long=
_name(map__dso(ms->map)));
>                         annotate_browser__show(&browser->b, title, help);
> +                       annotate_browser__debuginfo_warning(browser);
>                         continue;
>                 case K_LEFT:
>                 case '<':
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 3457d713d3c56df6..7df1673f08d3ddb4 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -299,6 +299,7 @@ DECLARE_RC_STRUCT(dso) {
>         u8               hit:1;
>         u8               annotate_warned:1;
>         u8               auxtrace_warned:1;
> +       u8               debuginfo_warned:1;
>         u8               short_name_allocated:1;
>         u8               long_name_allocated:1;
>         u8               is_64_bit:1;
> @@ -362,6 +363,16 @@ static inline void dso__set_annotate_warned(struct d=
so *dso)
>         RC_CHK_ACCESS(dso)->annotate_warned =3D 1;
>  }
>
> +static inline bool dso__debuginfo_warned(const struct dso *dso)
> +{
> +       return RC_CHK_ACCESS(dso)->debuginfo_warned;
> +}
> +
> +static inline void dso__set_debuginfo_warned(struct dso *dso)
> +{
> +       RC_CHK_ACCESS(dso)->debuginfo_warned =3D 1;
> +}
> +
>  static inline bool dso__auxtrace_warned(const struct dso *dso)
>  {
>         return RC_CHK_ACCESS(dso)->auxtrace_warned;
> --
> 2.50.1
>

