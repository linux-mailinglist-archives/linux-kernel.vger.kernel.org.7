Return-Path: <linux-kernel+bounces-859024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86752BEC805
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E369919C5DD0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84141A0BE0;
	Sat, 18 Oct 2025 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0FgaumR"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A071917F1
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760764791; cv=none; b=SysbYGyz0VZ76w1KZOA2RlUrD65vTQkFnzyc+IUi4K9iqG4umlCSwJATybM+BGvfJKS7uVHu5xYecy6WEPL3Ulu5rSpht4U6xqYbLnQGzXjL9oh0eVzUIYpeVf10+Vfl6VTcYZ5UiXbWUlz7ly8J7piGtzK5IlbkDnfpo0CTovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760764791; c=relaxed/simple;
	bh=m9Q3wCPB0ojOMK2Varp7yF7jF6NgI0u/1w2UonBZYmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baXZQHXEPwZ202SZ2xryItKoeFeDe0zFZdoD4+TyNlvx6n62kWYeTLcdFFajpIDU/z9dTxMmY+/s8fNVnjC5soMdcigbzxCj4KaLQxiRXhthepvB1FYtRq8pFQKIfg6IrgJ3IlFdQe0y4Adfw2Ce7Yi9rXPFYhNR3/H/bE26lDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0FgaumR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87c237eca60so22423996d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760764789; x=1761369589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZogXjcOIkSnlm6m1dI9qrbTyG/Vvh6qq2QtKDAWZ9F4=;
        b=X0FgaumRDZh+kg+rkLaYfXBA+Uc92IpnIvhAV1pP9+az1ld95nDPJKIOOJB3Ta/txc
         DyjWvXwq56gWvDkKIMkped7uMZvbQFpxNF7p2Q3aXLOZDsIFCHr3maCt8K/6S8beBG1+
         FrBOYEXPk2bqY3lFwUcdlUXfZHDK8u9q5w0+aI3J503yifiKrsOdQ1PqeV9moE7JR3a2
         VFdEztYsEbxSGyP/DNQ5ctXBkKZXfQgM0iF3aVvPwlo200Z7ga0oDCbnw4GkJM/FapxQ
         ynHn2Wc0HSwMFiS9wtwyUQE5iNumbP4d0WMOPBGNTTDzG73a+itSWmeh/tT89Ryj3fCT
         2+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760764789; x=1761369589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZogXjcOIkSnlm6m1dI9qrbTyG/Vvh6qq2QtKDAWZ9F4=;
        b=jcX3AXo6HPUCbN1eWmWODMdIHbaxaOhJhrw6f+5jTCLpGJ7wLCnOmHxO8pvAwdj3qq
         aXLfHJ+Z6mgHqwDPtllosqe1L57aPtj++zazUvC2SAEJUqQq+LYjPw3PU99XoXZgrtFY
         V6GSeeK6cLUha2x4QUlxXt+0GT+cRyoY68rPD6dfoA1mq324uscwiCxu0vrcJfqo+E7p
         2egXUmEyHtiO6+cP+fndLyP+vSoWbQBhrZSm0CG8Sfi2FJx7m5cY8LzzjEp5QoZGtxNc
         71hlGyMsheCD1RqVUXQgKc62+ZyOhlPmA8l/E5QJHWALnGRHPFcCIIj1SHoQ3N/nlSyF
         gLCw==
X-Forwarded-Encrypted: i=1; AJvYcCWoH1xvrgpVBBntqrvRzZbhNIbQ0nHkIk2Uuzjb1P+gUtargx21BDSo3PtDEmY39V4+IDIm/Mh58dwGUP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywvOhRMvPIMn7L1oa/Vge240YWRPGO73/P0GuGhz76FyeGa78G
	nOp3ZmlOMF7AgISXD7a6j8A39P53e9bYlzKVKHYPTJPqIMm78tPo0OyZGTQR7XNBdupwbOp0JDD
	jAYuvxst8D+GWL2zRpEouVqZOqD35bjw=
X-Gm-Gg: ASbGnctPqTNQkaAEAEknwiO0AufZpGpaDE3suE6Uxp74CEeekm4FAOuE7C0jnY+Xlk7
	N3HvRGBd8cDwLVv+drE20mRCVaB/X/Ehcs706vjLbAVp8GwzXDFpjQpdEeWQmNYGcEUpECkTLjS
	bQR5vxCyvw/vmuo16xRKezvW/owUCvGG8bS4Z37eKxxJz3tQSViiYnK/SGVArMwA1JD/aEx2OIQ
	R8orqG4b792E3ABJmwNtiuxXgQKkdQkF0fzZo2Dpr96CmKTfxnCURr2UUsuX4iwc0CJft4gUjby
	9NDv
X-Google-Smtp-Source: AGHT+IHhSo84IPocM9veFr1T8h8TCcjVP2GqaH2UgQmyQF5cTThsv1inzPHCl7GpEyOCHDd+u1vl/TmG8y+dcznfJ3Y=
X-Received: by 2002:a05:6214:d4c:b0:787:8e43:5761 with SMTP id
 6a1803df08f44-87c2081dfdbmr84963416d6.56.1760764788714; Fri, 17 Oct 2025
 22:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018045902.21665-1-irogers@google.com>
In-Reply-To: <20251018045902.21665-1-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 17 Oct 2025 22:19:37 -0700
X-Gm-Features: AS18NWDzgNuxVyTAzbzE5rLpbz_CXvPxcUXsFNspFB4ai4PPU3p4_sGq25mvINY
Message-ID: <CAH0uvohAneSDaXoDfNdOhg8Osnk4AYye4B59zhS=NaGj4upM5A@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Don't synthesize mmaps unless callchains
 are enabled
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

(It's been a while, forgot to switch on plain text mode)

On Fri, Oct 17, 2025 at 9:59=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Synthesizing mmaps in perf trace is unnecessary unless call chains are
> being generated.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

> ---
>  tools/perf/builtin-trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c607f39b8c8b..a743bda294bd 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2005,7 +2005,9 @@ static int trace__symbols_init(struct trace *trace,=
 int argc, const char **argv,
>
>         err =3D __machine__synthesize_threads(trace->host, &trace->tool, =
&trace->opts.target,
>                                             evlist->core.threads, trace__=
tool_process,
> -                                           true, false, 1);
> +                                           /*needs_mmap=3D*/callchain_pa=
ram.enabled,
> +                                           /*mmap_data=3D*/false,
> +                                           /*nr_threads_synthesize=3D*/1=
);
>  out:
>         if (err) {
>                 perf_env__exit(&trace->host_env);
> --
> 2.51.0.858.gf9c4a03a3a-goog
>
>

