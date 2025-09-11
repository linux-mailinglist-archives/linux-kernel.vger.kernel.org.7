Return-Path: <linux-kernel+bounces-812860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A4AB53DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE4BA078C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934842DECA5;
	Thu, 11 Sep 2025 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZdqbf2u"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1626E2C2357
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626108; cv=none; b=dCgc2Yc/vluM0Cx2tcM3X3MvMA0GhJU2976Osat51Hugh2UqYQNDkNe8mt1SX7f4o9AVHiNOca+85ucK/NgQCs+kQi+RmGdiAg1hbaVktI8g+bOK6ahIihmASb1ICKgGxTFHeYJxI4CL7FZuDg/jfpjA1Dvd8yMoVjDiwX3KiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626108; c=relaxed/simple;
	bh=/cCjXZtrqpy7VHvisyVa/Rdug0JeWOd0noi/GFcDP60=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rFD7VJNTgbq65ckpXQX6odIO1bjzLvO7ZTOLxt9NOeq74y78uWA1Zd+Hm+rhzlTF98YBmO1K56gRQFKd+q2wD7U+XtiPD6CfHqxHva5snwJGTAvwtFqzW+K5sHUZ084NHgmVXKAkzk+jaNp5wwp7pXKI/7Wzd7slXzLbMVSiqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CZdqbf2u; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e46fac8421so1062923f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757626105; x=1758230905; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XmPWjwHkYZP0cjDM6/TOrZ9Pu7V+x53nqGWgCRHLe0=;
        b=CZdqbf2uY+SU4AcG1d8n+8VIfH4drOsltEU2WTGL8JvA/6oyTiy3lPBlzjHvszyjUN
         Vjs8qAbsauZLLnuBxN23lhLiD7/P4uVb/bK/UK9eOPZpCjEHFnLMi2ctwCrDePk2xwT+
         sgMrlkcCw251UD+e0c5bd+FGp4ng8kd+UD8czo0zTCNExXoocF90LHw3/6RH/5ssNv0h
         UFan73gJPfS/OzczJ6lNeBto5kxPOIE7uMh7bu6+MUHG4gGZRvZCGGUUZA5a0ceo1lOm
         YCGyMghGPRREceTAAAUXyOD7e9osGfrXMq1UE9byncoR52Wzk3naCELIv6/VRTeHAyZR
         tVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626105; x=1758230905;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0XmPWjwHkYZP0cjDM6/TOrZ9Pu7V+x53nqGWgCRHLe0=;
        b=uxhch49s1sdDBmszUuqXM4tJz8/0RAahT3Hkz5vdOwEtd47BiLR1QV0Q2qciXBFf29
         cSxTZCiHrLmjWgF+ltT8wF8WFM8/igJ20RNG85zGWhvVRNtLIKpzF+lb2lXgo0dr2X8P
         x9dlmuvtqr2gCN3hD5fNZOx1Djb+V+wpRAyCp+XBr0iBtcJ9Amf3t+7KmNKxSQNs4mnR
         H14k4G6YpHAsmvUqUcnWLcew5d5zCbVAEka6kh5EFQkT3zhvNBbBqxLyKFMjOPVmsvDT
         3Wx5fOVIo4hNpYCp36dIWsm4l26i/PzdMCFjzwln87+7FOtDFKrsAAcjQzGNfXBw1TvZ
         OkrA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Hk9nNo9b+d3w3AGdB+IOvOdy4NM7wfCTVtVc80rYtdEBvdwmCQFunJBRWg0yVVu3bH0Gs28DHATG9QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycjizz9qWOnYLmHghNy4NPlTKQAPzm0tMp+gVs602WVrk1pkLP
	7iwO0SF8iAzac2m+62oracIgjhT3KiDlVNcyOiezxTcIvuROA7t1vcUSpjtQW3/Xvbc=
X-Gm-Gg: ASbGncs0Bc0Tsm25iGfPUJHXm+srII7qayKiP44eRqkGwM63vLzIWDC+YlKf678GWRt
	YzjStIrWPpp77MB+NebF/C5xJVHddgcSv1/ox5JzmamsYgPgjbfX6Fw4HW3LJ/N/qvz6EIr19zv
	aA9MDG57MiI3qoh4qh9YydS4Du/7OS45BijvaSyCGw/Xw89TK63l6pZUvJ3HtwTr789uEEIm11T
	xAQ+NQ3x2oWCzLZ+cv1OmJYnyLJ7WItc3fwcsTMxJNn+RSIlayZB7DmPpd6utqdQkmMxfczMIPN
	niyPRbZfoynYuwDefiIa1dbmyxP02SspqjSbw/z0ghxcLsuQ2Srhe9Ue8nViL3no/WnwTxHWn2s
	rfU2mAfPsdCLOtg7V09t8pW1o/hMSmeitF+0=
X-Google-Smtp-Source: AGHT+IGTc0rcdmQ0qqcNXcSMBd6YBfVvs/8+uIuw4BgL2H05vO3tLXTMHz7QbjVlp6IDwRn3LlLQ6Q==
X-Received: by 2002:a05:6000:230c:b0:3dc:1473:18bc with SMTP id ffacd0b85a97d-3e765530b01mr725312f8f.0.1757626105382;
        Thu, 11 Sep 2025 14:28:25 -0700 (PDT)
Received: from localhost ([2.223.125.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372ae57sm36200245e9.8.2025.09.11.14.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 14:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 22:28:24 +0100
Message-Id: <DCQAGDC63M8X.3DVH6I9FA0IZD@linaro.org>
Cc: "Johan Hovold" <johan@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] phy: qcom: edp: Add Glymur platform support
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Abel Vesa" <abel.vesa@linaro.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Dmitry Baryshkov" <lumag@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>
X-Mailer: aerc 0.20.1
References: <20250911-phy-qcom-edp-add-glymur-support-v3-0-1c8514313a16@linaro.org> <20250911-phy-qcom-edp-add-glymur-support-v3-4-1c8514313a16@linaro.org>
In-Reply-To: <20250911-phy-qcom-edp-add-glymur-support-v3-4-1c8514313a16@linaro.org>

On Thu Sep 11, 2025 at 3:45 PM BST, Abel Vesa wrote:
> The Qualcomm Glymur platform has the new v8 version
> of the eDP/DP PHY. So rework the driver to support this
> new version and add the platform specific configuration data.

It is a bit confusing. Subject suggests that it is an addition
of a new platform but patch itself and description looks more like a
rework rather than new platform addition.

The ->aux_cfg_size() rework here reminds me
913463587d52 phy: qcom: edp: Introduce aux_cfg array for version specific a=
ux settings

Ideally this should be split into rework and adding support for a
new platform. Or please update the commit desc and subject to explain
why this is the way.

> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 240 ++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 234 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/p=
hy-qcom-edp.c
> index 7b642742412e63149442e4befeb095307ec38173..b670cda0fa066d3ff45c66b73=
cc67e165e55b79a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c

[..]

>  static int qcom_edp_phy_init(struct phy *phy)
>  {
>  	struct qcom_edp *edp =3D phy_get_drvdata(phy);
> @@ -224,7 +241,11 @@ static int qcom_edp_phy_init(struct phy *phy)
>  	if (ret)
>  		goto out_disable_supplies;
> =20
> -	memcpy(aux_cfg, edp->cfg->aux_cfg, sizeof(aux_cfg));
> +	memcpy(aux_cfg, edp->cfg->aux_cfg, edp->cfg->aux_cfg_size);

So, if I understand this correctly, when or if init sequence will
span beyond DP_PHY_AUX_CFG9 and DP_AUX_CFG_SIZE won't be updated,
then we might end up doing something fishy here?

Maybe add an if-check or even
BUILD_BUG_ON(edp->cfg->aux_cfg_size > sizeof(aux_cfg))
or something like this? Or kmalloc aux_cfg eventually at least,
however it seems to overcomplicate things.

[..]

> +static int qcom_edp_com_configure_ssc_v8(const struct qcom_edp *edp)
> +{
> +	const struct phy_configure_opts_dp *dp_opts =3D &edp->dp_opts;
> +	u32 step1;
> +	u32 step2;
> +
> +	switch (dp_opts->link_rate) {
> +	case 1620:
> +	case 2700:
> +	case 8100:
> +		step1 =3D 0x5b;
> +		step2 =3D 0x02;
> +		break;
> +
> +	case 5400:
> +		step1 =3D 0x5b;
> +		step2 =3D 0x02;
> +		break;
> +
> +	default:
> +		/* Other link rates aren't supported */
> +		return -EINVAL;
> +	}
> +
> +	writel(0x01, edp->pll + DP_QSERDES_V8_COM_SSC_EN_CENTER);
> +	writel(0x00, edp->pll + DP_QSERDES_V8_COM_SSC_ADJ_PER1);
> +	writel(0x6b, edp->pll + DP_QSERDES_V8_COM_SSC_PER1);
> +	writel(0x02, edp->pll + DP_QSERDES_V8_COM_SSC_PER2);
> +	writel(step1, edp->pll + DP_QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0);
> +	writel(step2, edp->pll + DP_QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0);
> +
> +	return 0;
> +}
> +
> +static int qcom_edp_com_configure_pll_v8(const struct qcom_edp *edp)
> +{
> +	const struct phy_configure_opts_dp *dp_opts =3D &edp->dp_opts;
> +	u32 div_frac_start2_mode0;
> +	u32 div_frac_start3_mode0;
> +	u32 dec_start_mode0;
> +	u32 lock_cmp1_mode0;
> +	u32 lock_cmp2_mode0;
> +	u32 code1_mode0;
> +	u32 code2_mode0;
> +	u32 hsclk_sel;
> +
> +	switch (dp_opts->link_rate) {
> +	case 1620:
> +		hsclk_sel =3D 0x5;
> +		dec_start_mode0 =3D 0x34;
> +		div_frac_start2_mode0 =3D 0xc0;
> +		div_frac_start3_mode0 =3D 0x0b;
> +		lock_cmp1_mode0 =3D 0x37;
> +		lock_cmp2_mode0 =3D 0x04;
> +		code1_mode0 =3D 0x71;
> +		code2_mode0 =3D 0x0c;
> +		break;
> +
> +	case 2700:
> +		hsclk_sel =3D 0x3;
> +		dec_start_mode0 =3D 0x34;
> +		div_frac_start2_mode0 =3D 0xc0;
> +		div_frac_start3_mode0 =3D 0x0b;
> +		lock_cmp1_mode0 =3D 0x07;
> +		lock_cmp2_mode0 =3D 0x07;
> +		code1_mode0 =3D 0x71;
> +		code2_mode0 =3D 0x0c;
> +		break;
> +
> +	case 5400:
> +		hsclk_sel =3D 0x2;
> +		dec_start_mode0 =3D 0x4f;
> +		div_frac_start2_mode0 =3D 0xa0;
> +		div_frac_start3_mode0 =3D 0x01;
> +		lock_cmp1_mode0 =3D 0x18;
> +		lock_cmp2_mode0 =3D 0x15;
> +		code1_mode0 =3D 0x14;
> +		code2_mode0 =3D 0x25;
> +		break;
> +
> +	case 8100:
> +		hsclk_sel =3D 0x2;
> +		dec_start_mode0 =3D 0x4f;
> +		div_frac_start2_mode0 =3D 0xa0;
> +		div_frac_start3_mode0 =3D 0x01;
> +		lock_cmp1_mode0 =3D 0x18;
> +		lock_cmp2_mode0 =3D 0x15;
> +		code1_mode0 =3D 0x14;
> +		code2_mode0 =3D 0x25;
> +		break;

These sections for 5400 and 8100 rates seem to be the same. Is it correct?
If yes, then maybe join them together and drop duplicating lines?

There is probably similar thingy in qcom_edp_com_configure_ssc_v8() above.

Best regards,
Alexey


