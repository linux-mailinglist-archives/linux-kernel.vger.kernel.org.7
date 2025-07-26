Return-Path: <linux-kernel+bounces-746549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F4B12808
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D0B5875BA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DAF12C544;
	Sat, 26 Jul 2025 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plgrlgJA"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691D7263B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489929; cv=none; b=B4eQ00o4PIyYL/S8pum56t6Cfx/92c9jay6wYeE4PiZlNUgYgsC5vByqzPgOfn6ihdl0ROZ/vOPYd1/lt0WWbfDAvkQcLLJukTv7+8lUtTiekJmSX6jwY5RUty6In2iS4Nxqayr8M4N/fgIVIXUf48t+BS8ZfMNUMn0+NvZ+5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489929; c=relaxed/simple;
	bh=dfl/dPyojB1+sTZmfRYyP0AyyWfvKyQ2b/puzgxRQrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsCQwXYOmGUZLt+wRZwsaYbH0T0uzITPkRAwdE8cWhiL0qj/trhSES1KYiYwVnGHhE+w/dsjtweiOhby8flUy0IzZ+yUkv+hMhqg/L8HPzo9zY6TD/67WUSra3fAQOAB2P+beF9vu2a66jDj40H6dNTpc2F68Txov8yvKX5J9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plgrlgJA; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so41535ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753489926; x=1754094726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgnDYA89HrfOpKqT1bJoR+1nVMfoapxqC2SOa7Ke2IA=;
        b=plgrlgJAvr9CGZnn8GqZOcwyG13ab7kojclLpvri1QRM6R/7cfB+9RBAdofK7lG6G2
         FN/sPwkv1Hq2e1fyrrI2tm4bVEm0UDmf8quQoKfKRqWtgxGXvu7DLJ5lGHy8CsYEoGLj
         KNPu/ZT95olpfWLEQX0FQ7REYWRaDMzQquTnRdS5BZl3JhiyVvZTUj6DAtJA16f7HZk/
         o6OG39euOeEOZyjkNyg3Xd1OkUlZF9Dk+r/d47l+DBogZIOh1HLNEnNV76t2+FtkbpXd
         zXDpknk02z5lfTuW4YD+TuZx42UWDxSMMJEOZmw/AfxUhtsXJEDVUvBgiZgZayex9TIf
         a2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753489926; x=1754094726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgnDYA89HrfOpKqT1bJoR+1nVMfoapxqC2SOa7Ke2IA=;
        b=hjVpjRNi5wqsSx/R1y/ahqW2L/JRcw7ilR9za+0zyLZLLldEXpGvk5rKhLu8T57sUG
         9unPO6JdpO74QCaJgSX5Y1tONJ6DHtgkvVjLL1shSWOHviXg8pCgaZEnnFDZE/LwnoNv
         9N/A6ZzCWgGAENVXR+eX9Oc69/hbwjzCdekStuDjlxhUA7vSQwGDItOqyh2E0EF93BBy
         VulTsUTlOC8uvy/zSoJPJk3ayg/cABiLxLQFraalTss+Ce0xbZB9sxqB6X5WAHmouv6v
         dFMEqXNUNqmW2N8DhZjTUd9lWjlwhji1GWDo4auo2q+Wm4hV4HNeNlLl5+YTcTD3II5V
         Tfmg==
X-Forwarded-Encrypted: i=1; AJvYcCVLKjV0xnzXJD/cEXjqffs6CPG1pm+HlXYOsCpmHcG60e85cURFCJ94IUlwdphOEmM0iXNBk4mXffGBuwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLKBWYmxjOI06pXAHB1ihU/SmUyYKFaSg0anuvDawZU2PKzvw
	dXGd6Jj/B0XnHOj1RL4etn0JHO7vXOucXPNuepsuSZmvQanN3w58OsZn1odk6TUzwrGeaBPE9rv
	JkZBjnE2V+32hhmzjVbQIwNv/60ddJO7am/w0OYPNDNGS7UEHyMdf63Ez
X-Gm-Gg: ASbGncvL/vYCyJtQB3FfJRIAD4pSHQqmwOAu7c+cQ81Z3hjPD9AHutt+w3GQMwGgENk
	G3p+PWHAfAG6HRz4qaKvuZ7904VSyPhrHyEsF4jzcWbwfDtnoShGvI7V7M3pcp0kqO2J5PVRUCE
	JKR1PNY2M7VKKvCeBXitPHOmP4XQCsuhx/Md94aZRnwON70lRBRTn8EBMsZI4DcrH7N84V6gQd2
	2eJyBV5
X-Google-Smtp-Source: AGHT+IHZsuNRE5FCSN2N71Cs5g92HtpfBNRvuK2IugHr5y2cwwNCS7NMQMxQNWlfmuT7YsBOpbPM3T/vuO6yrTrLBg0=
X-Received: by 2002:a05:6e02:1a44:b0:3d9:6c99:5a83 with SMTP id
 e9e14a558f8ab-3e3cbf76632mr1476185ab.8.1753489926107; Fri, 25 Jul 2025
 17:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-6-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-6-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:31:52 -0700
X-Gm-Features: Ac12FXx15-Xg8zXVNAwr3s6QPiRXEJL9xYJHtvS6wZrXievka8D0R65K0JVRXBw
Message-ID: <CAP-5=fWapueXS2NBHyd8VAen7XsenZjRGFgyKtLZFuTmCGaA7g@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] perf annotate: Add --code-with-type support for TUI
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
> Until now, the --code-with-type option is available only on stdio.
> But it was an artifical limitation because of an implemention issue.
>
> Implement the same logic in annotation_line__write() for stdio2/TUI.
> Make disasm_line__write() return the number of printed characters so
> that it can skip unnecessary operations when the screen is full.

This change seems to be different from the rest of what is the patch,
is it possible to have it is a patch before this one?

Thanks,
Ian

> Remove the limitation and update the man page.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-annotate.txt |  1 -
>  tools/perf/builtin-annotate.c              |  5 --
>  tools/perf/ui/browsers/annotate.c          |  6 +++
>  tools/perf/util/annotate.c                 | 61 +++++++++++++++++++---
>  4 files changed, 61 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Docu=
mentation/perf-annotate.txt
> index 46090c5b42b4762f..547f1a2680185e3c 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -170,7 +170,6 @@ include::itrace.txt[]
>
>  --code-with-type::
>         Show data type info in code annotation (for memory instructions o=
nly).
> -       Currently it only works with --stdio option.
>
>
>  SEE ALSO
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index 5d57d2913f3d9a33..646f43b0f7c4c9b0 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -917,11 +917,6 @@ int cmd_annotate(int argc, const char **argv)
>                 symbol_conf.annotate_data_sample =3D true;
>         } else if (annotate_opts.code_with_type) {
>                 symbol_conf.annotate_data_member =3D true;
> -
> -               if (!annotate.use_stdio) {
> -                       pr_err("--code-with-type only works with --stdio.=
\n");
> -                       goto out_delete;
> -               }
>         }
>
>         setup_browser(true);
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index 23bea5b165774ae7..cdee1969f3131a7c 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -4,6 +4,7 @@
>  #include "../ui.h"
>  #include "../../util/annotate.h"
>  #include "../../util/debug.h"
> +#include "../../util/debuginfo.h"
>  #include "../../util/dso.h"
>  #include "../../util/hist.h"
>  #include "../../util/sort.h"
> @@ -1101,6 +1102,9 @@ int __hist_entry__tui_annotate(struct hist_entry *h=
e, struct map_symbol *ms,
>
>         ui_helpline__push("Press ESC to exit");
>
> +       if (annotate_opts.code_with_type)
> +               browser.dbg =3D debuginfo__new(dso__long_name(dso));
> +
>         browser.b.width =3D notes->src->widths.max_line_len;
>         browser.b.nr_entries =3D notes->src->nr_entries;
>         browser.b.entries =3D &notes->src->source;
> @@ -1111,6 +1115,8 @@ int __hist_entry__tui_annotate(struct hist_entry *h=
e, struct map_symbol *ms,
>
>         ret =3D annotate_browser__run(&browser, evsel, hbt);
>
> +       if (annotate_opts.code_with_type)
> +               debuginfo__delete(browser.dbg);
>         if (not_annotated && !notes->src->tried_source)
>                 annotated_source__purge(notes->src);
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index d69e406c1bc289cd..06ddc7a9f58722a4 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1362,6 +1362,11 @@ static int symbol__annotate_fprintf2(struct symbol=
 *sym, FILE *fp,
>         };
>         struct annotation_line *al;
>
> +       if (annotate_opts.code_with_type) {
> +               evsel__get_arch(apd->evsel, &apd->arch);
> +               apd->dbg =3D debuginfo__new(dso__long_name(map__dso(apd->=
he->ms.map)));
> +       }
> +
>         list_for_each_entry(al, &notes->src->source, node) {
>                 if (annotation_line__filter(al))
>                         continue;
> @@ -1370,6 +1375,9 @@ static int symbol__annotate_fprintf2(struct symbol =
*sym, FILE *fp,
>                 wops.first_line =3D false;
>         }
>
> +       if (annotate_opts.code_with_type)
> +               debuginfo__delete(apd->dbg);
> +
>         return 0;
>  }
>
> @@ -1743,7 +1751,7 @@ static double annotation_line__max_percent(struct a=
nnotation_line *al,
>         return percent_max;
>  }
>
> -static void disasm_line__write(struct disasm_line *dl, struct annotation=
 *notes,
> +static int disasm_line__write(struct disasm_line *dl, struct annotation =
*notes,
>                                void *obj, char *bf, size_t size,
>                                void (*obj__printf)(void *obj, const char =
*fmt, ...),
>                                void (*obj__write_graph)(void *obj, int gr=
aph))
> @@ -1771,8 +1779,8 @@ static void disasm_line__write(struct disasm_line *=
dl, struct annotation *notes,
>                 obj__printf(obj, "  ");
>         }
>
> -       disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
> -                              notes->src->widths.max_ins_name);
> +       return disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_of=
fset,
> +                                     notes->src->widths.max_ins_name);
>  }
>
>  static void ipc_coverage_string(char *bf, int size, struct annotation *n=
otes)
> @@ -2116,11 +2124,52 @@ void annotation_line__write(struct annotation_lin=
e *al, struct annotation *notes
>
>                 width -=3D printed + 3;
>
> -               disasm_line__write(disasm_line(al), notes, obj, bf, sizeo=
f(bf), obj__printf, obj__write_graph);
> +               printed =3D disasm_line__write(disasm_line(al), notes, ob=
j, bf, sizeof(bf),
> +                                            obj__printf, obj__write_grap=
h);
> +
> +               obj__printf(obj, "%s", bf);
> +               width -=3D printed;
> +
> +               if (annotate_opts.code_with_type && apd->dbg) {
> +                       struct annotated_data_type *data_type;
> +                       int offset =3D 0;
> +
> +                       data_type =3D __hist_entry__get_data_type(apd->he=
, apd->arch,
> +                                                               apd->dbg,
> +                                                               disasm_li=
ne(al),
> +                                                               &offset);
> +                       if (data_type && data_type !=3D NO_TYPE) {
> +                               char member[256];
> +
> +                               printed =3D scnprintf(bf, sizeof(bf),
> +                                                   "\t\t# data-type: %s"=
,
> +                                                   data_type->self.type_=
name);
>
> -               obj__printf(obj, "%-*s", width, bf);
> +                               if (data_type !=3D &stackop_type &&
> +                                   data_type !=3D &canary_type &&
> +                                   sizeof(bf) > (size_t)printed) {
> +                                       printed +=3D scnprintf(bf + print=
ed,
> +                                                            sizeof(bf) -=
 printed,
> +                                                            " +%#x", off=
set);
> +                               }
> +
> +                               if (annotated_data_type__get_member_name(=
data_type,
> +                                                                        =
member,
> +                                                                        =
sizeof(member),
> +                                                                        =
offset) &&
> +                                   sizeof(bf) > (size_t)printed) {
> +                                       printed +=3D scnprintf(bf + print=
ed,
> +                                                            sizeof(bf) -=
 printed,
> +                                                            " (%s)", mem=
ber);
> +                               }
>
> -               (void)apd;
> +                               obj__printf(obj, "%-*s", width, bf);
> +                       } else {
> +                               obj__printf(obj, "%-*s", width, " ");
> +                       }
> +               } else {
> +                       obj__printf(obj, "%-*s", width, " ");
> +               }
>         }
>
>  }
> --
> 2.50.1
>

