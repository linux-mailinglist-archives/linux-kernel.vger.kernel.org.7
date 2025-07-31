Return-Path: <linux-kernel+bounces-751539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D874B16AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13161176067
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD723B633;
	Thu, 31 Jul 2025 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i/60mbN9"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F384374F1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931457; cv=none; b=MT/p4aAuildBQ6gkjfWYXWKm+XeMIwzgfiG8a3yKPa58ZU9P/2RV2v7Fj9szuF19Uc+U9RRgx64HKe4IMx7+g3cYcYhx4SvwLiwSfxGOVDCJY2ByuYw5ChyyZu0RJLE2q3bYr7eF9xM9ufFXqn4paagltqAJqfP7rV3GcxsVYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931457; c=relaxed/simple;
	bh=DIM3U/viUk7et9FK4/5wZRJ741E/C+ZgyDud3Xa0d+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IngHrDJoBlCB02DtSTQMG8NVDuSb+qKr8dv3QgBNu+efCsim0gx9yRzBBQetseYaXU2Ccl3dU3sfSbs3Z0eD0/FR++Ib9ZwdJtCwh8Gu3yl7MbCEww6/0tConGPV9p8YFBv4F4pKqi1PgwAD/u5bwBAL+j7NUgzZjh98Wb6QGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i/60mbN9; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5390fce74a8so195151e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753931453; x=1754536253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQz3EwDsCOo1XFmvxHoa4HIcyhVHPzzMG2oMGGNImxA=;
        b=i/60mbN9KAiBXMeC3ZJHbvLzcalVVSH/StByGr52gIESE/NRy3pbHSyPsGnsc7n4y8
         62R/589S8n/vwPa6vTz5lz0O2fIwDJtRmIAfCTjuZ1PwsLML5tdFJW+9eRSkOyqW8dsz
         0KOAQGf3pHY/iqtJG2KH0UBC8QW2auyUxKA/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753931453; x=1754536253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQz3EwDsCOo1XFmvxHoa4HIcyhVHPzzMG2oMGGNImxA=;
        b=dd83Zml/A3hXpaLFc3vT30TPNcmw22c27qS0s+mqLDF/RhmWf1GTJ5bDGOorVGB2Az
         Vi/VggGJMKlT+m42dQwljJoVDTFOng7VwaQFYIC1k25eWAVOkvr08HmDKr5L6UmCefUO
         gk+YnhAgxRQIp613b2fmjYxBpVUAF/CynvkHg/jMqjWhDve5AIQvQM+n1MKkMoG0BKGm
         OAYdDusqkLFmigDV59K1xlOGwl7w87IaE/MRIKGsRfn1KCWsZy1Pg+W5osxolWDqTG6V
         aYQ4YKpVcfEUkjvgG7hj/SMjwYm16YbbHH3hzzJesY9HBQyQEiqJ41mwEeOkDOnK9Q20
         MFEw==
X-Forwarded-Encrypted: i=1; AJvYcCVXzVHNPMtBg3fRZuiB3FVwtcheEwiN8Wzj967M0oiQdSMen6PI8bIaMHuckrfviqgX2bFm5Nc60Rpwdio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1H8mfi0ugngQFEnONaa+Ine2s4BteAmQqTI0SoQpggidjhDF
	BH5obezR0s5Gx1vYi4wqYGn84jvZ8wYmZP82gEXcAlzfn1FZbiSsqsH8jKRiUgBSixkV5ZKnMOp
	pVo4=
X-Gm-Gg: ASbGncu/JiMWY7L/05sMq8Tnyc7wguVJ7+gw5w9y7CJq8jGvqWEm1JmUXzh1rb1Zvnu
	ewmkcEM3rhUYF3mJ1eZTj7bzPSxwSIMtgCoygRpeb7SD2AmlACO+xFOPUSLfFOhRi5yrCF+6WOQ
	F4bgOownY4/sDZkCkzLicM+31JW/GEOAG2pWKUJ/k4s58LikTRQxxAtIxzXePO/OcOw89UraAt2
	EMQvNftyz1QnuFOkVnY9f9DtRyQffCvF1m83oAEjFdO8xX/SpUmTvaOFy0rQA7tbNj/+RI1Pd9z
	zGzEUaS8KIMSqmvSq1TRB+Wk9QCUePi10PqO/VzbjvBdd4dKuTW7U8tJ+npbnvLSIDkRGKxLDgm
	nuHzBRVyNaaflsZ99wTwxTcrr1PvRlfdXM5nTp7Z8H52MYgoj1qUew6I9PuPseXkaspBQ
X-Google-Smtp-Source: AGHT+IGT8B49r1DsjyMGSrhKlWbY5dQzNZ0yI89nmhDOfRJ+SEWtSyd3erM8cflOsya3QkTbqc8YsA==
X-Received: by 2002:a05:6122:8ce:b0:531:2f9f:8026 with SMTP id 71dfb90a1353d-5391ce9632dmr3555164e0c.1.1753931452987;
        Wed, 30 Jul 2025 20:10:52 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f3f0b11sm180818241.14.2025.07.30.20.10.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:10:52 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4fbed2d9e61so190986137.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:10:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcnXSY3x5FW/Xd4lTkem4Bvardl5FNY4tOb6pDk9sSx3Hb8wEkoPElyqdgQs/6U4/2dW4Tsry+cLNLPUI=@vger.kernel.org
X-Received: by 2002:a05:6102:3e86:b0:4f9:d929:8558 with SMTP id
 ada2fe7eead31-4fbe7f5a8ecmr3674144137.10.1753931451474; Wed, 30 Jul 2025
 20:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-3-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-3-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 11:10:15 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhEiWmFkVMVGqg97TqXQqLhP0KZkQvq+F=k_hS_Jg297Q@mail.gmail.com>
X-Gm-Features: Ac12FXxQNf_MHWgJFTLhQCBFRAD1HLcfHVxkjg6vNoUDqC6XlmkmVeEw5sZ-QQw
Message-ID: <CAC=S1nhEiWmFkVMVGqg97TqXQqLhP0KZkQvq+F=k_hS_Jg297Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] thermal/drivers/mediatek/lvts: Make number of
 calibration offsets configurable
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:30=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> MT8196/MT6991 use 2-byte eFuse calibration data, whereas other SoCs
> supported by the driver rely on 3 bytes. Make the number of calibration
> bytes per sensor configurable, enabling support for SoCs with varying
> calibration formats.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 32 +++++++++++++++++--------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index f4d1e66d7db9..05aa8895ccce 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -96,12 +96,14 @@
>
>  #define LVTS_MINIMUM_THRESHOLD         20000
>
> +#define LVTS_MAX_CAL_OFFSETS           3
> +
>  static int golden_temp =3D LVTS_GOLDEN_TEMP_DEFAULT;
>  static int golden_temp_offset;
>
>  struct lvts_sensor_data {
>         int dt_id;
> -       u8 cal_offsets[3];
> +       u8 cal_offsets[LVTS_MAX_CAL_OFFSETS];
>  };
>
>  struct lvts_ctrl_data {
> @@ -127,6 +129,7 @@ struct lvts_data {
>         const struct lvts_ctrl_data *lvts_ctrl;
>         const u32 *conn_cmd;
>         const u32 *init_cmd;
> +       int num_cal_offsets;
>         int num_lvts_ctrl;
>         int num_conn_cmd;
>         int num_init_cmd;
> @@ -711,7 +714,7 @@ static int lvts_calibration_init(struct device *dev, =
struct lvts_ctrl *lvts_ctrl
>                                         u8 *efuse_calibration,
>                                         size_t calib_len)
>  {
> -       int i;
> +       int i, j;
>         u32 gt;
>
>         /* A zero value for gt means that device has invalid efuse data *=
/
> @@ -720,17 +723,18 @@ static int lvts_calibration_init(struct device *dev=
, struct lvts_ctrl *lvts_ctrl
>         lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
>                 const struct lvts_sensor_data *sensor =3D
>                                         &lvts_ctrl_data->lvts_sensor[i];
> +               u32 calib =3D 0;
>
> -               if (sensor->cal_offsets[0] >=3D calib_len ||
> -                   sensor->cal_offsets[1] >=3D calib_len ||
> -                   sensor->cal_offsets[2] >=3D calib_len)
> -                       return -EINVAL;
> +               for (j =3D 0; j < lvts_ctrl->lvts_data->num_cal_offsets; =
j++) {
> +                       u8 offset =3D sensor->cal_offsets[j];
> +
> +                       if (offset >=3D calib_len)
> +                               return -EINVAL;
> +                       calib |=3D efuse_calibration[offset] << (8 * j);
> +               }
>
>                 if (gt) {
> -                       lvts_ctrl->calibration[i] =3D
> -                               (efuse_calibration[sensor->cal_offsets[0]=
] << 0) +
> -                               (efuse_calibration[sensor->cal_offsets[1]=
] << 8) +
> -                               (efuse_calibration[sensor->cal_offsets[2]=
] << 16);
> +                       lvts_ctrl->calibration[i] =3D calib;
>                 } else if (lvts_ctrl->lvts_data->def_calibration) {
>                         lvts_ctrl->calibration[i] =3D lvts_ctrl->lvts_dat=
a->def_calibration;
>                 } else {
> @@ -1763,6 +1767,7 @@ static const struct lvts_data mt7988_lvts_ap_data =
=3D {
>         .temp_factor    =3D LVTS_COEFF_A_MT7988,
>         .temp_offset    =3D LVTS_COEFF_B_MT7988,
>         .gt_calib_bit_offset =3D 24,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8186_lvts_data =3D {
> @@ -1776,6 +1781,7 @@ static const struct lvts_data mt8186_lvts_data =3D =
{
>         .temp_offset    =3D LVTS_COEFF_B_MT7988,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 19000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8188_lvts_mcu_data =3D {
> @@ -1789,6 +1795,7 @@ static const struct lvts_data mt8188_lvts_mcu_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 20,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8188_lvts_ap_data =3D {
> @@ -1802,6 +1809,7 @@ static const struct lvts_data mt8188_lvts_ap_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 20,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8192_lvts_mcu_data =3D {
> @@ -1815,6 +1823,7 @@ static const struct lvts_data mt8192_lvts_mcu_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8192_lvts_ap_data =3D {
> @@ -1828,6 +1837,7 @@ static const struct lvts_data mt8192_lvts_ap_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8195_lvts_mcu_data =3D {
> @@ -1841,6 +1851,7 @@ static const struct lvts_data mt8195_lvts_mcu_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8195_lvts_ap_data =3D {
> @@ -1854,6 +1865,7 @@ static const struct lvts_data mt8195_lvts_ap_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct of_device_id lvts_of_match[] =3D {
> --
> 2.39.5
>
>

