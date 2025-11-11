Return-Path: <linux-kernel+bounces-895994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CA5C4F747
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209A13BC5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9C28369D;
	Tue, 11 Nov 2025 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USjugteI"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F8280329
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886180; cv=none; b=mulSQSgkiY6EsdZBEf4KUqjcnq1/VCXV9pINa40wFWh2cWGfqoM/KBUwQd1FwKmrsRP3Uu2iTyu4S2gnnDrA/LoVb5XZnMzUkp1q1QpCPQ/9VbHkkcDPYDnMCQhmevXib3rxL0LxwB5mB3yhp07P//idXND+quUjk+LLXyh9+ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886180; c=relaxed/simple;
	bh=1pBvUNJMalSWx8tG7uNlB8Qsp606sbxH7cQgaKu+NdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpN4pkvBGW7xGZ30YwBZp/v3Vy822V1sRLuTVu9zfkD/vO69tfjxZmgxp7iHOm5BuIqyh39d2ghSmn0Uq8i9UTRcVoqG7H+gECUTkXQR9Tx/wOzFyaRxo3H8avXfYYVTvurFMpgLvMZClwOY67hY/A4ebxxuqVUd7XDfZfplc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USjugteI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e13bf404so14115ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762886179; x=1763490979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYswEPzRlK+mthA04wWtQO8wabtLWYDKjZICxBjkS8U=;
        b=USjugteIlsFFClvnJbEZF8GmkKElOXH/6yE8JwebydVXKPazYTi3fGOD2pYjP7Iayv
         JsO6BlgZrAJZTJFjvRy4o7PU9VdXLx837cIHUJ+jDPY3QGbaAvzDjiYegWQrL0kSEzyw
         MDUU+HWWhg3o7fkL0sAlCf00fwKQxSRvCl2kx48SUcoU2uSs9iaVx1oCrAm7gK8rlyz8
         d/F34AJTqLZ9EfU2UveLw6P8B3a3tbz/MuoIZ6l9jeRDdUnDy/6wUWg5aKjYATMb0H+I
         LuM8mWGL+pO6oYiMvLBevRBJxyzHaDljpKP7LAFjH5NZl5/t6hx1EFWBiXY98ggFE56s
         Ltmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886179; x=1763490979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYswEPzRlK+mthA04wWtQO8wabtLWYDKjZICxBjkS8U=;
        b=ooenTeH3NlwIOaHAGsP1QbZ7MFL6yoGenCzkn/owC+YeJ/MTrNDM8xTincEfQUfcQN
         J9ngIA8KJF2AkIJNuI40kPzW+18dV/rTicM7Egu1LZpJBnurUrawXEnzfH901yTD2xvN
         1iBbZEC6lmtUqa+bNPg/pY6ozesDYeUHHugFdAkAa3OHf8XScXRJPlynstGFAHklXCWl
         z6OoNXH/tUAAI6FX2MCIaxbaj3ppk11VMzLcBVfcqjmhkesGlmwigobR0kdSbZjcmunP
         HM+TJKRsgGzUMupUEoN6POdo6rk57orlbPz87CpaLoJMKUfn78K2XSqaMrcwhRVVOsYh
         mMVw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/NDOUf3pv1yUWwX9duswHqVsl55NORJMOcE8Cn4AfnlAUT5dWdpmwt163kW8t2b2z0K5FasVWgB3WLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9WVmS10x72kme0e794HgKNIvuSyj/qJ2jCDGFQZ2/8pRY2eH
	rn0L7G10jVHGhswzXJSz+V7PUZ+LkPjGvBmLaUr0TS6L6mIM0p4xPKRPU5tIsNSdh+8M/ZSCUm8
	UpFDt3fhGu0kEyn6KIgfJPT838mpGQ6qhxChdmuB0
X-Gm-Gg: ASbGncv8VNQCwACSaoMs9A2JkvCQn15V9pVAQ4Xjami8nD2HKxaNxbAF3t4Nu4eZUJ5
	MxiIx0lpq4MqeR6yhw1v2/8rq/pLPX40Lka1IVZdk9GT0hAKSAg9IKWUPF40i79mDmyp53zLGOL
	hw/RkaO9Po8bTCrMly0EVnCEXoK57PPNv+s2vJGW5vmiKDTWspq8KQhp4rNcLnfKZ3IwW1mNU6K
	iN0/RBKEfsB/Ng2SwjrIQ1WrlYNOU+8fOgHa/GM2j2QC0DfHiI2sLhc2VcEYfR7NgxnaVXlH96E
	X1TVUIcW/kD7+3jxHT0xSUzDCQ==
X-Google-Smtp-Source: AGHT+IE9BeTE35laGTdRmTn3te8Hb2F8tasmp7+CYxRqo9ta4KZit/BcUZa0e4dYpT+XU1sD7lEfxFQhKg04tGEuUls=
X-Received: by 2002:a17:902:d2c1:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-2984f7a74f1mr299025ad.2.1762886178314; Tue, 11 Nov 2025
 10:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111075944.2328021-1-namhyung@kernel.org>
In-Reply-To: <20251111075944.2328021-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 10:36:06 -0800
X-Gm-Features: AWmQ_bkL8bvdtE6EATLhXQExRW-2Q0l_3acxh8Ac-qF6d7y_2VzNr8x5gTajQEo
Message-ID: <CAP-5=fV6Kt0qeyG=WkFgw4EGjfxyEN5HwS_KunC3VW7QeGn7OA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix missing feature check for inherit + SAMPLE_READ
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	"Chen, Zide" <zide.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_REA=
D
> on recent kernels.  Not having _TID makes the feature check wrongly detec=
t
> the inherit and _READ support.
>
> It was reported that the following command failed due to the error in
> the missing feature check on Intel SPR machines.
>
>   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3D3/PS}' -- =
ls
>   Error:
>   Failure to open event 'cpu/mem-loads,ldlat=3D3/PS' on PMU 'cpu' which w=
ill be removed.
>   Invalid event (cpu/mem-loads,ldlat=3D3/PS) in per-thread mode, enable s=
ystem wide with '-a'.
>
> Fixes: 3b193a57baf15c468 ("perf tools: Detect missing kernel features pro=
perly")
> Reported-by: "Chen, Zide" <zide.chen@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Perhaps also:
Closes: https://lore.kernel.org/lkml/20251022220802.1335131-1-zide.chen@int=
el.com/

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 67a898cda86ab559..989c56d4a23f74f4 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2474,7 +2474,7 @@ static bool evsel__detect_missing_features(struct e=
vsel *evsel, struct perf_cpu
>         /* Please add new feature detection here. */
>
>         attr.inherit =3D true;
> -       attr.sample_type =3D PERF_SAMPLE_READ;
> +       attr.sample_type =3D PERF_SAMPLE_READ | PERF_SAMPLE_TID;
>         if (has_attr_feature(&attr, /*flags=3D*/0))
>                 goto found;
>         perf_missing_features.inherit_sample_read =3D true;
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>

