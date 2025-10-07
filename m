Return-Path: <linux-kernel+bounces-844427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E511CBC1E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE63F3B39E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7272E1F01;
	Tue,  7 Oct 2025 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kg2cGdUM"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5719E7F7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850153; cv=none; b=hoWm4gi46Mw5vi1LEMj4CWR3j9LE2wBTDaa/kVJjAFdIi8ga2EA6Mibvjx2ZDdh4a1KnzmkQBCSEWVV4fPsAk1xssuyLzZywHs51JAX+gLtzTEpK1/0sOaxKUyKPdgKwhj8aRdppkG1aoZUztPXbE0pSNGWGt5QZCC9X4EjuuF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850153; c=relaxed/simple;
	bh=+O7bISEqVBf0751J7i6gKnbU6B3BplTUtsXYsCjQPmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMBW+UjpFNjqrMHKS7hCYwqctn8UrH1bpEOEb3KH2DQ4gjfUW1kF5/YDgwwKPo3RUn2auVgiP2/kL2q8LJ+NW1blvVFefwhELimQ7ur7qBKau46f6FUKXE6MBZZ9u+3uLHUekWaB4Yn0Lgtml9prs0A9WG/1q/5v0QmoY1hRtno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kg2cGdUM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eeafd4882so269205ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759850151; x=1760454951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlo69vXBzGlsQ45ur0452IkiksgpMlh1RM1fVkx9em4=;
        b=kg2cGdUMwBhUfTlf2kaeE3uOJ+85rJYDlj5cvEsR+Y1E/gfHQIxNeLgXMI7VgOmDsu
         j65a7itZ8uP2f6Q3MV2qqCKUvdSTzmpL/n7W4/XWB6YCtvkhezqQ/5ateDwxbt+GdMMy
         cemiNUV/SgNEW89IYmXLa57o4Bj/UWilthjArvYtw5Mo+S/dqXdYZ0xdw6BUNhaIZf6W
         vD8ELixYsool7fU4tkUAdzrgS4EaIyJO45Vlp7wWhUnKtVFhlFJCICb10hSxmX77XQd1
         1Wh4k/wMbByUu4w4nLKBPSfLiEpaTTX0KDcUUT/vSrpyyXfubmSjjRHCtyFFP/EDm2Qn
         NdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850151; x=1760454951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlo69vXBzGlsQ45ur0452IkiksgpMlh1RM1fVkx9em4=;
        b=G3mv9yT+9+Mb+ctuMpbd80H3QHknsSzoOjXbc1YbCg2vG/OwPs5DQEBUO9uq4oSUkm
         jsKWc5VPUcvXv5pwEOFIhiRG8r9ZFQAxvMmXHqkW9+c8OOTbeViNxQEbXXxIKgsl710t
         LX6iy6Guq9tEr/4tVDmwEt7tkE39+vyOIWuY7jBLK3vpFvGeziGJuIUxic4xem7rbsJx
         atjmrfUMfdkvCATUvgw9IqajfcMZVJe4knz5qjalsZwxYlQPAMEmiJfBHdAdXZKRl5H2
         YIZABdvs57n3pKioH/jjdC42oIjPIAJy1OSxvOyP1OQzHZgbJcUIjy5yooaaZiovdE6b
         /qCg==
X-Forwarded-Encrypted: i=1; AJvYcCUkCLRisNIwo2gwxK4BhqzCZyCIqM/Cf5GOpgtO3mlkuR6BzCEjIyl4ElC84323WfzE11b8Rf/jvJuBBiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkJalxkMRCSFD5TjAYXjyGSAho0WRIggmTA6dKUpKMyrIIlIo
	vwHpvhxhOIoxhzKW8X+bHKM6Xh9UZNTUf5+99MAuPeaZyfmfR/pDuIJE0CMq2LNZCXVvXZgtOKc
	HBvuNXNi1uSABsx3TLlZ5k7B4xcacbJgKHt8HXaNU
X-Gm-Gg: ASbGncul0IcauZqsJRZo8zcekGGhDozu9uDsYl8DBMlcuwfaOM1+GkB2txozlXlnaK7
	VTSEYLWrsq0CNMcOm3Wv5WKqLVJDOEqsPU+xYLIDu1VrNme0IixO/R9zVLrXjJJBIv49k1y309o
	jzxmatxqEeJWx9gZ9G3zcVB1FDASHyklTNlo0kA2+luQsp6Vqobu5Oi7uXh8PpLfyTBJmnTN98b
	nup9BjPTKkyrWtWrZcg/T9eWvxii1sgY8f4A/V8ZCNswN3j8TlCmdJcP5GdAYrR0D5X
X-Google-Smtp-Source: AGHT+IE/uOsOwUEeVYBrEonRjm9VvP1sGfvE+IsM5xAckvBMjr3635ZuUJOoKu8Y5u7PksTQSo+oq5sUdsj90Tf0J04=
X-Received: by 2002:a17:903:1a0e:b0:26a:f9c7:f335 with SMTP id
 d9443c01a7336-28ecb749b04mr4252835ad.9.1759850150956; Tue, 07 Oct 2025
 08:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007140909.307940-1-james.clark@linaro.org>
In-Reply-To: <20251007140909.307940-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Oct 2025 08:15:39 -0700
X-Gm-Features: AS18NWA_qSIjsZuAGkUFa-15Xd7pUMgLS5uE0fl0nS_c6et3z0hY7d_YvFzx-mQ
Message-ID: <CAP-5=fUfDtO5oVoxsCeYEuiE_kEYCOjU7tJjVS68nQ3cxo_Uqg@mail.gmail.com>
Subject: Re: [PATCH] perf tests: use strdup() in "Object code reading"
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, acme@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 7:09=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Use strdup() instead of fixed PATH_MAX buffer for storing paths to not
> waste memory.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Applies on top of: https://lore.kernel.org/linux-perf-users/CAP-5=3DfV1N-=
j+f4GBFnDWsmoMZcz_k0U=3Dnu1A7NZz-g4gzCH4KA@mail.gmail.com/T/#t
>
>  tools/perf/tests/code-reading.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-read=
ing.c
> index 4c9fbf6965c4..88408eea9e41 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -43,7 +43,7 @@
>  struct tested_section {
>         struct rb_node rb_node;
>         u64 addr;
> -       char path[PATH_MAX];
> +       char *path;
>  };
>
>  static bool tested_code_insert_or_exists(const char *path, u64 addr,
> @@ -79,7 +79,7 @@ static bool tested_code_insert_or_exists(const char *pa=
th, u64 addr,
>                 return true;
>
>         data->addr =3D addr;
> -       strlcpy(data->path, path, sizeof(data->path));
> +       data->path =3D strdup(path);

nit: should really check the memory allocation succeeded
```
if (!data->path) {
   free(data);
   return true;
}
```

Otherwise:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>         rb_link_node(&data->rb_node, parent, node);
>         rb_insert_color(&data->rb_node, tested_sections);
>         return false;
> @@ -94,6 +94,7 @@ static void tested_sections__free(struct rb_root *root)
>                                                      rb_node);
>
>                 rb_erase(node, root);
> +               free(ts->path);
>                 free(ts);
>         }
>  }
> --
> 2.34.1
>

