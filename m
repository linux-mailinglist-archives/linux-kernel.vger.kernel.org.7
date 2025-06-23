Return-Path: <linux-kernel+bounces-698677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2255AE482D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C693A3DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF2260564;
	Mon, 23 Jun 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ+vEFs0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CC22FDEA;
	Mon, 23 Jun 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691604; cv=none; b=LQU50N8HFwEKFfxvPNH5QN5ppLexakZtXYdEyeE+QrC1VJUWu727+q8i9yDzrKwxJcDKJ+r/2XHfyUvto3tKvgtTdwj0WlLMBpMR7ZevMzIC6poISauOn0U7vl2CptoUBUMTkIgvCxXERvlOOH44dkVAUNHMObDd4j1tCWvO9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691604; c=relaxed/simple;
	bh=m6+zeFbf7/Zy3uTO9XIn4MuWc9MoVBSP7ewq69H7+T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr5606/Rk7PEWDAZi/9aXL99DZ5OpJOxgViV50huHHqyo8W0qjKPiu9CNIxYXkHoQ6Gj38DXGIgpVu9tg9R1EO0VYHaJARdCrfNMEfy8X1QMLt4P+98y7dhKx5tnzQxMuUmdlq/m8Jp15Mxo3qDY3HH+WHECGQ7HQWm9YwZzypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ+vEFs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7478DC4CEEA;
	Mon, 23 Jun 2025 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750691603;
	bh=m6+zeFbf7/Zy3uTO9XIn4MuWc9MoVBSP7ewq69H7+T0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kJ+vEFs0j00QDs92yVfX6WZxq8Qy6AkSlDniiIRy7hDGzBsxfw8YkiTQmE79xNngW
	 NktYvcGFrn01CBzlG+o5XpzITzlCJbZa7rXC9rZnvnsb1HlJ7wb0FA0gIFu+VoOVij
	 1ScSV9VMvzH53sW/+uHQb7NZ/OVplDPUdPPN0ZqjWYCM9mPWHXUkxytG30QIRR9DoA
	 ZdA2qB/YsKL8Jkh/LR0EXoSA5YMjJJne7+Ak2hNUd9td/sb6wbKkIk5wE1ZnPWCemw
	 pT3SLq8JOgYmXMETAWePn/OtdTh8oVKo2lmrrTGSC29BScI9pvIkdAftm0gXQJCxnm
	 6jWCgZumgyPQg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6118c1775dbso145049eaf.1;
        Mon, 23 Jun 2025 08:13:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGUYkWOa1X4maXy1QXZr8RxZfyGNPFFWUq9Sf05ZReN34KtMmzt2EtdIMlIsEVx0Yj22daahOyMt0=@vger.kernel.org, AJvYcCVjgZmPIsH7ZoaRFwyUYFDIoLP8NGTBtRIbqaXgoQ0kvkqLKY8zGzOg82Zc5GRrFRnjYJNLQaRi/AncQWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyofp2J0MPvMFGeLvFt84QlxIJN8ePIkibFXGr4DyBsAEk43VND
	wBH6kc77YssLbyhFVKc/FB69Iy+c+D0tj4LKzDzRjPo+rmAPdFZn2KUmJanoTqHmyXFGaAWeFgX
	oUY9HvJxbzkO/tpiuP79sbVpNvY2J1Zs=
X-Google-Smtp-Source: AGHT+IGpm04yVlsU1rtbWQdJ5UO5ztXKe7NWSoIPZJyX3DsiZk/jtE/bA2b81WS4/pOaLopOXfilysz0oBGyTKPU6MI=
X-Received: by 2002:a05:6820:1b05:b0:611:5853:3ecb with SMTP id
 006d021491bc7-6115b734ecfmr8708103eaf.0.1750691602814; Mon, 23 Jun 2025
 08:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com> <20250623133402.3120230-7-zhenglifeng1@huawei.com>
In-Reply-To: <20250623133402.3120230-7-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 17:13:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0huLAM5XaGr1MWOwL5V-p7KX-ea7FYGx70GPwyVHETnHg@mail.gmail.com>
X-Gm-Features: AX0GCFsZ-nJyD3aKqSoDIy7nHLaVawW_CCC7pCQKRuRnoWPZrSQNKJcHar1AA4g
Message-ID: <CAJZ5v0huLAM5XaGr1MWOwL5V-p7KX-ea7FYGx70GPwyVHETnHg@mail.gmail.com>
Subject: Re: [PATCH 6/7] cpufreq: Refactor code about starting governor in cpufreq_set_policy()
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 3:34=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> Refactor code about starting governor without functional change in
> cpufreq_set_policy() to make it more readable.

Sorry, but I don't see the point.

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9b2578b905a5..7b82ffb50283 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2698,15 +2698,19 @@ static int cpufreq_set_policy(struct cpufreq_poli=
cy *policy,
>         /* start new governor */
>         policy->governor =3D new_gov;
>         ret =3D cpufreq_init_governor(policy);
> -       if (!ret) {
> -               ret =3D cpufreq_start_governor(policy);
> -               if (!ret) {
> -                       pr_debug("governor change\n");
> -                       return 0;
> -               }
> +       if (ret)
> +               goto start_old_gov;
> +
> +       ret =3D cpufreq_start_governor(policy);
> +       if (ret) {
>                 cpufreq_exit_governor(policy);
> +               goto start_old_gov;
>         }
>
> +       pr_debug("governor change\n");
> +       return 0;
> +
> +start_old_gov:
>         /* new governor failed, so re-start old one */
>         pr_debug("starting governor %s failed\n", policy->governor->name)=
;
>         if (old_gov) {
> --

