Return-Path: <linux-kernel+bounces-897136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB79C5211A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67DC034626E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC612313524;
	Wed, 12 Nov 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6gEz/Qh"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522C3128BD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948093; cv=none; b=s9HDyV4nTrt3UuEzNvNg9jpAbljPUtV6olzjFhW3OZNfSCBe0bZrABS9+3e3+le6qhj0M3f09g1k25D8cJJ5XmZb8vTRsxJcBN82Yd0OMyv2gK0w882qP/lFVhbYF9gPVZAShz8NMGVVgtcrZoNt909qIBAIdBitL1bvrXFKD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948093; c=relaxed/simple;
	bh=CsMGb72n65sB84BarfkbfHWx/m2UMDZrZnqMTlXRG54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3Y2dvA79MbdLN6jw058YgirQFXw5BldhmejhfO5bJSlvd8xhfDqKSEzqTWI9BYYbSCAOAg9+N3jAIAN+2Ind45DCpUVJAXUC3Iig4HCBIxwF/q6ANeyZqbPLXIffsjRM9BA2NL+OddyIXRMJSIhSchyQtxhiBUtWLO0G0SnM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6gEz/Qh; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640d4f2f13dso725676d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762948090; x=1763552890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgzISDlirsE7rAWSMafTJShRBnGq5ayeujnsXMAtrvk=;
        b=p6gEz/QhKAoAn8gGGoZGX15jWJOJFKqia3aIOW+PAsj43v8gQsGagVuKwdriWbOqVK
         LQt13St9sO53imHqePs9RW1YNgRqd0IquKTEzAyUqoJQC9xpb2pnJFCUzcLF+fe81b1A
         cgnKXW20RRSy2ayWCmRBjYyq1U/T5iRZdGlpSTFyVpOnwuosFc6eoZ7pmfRN7Vvtp8OY
         vVQxuCJTzM65+NuTnY40wjNJyKIU0wB58TqJLzjxqPrat0dJCi27St1tqIL+F/NeBwoj
         XkZi9AgKfOd73846AN8MsKXQPqxqHxGJ+UuL4L9QGERrR8DdQgX/6FQ1k8idKtciTuy3
         Xn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948090; x=1763552890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgzISDlirsE7rAWSMafTJShRBnGq5ayeujnsXMAtrvk=;
        b=Im8Sta09ql9TilWeLEp0LQrgbWZzDDBA8MWj0jApbqp8hg+POi4TBdYZchfgwHI8Az
         KJGnrI3bvQrTihe280Lq8jMsAnkXNzgARF6klNyP721VvLsX9fxq6NwmbkW8qCRgVa/4
         yhm3dsQdo4jND3nZCiJetCVG9Wl0/n4mN/3Gdc11uIf4rxb8gpanPqvnV5vKk51vjcCr
         TcU04J8kRupi64id1u2tdEBiB5W2Sxnt2kdgb1sSmFl/9Q0BdH20Q3+Ki0aGg74jh+U1
         Wghddc8QK8NKmmBB6CRh9y3/eLfNi+9NTmutqEiqlHjN/beB6BIxIgzXi5NCgBtoLOpy
         Jn3A==
X-Gm-Message-State: AOJu0YxAU+a5rjyXYl3K39LZr7OYzKUrog9lvWzvL58HjjvovGAt201b
	qa+JA4dTD6JmKHDc1botc2c11zCQJwl/dTWlkXOtpwIQRXNh/g+0iWnPggk99PNB+cNlEEPgk8D
	J3Th8dlrC9rJcQyNlofJCYwztRCkSBS8pMhBtGKuMXw==
X-Gm-Gg: ASbGncvmCnrhnW4oPlDd9NCPOUA4cNm5gHhG3YvBz/9b96vFqSlH0bRtO6uEoMDlgYR
	9DfmLAQyHgrJUoYzM47anhWWa6TSviYGgBFs9vvR8fwZkBHM2a/DONwUogtwdK779PxxZRIg5LV
	rPb7fT+rVOdX0BrNIC+9EkWiTImlb7dHiwwFeJmudX6lsz4Q87G9wM2yGddMSsEpYH6G9Q+vs3F
	5YJsh9zNnQdZtVOaKjp2ObJ08yKvpZ36IEP2QwnvRv22on45SoE0nz9DuWtIWzL/GYDg/Yt
X-Google-Smtp-Source: AGHT+IGxVD1ah00znx8Z0n4+25eGvivHAA4K6zNXyg92I1xK4Swd+fm3I5voy/zxPnGWNkitMSTktR/jSmObcXDdDAc=
X-Received: by 2002:a53:d056:0:20b0:63f:9a42:f21 with SMTP id
 956f58d0204a3-64101a47863mr1905650d50.19.1762948090275; Wed, 12 Nov 2025
 03:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141654.226947-1-marco.crivellari@suse.com>
In-Reply-To: <20251107141654.226947-1-marco.crivellari@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Nov 2025 12:47:34 +0100
X-Gm-Features: AWmQ_bmdzPpsi3lbHRhrOb4oHz6RYePwKDFXzCKbUNtzfxdQrCK7xqkVjQWSxdA
Message-ID: <CAPDyKFp9ugYVm4dm6JkHV8z5Tudi6RWbLk2NrkPA26nCbawP5g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Nov 2025 at 15:17, Marco Crivellari <marco.crivellari@suse.com> w=
rote:
>
> Currently if a user enqueues a work item using schedule_delayed_work() th=
e
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
>
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
>
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they=E2=80=99re need=
ed and
> reducing noise when CPUs are isolated.
>
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU.
>
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index c0ffe0817fd4..6a651ddccf28 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -3275,7 +3275,8 @@ static int mmc_blk_probe(struct mmc_card *card)
>         mmc_fixup_device(card, mmc_blk_fixups);
>
>         card->complete_wq =3D alloc_workqueue("mmc_complete",
> -                                       WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +                                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_=
PERCPU,
> +                                       0);
>         if (!card->complete_wq) {
>                 pr_err("Failed to create mmc completion workqueue");
>                 return -ENOMEM;
> --
> 2.51.1
>

