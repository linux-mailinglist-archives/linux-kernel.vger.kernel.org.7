Return-Path: <linux-kernel+bounces-878459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD7CC20B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD4D189CDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28EE2701CB;
	Thu, 30 Oct 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9L+Ez+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED337A3D1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835191; cv=none; b=JLANXldPGBIumkZSoQY2T47mPDe/LRMLzRZn1kx21ZHdpSWUNyq3yEdgWXB5WGpYB2TcXlpsZSjIGule4yyxRVYjtcfEqUTx7NH2Lw1lqecw66PdUpfC1k7DiUEuJor6KANkps7gZrhjOb8YSFmhV5idxBAOpDD0t6oIDlbAMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835191; c=relaxed/simple;
	bh=hjcJxnduxYBfm1/yiXsUuBIfCK14DHTXJzBF0o/xC6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/OiNvCaiDvGtDJRM5LMgdoLExRuwbxqBVnVOmLDQm43eGMWiVqRE9LO3vRRCOiRJEZH2oCE944iGCUEmYC5ArcVA6owOCvFNzeNdmzz/BGX4QG45X5b94W4Ux3Arfak1k8Sgsd/Hev+KeudUJtWG63UpL8nlk4CY/CJR5azXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9L+Ez+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ADCC16AAE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761835190;
	bh=hjcJxnduxYBfm1/yiXsUuBIfCK14DHTXJzBF0o/xC6Y=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=M9L+Ez+WzY4TJG6L0RX27xHKp0l/3shEnDOwpiuRF1pFxE1NVoAyWwPTGcP2towMS
	 JvlWxk2cdF3bXCsegoyIiClGLni5cqfiBdBxWU7DiP00Bxm/3iH6zkjP3InOJIb22U
	 E0Ut5kSm59C591xS5nZLzoAXFULp/0d++YLSGqdNt9/5yM9kAPOHgic44ueEFvEcgA
	 aj+yNP5X3jkrz7HQPF1eoDz6VqQvO5dJQnOKQXJWO1YY7MioscYjBKh6eTtQ7uWs2P
	 7XqnLdzqvbtzE+zG9HdnBRDWlXSLPmonuVmABTFurXlpj5vLIR6RJpczatYn4GCKG4
	 gQ2iHOpyXx94A==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378d61ce75aso12109441fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:39:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXd2FBmSrb2HDhY2/JDfiOHEHCGfBqVjzycm9epduRZ1DzFGK4GQzlylCv4DVYY6uYUKLrtxlgr2viPHLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHk5EF271A/zKsjc2L+s+Hx2kXy4nXru6x4Y/A/gVhFFL0Flvw
	FRni1qmI6mWAtsMyIfmSVba/GL2GbxAJX2Vm12R4aEyEyC9V5xz9s+lnF6oJb8UCeI8kxmg4LFr
	AdrUAft2Xyfyp5QRA/A4kbVKRInwsZyI=
X-Google-Smtp-Source: AGHT+IFLoHRoT/xBOfaxpGzVXuRSs1BHVdmKiKxSTiT1dPH61Kh3m1lm+iw330bafe7uumJC0YjML2XV87Ra0m0zt0o=
X-Received: by 2002:a05:651c:2206:b0:336:b891:18db with SMTP id
 38308e7fff4ca-37a18d8832cmr414851fa.2.1761835189002; Thu, 30 Oct 2025
 07:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <3fd4beba-0d0b-4a20-b6ed-4e00df109b66@app.fastmail.com> <aQMUu08phVPqfgEB@stanley.mountain>
 <dbd5558a-90d9-404c-ae98-a8c04cdad08a@app.fastmail.com> <aQNccP-lHqgygmsu@stanley.mountain>
 <CAGb2v664ybgMVCFWcDK-5cJZegC1HJmCg4-qJdgZ=7GAL4jOTw@mail.gmail.com> <aQNjoM3fgAW6kxUz@stanley.mountain>
In-Reply-To: <aQNjoM3fgAW6kxUz@stanley.mountain>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 30 Oct 2025 22:39:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v67oHJ5go2rhcrhL1C1_Mf2EZ6GiuG8So_=P89EbTHR4mw@mail.gmail.com>
X-Gm-Features: AWmQ_bn91KS_PesDBZYqE9EcfhISK7QMLkBqlS-0KEPOhntWuR2LKtmq4VM18F0
Message-ID: <CAGb2v67oHJ5go2rhcrhL1C1_Mf2EZ6GiuG8So_=P89EbTHR4mw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, John Madieu <john.madieu.xa@bp.renesas.com>, 
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 9:10=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Yeah.  Let me send this tommorrow if no one objects.  Pretty simple
> solution in retrospect.
>
> [PATCH] mfd: syscon: Return -EPROBE_DEFER in device_node_get_regmap()
>
> These days we can register syscons with of_syscon_register_regmap() so
> if we can't find the syscon that probably means it hasn't been registered
> yet.  Return -EPROBE_DEFER so the driver will try probing again.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

I'd also like to say I tested it since I have the same change in my local
branch, but as I said before the case doesn't really happen on sunxi.

ChenYu

> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index ae71a2710bed..e5d5def594f6 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -183,7 +183,7 @@ static struct regmap *device_node_get_regmap(struct d=
evice_node *np,
>                 if (create_regmap)
>                         syscon =3D of_syscon_register(np, check_res);
>                 else
> -                       syscon =3D ERR_PTR(-EINVAL);
> +                       syscon =3D ERR_PTR(-EPROBE_DEFER);
>         }
>         mutex_unlock(&syscon_list_lock);
>
> --
> 2.51.0
>

