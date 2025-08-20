Return-Path: <linux-kernel+bounces-778210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CF9B2E297
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F9A7AFC68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BACB2E8B98;
	Wed, 20 Aug 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8Oq1XSA"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FF32BF39
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708231; cv=none; b=mPfft/8XIx4weB0Js3BLzRSVe7u4wNd85j7HCb2G8cd+t/I8S8Aj2k0r8dRB/e59Z3iE9Vjy+6svDOnqx6cqq4kKPe6RcvlVsgGvMASShu49uaVQung2pkIo8VO/Na8Oj98kscT59wbQ+Fv71uOO8uNYOPvb2Ma84APSz70z9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708231; c=relaxed/simple;
	bh=WzdI1oYR8phntwLqYeaeesclKsoSMLbv6invCVoupTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLhugCj9zQMnCXB2kcYOnqRCpRTjCo39zlVoO5Yd8BpSstzY6rRrGP27LTQuJ4jmr5UgKmiJF5NsicaV/cRiF8Gx2NslYq/x9792KNXV+b7Che9P6HmGUMXnsdhvwZzw4JGLG5bbhj7f4eyc5Mjy4RsfgK7vEp7kYIL6fj/GroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d8Oq1XSA; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d603f13abso314187b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755708228; x=1756313028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQkujuB9vAN8hQhansFuXhh+VaQyrPhFjEbmZzXzSUg=;
        b=d8Oq1XSADB9peoTNPzST92bNBvOHz4O/SNw91zXmMQI52huCoUHHpYB6nhdh+NzsEi
         9VNTQtkJ3nc0fMifYFgdiWeqtPNGsmgaIHp/h4hxiPSrMCVx5k//MfwlszunXMicRhJ3
         8Ekt4wJRsDfrxlTlWk1Th2dkpc6Bp1vmogfgB7McT+3ZIdj0iABEb6AYyWno8AV3IjL+
         Uw/aACyYvDJ6l/I2NM1draQrPbKE89GS4VEIg33trLGq8HhxucePG5J6fYaZirI4ftC4
         zt1VPIUwbDjbOBOZD91/Sn5qwSoCOo4EHUYzXT3zNW+z/0KZl07khfbfyWTiciGczeHH
         JdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708228; x=1756313028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQkujuB9vAN8hQhansFuXhh+VaQyrPhFjEbmZzXzSUg=;
        b=HY9abbZ6CxcoYwRDDZNYvzroC/rwVLcejXS7c9r8Py4afKU2uYpxY7PevYW9L+MDJD
         ZiEMtw4tluLRkEpxGqOBT+13/5Rz5B9jpNkM0PsOBPevoLeFlNAdK/XqQLqfshKxguGw
         539Pxh0F8Q4p7kCxmwEqX/QyRXeFONuCmPxiLLQ+2meNTkGXe11GqeTwmT9GMEOxqiGB
         Z2cyEGZ5vszHg+V1iaWv6V6I5omLEo/FvO1BnmhKk+pkITFlq8b28OWyzhTgWfbU1i19
         qG9gDFtULnYTR5/eUU8YNbe22nx4mT+010PKlocn4b2N1ZiZR9Vbluit3pWtfGTMTpEP
         ginA==
X-Forwarded-Encrypted: i=1; AJvYcCVPoKrohuy4gsG28pv7saYrgmlkx2hmeWsgVwAKNGQAPbTkgNEOA+JfXtM3uU08kym7mLfeEc5Y29vv3t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtEBP9esRqGoHRk0LySZnZ/i7w4omasDh94nBZ6aGKVvo6GFij
	b60BosRgZVqz1P5Kj4w/yONi2sueK3u1jwnAVigrVuLZ9ewGxRstW/FdtkQIQ33iIHiXrqaYTgr
	veuR2I663/vAWO4DzfM5Iy4Ta2gU920bWvFYPd1JifA==
X-Gm-Gg: ASbGncvn+IhDdwKKpYrc7+EtxEI8Husc7OWN3CjEv6YJp+VPI+siio/Ede/0aMkZeFB
	R22WEiz5BlIPdlI4X/JlIEyBwKLiXz2fvLRCTZilWqP3jZeb3PqqzRoBHQHODXiAecBvirKViTV
	+8W8wrbBfXQGLk/Px5w9KFylam+BnNhqTsYVeJXszFhSk0zQExwC9650y1i7Ys6COgPMBeQFFu7
	Jvw8yMUNnBvFrGnDnY=
X-Google-Smtp-Source: AGHT+IE+Wt0j9bfvOyDxK4S5Sk+LF+v0ZkAtLY2D0aSLiBwAJ5C8bcVtX4TZmLbwWs4GZF94qJmrCp4P6UaXDpFQvm8=
X-Received: by 2002:a05:690c:f89:b0:71f:9c53:bac6 with SMTP id
 00721157ae682-71fb322b56fmr47409967b3.36.1755708228116; Wed, 20 Aug 2025
 09:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820104808.94562-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250820104808.94562-1-biju.das.jz@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 18:43:11 +0200
X-Gm-Features: Ac12FXzu7BIyKdX6LwKtLISsnZF2ODfTKPqrr4vIhUqGLfAqz8wea0u8ZAdXy40
Message-ID: <CAPDyKFqvbWVxGU4mvffSJq_QgY33TXi=ezXxbvKyXe5eUFbqqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: renesas_sdhi: Replace magic number '0xff' in renesas_sdhi_set_clock()
To: Biju <biju.das.au@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 12:48, Biju <biju.das.au@gmail.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Replace the magic number '0xff' with CLK_CTL_DIV_MASK macro for finding
> actual clock in renesas_sdhi_set_clock().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index a41291a28e9b..f56fa2cd208d 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -223,7 +223,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
>         }
>
>         clock = clk & CLK_CTL_DIV_MASK;
> -       if (clock != 0xff)
> +       if (clock != CLK_CTL_DIV_MASK)
>                 host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
>
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
> --
> 2.43.0
>

