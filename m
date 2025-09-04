Return-Path: <linux-kernel+bounces-801199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D64B44170
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375871CC251A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52FB29AB07;
	Thu,  4 Sep 2025 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlu9umTu"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE745281369
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001437; cv=none; b=OUpBMjgWZnVmqBevvz+hOOL2E6/6kWMEay0BO3/TZ7elyP476cPx5uVtvTS+9r4PHDCADKFP1aUm5yI992xMyu4vByFSUA/R9Nx+I/c5R6znQIokycwfKkXtx57knMdb2p8pYDGS/Ny8BXDWx8XrP4471JJrRGnp0RFmcrAG5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001437; c=relaxed/simple;
	bh=5bwgftlti0OnS19E8s5I3qUBUN5cb0H7I5hTJs1jaEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlEx96AQHsJHvp5WBMcFs3Z96iLW9wqu1K0uUVd7Sm4wSmN1yKsW0QCLBT9KDfIFq6qwqv0ogAef0bvCHU7sfIDVu8Hww3rQ+8Z30uokFNN2ih5wRk5FQLEhRngAi74JK8s1vKkcHjPQFmpoC7/AdR9HqeSSduoyQgrPvHDPyZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlu9umTu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24ab15b6f09so202775ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757001435; x=1757606235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knBUAJ9UaN+FZLHj0gx+L4m7BuumlipWhHmFcevIGIQ=;
        b=wlu9umTujnJHZeYWpfX93lNgSOkFLhU4c/fWbrf+hzKIES8J2DN9jQ5vAyAjUrqUtX
         CjzT9pEIHd/3SPKzuH+gS9UYJxRBwzSoXWs9PuZbTniH/c08yk28M28OoXYx4FYzUbwN
         o0uR7FYWRTo1hqQvAH2x58rYpuzADKA99YzlxvGy4j/c1kOb+uBTkU0/8LR+N50SWSsy
         2KfsAqo6H93bFxFC9Ge1rYRMW4dbFv8hgmWuJXpnVMBmA2YgfaNYBYKmJbEJ1+QOJsdf
         FxDAx5ywNmdXI4tLdcEgaXFSTFEWd92maIEoTY27CoIWgHV91oXvzuX+9ldOIuK/qaHp
         L+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757001435; x=1757606235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knBUAJ9UaN+FZLHj0gx+L4m7BuumlipWhHmFcevIGIQ=;
        b=DJ578oyKRddzRfFMAFiNYpwGMF7XBdoPd5O/2OKpRsN8tePFDqmB37HmuNb9cK/YBF
         4d3prtkL9fH+WGe2/Kg2xWcKVi4s7T4DEsHyNSXRUoI6IOzt7O/b84SPxs5uHkmIGAX4
         +01xx0JxulZ05nmMKGQ1vK87pGUclPo1vgACt+4qrNx0ffauOetK02QIdG4lg6oa4ABz
         qCI01OgrHDF6Yyn4TChuVCOLPn+3zbSIYWXi/J5VkCKr9HRo4sTH0wSOR5W/1csG5uPU
         wwvBOkvFo/OF+jauFzC2PttZ8OCGxUFXdUWQgmqmAUafCvslTMu9mHbVSF8xWBiqdd0o
         VcoA==
X-Forwarded-Encrypted: i=1; AJvYcCV8y/KIY6Dq+aJXdBKcPkdPNmIavwdj/6wxxaXDthEA7H1UYO36Rt9Y9YGdxFadp2EXDwuEjtHN8vyPQkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCIfXzxaaLbDeWcsISLE18xC+0Q/0w1jOZzHcaYFXgRjKijoj9
	vmAzQl4MaLJ8vTlpg1QrFqw6JX5xiU+wtH6OFG016+i2CYf+6TYY/31JPd8uF1eoJupJI5thk3G
	XQUQhGCatMSWvi4jpqXxJs7PuIH0XRRGsv8kUrpCLEOKscauwgWr1AdIVYvs=
X-Gm-Gg: ASbGnctWknsR2R8PKXYEZLaatElxtjq+nlC/NqZMtM1UZjzwMFP6QhpTEoKcuQe5C9E
	RLY7G75/bu89F7hpfIwMCayAI4584+MfW0C1YkRmauyPYmjIBg6SpONt8+z9DcAiVf913AeHB0m
	uPSz7mKpFE3vvPC5aAWDhBi+niYi655PjZtC/+Lm2lyUX+steWSd90QQMYEEabfMKhFZq7RhyB4
	vRcqKp29v2n/nql2NvFPeKQhzr+gIvybiXsMSGbUnK0qPU5G37E8J8=
X-Google-Smtp-Source: AGHT+IFruwuAGBkh7rKP7RWIUwTJnAWvhVe1xHsgspTlHo9U/RM8g1S8GgdHNUpcy8Rksev/Q7nZoVg7U084PMlX+h0=
X-Received: by 2002:a17:902:e88c:b0:249:10e8:c866 with SMTP id
 d9443c01a7336-24ccccc4984mr3559105ad.11.1757001434759; Thu, 04 Sep 2025
 08:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904090904.2782814-1-colin.i.king@gmail.com>
In-Reply-To: <20250904090904.2782814-1-colin.i.king@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Sep 2025 08:57:03 -0700
X-Gm-Features: Ac12FXwis0ieQjvaJDpAAZ-N5VUsQcVYBE46x0ADT7btZd7ypFajhQSQ5YJpnbk
Message-ID: <CAP-5=fVZ-mQTRzA2qkW2NjB_W_AvNJJ7mNJj5cBh1jJX7X8Btw@mail.gmail.com>
Subject: Re: [PATCH][next] perf python: Fix spelling mistake "metics" -> "metrics"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:09=E2=80=AFAM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> There is a spelling mistake in a Python doc string. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks Colin you are a star!

Reviewed-by: Ian Rogers <irogers@google.com>
Fixes: d0550be70f7a ("perf python: Add parse_metrics function")

Ian

> ---
>  tools/perf/util/python.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 47178404802f..779fe1280a56 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2187,7 +2187,7 @@ static PyMethodDef perf__methods[] =3D {
>                 .ml_meth  =3D (PyCFunction) pyrf__parse_metrics,
>                 .ml_flags =3D METH_VARARGS,
>                 .ml_doc   =3D PyDoc_STR(
> -                       "Parse a string of metics or metric groups and re=
turn an evlist.")
> +                       "Parse a string of metrics or metric groups and r=
eturn an evlist.")
>         },
>         {
>                 .ml_name  =3D "pmus",
> --
> 2.51.0
>

