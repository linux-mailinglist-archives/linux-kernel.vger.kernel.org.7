Return-Path: <linux-kernel+bounces-807520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257C4B4A581
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C653A74F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308DC25228B;
	Tue,  9 Sep 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qV0h+0sf"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842FD2472B1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407077; cv=none; b=HC6T+iK8i/5RPV4yXbzBdrWhrXXkPWntvypG+B7eWvqqnMpuBGV67+ZxvQEPbgUX+UXCQ2U19hGXw7OtRM+VTlbXUmgdxC+F31RgI7H+spGYCHc1l4x58BH+8LYdZWaceg4gfMwgO9dM1CtxbzpjzNr8+biNQm69osOTKpOMjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407077; c=relaxed/simple;
	bh=0D9zPGqjWWZl+QOHnnAWgsHVUD2gzmiemRgdPYNgRh0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mutm0XYO6U0wPv9LfMbtsNMlbz74LIn+seAGgL8Lyv6NkFleaQv8gis96UlX5LqGxQ6HmTrcD8hBlZge1SPRGmnkxh4v/ZdXpSpzyJ3oEMh6IU0KQHPsgmdWCyvAs21+BUcUDaomooMClSWrPjAM8aa22VB4WkEyZLTpYWrPNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qV0h+0sf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so47141025e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757407074; x=1758011874; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPzxhl5A2vCjE+tX3cc2Xu+QNXbQb+GYtT6YGGU4Vz8=;
        b=qV0h+0sfUEjDWEfPIqWiA1jJZIOcEBEA+7FwY+xuz8sfqRU5aPNKsaeX2XCpl0Jk6Z
         DMQ+iv1WBS75ZwueLQzhwJyu/BwLmC/+fo71DNRwGDaTnvvsTule1+KCqM8Li+ZxAjvI
         3J3wjfHMJ9vp7END0UfaeuZ5Mf586WAkOfJAyrSc1HPjhPM/cnA5uZwS+skh434f18dA
         AGd1qI5EKgBe2HzyeMgTCxoM89Kg9whpxeoXw65LMBG/I2tkqDAmgX2ZbnSrXq7YIYlL
         9QVd/NiRQTUoZQEtm5Jt8ukFLBrJumwSBH47BQAY8ZbZvrb/KUbd6+HugHM4D2QY5gFB
         T0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407074; x=1758011874;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPzxhl5A2vCjE+tX3cc2Xu+QNXbQb+GYtT6YGGU4Vz8=;
        b=S0ZuHqAy6ugl1AIgQTVNdppaBhEZnRJa9IwTmHdPJQxdp3DFBoF3qYLDRLDvchUbWu
         Tr+r+XyBMi9I1RYc1sq01GjZm7+XI5AfKd2FZkVxp7jWHOyFji7JR4Laupw3oOMAdf2O
         Nz7fjDwSszzk6RCJw6y4a4UtWJI763KlxrUcXWWK+zeBhYs6sHBQrrUYcBcvqOD3jbgj
         T6ZZyrTUIJy6bWOgV+3VKwjAa8Ns5xwP07elCLZAjXpYQ8TMBMTCcB08b8TbHrLlZ7AR
         uoGlqY0QtldAvAFt1OfIUwtpEGJejdh2FiXwe87T79eQc9/6UrFoADPHLxWxcdi3PM2Z
         FrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSELu56wHQCEUJRov+lnIMjN3gwQJNQKdeW8FGVBx2Intwo+wXjGj+9pRHS37pPiKBzSV5KPCYIisnEVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGm5kV/1fMLWIh8J5LXTd0kH6+9Cmav/PppLo6oXT/lsToWBVz
	B8bD84g9dkDewy43s7u5zBX9HoBu1KKXuXkR8p2lH7Odzy0TF6HU+PXd1mt+7MXdpsA=
X-Gm-Gg: ASbGncueLhz/vrsLBK6o9NkugagR19nv0MSYAPG9wp7GaDc0SOy9SyWLeOmk6NryaQ0
	eYfjzGlt8ps/3/NAwYyMuGcDwXUTZPI5psRat2p+aWtaBTuDIvow1VCgPxBjYHRPhuv7XzGYYCf
	0tumQc+KpxazNEqZhYu63jRE+RkvQPf2E4WLtCmgXcP8iaOBkYMpN8FUOVB3LK6EHSExlUX4XzR
	ILEtuvutjc4qGNbEzBLjdMUsvKJ2VwJzvk+wKxUb1Vdbln+FrMsbGcHnXVA7xopgRCKdOb6p33p
	f4CZB8N+/u5rgz/ki9TknGd4Va2wU+RZYidGujqUucXx9GCj0y4ng2YXNzjp0pu8LeIEfQ1GVcM
	X71DiQB6DauumRO9QOK3i8Bpfqg==
X-Google-Smtp-Source: AGHT+IGFY+CbQVY2RNO5FrloUQSNGkLpTLZZd3Iw5vqTDy31kdS591iFBn0tWIOYy70yOYW8CLpAlg==
X-Received: by 2002:a05:6000:2385:b0:3ca:a70d:5710 with SMTP id ffacd0b85a97d-3e64bedfe82mr7375351f8f.41.1757407073557;
        Tue, 09 Sep 2025 01:37:53 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7521ca1c1sm1728849f8f.24.2025.09.09.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4856b23f253d4ec58fd417d6be2d91cf025155c02cab64c8d8f827067e17;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 09 Sep 2025 10:37:47 +0200
Message-Id: <DCO4T9E3SGQ5.1J2ARMXFB9ONJ@baylibre.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62x-sk-common: Enable Main
 UART wakeup
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Kendall Willis"
 <k-willis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <khilman@baylibre.com>, <a-kaur@ti.com>
X-Mailer: aerc 0.20.1
References: <20250904212827.3730314-1-k-willis@ti.com>
 <20250904212827.3730314-2-k-willis@ti.com>
 <DCO4RGJBMTRM.1XNHG5EHBPS24@baylibre.com>
In-Reply-To: <DCO4RGJBMTRM.1XNHG5EHBPS24@baylibre.com>

--4856b23f253d4ec58fd417d6be2d91cf025155c02cab64c8d8f827067e17
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 9, 2025 at 10:35 AM CEST, Markus Schneider-Pargmann wrote:
> On Thu Sep 4, 2025 at 11:28 PM CEST, Kendall Willis wrote:
>> The Main UART can resume from suspend to RAM states when PIN_WKUP_EN
>> is enabled. Add the necessary pins needed to wakeup the system. Add the
>> system idle states that the Main UART can wakeup the system from.
>>
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 +++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64=
/boot/dts/ti/k3-am62x-sk-common.dtsi
>> index 13e1d36123d51..72801cf890d20 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> @@ -163,14 +163,26 @@ &phy_gmii_sel {
>> =20
>>  &main_pmx0 {
>>  	/* First pad number is ALW package and second is AMC package */
>> -	main_uart0_pins_default: main-uart0-default-pins {
>> +	main_uart0_tx_pins_default: main-uart0-tx-default-pins {
>>  		bootph-all;
>>  		pinctrl-single,pins =3D <
>> -			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
>>  			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
>>  		>;
>>  	};
>> =20
>> +	main_uart0_rx_pins_default: main-uart0-rx-default-pins {
>> +		bootph-all;
>> +		pinctrl-single,pins =3D <
>> +			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
>> +		>;
>> +	};
>> +
>> +	main_uart0_rx_pins_wakeup: main-uart0-rx-wakeup-pins {
>> +		pinctrl-single,pins =3D <
>> +			AM62X_IOPAD(0x1c8, PIN_INPUT | PIN_WKUP_EN, 0) /* (D14/A13) UART0_RX=
D */
>> +		>;
>> +	};
>> +
>>  	main_uart1_pins_default: main-uart1-default-pins {
>>  		bootph-pre-ram;
>>  		pinctrl-single,pins =3D <
>> @@ -342,8 +354,12 @@ &wkup_uart0 {
>>  &main_uart0 {
>>  	bootph-all;
>>  	status =3D "okay";
>> -	pinctrl-names =3D "default";
>> -	pinctrl-0 =3D <&main_uart0_pins_default>;
>> +	pinctrl-names =3D "default", "wakeup";
>
> I think you may need to add this to the DT binding of the uart device
> as well.

Nevermind, I just saw your other series, can you please mention the
other series as a dependency in the cover letter?

>
> Best
> Markus
>
>> +	pinctrl-0 =3D <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_defa=
ult>;
>> +	pinctrl-1 =3D <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_wake=
up>;
>> +	wakeup-source =3D <&system_deep_sleep>,
>> +			<&system_mcu_only>,
>> +			<&system_standby>;
>>  };
>> =20
>>  &main_uart1 {


--4856b23f253d4ec58fd417d6be2d91cf025155c02cab64c8d8f827067e17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaL/nWxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMC
ggD+KJ4+mIFOxqZ/OOfUILmagchKuJNiUOwdInV0goSql4sBAJYAIM5L0vr0Eqqo
w1Qatmm1+IfunotaRO+Sd8q8eUUB
=1rxv
-----END PGP SIGNATURE-----

--4856b23f253d4ec58fd417d6be2d91cf025155c02cab64c8d8f827067e17--

