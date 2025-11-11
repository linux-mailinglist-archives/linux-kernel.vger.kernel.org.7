Return-Path: <linux-kernel+bounces-895924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0582BC4F45E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 491414EEF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC90736A022;
	Tue, 11 Nov 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3oz7lA5"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14F3A5E60
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882632; cv=none; b=e8gQFTpVkqXPluEErlH2nqNL9Hv07EmNy1Lk6c+v+1LNkQxKg403nFqpdCdgvADrKVW+jrrKiC8jTMs4F/KJRz9zVgB0S+iR/Sz+w0cGVPEQCEE9D/CeHmrwkCsEBUmu3F7oB5bf23B1hFevER1z+rn9Hq1JFOIr4B2B0eoVkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882632; c=relaxed/simple;
	bh=EvsqPPFe0oeSUmlgAw3dm0536WHrkhiXIamVRC7y0qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbRrh5B40sUHI1AkakvwFn4YXU6xhgEDQGz5sMtdu+6KnBO0PBSlMvJJVFlRuRBWrP30rEuq+KQV82F5wMCuKr1UusE64VdGS9igjSnX7BYeeO3YT502iHAhU8ISMm8aObhEQXXbMyQv4NrYL/e7YTbGUI3eIzBPyAzJjt+w2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A3oz7lA5; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so4166092d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882629; x=1763487429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LKCHaTU9AqqSilVdSEk0nqYpEpb/jCCe95SCGOIIGQ=;
        b=A3oz7lA5twyw0E1kVLDFiJS7dbLpY7Th1fblmNr84kkr0/+5TGO1zFPAbcU5Qd2cyM
         x74vpEPEu7DoQmAFlFfpQim4orULRoR5IAoD/Tj901CBe7FR13ix+n8RKqTA9S7lCOBR
         99qS6J9GUXum4JHlUKkf5hjxxOu2xhk36GuTmdVrkWjcyJQLsQGeqGzZ9muPRcAAJ8jH
         ZEf4yfTix3SqNI/E+fuiYdRjPcBpSEIoBiHVmEzpwOefmy0B4euMkIdMD1YZp/l7J20u
         D48ntADN+IHsGTG0ii3PHbzhv3Cn2oC3aNOVWB+6bGYno5yXOAk4u7edWHQ+wGDnnnwR
         fM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882629; x=1763487429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LKCHaTU9AqqSilVdSEk0nqYpEpb/jCCe95SCGOIIGQ=;
        b=BROc0gTq8xNnFOmo0IudImWjh330NziHE4fNfhPVR8Qm8FGU3uEgk/iM3B+enJAwWU
         QRklbgD30e0/oe97Fih1oYLKAgZdKwmVMLV65K0bqJd194MeKkTqb/zoSMi0o7DWeUXo
         pryFgJ8/gtxOSMbYpRfzqi1MoS+r+1EMU2HS9O8X9WRnZuetB4AOwdw2UvR4ZORuTv80
         +X0LmUClUILT6rNWq+Iwa6ZpFQ+tOlgO9PxGoFp9hUMI11eLtFT38Slt+D94F18RYCYU
         zbMTVLLRXbL5wYpKwaH3Al3t8boUcvpzlwbOAxZnBttM73vAejo7OQDrpkAbSUI1M8Tf
         muOg==
X-Gm-Message-State: AOJu0Yz4DdfqMqGxLc8KSpyvRyDYdlWcnBEh5Pzt2In8KuULZ5AGfnfy
	ERCCbbTxArZk6QhNFK4SprOWmzW25xPUw+b7vcQICF1EBdVIrxqK0Om80q9ZFPbbect9N6sb/fi
	MzCbV5t4Sm9gu5ZD/HTKCfImbbBDas026e/b/XQJ84w==
X-Gm-Gg: ASbGncvRmyL4xyaeZ3MUjqk+9srA4X+ES7XYwqASIjcAK6jmmFTurVK82Ffvl3RJLx9
	vBQpdkQyzmGMds2ZsS2KDrrAnD9142TlZCXY+o5zOoIlj6bk8R45FUaZg4cdrEwR+ZhjlPiG+r/
	gPxICB725Cx/y475OZARUdnNCHtUlX9qIl3GljtZiyHMa6t8qr3um0+sN77YoPeZ/v4BLve9Tod
	ymlFs3gnO0/gDmBWoLMT8vg0EfJf2Y9Kc8tlXJRX5rjN56+j8dU03aP2Cgk0XtNou2LZfpK
X-Google-Smtp-Source: AGHT+IH2f3XqezxeAhdNiKVObMgHBbdajDoMt0Uzx41msTtJ4/Cc2g0V2tOxLNTPJCJid1luqYuD5eKp8Mt/296kpes=
X-Received: by 2002:a05:690c:c349:b0:784:80c9:a4f8 with SMTP id
 00721157ae682-787d534ffe1mr94850237b3.6.1762882629298; Tue, 11 Nov 2025
 09:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141907.229119-1-marco.crivellari@suse.com>
In-Reply-To: <20251107141907.229119-1-marco.crivellari@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:33 +0100
X-Gm-Features: AWmQ_blId-hdIdA29G_YqWQ_lxGPlkPRdUq8v9Z8X8IVcdr2EYee2EAYY4IIHQM
Message-ID: <CAPDyKFqpiWuJs3fZkATnfPejmqL=Ei4x1U9QbuaykuZxca9f4Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-omap@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Nov 2025 at 15:19, Marco Crivellari <marco.crivellari@suse.com> w=
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
>  drivers/mmc/host/omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 52ac3f128a1c..4a13111e1698 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1477,7 +1477,7 @@ static int mmc_omap_probe(struct platform_device *p=
dev)
>         host->nr_slots =3D pdata->nr_slots;
>         host->reg_shift =3D (mmc_omap7xx() ? 1 : 2);
>
> -       host->mmc_omap_wq =3D alloc_workqueue("mmc_omap", 0, 0);
> +       host->mmc_omap_wq =3D alloc_workqueue("mmc_omap", WQ_PERCPU, 0);
>         if (!host->mmc_omap_wq) {
>                 ret =3D -ENOMEM;
>                 goto err_plat_cleanup;
> --
> 2.51.1
>

