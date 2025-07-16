Return-Path: <linux-kernel+bounces-733290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94FB072BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09BA3BD94C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0972F2C5E;
	Wed, 16 Jul 2025 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sb7cT2DB"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA132F362F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660552; cv=none; b=gtHC71s/ZcpxZYZUUmMyZAvhyKyetLcH1CyySymL82UbuG1smAweBs7W958Yf2TAvQRvn32IfIXWlwOz/KvKRZDLx+tL7DPYPgFhmdSh3HCeJSZclHazqXXGs3XBzfr92SLTH4NA0KZWNDP9Y5LYe+33Fgzdji7y8IU+j0s8HPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660552; c=relaxed/simple;
	bh=bYR1c9LIUL6l7D6Wuh18sl8qUWFTwYdOeejSsA0iDBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbDEB85QG3iWjzR66F3K6WsCs1XO4oZuvvbRX1N0TUXru3F1KMn74RH2sVqVNFQaI0YyUrtfFnTw0KzQ2btbfZwdASZ7UuOUW4+qeE7ffc8e1kFOiUebNOukq2yhuOG4AzA32g6ZNjVkkdDN5SJPC7UFeGHh6RUVVXIBdAbXziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sb7cT2DB; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so5549890276.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752660549; x=1753265349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaSlIX5JSMkPDXYG9OHGWw9rTnf4dMbBtDMCUX1oXGk=;
        b=Sb7cT2DBKzu0dLJA4pKIFaNSayrw3zi+x/xQ1PZ07iSCbQWylfToz1gQ5LJTB+4eMk
         mBPS1BqqFR7JQDvuySXht3HTE1SOXSmNG9+dw8v0ny+BMr1M82EF4s/0gUIpuj/jXM5Q
         3uotcC4RsxC+YZ+DpnpxkHRX/NUYBOTxzaXh5npZtBtvwWPTipOUMqXkbCp026HlODlb
         Nzh4HmVpUcq+e9Jhf3miiQQ1Z6Xh/2Yq3iQNZ+FVgiM4X7AfkX+dMyvL0NNPbNOMKxec
         t6WUe9qhAxRCNbunJn/TdNP8v8OrA1ncgobXzOmB42NPXfT2aYp3cfWWSnPhAbDKCc6Z
         joOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660549; x=1753265349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaSlIX5JSMkPDXYG9OHGWw9rTnf4dMbBtDMCUX1oXGk=;
        b=A8r+dxtFiknHIfVvlusV6u25H6JrVIl83rWc2jE8zPmRf9bl293h98t8JdgSDMh4Ta
         XZ59MGZCy7IiVKTgCHsNdU9jenUdCkJgknRmg36Mb3zf4hsl6eRhdiIKWZfjVJ63EVjR
         Qn9W3fbyOYuqrAOW/NvJP+rI2QJ34z2x8Z1Rah73EGImlrICEmZ4NxeckSTxCRuKirpW
         zx/cqFbkxIBNI10jOtqdiEmDQS2Urtqz5kfVSYWl0hMcQRmB2NxQYVY2yDyuXFLUVVdU
         diHvrrQRObw7sdCqr8sngmpo3wo6zGLzAts6Dmb4Gd2ttdjV0M3GWPwIqbNenyAaorKQ
         cQzA==
X-Forwarded-Encrypted: i=1; AJvYcCVvRo7mtHgn0ZEn2PeoUz9SSd8ukSqYxL1XlKTb1+SWYTRzJODpuu5w9D7h/hum3EMw1SalJxe7M0kGKy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZGpiNqPqk8a4QFYbPGPL2QltAsVkLEioLO0ZfTXvuG8XeuqsB
	wgTYPC9j8BHNaDazG3nrt0G4PzkAE7QOIMULNbDzB0a5QIFMTtiKcpISzeAJfV6kDLOdNeVswy7
	QHgf339Llp1R/m6RQXsOkVomjS5MMhu0uQYtUgYJhhQ==
X-Gm-Gg: ASbGnctkHu6zft6g5X9FSma7ZbC1zptt1gOyu+xmZbBU9qy09BNtnt0YX7KS8n7zOlI
	W867AVfxf7kcjb/MH/Q7YqtlOB+HQcmFND/hRz+Hns2v8Av5cC60wSH7Z/btXiUYthDK9f0LHe1
	OEgxGY/iKRndgAepUCXhXrWUYFgha1Wv4N/IsX2V+ljNzIIhjfWK+QwusuD4J9X7O21JnVUbkgd
	cyAV863
X-Google-Smtp-Source: AGHT+IEVrqdnzjgna0nPf8/QlqPaakZ0z/Y4vr73ndJXG6lcTCHSif5oJvQaIYU9G6d6AxqzY4LsoRudWzSfDn6eIO8=
X-Received: by 2002:a05:690c:22c5:b0:70e:2ba2:659d with SMTP id
 00721157ae682-7183747da57mr24628487b3.23.1752660548791; Wed, 16 Jul 2025
 03:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <847bf395-6d62-49c9-a39d-8e82c5b17bf7@sabinyo.mountain>
In-Reply-To: <847bf395-6d62-49c9-a39d-8e82c5b17bf7@sabinyo.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Jul 2025 12:08:33 +0200
X-Gm-Features: Ac12FXzW2XIbQtUDaHN3eu8QGSaXiZ3-1JrKO6jE043zd7_dvv1edcxvTnJN-Gw
Message-ID: <CAPDyKFqsP7bHrN6oBi0Wvy-MRZNko3uOq6wiH8vf9QxOeJuEug@mail.gmail.com>
Subject: Re: [PATCH next] mmc: loongson2: Fix error code in loongson2_mmc_resource_request()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 01:01, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> There is a cut and paste bug so we accidentally return the wrong
> variable.  It should be "ret" instead of PTR_ERR(host->clk).
>
> Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/loongson2-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
> index ba6bb8fd5535..63d01d2cd978 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -887,7 +887,7 @@ static int loongson2_mmc_resource_request(struct platform_device *pdev,
>         if (host->clk) {
>                 ret = devm_clk_rate_exclusive_get(dev, host->clk);
>                 if (ret)
> -                       return PTR_ERR(host->clk);
> +                       return ret;
>
>                 host->current_clk = clk_get_rate(host->clk);
>         } else {
> --
> 2.47.2
>

