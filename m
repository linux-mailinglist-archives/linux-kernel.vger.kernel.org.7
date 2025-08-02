Return-Path: <linux-kernel+bounces-753958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553B8B18AB7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 06:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D503AF1D0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 04:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14A61DC985;
	Sat,  2 Aug 2025 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1AUHxVk"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC851D90A5
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754109571; cv=none; b=E4UzuAcphJEo0sIC6VOpyQWyJyZf/fDBgkL3Wd6zLw4FoFiYfGEtIB1uie1prnW0mDntZDQgZAzDYx25M5yfpvfXv7uDATPw3c+7GF4cNkk8KwTv6gnVy9ErBqs1or+/QpDoZ90GrNO8NcKa4LKbgQnoqMp5r1NM8SDvR9lamZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754109571; c=relaxed/simple;
	bh=4Dg34mx4qxko4XxpK2YIUD+lvidXnjY1AMEKq1PsdMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llDpSpfGAR0Rbf1eINquv1TQcEKDG7UYKqKEtCiLnPQtbTahyJk23gNkJrorIfpLCr2t/tlpJGqkkT0bYgCmiwjwJ8dKwjXY9Oqk3NPUxlCI0p3BEGYjEInyXDOuu/ryV/+9LkxWlci5fzUM1rG+ylElvvQ7y/lMvbJ58o9GU5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1AUHxVk; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70a57a8ffc3so24886167b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 21:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754109569; x=1754714369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwedNykX1uMkjq1G07l2poxKV3lFWdGMwyK077ctHSU=;
        b=k1AUHxVkTdrRG8QoCLAOwIJmklsUQAh1z+pWCNhEDKxlhf9tl0q9N3CsrTpGaxfePC
         2r/jQQN67B8q90WLY7Dj8jiipJ8fcmVZNZQwAPTmwUEfBDjIgJOU9DO4AdTeeJSduUq6
         68NLDXXwWSnQBiB3ljtzUowzzcUx2510ZZ1cjCHMWBVB9sZC9qFMf0V5nUxVOvnRt2rM
         3ojPvEK7VcPVAagw6J4GgH+23A1sSpqnsl3lOoJbDoYX3huhTS5F6d9fJuN8D9YRM6UX
         htVujS7wLbTQQhsqEDf6DZRBwuCgvm/t7X6CO22/GwdS+ym9v0yLW9+Xdh2sRKpuyO0d
         F+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754109569; x=1754714369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwedNykX1uMkjq1G07l2poxKV3lFWdGMwyK077ctHSU=;
        b=qlLE+6Cwm9ha9E9G3p2ztHrulMw2jD+t/x7j9J2COEaNo2pHa5iLiCjD+58FmTeMF9
         HYSA3S+UKYlUBG+YVEzuR0QinCdMtDPwPJkR5qKwfvduxz6O/13daLgEW5eTYQOY9jKS
         dlIUnL1bLFiUU7Y5FQPg859mVP96+6GuImERvBy/cJBxdxv4SPWfWGmb0WV7XP/TCBES
         venbYBaCsy3V+Ug2XlIBJMlJ7CL5z/VIIYWsXObguKEp84YZMnRxl0VFdyzg43/bqING
         TWYip6ZGl4TanDl9IW6OwR6Wuf/gAGVVPqlmqqbuX5ljr/jeJD4UNVfniyiLbUqfGIIn
         ILbA==
X-Forwarded-Encrypted: i=1; AJvYcCU3QD1PszCU6hG6LF1x7y3ord4Oswf2oFKMZEHIJpgIHpib1ZKPHk5Y+38moPb1Uz8VLlMf8tPL6QeukGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTF0biD9fYmZedVlCvnlL99mgrQzBo2JFjJF+64dkpiT+na7T
	Urq0jpXq4OPnAU7Q4Gzdc1Hhie8AV17tcani5bPBQin1fCmQOH1Sow7J7z9gtBqezr7X+6VYPbB
	q7cIZPLVy74yMeqQcEntqp/dV8BXXbRb3PMSztOfX8A==
X-Gm-Gg: ASbGncu5iN9Mmd0b72hah488ysS2MXhJtLEWi1KSwXizwBG02evFlcjZYcUA2+Vte0U
	HGbzkuDwFIeE+aXyz/x3mOkLD4Fafm5NReL+WgZHRnxXuAL72uWd3crD/UQCURtnDtAwxf51kBr
	CPS53NOP0kgILMJLGwVDWkOIVogbzDpS6V7rqZ9iXrHE8XIGhiejSaOfPRLWFfVStn2o+HWXKI5
	kFgm3HV/uCSpaOn
X-Google-Smtp-Source: AGHT+IEHE4XW/c08xnfJpKw584beuzxAr7sJRcO6jVJsJ6rlMG13mbhm7ts+7ePCLEPAybkCbOBp1u2oY29yCQQpE9E=
X-Received: by 2002:a05:690c:d92:b0:710:f46d:cec3 with SMTP id
 00721157ae682-71b7f5bc0cemr24750957b3.5.1754109568692; Fri, 01 Aug 2025
 21:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250724081337epcas2p430db7d7514b8cc05e41001f17b8b0d45@epcas2p4.samsung.com>
 <20250724080854.3866566-1-sw617.shin@samsung.com> <20250724080854.3866566-5-sw617.shin@samsung.com>
In-Reply-To: <20250724080854.3866566-5-sw617.shin@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Aug 2025 23:39:16 -0500
X-Gm-Features: Ac12FXzXiIgqxqB3CLv0jhcuQWL0uuYoB3Fa71uV_JWyZNdu94J92BGrpnV5cXk
Message-ID: <CAPLW+4=CZ=VsWerWEXGyXkomsAUJkd8eYycCRktKZjsTi-RVgg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] watchdog: s3c2410_wdt: exynosautov9: Enable
 supported features
To: Sangwook Shin <sw617.shin@samsung.com>
Cc: krzk@kernel.org, alim.akhtar@samsung.com, wim@linux-watchdog.org, 
	linux@roeck-us.net, khwan.seo@samsung.com, dongil01.park@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 3:13=E2=80=AFAM Sangwook Shin <sw617.shin@samsung.c=
om> wrote:
>
> Enable supported features for ExynosAutov9 SoC.
> - QUIRK_HAS_DBGACK_BIT
> - QUIRK_HAS_32BIT_MAXCNT
>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Sangwook Shin <sw617.shin@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/watchdog/s3c2410_wdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 184b1ad46ca6..16a845f41e74 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -305,7 +305,8 @@ static const struct s3c2410_wdt_variant drv_data_exyn=
osautov9_cl0 =3D {
>         .cnt_en_reg =3D EXYNOS850_CLUSTER0_NONCPU_OUT,
>         .cnt_en_bit =3D 7,
>         .quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
> -                 QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN,
> +                 QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN |
> +                 QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_32BIT_MAXCNT,
>  };
>
>  static const struct s3c2410_wdt_variant drv_data_exynosautov9_cl1 =3D {
> @@ -317,7 +318,8 @@ static const struct s3c2410_wdt_variant drv_data_exyn=
osautov9_cl1 =3D {
>         .cnt_en_reg =3D EXYNOSAUTOV9_CLUSTER1_NONCPU_OUT,
>         .cnt_en_bit =3D 7,
>         .quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
> -                 QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN,
> +                 QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN |
> +                 QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_32BIT_MAXCNT,
>  };
>
>  static const struct s3c2410_wdt_variant drv_data_gs101_cl0 =3D {
> --
> 2.25.1
>

