Return-Path: <linux-kernel+bounces-888355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4F3C3A949
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2A71A4512E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F62F1FDF;
	Thu,  6 Nov 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+WACv3a"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F72F4A04
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428685; cv=none; b=ikitxTjQvc31v/jSE17J/XtzTCsoE4ANPfe4ho+YAI8ey+rbgjP02o/dkpXwiwSXsLjlxp/zbgBY7X36E8p1qC7vEqCZ2XsqCKMgEFeEYD2B47JF/VzGeqWOUL79VrdZdg/XuMYu+I0qLiIpNokM6JAzMcPsO3I7W0kSWKcH9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428685; c=relaxed/simple;
	bh=H2DNmj95Fq8i7FycREunk7PBoQpmQkeo+jtVILW881w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIjVtYIY43tocr+Ec/TqaZ6XYsnyk+r/m2bHWr1yPU6/thchlxjRExnAbaDoNAyirWNlIrNAAjdzUKFVnnk7GBs6iADoOJh5HQjz386OdegXi1e3VrszrfudWTbBWLcTXmJPpojNDLuNYvqW6CF1aWE5Y85mxKPcMG9zaxWJJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F+WACv3a; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4500b2ec59eso136716b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762428682; x=1763033482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGk+iMMQZ2vEJTeI4z0/vF9e1THhn3jOf857E98Hpp8=;
        b=F+WACv3aHOAbFPaMYobgxpYvtN4TzeXD9fjvhbwrw1W6sajKCLNJx1sKHxeQfUz5el
         BMPioE1Y0Sv5LIN/11mUpmKYubuKeXWSrWONRW1jr0cAaWWrRACmFSk+yyRJ8fMxIIJF
         D9P59f8lhw0Fy+7UCHk+NhiXTZmS/9nxtvzbMJ2IOFkvT5DV3121V2rVjxvCwQlpk/yt
         c/WF3dNJyeYUwVgtzFbuza9mXi1q27XGbq1fhtevx1vmQz7BUYbPM+UgQ69o2kko99MB
         iX2z+2qQ/IihIzcyZlwMI5se+Una4XVPf8EXrhtS14H5DFo66We6j6EDRywSPebiJwsQ
         L3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428682; x=1763033482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XGk+iMMQZ2vEJTeI4z0/vF9e1THhn3jOf857E98Hpp8=;
        b=H2Pnq7hNy/+Li+AUqAUfyyty4sf6t6IfyDm/vTgTMXHPCKbkN/iwF8NFYvMWQ/LjNM
         qs7Hq1nWTXVHLt5Vl1E+yYWz9AjkvIFWNvjzSw7RGkaxEnZBdDpU3LJZoEwtK5GR9PRZ
         NRVSPQbRXYa/ig1UA6SJrZ6+NDB4A2HHwtUJiMZqt5qU2HIZ1MxFItH7ocbqI2mLnP7O
         XOPJKBdSmDfgS39Tf/rs6jHp5dMRYVprlFJkDAfuc7jBmHeNdKj9f0m7G9cWoMLsRh5C
         eTox5xjVwxzBygiAeWm/2vtDPcPX1/BqRV+8Nhe7hfkRoVxHiw8zK27AtYNY4Hkr9zZZ
         9YEg==
X-Forwarded-Encrypted: i=1; AJvYcCVeuUnI71TxF9/lUayvp3EuDdzjwN5KHs/GAxnXNAVDVEfi4lKlGIUSxutmojhCj+wVqhxzUxu+x1fhogI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyseNMAWe9T0XTa/cWktlzOoNhvpkEbRVTvxskHWaTXvIv7eH/v
	GYxOr/7yuw8OalFBDmc8/L7idHS7bMu6L17MqN+NqN5f547FLr79BvgqC3ywYamxHypztxzxT5W
	I8yDssRVmKlvrkNUMcD/H2gPIDa2zepYY6sG7SV+QwawUi2ODooD2GE4=
X-Gm-Gg: ASbGncvr72mFkpmwoV+Ri+OlkNzfbCt2milKmqD72XzaRIqmXRDBODSE5c6S3rieDCE
	KY01aPzS1egFUi1vSDj4Cszno2vU5vuQWAi1aTPyzZL7Y3f1KuJRQRzFkGUJf/rM5fJD9Wou8r0
	ieqvRz+IqbEy57JdBXLN6vk9Hq07smeo9N/YY+WWG60RgmkuvXxUG8jThJ3nnrQ41Lnl8fjA021
	qA85vFbPe0OCd3JbqAG+ZJwmKonozdDm6eU+AJn/zbcr7QRwPgX7UhekkXwgg==
X-Google-Smtp-Source: AGHT+IHkj4o/NOZHcWbw6giq3vF7bwqq0UNMoWmtnanbMAE/Exe7GRD/6wvB3w0v773txVFEKCGg/5jZY7nBpsA1L1k=
X-Received: by 2002:a05:6808:2448:b0:43f:5f02:2f30 with SMTP id
 5614622812f47-44fffbb8abbmr1722155b6e.4.1762428682039; Thu, 06 Nov 2025
 03:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106102008.1310234-1-yangzhao@kylinos.cn>
In-Reply-To: <20251106102008.1310234-1-yangzhao@kylinos.cn>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 6 Nov 2025 12:31:10 +0100
X-Gm-Features: AWmQ_bnTe3Bqx-0i6NqDlTVTxcKF21ZI3fkaw2jHTg947odKhfSyeYi5j-a1WhM
Message-ID: <CAHUa44FAUyQNBKmzugu-_gv_Jy_AftZqq=RSbKUnK1QQbL8Z9A@mail.gmail.com>
Subject: Re: [PATCH] tee: fix illegal pointer dereference in tee_shm_put()
To: yangzhao <yangzhao@kylinos.cn>
Cc: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 6, 2025 at 11:20=E2=80=AFAM yangzhao <yangzhao@kylinos.cn> wrot=
e:
>
> In tee_shm_put(), there is not only the NULL pointer dereference,
> but also the illegal pointer dereference.
>
> shutdown() --->
>     __optee_disable_shm_cache -->
>         shm =3D reg_pair_to_ptr(...);
>         tee_shm_free(shm); -->
>             tee_shm_put(shm); //crash: shm->ctx maybe NULL pointer or ill=
egal pointer
>
> Check whether the pointer is NULL and whether the pointer address is vali=
d.
>
> This issue occurs when rich world uses the 6.x version of the kernel and
> optee secure world uses a lower version (such as version 3.2), and it is
> highly likely to trigger a kernel panic when conducting hibernate tests.

It sounds like the root of the problem is in the TEE rather than in
the kernel. How about fixing the TEE to avoid supplying garbage
pointers?

>
> Fixes: e4a718a3a47e ("tee: fix NULL pointer dereference in tee_shm_put")
> Signed-off-by: yangzhao <yangzhao@kylinos.cn>
> ---
>  drivers/tee/tee_shm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 4a47de4bb2e5..de01d16409c1 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -722,7 +722,14 @@ void tee_shm_put(struct tee_shm *shm)
>         struct tee_device *teedev;
>         bool do_release =3D false;
>
> -       if (!shm || !shm->ctx || !shm->ctx->teedev)
> +       /* checking pointer */
> +       if (IS_ERR_OR_NULL(shm) || !virt_addr_valid(shm))

The IS_ERR_OR_NULL() check might make sense, but the virt_addr_valid()
does not. virt_addr_valid() might catch a few garbage pointers, but
the real problem is that someone is supplying garbage pointers.

> +               return;
> +
> +       if (IS_ERR_OR_NULL(shm->ctx) || !virt_addr_valid(shm->ctx))
> +               return;
> +
> +       if (IS_ERR_OR_NULL(shm->ctx->teedev) || !virt_addr_valid(shm->ctx=
->teedev))
>                 return;

shm->ctx or shm->ctx->teedev should never be an ERR pointer. The
virt_addr_valid() test doesn't make sense.

Cheers,
Jens

>
>         teedev =3D shm->ctx->teedev;
> --
> 2.25.1
>

