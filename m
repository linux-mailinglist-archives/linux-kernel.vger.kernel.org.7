Return-Path: <linux-kernel+bounces-723828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE686AFEB6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56651C20026
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26A2E889D;
	Wed,  9 Jul 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="di10ckS3"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722512E8896
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069793; cv=none; b=gw/gGBoiPtHfQSfNy9/YN5CIuZBdQaYd5G6G6iDU2tKeXAvz/NBY2I9opOtt0n01WtZWsueb8rCGfKky9FedQJR/4ZwsQx1HeKmI0zy9kBOAF4Z9g+L7IqUo8wOFCZSdxSKQJjwdHkXUf4Uy2DkOqkZohiAAF7b3pHdtgGKSPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069793; c=relaxed/simple;
	bh=XUDGaCvJBz6YoMwE/FZTJi7uSguH2A6CEyneQP2Jlyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K10y2AhZMz9U8AMa9MGnV2KhsT5HcrSmzUTk6sjYiCG2yMlvF48LocSk45F13Tnrsv7EQx33kHUk0lleBCIlO00kUMVIfosZ5kp4VJfab3VXgCuolWhmY4hSwcNtHra1JUZdLLEa2kLzTkwwPLW9W1ac7+XT2OunbKC6nKtddJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=di10ckS3; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e5e6ab7b8so50233357b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752069790; x=1752674590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=icCn+9q6kPmD9b0ulEedxgle71lUmwe2tRNjPUys3K4=;
        b=di10ckS3QIKJXN5f0elUTNvOykUmFH3BVYKQpXX+ikhpYktYTj+EmX+wGzxuD0gIm1
         SIP2DcPC73ERjn8IBTZO/WkxrbjQkLMqhzRrh1CCW2snFCyqw6u8qumHXsGSE0JVJQjm
         DDJVb5j/6FVWdfHvHPnkwI1D2Lura2rzeEmVrvzWf9kXKF+AXPMgByEr59KoWkOCBWvB
         shwHUnPoD/J8tbid1biWvvUvpK9RNOA3/ZrEZFqgGpgjiFFZ/ENfFuTLnh/8oC/z+EQ+
         zKWKL475TUafRE/0+qwBrCs/cVTPQOLqOSLD2ShndAzrT05za4wuPxZpLd0ZYsdiDucG
         YudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069790; x=1752674590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icCn+9q6kPmD9b0ulEedxgle71lUmwe2tRNjPUys3K4=;
        b=nGPTc7a+KPcINq4qHYmIaUjwlmzvAP9RUKDSKScSRco4wNeSxUqv4MPzjaACXrLFHO
         WHatwzSTE8ePq3nWKwCcKSW7MjzwEhky04Yj7ZTsTbc5jygPt03m3nNH27FGSKdVf1iR
         rUG9UxjTdA2Go47c6rORsCfaHQ6t6qaHFME1HRGUFt19bSh4tt/0JHpSmbEHaT57cZ6S
         YfnKvYgIOEAqvvGyQKonDDOgv7dQT6I9iKFaWkhDi2C2PcWXQpicWJDou1B95okhnG/G
         xUZ/GESTjsi6tvlhwL81lrM4zaxAFt59LVr8aX01yFANDvOxEPlGML7qyhcupsJoAjdC
         wq6g==
X-Forwarded-Encrypted: i=1; AJvYcCX9G04shpuixKJD7hqKmBxB6znbhrqQ9sifxPZ8k9xR7d1CqqUenkW4qCFhAU+qed/21uC5L7Lfj0jFz4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwajWepP+1Y72sw+yBQPYFHSKD547n9Ja2ew/BvWAHnSQmVFv6y
	d1HT72B32Br+QV9oiCMc3y3ezDoxZoelkc56PdrIe7FAK8FHh9ndDSerdw2Z/apBEZO15UqvooO
	aMWpgjiYC4hvZCTPhRTsEjP7CCASctY46Y9YWuflxYw==
X-Gm-Gg: ASbGncvQM/A8cQuthwEqcKY3VJeeEq+vIxyYG8ggpwwMn6H/dQz7C0iWRDrRuXlE85w
	i1wvTq9+7N1Aqxbv9GE3CNrQSPUoGE7aX+oo//0zbkpNQdrJptZt8589Fp2zcnTdQbA117FEb0e
	GC2dqyo3ZCfV+7p7P/qYSoYWOenaptRw3mr5IYjpFT/iKc
X-Google-Smtp-Source: AGHT+IHyJ46o+t0mO5xLY48+K9GG9/6xTUQtrqZjhxQ6H5sFIFl3XdMtdUngG/gpuMtaN9caUE3BU6VJXCmbohiatB0=
X-Received: by 2002:a05:690c:7406:b0:70c:b882:305 with SMTP id
 00721157ae682-717b1a8aa15mr39169157b3.36.1752069790146; Wed, 09 Jul 2025
 07:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707185545.46275-1-sperezglz@gmail.com>
In-Reply-To: <20250707185545.46275-1-sperezglz@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 16:02:33 +0200
X-Gm-Features: Ac12FXyz2vOIo_1A0tAmH0M_RCTxhQ0qVbD0NzFevVPE2428c_74Zin4o4qMpt8
Message-ID: <CAPDyKFq5S2srT4qf8wJKgA-Qhry1j=xrfWFipLjUc9weVZrBFA@mail.gmail.com>
Subject: Re: [PATCH] mmc: loongson2: prevent integer overflow in ret variable
To: Sergio Perez Gonzalez <sperezglz@gmail.com>
Cc: zhoubinbin@loongson.cn, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 20:56, Sergio Perez Gonzalez <sperezglz@gmail.com> wrote:
>
> In loongson2_mmc_dll_mode_init(), `ret` variable is declared
> as u32 but it is expected to hold an int value.
>
> Fixes: d0f8e961deae ("mc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver")
> Reported-by: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1644958
>
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/loongson2-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
> index 515ccf834f0a..ba6bb8fd5535 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -485,7 +485,8 @@ static irqreturn_t loongson2_mmc_irq(int irq, void *devid)
>
>  static void loongson2_mmc_dll_mode_init(struct loongson2_mmc_host *host)
>  {
> -       u32 val, pad_delay, delay, ret;
> +       u32 val, pad_delay, delay;
> +       int ret;
>
>         regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_SEL,
>                            LOONGSON2_MMC_SEL_DATA, LOONGSON2_MMC_SEL_DATA);
> --
> 2.43.0
>

