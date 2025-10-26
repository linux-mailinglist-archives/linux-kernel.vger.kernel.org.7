Return-Path: <linux-kernel+bounces-870654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A859C0B5F8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D783B6742
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926CF287257;
	Sun, 26 Oct 2025 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mhBryLYH"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A3366;
	Sun, 26 Oct 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761518004; cv=none; b=hmHV7IsK/B//qYEfbxxXRwdE1rnQQtq57YviBffBeS+cI/5Vz3dNmqqKHhRuuAZqC97B6WaTVeTxoSDh+oLmiticAeMTlF4Fu564QJ05nbQBeRZpJhrn3gNh4GedWnhlS7cns8j33HwG4UeVNepMtp9O9EyTgsUjvCBasK8302A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761518004; c=relaxed/simple;
	bh=ZeKH+i6INAwbYZ3LmiPgRoexaSYX0beeVnpjQuGqgZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBQFQnrE6z/OZucDlv10yT4pje3Mp99+yUbovAAD2BXbGv1tGXIQXJzX2VxgzXkRPlP4CKFAJ4wygWHoHhyR0zwLhUitc/vBtX3GuQ+meiXTx+n66dOWLsnU/8hh0wWpxUzbSpdJg1vj95jVDiZfRUlvnUpYowZp6h2kte6mK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mhBryLYH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761518000; x=1762122800; i=w_armin@gmx.de;
	bh=YhNgai3C3SjHSECa/ONjQUaBLHUC8yMbN6/P5VX26nU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mhBryLYH9Au9t/3jzynGsViwMyub849A8IBBwYgeLulKTl6sBM/EjPEm+AidcDJg
	 zc8PEyyHXsS+6eaxX3Oxvdm4iwPD1vmFQ3t446sJUf89HkD6cgJh9em1Hh+8qOwwC
	 CPwHh1YKGgvVpT7McI61jjS0+XZNq38/MOert84RnA/FeGnas73xnbIq89Rh2YL9j
	 3/jAVvfmVbOGg7nzGTe+cd9yMR9hrEaPDOQrOIpxQ/64/lMUibKsYSm+VMkNF+UBN
	 TCU+pt4DRI6ERWyvT0x0i9RHYVXO88ASRBeZm3HZfil/CLBg3/cj8z+WSStHkkQgi
	 IPjbDvhONbZJMKhH6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1v4Jax4156-00AIaN; Sun, 26
 Oct 2025 23:33:20 +0100
Message-ID: <526b47da-562b-426c-9210-c02069a07195@gmx.de>
Date: Sun, 26 Oct 2025 23:33:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] platform/x86: ayaneo-ec: Add hwmon support
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-3-lkml@antheas.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251015084414.1391595-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wHR1n9H54xgwLJk95sTkUB+nM8FIsbkwXHzqJjEGBVsTxc64X68
 f13HFBjZ5gUV76zumIf38JOL+TZqBns61WuKoLtwY2u/sU6c/Zy0pnn4fVM2eNVzPjKGcD3
 0hJQTWQiKtpVYbrwqLn9BNNSnvTH7X9Kwnif+VdL4k3aYXaPlbA6yUaa5QWMWShO512VHXz
 k0k9FCUfcMkcRTBgyCpWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3pF6esB2AIw=;iWvmJ6ie//cgveYB6/SqDR1NHmf
 sZ6I7Vvq4gHEAEP6kzh6f8WY2dxnOxfTW2k7iTjDGtpJGWX9UiQrgDzZBmggIv8nzdgeIVumK
 mY5e181M8Gzw9VvLnaICepuZR9qym7JqFY+Q0nbIkwSSJPpuPo9EOZzij0zeOxmu5gcKPOQUJ
 kjKSJklnx0kiIl0CqkydVbKA1C/Az1kZmzDpoVZRWdBwAQMmo/+zqzSAbfyZowvodT0SfMDx2
 HDLNZ5uLau8lEPqR8bCrhxsZ+qJO4EEHeFAO6yT7H0sZg5bHepETqcTvDXxVvcZVeHhMsxYQa
 vSqwa9bTCqnO12LSbyPfMM1lEgdlYshMfON97NwOfttV2YpERdz81IQeRi+E5XOJMOVldKqfe
 /URp2RDWkhZC3vcHl2gFEq+ZmNdf8sPlTdgmyvdaZIfB6mMsILMdL3N9wwcJta92fVLNpm8T5
 mqK84YVZIQSK2Sya4MZ47eHe70oyRAbx6tTz+RajanG+he2mQDz/PyekFdBkz1t8SOzcXz+AK
 uRoKouTY+lrffmx7TTaOT3vuwMjUtNOxPq+cPHYh4apYa8T5a/K8oBFtL/UfYzHuM2QkaFycN
 E20vq3Ih4yIADIHAkgP6Qhs29bdDEmYAIwBLSOw7/C3NCPgI5YxSch6z11oJ1gwOLsuM+BSrC
 s04ySY26TnWKCNpp0JlUQSA2jR5z+iMxxwwH7iOs3yiG9I7RP1RtPnKzonZX+g4R0uaR2Ajpo
 CYAT+MevEsln0AK6GChToxO4QXfLGzavGDBW9nVbwk2tDghdRWVsbzvbuTGj7A9Eun2O/oaVq
 WJw48hs/EEif6TDusVua5k80sHZF3xiXq5VcBdLbHjvDNSGsfysPc9E7OsTBA0V2TMbA1lHxt
 OwZBCSll1vF71IPPGb504FS/rdSM8Teg8PONZi9aqCJTXirjquFwO1L95iP0cPi7ZmEJoKA8f
 NpZu8RFBgxobp2Dl6ZjPU5xh0qROYLnEFH2XILC3zx7pf7cfNiZBUtYZNCB5UxwRrnGKixFqe
 EceurwMKwsM5tm1s9u4Bd4l5kQoten3Xk876HIg4u99EE0JB8hqS40htI07ql7VVfEIeeUzyt
 Tf++W11xznm2ra1G8Sk9oK6K+CGcYwoId+MIVLHTdBwD9vgrCQ8ZYSVqQCpi1eG3dw8lsiUz5
 R0z2dI1yNu0AFnIfhACI5s65aHj95CKTAxpBLpQwCcMF4KpqVvVVzr6GziWglbrMlirzSmf6B
 A1srNnoxgYY+OANMHlMWioV1jc0Q72Md5UJqHOfYT4mPpm2c7kBxq1HjdPyGU4LuJ59si94ZZ
 2qIhtdJBH1YtFNOhXTd2Yhzs0NQKgWFERZnyEu1xvHMUdmzwMXv0ZaoD4rN+jpn4sJp4XcyL1
 1Ofk6KqQ4BzvWBiQFejeRqfDU2H3LtSi4CRDOYSTGAJl9MfZCVgGOXBeDP4xEkbdW3lqhNYlA
 pPaBriL9XFiabPenP9dQaSofKYDs+N9Z1psasYYefPtPTYdWheVSWLlV5tN421r2/P7Pr/ckL
 sDkSAedQr0iOCYIYG39wGkhdocA+urE8Qsijape3ictxeGE2QYzGXmyr+q3ceGCSmg+Gxp3sB
 DgG0382LH0JbDJ6ue+iMCHSdpCwRW7x7kTsGT8YA43J3Pt0Ece6HufdXOy/oIuo6HWcw6HlKQ
 OgkeI9QkqXiWnPufWYO/xpO+FKIJFzhmw7rSH+nLsQIw9Mmj+MDECGEXpL+SMZsswreG5E+iN
 yyMou9q9qVOFDURM/o55evo0hDF0igm0hYfZIfBYjpxL/Vbxfbj+SVPEUg47x8HSekp0vLidd
 wdbYYEQO7n6v9bWx+sKEkVboC0BnYri7ScDQxcvHGsX/OOK1hS04h6ml7YDggURWwUs6v3SOO
 lPgzFN6hbHuS+jofdL/SspnZyfb9Ktoxv9JsbLuE0P9xxJAr72WB/TF0t0cI91aX6+Ymbn1CQ
 eD+58Go2YkiWHWd8Y1i1ONB9jEqhnulEcSldsrJuBdNYgqrD+JLGBNFlOZCTj/edXECTmcsYD
 YXdsTPXqigRMOsU8OtctBS9eE2Jt+3M3ytz4Jbolbmh1lkJytIqaXi3NIYtWhzJI9OZVV0Fzr
 u2+TQEpUJDvL51VwPascz1i2JzrajhGYdDHn8ssb61tzODdOyoaCxk2ssST3wp386jmB3Kmgo
 KdCshvVCXHgoL4MeztnVlwlCx8L/qLuhOKuzVpTg0Q3eMCi+/M6FMmwhQJQE9dpsfCD7QZDAd
 hC/6u78k+CCWMu2uNi3wHOXZ5NKuVFB7I+8gnhLlH2kYU4bugtkRdK8hZduf6MIYPLualh+e/
 kuGTDEgZ2FlyCr4cXulMUitfK5A48vtr/OWSN929QP31oqUp6N7c5ke3318XJHRmuDPlbWTYr
 84BV/u7+a+yidBEjRLzo/qZGGiUS0JmNsadpZ8+eOvH6FzZUD3OsZ/i52hn4IaDIyoxXjkmRw
 NJRArEeET6RB5fuYbmNc2y66jwEzlMZJ5SI5dQ0c7ydmIpgJwlxqTvhkMTH73/1B5rWIh9Pu/
 Ip75SFX/ALKwRG/D4r3FK7XBKa+d6a/7xqGPDCKWLwm5uwhuatyKC/ZnAOeZ32g0lg3zGzzWU
 K4NaufkvdFc/x1MRXHXhd0wcf9k3kHegWL4fTCtZAxMGvacB09NVemaHpauT8hpiEai+iPQPa
 cAEfn5NQWKfUqqZ96y3IwYzukYZKX5TzcbLCvaNYwKBAHZfgTomalMI7Ct2pIR+6gOUXIlQ7W
 5yN+J/Htg4OILmkI52cxH+OZtL9p4vteF1xZtfzoDE7FmS634a9KD/Vw2FIOwsmjM/LUloA4i
 kyve6KIRkMU0ZS6etbkkY8nsRS4yO7arSGfD0fOAGrbkJTFlrAAo6iEe3xwdQRkg8Qj32v7tv
 Q0M/rIuoT9ABjVVXNgB809b+T2NESsxoRSWoZuI63VVLAsL6O7jvxph+svDnC8z5t/kq4xQ8B
 NpQgllXIm12eDYj05BnsEqFWNC1JPVGcu6TCSA5zG1TaWB24o8m6rFIv1baH2DHu1RYjxomyB
 0TkSrqn8BSvvA1TtJA5mDgWM4vwvivi8wuELgrcPrvz/+/5DOO6AmoRkXqAMF4vg5t/NdFdbn
 5qOlgALvbRiRAQs7yiaP6jADKfyHageQFT7AsTuMSiGrkJW/mGY49lWfX3zYCH9V3Aq5DP3dH
 N8wKOY24/jAq3UP4BSGCInTXSrmudaAD5eBQOKTmAaNRreIZ3/u2c5sp8NilosDKP6AIkFrrH
 3qKfGqUZST+PAHAH7aHReca4fLsoPMlZ1KAdF3daxGn/l9xveCVjrlRLtF1lVBVjOgCnQYdSp
 BD8NpSg+Ok9JscSV4oC9Q/rK7BzcUjdZ6Kr2cggpxkujn7+/Mh4x2ya0jhbCN92H6UuVIPfn7
 nBALGS4Bj54Z0C9SE6TtJc7VL3+IUj1VjsrVrr3av3kdgBZGHj9HABnUQM+os3FUZ2lSkSYYG
 48stDGCZZDktuj+64EOXPXDd7tQ7x0JRabEX0CEuymUBUNTbnhhovZjur0VAbQBa2HD467CDN
 A4+PEBJbWv0Qoed/PDGn+NySSXT4CUrgBJlSR0q1UQ0NhtE6hm1DqcYT7T+Ocb/GyAo1iOLkH
 XbH2RicGkODUIRtrVGN+pFUv8If0EaKeCefSsolQfb+z/5mPfg6uCQbCcWABJ45+dIsYNgfFj
 fGATgc9IShSo0OBQ+E9f6ShTDP2QyRKQKytn1UZJVc12jO0O+kBp/aiqh8RobHOKboFgGHflm
 kQxOu2z70tW/guNzKv6rK8r0XMw7l1i4k56KubEHa+jNkMXJKUWuywA8ekcYCdUFP1rvdbWQK
 QXnAXsjBrjGKWkAezdr4z9JX1umuQOb+9vRxQL79lPBGqp0EJdZvtzYDZlHBKaIZNHJnKfmeJ
 obCdyud3SqLZSkDNKhC0UIrYauAMwayT+UOozSdthOcazyXUAleIYzh8GWWXmLx+G2jNKeF0U
 uZ2ndKRUzbEAtMvwoRtEmIdHSFAc/n+ISf0im95kAeVFv/r3pPtUqnqjTjSh76+yNQUMcyAGt
 GGwZWRUArVGKEe+cEEaucgIbGeMGChiNaKycECNC5nrr3YN3lSYAxWMaai6FEe86abr+ocMaT
 Gul+FALp8B5ff/C6H1UHEYU7O5rDAQ+2WUOCg2iwM0Vkc0oKXs7FsHFFWx2+Sg4IpPSfXHodF
 YuDxzuyEV0kT0aRhmOpzyIEBXEFS+uvrBpMCzGiy5C1G5AAD/A6emJa93NlC+ZLqC2m6QPO7N
 txIYoG+/wLzbuf8bSmxK8PmLnALHFJySfdja3eLLi9xybYcRHfODWLnMkUWHXfUyG49KbiebM
 XrBLsSPdGemiJheAWoEyo5hR1Gef77hs7jE5AgGs3WRu4VHoqhkKcpvUdaGoeWWUNO8O1B88Y
 ZqQX5r0A1F8sn+QEQ6oIkAGPkxvTZ4Xht67HjcCNWgjqhA6iCizpEk30mas7kjDMhi+a6Wn4Z
 xkpXS2/4H92f23cWk5z+6Rnyg4VTkRV2vlIGTVF3K3DEMP6zcGDG9Vy/PU3dmLQlj4YHzAkOL
 TtvirCIkpGi1X23YzThGoTsRsZ/ufVzMVZdjCu+Y01+U3g9df6ibVvSVABKIGwUEV8nQPR56y
 sV3bKq2SJfuI5suD6uHVqQgukehTPZ4V2Hm+D4UiBd0eagZHVRJrXW8d4DpaQSKmBcY1JoJ5H
 cyfvblBo5pbEu7HYcsjAzKxPdi6vuopVbgZprpW1J4OGpdrkKMrxgruWawN4n8OoJtgaMqAjS
 DIDFQWj/Gn0NDptu9Q0BUTwxN3qe4wJ+ObdGYT8VbxzIdxHwSMVbxqx8SMq5TwxkaPKDXOyZQ
 QFp8iLfNILYjOEZF/U10VBXRzrsaRjR4+68d/a4OV8i6YsL353LMEM0/iHCyayxGMvxAfkR9L
 66Y8IoKheKfrSoJ65n6lpSex/rOssayg85Ai1peMHVco6WiVbTrczWNWQtwi5NH3sNQGeCDeh
 F6ykUAXl6Cxs9aoLRsh2EGh6fx09VfOzLT5TTEvkPbyt7wiyylAj0EuftsUSTJOgAYe6FeDLY
 fendIsnk4wr3om/bNiCio1+Hxk=

Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:

> Add hwmon single fan sensor reads and control for Ayaneo devices.
> The register and method of access is the same for all devices.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/Kconfig     |   2 +
>   drivers/platform/x86/ayaneo-ec.c | 134 +++++++++++++++++++++++++++++++
>   2 files changed, 136 insertions(+)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ff2678927696..f132a87fcee9 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -319,6 +319,8 @@ config ASUS_TF103C_DOCK
>   config AYANEO_EC
>   	tristate "Ayaneo EC platform control"
>   	depends on X86
> +	depends on ACPI_EC
> +	depends on HWMON
>   	help
>   	  Enables support for the platform EC of Ayaneo devices. This
>   	  includes fan control, fan speed, charge limit, magic
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 90b86527ab0d..9884eed0cc84 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -7,13 +7,23 @@
>    * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
>    */
>  =20
> +#include <linux/acpi.h>
>   #include <linux/dmi.h>
> +#include <linux/hwmon.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>  =20
> +#define AYANEO_PWM_ENABLE_REG	 0x4A
> +#define AYANEO_PWM_REG		 0x4B
> +#define AYANEO_PWM_MODE_AUTO	 0x00
> +#define AYANEO_PWM_MODE_MANUAL	 0x01
> +
> +#define AYANEO_FAN_REG		 0x76
> +
>   struct ayaneo_ec_quirk {
> +	bool has_fan_control;
>   };
>  =20
>   struct ayaneo_ec_platform_data {
> @@ -22,6 +32,7 @@ struct ayaneo_ec_platform_data {
>   };
>  =20
>   static const struct ayaneo_ec_quirk ayaneo3 =3D {
> +	.has_fan_control =3D true,
>   };
>  =20
>   static const struct dmi_system_id dmi_table[] =3D {
> @@ -35,10 +46,126 @@ static const struct dmi_system_id dmi_table[] =3D {
>   	{},
>   };
>  =20
> +/* Callbacks for hwmon interface */
> +static umode_t ayaneo_ec_hwmon_is_visible(const void *drvdata,
> +				       enum hwmon_sensor_types type, u32 attr,
> +				       int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return 0444;
> +	case hwmon_pwm:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types t=
ype,
> +			     u32 attr, int channel, long *val)
> +{
> +	u8 tmp;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			ret =3D ec_read(AYANEO_FAN_REG, &tmp);
> +			if (ret)
> +				return ret;
> +			*val =3D tmp << 8;
> +			ret =3D ec_read(AYANEO_FAN_REG + 1, &tmp);
> +			if (ret)
> +				return ret;
> +			*val +=3D tmp;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			ret =3D ec_read(AYANEO_PWM_REG, &tmp);
> +			if (ret)
> +				return ret;
> +			*val =3D (255 * tmp) / 100;
> +			if (*val < 0 || *val > 255)
> +				return -EINVAL;

I think it would make more sense to first check if tmp has a value between=
 0 and 100 and
then performing the calculation. Also please return -EIO instead of -EINVA=
L.

> +			return 0;
> +		case hwmon_pwm_enable:
> +			ret =3D ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
> +			if (ret)
> +				return ret;
> +			if (tmp =3D=3D AYANEO_PWM_MODE_MANUAL)
> +				*val =3D 1;
> +			else
> +				*val =3D 2;

Please check for AYANEO_PWM_MODE_MANUAL as well and return -EIO if the EC
returned an unknown value.

> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types =
type,
> +			      u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +			switch (val) {
> +			case 1:
> +				return ec_write(AYANEO_PWM_ENABLE_REG,
> +						AYANEO_PWM_MODE_MANUAL);
> +			case 2:
> +				return ec_write(AYANEO_PWM_ENABLE_REG,
> +						AYANEO_PWM_MODE_AUTO);
> +			default:
> +				return -EINVAL;
> +			}
> +		case hwmon_pwm_input:
> +			if (val < 0 || val > 255)
> +				return -EINVAL;
> +			return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops ayaneo_ec_hwmon_ops =3D {
> +	.is_visible =3D ayaneo_ec_hwmon_is_visible,
> +	.read =3D ayaneo_ec_read,
> +	.write =3D ayaneo_ec_write,
> +};
> +
> +static const struct hwmon_channel_info *const ayaneo_ec_sensors[] =3D {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> +	NULL,
> +};
> +
> +static const struct hwmon_chip_info ayaneo_ec_chip_info =3D {
> +	.ops =3D &ayaneo_ec_hwmon_ops,
> +	.info =3D ayaneo_ec_sensors,
> +};
> +
>   static int ayaneo_ec_probe(struct platform_device *pdev)
>   {
>   	const struct dmi_system_id *dmi_entry;
>   	struct ayaneo_ec_platform_data *data;
> +	struct device *hwdev;
>  =20
>   	dmi_entry =3D dmi_first_match(dmi_table);
>   	if (!dmi_entry)
> @@ -52,6 +179,13 @@ static int ayaneo_ec_probe(struct platform_device *p=
dev)
>   	data->quirks =3D dmi_entry->driver_data;
>   	platform_set_drvdata(pdev, data);
>  =20
> +	if (data->quirks->has_fan_control) {
> +		hwdev =3D devm_hwmon_device_register_with_info(
> +			&pdev->dev, "ayaneo_ec", NULL, &ayaneo_ec_chip_info, NULL);

Please run "./scripts/checkpatch.pl --strict" on this file and fix any iss=
ues.

Thanks,
Armin Wolf

> +		if (IS_ERR(hwdev))
> +			return PTR_ERR(hwdev);
> +	}
> +
>   	return 0;
>   }
>  =20

