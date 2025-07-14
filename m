Return-Path: <linux-kernel+bounces-729734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F2B03AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DEF17B0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3416241136;
	Mon, 14 Jul 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="di1SOu9k"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A8237186
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485688; cv=none; b=pXOaY9iqnekiAjTFL6lhNbXctNbYuHHlJQpyhgfEjbID/wgZ84opqRhzvCbJBV9hASQRKUifDxTsqktSlhR1+WMMmSGxOVZiV22EOO749/N2+9RIW0cf4rf5CiBOwuVocTb2zju7FB3+0AT2hd6P83g5tvXsb72uZOEgqVNTIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485688; c=relaxed/simple;
	bh=UfwKYdfhLk2Qy+lp7anf0iJDtzV7naJAbuUbpizuis4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZnxaT9j9LOi1FkT653W2ta+XwHSQS9zsT3FArjGPr3tAHZB04HXxqJP/9r2HokweoF/HDLRoatc135wx0rIcwRh6BXbMx4u0vcNJYmhExeM1ltSKwp6A44V75UaGF+yi04vW13h9nwhOQIaw2CvCp0BeDfjJ1azb7cFOxB44z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=di1SOu9k; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e3c6b88dbso27946787b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752485685; x=1753090485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEmmr4XGYIHTUb8r2LHfVd1MIoDVWAOSUqn/NEpPRbM=;
        b=di1SOu9kEFU45yaf/R5J/6R+Bg6mYwoa9dYW5LtCDcJzD1ToEk5wcOtE/9Iag6dWcf
         FJzKHkIh7LL9XZpdOe9l5mpGzgzKV4lf4vbyjSiaY0E0Cf6eQHy7jBS4RssfRCQ1bwiK
         mlMjxiK0WpoBtUfGVevE+X+EhK7X41zVYyF+DisvaNNr+F3CYwihd4eVhJ0BqnSYxIce
         42AvKP1sASthFrA0dcHmdF97uoz5WHuebMavzGRy4uhPicT7vMZGkPUjU51aZViAybC4
         YlP3Ig+ZWzk68fU/dCrGTPcN4CJuLBw1XKm1RVRyE76462b88rNzZlxSw8Ef4gfToPtY
         hqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752485685; x=1753090485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEmmr4XGYIHTUb8r2LHfVd1MIoDVWAOSUqn/NEpPRbM=;
        b=jX7NArnoIevp6pPZCPZLwdkL/ciTtbUohAlcQMhXsq/DUfqMK0PeuMq7xwjNcDQBzN
         XE8JmyOp9Z/ccHVejUEUpqWrxdVi8gzozALOjlEdZZUB3KUPTyaeFo+VZiVYCeElUPAa
         2x5fYOITw8MyqKEjMN71Rjna0FKSiA56epLdMKksjPidX4/9xLPxU0jUhuS8wdzLw1Tk
         izCZq5luqlvYdtSgtdnkJ927EEhlQK+7+iYc9ww0ecXG4bNxBj3Q+YOQ5tZGDQuzFRmW
         W9weJXOiss8vexPlfAXkhiqk3V1cWyVLTztP2n+X8m4ncwkZqGe98AFHHuJcfCLrCg+W
         b50w==
X-Forwarded-Encrypted: i=1; AJvYcCV9jOdeKBUqIH3iWYU2Oqwt/Qlm3ZcwBV/gyUWkWP3pJh1WMEgfKhnXxCHfnRZ/mJvjuP/IYgFz5ySfpt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCmgURiqfoFpynMd1S03CP67pO5ezTbf2WDYrqSnqbFhyf0ov
	lBoz+D930IrsvjHhGtIFX1m3C00lhH74c6Y8+fzBct0XqfM8AEf6xPan/jvTqDX/1Dm6x12vxtP
	ETBuGvfom16+2qBqHn/rO4myWBkvtE5oVmq/eJHXccQ==
X-Gm-Gg: ASbGnctSsusjZf4Z94xhXD4MBPh4R5zsxN91N4jiommtizP/ayVRgQJRsYo4+tUu9m2
	no1Tvb7tkUj6gqHWAsaYNH3w0QpaYaxJCaidDGiZzitMna8OOpvT8k18oO6I2ZNIFaznVaWTJ0n
	XhWtt8dAauJsWpuoxFmUEGezvKLDUO7If7PTnM8huXbe23PBRACM8SspEKcUduAKhOruzBXW37h
	kZXV7yqsmBVcAnx+Po=
X-Google-Smtp-Source: AGHT+IHIlg2QgBnKLSKe6umOG6mLkyHuyOGa5CDuUCJGRmLch13uGRl1lyUH/fje8e3UhcJpXB/eeeAkkqwb0eDhQ3E=
X-Received: by 2002:a05:690c:628a:b0:70e:7ff6:9ff3 with SMTP id
 00721157ae682-717d5f3d391mr195973477b3.35.1752485685299; Mon, 14 Jul 2025
 02:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114719.189441-1-ulf.hansson@linaro.org>
In-Reply-To: <20250711114719.189441-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jul 2025 11:34:08 +0200
X-Gm-Features: Ac12FXwf4BfTjOB0bq-V0l481-9ls28bgQwLelpMu5ij-cJg8s7O_Ow2nAI2D7E
Message-ID: <CAPDyKFrouK9b8Gd+DYg-=BE0dYVuiwy3+Jkrp1=4dDXu90gDTw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: samsung: Fix splash-screen handover by
 enforcing a sync_state
To: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It's has been reported that some Samsung platforms fails to boot with
> genpd's new sync_state support.
>
> Typically the problem exists for platforms where bootloaders are turning on
> the splash-screen and handing it over to be managed by the kernel. However,
> at this point, it's not clear how to correctly solve the problem.
>
> Although, to make the platforms boot again, let's add a temporary hack in
> the samsung power-domain provider driver, which enforces a sync_state that
> allows the power-domains to be reset before consumer devices starts to be
> attached.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/all/212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Marek, Krzysztof thanks for reviewing and testing!

I have applied for this for next!

Kind regards
Uffe

> ---
>  drivers/pmdomain/samsung/exynos-pm-domains.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
> index 9b502e8751d1..5d478bb37ad6 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -147,6 +147,15 @@ static int exynos_pd_probe(struct platform_device *pdev)
>                                 parent.np, child.np);
>         }
>
> +       /*
> +        * Some Samsung platforms with bootloaders turning on the splash-screen
> +        * and handing it over to the kernel, requires the power-domains to be
> +        * reset during boot. As a temporary hack to manage this, let's enforce
> +        * a sync_state.
> +        */
> +       if (!ret)
> +               of_genpd_sync_state(np);
> +
>         pm_runtime_enable(dev);
>         return ret;
>  }
> --
> 2.43.0
>

