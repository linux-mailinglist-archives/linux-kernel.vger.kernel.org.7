Return-Path: <linux-kernel+bounces-783443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CFCB32DAB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EEF1B21448
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B321233722;
	Sun, 24 Aug 2025 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="SnvMnWFl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5A23236D
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756015740; cv=none; b=ZT/Xj7vYuof9CC9EwTdHjKgmm3UHvSWit3ybtmgNwRiS1qngf26tZw2zrd9S1yPPE0KKVqRS7oi7P6PwfHyk0vsLJ07/vtetd8UDUCiYweAH0ze7HWIuJShRXKypQTPWJlduvW/nL3Cco4LpM2MV8IGBHOf85pnan4HCb8bZ/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756015740; c=relaxed/simple;
	bh=OwC8kSoNhJ/QrfFk08QEKBVI7mvOzyNNuuRqGpk08+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpeE1An7p2wjqgDJ6cAH+EONTbF60zVAxXhCAla5yLIYUXKfQAJ2LPgcT5Pf5UREt6jm5VSDbbuZ0IY0rdeFJLHL9JAXChvjyuHU8d12CTZjsahtDqjmCpNYvJExxUxf8eK1JmCjLVbl5x7X4k68MSLfbzyrZLJx4TeeqDatPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=SnvMnWFl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Mupk3r2Lw9myiPKOhZiMD7z8z8WBSkZnpSNn80gsJsU=; b=SnvMnWFlWedvFlVdM3jJtWJvvp
	xQvs0SfuvsN5dN1g6ELZeTWjhkw+gfxSzltwvoPW3LkvJ/8x4HqN6cOeKyZ6C+qIBVMMIvdqR2geL
	BI1q50N9DBiJXvsR3PjCSDO6Y2GcllQVwP1NS0IrbWI1/FDnkCinYe3YTUg+imOZ/kilPjjTXVdl5
	Z073+7BEfhkKi4frUPOWRLK+MvWEmqBJeWqFXg8HKxFeU6rXxVgSRkC+mYCMc2XW/whK1hvMz3FOm
	u4/HslXR2RYSXmkx9CZEnW/NeyeQhISe8gqh2FZWKFRACJ7isb0KD8wnFra8a2cDJ6haF1JsI8RL4
	OA8Y681Q==;
Received: from [212.111.254.164] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq3tt-0003EY-IB; Sun, 24 Aug 2025 08:08:21 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andy.yan@rock-chips.com, hjc@rock-chips.com,
 Damon Ding <damon.ding@rock-chips.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject:
 Re: [PATCH v1] drm/rockchip: analogix_dp: Apply devm_clk_get_optional() for
 &rockchip_dp_device.grfclk
Date: Sun, 24 Aug 2025 08:08:19 +0200
Message-ID: <7656195.LvFx2qVVIh@phil>
In-Reply-To: <20250824031932.3204920-1-damon.ding@rock-chips.com>
References: <20250824031932.3204920-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Damon,

Am Sonntag, 24. August 2025, 05:19:32 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Damon Ding:
> The "grf" clock is optional for Rockchip eDP controller(RK3399 needs
> while RK3288 and RK3588 do not).
>=20
> It can make the code more consice to use devm_clk_get_optional()
> instead of devm_clk_get() with extra checks.
>=20
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gp=
u/drm/rockchip/analogix_dp-rockchip.c
> index d30f0983a53a..d0f78ab9faa6 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -335,12 +335,8 @@ static int rockchip_dp_of_probe(struct rockchip_dp_d=
evice *dp)
>  		return PTR_ERR(dp->grf);
>  	}
> =20
> -	dp->grfclk =3D devm_clk_get(dev, "grf");
> -	if (PTR_ERR(dp->grfclk) =3D=3D -ENOENT) {
> -		dp->grfclk =3D NULL;
> -	} else if (PTR_ERR(dp->grfclk) =3D=3D -EPROBE_DEFER) {
> -		return -EPROBE_DEFER;
> -	} else if (IS_ERR(dp->grfclk)) {
> +	dp->grfclk =3D devm_clk_get_optional(dev, "grf");
> +	if (IS_ERR(dp->grfclk)) {
>  		DRM_DEV_ERROR(dev, "failed to get grf clock\n");
>  		return PTR_ERR(dp->grfclk);

generall I definitly I agree, but you're loosing the
"don't print anything for EPROBE_DEFER" handling.

Additionally DRM_DEV_ERROR says in the code
"this is deprecated in favor of drm_err() or dev_err()." .

Also this in the probe-path, so to catch both issues, I'd sugest
using dev_err_probe() for the message, which handles EPROBE_DEFER
automatically.

Heiko



