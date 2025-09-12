Return-Path: <linux-kernel+bounces-814129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD8B54F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496F31CC7B34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC273019BD;
	Fri, 12 Sep 2025 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTBiYciQ"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F12DC791
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684084; cv=none; b=d4howwKx0rgbIjVJKw4+Btj53aZ9Fu1QIzHZbt7N3ki3kPerFdlj+Vjf7Db0TEtsMlJARMvo5smCtoGvb+xoXLUmGIGCFKi17OChmxHKRntYH2KEwKYzsYN2SG5sPuJMwT/FMm1/5WIpp3ax08O/k6YR7JgtixuQY6q6xecWFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684084; c=relaxed/simple;
	bh=LNKzymsgb/6Iwg40XhzmFUiClYs9OYnQ0dLnby/t7ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvsC2vYHLl1DB7sqAk89O5WPwZP+SffxL7XCHcd/HDDK4eU8eR56feNuZrAEUG7Nk0bbMgR5kK8p1vT1kCY+G4OkYwnT9oVSjY/Z8+pWfVt62bhUA1taenH7Kw6jtt+Jt6Yprv+W0rNlVIlc6I7XE2B9bV7IlSXoQTjHXf+55jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RTBiYciQ; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ea0297e9cd4so1195107276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684081; x=1758288881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ/K8q1HzdoHIMtTKXskdUrRNYCvrta7LlIcSp9TUsU=;
        b=RTBiYciQO3DsPhCq6bNle2T1xdIkKrALnQdabNbJ4hnl/BUqxrMQPRhoaVCotzHg7L
         F1YytPuJm6NHIGC8+je3LkGxDxAiZCQlB0BOc/eLxz+LJztP1B/cwgd1R2JGuCMG1+eY
         obiTq02l3MfolLpY6gumvqcSe5mqywMWHY3ywWiCkEMm0Epq3wiqDarFCwl4mhdNMy7n
         AoAwvwtVikEvwJ9Lglc4M5PjqtKsM5qHWw0I06q1+c0DUvWOuL+9iEUj7d3+VvNRcYam
         Ot0ffcJWh14kr0/naEVpaWensuzPYfJXcxrJr6y+WCvEY0kk/34fDk+p9p36RElTBT5a
         N8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684081; x=1758288881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ/K8q1HzdoHIMtTKXskdUrRNYCvrta7LlIcSp9TUsU=;
        b=rIwuh3867DtF5wQVYuAVXFSMDUjv5BL8wBpG4V0F59hMkb8VHZlaCOQCRI1d1S+HGd
         QfQgw+rKK8lwu7zFSw1/gjuEfcwN+Pqc0oxpmq2lzU72y5UOBWrFl73lE178I1VntTQZ
         9yd8U6UY8ibHhd31nlGnllqC0Au+MMqIvH1JQUK6Q/chseVnT3MIcQp2vMI3SAGD+Voh
         kbzJZNQQicTsxlIRebhycFmwiW3HfOwdpknNNVNtEKYOabJqbU0vvdFgdVdtENvzVFLe
         BCxxGBAf4Xbp1DKJwnnygBvRwth2FC4thccLCuXW7TOZ32JHeWSDyTD+FDAbus9cvfx3
         +iug==
X-Forwarded-Encrypted: i=1; AJvYcCWcw6Dn0uqr4iMQHbS5LfsZP+L2Xf5rO2OVQR6tOqKWBuF6ey3s6kWdjTaT3fqXEqJaYbpwpGN0XYPMxjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3g8adGc5nWd6hkqbMu6mnKbgoEnUGmekjyqPW0i9Pf/Qi0KPD
	kvUNueBcSz8RzLn2JqBbcd4fObB/hujxtDWl76McBtX34/LqVSpgS1yDTV7SQ2APwmInA7junF7
	2+M/d3t+lQeHNcrPnq9AkqQguS4l8/7q5lxHIXxxl6Q==
X-Gm-Gg: ASbGncuonZYB0s/bVRn7iGWjJDWpwPT0qdyCUgL5oLFAd4lek7IuCiOEhSGvZ+rrIWz
	I2EunHYHF/tQ8GX7hsxniqcVHf66aDlnUcWz6ryv0RoUoOLrVoXH34SXv4tDJmnABOwMf1oyq/D
	tSsmU3q7WtgkXb1uEIVDK5IvTfP8wp82vMPh0v6etjCbDLsg7DTP66neYENtS1l6gIb1hLEyB3o
	eY6ltdH5RoEDl9nCMM=
X-Google-Smtp-Source: AGHT+IFU/1m7pdVKE0NcSMn+u8VXuWyV25MtsVbS6YuHqP6NuVR7mVq1wHW3//d0OvD3Ag7uQcwmsaBXlaeICB6KF/w=
X-Received: by 2002:a05:6902:330c:b0:e96:c4f2:1f40 with SMTP id
 3f1490d57ef6-ea3d9af39e7mr2133916276.46.1757684080633; Fri, 12 Sep 2025
 06:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826075812.82305-2-fourier.thomas@gmail.com>
In-Reply-To: <20250826075812.82305-2-fourier.thomas@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:04 +0200
X-Gm-Features: AS18NWD70Za98HPo5BqoaFdKJPpqyjBZynLCy_vXOulb13mtCddOduOwnUrku8c
Message-ID: <CAPDyKFq=3RANVUpZEJMTLH2YewJN=_mV-kM7DBb4-hhHPFv4oA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mvsdio: Fix dma_unmap_sg() nents value
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Linus Walleij <linus.walleij@linaro.org>, Pierre Ossman <drzeus@drzeus.cx>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 09:59, Thomas Fourier <fourier.thomas@gmail.com> wrote:
>
> The dma_unmap_sg() functions should be called with the same nents as the
> dma_map_sg(), not the value the map function returned.
>
> Fixes: 236caa7cc351 ("mmc: SDIO driver for Marvell SoCs")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mvsdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index a9e6277789ba..79df2fa89a3f 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -292,7 +292,7 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
>                 host->pio_ptr = NULL;
>                 host->pio_size = 0;
>         } else {
> -               dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
> +               dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>                              mmc_get_dma_dir(data));
>         }
>
> --
> 2.43.0
>

