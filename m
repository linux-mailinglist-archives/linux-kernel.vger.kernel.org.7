Return-Path: <linux-kernel+bounces-746545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD6B127F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADE8AA7F2A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50B3BBC9;
	Sat, 26 Jul 2025 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHYH3eSz"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF202E41E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489396; cv=none; b=F44xbh+WGEjHjKCE0Gjmm3SE88ESqTXt2vyrYMx1zsLWd05a9gzFknuYj3Lv+IpJpxebPOq4w3/1+yCdXTuv7b4nXN3j6r4nhqlE4h+xXt/xSI7hDBlIb9ved+tT+L3Pu8hH9rfOvQDyZcHZNV7jkQ0kl5GkX8VKTINtQ0mrPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489396; c=relaxed/simple;
	bh=7HW9OdzIt5E/11kvgXft6L23nySmEGJ0+NkdDQ3foLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWVetIbMUfjyJN2d722IbEY343Sj40WtvSZ3RT6NH19d1CB5FXeaXiomaP/rXhhV0+6tTVAVEEICxIY/EdkD3l2omj0atdpZ3GtyA8jr0uAJS4vqnIAyyFYTotIM0bOaGYKvK5oksZWx+4ny2gn8x9ZrknPJm7XJZ9FrapANQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHYH3eSz; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df371e1d29so48295ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753489394; x=1754094194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE2zFD1Hhoqv4r2nk0n1vcwd3vzLaNQ+m4wr9qfWXqE=;
        b=gHYH3eSzlrR3k4ftpD1a9JGPGgyhTx0Y4Y581ZoF8LyRLkzHTJLtBA9mQjnNqslaNR
         BjOUPPkGlPaqfOAG1nvYourmlTTbkF16DHD4qcCOIL/telQ5XKtq9BkL94Nr1cDdFnDW
         /eLEavjTvC8/saul9istgZORbMJcwSnSpZiMohtgIeeZ9qXPdqrxOfLSazMT1l6M1rQo
         xVk78frz3vI56cwX76q43726bRWVFCddZrmm7f8cVM6NOulQAn5JegdxsiHG9JNo3tKl
         quQQNOGz6GIZqVa2ihRIGG2AUqZqiM0pV7WXBkQFF+wFDJfbhv4c8sIDCbE2KQr+JGR5
         WJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753489394; x=1754094194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE2zFD1Hhoqv4r2nk0n1vcwd3vzLaNQ+m4wr9qfWXqE=;
        b=nD2jTmukOhEDvFDMQQiVzIOB7kctBUmVhylYCqiEiCW65NFE8mnhxjdWilgJBcl2Yw
         BDIdmReSxfCucNDyb2aQiVa0HSqo7BG1mLqviw5sARrZac41pYE26ENvZyPB3SOwA8r6
         5JsTRdNe+R0bPm1FKfDt7qbj9gywCofxuZUHMLeGODP8aWhcFZN+YTzi/9GKDeegnC5K
         TNTZjWdv1p7SehHXqgDvr6pvtHwSWheBuElrGJ2lGqL/m+tR0sHY8TSX/5osAJayYeMH
         CNGplgVvDry4Sxjxwq8VVsRkeAcPlQKve0c4MkIKL3D1wzS7UdOsqsfY0TRgiSgat5U4
         UKUw==
X-Forwarded-Encrypted: i=1; AJvYcCWCLpKJcSojDnTECTObuAXgatO51OxrjVBVWRvR31Byj8rA+FMT0PtbfZ4zqp/BGITkqblO1fLKwoIqSns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHn9zQ60Wd4AbC6x8rj7HTOh/UTxtWNpHzGFlRqpohHuq9x0i
	Wlw1ec0QDz15+yfyrEBWaokPjAIEmEVUoS0e0kJ0EtN2+ZVnb+QMpcIwqjXKVzUKq62lhaQ6P4S
	R9gVFakKVzGWPUo6meNdrYoOjjRlM8jEwpZEozSZ4
X-Gm-Gg: ASbGnctLlCcLNO+SLvIhA73nUxJQfKg7Rx1BuEcyXD/N/XHQcAevyTNd8J4kLNj4kFH
	hRR1PXb06rQGrsAUCvn7DUSHJcgc1oMSrdKSBdKTYajPoLDN7DYEoIFzhLWW8oEfg1cbLmLmswS
	DqxV7mMizbMOiFqqt36MAQylbykd3hXqp7DT76BRliz0kBghvCjYIZqtd9b4cooaIF5RDcUn9iT
	4zx5fLM
X-Google-Smtp-Source: AGHT+IE+UU4VA4DGmnQFV54tyrhp4vJqJ91dEAuaijW8Yd97sgJ61zqil1yRxViEnqYJIPosIBS2J8A23CgpIiWzZTA=
X-Received: by 2002:a05:6e02:3986:b0:3e3:a546:2d4c with SMTP id
 e9e14a558f8ab-3e3cce7b3d2mr804335ab.17.1753489393830; Fri, 25 Jul 2025
 17:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-4-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:23:00 -0700
X-Gm-Features: Ac12FXxxiNE-ui_qvOqBNd0BrTofXzEa8BivZHtX2XR7zItOPclck6bSRLc1KaI
Message-ID: <CAP-5=fXUyA=kgTTMDUmeOF9hURhQQxfYOFk5_HZEkQsdh7QqSg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] perf annotate: Pass annotation_print_data to annotation_line__write()
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
> It will be used for data type display later.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 13 ++++++++++--
>  tools/perf/util/annotate.c        | 35 +++++++++++++++++--------------
>  tools/perf/util/annotate.h        | 15 +++++++++++--
>  3 files changed, 43 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index 28ef146f29e8e742..23bea5b165774ae7 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -28,6 +28,8 @@ struct annotate_browser {
>         struct annotation_line     *selection;
>         struct arch                *arch;
>         struct hist_entry          *he;
> +       struct debuginfo           *dbg;
> +       struct evsel               *evsel;
>         bool                        searching_backwards;
>         char                        search_bf[128];
>  };
> @@ -108,12 +110,18 @@ static void annotate_browser__write(struct ui_brows=
er *browser, void *entry, int
>                 .printf                  =3D annotate_browser__printf,
>                 .write_graph             =3D annotate_browser__write_grap=
h,
>         };
> +       struct annotation_print_data apd =3D {
> +               .he =3D ab->he,
> +               .arch =3D ab->arch,
> +               .evsel =3D ab->evsel,
> +               .dbg =3D ab->dbg,
> +       };
>
>         /* The scroll bar isn't being used */
>         if (!browser->navkeypressed)
>                 ops.width +=3D 1;
>
> -       annotation_line__write(al, notes, &ops);
> +       annotation_line__write(al, notes, &ops, &apd);
>
>         if (ops.current_entry)
>                 ab->selection =3D al;
> @@ -976,7 +984,7 @@ static int annotate_browser__run(struct annotate_brow=
ser *browser,
>                         continue;
>                 }
>                 case 'P':
> -                       map_symbol__annotation_dump(ms, evsel);
> +                       map_symbol__annotation_dump(ms, evsel, browser->h=
e);
>                         continue;
>                 case 't':
>                         if (symbol_conf.show_total_period) {
> @@ -1061,6 +1069,7 @@ int __hist_entry__tui_annotate(struct hist_entry *h=
e, struct map_symbol *ms,
>                         .use_navkeypressed =3D true,
>                 },
>                 .he =3D he,
> +               .evsel =3D evsel,
>         };
>         struct dso *dso;
>         int ret =3D -1, err;
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 69ee83052396b15e..c21152710148b68c 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -765,15 +765,6 @@ __hist_entry__get_data_type(struct hist_entry *he, s=
truct arch *arch,
>                             struct debuginfo *dbg, struct disasm_line *dl=
,
>                             int *type_offset);
>
> -struct annotation_print_data {
> -       struct hist_entry *he;
> -       struct evsel *evsel;
> -       struct arch *arch;
> -       struct debuginfo *dbg;
> -       u64 start;
> -       int addr_fmt_width;
> -};
> -
>  static int
>  annotation_line__print(struct annotation_line *al, struct annotation_pri=
nt_data *apd,
>                        struct annotation_options *opts, int printed,
> @@ -1230,7 +1221,6 @@ int hist_entry__annotate_printf(struct hist_entry *=
he, struct evsel *evsel)
>         struct annotation_print_data apd =3D {
>                 .he =3D he,
>                 .evsel =3D evsel,
> -               .start =3D map__rip_2objdump(map, sym->start),
>         };
>         int printed =3D 2, queue_len =3D 0;
>         int more =3D 0;
> @@ -1357,7 +1347,8 @@ static void FILE__write_graph(void *fp, int graph)
>         fputs(s, fp);
>  }
>
> -static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
> +static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
> +                                    struct annotation_print_data *apd)
>  {
>         struct annotation *notes =3D symbol__annotation(sym);
>         struct annotation_write_ops wops =3D {
> @@ -1374,7 +1365,7 @@ static int symbol__annotate_fprintf2(struct symbol =
*sym, FILE *fp)
>         list_for_each_entry(al, &notes->src->source, node) {
>                 if (annotation_line__filter(al))
>                         continue;
> -               annotation_line__write(al, notes, &wops);
> +               annotation_line__write(al, notes, &wops, apd);
>                 fputc('\n', fp);
>                 wops.first_line =3D false;
>         }
> @@ -1382,13 +1373,18 @@ static int symbol__annotate_fprintf2(struct symbo=
l *sym, FILE *fp)
>         return 0;
>  }
>
> -int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evs=
el)
> +int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evs=
el,
> +                               struct hist_entry *he)
>  {
>         const char *ev_name =3D evsel__name(evsel);
>         char buf[1024];
>         char *filename;
>         int err =3D -1;
>         FILE *fp;
> +       struct annotation_print_data apd =3D {
> +               .he =3D he,
> +               .evsel =3D evsel,
> +       };
>
>         if (asprintf(&filename, "%s.annotation", ms->sym->name) < 0)
>                 return -1;
> @@ -1404,7 +1400,7 @@ int map_symbol__annotation_dump(struct map_symbol *=
ms, struct evsel *evsel)
>
>         fprintf(fp, "%s() %s\nEvent: %s\n\n",
>                 ms->sym->name, dso__long_name(map__dso(ms->map)), ev_name=
);
> -       symbol__annotate_fprintf2(ms->sym, fp);
> +       symbol__annotate_fprintf2(ms->sym, fp, &apd);
>
>         fclose(fp);
>         err =3D 0;
> @@ -1656,6 +1652,10 @@ int hist_entry__tty_annotate2(struct hist_entry *h=
e, struct evsel *evsel)
>         struct symbol *sym =3D ms->sym;
>         struct rb_root source_line =3D RB_ROOT;
>         struct hists *hists =3D evsel__hists(evsel);
> +       struct annotation_print_data apd =3D {
> +               .he =3D he,
> +               .evsel =3D evsel,
> +       };
>         char buf[1024];
>         int err;
>
> @@ -1678,7 +1678,7 @@ int hist_entry__tty_annotate2(struct hist_entry *he=
, struct evsel *evsel)
>         hists__scnprintf_title(hists, buf, sizeof(buf));
>         fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
>                 buf, percent_type_str(annotate_opts.percent_type), sym->n=
ame, dso__long_name(dso));
> -       symbol__annotate_fprintf2(sym, stdout);
> +       symbol__annotate_fprintf2(sym, stdout, &apd);
>
>         annotated_source__purge(symbol__annotation(sym)->src);
>
> @@ -1936,7 +1936,8 @@ int annotation_br_cntr_entry(char **str, int br_cnt=
r_nr,
>  }
>
>  void annotation_line__write(struct annotation_line *al, struct annotatio=
n *notes,
> -                           struct annotation_write_ops *wops)
> +                           struct annotation_write_ops *wops,
> +                           struct annotation_print_data *apd)
>  {
>         bool current_entry =3D wops->current_entry;
>         bool change_color =3D wops->change_color;
> @@ -2114,6 +2115,8 @@ void annotation_line__write(struct annotation_line =
*al, struct annotation *notes
>                 disasm_line__write(disasm_line(al), notes, obj, bf, sizeo=
f(bf), obj__printf, obj__write_graph);
>
>                 obj__printf(obj, "%-*s", width - pcnt_width - cycles_widt=
h - 3 - printed, bf);
> +
> +               (void)apd;
>         }
>
>  }
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 0f640e4871744262..8fad464a870a2b8e 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -199,8 +199,18 @@ struct annotation_write_ops {
>         void (*write_graph)(void *obj, int graph);
>  };
>
> +struct annotation_print_data {
> +       struct hist_entry *he;
> +       struct evsel *evsel;
> +       struct arch *arch;
> +       struct debuginfo *dbg;
> +       u64 start;
> +       int addr_fmt_width;
> +};

nit: As the scope of this is now global, is it worth commenting it?
For example, where is start relative to?

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +
>  void annotation_line__write(struct annotation_line *al, struct annotatio=
n *notes,
> -                           struct annotation_write_ops *ops);
> +                           struct annotation_write_ops *ops,
> +                           struct annotation_print_data *apd);
>
>  int __annotation__scnprintf_samples_period(struct annotation *notes,
>                                            char *bf, size_t size,
> @@ -463,7 +473,8 @@ void symbol__annotate_zero_histogram(struct symbol *s=
ym, struct evsel *evsel);
>  void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *=
evsel);
>  void annotated_source__purge(struct annotated_source *as);
>
> -int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evs=
el);
> +int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evs=
el,
> +                               struct hist_entry *he);
>
>  bool ui__has_annotation(void);
>
> --
> 2.50.1
>

