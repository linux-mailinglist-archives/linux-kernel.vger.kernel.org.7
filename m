Return-Path: <linux-kernel+bounces-746558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6523AB1283E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE0E3ACA6B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFBA13D53B;
	Sat, 26 Jul 2025 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2toMk+kC"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A32B9BA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490688; cv=none; b=MLQvD8zOGmkEou4fCxxWp1skbgMwA6GD7abxeIK+eHhh7IHMcLk9x985szSmRdzhAZAHMiGgsrfzITiKecsD1EZ8DYa95IEeQ7OL+PFLlGDglbhm4sbWCQ1PK71XmF+GjrREMImQ6bRu3IZXVDiYEwEy1/SmYUrAndUH+MhcfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490688; c=relaxed/simple;
	bh=9JFB9IXapt2d7PBmF4Tk/F4nAX0jKPDuyt5xJWIWPgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i80r+P+slXr4RN0P2mmjIQTSBWwhbx+EJfr79xyBriFFV3OxJy4fL3glv3VT30otqhFk0Z2HA6+82xspLQGoCjrirDWMxAoYoOGYvrfn0nilizb0/fWENWkT4CiUB+EZkSrCNI8Uwa3OsoIJ3Vvb9qn/OZokm6tpWhWw59xRFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2toMk+kC; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e3ca89a34bso56605ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490686; x=1754095486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPWnUybGUUkWCXTqRdDIxAceE2NePosWnljOPJMqdUk=;
        b=2toMk+kC7E6iIBtteBsOBsh13T4m2RP9gW/+T+BrHIfy8EqP0Eh5pP2d3XJ3vxV2NQ
         yy7+CoucCuV+ifM6ZofwrgCh8hn1O2fSV5RpoT5ai94kvvOSnI9x9sRTgwkM5B7PjKSi
         uFLsk67TkT+wopADtxJ6otVB5wula+cDB864cwLQCbYAru+ZXvTIpfeMxZhEsOjnJdxF
         bdV4mWHG37I/r2MDfqxn7hnLaBUiPlrPgf23cyZfOXi5OTkQC6q4LchhS3yBOOx0arlv
         5BnmahyPHy8OAUIM3+j6xw5lbxKixIzKhg6eQh8CghEfeVix2jY/I5pCccMJuutbO1oC
         erRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490686; x=1754095486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPWnUybGUUkWCXTqRdDIxAceE2NePosWnljOPJMqdUk=;
        b=ONMywgywmqoFg+9ztYsyy8UwNI9omvLKoL3oTNEXwN5QikW/v0p7+MB489yZfpbzk0
         rOC63hUGIj8LLO+QcxY4sUwLijHSBXyXpZevmvt9bL9tlkRt7mPUCO09bWuH93Fkgnia
         pemVx7mC0cpg3ov/a9fSu+SQuygmQ1X6ri32ZfnUIXG4kD2TqaEq65LNkaXc2rDddLaj
         8Qu1KzJK3aLAwEBFoi/srsUmZIJP3CLcEghtnrYYXfLMObaykJgKNzPNz3jyHyZSxBX0
         TEfeAocmEokhKwGVm7mxLZIuU2lgpJLXymqxA17Q5nA9I0a3ba/laAEoZ7l2Nmjs1/6a
         n7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX98ToIAUgrXuh2b6bnm+fGW2oy6pqO6JLWIXVshfJr3PDgnf0ITW3u0IeDvyEuSOixa3tQQbqgsAFShqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBaG9b9jMBWIZgDith3WSrekynWrURalGijGfyCbtiBZgxw7M
	YvOD050UfcyXutdrWZqDW4LJyeCQt4QinZkxFupzNyUn4tfHgeVuAR4W/lb6ELJiKKH5/YiIa0F
	5F2B2BEzCpJowqkBVuSL5PQdasr0iV30dqrgJUxHM
X-Gm-Gg: ASbGncvh5hoDQ2bJpoW68bDh/Nj/ejsFDEWhccHDueOdkUlAHBasCO9ss6nXya/xE8D
	qb9+LzUG8KLwNBfUpUuNDUZTuoOYPXOihMmPNamLOUpBZ5QL06JuZscEv8bQypixzWcxDPbYQbV
	pGhHhpvYdKkBbYkXAuF55llPt9vNCNcuwSJ90KOnLJq2VVB6laP7y0rnAJGlY2LDeC8yZo/yEth
	5r6Mj+z
X-Google-Smtp-Source: AGHT+IEHep2QYo3/LUJWt7WhvNXreRM+1G567+rK9hz7zyyMGGvYlVYw4NBVEb6WWUvJpA/Lns63orazNlcJeanqKbU=
X-Received: by 2002:a05:6e02:1d96:b0:3ce:7852:1e9 with SMTP id
 e9e14a558f8ab-3e3cce7e6famr904165ab.17.1753490685878; Fri, 25 Jul 2025
 17:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-9-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-9-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:44:33 -0700
X-Gm-Features: Ac12FXwKFtkaUOt5oHGOS4d5yrst1_xqdIh5_OnIcCc3aJSP8ffW-lYND28Bamc
Message-ID: <CAP-5=fWJxCq97Oss3NXbXEKHeNXbif9-yWvktNRQvwtm3H3jbA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] perf annotate: Hide data-type for stack operation
 and canary
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
> It's mostly unnecessary to print when it has no actual type information
> like in the stack operations and canary.  Let's have them if -v option
> is given.
>
> Before:
>   $ perf annotate --code-with-type
>   ...
>          : 0    0xd640 <_dl_relocate_object>:
>     0.00 :      0:       endbr64
>     0.00 :      4:       pushq   %rbp           # data-type: (stack opera=
tion)
>     0.00 :      5:       movq    %rsp, %rbp
>     0.00 :      8:       pushq   %r15           # data-type: (stack opera=
tion)
>     0.00 :      a:       pushq   %r14           # data-type: (stack opera=
tion)
>     0.00 :      c:       pushq   %r13           # data-type: (stack opera=
tion)
>     0.00 :      e:       pushq   %r12           # data-type: (stack opera=
tion)
>     0.00 :     10:       pushq   %rbx           # data-type: (stack opera=
tion)

I believe the intent in the dwarf is to say where the caller's callee
saves are, but the stack slots should just be saved and restored and
won't be used for anything interesting, perhaps for exception
handling. An annotation like:
# caller's RBX at stack frame offset -48
could perhaps be useful.

>     0.00 :     11:       subq    $0xf8, %rsp
>     ...
>     0.00 :     d4:       testl   %eax, %eax
>     0.00 :     d6:       jne     0xf424
>     0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-ty=
pe: struct link_map +0xf0
>     0.00 :     e3:       testq   %rbx, %rbx
>     0.00 :     e6:       jne     0xf2dd
>     0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: stru=
ct link_map +0xf8
>     ...
>
> After:
>          : 0    0xd640 <_dl_relocate_object>:
>     0.00 :      0:       endbr64
>     0.00 :      4:       pushq   %rbp
>     0.00 :      5:       movq    %rsp, %rbp
>     0.00 :      8:       pushq   %r15
>     0.00 :      a:       pushq   %r14
>     0.00 :      c:       pushq   %r13
>     0.00 :      e:       pushq   %r12
>     0.00 :     10:       pushq   %rbx
>     0.00 :     11:       subq    $0xf8, %rsp
>     ...
>     0.00 :     d4:       testl   %eax, %eax
>     0.00 :     d6:       jne     0xf424
>     0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-ty=
pe: struct link_map +0xf0
>     0.00 :     e3:       testq   %rbx, %rbx
>     0.00 :     e6:       jne     0xf2dd
>     0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: stru=
ct link_map +0xf8
>     ...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 06ddc7a9f58722a4..6fc07971631ac8a3 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -765,6 +765,17 @@ __hist_entry__get_data_type(struct hist_entry *he, s=
truct arch *arch,
>                             struct debuginfo *dbg, struct disasm_line *dl=
,
>                             int *type_offset);
>
> +static bool needs_type_info(struct annotated_data_type *data_type)
> +{
> +       if (data_type =3D=3D NULL || data_type =3D=3D NO_TYPE)
> +               return false;
> +
> +       if (verbose)
> +               return true;

lgtm given the many overloaded meanings of verbose.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +
> +       return (data_type !=3D &stackop_type) && (data_type !=3D &canary_=
type);
> +}
> +
>  static int
>  annotation_line__print(struct annotation_line *al, struct annotation_pri=
nt_data *apd,
>                        struct annotation_options *opts, int printed,
> @@ -844,7 +855,7 @@ annotation_line__print(struct annotation_line *al, st=
ruct annotation_print_data
>
>                         data_type =3D __hist_entry__get_data_type(apd->he=
, apd->arch,
>                                                                 apd->dbg,=
 dl, &offset);
> -                       if (data_type && data_type !=3D NO_TYPE) {
> +                       if (needs_type_info(data_type)) {
>                                 char buf[4096];
>
>                                 printf("\t\t# data-type: %s",
> @@ -2138,7 +2149,7 @@ void annotation_line__write(struct annotation_line =
*al, struct annotation *notes
>                                                                 apd->dbg,
>                                                                 disasm_li=
ne(al),
>                                                                 &offset);
> -                       if (data_type && data_type !=3D NO_TYPE) {
> +                       if (needs_type_info(data_type)) {
>                                 char member[256];
>
>                                 printed =3D scnprintf(bf, sizeof(bf),
> --
> 2.50.1
>

