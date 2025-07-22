Return-Path: <linux-kernel+bounces-741109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C662B0E02F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BED188C075
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A91128B7C7;
	Tue, 22 Jul 2025 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQImAd8V"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BFC1C84DE
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197053; cv=none; b=NpnrqabmD/1NnhCj6Vwf0D+afAL2pznbin3lwFpVy1Y42B038xgeYrRvGT2+d47kFKg+kSRIUAGB3W/xzxclZ59wbhAcIfcXh31XYW6GFT+YouBIE0ArEfAWfgnQAmO/bk8v08sbnHpeOfO3hbINctLmhSlHwP72oBTSx/xLZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197053; c=relaxed/simple;
	bh=bXiIcUS4ZKUlE5EGfppXIJnyr0fdlKsJLvXnKOv53uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbwB5gLWrqu6zXC6+A1lq3QklGDMYcVjBJF5NWyyyoPVp6qrKY2jM3m9SnajN3dXVbHOn/VunIhIXzrlddUzybx2PnfqYYsRZMY+J1hCuc2BsV8ilE1FqsJhK2Ds/cHoIsTYsWlvfn2jV6VoJb2L9ZBaHnNkNPzoG7kwG5kntyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQImAd8V; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df371e1d29so115415ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753197051; x=1753801851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrnjuIg4e+o8/wr4oPnV/ZDCtxDk7IDXvR/lvcR7L34=;
        b=qQImAd8VSxpvdBSvfDThmr2e25VBbAXwKZqoTTbvEZmdMNSiCi5Keh0ERyuVOCBJ2j
         7UyDJcLS28+Ue6zbMJjFRfl71x56kKKl7uJ7TiQ2lxKyBkoXFCCRfQWXPTngiRfcqsUu
         xQW2+1zvmXlB7sKhaAYCp2B5hw+J+A06tMEa5TmAESrm7ARSvfqcxHkGeX9Fzhka6glT
         7+jI2zkOXlz3fM8EmgmLxPAQ3lqDHXP+mwtvASMmkd6IjWwhz3phBCo0L9NpSQbj/sJ9
         uVfu4ItHud9qIJR/nKlKuUFwDUp2WrqRTSsONxUXkfV+LhwBtGS0KxXne/Qz4daxPQxf
         Vswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197051; x=1753801851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrnjuIg4e+o8/wr4oPnV/ZDCtxDk7IDXvR/lvcR7L34=;
        b=Jsa/uZJYHVxn2opEisPnAI7RGQa+axAcU5z8tMsAk1KIvxGKlic7pymM/FfYukbnaa
         6o8Ves6qBGZFbRXXQwWwyZLYA4jeJ1dil16/XYX1aDtNmejiJyiD6ZCCBMNHtyUB4UHz
         vdzFAep9rbufR+/ZP7uxSBmC2wbkFTRNbmUulUpjcF+25rRznhDSsnkU5IKShA+Hsrpv
         Yi1Wf93YeNQITke26QuTyUiOe/o+Cr2nvyUF5moxjx8CXkE2npgglJSJUtHDNoG0nRiS
         GwhJaE2PJkNUQJppCHghHBOG4MAImhPiZ5E9HxomXaDHb3fb84ehGH6KWr7JzMZl3t1P
         MBdw==
X-Forwarded-Encrypted: i=1; AJvYcCUqurQ4t5o1bhyy5SXSBAqx4HcrtR09j8WalRXi2AUvDGZA+2qPSabRc69G+uwwDon8sTwcb3uH4A8+cPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDjZpOTKEGF11F5bXd4Ee9Rhle8xQnEaUBl6VBEDRKdz72s+6
	5DnBWW8DHJrothFIFaFr0X9x4ENGCjW1JUR/BR2S1wHbtxPl/hvnvc0j0fQMmGJKzfmgO3z8Ncd
	uQgvJhuvCz94h12n0BPdSZpYXwvPr6agL6fbSVJ3T
X-Gm-Gg: ASbGncvcdGWGi3RvX0zPPxe5tCpq3yYVbrLhouJYY6lYBmfFcUJJRx9uFBzGGvhTVnk
	2gWVzJ3ujOrozDaxZUFJcavyUWnDs/wi6td7SS5DOZeM2naNWYR8LrIZ/esWGmH8/1VRM9+tZeo
	2SiXSnKaC0wAsu3nugQ9Clr+wx3EOHcCUIrTIHxcvbFgFfDqRmBBAQFHCmtE9Rn6/Wu8cY4YDE0
	pXg3Fuusnm4M0aGvpJoIe5HJGQigkct20xs
X-Google-Smtp-Source: AGHT+IE2E7+83BOEx6tLs/66ORgFia6L7tH6SAgAtRa4Ppe0kHWFhpLdHDLDf1GERndmzTI1sLB37BFfvgRJ09LGfEY=
X-Received: by 2002:a05:6e02:2282:b0:3dd:872d:b3fd with SMTP id
 e9e14a558f8ab-3e2bf1152a8mr4685215ab.2.1753197049845; Tue, 22 Jul 2025
 08:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613114048.132336-1-changbin.du@huawei.com>
In-Reply-To: <20250613114048.132336-1-changbin.du@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Jul 2025 08:10:38 -0700
X-Gm-Features: Ac12FXwWJZVb2aJmP4nhddrCkEkMezDz_pPuVMIzQRc4SFP-iDAuPJGdnMDR4Ks
Message-ID: <CAP-5=fX6jNrGhP9xH=KhGgT60r+SDgLpUT6jc0V67jAu2H5YOg@mail.gmail.com>
Subject: Re: [PATCH] perf: ftrace: add graph tracer options args/retval/retval-hex/retaddr
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 4:41=E2=80=AFAM Changbin Du <changbin.du@huawei.com=
> wrote:
>
> This change adds support for new funcgraph tracer options funcgraph-args,
> funcgraph-retval, funcgraph-retval-hex and funcgraph-retaddr.
>
> The new added options are:
>   - args       : Show function arguments.
>   - retval     : Show function return value.
>   - retval-hex : Show function return value in hexadecimal format.
>   - retaddr    : Show function return address.
>
>  # ./perf ftrace -G vfs_write --graph-opts retval,retaddr
>  # tracer: function_graph
>  #
>  # CPU  DURATION                  FUNCTION CALLS
>  # |     |   |                     |   |   |   |
>  5)               |  mutex_unlock() { /* <-rb_simple_write+0xda/0x150 */
>  5)   0.188 us    |    local_clock(); /* <-lock_release+0x2ad/0x440 ret=
=3D0x3bf2a3cf90e */
>  5)               |    rt_mutex_slowunlock() { /* <-rb_simple_write+0xda/=
0x150 */
>  5)               |      _raw_spin_lock_irqsave() { /* <-rt_mutex_slowunl=
ock+0x4f/0x200 */
>  5)   0.123 us    |        preempt_count_add(); /* <-_raw_spin_lock_irqsa=
ve+0x23/0x90 ret=3D0x0 */
>  5)   0.128 us    |        local_clock(); /* <-__lock_acquire.isra.0+0x17=
a/0x740 ret=3D0x3bf2a3cfc8b */
>  5)   0.086 us    |        do_raw_spin_trylock(); /* <-_raw_spin_lock_irq=
save+0x4a/0x90 ret=3D0x1 */
>  5)   0.845 us    |      } /* _raw_spin_lock_irqsave ret=3D0x292 */
>  5)               |      _raw_spin_unlock_irqrestore() { /* <-rt_mutex_sl=
owunlock+0x191/0x200 */
>  5)   0.097 us    |        local_clock(); /* <-lock_release+0x2ad/0x440 r=
et=3D0x3bf2a3cff1f */
>  5)   0.086 us    |        do_raw_spin_unlock(); /* <-_raw_spin_unlock_ir=
qrestore+0x23/0x60 ret=3D0x1 */
>  5)   0.104 us    |        preempt_count_sub(); /* <-_raw_spin_unlock_irq=
restore+0x35/0x60 ret=3D0x0 */
>  5)   0.726 us    |      } /* _raw_spin_unlock_irqrestore ret=3D0x8000000=
0 */
>  5)   1.881 us    |    } /* rt_mutex_slowunlock ret=3D0x0 */
>  5)   2.931 us    |  } /* mutex_unlock ret=3D0x0 */
>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>

I tried testing but lacked the kernel features. It built and I checked the =
code:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-ftrace.txt |  4 ++
>  tools/perf/builtin-ftrace.c              | 60 +++++++++++++++++++++++-
>  tools/perf/util/ftrace.h                 |  4 ++
>  3 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Docume=
ntation/perf-ftrace.txt
> index b77f58c4d2fd..4b21a755132f 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -123,6 +123,10 @@ OPTIONS for 'perf ftrace trace'
>  --graph-opts::
>         List of options allowed to set:
>
> +         - args         - Show function arguments.
> +         - retval       - Show function return value.
> +         - retval-hex   - Show function return value in hexadecimal form=
at.
> +         - retaddr      - Show function return address.
>           - nosleep-time - Measure on-CPU time only for function_graph tr=
acer.
>           - noirqs       - Ignore functions that happen inside interrupt.
>           - verbose      - Show process names, PIDs, timestamps, etc.
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index bba36ebc2aa7..f7cf1dd7b64b 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -301,6 +301,10 @@ static void reset_tracing_options(struct perf_ftrace=
 *ftrace __maybe_unused)
>         write_tracing_option_file("funcgraph-proc", "0");
>         write_tracing_option_file("funcgraph-abstime", "0");
>         write_tracing_option_file("funcgraph-tail", "0");
> +       write_tracing_option_file("funcgraph-args", "0");
> +       write_tracing_option_file("funcgraph-retval", "0");
> +       write_tracing_option_file("funcgraph-retval-hex", "0");
> +       write_tracing_option_file("funcgraph-retaddr", "0");
>         write_tracing_option_file("latency-format", "0");
>         write_tracing_option_file("irq-info", "0");
>  }
> @@ -542,6 +546,41 @@ static int set_tracing_sleep_time(struct perf_ftrace=
 *ftrace)
>         return 0;
>  }
>
> +static int set_tracing_funcgraph_args(struct perf_ftrace *ftrace)
> +{
> +       if (ftrace->graph_args) {
> +               if (write_tracing_option_file("funcgraph-args", "1") < 0)
> +                       return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
> +{
> +       if (ftrace->graph_retval || ftrace->graph_retval_hex) {
> +               if (write_tracing_option_file("funcgraph-retval", "1") < =
0)
> +                       return -1;
> +       }
> +
> +       if (ftrace->graph_retval_hex) {
> +               if (write_tracing_option_file("funcgraph-retval-hex", "1"=
) < 0)
> +                       return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int set_tracing_funcgraph_retaddr(struct perf_ftrace *ftrace)
> +{
> +       if (ftrace->graph_retaddr) {
> +               if (write_tracing_option_file("funcgraph-retaddr", "1") <=
 0)
> +                       return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
>  {
>         if (!ftrace->graph_noirqs)
> @@ -642,6 +681,21 @@ static int set_tracing_options(struct perf_ftrace *f=
trace)
>                 return -1;
>         }
>
> +       if (set_tracing_funcgraph_args(ftrace) < 0) {
> +               pr_err("failed to set tracing option funcgraph-args\n");
> +               return -1;
> +       }
> +
> +       if (set_tracing_funcgraph_retval(ftrace) < 0) {
> +               pr_err("failed to set tracing option funcgraph-retval\n")=
;
> +               return -1;
> +       }
> +
> +       if (set_tracing_funcgraph_retaddr(ftrace) < 0) {
> +               pr_err("failed to set tracing option funcgraph-retaddr\n"=
);
> +               return -1;
> +       }
> +
>         if (set_tracing_funcgraph_irqs(ftrace) < 0) {
>                 pr_err("failed to set tracing option funcgraph-irqs\n");
>                 return -1;
> @@ -1607,6 +1661,10 @@ static int parse_graph_tracer_opts(const struct op=
tion *opt,
>         int ret;
>         struct perf_ftrace *ftrace =3D (struct perf_ftrace *) opt->value;
>         struct sublevel_option graph_tracer_opts[] =3D {
> +               { .name =3D "args",               .value_ptr =3D &ftrace-=
>graph_args },
> +               { .name =3D "retval",             .value_ptr =3D &ftrace-=
>graph_retval },
> +               { .name =3D "retval-hex",         .value_ptr =3D &ftrace-=
>graph_retval_hex },
> +               { .name =3D "retaddr",            .value_ptr =3D &ftrace-=
>graph_retaddr },
>                 { .name =3D "nosleep-time",       .value_ptr =3D &ftrace-=
>graph_nosleep_time },
>                 { .name =3D "noirqs",             .value_ptr =3D &ftrace-=
>graph_noirqs },
>                 { .name =3D "verbose",            .value_ptr =3D &ftrace-=
>graph_verbose },
> @@ -1699,7 +1757,7 @@ int cmd_ftrace(int argc, const char **argv)
>         OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
>                      "Set nograph filter on given functions", parse_filte=
r_func),
>         OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> -                    "Graph tracer options, available options: nosleep-ti=
me,noirqs,verbose,thresh=3D<n>,depth=3D<n>",
> +                    "Graph tracer options, available options: args,retva=
l,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=3D<n>,depth=3D<n>",
>                      parse_graph_tracer_opts),
>         OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "siz=
e",
>                      "Size of per cpu buffer, needs to use a B, K, M or G=
 suffix.", parse_buffer_size),
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> index a9bc47da83a5..782c33227e92 100644
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h
> @@ -29,6 +29,10 @@ struct perf_ftrace {
>         int                     graph_depth;
>         int                     func_stack_trace;
>         int                     func_irq_info;
> +       int                     graph_args;
> +       int                     graph_retval;
> +       int                     graph_retval_hex;
> +       int                     graph_retaddr;
>         int                     graph_nosleep_time;
>         int                     graph_noirqs;
>         int                     graph_verbose;
> --
> 2.43.0
>

