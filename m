Return-Path: <linux-kernel+bounces-830243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1667CB992E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F82D2E76EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FA12D837C;
	Wed, 24 Sep 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iNbL4DyD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6923C516
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706577; cv=none; b=kUylm+rp1hlav/ACzZu02SFmhwqxOjeej1J5Xg4ksKANDrH71Qx6IQpNI2Jtyiz2DG8ymlQ5PcqqZBk/uhjPzRuEt2V64VjyDuuoTto775JL12/dIbVr0M2VKde7dLnne3/YA/2B0ccFVtDmxD+0yIAX79oRli0v7xMU4djXASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706577; c=relaxed/simple;
	bh=ZPS5vkPDC0Z1dLXwG4FwSnQiGQrzsW4kSKnPvivEQWE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UkVo5twrjRuXBz5WbTuxFM/TKjYI71mG7zQ45fFv6nbgMeXB2+tHbeK0WkDgDAdp8wAE7Y7/Qgr/jJAVWOtgdqB463maYKCIwVGDAFsfvOErjcMXaGuDlSUJtm5VK/IEt4+zX0gZZ4GIEA0wYBmAYRmYiiWeyoTP/FLOoDjcl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iNbL4DyD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so10558181a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758706569; x=1759311369; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5Q6p/KiNHqv49UA1SnTb+Yaprb1pd/5n2oQ6uG61w0=;
        b=iNbL4DyD49Ce/I47kjnhiUV0CwUsrV6oxWEVgd05Vo+07/K28XVtvKZ6ABD3hRPM0F
         vbBbpOtPUtPOEH67q/T1cmXASzHYLsHC9F+42IWta9adzrcIzrTj6xdCZl1Pqg0+v/DW
         Wq/L9AS3q8X4viuWH95UzxvAeiw4Psg0dh3i3JqsZmii3zv3XvglqYLLqt+GihXxGaPb
         oTPYvIXdI0DVCaI5Jv3b//D9c/xaAPaBH98iWwn783cackdHrjKKWYUbtmlLilGyTRDJ
         sJlKOrM+qScnqQDcESF+r4338czrGbZodKz3fdEfZX3Xlxh5LvsVhHxL3a5t3wcMhp6Q
         jawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758706569; x=1759311369;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5Q6p/KiNHqv49UA1SnTb+Yaprb1pd/5n2oQ6uG61w0=;
        b=Ao25CNVqQrRG1p+S7xtrTZ3hHLJER2MY9j41ApcLaseplTujdu1Bv/aaJgA321jPoA
         CpMOnWSMlgARyZtiC/GCfMzVunOLTQ9Ul3rtwP1crQ1dw7OuHFLv1fq6uQylGPsROUlA
         TBv3mJwI8KX/88YdJhVgVYwXo6njlbN093sRgsFZbNkQEoBHl58tnPHrERcL1uUcPxQy
         cTZ3ZonaQJ0F5wv6aXjycWCZOWO96RRI+2UvTnJ5NpRpUTn/pXl4nxD5KZ7og0hgPaOh
         YA6gSQvq3W8KiY5xr7bb7VzwwsqrRMB3NVMhRY7byhQ7Fv0PKPwSPBKZ8yBPWI0DZGQu
         YneQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTWzhNTuW++VQRAaq8BLoGTipbzOxSbC9zIfCYf2Onuc8P6HZ+F04baQPHhiXr6tM0oFCeHbRefGF/1/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PhT8SyUxHYfLMSYP8I7aOg/i48/J5kz6wTn/NTgH0bK2Ozov
	9CQptvt3RidWCHop/pu2HLkjQhQWDhqW4QyE0swCIfLLIRkMyjbG8O9yil315f2IIlo=
X-Gm-Gg: ASbGnctDJnWOL+6xDu2+UzpiExAhI/zCYfnP23pLo2rac/jfbMZ0guJ8AGi778zaMQN
	yU1ME5y/G0JCtZ4DLfm4UgW9/Mc9xSUf2Op2cJeUX6TLTKo9p5/oi7bCr8yY/UWUVe9BCJ/Azz3
	Zun9MHCjEBrkakn26rPQ8aNMu5bfQ3HiTSiDsPfAOiQvDaCmfurvzrptruRuwNYe0+qIYlugnQ7
	3RnXXNVoQShJnviYJf90izfWy16oYqyJY1h9DHLVtbceTdzg9n6JAgIBh4OrloskaTD5obHGBaB
	x5hzUMFxA002JEHJG7RS9raY9X9eIaCzH7DQAU0pDfhGjui6sVxV4GG66COgRxtm1ixjsuX4ZR4
	gYfRKDSUorZmZv5Q=
X-Google-Smtp-Source: AGHT+IFrVuMeV3DxBIcNMAPLjIp8Ym4ceTLMZRcoC30nbyeaEZUcstVPsEO8E6Kunah/gyUeusxbdw==
X-Received: by 2002:a17:907:94d1:b0:b0f:29f3:94f7 with SMTP id a640c23a62f3a-b3020c37aaemr508846066b.0.1758706569095;
        Wed, 24 Sep 2025 02:36:09 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5f14e64sm12481067a12.25.2025.09.24.02.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f7cc4d2a582e78fc50c0277a2c40522eee0e153b07f7e60887709f76b82e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 24 Sep 2025 11:36:00 +0200
Message-Id: <DD0XG03P3KDH.5763ZFCO92H0@baylibre.com>
Cc: "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Tero Kristo" <kristo@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vishal
 Mahaveer" <vishalm@ti.com>, "Kevin Hilman" <khilman@baylibre.com>, "Dhruva
 Gole" <d-gole@ti.com>, "Sebin Francis" <sebin.francis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: ti: k3-am62p5-sk: Set wakeup-source
 system-states
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com> <20250812-topic-am62-dt-partialio-v6-15-v2-7-25352364a0ac@baylibre.com> <20250923182450.5rqwz2pkn2gjt2vh@uda0506412>
In-Reply-To: <20250923182450.5rqwz2pkn2gjt2vh@uda0506412>

--f7cc4d2a582e78fc50c0277a2c40522eee0e153b07f7e60887709f76b82e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kendall,

On Tue Sep 23, 2025 at 8:24 PM CEST, Kendall Willis wrote:
> On 11:15-20250812, Markus Schneider-Pargmann wrote:
>> The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
>> powered during Partial-IO and IO+DDR and are capable of waking up the
>> system in these states. Specify the states in which these units can do a
>> wakeup on this board.
>>=20
>
> nit: s/"IO+DD"/"I/O Only + DDR"
>
>> Note that the UARTs are not capable of wakeup in Partial-IO because of
>> of a UART mux on the board not being powered during Partial-IO.
>>=20
>> Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
>> Partial-IO. Add these as wakeup pinctrl entries for both devices.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>=20
>> - Merge devicetree nodes in k3-am62p5-sk.dts
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 71 ++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 71 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/d=
ts/ti/k3-am62p5-sk.dts
>> index 899da7896563b43021de14eda1b0058a5c6d36da..a2dffb5e243f543c90081eea=
cdc0758b38bd0eb9 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> @@ -762,12 +762,52 @@ AM62PX_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKU=
P_UART0_TXD */
>>  		>;
>>  		bootph-all;
>>  	};
>> +
>> +	mcu_mcan0_tx_pins_default: mcu-mcan0-tx-default-pins {
>> +		pinctrl-single,pins =3D <
>> +			AM62X_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
>> +		>;
>> +	};
>> +
>> +	mcu_mcan0_rx_pins_default: mcu-mcan0-rx-default-pins {
>> +		pinctrl-single,pins =3D <
>> +			AM62X_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
>> +		>;
>> +	};
>> +
>> +	mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-wakeup-pins {
>> +		pinctrl-single,pins =3D <
>> +			AM62X_IOPAD(0x038, PIN_INPUT | WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
>> +		>;
>> +	};
>> +
>> +	mcu_mcan1_tx_pins_default: mcu-mcan1-tx-default-pins {
>> +		pinctrl-single,pins =3D <
>> +			AM62X_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
>> +		>;
>> +	};
>> +
>> +	mcu_mcan1_rx_pins_default: mcu-mcan1-rx-default-pins {
>> +		pinctrl-single,pins =3D <
>> +			AM62X_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
>> +		>;
>> +	};
>> +
>> +	mcu_mcan1_rx_pins_wakeup: mcu-mcan1-rx-wakeup-pins {
>> +		pinctrl-single,pins =3D <
>> +			AM62X_IOPAD(0x040, PIN_INPUT | WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
>> +		>;
>> +	};
>>  };
>>=20
>
> AM62PX_MCU_IOPAD should be used for consistency.

Thanks for your reviews, everything fixed for the next version.

Best
Markus

--f7cc4d2a582e78fc50c0277a2c40522eee0e153b07f7e60887709f76b82e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaNO7gBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMl
JgEA/mISSoRZhk6VfAJFaK9lIaKSXc+xnPgUPVfC4DEzh/UBANaYGyPZmqpr68a/
lc3eBY0abnF1USiw+jz0CqS7BpgA
=evl8
-----END PGP SIGNATURE-----

--f7cc4d2a582e78fc50c0277a2c40522eee0e153b07f7e60887709f76b82e--

