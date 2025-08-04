Return-Path: <linux-kernel+bounces-755428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65AB1A628
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620781818ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C2E21ADCC;
	Mon,  4 Aug 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ka2Ad6T6"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB117367
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321741; cv=none; b=TNGyopKJqkmsYZ0QcFzU0K/xBxwAa4LlAEpx9WoIJsZr5fQyudzCX1Wf0zOudsgPXXNaDr2oAUnv/HGBz1mpqD0aGF9z2uQCncMdowz2433MdGqTQgW2NazSOY+tJJafaB7NDW9Seeo3ez13bUDtCe9p2dIJfmSJhP5lxgkpBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321741; c=relaxed/simple;
	bh=6e7J26NQEcMI5/yS0dzAaPsIWolrygotjGI0c5HiB+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7DYfRiN7oQmT7ME4nyUMQ52B5Ej5xUTHLLNv5OrD5jjvvGM2verF3mcVzG+pTvW3sg6tj+tshmxGPBAjy1JJFnJPEPgwDrykO1ulWHP1WNjAuGU6b/4A7vfR6rBzAoT/IRxkCRpDyhpAKeZkOL3XlvDgdZdRUjR7yNxq+gti0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ka2Ad6T6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af96fba3b37so166426566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321737; x=1754926537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nY5oxcWHAdZZYPfBz5jB5KV5yorDq8nM1UTjGthtwrI=;
        b=ka2Ad6T6e0EDJRHwLf/spUqB/8/Xjgze15dy7r6z09h1M7dnP9z+BRuEw0BKc1Wcb5
         1yZDBPDTIQ284br+AGJ4myAuAWghmsn+YtctJwTI+rO2T719eWnJonH81dpYNxhVt2YN
         PvPu/Frri0MUuA2c1wLeeilxLsP8OUqScCFkn1bLBZweQVMf21yiPd81pItSIhB3ysKz
         NXY32Q2vk9RSLYhrs4XE6xoC3PvoNLGsXBfTlGDiEZW8XvtC3XT8bCvGoGVLyhGw97ad
         J9q1OdkeXP6u587NE988Noht7dpsb5JdZ2y1CNTnbzO4gqnc3q7PI+Zz5/mz8uyQFx4q
         ANOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321737; x=1754926537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nY5oxcWHAdZZYPfBz5jB5KV5yorDq8nM1UTjGthtwrI=;
        b=os5/hfVWkZFnyoPxa2L9iaBDaV1qRn5bOGoCEcKga9AK8WblWdc9RC1zG924SDYyiw
         XFODr3ht9HLSD24M/t4whHzCiCb1kf7KM34PhoIbnBTwwLybFZqtKLGiSqczhx/m821h
         K+DVffq9WSL4FyYgTAd7fsv1HHf0tfDAbT/aPEdFeTK0notlM3DOgctqTrk2UFrfp8xg
         4Gr3a9KuHo8XSLbgTaIy7jm4gv+1t+/wNTtm1K9PrZrDpCmvvnt63F2eM2t5XaU5jmzZ
         A3Uo9NQwK5uTEknfhNwxLwEPnVKL6uco64kQHa2bdJEqrprIIun+ZyLs7dprpXlTipXl
         ntzg==
X-Forwarded-Encrypted: i=1; AJvYcCXzRH0bNrNMAlbtzQZwXDXuWhkWkYwAdsag8bmPcR73RrLG5/ADZIAVz8s0E3iRwIka5L/Ot5/gzvYWWCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMboRl03ieqrfAhkx0WEEHJmwNXDjTZjr1KAsGB7p5bV4sixV
	tmD+DSQUCPlgKmYAi0njexmio8tclfUZS0X8MUrDG15KP7uzLwBNXa2JG6UoXFYWJgQblHL9tka
	FGkww5o1XyDLosAQtFEkPGPpKrssxxLNlvvepdXPx6A==
X-Gm-Gg: ASbGncuSZ503LKZuJ/YMgDDmmiOgx5Grz6O4yMubvx1Gyth+BlFT/hyYXkNERNFtnIn
	IG1gfUDQNYFc7lvev0URQegv1Y196PD3aI38w4n+KLl5FMT+h6HHOpcELC6WAXJ0k4gKJCsBR3f
	eUf4Y+m7eeyHM1wG9ryM6GnXWBPcyzu60y7Ni0d5IGRpUYzW0F5bhHceu8esoUsxFGc9bbRydpr
	4UmouMi0JXFqhQvzeLzWKlSxvSRLc9Ve8rO
X-Google-Smtp-Source: AGHT+IEB0XuOu8HCiXterrleIeIutdAlbUXxCXbnfBQ2sEkvVdLmPrcGecgna+J0zrNE1WxvojxJx+Zw2mVfHZ4CMEs=
X-Received: by 2002:a17:907:2891:b0:ae6:c154:8059 with SMTP id
 a640c23a62f3a-af940187820mr715015466b.37.1754321736804; Mon, 04 Aug 2025
 08:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804064416.1697786-1-huangbing@kylinos.cn>
In-Reply-To: <20250804064416.1697786-1-huangbing@kylinos.cn>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Aug 2025 17:35:24 +0200
X-Gm-Features: Ac12FXy9fqhtXoKlzF6fKtLyIzSjGYcRSoXj0SXt6v9UXw9OXx9Vm6RF9YAIVcQ
Message-ID: <CAKfTPtD+YVAkPM3x7WLBOHhh9E1z9E96T7Ff3sbrH2fNnG=mCQ@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Remove the rq variable in build_sched_domains
To: Bing Huang <huangbing@kylinos.cn>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 08:45, Bing Huang <huangbing@kylinos.cn> wrote:
>
> It is no longer necessary to obtain the root_domain's max_cpu_capacity via the rq.
> Consequently, the rq variable has lost its substantive meaning.
>
> Fixes: fa427e8e53d8 ("sched/topology: Remove root_domain::max_cpu_capacity")
> Signed-off-by: Bing Huang <huangbing@kylinos.cn>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/topology.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 977e133bb8a4..5eb464039d1b 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2444,7 +2444,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>         enum s_alloc alloc_state = sa_none;
>         struct sched_domain *sd;
>         struct s_data d;
> -       struct rq *rq = NULL;
>         int i, ret = -ENOMEM;
>         bool has_asym = false;
>         bool has_cluster = false;
> @@ -2563,7 +2562,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>         /* Attach the domains */
>         rcu_read_lock();
>         for_each_cpu(i, cpu_map) {
> -               rq = cpu_rq(i);
>                 sd = *per_cpu_ptr(d.sd, i);
>
>                 cpu_attach_domain(sd, d.rd, i);
> @@ -2579,7 +2577,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>         if (has_cluster)
>                 static_branch_inc_cpuslocked(&sched_cluster_active);
>
> -       if (rq && sched_debug_verbose)
> +       if (sched_debug_verbose)
>                 pr_info("root domain span: %*pbl\n", cpumask_pr_args(cpu_map));
>
>         ret = 0;
> --
> 2.25.1
>

