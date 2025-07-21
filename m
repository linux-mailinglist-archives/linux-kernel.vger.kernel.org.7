Return-Path: <linux-kernel+bounces-739030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD0B0C0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D71B4E1105
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D7828D8CB;
	Mon, 21 Jul 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XAdhfoSZ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140020E71C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092504; cv=none; b=IDPHBBBqRnvZlMJTZHRZPMjq66obfWi2BoisLUSwA3vJL/bmCqJS96m1XyE6E1WMssKnmCwzYYMQ7v23+2EazJ1xKDCM9egbIMZBfD9BUyeV8M5WmnFyePVPlTSiH0CBQWhulpzZRi+UX8L0iCSnuJM66lPa4XZ/HD8/vow0NTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092504; c=relaxed/simple;
	bh=50Ubmg4LfSlEdX6k4IcF145XqGsrPBSvcnbfU9xKeLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/9g1rtRxpxu8FLgVMhuT8w61LPapGJpvTVVXDRetAoqPW+R1IN7P8N0JvqmmzFB8Z0//lVYqIorOWla2L5d8cjm+YpX8qDO6h7HAuE7dDQwHukT+/H/vjwd0XcCbDVTwUOAsbMMPU3qOudAuf+A3ZB7eaUNWVyFtXlICck5Iek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XAdhfoSZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32f1df58f21so41610031fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753092500; x=1753697300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD8rxQd2ghX7oxkvwv9EZVZXOQiPMsFApAotllBQSeg=;
        b=XAdhfoSZONUfQGU3zAjMmLyhemuNhljyMd5NAsbQk58mafPj4HvRBYYF9MnlAMZ28C
         vqeFad8XNUQ5B5h9pGJpmRYYw28ZyG/evVPUfOdJuPrcay/J2a8HjGg3hTDgBoMDIL1A
         pcaF/BxAjhYZ2zadjJWIZ1dgaMD5SAS0R+0gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753092500; x=1753697300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD8rxQd2ghX7oxkvwv9EZVZXOQiPMsFApAotllBQSeg=;
        b=N+qpdKrZdQnMQyaAGWvw5u31lPMAQq2Uqx5D0ddWhXlFDaL4TbQePNI2wWDqT/SKoE
         iHQqd4E6GfJdIR9NpgXv8UVhqhQR+cW36b7Ve+zpVykIqgMqHm9pz5mEafW1FcUX0x6L
         g65a+1gXIidyr4Khg5g8TT+iz4zVo23Ur3VqzfXad17peF3nZV4wa5KffMtpB9XPSYRV
         nOR8QfZ8OrSSxZNgnkiUpi6383nDCsKmGB4cisrDKpkALt3g9W4JIhKPyl1q56ZZF580
         Jt4vDhen9HY9Crr6ckmBlAoHFtMhBsEiUYWZR6XFnr+P8+3HV1ZNAvBejHy1S/7WNAR9
         1Ccg==
X-Forwarded-Encrypted: i=1; AJvYcCVxZWiCX616nMi73Y6BOnXjOa9S9JSZzgxOEyG1mTGP0rrs+VDqZfKp6EWmU4qQf+5srz+ajNyM2Q2OPFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYu2NtOuGQmWazrgPXzx83Jo1xgmFghJ6/aQKOJ0CLJiAjY7Yh
	179/876JJi+wvGRDysy+AiDCilawsOOGhTu7ZlO2Sw39axZW7+jNqEDr74fMb+MEAglvJwGSVlv
	bcN2JbcMPuofISos4VUHbizFGDAUioIl50Iayi8Rz
X-Gm-Gg: ASbGncvdQm34XCkYifS/FFqxci5TVlqRUyaW9iKlC941gOSvIMhN0VP00N7WhOsIAoF
	XbfZ1g3PLrHvBoFcmfKQ64EC6X868U/iSyNut7C97sX5u+I0oRKptHOIERLCSMdO/V8i/lC27eJ
	zYTSl0d9w5w27OoBH9eRXZy+6HgSGOT4TmaWvepwLVVAgPoF5D3VKy7LG1w6N+IaK8k7ZHlHVOl
	jfOwSqhBSUPVIG41WnRQKqa16AvnvVgDS4=
X-Google-Smtp-Source: AGHT+IHi6PdCwFOePdyUiSBZQls+DPW7XtyOQBhq5kUoIJmQhohNKReJGJb1oSImXRjY6TmgwESv8Tvn2SOgxE98754=
X-Received: by 2002:a2e:a99a:0:b0:32a:8916:55af with SMTP id
 38308e7fff4ca-3308f4c5e9cmr53974251fa.2.1753092499826; Mon, 21 Jul 2025
 03:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721081459.16278-1-laura.nao@collabora.com> <20250721081459.16278-4-laura.nao@collabora.com>
In-Reply-To: <20250721081459.16278-4-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 21 Jul 2025 18:08:08 +0800
X-Gm-Features: Ac12FXzBhOOgbkI7YQgVr-Zp96LKQsUci_34ENr1pVVGZfl3HxcKeWbG5MiHa8I
Message-ID: <CAGXv+5F51DiCHi_QPeDKOGCwvgM6HpmRjEjSgS8-mh=Fg1Fr5g@mail.gmail.com>
Subject: Re: [PATCH 3/9] thermal/drivers/mediatek/lvts: Guard against zero
 temp_factor in lvts_raw_to_temp
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	lala.lin@mediatek.com, arnd@arndb.de, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nfraprado@collabora.com, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com, colin.i.king@gmail.com, bchihi@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:26=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
> division by zero and ensure safe conversion.
>
> Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff c=
onfigurable")
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Code wise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

However I assume this would only happen with bad platform data? The
factor should _never_ be zero. Maybe also issue a warning in the probe
function?

ChenYu

> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 8d5259b9d03b..b80c2929ae74 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -280,11 +280,14 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_=
factor)
>
>  static u32 lvts_temp_to_raw(int temperature, int temp_factor)
>  {
> -       u32 raw_temp =3D ((s64)(golden_temp_offset - temperature)) << 14;
> +       u32 raw_temp;
>
> -       raw_temp =3D div_s64(raw_temp, -temp_factor);
> +       if (temp_factor =3D=3D 0)
> +               return temperature;
>
> -       return raw_temp;
> +       raw_temp =3D ((s64)(golden_temp_offset - temperature)) << 14;
> +
> +       return div_s64(raw_temp, -temp_factor);
>  }
>
>  static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
> --
> 2.39.5
>
>

