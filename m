Return-Path: <linux-kernel+bounces-823101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5CB85874
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B291883942
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD233002BC;
	Thu, 18 Sep 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zp/SOqSq"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C17233721
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208506; cv=none; b=YO9xNDhqzHzWZjnVN6RthezbnqP0o1oIY12V/gH/yyALB3eq5p5cL4a7GKQtDcvLwFoAin3eHukYID+w2/mUKuVSaYxOh0GsL8tgdY7izjw+U+dALuYd25sYPBu074MN+4MEWfywxghiX182E3s/N+5vrHoRSS1370ALuhoUXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208506; c=relaxed/simple;
	bh=W5nTjMEiqZnba5g8e3Gi7lUj7gQH38jU4DdLi32iJEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3CIONUwlfRcjNnCxGTR8FyUHysYSCJUYEyESi1CyVK7NN+7Z8e0PLQ6U+2r4+N+RRnxmUh92R0fpSEIAsI6n0X+8fULBGndeuVRkJU8kHoEhSy47wuPab4xyYN00qFw+xNLWOxa9s69qEblizvj8bTKr14OilLVk7ZtxiucsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zp/SOqSq; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d6083cc69so11229547b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758208504; x=1758813304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OFt6YzhskfMz4G5ASFBcNJdSZpqtygY9kyuCw6Wbqgk=;
        b=zp/SOqSqSMI5TW4vac7YZCkoM9yhF0pMqb0QTI0ezQjs1cYd0yO6U+s5kfa6TAT35K
         EuEhHFpdmfWDaWGY/EQkP/ejyIhf+H8vvhUMfYXBq/x0xjBcU+Bllk6lXsr2eccMd528
         4P8EpBsktYPSTCPwv3th5y8rtpFaUwFMwSoiRSGleDnx/TXO5dJE1t0VXgLBnE8L+02i
         gUChk7v08DwLvgwe0mwyPBWDCSFgqvUwk4fN5kwbX4ZaknTZmMS5Qo4UFxrqcm+KagT2
         Unnl6S72aYIYHH5+vX0CFZ6YeXuRLd+WSz1LsN310YMoO608Hk4933mL1tRto5OOVAyC
         KuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208504; x=1758813304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFt6YzhskfMz4G5ASFBcNJdSZpqtygY9kyuCw6Wbqgk=;
        b=QlH4CJYO2Soj4ldS1PreZESMBeXXsPSBJcav2n92u5tDV8xAcPsGMht90MljRuryBC
         EjIZ/sA3C4zidpxIjNCQnADrxaq215ix82vtvK1oEKUB9r5yw3j0kQyX8hiYYATlbCcf
         UDZ2eDQFxghfSTU/pxtPqLbq3NKiBVhbR1iuLuZWRgTfOUTleq1p49XYrjnANZbUzAM+
         mHMyPX9VJvdryjwdZj2Ig5NhOcM5EWk5DhIL9hOLL1uvztuaM0k0yYZUJiUuooJeOKiP
         UrEb8+xv8150ZdDkd61tPA/bpYyOPN73qZUV5oqv3/QNZSNUb7VIL/WHPo0vSg6aZwuj
         u6vA==
X-Forwarded-Encrypted: i=1; AJvYcCWo0iPkNbWoZxfyijj3dd+Upi7fzG1HedacQ3h8Km5zHJB7Yi7QuKb7P3eU5ENEtd5aGIBgzBgb/A3dNLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFlxe83QIS9j1rtdL1lGhCtudx7BlLQtY98G6R33m/JxY9Gg9
	uyceXa/wPqK/XE4I4c3GYI+NzMIHEdmpFQbnAqXWqXE5icbmgEggWOHRV+wcblt2nj3QiSlab89
	jhv+rrmsNTikcTAHsX7rUDkhQEGmQAVMcB0AaD7ibEg==
X-Gm-Gg: ASbGncuqHd4otdCrzeJir3CAeFaUCXHRTui/HweqX3CIzyGsLMP/3aGLNHhW3TM4rQ9
	B8olru+vxBj4NX+hG+CMzU0mZ4gfJzHLDvYsR5A34/86juusENcFRDZyDL2CLD3/B+C61ZERrI9
	0z/LlW0hBFb4CgL/SUly1tVyy2T1kwMZvrCkiPjIu4EQUG5Ym2GLcxFEp0sQ02eLMbhZFPzpWV/
	oBNycPbmoeN/PDL0iLVBYcGecw=
X-Google-Smtp-Source: AGHT+IFWx6n1PzkYYp5utqUHYs3cajDfg2GyxSlUHuEjN16hnOdbRT6rrrmIdLRynF4h/+ErT5T1ASVcKks2d63Qrt8=
X-Received: by 2002:a05:690c:7281:b0:731:6570:132 with SMTP id
 00721157ae682-73891b87069mr62837047b3.35.1758208503588; Thu, 18 Sep 2025
 08:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com> <20250902-pm-v3-3-ffadbb454cdc@nxp.com>
In-Reply-To: <20250902-pm-v3-3-ffadbb454cdc@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Sep 2025 17:14:27 +0200
X-Gm-Features: AS18NWCdTZsclOkAHpdSQCQjKeMfCrt_EDcLieD3X8xYbm6A6ARROAgFxf2mSRY
Message-ID: <CAPDyKFq1Coz4rbdam01s3pOCDa=Et2ePmf7niLSgOdjCbnEANg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] usb: chipidea: ci_hdrc_imx: Set out of band wakeup
 for i.MX95
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 05:33, Peng Fan <peng.fan@nxp.com> wrote:
>
> i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
> power domain(Digital logic) is off. There is still always on logic
> have the wakeup capability which is out band wakeup capbility.
>
> So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
> wakeup system even if HSIOMIX power domain is in off state.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 8 ++++++++
>  include/linux/usb/chipidea.h       | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index d7c2a1a3c2715967203b98c819fa864e06a00a32..a2b3f673dfc1183a02783bf6ef92f8570c6042cf 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
>                 CI_HDRC_HAS_PORTSC_PEC_MISSED,
>  };
>
> +static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
> +       .flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
> +};
> +
>  static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
>         .flags = CI_HDRC_DISABLE_HOST_STREAMING,
>  };
> @@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
>         { .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
>         { .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
>         { .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
> +       { .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
>         { .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
>         { /* sentinel */ }
>  };
> @@ -570,6 +575,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>
>         device_set_wakeup_capable(dev, true);
>
> +       if (pdata.flags & CI_HDRC_OUT_BAND_WAKEUP)
> +               device_set_out_band_wakeup(dev, true);
> +

Based on my comment in patch1, I think we should set this flag from
within a system suspend callback for the device in question.

[...]

Kind regards
Uffe

