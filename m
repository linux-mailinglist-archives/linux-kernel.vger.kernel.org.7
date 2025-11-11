Return-Path: <linux-kernel+bounces-895895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B966C4F36F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8E63BDA12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C5393DD6;
	Tue, 11 Nov 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apSJy0Yx"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD328258CD7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881211; cv=none; b=S3FctIPPySdmse0L85kbKhKUfIFFPTvGYFuCfzW4OVKx+fSF+HcSTyBiQpQMNBInkKYFq2lEKI9HXz1w22PoIGDcvxCn+DZN8lVAScCKyg5FIyhNYLn/Tmk9SCUnjA5gUMzM7WLAUxu3YS2aPTeAh4ma6JSuSYwNS1sKIdWfRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881211; c=relaxed/simple;
	bh=XWfTO4/IXYtSv4EgyQT3r4JllI6XqufjvF1l29xB2vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+fob7Qs4l5bKiUgxrtgIOPoBeR81dbYM+MLmuYEFBxABUCkZwQodq2dVSy7mKjuMiZzmp1euMSJtdYdH1uGlr6gDETVXJVFAw2XMnSLDkYATMow37KxqJ4VRuXijfwlcA2L/vHPVhBUHxyht0Sya6Jf5DGc8gq7oimKXfKdzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=apSJy0Yx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78802ac22abso14522237b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762881208; x=1763486008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QmKCicVCPHIj3mdKL3div0nARhe2VGZEzDrkecA8Xk=;
        b=apSJy0YxvtCZXQJ8pRiAClvyJv2T8b3lMDkN6i8A369nLPQGR8i55fDJuD2Ul7XmPp
         yKPME9CrcrrhG9jrrz0HNIsIPueleT89lFRzElf1StkWcRiz3N3W6O67QRyXoxmHivK1
         3rFqtQnN2aqEw1JMtNP9CQRIy5hz0ax7pdlkmQ6+TCZJARcPFgw7UFXMZFnV4+AZFUD3
         g0jizlkGMQNbcgCAXbwloT5wqbS8eAkhAxS7csb7UdImTg3JrzVg5tgtWnTw6FNHzBnR
         nHd4eVQE0DFv9W9RYycUd/0B3zMYX5OQGKYSV/uPHzc4RwDwiXh4ERUnFoE07rsg7/Hg
         uRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881208; x=1763486008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QmKCicVCPHIj3mdKL3div0nARhe2VGZEzDrkecA8Xk=;
        b=owCfcFw6jK5FVpmWUhFFAgc3EVN8Rem40tWrqQ/HQr8KVc6E2er944nPxie+ZN4RBV
         NEbwes+X8/7BhWQ39gIjRB2OsYyqbW75/BJCjJ3qOEkTl/usL5B2Z5mmjqoh3/MlVgEO
         HGDRK2Cb0FZy5CpdTjRvzTAihF53//MyWq0/ElLfq8TxGY7ZHUqPpdBWOhap8tpbRGgA
         f4281Z8TreXB+8ElR7pVUXMXca3bqUZpaMKpq8iqovr2L+fY+870XITB3bbZKqEJ9YEG
         4YFPi6YfdbV8kzWvDfGQSVX3naKK1ehrFI5YGll/CDm0P8RiQSIu+e2hteTFERpdMwuQ
         Z37w==
X-Gm-Message-State: AOJu0Yyub16E2H7aJgU0yXVxQfhlpCzV/hGA1lFYHArTP3tsi8D2altg
	5Mxf8acXgnqlNjy4i1eVh3g5eY6t1+hztp2S/icjK3TuJAZBgs9v3af5IQDQE9gv4AfS4vYk30L
	Bzn3ZjFDRcVzpD2YGXGoAOiT6QicASw7430Kv4OwiiQ==
X-Gm-Gg: ASbGncsRXFY2eY+lKT1FMQjfr1k0g0+ASYY3ia1vGFcBkjsg7DgzH4F0ZFJiVrj/XBX
	CjFdFgKARbFtVR8RSmCuLq4Ky/t2FGjHJ8irhR+aJNtwxeCRMkPwuU5vpmjMqsHyop5nV3b6fBh
	yxwnBAIv0LnJS/faEH7t7qqVaK5SX0GKVStT1M+BOqkRfF4CebdgnmpTmshYp1QxpzplJXCEVPY
	+0w9+1uG1KmZAU8z5pJxauftcqTWRMr/NBmTf8Ma2k9hSs9/uYnqn3w7fA2t1eJgAQsbDPL
X-Google-Smtp-Source: AGHT+IHsBdT3PZHzLqRZFfNwozig+Xj22E+YyhYW2OHI0PA6fmjqwweePG9pSYLroeVpxbau2y0IZ/+9yhkJkYzwk7w=
X-Received: by 2002:a05:690c:4c13:b0:786:5ebb:483f with SMTP id
 00721157ae682-787d5473c6cmr123803657b3.65.1762881208594; Tue, 11 Nov 2025
 09:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141654.226947-1-marco.crivellari@suse.com>
In-Reply-To: <20251107141654.226947-1-marco.crivellari@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:12:51 +0100
X-Gm-Features: AWmQ_bm9jflRRYlPnBrOqM5u5sgpAgSohcTdgzu--tAO09VnwRFmrIOBZngqZcg
Message-ID: <CAPDyKFq46qON9W5akWh7CV5fiGSLHV=K9F_Uj6u_g1g08DPV=g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Adrian

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

I guess we prefer to keep the existing behaviour to avoid breaking
anything, before continuing with the refactoring. Although I think it
should be fine to use WQ_UNBOUND here.

Looping in Adrian to get his opinion around this.


>         if (!card->complete_wq) {
>                 pr_err("Failed to create mmc completion workqueue");
>                 return -ENOMEM;
> --
> 2.51.1
>

Kind regards
Uffe

