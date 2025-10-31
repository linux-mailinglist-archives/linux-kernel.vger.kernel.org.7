Return-Path: <linux-kernel+bounces-880650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94EEC263FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173AF1A21785
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A062FD7BC;
	Fri, 31 Oct 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxD7e8Cq"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE023D7F8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929791; cv=none; b=pfmfcc9/5C5HMJzaB/94yD2B3gPTt5f/g33cpIo9q7FlWxoexRrGHFHCwGQLvm5NwcsayNcwOoiMPYU4lS/cM4R4EHfyNQO/QWdUB2Ne8QPhbiBHZG3Q0t8GVtTs+vBjor2w+n4WUshf9HoaQcN+b3mqDCzgm5WSUIEpaz4E564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929791; c=relaxed/simple;
	bh=lkiO8XrUOZOmOcIFgJAFhtGKZWzU3bVRktX8oPYM5CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhOSxu1mRYWZXgMlbssUjPfhYfOKquHMLvDYgSWKSpyk3xP2OdqpcWbp10JjABkLr7njZntoVMzbmbPyHUU3a0KpwdxkCC2x/ZbGCkQ1Td38yXMrSrLgpoX2D7YyNwU94jMayQq/w8BLjEN3aZWwCTnqOGivjtRoyhNNQTn1Auc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lxD7e8Cq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27eeafd4882so6235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761929789; x=1762534589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orEjtXAHj63cwii1Ewu/bOztRrLitJVVFzVJhGPGPvY=;
        b=lxD7e8CqaMJnRgSOY9ZtP5qSUPRiHwNshRTXXbo9XQlQn1jYw1eZfnP/tRmGh/GszD
         ypZMw+aG8oaxfnqxBUJS7F+PZQm9Xxy3AdqBHDAgxu6Zto9D9o5T+I2zJml3L31XIezh
         H55RRs5WAsMUEWlNmNPmo0SfrkpIWsKMOeYgE/fMcsrtedkQjzx32+3zqrp5PuR1h1vP
         +D4xRPr4/RJBgQ6/FzCwlbEizcZqvXT0OMrqdQv+OCFn3HU1ofFL2xMYLdsxDFeLERpw
         KOjMx7HUtLkosN2i6y702EWCdLDIeQBK/lTcYpgFnN5W6aewOqpL3B4sLSTlwFKqwdfa
         7PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929789; x=1762534589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orEjtXAHj63cwii1Ewu/bOztRrLitJVVFzVJhGPGPvY=;
        b=o4WncEfBbVNj2oXTke+zY8wyIB8sQbs9upjAh5cFFqfOtAPEPe7c1A+igTjGaOJ9qJ
         pVL3NvE5vDCYY39YUAaIQuNPc+hq5s9CVTwNUypj/ceRSd96KOlM+5rsy3Nc6ujrFJoC
         RC1P/yoz3QX/0mU9Ea7rLt/eAcZcSJ+20P0jd7mVTj4ta0CyuJvaha3LnLPpVki4brQZ
         NpXmiDnzLet0q13fn6fvQHY7D+m+ecFoDugx5cuBh3xcKCIeBcSqoFM0YT+PkdqYZ2YM
         tLLthE9d3tpb3YtSiSs0LavzzOH9i/XJe+O8t6+3CgJFbyJhK33p5dl1dlyGuf3VzuFP
         e18A==
X-Forwarded-Encrypted: i=1; AJvYcCV36plfILQdl2pqMaCezyu0H7a3S/lgGuqDjrRg5Jws473/60Y4O/W3MxGP/9tq8heJ5EAR3IYZ0OKzxHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrDFiq8yN1VJhb31ckGM6pprb2H2V2yXmXBsMyZmpkXDQ2EBm4
	vVyzZShyTQTCuWTEi4AY4S7DBp7LBU5wUqDhvB1fztB3LvoWb+3hTvzVU3Xf5HMzh81StpkAFj2
	/C4IhA20In3ATdtAIXQoLx3xlIZmS1dy5PhC6CGrP
X-Gm-Gg: ASbGnctXRvzqTcmkzna/MOpKi21dFMKLfeQUmFK6GLlcwzSzEospn7UUsJOORzWO1YV
	04hi7uczmbsOL1alkH0YqtIs6SOYCODjnbWuZ28rwuxmrgN7RdO3Ng88xoD1ANRiAsD6zL+GjlL
	c2vte5U75fIkpl77yzWg50aYTu3qgN8C+1wyRRSYX6Maym1LpBqtRQ9ORCZgbMmTZzuc5X7U7Z5
	aFK6Ci+/MZ0aZ/39yQe/qCZpM9P69zVASsnnUMY6rS3UMfvxErQi8GRTa5+Dws6ixquoT4kHSrR
	78uLea4YK+GObI8=
X-Google-Smtp-Source: AGHT+IEsPnPxFIN1hYlO+t/wmUYP6y9esVa2ldoa9AgpQzw0BQvhvOGZ3gJe4GC0IHDy7KEHxRaubt0hT/sM3EKgjeE=
X-Received: by 2002:a17:902:f60d:b0:295:28a4:f0f5 with SMTP id
 d9443c01a7336-29528a4f6bdmr2781575ad.5.1761929788793; Fri, 31 Oct 2025
 09:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030040140.1115617-1-namhyung@kernel.org>
In-Reply-To: <20251030040140.1115617-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 09:56:17 -0700
X-Gm-Features: AWmQ_bmyg0Pz25RVawZdFY6E21GseqbValX9xKWlZmhN4wDaYncuilO84HOs4xo
Message-ID: <CAP-5=fV3H234wnVkmf04kyJYb=M9gUtZbHigrc7pQKYUXoFSzg@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Load kernel map before lookup
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On some machines, it caused troubles when it tried to find kernel
> symbols.  I think it's because kernel modules and kallsyms are messed
> up during load and split.
>
> Basically we want to make sure the kernel map is loaded and the code has
> it in the lock_contention_read().  But recently we added more lookups in
> the lock_contention_prepare() which is called before _read().
>
> Also the kernel map (kallsyms) may not be the first one in the group
> like on ARM.  Let's use machine__kernel_map() rather than just loading
> the first map.
>
> Fixes: 688d2e8de231c54e ("perf lock contention: Add -l/--lock-addr option=
")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_lock_contention.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index 60b81d586323f379..7b5671f13c53525d 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -184,6 +184,9 @@ int lock_contention_prepare(struct lock_contention *c=
on)
>         struct evlist *evlist =3D con->evlist;
>         struct target *target =3D con->target;
>
> +       /* make sure it loads the kernel map before lookup */
> +       map__load(machine__kernel_map(con->machine));
> +
>         skel =3D lock_contention_bpf__open();
>         if (!skel) {
>                 pr_err("Failed to open lock-contention BPF skeleton\n");
> @@ -749,9 +752,6 @@ int lock_contention_read(struct lock_contention *con)
>                 bpf_prog_test_run_opts(prog_fd, &opts);
>         }
>
> -       /* make sure it loads the kernel map */
> -       maps__load_first(machine->kmaps);
> -
>         prev_key =3D NULL;
>         while (!bpf_map_get_next_key(fd, prev_key, &key)) {
>                 s64 ls_key;
> --
> 2.51.1.851.g4ebd6896fd-goog
>

