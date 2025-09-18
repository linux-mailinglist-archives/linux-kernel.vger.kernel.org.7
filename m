Return-Path: <linux-kernel+bounces-748522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77019B14235
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F24718C1F92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90549275AF7;
	Mon, 28 Jul 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKnacxs2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786621D3D2;
	Mon, 28 Jul 2025 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728467; cv=none; b=ALMSmkMsMCaQyX0IxdLVzuDB7bYqjE/6vII/zSi4f7aQShHmQmACupkn6S4ea44gv3t5wXScyCudr++ybzl+9bMzKl5Oti1HfIurFc+Eiit6LRivtNqfKR0JYYUPY9U+7zHEzk1odLo8LUOjtmPBhMbt486FyB27jSrKWZKswFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728467; c=relaxed/simple;
	bh=cA73/lc9IWHo6yAek5ZnaVyqbHc5bxbJzNBobW6cvdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVBkPkwa5YPTJk8DpLeRCiFK06mMyBHPSHIljRIGPPtNjjZPn7u+n3vfU79rrrPFs0xjbmeI30Lb74ue3cnj7mqCVU4JFqAormWq3HPjlFpQMD90KQ3DH4aDeD1p/JIy7yb9EkRVtsRMJY2hlFeuS0Qo5eGKgNrKLGV8878ints=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKnacxs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD71C4CEE7;
	Mon, 28 Jul 2025 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753728467;
	bh=cA73/lc9IWHo6yAek5ZnaVyqbHc5bxbJzNBobW6cvdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKnacxs2yto7i2z8cOvfComv3mr3h/zxLroMTtPXXEkeinKAK13o00O/3nNYzlQpY
	 C+SrGjWwQ90V3zo4zA1NHkfESd9bXDvssnbEZ3zDE0qzvl/4LPDxX6fxdEWZnFVyIQ
	 wzUqATn+FtkgVkrlFce2h6lXaDXOYT0WBX0uVDlwH5UMz4izHd4aoBTH5movFWZY4J
	 4bWqQ5gR24T0MXs/tqj9VOSLoHGzLCtjtrQPXbqto2MSJ0bB+7zhttKiBdXJvEVVkp
	 3Modd8sqZHGgsqJWapgM7hSPNaPXPjvUry0nCKNRXuXGPJt0YR8aR52vKaspWdEHVL
	 Uvqbkw45lThPA==
Date: Mon, 28 Jul 2025 11:47:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 5/9] perf annotate: Add --code-with-type support for
 TUI
Message-ID: <aIfF0X80EhOF2f4J@google.com>
References: <20250725193755.12276-1-namhyung@kernel.org>
 <20250725193755.12276-6-namhyung@kernel.org>
 <CAP-5=fWapueXS2NBHyd8VAen7XsenZjRGFgyKtLZFuTmCGaA7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWapueXS2NBHyd8VAen7XsenZjRGFgyKtLZFuTmCGaA7g@mail.gmail.com>

On Fri, Jul 25, 2025 at 05:31:52PM -0700, Ian Rogers wrote:
> On Fri, Jul 25, 2025 at 12:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Until now, the --code-with-type option is available only on stdio.
> > But it was an artifical limitation because of an implemention issue.
> >
> > Implement the same logic in annotation_line__write() for stdio2/TUI.
> > Make disasm_line__write() return the number of printed characters so
> > that it can skip unnecessary operations when the screen is full.
> 
> This change seems to be different from the rest of what is the patch,
> is it possible to have it is a patch before this one?

Yep, will do in the next version.

Thanks,
Namhyung

> 
> > Remove the limitation and update the man page.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-annotate.txt |  1 -
> >  tools/perf/builtin-annotate.c              |  5 --
> >  tools/perf/ui/browsers/annotate.c          |  6 +++
> >  tools/perf/util/annotate.c                 | 61 +++++++++++++++++++---
> >  4 files changed, 61 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> > index 46090c5b42b4762f..547f1a2680185e3c 100644
> > --- a/tools/perf/Documentation/perf-annotate.txt
> > +++ b/tools/perf/Documentation/perf-annotate.txt
> > @@ -170,7 +170,6 @@ include::itrace.txt[]
> >
> >  --code-with-type::
> >         Show data type info in code annotation (for memory instructions only).
> > -       Currently it only works with --stdio option.
> >
> >
> >  SEE ALSO
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index 5d57d2913f3d9a33..646f43b0f7c4c9b0 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -917,11 +917,6 @@ int cmd_annotate(int argc, const char **argv)
> >                 symbol_conf.annotate_data_sample = true;
> >         } else if (annotate_opts.code_with_type) {
> >                 symbol_conf.annotate_data_member = true;
> > -
> > -               if (!annotate.use_stdio) {
> > -                       pr_err("--code-with-type only works with --stdio.\n");
> > -                       goto out_delete;
> > -               }
> >         }
> >
> >         setup_browser(true);
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index 23bea5b165774ae7..cdee1969f3131a7c 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -4,6 +4,7 @@
> >  #include "../ui.h"
> >  #include "../../util/annotate.h"
> >  #include "../../util/debug.h"
> > +#include "../../util/debuginfo.h"
> >  #include "../../util/dso.h"
> >  #include "../../util/hist.h"
> >  #include "../../util/sort.h"
> > @@ -1101,6 +1102,9 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >
> >         ui_helpline__push("Press ESC to exit");
> >
> > +       if (annotate_opts.code_with_type)
> > +               browser.dbg = debuginfo__new(dso__long_name(dso));
> > +
> >         browser.b.width = notes->src->widths.max_line_len;
> >         browser.b.nr_entries = notes->src->nr_entries;
> >         browser.b.entries = &notes->src->source;
> > @@ -1111,6 +1115,8 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >
> >         ret = annotate_browser__run(&browser, evsel, hbt);
> >
> > +       if (annotate_opts.code_with_type)
> > +               debuginfo__delete(browser.dbg);
> >         if (not_annotated && !notes->src->tried_source)
> >                 annotated_source__purge(notes->src);
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index d69e406c1bc289cd..06ddc7a9f58722a4 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1362,6 +1362,11 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
> >         };
> >         struct annotation_line *al;
> >
> > +       if (annotate_opts.code_with_type) {
> > +               evsel__get_arch(apd->evsel, &apd->arch);
> > +               apd->dbg = debuginfo__new(dso__long_name(map__dso(apd->he->ms.map)));
> > +       }
> > +
> >         list_for_each_entry(al, &notes->src->source, node) {
> >                 if (annotation_line__filter(al))
> >                         continue;
> > @@ -1370,6 +1375,9 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
> >                 wops.first_line = false;
> >         }
> >
> > +       if (annotate_opts.code_with_type)
> > +               debuginfo__delete(apd->dbg);
> > +
> >         return 0;
> >  }
> >
> > @@ -1743,7 +1751,7 @@ static double annotation_line__max_percent(struct annotation_line *al,
> >         return percent_max;
> >  }
> >
> > -static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
> > +static int disasm_line__write(struct disasm_line *dl, struct annotation *notes,
> >                                void *obj, char *bf, size_t size,
> >                                void (*obj__printf)(void *obj, const char *fmt, ...),
> >                                void (*obj__write_graph)(void *obj, int graph))
> > @@ -1771,8 +1779,8 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
> >                 obj__printf(obj, "  ");
> >         }
> >
> > -       disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
> > -                              notes->src->widths.max_ins_name);
> > +       return disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
> > +                                     notes->src->widths.max_ins_name);
> >  }
> >
> >  static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
> > @@ -2116,11 +2124,52 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
> >
> >                 width -= printed + 3;
> >
> > -               disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
> > +               printed = disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf),
> > +                                            obj__printf, obj__write_graph);
> > +
> > +               obj__printf(obj, "%s", bf);
> > +               width -= printed;
> > +
> > +               if (annotate_opts.code_with_type && apd->dbg) {
> > +                       struct annotated_data_type *data_type;
> > +                       int offset = 0;
> > +
> > +                       data_type = __hist_entry__get_data_type(apd->he, apd->arch,
> > +                                                               apd->dbg,
> > +                                                               disasm_line(al),
> > +                                                               &offset);
> > +                       if (data_type && data_type != NO_TYPE) {
> > +                               char member[256];
> > +
> > +                               printed = scnprintf(bf, sizeof(bf),
> > +                                                   "\t\t# data-type: %s",
> > +                                                   data_type->self.type_name);
> >
> > -               obj__printf(obj, "%-*s", width, bf);
> > +                               if (data_type != &stackop_type &&
> > +                                   data_type != &canary_type &&
> > +                                   sizeof(bf) > (size_t)printed) {
> > +                                       printed += scnprintf(bf + printed,
> > +                                                            sizeof(bf) - printed,
> > +                                                            " +%#x", offset);
> > +                               }
> > +
> > +                               if (annotated_data_type__get_member_name(data_type,
> > +                                                                        member,
> > +                                                                        sizeof(member),
> > +                                                                        offset) &&
> > +                                   sizeof(bf) > (size_t)printed) {
> > +                                       printed += scnprintf(bf + printed,
> > +                                                            sizeof(bf) - printed,
> > +                                                            " (%s)", member);
> > +                               }
> >
> > -               (void)apd;
> > +                               obj__printf(obj, "%-*s", width, bf);
> > +                       } else {
> > +                               obj__printf(obj, "%-*s", width, " ");
> > +                       }
> > +               } else {
> > +                       obj__printf(obj, "%-*s", width, " ");
> > +               }
> >         }
> >
> >  }
> > --
> > 2.50.1
> >

