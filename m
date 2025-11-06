Return-Path: <linux-kernel+bounces-889261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58468C3D17D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AFE3ADC2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7A434E771;
	Thu,  6 Nov 2025 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i35KC73V"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB0324B20
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454617; cv=none; b=kFp9cy9bkg6gz8JdnIMFdDifmZ35creoymqhaxScY8cVR1J3/4Qo4puH3A/rDNLHFtSu5r2ALkUSUs2TGjyLeVxr3L+JdPSRhDUzjXlj+EsND6UAizQ3Elgbd94p6PDVEtTuYXcf/eiPjpZFW3NwGVCtHhYN7yEbQ7JrX7KtzTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454617; c=relaxed/simple;
	bh=Xgezs5FSuKUDxWZkIg/JG0XAvfAssZlpTqZgQYOOjtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp2xCG8TFllf8KQR8BLDDzC/7FkDgT21zVsi3EAUJabZbD4slC3pZ97qpkrmqSE+ua+fFm+jmbtSDrOBi2ADnezQ/jgZTOh/MxGx+BqxfTcaUheEpiyhCK+K7C5ox4oIuMjTtKvV4MoTWSRyVuD2IPM7Y/lMQbqfGJ9MMuXz6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i35KC73V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295c64cb951so20165ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762454615; x=1763059415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx3k3kEep1Osi8t9YC8biS3Xn+GMlwzxfXdy+eSJ/tw=;
        b=i35KC73VPrU1iUCJP2VhlkFnSui4Qny00LhJCO5H6jzbxw+PaBbt/QF1Ig1+aKwmdi
         P6mpRtrDpHKks0+qCDc2xm9zQiwLS8V6uS6ncT1AH6TUpPBHrnaW4LiBy5ruhtrDzJHj
         QFzSO4LtjVeQYYSHjzHr4EpXQDOEdMvp/n9HOUMdD2if0WIJCh21sIDssBrcX7tloeas
         4POU5gERedBmZS1YkVaCnfk3ee4TwoO3xLBRwI5rtJptNtnF4j/kH+EjEEzu+NsUrmvN
         DV0vt+cBorylm7jkYePor4IC4D+hfg+Ee0kWDyB/OxFcJr8l2N/R7YnF8CG93/sUtzrQ
         hSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762454615; x=1763059415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kx3k3kEep1Osi8t9YC8biS3Xn+GMlwzxfXdy+eSJ/tw=;
        b=T+B/0nVvpxRzrvB8ucqBU2Yi5orGoynY2cEgp5g9TBwrrJgP7Wrtrd2kpfE0bS9+5x
         iGkq4E4teh4Hc1HnDFVDQpxY21LcoNdWSOefiMgndHMkX3SXhQf78vmaHh08u8EOPEuM
         gsuVeImJc/Br/SWS2atbRbYg2k8szZEDD4cV8Ifd8ePWUEMVyIxcYNQnYrMhJv/o5srj
         DFtmPUrw6DS0WaGjXPSedtQcHKPH9v0pYjTFbW8YT5sh5jO2c+2RdctBhvoU4yUbCKjl
         GYE1mj+K/kcqNH1GZEFGVlm+99RjEw+IrodYT1LihaTV23So4vRygaavVDKw9if+F4Jc
         13og==
X-Forwarded-Encrypted: i=1; AJvYcCVwN8lQCLnp59WKK6T1l1Ggbp+akqB+TvGNWHpMsXj2pKwXYwu+Oc/YlLheTqs8NQQOOlbORTF+ip+DNDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnz1cVn0VgQfsltDWYMQpWq2f1lvd3wPvN9LQ/19CiTwWf3jsS
	ov+KoYwtLMrUkd3Ie+Q9uaMnsZKGXHgRVPKjA8aCmeG94EP+RfqqK53VmaEcrfPYTX4MzaVdlSJ
	c3TDWUoj4LPXvNSBMNf9McadbSZYHfXG24oJ1xZHh
X-Gm-Gg: ASbGncsniiya4yXRWNuBNDAXPqph5GGX5R+e9FHzdnRdp1B00TqqB8R1bSQ1W/xrGRA
	3cTPEjLC9sMZ8Z3evdTwi+H7ibObgFrRwcax4UUPMYzHNvvEzKC57VueHSKex18RetWxZLl08SF
	GqRzHdW7mBGCuoyl/6mrDSX8XGlnCVQXvFCnaEaQ28EMEAWMQG0NjLIUHkO2JB+kBcNTJiX0HGX
	6oby2ip8Hf1nF59VZ/vQAVdeJaPsT5bmWwTWhzna3farFx4Gr/tJOIGO4Lu3zmuht+rxiYnWErC
	5ojhPwTLlWPSJjIonohb42LMAw==
X-Google-Smtp-Source: AGHT+IF595yXHj1R0vJCF+feMalPWNtb+trAUjO98C5efGBIfaeJjOXXPVeNB7Rs+09OqW76Or/uYcg+9ZG9bBRA+RU=
X-Received: by 2002:a17:902:db07:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-297c23c3639mr176895ad.6.1762454615057; Thu, 06 Nov 2025
 10:43:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com> <20251024175857.808401-8-irogers@google.com>
 <aQmHfya8SYIcVGcg@google.com>
In-Reply-To: <aQmHfya8SYIcVGcg@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Nov 2025 10:43:24 -0800
X-Gm-Features: AWmQ_blYBvvVj5PROyLrN85lROrsLampVhlxTAN2qAyCgPP2Nlsws--HlUu63tU
Message-ID: <CAP-5=fUcCjDpu3=FNkiayZG7gpTzo9VLnEO-YM_b=GPwdDeLbw@mail.gmail.com>
Subject: Re: [PATCH v1 07/22] perf expr: Add #target_cpu literal
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Oct 24, 2025 at 10:58:42AM -0700, Ian Rogers wrote:
> > For CPU nanoseconds a lot of the stat-shadow metrics use either
> > task-clock or cpu-clock, the latter being used when
> > target__has_cpu. Add a #target_cpu literal so that json metrics can
> > perform the same test.
>
> Do we have documentation for the literals and metric expressions in
> general?  I think it's getting complex and we should provide one.

So in general all these are documented in the tools events in `perf list`:
```
$ perf list
...
tool:
  duration_time
       [Wall clock interval time in nanoseconds. Unit: tool]
  has_pmem
       [1 if persistent memory installed otherwise 0. Unit: tool]
  num_cores
       [Number of cores. A core consists of 1 or more thread,with each
thread being associated
        with a logical Linux CPU. Unit: tool]
  num_cpus
       [Number of logical Linux CPUs. There may be multiple such CPUs
on a core. Unit: tool]
  num_cpus_online
       [Number of online logical Linux CPUs. There may be multiple
such CPUs on a core. Unit: tool]
  num_dies
       [Number of dies. Each die has 1 or more cores. Unit: tool]
  num_packages
       [Number of packages. Each package has 1 or more die. Unit: tool]
  smt_on
       [1 if simultaneous multithreading (aka hyperthreading) is
enable otherwise 0. Unit: tool]
  system_time
       [System/kernel time in nanoseconds. Unit: tool]
  system_tsc_freq
       [The amount a Time Stamp Counter (TSC) increases per second. Unit: t=
ool]
  user_time
       [User (non-kernel) time in nanoseconds. Unit: tool]
```

We haven't done that with #core_wide and I followed that pattern for
#target_cpu as they do similar things. The issue with these two
"literals", why they are hard to be tool events, is that they depend
on command line options that may be processed after the processing of
the metrics. We could make tool versions with some plumbing. I'll look
to add that.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 7fda0ff89c16..4df56f2b283d 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -409,6 +409,9 @@ double expr__get_literal(const char *literal, const=
 struct expr_scanner_ctx *ctx
> >       } else if (!strcmp("#core_wide", literal)) {
> >               result =3D core_wide(ctx->system_wide, ctx->user_requeste=
d_cpu_list)
> >                       ? 1.0 : 0.0;
> > +     } else if (!strcmp("#target_cpu", literal)) {
> > +             result =3D (ctx->system_wide || ctx->user_requested_cpu_l=
ist)
> > +                     ? 1.0 : 0.0;
> >       } else {
> >               pr_err("Unrecognized literal '%s'", literal);
> >       }
> > --
> > 2.51.1.821.gb6fe4d2222-goog
> >

