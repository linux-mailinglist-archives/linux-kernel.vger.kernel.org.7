Return-Path: <linux-kernel+bounces-822753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028CB8496B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD49517F9E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E162D1925;
	Thu, 18 Sep 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRGXxpD3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01BA283FD0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198643; cv=none; b=SF/8yEDiGADzXmpGXcDeTcJ1wktFXlHLDiI///syJMcpssmZktRuOZ6muJv3Ukzn9Lz81bYbDndENyfANB3pN6fT3JZ8Z70yYrqePsBTkNTKAkNbKZ51h0l8T3ZpoXf8HmyM5Ndmuy8OBXGlrPiX1F7UWRU654jd3KDzgfOAYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198643; c=relaxed/simple;
	bh=hFnQmhtB5FdUouz9wOMjSFsEfEpZDGlWnR0IKMEjviw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKqE4+SDdft2ZzVcJMSte1ZVucHUIgxslfDi7305j6/55LB/c0xR7f/timS1TFS5FX/bIQbFm+NpoJFB2N49CoHVQma/q85ooupi8yKY8k3cIKIsco5xPhLxrSH2KuTE+3g8repAx61Mv6qy/P4SpLuS2mboqJmvVaOwyZ8ZCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRGXxpD3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24457f581aeso8785065ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758198641; x=1758803441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja6LsTNawGy4pmDnATZPCfzTVrsSk5wN9q0e+DceoU8=;
        b=bRGXxpD3ZIyxEkVfPJ48lb6z09Orn0+ZOlI4e0AqFqo3eM+DpBs6pV+OWG8gMLb2x1
         3DTFmaUcFBRu3SKNwtFLELoeVWXL6N0mcSEWp1TTK4+i2bjSqOK4OpaCe+VgAlmac4IU
         nGrDL5CVMnylKfcGOwzAEn30f99GzPJNHe1J9zTgqJFLpUcz8pdMy5NJL0ylk5TPMRa8
         aIX7DDHe904vf8jYA0vJR9VOteiPcuCOrV45yt3OhMAzXyT523cWx65XmUPE9sgXh9gg
         xfx1Hsl14YlGs7CGQyHHf+ofKhfW8cLxzy7IDQsf3ILoK8sBFycn6OKfwhTBsjT8+3G+
         2bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198641; x=1758803441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ja6LsTNawGy4pmDnATZPCfzTVrsSk5wN9q0e+DceoU8=;
        b=V7c+ZsljPZFRJkZzrfq80Yb+bPmFPaNh18fibE448zn6plRvDrF4Nr58KmlKDcrFsI
         457NVJFRncEVim27xHb7h47Sc1unhzlx7MrURJHCbsKrs/wWaTEAWEDZhEQm3IGJfp6O
         9E1vPn/gZKjSuQ+QL/+zmNgucdOQ2IwhH/3QQIbyIou5JNw8bnNBPVNKsNsE+cSc0shS
         aQo/tqaFGUleve+osx5JaR5aq1W3OnZcoGi3Y1zTzOyolVqNaH82tdLYPf1ntH1psVoi
         JUru/U/NTl+HrNV0fq1cP3LgR8eUd3P84anidOAQ2mYaWO5ECJ6A0IJQ2vNE9bNrmmcX
         0HVA==
X-Forwarded-Encrypted: i=1; AJvYcCXfd48ky0N7t/FbOUIlIKyRFHLz6oTa3YuriZTYAS+Sa891nTajbQVvsbIKBV7NXDrA2MbqEwYSXGoTbCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUp2qPYSEA5Sg2sJDeMxmneTAlKWBtEvY+O6dKg4dwDyADSDk
	1KZKrAuu9FqKg56LNkGB0S4KVp5Bh0Znsp+ADM7UBa6pHBXp38zwHMr9i3/E06WRsu1u7N0UXoi
	VTsQ6rE3Sn3tQpjSJ6uNajHvW9/yVcVw=
X-Gm-Gg: ASbGncuDyff1Um1fgHpChjCoV9sjk3cqa61LCF1kQtDkTEN00NO01lc0wNXfevcvtty
	MSgH0h+TBoXeCtsOBy22VNUOrX2I2X78fSYCqEMvmUWtVhRxuk3RwBlOvO7xHlUR88fWH2aSuFY
	flbepySF4m5P58johFZM3J5Kziv5FWj0Kxmc0n7UKzHPixPw8LAXxE9hveNYEYrzK4e28CWlXO3
	wLWCuYnpBRd1Gr5KPwZygkIjK4mGSgiIeN8HodWkl0DLc7fjWiNQvZ9zIcJOLpsXg==
X-Google-Smtp-Source: AGHT+IHfxVH6u3MLt6Uuih0vzSbpLygF4jPPQ9s8yqLw/oxh8/QW2NTZ+3Q+TitB6KAglFx0XO0/v8MormCOdtkYPDY=
X-Received: by 2002:a17:902:d4c1:b0:266:702a:616b with SMTP id
 d9443c01a7336-2681228a5cbmr84479475ad.18.1758198641200; Thu, 18 Sep 2025
 05:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-imx_rproc_c2-v1-0-deec8183185f@nxp.com> <20250918-imx_rproc_c2-v1-1-deec8183185f@nxp.com>
In-Reply-To: <20250918-imx_rproc_c2-v1-1-deec8183185f@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 18 Sep 2025 15:32:58 +0300
X-Gm-Features: AS18NWDb4GfzMHKRtymYoCSSIMdUKa-LQpWcaz1XI-CRyqhVc2xtdOdWO6gJCWo
Message-ID: <CAEnQRZB2ZkcRirj1SZkfbsPHyyGr5PfnCDfv+ZuMu_Mj6XKBEQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] remoteproc: imx_rproc: Simplify clock enable logic
 using dcfg flags
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, linux-remoteproc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:51=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> Simplify the clock enable logic by removing the dedicated
> imx_rproc_clk_enable() function and integrate the clock handling directly
> into the probe function to simplify the code.
>
> Add a new IMX_RPROC_NEED_CLKS flag in dcfg to indicate whether clock
> management is required for a given SoC. Update probe logic to conditional=
ly
> enable clocks based on the new flag.
>

<snip>

> -               return dev_err_probe(dev, ret, "failed to enable clks\n")=
;
> +       /* Remote core is under control of Linux or clock is not managed =
by firmware */

I see that you negate the comment from imx_rproc_clk_enable but with
the negation
OR becomes AND.

So, the comment should be:

/* Handle clocks when remote core is under control of Linux AND the
clocks are not managed by remote side  FW */

Also, do we really need this flag?
Shouldn't we just make a decision based on the fact that clk is in the
device tree or not?

> +       if (dcfg->flags & IMX_RPROC_NEED_CLKS) {
> +               priv->clk =3D devm_clk_get_enabled(dev, NULL);
> +               if (IS_ERR(priv->clk))
> +                       return dev_err_probe(dev, PTR_ERR(priv->clk), "Fa=
iled to enable clock\n");

