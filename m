Return-Path: <linux-kernel+bounces-781876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE388B3181D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3821D02716
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6311E2FC001;
	Fri, 22 Aug 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hcg9y0fX"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC219007D;
	Fri, 22 Aug 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866484; cv=none; b=QbWTW/XXD0NvRxfPwOgzHWiTbNgM9IlVwLqTzTLtMt44A8Op+uqJX6vCHieyGJcSEzK/e2ZfWBI1+k+P6QKO2vvj9zZtuVDGHZaYxZRa1mMtKhNGGFyDHIgFRrO9Hopq6mc7gFiURripzeNV0aAEIvYbsFOH4GT/3NAS8XkMwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866484; c=relaxed/simple;
	bh=YR5XU+QjZhfjCsD9TDvvLC+yftuWqfjApTsbmhw9uUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YV9YA33tp7J7Pp9/8j/43CVYY+dmgKyck7Mk8rg6y63DTestsAl+SOKqLTXPy+Ux1A8lO1SbiAgFuLyLyTN8DqNco81eEIu4gQ1dx954o1Pbh8XX9/FXYs7xlzlZsZ6oYlfK/Zb4f20XbVFqpv0raN3BI6+iD3o1cE1j5AHLCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hcg9y0fX; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755866458; x=1756471258; i=w_armin@gmx.de;
	bh=UlOyDv2nwexOW5ytcGdIPOdSrhxqxrZmMe9/PB+UnfE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hcg9y0fXcE+UnxvRqNukUE2b82YBY4IFCu2pmvTRypE0D+ItFtoZ1XMVU0wdiAkK
	 8OINuF9979xooTaOzek4noREtLjM+IRfJp2L2223bi9kERs7apszyDmmg69xr4ynI
	 C7XmvH8N+EvGK9zfD+//L+eevRMsJA/cRrNwcl8XSorja+hjSIlTqvhFWfe1Q5LSm
	 6f4uOL8K3k7TRsslZWYxHMNuQJ5RuHRBSUxbMMhLQ91LszBrs3TOAtH/GkQg+w4Nq
	 njV9Z6mJPfskrXkNxIDH1sqabkbrVQx3VX/4atlCoyezlenEFS+DvUqFWTB2gFRKM
	 PYIFLQrr2Y8JJiuKtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.189.91.1] ([176.5.63.45]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1v6hD40TaZ-00JxfG; Fri, 22
 Aug 2025 14:40:57 +0200
Message-ID: <aaf9682d-f48f-4d43-b8fe-87a93b353fa7@gmx.de>
Date: Fri, 22 Aug 2025 14:40:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20250820160628.99678-1-lkml@antheas.dev>
 <20250820160628.99678-5-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250820160628.99678-5-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lXcldDE17gduNyIg/HvkWZ+VHNliy3CWfGYWMylGqStv2qaXTYd
 udRsZhepK3hJjWyr7MtlQYwpPOb8S3fSFidYIxtY1Y1vi+OmJKCyYAB2Y0y91OdKLHxThEw
 oVg5MaQzXTqFmiTiYaib++H5w+9a4Mu6EwoZL/0VdWUhf7/Y8mhDSmMlZwoYeMiMrl5YoUC
 k/0duq8/kuk/R0g85gwEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O3nUpIcBkys=;lEcklwz8VjbLgZ9rP6WIBUZ4BZJ
 pzSHawmnJSYtORpUDIZuINWW6EPVItF6m3Rv8VyoYWM3/sdgxi0BAuxWFuf5WMCE+j9CxFeLd
 lC3DOj1LLk5a6vzRQTp6AHmkw4MmKtwzgJ1EACytEi7A4VIg8t7fYeshgWgdDgNtjTl7HJx+X
 sNsCKz21G9b1p8VC64o6PYpKgXm8MkZ+NXTOIwUQZaDDxQxgzuC9fF2K5DL9IfI1FQGUeSq2l
 s4PF4YsnYSQOEn7j7rERtUpeLPanhAdqxsgcNh5JodLZxhK9J/h5IRUk8LFt92ijC8/v7RLiG
 nnv9CjwJYDM2ZKPXnJyNa8EAfUGG5K6ACY5N98Sh8sa6rGPnYhL+/rlZBpZDyR7zuntgBTNsw
 cXK06U1ON349GqdEMA5wdvHQfjoX+GjGqXssIGUQ3V1NdIUlukXUCFZW30OBd/aqDrNDk+Diy
 Wt7g2WRPFfDDT+udmd150oq20rIrM4se0RoJO9He4A8Gk6+vGEu22cEqCQB4gZiSqRACF+K6y
 HrdOItuS2Oono+D1wSIDPFNdzw9uZA7xVnaBmnABJ4KFITMRWc6nAShBY4EaXU6eVxJ86L7SJ
 FYlGNHaT2kVQnHPQFSYC4Bdsu8JViPob8Fdst7DFKaG5TXgBTB7gXuTjY1vG58cJhgZJOgM7/
 CKQFpWr9f2J2CSyoTKGrKlOpCxqjQdESFirTATHTR3FpHGe+Gq5bq9WxpuqVbSWli9nEe24ar
 yJbAT6iCfz9HhX9Hxc4DONSuQb69GThXjJzjex9/6/ZAzu5tx6HWc8erpmvgQX0TRyFw3N6F6
 xiSgdFExxuSgXKCjbfVSErc7mk2X6yS8lLRLJx467O1rgLSmYx/7CxLNDLsSRV7FMjKnIDRsG
 DbVG74uvrAfm3zh18pps8RXBZzERvMy2Ef9Lxr30XdQMg7PvyiYROOeISS0yaVY3mV8Kxqght
 eWJv2cSivsQAPixAAJr+xGiT7MDtVRmhca8LPgdCYmM9lq0oDlULInJlvattKhf6Se5WQa+Eq
 APbkubLIxXzPb4+LNUFkn3/bG3hI0n9EeuCLkgAQCwdL74WkMQhc01JpjGs/W84wMBcYRMUBO
 F0eJSD40X20cgViA34LxmhWbZhRi1f8HcIvHPD0cppgWipf/b2CpiKvzTO2J1lrq65aoJvUdf
 E5DelFDKuxdfUEfqvZ04mFtObiWZI3ogjv9vcRrWwuiTJ8g0R3TeH0evqgIDggGj8r1Azeq9n
 JY3/3Xrz9rG57xcRHNzPexGsFqEIBagTmum+xR4psoSKnZhWo+e0/QzZp5OzXMtiYfdHJOAiI
 QYABDsuwuDifu1z+jyFIIjQYy6k8rtFgnRJEjKgqMNzutopWlOP/zaDnQS8pxg8aaaIcN7f7+
 tFEr7ypv3u0azlLNoY7yJWX7RKzDyFvSIuLbpcLnSh5VzHK7i0haiLQUz1hzt96A8y6eku3pF
 dq2G/oE6x1cxCFPFOVIphv5LXzZD6okGrbTe6iOiJceEH8Swtqsjhc4ak98V5KOaERUrUAZt4
 PfIvA020kImiFc0GGCUzypcxiUpT7ZvW/41xU8xRf9SoLepwmPq3d1YCjeRi6Tz/Lc7HI+XSp
 OIdowuJzPg6wB6OSctIFz/u38dGlmxYsywFIUhT2QoK8yI3CQtQMHjkH6MdMQafJgmBmaRjPQ
 6ahrCX2Ie4+3/MPhopz48Qy7TubUgEPQUe5ZmR0FdvGsJ2Lws2BaK7+HoS5etZjMy9LpzEAoU
 JzrnqSjFeqLYBMo+3QDMEhWlQ20Nvk+nykR3xEnPhdlU65gKKN/2z9Fgncxd3PlTBf3aiyXq9
 OHZgeWLA6cxyhm1ERpR8RhDeCUgBwfANAZ9nB/gISVJdnKffWFO0zik4TaNm7Eh9nFMKU3055
 wl9s1gY/SQETgXFlyp5Wsz/ZukUm+Wdhc2WM/Mfp1RVSIizEC82FMGWkunxqUFtZZjH8wrTF4
 NQiYRtV2j3MTddzuaB3TvWfZPlw4Du07FilGDoBP7pJ/HVvSbZUZKDzNPY99FDvmjqy+ynB1h
 VrE+s8HX2OuMclnzFYloh8UVrbWVLRx1/nyJ3XE2fFEBBGdGYP877Abg2m23tAjO29pZlRdZA
 BZII50ueaemLkOetTfK2986eKIJNjoZa6girJmAG61/Fn/AefaDENkLUXgUWCiDve/eX7SpkM
 4REYfe/Gg3ETn9gVqgru0UFDrC7oEDbSkJqQPGbLkHZsrbG5QlMnAEdnySLcfRD/isF/SrJ/s
 4zVrLSGU2874cjcEkK1xIX7QZg3x+k+O0bXR2F61JkL8105HdiM9TLgKUpYXVIFYikn+c70K9
 ELUw1muNR0giUZTv143bh4oY10EEQA7DWipvUi76Eomu9hS8q8Z/qQSofICZMOFu2N7YurXKM
 zuXM/kycGKuu1/QezsGMLN+2xaeXpk2plZGGcAu8TgLmZxLtbkhiomrbEzAbuCv+UGb+DtMyV
 MK9Yt3orso3F57uL6bx18WOtqGwqe2w6W7zxYC/nUqrvEefbOSEqD+lwLTyK3B8sh8cfS8864
 pXwPkXzZVkV8LIAhArEYE9b75PRrDFDmme+OO99EPdFIja8ENQFvWce8C1WjnFM2JRMwuUNwT
 UBqJ6DCIZRnCecmIsSIFvPPRgAoGUxtjHXGrQQ5S6jDbsGZnk56DSDGxWaxkSb+/BYM0Is4R9
 ki0MCDpIkTkcmxUFnnu+emejaxr7pg7ZMZpKcfSzorZiOTHWCKl8MPy4l2pMJa9n6wVqOPWgE
 34ofHVkDyz2DkEPxyGCcSb+6+JILrhRdkUDqK4gcQATS0MoAor3DMGXnYgn/r6cQq1YnRcmvR
 J2rJgEQyqog+h4ZKPEOuh0HGxjZCL+CvR/wWipGL+thTTvbf7GvfhN5xaedUvbn/MfOhEl4Pp
 IK3Jx23k1J4y2XSEulTs+L21XtaKMycMwsUWEKlJ5LfvS+VXtQgGtiYD7bfUvA9VYBaMwbMx+
 /zRZw/SZEHXCsQPAymIYJBquoXKfCEhchSsRG1ERtbXJMYzC8uFu0t3smjjbs4/ZHBnVxFBbg
 z5wDyU/QYn++OfGVFSjr42n8ke2uzsrPZ+KL4WXUH1NOuxY1sTLt/SbLq8UDr7bD1j1fS0Ejt
 3rpeAGF6wRy9KKuBKCxyzXJt44rmv19b3SwBiGCgMeF/XK8LQqOJEq8f+YO5ciu/dwQFitEOC
 jNHvhtv8/U5hq/E7fUQU8Kk0yxJ/tZCPP4c6X/tbrfzwowzSa1Qrryc7dvarir0YFIgjpGhg8
 J6Z/R8+zaLXrrjxYGlHKGFIdOPFdnRW2kej2WukcMV8RcDMyeY7WuIKPknzaYpbnoX4FcgbO1
 NKa7ZW4G2RYJZVLcHZcnlfBjJu7t1C1OTfvAQJCEKSJ6cUHJWSg0KSYoy5amC0l+WikgaSmyS
 WbgjjI8v1QwnlRxFge9oiUXzHNdIF6nOEYrsWgO5MRoNIaw87q9gpGZevjmaV8ZvmO8RvLwsW
 liwLFx9K3+dipT+2CEPQ/58Q1s0LNlLHR2RhTZ4N3x8bCCHLvhOaqCgY5T4/tBnjO3Sab8ISp
 +U38BVfSCDWw0L6OWftn31kz+XMfu3KrO3tdJVe50kOIsi6rUo0zSxQiUZ2x4iqeoJyjnWXEk
 CtHzlNoUQQjBctM10P7qlHZtn7cFzxavtQFVsQFNlk0jNFCIYNohhIT50Rp5uQ1vhehVhMzC0
 Uwf2Q3yohW+X2D8/oi29E1mmZHCpMXYYfm4+PUbNcV+G838sDkco2qZ0kseRzz8Mi7BUEsvsz
 Uxm92fO682CUISksnQABupAGLjHL1l+XyHWQkvaKqlXvVBdTil2n6eKVFQNsRwZ5SAoG3iiVO
 P/0dq6vemXbd4NtuuH9Vxz+Q2lbxMAAr8muJV8dNVShpyHsLz3Qd9T2CByeBLxdMp6OntoeR7
 VCFpqwjCCaG8eYADmUz6NsBiG/w/Ypq6YlVUFb6MVo/6QqC2lOvPgWE1esybZhLiujQHr01uy
 bvxvZSqlQyzipGRoOD7wCFeCRLsC8APDi3bsuU8iU64us48qtjmmggbDEG3UeZyK+N5PHsFHJ
 BbUToC79qDKdtnU6HVQrmGNa69ez/oq5PNCwmZhLBYnV0GGoBC4J6vT0h/HQLn7SZvVmf+k7d
 Ei1PJ3gTpOcSVyDguL6hSODbD1ThyHyogKOJ+5VGugLciFq/2lCyZvQ2PNmNOcvqRMG97WbCd
 TtvyyUeIDj35VGAA2FpeYZ2heEuVd+P+S/bVvNuVsiw/C/DccToO5KU1spki7PdG1ixYjjIEq
 bo9zgWkQZHRqKvv18u9bSdeQ4dq6trTl0ZzH8ENVGV5Ahy3KjBIMOXcunvfWtCDJAnSu9C2Ia
 1E3+k/FkJEu/TsA0lNaRJcxN0odbMwdjYHkcaTeUrP0FAvPsbenS9/JhDZCNbXBqsvttxiHcz
 3FSsx8EkEewT62PczD0ecOgGquAOlkNdortPK7PVxdn6L1kkAfgPHg+V70BHTEamcu89FVKbD
 Q1jA8etP1fdWWNW3u/j/ysXIr5m8cgjoJWTzoF5FXpiOVB73OSc2tQhFPUkxB7yDGkSpUqRQL
 CeFs++Khd3bkU0ga+FHnctUh6guv3uMmmsr5z214nRwpHEsyaEHeuUvKH3+i4ZLhGQllKdkvZ
 +3Kmg5sERMeeItTLMuMNSPPGIcW7BpozlCOuMaoX4CD3JJiWKAkoEJ0awC+N1PwOFx+RX0CE7
 FVTE+6LqxVObb+09u5Xj+/udDq8U8MtNRALV/pLua1DkzMH9Dlja08AC/dDNGazdLZMcSCNtl
 RHgW1aEWcvLwzPKwskylfKKzDxWN2U96OKJY/gXKMamMA2DhKUVDarLKVhSAxrtpsZjjqnGVA
 yNlI1l/0Se

Am 20.08.25 um 18:06 schrieb Antheas Kapenekakis:

> The Ayaneo 3 features hot-swappable controller modules. The ejection
> and management is done through HID. However, after ejecting the modules,
> the controller needs to be power cycled via the EC to re-initialize.
>
> For this, the EC provides a variable that holds whether the left or
> right modules are connected, and a power control register to turn
> the controller on or off. After ejecting the modules, the controller
> should be turned off. Then, after both modules are reinserted,
> the controller may be powered on again to re-initialize.
>
> This patch introduces two new firmware attributes:
>   - `controller_modules`: a read-only attribute that indicates whether
>     the left and right modules are connected (none, left, right, both).
>   - `controller_power`: a read-write attribute that allows the user
>     to turn the controller on or off (with 'on'/'off').
>
> Therefore, after ejection is complete, userspace can power off the
> controller, then wait until both modules have been reinserted
> (`controller_modules` will return 'both') to turn on the controller.

I do not think that those controls should be exposed as firmware attribute=
s,
as they are live values not persistent across power cycles. Better use
sysfs attributes instead.

Thanks,
Armin Wolf

>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/ayaneo-ec.c | 235 ++++++++++++++++++++++++++++++-
>   1 file changed, 234 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index a4bdc6ae7af7..eb7f9ae03b4f 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -16,6 +16,10 @@
>   #include <linux/platform_device.h>
>   #include <acpi/battery.h>
>  =20
> +#include "firmware_attributes_class.h"
> +
> +#define DRIVER_NAME "ayaneo-ec"
> +
>   #define AYANEO_PWM_ENABLE_REG	 0x4A
>   #define AYANEO_PWM_REG		 0x4B
>   #define AYANEO_PWM_MODE_AUTO	 0x00
> @@ -30,20 +34,60 @@
>   #define AYANEO_CHARGE_VAL_AUTO		0xaa
>   #define AYANEO_CHARGE_VAL_INHIBIT	0x55
>  =20
> +#define AYANEO_POWER_REG	0x2d
> +#define AYANEO_POWER_OFF	0xfe
> +#define AYANEO_POWER_ON		0xff
> +#define AYANEO_MODULE_REG	0x2f
> +#define AYANEO_MODULE_LEFT	BIT(0)
> +#define AYANEO_MODULE_RIGHT	BIT(1)
> +
> +enum ayaneo_fw_attr_id {
> +	AYANEO_ATTR_CONTROLLER_MODULES,
> +	AYANEO_ATTR_CONTROLLER_POWER,
> +};
> +
> +static const char *const ayaneo_fw_attr_name[] =3D {
> +	[AYANEO_ATTR_CONTROLLER_MODULES] =3D "controller_modules",
> +	[AYANEO_ATTR_CONTROLLER_POWER] =3D "controller_power",
> +};
> +
> +static const char *const ayaneo_fw_attr_desc[] =3D {
> +	[AYANEO_ATTR_CONTROLLER_MODULES] =3D
> +		"Which controller Magic Modules are connected (none, left, right, bot=
h)",
> +	[AYANEO_ATTR_CONTROLLER_POWER] =3D "Controller power state (on, off)",
> +};
> +
> +#define AYANEO_ATTR_ENUM_MAX_ATTRS 7
> +#define AYANEO_ATTR_LANGUAGE_CODE "en_US.UTF-8"
> +
>   struct ayaneo_ec_quirk {
>   	bool has_fan_control;
>   	bool has_charge_control;
> +	bool has_magic_modules;
> +	bool has_controller_power;
>   };
>  =20
>   struct ayaneo_ec_platform_data {
>   	struct platform_device *pdev;
>   	struct ayaneo_ec_quirk *quirks;
>   	struct acpi_battery_hook battery_hook;
> +	struct device *fw_attrs_dev;
> +	struct kset *fw_attrs_kset;
> +};
> +
> +struct ayaneo_fw_attr {
> +	struct ayaneo_ec_platform_data *data;
> +	enum ayaneo_fw_attr_id fw_attr_id;
> +	struct attribute_group attr_group;
> +	struct kobj_attribute display_name;
> +	struct kobj_attribute current_value;
>   };
>  =20
>   static const struct ayaneo_ec_quirk ayaneo3 =3D {
>   	.has_fan_control =3D true,
>   	.has_charge_control =3D true,
> +	.has_magic_modules =3D true,
> +	.has_controller_power =3D true,
>   };
>  =20
>   static const struct dmi_system_id dmi_table[] =3D {
> @@ -260,6 +304,159 @@ static int ayaneo_remove_battery(struct power_supp=
ly *battery,
>   	return 0;
>   }
>  =20
> +static void ayaneo_kset_unregister(void *data)
> +{
> +	struct kset *kset =3D data;
> +
> +	kset_unregister(kset);
> +}
> +
> +static void ayaneo_fw_attrs_dev_unregister(void *data)
> +{
> +	struct device *fw_attrs_dev =3D data;
> +
> +	device_unregister(fw_attrs_dev);
> +}
> +
> +static ssize_t display_name_language_code_show(struct kobject *kobj,
> +					       struct kobj_attribute *attr,
> +					       char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", AYANEO_ATTR_LANGUAGE_CODE);
> +}
> +
> +static struct kobj_attribute fw_attr_display_name_language_code =3D
> +	__ATTR_RO(display_name_language_code);
> +
> +static ssize_t display_name_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	struct ayaneo_fw_attr *fw_attr =3D
> +		container_of(attr, struct ayaneo_fw_attr, display_name);
> +
> +	return sysfs_emit(buf, "%s\n", ayaneo_fw_attr_desc[fw_attr->fw_attr_id=
]);
> +}
> +
> +static ssize_t current_value_show(struct kobject *kobj,
> +				  struct kobj_attribute *attr, char *buf)
> +{
> +	struct ayaneo_fw_attr *fw_attr =3D
> +		container_of(attr, struct ayaneo_fw_attr, current_value);
> +	bool left, right;
> +	char *out;
> +	int ret;
> +	u8 tmp;
> +
> +	switch (fw_attr->fw_attr_id) {
> +	case AYANEO_ATTR_CONTROLLER_MODULES:
> +		ret =3D ec_read(AYANEO_MODULE_REG, &tmp);
> +		if (ret)
> +			return ret;
> +		left =3D !(tmp & AYANEO_MODULE_LEFT);
> +		right =3D !(tmp & AYANEO_MODULE_RIGHT);
> +
> +		if (left && right)
> +			out =3D "both";
> +		else if (left)
> +			out =3D "left";
> +		else if (right)
> +			out =3D "right";
> +		else
> +			out =3D "none";
> +
> +		return sysfs_emit(buf, "%s\n", out);
> +	case AYANEO_ATTR_CONTROLLER_POWER:
> +		ret =3D ec_read(AYANEO_POWER_REG, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		if (tmp =3D=3D AYANEO_POWER_OFF)
> +			out =3D "off";
> +		else
> +			out =3D "on";
> +
> +		return sysfs_emit(buf, "%s\n", out);
> +	}
> +	return -EINVAL;
> +}
> +
> +static ssize_t current_value_store(struct kobject *kobj,
> +				   struct kobj_attribute *attr, const char *buf,
> +				   size_t count)
> +{
> +	struct ayaneo_fw_attr *fw_attr =3D
> +		container_of(attr, struct ayaneo_fw_attr, current_value);
> +	int ret;
> +
> +	switch (fw_attr->fw_attr_id) {
> +	case AYANEO_ATTR_CONTROLLER_POWER:
> +		if (sysfs_streq(buf, "on"))
> +			ret =3D ec_write(AYANEO_POWER_REG, AYANEO_POWER_ON);
> +		else if (sysfs_streq(buf, "off"))
> +			ret =3D ec_write(AYANEO_POWER_REG, AYANEO_POWER_OFF);
> +		if (ret)
> +			return ret;
> +		return count;
> +	case AYANEO_ATTR_CONTROLLER_MODULES:
> +		return -EINVAL;
> +	}
> +	return -EINVAL;
> +}
> +
> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *a=
ttr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "string\n");
> +}
> +
> +static struct kobj_attribute fw_attr_type_string =3D {
> +	.attr =3D { .name =3D "type", .mode =3D 0444 },
> +	.show =3D type_show,
> +};
> +
> +static int ayaneo_fw_attr_init(struct ayaneo_ec_platform_data *data,
> +			       const enum ayaneo_fw_attr_id fw_attr_id,
> +			       bool read_only)
> +{
> +	struct ayaneo_fw_attr *fw_attr;
> +	struct attribute **attrs;
> +	int idx =3D 0;
> +
> +	fw_attr =3D devm_kzalloc(&data->pdev->dev, sizeof(*fw_attr), GFP_KERNE=
L);
> +	if (!fw_attr)
> +		return -ENOMEM;
> +
> +	attrs =3D devm_kcalloc(&data->pdev->dev, AYANEO_ATTR_ENUM_MAX_ATTRS + =
1,
> +			     sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	fw_attr->data =3D data;
> +	fw_attr->fw_attr_id =3D fw_attr_id;
> +	fw_attr->attr_group.name =3D ayaneo_fw_attr_name[fw_attr_id];
> +	fw_attr->attr_group.attrs =3D attrs;
> +
> +	attrs[idx++] =3D &fw_attr_type_string.attr;
> +	attrs[idx++] =3D &fw_attr_display_name_language_code.attr;
> +
> +	sysfs_attr_init(&fw_attr->display_name.attr);
> +	fw_attr->display_name.attr.name =3D "display_name";
> +	fw_attr->display_name.attr.mode =3D 0444;
> +	fw_attr->display_name.show =3D display_name_show;
> +	attrs[idx++] =3D &fw_attr->display_name.attr;
> +
> +	sysfs_attr_init(&fw_attr->current_value.attr);
> +	fw_attr->current_value.attr.name =3D "current_value";
> +	fw_attr->current_value.attr.mode =3D read_only ? 0444 : 0644;
> +	fw_attr->current_value.show =3D current_value_show;
> +	fw_attr->current_value.store =3D current_value_store;
> +	attrs[idx++] =3D &fw_attr->current_value.attr;
> +
> +	attrs[idx] =3D NULL;
> +	return sysfs_create_group(&data->fw_attrs_kset->kobj,
> +				  &fw_attr->attr_group);
> +}
> +
>   static int ayaneo_ec_probe(struct platform_device *pdev)
>   {
>   	const struct dmi_system_id *dmi_entry;
> @@ -295,12 +492,48 @@ static int ayaneo_ec_probe(struct platform_device =
*pdev)
>   			return ret;
>   	}
>  =20
> +	if (data->quirks->has_magic_modules || data->quirks->has_controller_po=
wer) {
> +		data->fw_attrs_dev =3D device_create(&firmware_attributes_class, NULL=
,
> +						MKDEV(0, 0), NULL, "%s",
> +						DRIVER_NAME);
> +		if (IS_ERR(data->fw_attrs_dev))
> +			return PTR_ERR(data->fw_attrs_dev);
> +
> +		ret =3D devm_add_action_or_reset(&data->pdev->dev,
> +					ayaneo_fw_attrs_dev_unregister,
> +					data->fw_attrs_dev);
> +		if (ret)
> +			return ret;
> +
> +		data->fw_attrs_kset =3D kset_create_and_add("attributes", NULL,
> +							&data->fw_attrs_dev->kobj);
> +		if (!data->fw_attrs_kset)
> +			return -ENOMEM;
> +
> +		ret =3D devm_add_action_or_reset(&data->pdev->dev, ayaneo_kset_unregi=
ster,
> +					data->fw_attrs_kset);
> +
> +		if (data->quirks->has_magic_modules) {
> +			ret =3D ayaneo_fw_attr_init(
> +				data, AYANEO_ATTR_CONTROLLER_MODULES, true);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (data->quirks->has_controller_power) {
> +			ret =3D ayaneo_fw_attr_init(
> +				data, AYANEO_ATTR_CONTROLLER_POWER, false);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>   	return 0;
>   }
>  =20
>   static struct platform_driver ayaneo_platform_driver =3D {
>   	.driver =3D {
> -		.name =3D "ayaneo-ec",
> +		.name =3D DRIVER_NAME,
>   	},
>   	.probe =3D ayaneo_ec_probe,
>   };

