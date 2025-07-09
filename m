Return-Path: <linux-kernel+bounces-723511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615E1AFE7C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AC616C2EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FC22D8371;
	Wed,  9 Jul 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EN7jCNpm"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335F2D77F9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060687; cv=none; b=s1qO+8GBQnwqKUYKl8SAsdZkTU1p0KsPiDAMWEPJcCwk82IHfpvfumhu55ISgWvVDK8Ok3JI5uQjfo0GicGEr7E+FnZNCKnBtu8U7vX0wzc56Zy+Gnj7IJxf5q/9FcdZaDV56+mlSQQvXrKXhtn26swgzShVQCd85ycYDt7vgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060687; c=relaxed/simple;
	bh=N8QY2YLbLqwZxs7VhmrGcUAii95hVfhe2zG9GwU9b2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CERMp6FWMeCvIhemHcedjOXPbnJdviSJ1oNcd7BEVETJFjiMK+cLW6bgTIBkAk/wh22RaC9DEkZfijq5km10fRFLlFPGDHtVrrmIuSqZEB6QwjoUpMwK88CdIurPptnokDXcjlo9t6oRU7CUaCmgcgoxhkhferMoosiVSUSuiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EN7jCNpm; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-712be7e034cso47999617b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752060685; x=1752665485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDvxz8anR+BJ4sHLfVXzhIbmkKQRFf6UUA1osiYchOg=;
        b=EN7jCNpmkIWhW6NN7O6gwnZKkXTKemOAomy/L64yPJHPV3EnFX1yqI9KsR1XHxnawc
         yra7yuFEYDnxRkZMcqzk8jnWcix/jf2MxDibQKNVy7CP1oR97d3Lmch6g/KpZQPLeL0M
         2EGvqk0wHv64xqxcTHKQlRiZLt+0U7cI/e0JGTr9dkxBs6JwwYwregd0rWS+Go5QsVga
         Gqa5fby62A1KAkPl2UhNE2wMJz2BQyOdHrdlxlwJK1jyyryjcylrKUSns//xIc8le4ET
         6qYDzpo13i2DkeJJhp7/R2z9kU6vPNEu01PHCGdDbkFfIbVEtc2nySE/ri9k0udNFQSh
         x5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060685; x=1752665485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDvxz8anR+BJ4sHLfVXzhIbmkKQRFf6UUA1osiYchOg=;
        b=lhlVOZNjfr0hxkDqoA82NHB6lx1jlzRJHZaZCaqA0tMwDloIjv3IkePS7dboDxjGnU
         yFzx25kJzsi/ih1NlmbIPXFtBvp8ghITm1DCtE8zA/PB095u4f3QOwwopFu/zgvYPGrP
         L2rRvCGK5gE/qryuCvwR4woiLM0PbDNDUfO1+AdZv7+B70+DeFZ5GJNIFI5Yunli1/E1
         iOFoLVBjedUyAtq+z3gDuV+5W4SxHayGGZlR9KEUZp/toPXvQiup1lTvNLXV/R1qXl6e
         gyj8y9DKxYIa/8lVvOUtyVQr26muz60uq9wCnRwfU3Rs0Y5N++Q7CO4nqnnW6qhMP742
         PLWg==
X-Forwarded-Encrypted: i=1; AJvYcCXbKUIHeLS9JavCzvBDwHIaoAteX/46pSHwuaPAf6XsX5IrfUseP+auKN/fceGWbLR1VRZHuriZVT828pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwswUJxAgcs2XjGuDk49a1vDpKFSLyBrxyWA1d0t4DIp8JOnQNR
	WnDqS81FkOpKVxqS2FA9vBkIDU6xYjMDM8PBXkXlAKUAYa8AlLwR7djKpKQNII8d2K1TCZ3c6/H
	l1xBEVJocvCOx/yBZ49PSRKk0c05AvOFc6LwABhnKaw==
X-Gm-Gg: ASbGncuKWPzhjRwA8fcVpGx4K6hIygKcmqfVjF/6yKjhgR27OE8XFxbLrjCH7+p2lVh
	5SU62qcH/z4ShsH3Lm2wz6HlyDf9rM5cEV0Y5dQZ6mP2Z9mczff9d2F1pTuz6JUMo3fYw+si6pz
	cU7tNiDm8yd5NuC0Duq/WY+zg6SaSiEului5oBNlxiuqAPejpLnwKRvNE=
X-Google-Smtp-Source: AGHT+IGU+pji3u6/G/drrXD9f6hzZ57lAuY7UQylTxtmRHqJxsYBUBEDT5Y4GQThZIBDfvEDAxWsUuXsGoMFEvARnXI=
X-Received: by 2002:a05:690c:6901:b0:70e:2c7f:2ed4 with SMTP id
 00721157ae682-717b13c163fmr32649447b3.0.1752060684637; Wed, 09 Jul 2025
 04:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e71abd8d75dd842690e5a11e38037bcf5feac189.1751816732.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e71abd8d75dd842690e5a11e38037bcf5feac189.1751816732.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:30:48 +0200
X-Gm-Features: Ac12FXwjFFHXtdaaUqyy9FfmUbPYblM-fvRv4hnhCWqr-KyPAgwmhH4mdvxEDsE
Message-ID: <CAPDyKFr2VPbQRRx6hYp4e6by1O4LvpD=WwwP2gb2KCMTB8uQGQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: amlogic: Constify struct meson_secure_pwrc_domain_data
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Jul 2025 at 17:45, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct meson_secure_pwrc_domain_data' are not modified in these drivers.
>
> Constifying these structures moves some data to a read-only section, so
> increases overall security.
>
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text    data     bss     dec     hex filename
>    9248     408       0    9656    25b8 drivers/pmdomain/amlogic/meson-secure-pwrc.o
>
> After:
> =====
>    text    data     bss     dec     hex filename
>    9344     304       0    9648    25b0 drivers/pmdomain/amlogic/meson-secure-pwrc.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Compile tested only
> ---
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index ff76ea36835e..e8bda60078c4 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -342,32 +342,32 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
>         return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
>  }
>
> -static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
>         .domains = a1_pwrc_domains,
>         .count = ARRAY_SIZE(a1_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
>         .domains = a4_pwrc_domains,
>         .count = ARRAY_SIZE(a4_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data amlogic_secure_a5_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data amlogic_secure_a5_pwrc_data = {
>         .domains = a5_pwrc_domains,
>         .count = ARRAY_SIZE(a5_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
>         .domains = c3_pwrc_domains,
>         .count = ARRAY_SIZE(c3_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
>         .domains = s4_pwrc_domains,
>         .count = ARRAY_SIZE(s4_pwrc_domains),
>  };
>
> -static struct meson_secure_pwrc_domain_data amlogic_secure_t7_pwrc_data = {
> +static const struct meson_secure_pwrc_domain_data amlogic_secure_t7_pwrc_data = {
>         .domains = t7_pwrc_domains,
>         .count = ARRAY_SIZE(t7_pwrc_domains),
>  };
> --
> 2.50.0
>

