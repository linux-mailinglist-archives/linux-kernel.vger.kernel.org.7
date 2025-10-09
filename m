Return-Path: <linux-kernel+bounces-846338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F86BC79CB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC84F486A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B78F2C0F68;
	Thu,  9 Oct 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y3hBbt8z"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585E1C1F02
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993690; cv=none; b=nkCch1DsBZFbeiJnZ0J31B6yKaKJzOVXWTkcyIe4ba/tqxJB7NqIsTRYrBPnuH6ewHXY5SQyBoS+LqTChf8GfoXbTS8JtBVudo3if47jtDJNwrM2bEULLBDbum6+R2Of1zpccO6RdTP8q8LVzwQvi3QH7Qb4+Yq08vmf7Y4GSaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993690; c=relaxed/simple;
	bh=LhYyzk6WfYJhkKhEyLTwv9qmYjmpZeKxoucLrJ2XuEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4TekzHwawwY9SY27xOE8eZ+lmm+4bEC7HaRRhspdHQrw29cZ9gC4gFIKr9bXx04inWOjC2aZ6AZYEVrZMo8bD6QNv8252X3xkWgkKMH14M3Yanx+0CyjP3HppgJDpKSyhUnFCq2KLL/zGT+l3s0AF5mj5D9zJvhTl2Zi4lseyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y3hBbt8z; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-375eff817a3so6406051fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759993687; x=1760598487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrEMSIgPZk1KeuuGhcj52P085Zkq+6alNWoGna9Zc/w=;
        b=Y3hBbt8z8AwSILzcdkl6Bwx1zj7jBg53Puw9j1ElP818AHH9BIixjKVyOf7YpVu913
         icKUHN92dLdHT45wRQcU0tg4N5eRUHAM1PRZZHE5zqt4BFCks5+dWLcvZjI6HguWdYvo
         M6KnJcRCdR/J1RTW9Dg7ulpu6Se3NpttfzPR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759993687; x=1760598487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrEMSIgPZk1KeuuGhcj52P085Zkq+6alNWoGna9Zc/w=;
        b=J0qHD74Zyh80dCPulDHkL7S1P0U2I5+urRKb90rXxHFsvA1MEF2LvPlVaJoHQI+pp6
         AmjDCERkNiBJ5gC/bpK9OGsecZwq+Vvz/cL5wiawr2l7E5cBnWXhImGYfuNvyNLHulLO
         HHxSHFa3xa+/rR2KTviD/8jPYzfwXW7v9K3IDpP0h3mGDqSFrg8Okz7NDmBCqmtmRbCr
         Sw82Liw4fZ5ccovHhpU0t7tOzg0KHfIIjNmk7s+tn417NKGjyudvWJ6vkkoXPZyzDQAo
         eX2EUylxN+emQfu2+C2fwnTwFd92JNiPU5moC+CrChKDUblIPC7iUFLazKWpstCOyR2u
         mVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ihnowz+Aa1Futi/+46yKIMwLoiJGJIpnFkdxQ/4TKzxwsU3FRKgRX8SaohF7U+p0iYk7iBWzOTaTK30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Vi8QxqM8AzeYTWnqOR4TUO7OfIjVTNLijCtsdDdgrRB123Wb
	8RG8Etif6CeA81oZWWteMnLhMniAy/L44YWw0BOxAQj+RfhBOg3kCl5lpVJzwAGUxLJm19CpVBJ
	Gq6pi24OlRSTmFCqGTsdKyw9qWOVluzCkN//+4YUBqQ8QoyoZEzo=
X-Gm-Gg: ASbGncuqejwa/O+WmK7QC0ko3mKuyr11A6mXN7JE3VHZ9gxRgxbzvpMPlbUPQJAspGO
	5O6l0yae1bJbbmrasN+WnIxwXPWnWjV/82FxvFGzn1kz7x7yeHJeRyg9ZKiXN24y7PF0dyWLTpT
	yH2ec7AVynNjnk+axEjMlucpvFWQWuTg+fjuthY1iFrvr69EFCdgtmIr3RGCvitEo/++EvDqwiI
	iIwTx0YXZxniiwcV2oxar+5jTy2LaD7098nzNZUJC4KBHMCwVE+PM6RLksplQ==
X-Google-Smtp-Source: AGHT+IHRoD8fUFYarUIhK/FMKZGr2CwU3Gj3Lvi6h5d/Em4hrbue6QlrL7H+4NXmnHM+zo7hkW3w3oPsj8Dawmy7Yjk=
X-Received: by 2002:a2e:be26:0:b0:365:6b40:8687 with SMTP id
 38308e7fff4ca-37609e0ea58mr13923031fa.22.1759993686781; Thu, 09 Oct 2025
 00:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com> <20251008-mtk-pll-rpm-v2-1-170ed0698560@collabora.com>
In-Reply-To: <20251008-mtk-pll-rpm-v2-1-170ed0698560@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 9 Oct 2025 15:07:55 +0800
X-Gm-Features: AS18NWBxQ-yW1drBobxZE5-xVOr4CwQCIc293oxeKqSrQOU5dPVPYMgKJ9ACvWg
Message-ID: <CAGXv+5F_xeC_sGNB9Aev4CQbC_8Vo4YA1u7K60oKu8PseL=Qhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] clk: Respect CLK_OPS_PARENT_ENABLE during recalc
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:07=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> When CLK_OPS_PARENT_ENABLE was introduced, it guarded various clock
> operations, such as setting the rate or switching parents. However,
> another operation that can and often does touch actual hardware state is
> recalc_rate, which may also be affected by such a dependency.
>
> Add parent enables/disables where the recalc_rate op is called directly.
>
> Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents en=
able (part 2)")
> Fixes: a4b3518d146f ("clk: core: support clocks which requires parents en=
able (part 1)")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/clk/clk.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 85d2f2481acf360f0618a4a382fb51250e9c2fc4..1b0f9d567f48e003497afc98d=
f0c0d2ad244eb90 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1921,7 +1921,14 @@ static unsigned long clk_recalc(struct clk_core *c=
ore,
>         unsigned long rate =3D parent_rate;
>
>         if (core->ops->recalc_rate && !clk_pm_runtime_get(core)) {
> +               if (core->flags & CLK_OPS_PARENT_ENABLE)
> +                       clk_core_prepare_enable(core->parent);
> +
>                 rate =3D core->ops->recalc_rate(core->hw, parent_rate);
> +
> +               if (core->flags & CLK_OPS_PARENT_ENABLE)
> +                       clk_core_disable_unprepare(core->parent);
> +
>                 clk_pm_runtime_put(core);
>         }
>         return rate;
> @@ -4031,6 +4038,9 @@ static int __clk_core_init(struct clk_core *core)
>          */
>         clk_core_update_duty_cycle_nolock(core);
>
> +       if (core->flags & CLK_OPS_PARENT_ENABLE)
> +               clk_core_prepare_enable(core->parent);
> +
>         /*
>          * Set clk's rate.  The preferred method is to use .recalc_rate. =
 For
>          * simple clocks and lazy developers the default fallback is to u=
se the
> @@ -4046,6 +4056,9 @@ static int __clk_core_init(struct clk_core *core)
>                 rate =3D 0;
>         core->rate =3D core->req_rate =3D rate;
>
> +       if (core->flags & CLK_OPS_PARENT_ENABLE)
> +               clk_core_disable_unprepare(core->parent);
> +
>         /*
>          * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
>          * don't get accidentally disabled when walking the orphan tree a=
nd
>
> --
> 2.51.0
>
>

