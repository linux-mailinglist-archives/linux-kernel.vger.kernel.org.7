Return-Path: <linux-kernel+bounces-746927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31250B12D2E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241D2189D446
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E2B4A32;
	Sun, 27 Jul 2025 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="X9H+HB6t"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C8191;
	Sun, 27 Jul 2025 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753574638; cv=none; b=rZZG2BPnDNP5cEnmyu5yiWV7+46lt0lfSUJXNArILhNMwiYboSdY3tRNFsl8wFOmXp7qNvxDk61IbXhFS6SaoaMdzK185jzgfgf9G66mVB3qVjyvqz3/sGDgobX+EZ7HY3voQNRoyWi0K34v7+JwgPAvz7Pf2cyfhT4JJ3KdFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753574638; c=relaxed/simple;
	bh=JfBV3ebkmrEvQe7FZs5FYBx/78x6+EPk8m117ZHbAK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=We1Ic5cCLWTFbJtkOnxia4XQo5xagOP7O6v+0dP9oLjrFPMs2/m6Wyun8IHHrF1GGo8NYtmkRNJbjtmwylGo6p23VtIrsdfrJQoEUTduhLi8mxWjly/JVbq3y2SBbAZFwAoQvmxLz7pOf3Ev1nTlJCT8fdwl9mNb1dlC3ztd70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=X9H+HB6t; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753574626; x=1754179426; i=w_armin@gmx.de;
	bh=taYZTqpTXzgGmGxxLaEYOcTPhLZUXki3uQyD82KsFyo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X9H+HB6tBk7Ho2Am3wX1aDsiivwJHBwbrwMANxJUYLAYPeMhLJKE54bQPDqOmFn7
	 giDX/v50tBkD/0JcewzvuDvQK65k8Wg2dzCsPdLtkDMzGOSIj7UDhvlmzzHBoSS3E
	 5hCHiwVWMw9p4IzIxKsY+Dg0OTd8II/Dq0Rkz/2i2j8ALnvG2l/dYkalnoMGsiG9m
	 3NzPJwbXC7a+DWpecvdD9E5h9Wcg4T4jkrVZciIyJ/IOixG5D+xtwYnJcGSF9x+d7
	 vobbbFkXMb0onq5C0QrI+XDaHVGKfp7iPa6RpEaFmTRmITi2uy69dOSZK6uPq53zG
	 EXbm7xg35LEiUKBnyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1v5q9w3Ig5-00YHRK; Sun, 27
 Jul 2025 02:03:46 +0200
Message-ID: <5e910391-5769-40dc-882d-90f79888c772@gmx.de>
Date: Sun, 27 Jul 2025 02:03:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] platform/x86: (ayn-ec) Add AYN EC Platform
 Documentation
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 David Box <david.e.box@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
 <20250726204041.516440-5-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250726204041.516440-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZMtuH7wNrJVkEC8EAT1uTNaLAW/gHL63nn2tJ4+sf7zjJ16eAAb
 DvRBA3+ZrmB29Qq81soGKQP118PC2AE4RgoxfJn910mUXGH+TPPzi1ndRwx+ha4eEp00VVh
 KyLNUx7Uhtf+6dpKS05r2nkP8rG/GAOFkG0zUyQs9usXmH6GQgDv/z+oN3S1HcQX7jlqdqB
 t1wcpbS0PpyHNMSK7auSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VkyFnyOGTAc=;FF8DWxWQOY2ct57OFg4MDW6lz4a
 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

Am 26.07.25 um 22:40 schrieb Derek J. Clark:

> Adds ABI documentation for the ayn-ec platform driver
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   .../ABI/testing/sysfs-platform-ayn-ec         | 59 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 60 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-platform-ayn-ec
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-ayn-ec b/Documenta=
tion/ABI/testing/sysfs-platform-ayn-ec
> new file mode 100644
> index 000000000000..32cb6f7ca2fc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-ayn-ec
> @@ -0,0 +1,59 @@
> +What:		/sys/class/hwmon/hwmon[0-9]/pwm1_enable
> +Date:		July 2025
> +KernelVersion:	6.17

I think that this driver will miss 6.17, better use 6.18 instead. Also you=
 do not have to
document standard hwmon sysfs attributes. For documenting the special PWM =
mode i suggest that
you add some documentation under Documentation/hwmon/.

Additionally please add the new files to the MAINTAINERS entry of the asso=
ciated driver.

Thanks,
Armin Wolf

> +Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
> +Description:
> +		This sets the PWM fan mode of operation. Valid values are [0-3].
> +    Values [0-2] conform with standard hwmon operating modes. Value 3
> +    enables user defined fan curve settings.
> +
> +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> +
> +What:		/sys/class/hwmon/hwmon[0-9]/pwm1_auto_point[1-5]_pwm
> +Date:		July 2025
> +KernelVersion:	6.17
> +Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
> +Description:
> +		This sets the PWM fan duty cycle for the given index of the fan curve=
.
> +    When the temperature reaches the corresponding pwm1_auto_point[1-5]=
_temp,
> +    the EC will automatically increase the fan duty cycle to the given =
value.
> +
> +    Values are [0-255]
> +
> +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> +
> +What:		/sys/class/hwmon/hwmon[0-9]/pwm1_auto_point[1-5]_temp
> +Date:		July 2025
> +KernelVersion:	6.17
> +Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
> +Description:
> +		This sets the activation temperature for the given index of the fan c=
urve.
> +    When the temperature reaches the given value, the EC will automatic=
ally
> +    increase the fan duty cycle to the corresponding pwm1_auto_point[1-=
5]_pwm
> +    value.
> +
> +    Values are [0-100]
> +
> +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> +
> +What:		/sys/class/leds/ayn:rgb:joystick_rings/effect
> +Date:		July 2025
> +KernelVersion:	6.17
> +Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
> +Description:
> +		This controls the display effect of the RGB interface.
> +
> +    Values are monocolor or breathe.
> +
> +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> +
> +What:		/sys/class/leds/ayn:rgb:joystick_rings/effect_index
> +Date:		July 2025
> +KernelVersion:	6.17
> +Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
> +Description:
> +		This displays the available options for the effect attribute.
> +
> +    Values are monocolor or breathe.
> +
> +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b816883fe7d..199bebbffa0d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4039,6 +4039,7 @@ AYN PLATFORM EC DRIVER
>   M:	Derek J. Clark <derekjohn.clark@gmail.com>
>   L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-platform-ayn-ec
>   F:	drivers/platform/x86/ayn-ec.c
>  =20
>   AZ6007 DVB DRIVER

