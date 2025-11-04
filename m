Return-Path: <linux-kernel+bounces-885437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E7C32E14
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 21:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9029A34998F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94762E8E08;
	Tue,  4 Nov 2025 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KZfslalu"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D82BE7C2;
	Tue,  4 Nov 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287228; cv=none; b=qlqxzmK2u0+C3oYG7SSPUx9/cx0/y+A9HlT92w65+50DY+eZzVY0WsBvAFtsnI2tdIj3onCAgOs5xKz6VOrBS+bbCH8S5EN/BUx0aDgEAjLdjLpHUcDHjx0lrDqJMJVHJIsWfaN7nKEXM10SFYvLH+LNUmuAlCQ1s+sdKN2ImBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287228; c=relaxed/simple;
	bh=3OVOsauAHqBfFq5y0sIH75q8XfLv7KHL4s4CePq6jik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgnzFS53ksnTSYn8cqkEz7H6kzwO+Kp3sW+XOni6Cv64ngbSPry/KobQJ5VDr51uBsQm/+fapQ1c886f4xcfSVngob9yyCvuuWI8InL3LtjMd6cpG+9Vqj53jwZ5J+PJzYYqvNFZZuVKUEVQxn0jObhS3xVaLkA47dLAYDs4538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KZfslalu; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762287200; x=1762892000; i=w_armin@gmx.de;
	bh=5LCpFMy2Sa/G0xlgeiLHdmWtgBApdqYWv3zP0sHxuSQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KZfslaluDyy2XKgOHK29K8y1NDxaZZ8XAq/HJ0B6VPBgQYGLxXGKV8jZbjysLXUz
	 Dh4TFCAIsHjBMli4aAvgr7R29t/jM+xUaSf99ceO8GWFvsCHW0q8OA05sfGPYE+OW
	 4o8J+FuVfy0869KWaihdrAKP20FQgyVcv8i9MG1raEfKcZz2HHBvsR/Ay03GUE/be
	 IvWlgeTdPev9mtBK3WlKqBufy2H0nO7YfSBU4G1LQndb2wk4iX8M0P3WvuJKK6XEP
	 PROS5iwzWQ4d7csAiYsWrzX6XP333Es2hNzfjyd6RtldeEVI2iDZWJMAQmRiMGW9G
	 SIbvb4HQ9kUcEMGsmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1vYBN31c2r-00IijD; Tue, 04
 Nov 2025 21:13:20 +0100
Message-ID: <a0b6d30b-3cba-4760-81dc-099e8fada7c0@gmx.de>
Date: Tue, 4 Nov 2025 21:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] platform/x86: lenovo-wmi-helpers: Convert returned
 4B buffer into u32
To: Rong Zhang <i@rong.moe>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20251031155349.24693-1-i@rong.moe>
 <20251031155349.24693-2-i@rong.moe>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251031155349.24693-2-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eWbpGXWFB+lbvGNGiVJ4mXtMmndYXQeM5YwZCB9XFoSA8lyXreB
 kuQr+8614gTZzWxys7SK8iNV3APqfIh9yO4qkknIsc9EeDCq2gQCkmSaiktsoH/7FCUm88K
 ONdE21r9A9mV+icIbSl7djHyVAWza3OX26qZ9AYZdZGAjCBTDgLkCBlDTNg6VTISkNX5TAm
 6Y8+r4GD16vNLLwvyUsUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HLA9OgY9O+E=;GdvtZB+2ntgdV24Ql+LQG1672Q1
 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

Am 31.10.25 um 16:51 schrieb Rong Zhang:

> The Windows WMI-ACPI driver converts all ACPI objects into a common
> buffer format, so returning a buffer with four bytes will look like an
> integer for WMI consumers under Windows.
>
> Therefore, some devices may simply implement the corresponding ACPI
> methods to always return a buffer. While lwmi_dev_evaluate_int() expects
> an integer (u32), convert returned 4-byte buffer into u32 to support
> these devices.
>
> Suggested-by: Armin Wolf <W_Armin@gmx.de>
> Link: https://lore.kernel.org/r/f1787927-b655-4321-b9d9-bc12353c72db@gmx=
.de/
> Signed-off-by: Rong Zhang <i@rong.moe>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> Changes in v2:
> - New patch (thanks Armin Wolf)
> ---
>   drivers/platform/x86/lenovo/wmi-helpers.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platfor=
m/x86/lenovo/wmi-helpers.c
> index f6fef6296251..f3bc92ac505a 100644
> --- a/drivers/platform/x86/lenovo/wmi-helpers.c
> +++ b/drivers/platform/x86/lenovo/wmi-helpers.c
> @@ -59,10 +59,25 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u=
8 instance, u32 method_id,
>   		if (!ret_obj)
>   			return -ENODATA;
>  =20
> -		if (ret_obj->type !=3D ACPI_TYPE_INTEGER)
> -			return -ENXIO;
> +		switch (ret_obj->type) {
> +		/*
> +		 * The ACPI method may simply return a 4-byte buffer when a u32
> +		 * integer is expected. This is valid on Windows as its WMI-ACPI
> +		 * driver converts everything to a common buffer.
> +		 */
> +		case ACPI_TYPE_BUFFER: {
> +			if (ret_obj->buffer.length !=3D 4)
> +				return -ENXIO;

The Windows driver also accepts oversized buffers. I suggest that you foll=
ow this behavior
for the sake of compatibility.

>  =20
> -		*retval =3D (u32)ret_obj->integer.value;
> +			*retval =3D *((u32 *)ret_obj->buffer.pointer);

The buffer can be unaligned. Better use get_unaligned_le32() from linux/un=
aligned.h.

Thanks,
Armin Wolf

> +			return 0;
> +		}
> +		case ACPI_TYPE_INTEGER:
> +			*retval =3D (u32)ret_obj->integer.value;
> +			return 0;
> +		default:
> +			return -ENXIO;
> +		}
>   	}
>  =20
>   	return 0;

