Return-Path: <linux-kernel+bounces-870664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99DC0B660
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F04E701C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F32FF654;
	Sun, 26 Oct 2025 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZDHVJXcb"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944401BC5C;
	Sun, 26 Oct 2025 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761518999; cv=none; b=hCCcjG70EvML7ei52FOMQKVsoWHjO/U/0ZxSqY/qCMPyKasYHd5Gsn7DcisA+FTPadywdxjB+/2fxqZy8oebCF2SiGdb22lZz+i8q7rCR7TXlEDINULG+yJrd2XhXb8io3w0REDrUS4bxXrL2i77I+LjtVHNcEHCgIfLk/v9AHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761518999; c=relaxed/simple;
	bh=Cc4df0JjIO6+tnwwuyIYnFiRL2z4izoA0MZNKQ8hkOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CasBYZWUx+WJ018mgs6YB7nqb7L3JV1ptNQQK/LN7/onxs0/AxpqWK3byoZCV3lxSOxTAH9lYqvZYcKUEK4GN9nEjw45wFIPusVwkyh9Coy3asQ9/3/k6W4snrTfEcQqPRMed3hiqJdUx6SpgbQHCAOHF2LngGis++6Hxoj1F3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZDHVJXcb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761518987; x=1762123787; i=w_armin@gmx.de;
	bh=GDn9s7baFendtkmgnn14F/wdoN29Rbr+Rfjd5IqSGU8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZDHVJXcbBsuSGSbJ5GV6Jruzf8UCcJGj+ORfPSxU6Je77xvY5GYtw4bXd4narUvC
	 LhoazZ28RIwbSpyycVY/Ge9749TTVZiSMp823VB/blU9+cZDxTbghyBrgs7k8Dhe8
	 +ytRBL3CPuoJ9C8+yfOwiiQkEQ6AtR2sXevlSCkBOujfq8XIpelR0vYzv20Q5RH12
	 1pRwrx2oVLPEYQsyLxjwh2LipKyL8KLAigQI/MbgrI3W7Ry+V2FRB67KdSGVRzQzS
	 elsns3E4tOiyj23eIiGQotMrlaP8y8ilT0uM/csIU0maBxQwieu2eDYAB64CxMxhS
	 yK2iRbDjDco2kjFAzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1v8DsX0B3i-006Oi8; Sun, 26
 Oct 2025 23:49:47 +0100
Message-ID: <63f0221d-4436-4d1e-a933-8b12f392cac6@gmx.de>
Date: Sun, 26 Oct 2025 23:49:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251015084414.1391595-7-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gcKzcIEb+PthSasSIUnOzPTXRG2+7MY0m8fG3V4qukWQZuV/oFJ
 5u5nQ2PDM3jkn52mQybM9gWbURyvRSoqPOiUWj3H+v+UV6b998fplCwIQna/YmfH/eFC7KS
 Bj4OgrMt2ltYV+g1pMU3boR9FUww5E+dSQYzs/1W1Rr4IxVnmCNUK2dWqA7ef4Ffhu86iHR
 a+G5P9gktTCRqHcf1/G2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wp7F/RXudSo=;fyE6CdDXYW4hDYRgL8djVhouj3P
 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
 UoMQt0Yze2K09Tr7HuShE6AS3OxI5g2wT0U=

Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:

> The Ayaneo EC resets after hibernation, losing the charge control state.
> Add a small PM hook to restore this state on hibernation resume.
>
> The fan speed is also lost during hibernation, but since hibernation
> failures are common with this class of devices, setting a low fan speed
> when the userspace program controlling the fan will potentially not
> take over could cause the device to overheat, so it is not restored.

I am still not happy with potentially breaking fancontrol on this device.
Most users expect fancontrol to continue working after hibernation, so not
restoring the fan speed configuration seems risky to me. Would it be enoug=
h
to warn users about his inside the documentation?

>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 73e9dd39c703..8529f6f8dc69 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -37,6 +37,8 @@
>   #define AYANEO_MODULE_LEFT	BIT(0)
>   #define AYANEO_MODULE_RIGHT	BIT(1)
>  =20
> +#define AYANEO_CACHE_LEN	1
> +
>   struct ayaneo_ec_quirk {
>   	bool has_fan_control;
>   	bool has_charge_control;
> @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
>   	struct platform_device *pdev;
>   	struct ayaneo_ec_quirk *quirks;
>   	struct acpi_battery_hook battery_hook;
> +
> +	u8 cache[AYANEO_CACHE_LEN];
>   };
>  =20
>   static const struct ayaneo_ec_quirk quirk_fan =3D {
> @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device =
*pdev)
>   	return 0;
>   }
>  =20
> +static int ayaneo_freeze(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(pdev);
> +	int ret, i =3D 0;
> +
> +	if (data->quirks->has_charge_control) {
> +		ret =3D ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
> +		if (ret)
> +			return ret;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ayaneo_thaw(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data =3D platform_get_drvdata(pdev);
> +	int ret, i =3D 0;
> +
> +	if (data->quirks->has_charge_control) {
> +		ret =3D ec_write(AYANEO_CHARGE_REG, data->cache[i]);
> +		if (ret)
> +			return ret;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ayaneo_pm_ops =3D {
> +	.freeze =3D ayaneo_freeze,
> +	.thaw =3D ayaneo_thaw,
> +};
> +
>   static struct platform_driver ayaneo_platform_driver =3D {
>   	.driver =3D {
>   		.name =3D "ayaneo-ec",
>   		.dev_groups =3D ayaneo_ec_groups,
> +		.pm =3D &ayaneo_pm_ops,

Please use pm_sleep_ptr() here.

Thanks,
Armin Wolf

>   	},
>   	.probe =3D ayaneo_ec_probe,
>   };

