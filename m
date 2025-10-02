Return-Path: <linux-kernel+bounces-840257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A4CBB3F50
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01402A6AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C761D3112C4;
	Thu,  2 Oct 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Iny3QpE/"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4CD2F7ABE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409893; cv=none; b=Fi8G+AAW2ia6oD8HpBKm5fAWg2B98QWadV5omASZokZz/iwCrrM7CQ5yhapWmNR9oUuNeCYXwCCqJK3Zrvq/HkQCQaMK4CmwSuqYgKT+pElKpa9lwXqjr2VNOHHIgUAPMkQlRHZqUDZEMPtBWVfA/iWI+FGdfcX+A55CD0Imt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409893; c=relaxed/simple;
	bh=rwoTCG+vC/4a27tvGJXVSo3x+Qr28gT1DgOxt1WVOj4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QtCwAWR5Wr28dKsJRKwGLEc8cSi8jq2ceYw86YYqDjdPQcQm3epf8Uty2nXDDU6l+aDCfgPBOQyUlYUnlcYbdmDt+/Vcs32axPlDw7DRv9aPF/+2BJ+s3F5p9lGq/OQkl8RjvDX9ymjsfM+v63HrH4HhyDbGjGcOAd7qqkYFONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Iny3QpE/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so1595854a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759409889; x=1760014689; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlHVXQUT5xjofjj/AzuHsPu9MqRuziU/HLOwq3aVews=;
        b=Iny3QpE/s2l2l/HftdnZsd7muY5uyGM7TmDliWrIk5yIWjRaqb6CThkOPifkSTxR23
         5PqB9TPNpzxv8VjOw8WF6CBcVf/29PLK+qyE97KwH8iiNShetA0IzyB7Sg1R/xmdhE9+
         TtNBPSbUqSMFWGVDQCug+BsC09qiNHW+H5V0ydzRYJ5iLPbtzeqHXZWWcEZRLiJ5IwXq
         uuzcjccs+E6X/J0vID6tXwpDuxcOmR+Cj21jqI6xuvwgItDcRwApYSIR7wV1+wcbHCfG
         KHEA4stc+2pAwdOGZxcda6WuO8dD+r9nw2Vv38uMpHUWpu9r08qsgQENTrLvzXCCTFY4
         K7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409889; x=1760014689;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mlHVXQUT5xjofjj/AzuHsPu9MqRuziU/HLOwq3aVews=;
        b=n+GigRXrMf/bSphaCpCnUWOtsOTv1x+ywGLiNuuyYW8fdjmobADjvKZT5er/bWkKAn
         2Zacj9UfoHpvOUpCL/4h8FZOz9xjNr2paadrpNhT5o69fX3d46AqfczdAF0yo+Sx3xCl
         jW+iR4NLDIJZjN9mwj0mhS5AOM9AOIOQSIb+GN/Rasgp+FXTgjU43O8t+N9XwCIERYnh
         kXn/DzxEtzoX2AQwnN+Ily39FwRWvmbl/gZn71Hy0N5Sv2FWJxfwuGIuMWOUOQd2esod
         mej7ZBUnc4jeKYKCGjzPkvjMZCYhxZeA1Lbmb6Ljh13bmeuenf2JRPruGg65H4/LuByq
         GGlg==
X-Forwarded-Encrypted: i=1; AJvYcCWru7kMY4pz3+zKjD5pB6rTVJqDOeBnhfxcdyl+n++wrIPhk5DewD2ZpEe19WSc5OpprEZwWcVi9AkHIXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9Jgk3Z9dPqmC/X1Z8tO3Z00JmhfgnENFdruI9hK7JMq9ki+f
	OzAIXLaAzkjtsajUBPEYoeifL3CjpMDq8joTzykEJOvca/TfyRCGj4pO9oV1fA+ZQLI=
X-Gm-Gg: ASbGnctEt06Vs13NtCh9Qoc6Ua26NVLFgpD4TYeKk+frGef60ZScW+LXRbTWUbawdWm
	YghYALXaXlJoSrId+i8KzUfbfCPzNgYernqptPcsjTpu+yG9fz1+pQuH3h7DCp9ev6YPw18RdfS
	p3PQCkalwR43MW6rUEwtNdC2VTkwuUK8Z9HHZtmZNFYccUc45NdYKgqhRBQRfh5ZP6MI4TY4xHz
	WZN1TN3IJQ7xmICM3sXn8AwE1NkrbovynXhD7HPg/Q7a5jk7nfN52RmJGpRJTBbpR2u2SYCTGFK
	I5gQYIgmfCxE8QmvskjPbiBt+Lt3kQtU36JkU4pBaXPZ0e4Pi3k2fhHFfvTU7kHibmErqcH5Dcr
	ha1WQjQLZC7UAQdOVs9vzhzcdOAW1VL1Hs3mtnHU7tOJCmVd6h0n4dwjgUusNYOLmagdF4b3Doo
	uYoa9hYI14GprqS/bV
X-Google-Smtp-Source: AGHT+IFQ1mVbSshFmP6hkBoNszw5KHlwHgEvKAoM6u/Ai0RegitKIfBOYx0FIZnlu+xOm0B4DjDmBA==
X-Received: by 2002:a05:6402:5241:b0:634:4f76:25f8 with SMTP id 4fb4d7f45d1cf-63678c80b42mr7833044a12.21.1759409889519;
        Thu, 02 Oct 2025 05:58:09 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637881000c9sm1820799a12.31.2025.10.02.05.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 14:58:08 +0200
Message-Id: <DD7UR4O7OYEW.1LFYVKUEE6RED@fairphone.com>
Cc: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/4] media: i2c: dw9719: Add DW9800K support
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, "Daniel Scally" <djrscally@gmail.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>,
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
 <20251002-dw9800-driver-v1-2-c305328e44f0@fairphone.com>
In-Reply-To: <20251002-dw9800-driver-v1-2-c305328e44f0@fairphone.com>

On Thu Oct 2, 2025 at 12:15 PM CEST, Griffin Kroah-Hartman wrote:
> The DW9800K is a similar part to the DW9719. The method for operation is
> the same as the DW9719, but the register set is different. Add support
> for this part to the existing dw9719 driver.
>
> Tested on the Fairphone 5 smartphone.

Can confirm!

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

Regards
Luca

> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  drivers/media/i2c/dw9719.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/media/i2c/dw9719.c b/drivers/media/i2c/dw9719.c
> index 3627e78b8b6668933c4ecd92231465ce4105ff0c..172479f2c9f63f6b2a1f6eccf=
8184142edb383b9 100644
> --- a/drivers/media/i2c/dw9719.c
> +++ b/drivers/media/i2c/dw9719.c
> @@ -68,6 +68,9 @@
>  #define DW9761_VCM_PRELOAD		CCI_REG8(8)
>  #define DW9761_DEFAULT_VCM_PRELOAD	0x73
> =20
> +#define DW9800K_DEFAULT_SAC		1
> +#define DW9800K_MODE_SAC_SHIFT		6
> +#define DW9800K_DEFAULT_VCM_FREQ		0x10
> =20
>  #define to_dw9719_device(x) container_of(x, struct dw9719_device, sd)
> =20
> @@ -75,6 +78,7 @@ enum dw9719_model {
>  	DW9718S,
>  	DW9719,
>  	DW9761,
> +	DW9800K,
>  };
> =20
>  struct dw9719_device {
> @@ -137,6 +141,12 @@ static int dw9719_power_up(struct dw9719_device *dw9=
719, bool detect)
>  			goto props;
>  		}
> =20
> +		if (dw9719->model =3D=3D DW9800K) {
> +			dw9719->sac_mode =3D DW9800K_DEFAULT_SAC;
> +			dw9719->vcm_freq =3D DW9800K_DEFAULT_VCM_FREQ;
> +			goto props;
> +		}
> +
>  		ret =3D cci_read(dw9719->regmap, DW9719_INFO, &val, NULL);
>  		if (ret < 0)
>  			return ret;
> @@ -177,6 +187,12 @@ static int dw9719_power_up(struct dw9719_device *dw9=
719, bool detect)
>  	}
> =20
>  	switch (dw9719->model) {
> +	case DW9800K:
> +		cci_write(dw9719->regmap, DW9719_CONTROL, DW9719_ENABLE_RINGING, &ret)=
;
> +		cci_write(dw9719->regmap, DW9719_MODE,
> +				  dw9719->sac_mode << DW9800K_MODE_SAC_SHIFT, &ret);
> +		cci_write(dw9719->regmap, DW9719_VCM_FREQ, dw9719->vcm_freq, &ret);
> +		break;
>  	case DW9718S:
>  		/* Datasheet says [OCP/UVLO] should be disabled below 2.5V */
>  		dw9719->sac_mode &=3D DW9718S_CONTROL_SAC_MASK;
> @@ -426,6 +442,7 @@ static const struct of_device_id dw9719_of_table[] =
=3D {
>  	{ .compatible =3D "dongwoon,dw9718s", .data =3D (const void *)DW9718S }=
,
>  	{ .compatible =3D "dongwoon,dw9719", .data =3D (const void *)DW9719 },
>  	{ .compatible =3D "dongwoon,dw9761", .data =3D (const void *)DW9761 },
> +	{ .compatible =3D "dongwoon,dw9800k", .data =3D (const void *)DW9800K }=
,
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, dw9719_of_table);


