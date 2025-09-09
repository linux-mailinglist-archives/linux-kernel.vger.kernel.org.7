Return-Path: <linux-kernel+bounces-808772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE3DB50499
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CEC1BC0366
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532523568F0;
	Tue,  9 Sep 2025 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht2ZYt5v"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D476217F24;
	Tue,  9 Sep 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439671; cv=none; b=X0n50kMbWvcqxK4Y6/GUoP+WyIL6pv2u0U5Y4QpboaVySSfN4dyrH82FyE9DxPbN3c5qJHq+PhIC5FJmvSxGTzFqndDFToZsFd0oSUl9AiZBJZDmnTFl9fz0x8WJuBbhU52q4HhJsTqWSiFt9hWMs5u5GlcayzLzfa0jXqeKAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439671; c=relaxed/simple;
	bh=iMqzuo60ZLuJFOqTZIOoW/WODE7m+60kgAFLvDECvRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZMuEjg56QI8rqc/ZoejXfAt2V0mBIFLtxVmMJFYvTjEJDQQCMxhgjJefGxh/hEzpPr75Qk6EMW//H9hl1h4tK9CnL6gi+sguTmEmZBwCtQwp8FcXBOAx73Rh3nCaPN2D3BQQAkWeMUC0sW8NXIZHQHr9X8aMrtQc1vZe4Gw2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht2ZYt5v; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e249a4d605so4740632f8f.3;
        Tue, 09 Sep 2025 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757439668; x=1758044468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry5FSpI7dPZc6Kq1cRRqL+tbhUwVxII5JV+3rpol5sI=;
        b=Ht2ZYt5vt3FGksgoBjsT/0kbNBFQdDu6I1ZzYdtygTr62AJTQV82/2EWV9gjF4k6C6
         Qaku361KLwH3w5feybnW2v/JoHJQWjYbUJRS1xhgOpPlIhLKe6CihYljqFhoElaJcJbw
         pvHimC1URlSdzdMqIyT2U0CobrRINJyL0Ed11eu8AjkVJq0kXRPCiRrONAoanhou7SQO
         uvOzbKJK+bMXjFSvBdKmdul5+u+Ykh/IEII1czQco5iCl0VLJULfbjXF5esnABQfkv55
         Sgfkv3ay6sTz/pyW7dt+Dm7c6C/yufEiStv41LD+hm+9uun046KbIxLIJXQUim4cCvn0
         QC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757439668; x=1758044468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ry5FSpI7dPZc6Kq1cRRqL+tbhUwVxII5JV+3rpol5sI=;
        b=xEcsuf0Z7HyNALAFM2RFv+aeQ1lMk73AW2Y4OHWlxZ8Juc4V24oMEjjWhgdbWW5Gty
         M1ugrY131BrH5KljzW+Vsgh63mOpwFLDggOacAZF9ywtPufa+5meR9nm31KpHciLtV5W
         0mLRVeN/yu/6eRjKiOlBWikeu16pPmWMeI9GDjEohrylJGoSipJurzEeJ7kzojAoPC0J
         tyqENt+r/O7tfnePnqA5LdvTlN6qN/Orp71Jq+i2cSHiRSvRUq4ewpdgKk3lzmIIT+F6
         WvxBnMXr1ZqoC431r/KJoxrwMHdzJQ4D6G5IbD2ywBkHliarikzkxzqbqG4cqVNa/76b
         i+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXX9egDku/UfMJ0sKMPPUfRJkjOHMK9kd6HfU7aSxg7Byf6nwv5GrpWLR+PGU06nkJDF0NiX68HWAY=@vger.kernel.org, AJvYcCXr+4TMdsiAfP2pzrfTySzSrYiYfiXrtbQiyKgXrGN9WjJPZzRhhvDeSEYEEkjpZam1Ek9tc/6SQM0awSAj@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlfOgBSdn6dfPffXMpiBZSJJTf5KQ3PHkIhATNwr/cjcegX8P
	eXlIzcCwvKcJL95vxF9bn12IRor1aeJbCO7EA6f2QXkVQ78wvSlwuETGZ5/gIA==
X-Gm-Gg: ASbGncvophIAf5Wjnj1iOZTvt/6HUu0x4O78jxLK+4gKOIPyD04fvKAlhIvBwF2IzPm
	rdQ8PY207O0sU2MERwdhztj/SXFETovl6OIudxDcLlIK1M3jVIgnZAzf9VffKuISVHY46AAAXck
	uEp6Ftc+Z65FlFQgAWhTlYD5vNIXHQmVy8JVE9DBGWuCkUkK8CqpNoCCfMHbEskGpItC2cUFiYU
	lBH94QgVyhNOldqDCI8uL4Fp6/lHWZS5HodmxOodvER3OZIYWVDdz8j1YPQSaYTYwNvtCy5RFM9
	Ei31IWrR2WwQ5q2DofFfnda3tQfNlTek+2CEiFycMaXr3+RD42VGMDJcl4HNaSQejTT2kiZSmrY
	4ADP3MGPSXRkOgtOYE74OeTWk67ao8JImmDqy+TIFbwjvnN2hrQs7nnkNE46CPrpEska+w6RoAA
	z7GyFSEdzzSaD2maRZbXI=
X-Google-Smtp-Source: AGHT+IG2uQ4FJ9P3y+p4jrZc5L4f0i9TvG505+l+khrDgQ8Fx5vRm9E1UHocXbYiO2BBq31vpy9atw==
X-Received: by 2002:a05:6000:2383:b0:3e7:438e:cddb with SMTP id ffacd0b85a97d-3e7438ed1c0mr10407637f8f.45.1757439668124;
        Tue, 09 Sep 2025 10:41:08 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224db20sm3366103f8f.60.2025.09.09.10.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:41:07 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Stephen Boyd <sboyd@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: sun6i-rtc: Add A523 specifics
Date: Tue, 09 Sep 2025 19:41:06 +0200
Message-ID: <6189783.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20250909170947.2221611-1-wens@kernel.org>
References: <20250909170947.2221611-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 9. september 2025 ob 19:09:47 Srednjeevropski poletni =C4=8Das j=
e Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The A523's RTC block is backward compatible with the R329's, but it also
> has a calibration function for its internal oscillator, which would
> allow it to provide a clock rate closer to the desired 32.768 KHz. This
> is useful on the Radxa Cubie A5E, which does not have an external 32.768
> KHz crystal.
>=20
> Add new compatible-specific data for it.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/=
ccu-sun6i-rtc.c
> index 0536e880b80f..f6bfeba009e8 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> @@ -325,6 +325,13 @@ static const struct sun6i_rtc_match_data sun50i_r329=
_rtc_ccu_data =3D {
>  	.osc32k_fanout_nparents	=3D ARRAY_SIZE(sun50i_r329_osc32k_fanout_parent=
s),
>  };
> =20
> +static const struct sun6i_rtc_match_data sun55i_a523_rtc_ccu_data =3D {
> +	.have_ext_osc32k	=3D true,
> +	.have_iosc_calibration	=3D true,
> +	.osc32k_fanout_parents	=3D sun50i_r329_osc32k_fanout_parents,
> +	.osc32k_fanout_nparents	=3D ARRAY_SIZE(sun50i_r329_osc32k_fanout_parent=
s),
> +};
> +
>  static const struct of_device_id sun6i_rtc_ccu_match[] =3D {
>  	{
>  		.compatible	=3D "allwinner,sun50i-h616-rtc",
> @@ -334,6 +341,10 @@ static const struct of_device_id sun6i_rtc_ccu_match=
[] =3D {
>  		.compatible	=3D "allwinner,sun50i-r329-rtc",
>  		.data		=3D &sun50i_r329_rtc_ccu_data,
>  	},
> +	{
> +		.compatible	=3D "allwinner,sun55i-a523-rtc",
> +		.data		=3D &sun55i_a523_rtc_ccu_data,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_rtc_ccu_match);
>=20





