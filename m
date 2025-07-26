Return-Path: <linux-kernel+bounces-746564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98ECB1284E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A53A164D8D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4CB1946A0;
	Sat, 26 Jul 2025 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Upy6JXN"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1B2E3719
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491499; cv=none; b=DZZaZuEQ0KbMYG5EUZMupC0JaKu0UxfMWBWa6S6QGm1pHyBFpN6+WEU19OZqkmwtNR43J5IZKTPlxniICzYtNG5Y5iOF004tlzM/cneTPADkbxTINVaZPyEhxW9MKUUkV9ejBZiosiFp2sfZTwos55hve7PdRO3PsWP3ERQb8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491499; c=relaxed/simple;
	bh=DIf6O7PnWgEkqOWfZT2pbDIF9srrUdRo1wLN+ipZlJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElTeNz99BqlflgCyFhg+i94PUDDpdiVSoteuqmFXjwjDlWHmkLfrT5lWGzTce8GSn4KYLDv4ZNpr2RoXPM7vcGy5UmFjXe92U+Y+QRg++yfgzwjeeJC5p40mcUyA6jccsF+bGHIbqG/NcUSJFBwdXQd8mCNzYvg281DBiLKR9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Upy6JXN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-237f18108d2so74365ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753491497; x=1754096297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fplU80zmFpf0ULHak+TNWOazTGxzQTr6hTMAaKKe0E=;
        b=2Upy6JXNVTdyPpAoSn0mrmFOZ4gcHgOufAl6BkRbxQKhCIcw7xs/AVew9vZkzgnCrw
         AnG8s/f8WYKm5O2kzG9UInZtCQ7JBmgDINMO/Yt+Xy4OIn3A+v+Etf8Aljd479otRSq3
         5B1GN8gEe27UxgoSbr32YteZsHwefXrWMKqPHLlaVomjwi/V/xRCaCRzehK1fXa+IvHP
         O7rbw/62y8n7JCCo18ZqH0vKEYgVgmfQlNkqNoC9kcHgBOr8jgtAMJeCr06boEbPV/87
         KMFLXftgR6hLqxervZsf2kOBZ8ONZZpGUjB+fXFnm2GLquyXwCr/RhqFIE2KWjVU5OwU
         7QSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753491497; x=1754096297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fplU80zmFpf0ULHak+TNWOazTGxzQTr6hTMAaKKe0E=;
        b=m6U3+f2wMPktazvy55g6DLTi3Lwk1qlPszf6MoNY13uLgigRY3JI0JwLpVFUWeDVc1
         c5q6Bq2AklDEA6rbvIwcZeAznO8TupOBOdnJuJf0NUK0yomsqFN3jXxCUqAImW1YXVei
         CB3wBxbJNU5sixxwuFtrX5JO5LJDG6Z6UtqVSIDeYLjeRkKKbJxWL5PZinXXdfvadr6W
         f2nVC2IMYgmaziWmwttSsY1HYCG8kBUW6Zl14tqZEgOPaIWOsXSrdMdwUlB0lz9b3iGP
         H1G1hReIOhvhXUJEKtgIzrR4CHdyYNJhDQpH65OVrNoBHnZVLyfgu2czgWuRlQkvI+7Q
         6C9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGUWzoNi9vq9bm6CK2p51Rg3yY4asB6BEWlyLJRLkLuMhxEHqy1n3acEvGY1RtETgczrjZaj1zWOT8rRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoG1ABapvyaMXd7cvU+Gc+FnE+S06p3qcpr36Qecn+uH5GqDEz
	k+6CLydP1q7qlhqS9PRPk9jcstw/58tuMMggwGAh4cHIHPpHf+33eSdSH+bjOPqWNH1sBhaH+xH
	7zZ86JjOVWkN46p9vbwYtKFQIu3Rg9RPNVFzPkN8a
X-Gm-Gg: ASbGnctls9PpmMUI6V9vrVwOgEOyTRyvEmN26JZZ/TPImjflxE9Nzg3yu4J2ttl81qG
	Gt+hlPpEYQytZPEJDU+yn4mQXhgSMZo1PIDGj3JkIDfL4lwC03HMeqGx3/UVsJCP+8j6PAWlvUy
	SpHNp7vdvOUCZanLynFhMk6BoVhvRJhfGPgt9Zmtc4nzfpw485jyu9O1Qvbtg9n0J7mLOntuUkZ
	pZTK3OL
X-Google-Smtp-Source: AGHT+IHeyEi742aFO3hV++AeipeYKf/qUxIOv48p8HeoniBt1Dakppqs9grY2COUbSw6mP1pEx8383vgJzT2eDE3tHY=
X-Received: by 2002:a17:902:c94b:b0:223:fd7e:84ab with SMTP id
 d9443c01a7336-23fbfd1a554mr1233415ad.24.1753491497158; Fri, 25 Jul 2025
 17:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com> <20250725202809.1230085-2-zecheng@google.com>
In-Reply-To: <20250725202809.1230085-2-zecheng@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:58:05 -0700
X-Gm-Features: Ac12FXzpELJCcryfhuSE4R5Cmu-ZJknOKDSv3fvvFdgvz8mX4aUbhKb-Qd_Capc
Message-ID: <CAP-5=fV3KaHMR1eFtUh0kY6CmVkZjw8vJ0UNcY3phH=2jsiwyg@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf dwarf-aux: Use signed comparison in match_var_offset
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:28=E2=80=AFPM Zecheng Li <zecheng@google.com> wro=
te:
>
> match_var_offset compares address offsets to determine if an access
> falls within a variable's bounds. The offsets involved for those
> relative to base registers from DW_OP_breg can be negative.
>
> The current implementation uses unsigned types (u64) for these offsets,
> which rejects almost all negative values.
>
> This commit changes the local variables within match_var_offset to
> signed types (s64) before performing comparisons. This ensures correct
> behavior when addr_offset_ or addr_type_ are negative.
>
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/dwarf-aux.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 559c953ca172..bf906dff9ef0 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1388,10 +1388,12 @@ struct find_var_data {
>  #define DWARF_OP_DIRECT_REGS  32
>
>  static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *d=
ata,
> -                            u64 addr_offset, u64 addr_type, bool is_poin=
ter)
> +                            u64 addr_offset_, u64 addr_type_, bool is_po=
inter)
>  {
>         Dwarf_Die type_die;
>         Dwarf_Word size;
> +       s64 addr_offset =3D (s64)addr_offset_;
> +       s64 addr_type =3D (s64)addr_type_;

Would it be better to make the function take signed types? I'm
thinking if a 32-bit int is passed, with the signature as-is it is
unclear if sign-extension will happen.

Thanks,
Ian

>
>         if (addr_offset =3D=3D addr_type) {
>                 /* Update offset relative to the start of the variable */
> @@ -1414,7 +1416,7 @@ static bool match_var_offset(Dwarf_Die *die_mem, st=
ruct find_var_data *data,
>         if (dwarf_aggregate_size(&type_die, &size) < 0)
>                 return false;
>
> -       if (addr_offset >=3D addr_type + size)
> +       if (addr_offset_ - addr_type_ >=3D size)
>                 return false;
>
>         /* Update offset relative to the start of the variable */
> --
> 2.50.1.470.g6ba607880d-goog
>

