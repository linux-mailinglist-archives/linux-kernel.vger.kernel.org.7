Return-Path: <linux-kernel+bounces-893123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBB2C46925
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36D4188DD00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1433C26F467;
	Mon, 10 Nov 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONEWKk4J"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A171E492D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777425; cv=none; b=G8g6EH9gFFFSHR7aG/ZZCsizVDMvfh0pZNBx7rznCeA7ce9qWP5mS+nkYnTg3k1qTJGoijBHM6GreuMKEaeYwzBkRinGDOMUMe32Lh4vKyisccI9aw8rrBgZx1Ol5DQPfrhEZQljeJlvszBgYJc5ZiCt2N4fjQAGkLS+ulaMjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777425; c=relaxed/simple;
	bh=zWbNCTtGk7yw43CTCAcuX34n6UWU3vWChmXQCsvs42c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXAc3ZLWP5Fj3WurF64H84toJEVHFXuEHIgpo+cF1rFFWV/6bn7mzx5CIX/4yxTrepIZV+iMjTbgrUURHRlCeTF06Gn6N/2aVhEkr1W71dDHyqzl5AoSGhqrjS3ui2syfy7d7gGJBh0LRAZs3Lrq+KDHAcSPjhO1dCgYAlj4u5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ONEWKk4J; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so3557669a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762777422; x=1763382222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DzW1Nmfxb6NiioFQyuj9BtUlANBvsFTwFmbLEk2yLZU=;
        b=ONEWKk4Jdnzt6NSTRZZJhlzCozURxOxM0ctQAfFkoskUt8gSf4szk1kjdMhFYIg8da
         lk8UDMf80yhtQhXAMtrLyOGogfMjhM7aCNMj/aiiuhs4YMPnNzcj8OPu3dEOJnOoKfDe
         4h3a7YiF82GZBOlVhDihud76n8qXSUIjuIooJDY4F1qPiNWm41wL7t8wsRHdeRekkGCA
         atwK1xppiGCiDt2iRT9uytUUMqTwTBUT1/mfHGMyPqomVeG166xyCVZHFnlC4/7EuKuC
         /tioMpR8zcooXpGQ1rgScon2IcGSGCmdLl/LjN1CanUgNO5zxWWeSwCq2KizBMMbQPN4
         VrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777422; x=1763382222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzW1Nmfxb6NiioFQyuj9BtUlANBvsFTwFmbLEk2yLZU=;
        b=qp9dy2Z+TeHHMRbPGDE0bPqyDKXUlFJa6qdcEUEyXqJGnGB7G9ju3MNeGQwH9Tir5s
         G1lbH439jEfeJOLiVPhN+dqtQZ9QjDrufGfbABgVT2KDPemoLYIzTKu2cEHa96ujk/WY
         aMSPnLW6fyNAtMdnMZ3OKUwHhVG2aCnxuRHmgw3Gp4x1tNGVRPmwPyfJRsUQBRnM2FHN
         iF+Tk7HrFlpCHUAdDfVvMBJ8dgbxnfrPs6u3X8Xi4r4/W8vnWoLAYXbOFDsgelqjC6Ze
         wAIg9p1QEbL1D4LY8TfemKr/uYRwdSUcw3bBn/TzlIIyulPuFrNxs8LCf6qtoZrAyQFe
         0Pcw==
X-Forwarded-Encrypted: i=1; AJvYcCXGN4gxK7aH5HfbGa45liQgnQ0FT4ls3G6aor+6qfgxSqBhmgNOvmPfqYLow1I4Bl789r4JquoX0ps345I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Nchnj9H4tCDTfKjdwLpMUi27WIqtFFLrjZGeXlL3Yeg74TFW
	5+zw7Xf1A9xDSSbH6Z5NdMdcVWcu5LYGYZph1nt7X2RnyDprCrE0emrhBJkJquL8Js+3IDyMjl9
	Xm4+t7kywAwCP6Y3sNRHaa7/wnfL4T+eg1GEx+oHSww==
X-Gm-Gg: ASbGncsSS7Bbpi/o69dc3fn09Sp3LodrTZZECLA5R5zjg9To/tiyVs3FbD0rtqd6BWU
	zFFqewKz0ID0St4lqAcs8N0OekxCKEMgO4fiwVDEiTt9Vzfe+hFq8+DW1jZKn+Pc/jdGTh33XTs
	SbMYE3C/mCn8JuuGhQz/smpLJKKU2mN7LGgMiSSwxwX8TP9YaFJmKeUN8dYyzG9feJdQUNMZ7pO
	vWcA8NYbeuasN6BOm/JnVrnR6FASVhEbRdvjDykuz6xymr6Kz0wmi+tnMMIIQV6BVID7OS8oEh/
	i0cAaCU=
X-Google-Smtp-Source: AGHT+IGm5+Uu79ujlZItIA42GflK7UfV+AyBRUd53fOR/2PdZlplGxgc5r7/bRr9gNtqR7fwtBSp/+VdEs2VA7Pi6Oc=
X-Received: by 2002:a05:6402:305c:10b0:640:c454:e8 with SMTP id
 4fb4d7f45d1cf-6415e7fd2c9mr4878827a12.30.1762777421528; Mon, 10 Nov 2025
 04:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-clk-pmdomain-mediatek-round-rate-v1-1-49441ea27f84@redhat.com>
In-Reply-To: <20251106-clk-pmdomain-mediatek-round-rate-v1-1-49441ea27f84@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 10 Nov 2025 13:23:03 +0100
X-Gm-Features: AWmQ_bnh8tp1oLAuPElgvSFmN8WE23c2ga9LAvFWkFMPaVp1NApY8JmtQI4OamU
Message-ID: <CAPDyKFoq=dJW_FCVykBwH85+RbeZ-SR6=vF0vKw+237TsgOfDA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: convert from clk round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Maxime Ripard <mripard@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 00:40, Brian Masney <bmasney@redhat.com> wrote:
>
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops, so let's convert this driver so that
> round_rate() can be removed from the clk core.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> index af20111067c02a5f9a0d6d751e9e0dc32c1a4d90..9bad577b3ae4bf1b83d4f782bb52f56f779a8974 100644
> --- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> +++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> @@ -309,11 +309,11 @@ static unsigned long mtk_mfg_recalc_rate_gpu(struct clk_hw *hw,
>         return readl(mfg->shared_mem + GF_REG_FREQ_OUT_GPU) * HZ_PER_KHZ;
>  }
>
> -static long mtk_mfg_round_rate(struct clk_hw *hw, unsigned long rate,
> -                              unsigned long *parent_rate)
> +static int mtk_mfg_determine_rate(struct clk_hw *hw,
> +                                 struct clk_rate_request *req)
>  {
>         /*
> -        * The round_rate callback needs to be implemented to avoid returning
> +        * The determine_rate callback needs to be implemented to avoid returning
>          * the current clock frequency, rather than something even remotely
>          * close to the frequency that was asked for.
>          *
> @@ -325,7 +325,7 @@ static long mtk_mfg_round_rate(struct clk_hw *hw, unsigned long rate,
>          * high current frequency, breaking the powersave governor in the process.
>          */
>
> -       return rate;
> +       return 0;
>  }
>
>  static unsigned long mtk_mfg_recalc_rate_stack(struct clk_hw *hw,
> @@ -338,12 +338,12 @@ static unsigned long mtk_mfg_recalc_rate_stack(struct clk_hw *hw,
>
>  static const struct clk_ops mtk_mfg_clk_gpu_ops = {
>         .recalc_rate = mtk_mfg_recalc_rate_gpu,
> -       .round_rate = mtk_mfg_round_rate,
> +       .determine_rate = mtk_mfg_determine_rate,
>  };
>
>  static const struct clk_ops mtk_mfg_clk_stack_ops = {
>         .recalc_rate = mtk_mfg_recalc_rate_stack,
> -       .round_rate = mtk_mfg_round_rate,
> +       .determine_rate = mtk_mfg_determine_rate,
>  };
>
>  static const struct clk_init_data mtk_mfg_clk_gpu_init = {
>
> ---
> base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
> change-id: 20251106-clk-pmdomain-mediatek-round-rate-649a9bf7d30a
>
> Best regards,
> --
> Brian Masney <bmasney@redhat.com>
>

