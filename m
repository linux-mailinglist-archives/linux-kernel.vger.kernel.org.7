Return-Path: <linux-kernel+bounces-821154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68256B80965
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AA11C2772D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68396335954;
	Wed, 17 Sep 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3yQ6njjb"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F390285C80
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123078; cv=none; b=SUNA/R2YsFghxKh3sbj96/JpnCm7CqZN9Gn5UXYBlNu+fFcNjD3a6dZz94LI1XdXo8c+i44JvLKY58AfXknj0XwpT2YPFm9G3lsuw2on5eS27/Xzm22eNQJSRjBsp5tQIOsciYkDCoSSZj3ZSq91pepn1tQItrJAU+uaSI2gVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123078; c=relaxed/simple;
	bh=Q9p0ElTEfDeyRmJGVtQS7BZacADA6lcsIfSZqPI8CPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8A0NMOq3W1JZgeXoaQDkFBpiPkysggyaFbz2JaMsBu2FuTgEBKTTRHGwX/Ktnz3F50qIbtKH4qsncg2YXSH+Eikjj+de2Ge2B6aUEl2nlAiYA/bLbeAK8o70yWSFDHZoIQVuknk/W/qukZU6JSDY352ZBWxS4/BhqmBIWN5lUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3yQ6njjb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-265f460ae7bso193185ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758123076; x=1758727876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP2yi9kYnKCwIrv9Gb5KpJODKy5MEoQhUbHkafFHfNQ=;
        b=3yQ6njjbt9I5qm7wFeO1gZNhSoEzMLJPUQjOcdIvmwVYTX3TdzZxtwsXNn6Do61E/B
         w+GINPspSdv5n2RmuQVSY1P7Gmu829FOiD/BYf95tV+tsXVo6Z5HZkjiDUKkcCYZd3DJ
         6JzEbVq/dY1ocspgHR1j+ibqQAAbKX88K7Vn3Is6854xDw/oE2UFfcfCLUhQB8+0vkH7
         iQcXjz4yh5eZWrWRRevXh5UxMU7ya+47RPjr33ILAwjF9qhx2CUOC/7wqBHeQCLibyNq
         BjelaGr+l7KbLE7YuUVwe2NGSSvCM6DyzSJyKVh/loJVr47wAqI4pkNeNAR/YVqC5Bdo
         t1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123076; x=1758727876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP2yi9kYnKCwIrv9Gb5KpJODKy5MEoQhUbHkafFHfNQ=;
        b=whOE12e1ptCcAvpluqUFsI1CfMFCyI4j9U1DFkw/sMfJTNTEm9CLyJLk9GgLbaLoT7
         KIi53AfJKqX4ccY0wtmue6ke2Pk5F6eWhXSbP2v+l6yImkzR8WGFHiPt/rV6UXz8tSI2
         wCPFHbUgopW4UCM2rqG2SGhPsh/pNgIUJm7vlm3P4lLzSRRnKTXG+Khutb7f+HU+j/qS
         5TjOiX7iQHN5Nf40GTy/bGpZc8GEnALYoOmSE+3U0hlKKyKBYpZSZjxoUCLrMm+E0+iq
         vCJebu/pI7zf4Oy03LdrGUQ80QGzfFRTsviZ4/33ZtQw90fqV2oFP06Y+lWaG3eoFXKc
         5wVg==
X-Forwarded-Encrypted: i=1; AJvYcCUeeAYlb8ejHKt0v2KGzBpYF7J105/Vf1ReJGQF9oo5c8acnzAu+eD+pb/o7rZC3McTbAHDFitDFTLXaOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGGPe3VQJckURW71alHzzaHIdeSnTQc5xpXCmLRIH0hwrBeoz
	pFMTGuW0jV0caHrD7On1FXPHOsnNbsaKT1+imDxpTSiKajGXGmtosk2owlGVjM7Q+ajVVLMsWx6
	fJelwCsgOr7IIdmi6OZkjMhmlGLSnC9IW2amZoUnF
X-Gm-Gg: ASbGncvBTrc7YfDZTuI7sQPf4mVSpk6pTsQkj+uFsuDR5UU4xn4EKAcIf4/SijxuuFN
	km5f78Iz/bzl4cYJwl66LUT07abmlEJ9s1gTRE22Pwwf39Nxa6iY5WFNOBcsPYnS+g3A0sbs4jD
	xpHLcX6gHCVpv6l9DLejOE5mNqPkGkDc94tysn9a3RaBQphg1OimhpVicoXiGmd7br6OfSHACZ1
	COwJ/0eeHpRmtvTYc8Hqyi06tbkTXDsaaKM8B0aaQ0=
X-Google-Smtp-Source: AGHT+IEIYsSgoPFw8n0D5GyMXO8O7j8k2ouTC76R97gvN6WMwuWsPXFAVjR0Mb9sTGuoiknuifAK5c5GGSIVmLuC2HU=
X-Received: by 2002:a17:902:d4c2:b0:248:a039:b6e3 with SMTP id
 d9443c01a7336-26800f661e8mr5881855ad.10.1758123075306; Wed, 17 Sep 2025
 08:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917095422.60923-1-wangfushuai@baidu.com>
In-Reply-To: <20250917095422.60923-1-wangfushuai@baidu.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Sep 2025 08:31:02 -0700
X-Gm-Features: AS18NWBn1xIsmr49KgjsNQAQO0Eb9GKnYzHA-cdT8fTubed47WT7fWABg6bGxJk
Message-ID: <CAP-5=fUvvcfPOEyoTGFD9oahxzKGMZXPZ1YikLqzwE3hw7B=bg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:54=E2=80=AFAM Fushuai Wang <wangfushuai@baidu.com=
> wrote:
>
> The alloc_syscall_stats() function always returns an error pointer
> (ERR_PTR) on failure. So replace NULL check with IS_ERR() check
> after calling alloc_syscall_stats() function.
>
> Fixes: fc00897c8a3f ("perf trace: Add --summary-mode option")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index fe737b3ac6e6..25c41b89f8ab 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4440,7 +4440,7 @@ static int trace__run(struct trace *trace, int argc=
, const char **argv)
>
>         if (trace->summary_mode =3D=3D SUMMARY__BY_TOTAL && !trace->summa=
ry_bpf) {
>                 trace->syscall_stats =3D alloc_syscall_stats();
> -               if (trace->syscall_stats =3D=3D NULL)
> +               if (IS_ERR(trace->syscall_stats))
>                         goto out_delete_evlist;
>         }
>
> @@ -4748,7 +4748,7 @@ static int trace__replay(struct trace *trace)
>
>         if (trace->summary_mode =3D=3D SUMMARY__BY_TOTAL) {
>                 trace->syscall_stats =3D alloc_syscall_stats();
> -               if (trace->syscall_stats =3D=3D NULL)
> +               if (IS_ERR(trace->syscall_stats))
>                         goto out;
>         }
>
> --
> 2.36.1
>

