Return-Path: <linux-kernel+bounces-898054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0219C542BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53BED34A3A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0034DCDF;
	Wed, 12 Nov 2025 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XI+dJR2B"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5711C695
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975897; cv=none; b=VkAH1mBSL0LgEndgdcc1aI3NeW2IY/3D1uQdqXv751Dsrw7BMyYdKZV235F4zza5AMUsKhCBWWrQ2vEq9eLogOQGtsSB+gaMGDIYD7LPO5yNdN3Zj53d6deNwlYd4+hPOCLvhyMCwS6629h8Bh1KBcfMrW+9tmvUe9OXQxakoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975897; c=relaxed/simple;
	bh=2z30Onwslv/HKcZ2MyBEPI3V6h4LiyRU3iVn30ZBBiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsJt1gabM9yVQ0LvTHymNm7fxzrbBsvquM8dkTYuzW4XW3HTyhwypimeZ/kSBT+RxJn8TM6miSE+rRGA9jYF7bAhaxKu04hh7Mx0hJbDEitA8RwVRFG1y6SOFgY+l5hzcxSOLS6wc7E9zvWYN7rutr6cIwoyVZT+DV3TlvHsC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XI+dJR2B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295c64cb951so25935ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975895; x=1763580695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcvUwP/777L/eN/ikRIeQAoirqn6cF5E9VLK5dHu84o=;
        b=XI+dJR2B/uhl/EcDhzNuv0JxL8HI8tLeFuMI4cd0YVx/XV82e7sYf3aLlwUzklIGWC
         RwO377HM9ThSo80U3843yMPz6UaoETJWPKslnD7b5wLaANRCdt87v7zZ85/o98KHB0tx
         unffjRMQXuUaGnEIP0CNms81TT7uLLIAt7kiGpEUHKTcWxJ1qJocYLtgza82Hyeqc69m
         lrgKVzuQPTWE39jxE/fC7HXpTKgi+CskkJ+ovHXcXKoPH6hc77k9I1K3c8Pvwu3E/Dkj
         PaXjnx/wVIgmrf+gi1MLhWdD5iaNW9hMq15qHvfy1sGfTDPbN6an+cJIgZnBgEyrh3yd
         bd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975895; x=1763580695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RcvUwP/777L/eN/ikRIeQAoirqn6cF5E9VLK5dHu84o=;
        b=YT6ixq8rS8odnqxoChK/sHRDct9ifzui1AAOfNLBmGlnU1j25+wyovJOD0ubrvDsCx
         cTFxnq/R5KJkrRGygfZ/RhzyX4vRxaJpdXqhH5HPsnoRUQAe6wR75DTfVaQXlWVsfWKA
         52PBStotu2HZt4Z1/g++YIvYIr6TWZOF1QNSDGnLf7Ekv0gfD3Xz78ifZ++t94Tzhlw7
         0+eYA1OUTGikcJUAjwWEHqf6dlJwqkM3ZGefM6QUpdoXBd0T9S8l40qb3ujKO6n5jhSz
         mkSjGcMH7cCxBGTNHFAQMSBfAdbzAqBPuuzFhiWPacdJjdC2oCQSnzjLZddfiwBedF8I
         YroQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs1nhoVPZwKPpfauwmQ1dW+um3Jc2/QPtSore0+ODfb6TmkFiVAgrOemgR7aw5/eADyR0Rl7XD1rXx7gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7TM0pdMYxPJsu94sPif6PvGA5JOjTu0n49tJhyVfIOeDEeEx
	8iGicRVYJTU1jHLbnHGD2EWEKkvRid9rEWd+PkTQLbXwZWxq1DwrF8gppMFSllvczz8eZdvgy9p
	JsNaE01m5rhcPCH1Ajjge/f/UYCqzECDdJThedwqX
X-Gm-Gg: ASbGncsIwFCW30tN9lBJjpY/iZiXnLDS4PolE7Ki0eDYo8qV5IIsO3sLTFiT04YbUdC
	CfVKNAB+sFaU5XeOV4BrMaEXWB0+5u6x1LAVi7GpqgQDFtl6f0v8EMKEP0d+J45icEfKFHqkdnh
	T578DST2/j8OMFPvvav786ltFqtQbbIeAdfuVLOoijJAuz0dtp/vS9l1Q6OZF5vaqsn6HB18a61
	MJRzKa2DVX+ws1WFBSeiIXcu9SSxDys3MXJL2ETVUs/X8gH+5RgtDNZ8jSQ9juYf8tOZEl3ZaLk
	h8pZPF1FchsSv6LVqcfDaaP1IA==
X-Google-Smtp-Source: AGHT+IEnanRTpKm63zCv33Zb9RXdVcyIJoICIdpTLlTnSgpNWbSyREWjSVvWZ7Ny+8nzA7PjgTs9GzQPNFbYFlXOfLE=
X-Received: by 2002:a17:903:1251:b0:295:30bc:458e with SMTP id
 d9443c01a7336-2985b86993amr471875ad.3.1762975894761; Wed, 12 Nov 2025
 11:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031162637.1456191-1-irogers@google.com>
In-Reply-To: <20251031162637.1456191-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 11:31:22 -0800
X-Gm-Features: AWmQ_bkkiP1GXmQJX6oJj_AhVOQ03vFxJ4Fxk2Kf9lhezAqqgbeGmvhNAnlI74s
Message-ID: <CAP-5=fV1bobHM5bT8xU7sxZAFt03XNaXwTQVGj3hm9RyKsH3fw@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor power9 nest metrics: Correct unit from MB
 to MiB
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:26=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> 6.1e-5 is very close to 1/16384, where 16384 is 2^14, i.e. a power of
> 2. When units are in powers of 2 the IEC unit is MiB (mebibytes)
> rather than MB (megabytes) where the values are powers of 10. This
> patch corrects the unit for uniformity and because such units may be
> pattern matched against.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  .../perf/pmu-events/arch/powerpc/power9/nest_metrics.json | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json =
b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> index 7a5d1bf543f8..8d028a7c2777 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> @@ -29,25 +29,25 @@
>         "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + ne=
st_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
>         "MetricName" : "mcs01-read",
>         "MetricGroup" : "memory-bandwidth",
> -       "ScaleUnit": "6.1e-5MB"
> +       "ScaleUnit": "6.1e-5MiB"
>      },
>      {
>         "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + ne=
st_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
>         "MetricName" : "mcs23-read",
>         "MetricGroup" : "memory-bandwidth",
> -       "ScaleUnit": "6.1e-5MB"
> +       "ScaleUnit": "6.1e-5MiB"
>      },
>      {
>         "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + ne=
st_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
>         "MetricName" : "mcs01-write",
>         "MetricGroup" : "memory-bandwidth",
> -       "ScaleUnit": "6.1e-5MB"
> +       "ScaleUnit": "6.1e-5MiB"
>      },
>      {
>         "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + ne=
st_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
>         "MetricName" : "mcs23-write",
>         "MetricGroup" : "memory-bandwidth",
> -       "ScaleUnit": "6.1e-5MB"
> +       "ScaleUnit": "6.1e-5MiB"
>      },
>      {
>         "MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
> --
> 2.51.1.930.gacf6e81ea2-goog
>

