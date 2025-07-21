Return-Path: <linux-kernel+bounces-739145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36153B0C257
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2890B3AB8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92317295502;
	Mon, 21 Jul 2025 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BZtWWBlE"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E8295530
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096344; cv=none; b=sAVBWBNSgyZxAat6MSpRqr+wGZ3JWAnTEeVcZBAE/oiwTi/J0gkUDmrMpIe7BpN8BGnCRhz2aUOyWwv3e4E+zZm/YgYDs4qZwrITEwZry+xCASAVc4VTMZ/PvG71o4OJBQOeQgD2PyKhLXuB1ybj0yZ44eXmQkRi0zXCYuptwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096344; c=relaxed/simple;
	bh=ksZkhhiBwulOE/IukbPeIEXyJFBXFotH7naTuSJS5cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+xYoH/as0u670y8wTtGUXkZZZc0KfpZ+OPV/161alCR6aTDBfRHSxPxEB/UXfHR9sxUuOtOOM7vES4ORAWiPRwybjqRycfbxT0oQ0Yjrlf7kxnvUtQMFGIqs+T6ZKYHQG0Bw1g1n0G0z1kNSKIg1h0O+NsGKMmVdD6SebrCtN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BZtWWBlE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b50f357ecso4148561fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753096340; x=1753701140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvD8IUqr+Bzg9GKWiYPMFuwvqaPjoCioCLoAukeES3o=;
        b=BZtWWBlE6Sh0kiPqNgEAjIpk/NmTjn3bfieRPCAs39tzUBnYHZsLcMpqyj0UoWPPn5
         xeVdmiOnhzh7ksGLjacQeGaKRUXVLiV0OTbQ2yep4QvzAAXbIHhD5mUStkURaa8s37sW
         AzrRuWpr+LC1ZZ8PZF61dH0OLPQD7JTwlOESs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096340; x=1753701140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvD8IUqr+Bzg9GKWiYPMFuwvqaPjoCioCLoAukeES3o=;
        b=vaNf+7eyx5XSVnq6h7sKQC3cJ7HlXNR214ksP+XqEZ9E62WtwvITUNnN8U2fHiwvOk
         b9Cb3Y88vaXoM1L078AFgUtVnJDpsmL+z/hop5CS1wb37KtqjJNlRM8Kfl5gnIHnK4vI
         Tk6BrVxw9+9nYOzIAV7FyRyJXcrqxzy7/ehdfM6eSZPC1y9Zg/r33Ue2zSuHOIPkOz+A
         hgDawpfBmaSNXibCd856pUXYMzRnJz01gHFkIGQmYOOylh7lv4m6XLnd2jxj9JHsErHb
         I4tf6XOKdaXZFidNpUoN9KEnEh4byE+Gkr5q65glfqRF9L5L1REuIcrDPuOuMO61JdqI
         RMmw==
X-Forwarded-Encrypted: i=1; AJvYcCVwNugFV+bsTdTwBB5jq4U/w00x6jDMLKgV2S5Mt2T4Mk5hm3J/QjLMWqAnUdkcGlzDSo58WzjLpLu9snk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhhsjcw5TUb61jz3u/cRdYqUjOH6fZmTSteLVkjvosGtRyLPsr
	7H8iYRmYv10TTeuZBfL33Sh8tX23suOexrCQ9xB2K15ObnsZnsCTMzh29a6fptH+fXSCBA16y83
	4o27xTHB4n6DuROPIH0d4VMx95QBCA22iNVFbbH7S
X-Gm-Gg: ASbGnct8FJQVYYXChD8TJxPjIHJl5FVgEbDI9KNlpRVDDg3LEz2n9c2HLOeFsop67kQ
	VjpktLiS4oP4nHk3N6HlrATwrORJy/ZKAB8Onyp9/TcMH76Fh2fPQsEOk/2sfT9/YAop3HGZ/7E
	U63GZgruYkOLB1NvsQA0QcPYsRrVc/1jDPLpjE+bz2Glg60SNzugm8I+mcHzHqInxp9WxviYZZ+
	AXxjNngVObymGbLyCC1dqDYoUhp9lnSHf0=
X-Google-Smtp-Source: AGHT+IFBcIrODyu5ElS2DkB5XwLAm0Yi8m6vfMTv3g3vNlbCwrZrTFNYjxARMwbJuH0gzP751/Mkg4oUm0Irdkz6hQA=
X-Received: by 2002:a05:651c:154a:b0:32a:7270:5c29 with SMTP id
 38308e7fff4ca-3308f4c5293mr49883741fa.2.1753096340224; Mon, 21 Jul 2025
 04:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721081459.16278-1-laura.nao@collabora.com> <20250721081459.16278-6-laura.nao@collabora.com>
In-Reply-To: <20250721081459.16278-6-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 21 Jul 2025 19:12:08 +0800
X-Gm-Features: Ac12FXwjyLsGb66oW3wQunTIZj2TIT6qrKAAeEzwRJZc_WREeNFVgKGeEo3jG4M
Message-ID: <CAGXv+5F9NwJ7uGFPWZM-Dywbbk4f6aiYS5M4m6_VFETVGEwr9A@mail.gmail.com>
Subject: Re: [PATCH 5/9] thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw
 variant for positive temp_factor
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

On Mon, Jul 21, 2025 at 4:31=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> The current lvts_temp_to_raw() implementation assumes a negative
> temperature-to-raw slope (temp_factor), which holds for the SoCs
> currently supported by the driver. However, this assumption breaks on
> MT8196/MT6991, where the slope is positive.

I don't think that's really a problem. The formula is:

    temp =3D (raw * factor) >> 14 + golden

If we move the terms around we get

    ((temp - golden) << 14) / factor =3D raw

Or

    raw =3D ((golden - temp) << 14) / -factor


The calculations should work regardless of whether the factor is positive
or negative, as long as the intermediate and final values are within
the range of s64.

> Add a variant of the function that inverts the calculation logic
> accordingly. This ensures accurate raw value generation for temperature
> thresholds,avoiding spurious thermal interrupts or unintended hardware
> resets on MT8196/MT6991.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index db83137c7537..3c34956e37c1 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -296,6 +296,18 @@ static u32 lvts_temp_to_raw(int temperature, int tem=
p_factor)
>         return div_s64(raw_temp, -temp_factor);
>  }
>
> +static u32 lvts_temp_to_raw_v2(int temperature, int temp_factor)
> +{
> +       u32 raw_temp;
> +
> +       if (temp_factor =3D=3D 0)
> +               return temperature;
> +
> +       raw_temp =3D temperature - golden_temp_offset;
> +
> +       return div_s64((s64)temp_factor << 14, raw_temp);
> +}

Here you have

    raw =3D (factor << 14) / (temp - golden)

which, barring integer arithmetic limitations, is actually the
multiplicative inverse of the original version.

So I think the commit message is misleading. It's not negative or
positive that matters, but that the hardware expects the
multiplicative inverse in this version.

(or the downstream code is just botched.)

ChenYu

> +
>  static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
>         struct lvts_sensor *lvts_sensor =3D thermal_zone_device_priv(tz);
> --
> 2.39.5
>
>

