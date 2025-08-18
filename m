Return-Path: <linux-kernel+bounces-773425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D9BB29FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DC17AEE17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA7C261B77;
	Mon, 18 Aug 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/UTAnAs"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737A261B72
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514564; cv=none; b=IMcYmOGFOJw/Qp7vFq1Anx96CwHW80kR28ZPBTAEyvC0ORkgWHjInkMdh/gvYV7FoYNeS8zESu99ljiXFglKgPPAR4nq99S2NdYZlwacvBMyGCnMw3HdvdwGQHA6UTBc0lJ+OHBnWlmCMrk9ULSbv8BoEpWkn2mG9ccCWrhsluk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514564; c=relaxed/simple;
	bh=cQh8V4MSHSCq71cP6DQMTdJxWDVSbyeNn5X8j2CTEFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+ov9jktCkgnmk6mjQ4EMGBHC/8BJp18ybVQyixCVfm2HqhVAkWqgsT3yuNpdRj+jq9vFnzRNDPxjRbWkiiek9PFmdjLZt6io9u8H08TAYuRYkKPHjkGD7MWSsNsM1y6tams1znPHdhcmAisK2Mt2h0k1Jm/MxRjrZtjJJuIPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v/UTAnAs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d605c6501so33885387b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514562; x=1756119362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf/h379UViupe5+NY6kzAfazLWPK0066Pyufbr9DpO4=;
        b=v/UTAnAsfZ+Xw+dqX1khMjCRZWNf8vHq2E7fq22bPB7stDeNTYEPNAIPYzRbDRko9E
         E+V+ikM9tFz9gnqR3tpd32FbvAKD4MmW+GKaOfR+VFbrU0VcHmwFlKCAIPDzoRnWeDUM
         Mi7TutgMukyq8gI7Fx/QmyX4r5SDBp5DDPnYNZLX1DHrx2o7R3AnM7LwQSs7l8RNtvwA
         oTJETfl3B9xncplFgg6mkufeCFJgmjqPTJ2MJflsvZOGxQfmb892SvGSDl9NOFBPYTgr
         RSRSC+uA9X4zjig+8leK5sFHp5hAqieq0k4V0Lyo6kla/BM2IKAHoow8bIqhywZ84SwP
         3jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514562; x=1756119362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gf/h379UViupe5+NY6kzAfazLWPK0066Pyufbr9DpO4=;
        b=MpWkcxUUWH5BURUnJ0CCAPg+lINNouVMgMb+E44rVWf9Z934TPmv3D5OKSCRzGttsN
         JzuWoSy3WPdphTkTWxdH0a1fyZ2Ni62HFQadreNlLC8mauuTAo1/Q/F+mdiVHrGbgSWW
         cKEB90YpxBjBUSzg31BHfXuTNX+LLd8IQWLrkFh0wjue95LnEJjSVXTjQnK7puZrFl/Q
         cztUhoPiB0/W3U5Hg/tilTvZJtGSFQrcw0KuI1Ek4gM9yN4I6WbvrE1/OpYGQMPtth+n
         Rn6Y0BL3DH5xwBF3/a2qagtdwR2hEg0sKGejCggs0KlbmGs47YojAUSMTsZKcJRtFKDA
         MGag==
X-Forwarded-Encrypted: i=1; AJvYcCXanTqcaee98BfELA7HCSCZGiuV31/sGKEEt5mV3TjyZY8BGu/7AUrZWYFOa/pLE/BvE8dyJUKfkYUk73k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFcbekonqCrB2wqm3ld4d9EGukYMcXWMyZW/nVMndqRMNECc5
	ik+GS74XUuhVbMsYzZSiH8tWWXRroyxnbIut8g+1r+KMmm4P2h0xaGlczCz10Duj7ajJjCHA3S7
	FyJA8RBkmTylfI+NluB86ryXjTAHW+Yr/61JaT4fMqQ==
X-Gm-Gg: ASbGnctdjP6ps3RzaPNXnbhQwJLMRyYdHtfBrw0ttIyIABzQVgjAlN4+UZjUZJsEa9o
	mCDy+Q31CDmp0yL0XunC+/uvT4zliA9VENX0welZjrn2x85YlA8BK/yQIlfxB7TPrOHIjUwIwVD
	QLYub4ojtlna3/N8afhxfqkTMEx+6jqzRvDn/spxRD/TUDWvazCf727elWMgYm18nfgAjqcLktc
	r5vsfyt
X-Google-Smtp-Source: AGHT+IGpvbrDi4hUl48Zba/3/rBPfc8NraKhAc4AfrhtmjNoilheS+QB0WSMwYa9e4qE4gIontoviX/Mi8xWRVPKC+8=
X-Received: by 2002:a05:690c:6605:b0:71a:3849:f88e with SMTP id
 00721157ae682-71e6ddb2fb5mr146226437b3.17.1755514562208; Mon, 18 Aug 2025
 03:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812092908.101867-1-zhao.xichao@vivo.com>
In-Reply-To: <20250812092908.101867-1-zhao.xichao@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:26 +0200
X-Gm-Features: Ac12FXwa1IzQiF3BDBFOd_R2WYobNi0PZbh6LfTaEAaRBfzgD2wCR6ijr3XXs00
Message-ID: <CAPDyKFqeA895DBDKJUcerXAYLGG_Em-vBu9eRMoVEwc0LyX=ug@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdhc: use PTR_ERR_OR_ZERO() to simplify code
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 11:29, Xichao Zhao <zhao.xichao@vivo.com> wrote:
>
> Use the standard error pointer macro to shorten the code and simplify.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> index cbd17a596cd2..6d619bd0a8dc 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> @@ -84,10 +84,8 @@ static int meson_mx_sdhc_gate_clk_hw_register(struct device *dev,
>                 return ret;
>
>         clk_bulk_data[bulk_index].clk = devm_clk_hw_get_clk(dev, hw, name_suffix);
> -       if (IS_ERR(clk_bulk_data[bulk_index].clk))
> -               return PTR_ERR(clk_bulk_data[bulk_index].clk);
>
> -       return 0;
> +       return PTR_ERR_OR_ZERO(clk_bulk_data[bulk_index].clk);
>  }
>
>  int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
> --
> 2.34.1
>

