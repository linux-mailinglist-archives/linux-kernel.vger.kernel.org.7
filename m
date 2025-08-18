Return-Path: <linux-kernel+bounces-774550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ACCB2B40C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1378188EB09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4224EF76;
	Mon, 18 Aug 2025 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1uTwhgCu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674F21CA0C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555442; cv=none; b=WeM0SredJqUDZT8BbgM675hLiKFicyykaeCH9L6QGsxbCE6NJ2N6B1IBPVR6efb1qwF4Xe7CYz3vxe/aLGEsoe9glyo+BiixDKoa7w+5SdcK6bohqlRGN1Kq2NTzfpBBPkjYlkR+fCyBs9+P5njjAzUSz/LTnxvaS1eogL+cZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555442; c=relaxed/simple;
	bh=G6u7wXNrmkVxiUsvwqfcp81Ql15S39BbqPwoKLL7atM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rf4QRkfhB1pERtFmI6ALWdoSYaReANloHDuqiQZs7baRIF+FvD0s1G3998Xy/SuMt/xAj7svvhll0tvAgaXJCciKc3fXKNplO0km6umnXFr6Cg7Csc1x7QYps+0TnvH5z6k9LLUBCZksYIJw4zrVEyO5D0y/MU09o8DFxMy4gwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1uTwhgCu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-242d1e947feso74375ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755555440; x=1756160240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZA6ooLu7qT5iTdye/lR8tavBy+pKLzuc7v/W/TQXdE=;
        b=1uTwhgCuKBjIo6SSbIXXQC3csjQynl0U2/JcCYeAq2i4XF8LQwLXRrFiJDTQxFOzUY
         +lOGYyWvVWyMQlUAJq1zER6qNownwaasVkd1+T/NPMjAHYrnH5tdmWlOq0JyNYJO2xKT
         CVz+WnR449HtQOWvBtkT1VzLmaqhKjWReYibDtZsKFkXd2mTFTk/Gcq7OufajWP77QMN
         cuY/PvZPzcx+sAHQLLAwTcYmjKwdEly+3+bxSHT/Yq3dCLzfrnNwAfOqxE0BXVHmy3Wo
         ZTm6jfTQhyVYRX1JdBgPrLcf0YAa211lxnWNtjczP88xFUq57Si4zNNnQMfRMhXvyI3o
         mn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755555440; x=1756160240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZA6ooLu7qT5iTdye/lR8tavBy+pKLzuc7v/W/TQXdE=;
        b=jDMBD5Isoohq2pjJC5X1nagaHPDfeJg9wQ7a7498wghQzeMAFkbGkBQSVhDs1+OT4J
         Vr80zlbVnrmma35YIeGwQPyzMpwRrk7FXQITzcpuUqGJFKkAJ/WNIvcDjWHD8Ccf6txP
         3aXNDgVHVhgXmg+0zh3KsbTvIT9KL5FnKl0I+btnU27zIm6zBWycpOB4tM4qJmrnPWXq
         JXKWFwSiJqK30PNgqn7ItbeqVij0ErOmHIOeJ0oViKzzxrS0mXJ6QUgTkVSLNA8W+doj
         lr6T7rn8y39NxV9zd2SKhBobkx5/PpkNE/X3nOPptqDwODTk6CVvT1H2XEhVRXJj0rDR
         V1rg==
X-Forwarded-Encrypted: i=1; AJvYcCXgCQgkHBeJSiqAK7R/m+P7fBU5gy1xyW8tShRX7hAl0OiY0zY7MH7SXW+wABNQiiRZtJ8pIN6wROcmTI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsv5sm4mAkJv+s5oEKSvCiAWzCoQ4l47Y9hg7GdiOfoRo9baV
	f+kTifXJihqEb9BhOC0c4DTRt67yEd5RuJ1Rn2yjefYqE8qD6hQh34qOk7gAbQbn98ZbKbtW1Hb
	f7ppICdK9QaUdYd4QfxBWK9YBNa4auMqKqmuRTuIq
X-Gm-Gg: ASbGncuGi6Gkemn2TD6TLVql67PgBI+PuOeYG5x4wvv5KJRMPp3GgPLqhBrFGfU471o
	wEClKNjFvFglGnlpxDv7uMlPjfwAk+BIJQkKxBCQlALBv6ttVZfRw5TnsBXPA6piKydqfSindaN
	ShKVZ/UlRFBi/3sK74JDwjqXIEywrGro06vfoUlx4vLV51RP2CQaukTqD5hMeme8nEOh3+pGi7f
	oV0tdJaJHTFaXSJnroLzrHVaSfAhENCBnDlLrwVXUdFulpy+ORlNR2uxAutrhF1
X-Google-Smtp-Source: AGHT+IGXJsBkIUyGYgZqYNVTSCHvta/qmXssx4kJMSOLn93RuqiAfnx5Np6n2KBt1ebJbwuHyAvnkjE2SYEu0Z6XWKU=
X-Received: by 2002:a17:902:e804:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-245e064c79emr421685ad.13.1755555440291; Mon, 18 Aug 2025
 15:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808222650.2218658-1-namhyung@kernel.org>
In-Reply-To: <20250808222650.2218658-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 15:17:09 -0700
X-Gm-Features: Ac12FXwDIxx6_EEdocwcH_4PCk_uSDnQj-tMx1M3oppYAFONzz4UzLlze10Mx5o
Message-ID: <CAP-5=fW=Lz0NDS2=D2cKOAjVT2qP6Lw3QJsCqhac4w-X0XjH_A@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Remove a pointless check
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	David Binderman <dcb314@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 3:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Static analyser cppcheck says:
>
>   linux-6.16/tools/perf/util/tool_pmu.c:242:15: warning:
>       Opposite inner 'if' condition leads to a dead code block. [opposite=
InnerCondition]
>
> Source code is
>
>         for (thread =3D 0; thread < nthreads; thread++) {
>             if (thread >=3D nthreads)
>                 break;
>
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/tool_pmu.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index d99e699e646dd651..f075098488baddd9 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
> @@ -239,9 +239,6 @@ int evsel__tool_pmu_open(struct evsel *evsel,
>         nthreads =3D perf_thread_map__nr(threads);
>         for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
>                 for (thread =3D 0; thread < nthreads; thread++) {
> -                       if (thread >=3D nthreads)
> -                               break;
> -
>                         if (!evsel->cgrp && !evsel->core.system_wide)
>                                 pid =3D perf_thread_map__pid(threads, thr=
ead);
>
> --
> 2.51.0.rc0.155.g4a0f42376b-goog
>

