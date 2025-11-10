Return-Path: <linux-kernel+bounces-893834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 560BAC4875F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B76C44E83E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5378930E0F1;
	Mon, 10 Nov 2025 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ADWrBX+2"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB02E54B3;
	Mon, 10 Nov 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797758; cv=none; b=Qejck6hMzuTfjZQ8kO1yJ8WHFZWny45qHm9XYxRLlnV5Ir4wkl7Eyqe1UyTYiYwadwApXEEVfHxsnCKis7lVeFUyE2YqiKE1lFL2LcouAUASy2OKQrSzW2AiTffrsUQl/d0nS9RJ1sr6CYGvZkMzbtbFzULgshTOf4LF7BSICx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797758; c=relaxed/simple;
	bh=wDiioYbXkN84J9BljVuNoMQ3/lrhgDpg+ug7s/PvM+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+F0ng/C3CVwymXyDzKN5m2JXgEXYJZjiZi3CJ7ZXxvurNx7plMmr2SRZtABDg4vv0gigmTEOOtc1vHcc1y9tfkQX0uU5eHSG5AGZW/HTek+sxmFm8WEmF5NJTiPAM7lvQgWGPY9Ck4sG3EnnRc3zngGJexgk894697vUyfPa3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ADWrBX+2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762797739; x=1763402539; i=w_armin@gmx.de;
	bh=P4Ka+Nslvpurzf47YJ4FsBMdsn3Hw2D7Afr76nYrb6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ADWrBX+2kWgPAo1iYjs7jX4qTLnrKi7j8U+yWScd/MXK2ytTCXGKwFmgcZXJ155c
	 rViF8k/baPecehpblzp4eR/tUh+7j4Z1FP5qesfoz9zz0nQM2Z7j+RIzqVzMUHT0E
	 beINyNDnO01lerZWAFLVl+Esi+/PQWSsaEX6TFw8ktBUA7nARwZFrHmVUDJSHA+my
	 vCgHGFDVOwQD3sIK7RxtRIpLrvIi731bZmO3gqg7yduTEsUkyBM7x30I7MoCt7qKC
	 ntS3NIALGw0bgl47JaoFCriBOJdubcmZuW8XECOujkd8VIc6imypsM1AqpXI5pL/X
	 OhZ0IZMNyj+4lYLA/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4QsY-1wIqIm3xfa-00rAz6; Mon, 10
 Nov 2025 19:02:19 +0100
Message-ID: <a2dc5c23-837a-4520-8975-6d01fc50fa58@gmx.de>
Date: Mon, 10 Nov 2025 19:02:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86: msi-wmi-platform: Only load on MSI
 devices
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>
Cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, lkml@antheas.dev
References: <20251110111253.16204-1-W_Armin@gmx.de>
 <20251110111253.16204-2-W_Armin@gmx.de>
 <3014ce29-a707-2d77-71e6-11a631221804@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3014ce29-a707-2d77-71e6-11a631221804@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IMJjz/PpXEhCab6x8mCbWiGSNpdtVbLywXFrnQpZ9BuzNgbl24O
 UjF8/c+fqwoBS5swsKEnos+0tQQXXCTerDdsc5a/ldCNai59oqtw5hJ9Y900CCwzJkVBeB0
 Umz149uxp+Bs1pai5DlasjP6cYxMLk7q1GxeINc2vf/LUt8HRqGeSu0JXQ0y9IKTU5+zW4P
 vxMSr4Xi7QHCFV36VEnVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1dd11xetYoI=;d5vMtdc0U9/agTdACX4jBA56gsB
 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

Am 10.11.25 um 13:40 schrieb Ilpo J=C3=A4rvinen:

> On Mon, 10 Nov 2025, Armin Wolf wrote:
>
>> It turns out that the GUID used by the msi-wmi-platform driver
>> (ABBC0F60-8EA1-11D1-00A0-C90629100000) is not unique, but was instead
>> copied from the WIndows Driver Samples. This means that this driver
>> could load on devices from other manufacturers that also copied this
>> GUID, potentially causing hardware errors.
> How unclever of them to copy-paste an unique identifier from an example.=
..
>
> I've applied this series to the review-ilpo-fixes branch.

Thank you. FYI, it seems that many manufacturers are doing this, for examp=
le
the eeepc-wmi driver also uses a GUID from the driver samples. I do not kn=
ow
however if said driver has any safeguards against this.

I have CCed the maintainers of the eeepc-wmi driver so that they know of t=
his.

Thanks,
Armin Wolf

>
>> Prevent this by only loading on devices whitelisted via DMI. The DMI
>> matches where taken from the msi-ec driver.
>>
>> Fixes: 9c0beb6b29e7 ("platform/x86: wmi: Add MSI WMI Platform driver")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/Kconfig            |  1 +
>>   drivers/platform/x86/msi-wmi-platform.c | 41 ++++++++++++++++++++++++=
-
>>   2 files changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>> index 46e62feeda3c..d96728a0f18d 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -545,6 +545,7 @@ config MSI_WMI
>>   config MSI_WMI_PLATFORM
>>   	tristate "MSI WMI Platform features"
>>   	depends on ACPI_WMI
>> +	depends on DMI
>>   	depends on HWMON
>>   	help
>>   	  Say Y here if you want to have support for WMI-based platform feat=
ures
>> diff --git a/drivers/platform/x86/msi-wmi-platform.c b/drivers/platform=
/x86/msi-wmi-platform.c
>> index dc5e9878cb68..bd2687828a2e 100644
>> --- a/drivers/platform/x86/msi-wmi-platform.c
>> +++ b/drivers/platform/x86/msi-wmi-platform.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/device.h>
>>   #include <linux/device/driver.h>
>> +#include <linux/dmi.h>
>>   #include <linux/errno.h>
>>   #include <linux/hwmon.h>
>>   #include <linux/kernel.h>
>> @@ -448,7 +449,45 @@ static struct wmi_driver msi_wmi_platform_driver =
=3D {
>>   	.probe =3D msi_wmi_platform_probe,
>>   	.no_singleton =3D true,
>>   };
>> -module_wmi_driver(msi_wmi_platform_driver);
>> +
>> +/*
>> + * MSI reused the WMI GUID from the WMI-ACPI sample code provided by M=
icrosoft,
>> + * so other manufacturers might use it as well for their WMI-ACPI impl=
ementations.
>> + */
>> +static const struct dmi_system_id msi_wmi_platform_whitelist[] __initc=
onst =3D {
>> +	{
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "MICRO-STAR INT"),
>> +		},
>> +	},
>> +	{
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
>> +		},
>> +	},
>> +	{ }
>> +};
>> +
>> +static int __init msi_wmi_platform_module_init(void)
>> +{
>> +	if (!dmi_check_system(msi_wmi_platform_whitelist)) {
>> +		if (!force)
>> +			return -ENODEV;
>> +
>> +		pr_warn("Ignoring DMI whitelist\n");
>> +	}
>> +
>> +	return wmi_driver_register(&msi_wmi_platform_driver);
>> +}
>> +
>> +static void __exit msi_wmi_platform_module_exit(void)
>> +{
>> +	wmi_driver_unregister(&msi_wmi_platform_driver);
>> +}
>> +
>> +module_init(msi_wmi_platform_module_init);
>> +module_exit(msi_wmi_platform_module_exit);
>> +
>>  =20
>>   MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
>>   MODULE_DESCRIPTION("MSI WMI platform features");
>>

