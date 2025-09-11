Return-Path: <linux-kernel+bounces-811622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D65B52BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707671C82CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0292E092D;
	Thu, 11 Sep 2025 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k4sPmNC9"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CB2DE202
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579356; cv=none; b=ODkDLVwLZrO66nM6S3rV1pAt49F0S8tfFWick1xetu7G/BKFz/1VsnrpvSeJKNWM5mk7msYrpofTOKoJOL0hitIn78P2HodF5L3a+T3+3D629vonSWj/qAGmsfFNdKMe4q9S1EAVmjrSegvt7BKfDrXJfpNsJP0hflz7zr/MOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579356; c=relaxed/simple;
	bh=tn+d+d9o/oBe0vPLS7N2nNhfxrRJL9/aiVfSs7QLPyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgocSywQ3Se3fSLUv4iKwTzK1JoZHXnaJErq+3nTp35+8v27Brs0O0wi+tu/LAK4Ze58xa5teEjPMLTcp1nVc+xSNorNbum9h1MEx0YWc6lX1xntufRhk8eRTJGEUYZrDAYyZl93GaMuA308OgsK31xybtQSbAZVRP4/L2mF5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k4sPmNC9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6228de281baso714370a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757579352; x=1758184152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CTl/N46+3x4kPEGgOfaMlRwbCfT8UzGcwBzoLjdKxc4=;
        b=k4sPmNC938YWPUdgepq+MN1svanLdzj2uyylcjCr8haBDUfXnQDv2MB3cIN7EPGAke
         jwSuAm0rihpe93V77zyw13JN8AuizpufUDFKOeXUoM7NZO6g0zxGUqeqf8jXrBTjrQgv
         R1UCpLWz5ZS30CPj34m5pTnjxERctn9gwv/OZAJjN4pLt+2szZ8uKMt8lUYotGq7H3cf
         FwkJ1GFIhoYHEo5zxjBMRVJP/3t4eb1NTpeT9d/xYERxGb99SOl5Ohsci5wqjeSyV8mI
         LBoJ7Ksxf5IisZyt4gK23LWj2i4GD4ALTx3dB8IayAYHaP4j0oEflnpVEyuJ8gA4Ynu1
         oMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579352; x=1758184152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTl/N46+3x4kPEGgOfaMlRwbCfT8UzGcwBzoLjdKxc4=;
        b=fdG3pwMDodhNO/Ml0TRDOOblfzb7GIkxYJrMAfpqozfEXYhsQHG7W6kktIjTGSZoMY
         g//3zZvL+vZOWflfwnE2tWRmcV/0t0MtjvCSHF+ERxVFoLF9wTEqJlUwRTUywxgLYPUf
         097B2f+xtsJmSvtB/b9T4deTp63dSyzdjfBiwswsMQ5120vbRxi/xzJKLp4ORUNMh9Iy
         UnoaDfCr3mZY5SogJy387UKr9cMcgxirKWc1+uz+NJm1lPJIHFwWsc3ufSlRC0ek6/5q
         MMJh7F5E4D2mzA2ljNKHcPYHJsc2IUXZdhNRVwS0LQEBXOMVmkHic4XAHnf+2Sqp5QAG
         988g==
X-Forwarded-Encrypted: i=1; AJvYcCVFdxGlrJczEO6j78dXOPX4PnKIfieEQEmy+iFG8wRi8C06ZrutFrCjq/Yws7hPldW7904ARgfiroG6IIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mlIE/1zFlwVDDeuCa8QiYhxL/eimBO78qKPLytEd4NmuJDbg
	8K4iTAqcYPZIo57WabYc94oMeB1YFflYB7+0IHAyiVWRh6nGKbJCnIPwn2OExjqG6yxjl+g6Mkg
	PqSAFvlEWtnw+RtWrejEW3R3KNP0bcZ5bsdDftv0StQ==
X-Gm-Gg: ASbGncudV0dE1zN0eRkJwuNavX0VPwRsIqeUkxMgc1I/k5ePB7JLv5a/v+YJxcGIUTB
	8DLFNXRni60uRuxI2dDA+UjT1H58rl3PPe1oOK/mqaNTcuR+R9kV70C+tcfKchDGNeiA7wKBWvK
	zRYBszeyxp1yqYqCRQr+cA5JUmsEZlQQmkhNmnAkUuZc/3m7Z686lU97QLKCg2wMgzhyuuzatYN
	J9Bd4HlmVSlwNZ+pVKK9ypnmw1BhNeANQ4n
X-Google-Smtp-Source: AGHT+IHlgwFGpCkU2VafHllW1VlKGreu8Iajcph7UWLGWwWGqMNKs5rQlLChGNV85lFHEXrKvSc1Cg76oTHPpLzMuuM=
X-Received: by 2002:a05:6402:35c4:b0:625:b818:430e with SMTP id
 4fb4d7f45d1cf-625b81847ccmr15142937a12.12.1757579352354; Thu, 11 Sep 2025
 01:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911023426.457745-1-yury.norov@gmail.com>
In-Reply-To: <20250911023426.457745-1-yury.norov@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 11 Sep 2025 10:28:59 +0200
X-Gm-Features: Ac12FXxsKR5YyZ6ADAHTVeYUfF-InGj2-Tmi7nMiN7oJtEP732B3Hn_y1ppYXc0
Message-ID: <CAKfTPtA_1uQ6s5fMw1g0N8tOLD4s0orD_yv=1-+yOS73Jpu5OA@mail.gmail.com>
Subject: Re: [PATCH] sched: fair: drop useless cpumask_empty() in find_energy_efficient_cpu()
To: Yury Norov <yury.norov@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 04:34, Yury Norov <yury.norov@gmail.com> wrote:
>
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>
> cpumask_empty() call is O(N) and useless, because the previous
> cpumask_and() returns false for empty 'cpus'.
>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..7229339cbb1b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8320,9 +8320,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 int max_spare_cap_cpu = -1;
>                 int fits, max_fits = -1;
>
> -               cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> -
> -               if (cpumask_empty(cpus))
> +               if (!cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask))
>                         continue;
>
>                 /* Account external pressure for the energy estimation */
> --
> 2.43.0
>

