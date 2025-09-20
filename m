Return-Path: <linux-kernel+bounces-825887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C3B8D0C2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41A0461FD7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B502C11C3;
	Sat, 20 Sep 2025 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjRtdm5Q"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC62C11EB
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758399755; cv=none; b=RcEz2KnU4OhZWJQ5+gABiHbeqAw321Z0LmAylK5iv1az1o7TutgogHqpZDZbxGRgCvT2LSRSTX1veAoSGn1fyMOe8lNWxX+KoTp2OKR+9OjSElam0ZvwDuhLb73oxAUpiZJtzpec/lpxvgRVcqd6ZpTSbYPyDoAqhvhpqaerfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758399755; c=relaxed/simple;
	bh=Am3FqAor/UTkbjr2Ye8bRp/s+L2cvBen6QV6UQ5vJDE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=p0LWZiLxfJVJKY8/R+EAxnmGQjBvw9GQBjwFslQNy0IKhIifTvJ6sozuNp3lR71a7mSILpS9mhGw9hdgst6hGfZjwCLRmfQVs63ZsKA53KLeH3QynPJGgxw2GKrEbtOG6AJuwRkn/9OhrVS5JpUMkHQ2CNdoRjbL1qkymnksDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjRtdm5Q; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-329b760080fso2537660a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758399754; x=1759004554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oEDh+Wvs/2MhWrMqDGofeZax2aipiW7qS5Up+Qu8dgY=;
        b=CjRtdm5QANpR1A7Vu1tlBf24Iv7p5TWXvsy1q8IFnBj1Q/klm0xEVuiK58/6dYrR3y
         /DsBGbxlEKH9JDE4LnAcPqEnugfH/HWGM0O64whTMiB2cTWN1yimUE2pf4tL0DmWp2FN
         BN8d4pH+zapGrmJMiT+lVv9SMzDIQ2ZM3tfZjTLuGOWjGIWkE+1vLwNJ3HDnubR3+LxG
         PPoePo5H0t5m/jeqaWnpfzIr6CDk+iyqWHJeB5Fpwqfvl/+lmRykl8iuBMjU54rLV7IA
         8LLZo53VHIQSboJeI6/ED65n0ZIxkRbjt8rE9+EoQ98yxUSqGy98J+8JyPJfOo0UlcTi
         cwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758399754; x=1759004554;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEDh+Wvs/2MhWrMqDGofeZax2aipiW7qS5Up+Qu8dgY=;
        b=ZGSFy9EfHNgjUBg611ZiCs+PWl/pE4zwBkuPLVFzA1iXOwFaz6RF70Kdf1iEyXKXsU
         k0CTrVLQw/0F/B8yE7ebXC690CDE6IlsSoblvfFWwgn81MgMUm7/2SWszeJ6O8RqN8+N
         RjhMIz0ojaNgC2L7FB7m8kx2bHLHTbuAtPpPYVvQ4+NimtmsmbfgfWhR9GBJQzCMQwcZ
         fDhkEzCjI+1Qkmc/2nDTLq07eZJzN938pxQF2xVftzCzSl6VMzL3aIT98v58fcmwZxrO
         538SXiFAH0kkK9KRD4CWa6K76sqKlwnmoNkmadLke2fdpGCJCq7kiQeOIf+MXv1R/kxE
         xN1A==
X-Forwarded-Encrypted: i=1; AJvYcCVFxuSsUY/KuRfEFHg3+oIr1VeIK6ofw9/IN74at/r365fu3J1lC1CbXhgk52y16GoxXiMR085iqnknnVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cXwnEoyTXb6YZlfz94mGPRw50a+Z+xr4GIbtOUQG+qazXca/
	FKfovySIKSCu/oMu5PHNYyVU6ieCQQD7jcZAWXaHlwWdptviYP6JyVwy
X-Gm-Gg: ASbGnctt7YZmZhm9Ds7hOdPqkoCSc3usC612/ixKYHZN54N0B+sJD14X+hrwLxDo0Ic
	Tu1HEkPlZ5rl3csRTgQVpzCxZzbj0z6gsDCXwsJ6nGyHDdiV7+K7itZHzbg4xx+zxZKHuYb8/lx
	JKQQt0BcEnYgYBGMUcT75jfOyp0CXgaYKML1MG3NDrtSa4R3Zqc3MbK9aQVuFxWaGoMoMqI0zsP
	b9sYggr1lDv7q8JnquQbgePfjrMWRnOY3ItBzjusMbnIz81bLjNd+VLObG4n8/9B3OJmJOoNIqu
	eeryUnKHB+T1lGAKaA/gkXx9riM8aIKF8042bTRj4i/MOLLg6yLQe1CBKgv6UgQS0uoJYNGu7i5
	cg8aRvkt+pCoj2mJn8U5cyaL4091ba2WBybhe53HQ8YE=
X-Google-Smtp-Source: AGHT+IG3D81KvO3jDKAMB7j9mZS/RFnD2xJducLybPfAPsNEHFakSNlx4mse/NO+LH4HnBqVFQfMJg==
X-Received: by 2002:a17:90b:2c8f:b0:32e:96b1:fb70 with SMTP id 98e67ed59e1d1-33098004a50mr9769248a91.12.1758399753726;
        Sat, 20 Sep 2025 13:22:33 -0700 (PDT)
Received: from ehlo.thunderbird.net ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3309c81f50bsm5417043a91.23.2025.09.20.13.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 13:22:33 -0700 (PDT)
Date: Sat, 20 Sep 2025 17:22:28 -0300
From: =?ISO-8859-1?Q?Eric_Gon=E7alves?= <ghatto404@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: qcom: r0q: add gpio keys
User-Agent: Thunderbird for Android
In-Reply-To: <r6e23h4nkddktkle5rohdiiqkw667rq26j7u2yodao6p3scixp@y3roqbly4oje>
References: <20250920014637.38175-1-ghatto404@gmail.com> <20250920014637.38175-2-ghatto404@gmail.com> <qiiuezocvxvj5bhrr77v6o2amaaaepdx54pqoewvhtnxce5ccz@g7bhkrb6a4pd> <5436E420-E459-4E47-9752-EF80F550FA6F@gmail.com> <r6e23h4nkddktkle5rohdiiqkw667rq26j7u2yodao6p3scixp@y3roqbly4oje>
Message-ID: <B58EE981-3702-4FA3-B150-A3C862643870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 20, 2025 5:15:41 PM GMT-03:00, Dmitry Baryshkov <dmitry=2Ebar=
yshkov@oss=2Equalcomm=2Ecom> wrote:
>On Sat, Sep 20, 2025 at 03:02:42PM -0300, Eric Gon=C3=A7alves wrote:
>>=20
>>=20
>> On September 20, 2025 12:45:27 PM GMT-03:00, Dmitry Baryshkov <dmitry=
=2Ebaryshkov@oss=2Equalcomm=2Ecom> wrote:
>> >On Sat, Sep 20, 2025 at 01:46:33AM +0000, Eric Gon=C3=A7alves wrote:
>> >> Add GPIO keys support to Samsung Galaxy S22 (r0q)=2E
>> >>=20
>> >> Signed-off-by: Eric Gon=C3=A7alves <ghatto404@gmail=2Ecom>
>> >> ---
>> >>  =2E=2E=2E/boot/dts/qcom/sm8450-samsung-r0q=2Edts      | 53 ++++++++=
+++++++----
>> >>  1 file changed, 44 insertions(+), 9 deletions(-)
>> >>=20
>> >> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts b/arc=
h/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts
>> >> index 880d74ae6032=2E=2E70e953824996 100644
>> >> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts
>> >> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts
>> >> @@ -2,11 +2,12 @@
>> >> =20
>> >>  /dts-v1/;
>> >> =20
>> >> +#include <dt-bindings/input/linux-event-codes=2Eh>
>> >>  #include <dt-bindings/regulator/qcom,rpmh-regulator=2Eh>
>> >> -
>> >>  #include "sm8450=2Edtsi"
>> >>  #include "pm8350=2Edtsi"
>> >>  #include "pm8350c=2Edtsi"
>> >> +#include "pmk8350=2Edtsi"
>> >> =20
>> >>  / {
>> >>  	model =3D "Samsung Galaxy S22 5G";
>> >> @@ -28,13 +29,19 @@ framebuffer: framebuffer@b8000000 {
>> >>  		};
>> >>  	};
>> >> =20
>> >> -	vph_pwr: regulator-vph-pwr {
>> >> -		compatible =3D "regulator-fixed";
>> >> -		regulator-name =3D "vph_pwr";
>> >> -		regulator-min-microvolt =3D <3700000>;
>> >> -		regulator-max-microvolt =3D <3700000>;
>> >> -		regulator-always-on;
>> >> -		regulator-boot-on;
>> >
>> >Please don't mix up refactorings and new features=2E Split this patch =
into
>> >several=2E
>> The patch only added gpio-keys node and pon_resin,
>> pon_pwrkey=2E Do you mean I have to split each button
>> into separate patches?
>
>No=2E The patch also moves regulator-vph-pwr and changes the comment in
>the TLMM node=2E
>
I thought they would be too small to be
patches on their own=2E Is it okay if I split
them into 2: arm64: dts: qcom: r0q: small refactor
and arm64: dts: qcom: r0q: add gpio keys?
>> >
>> >> +	gpio-keys {
>> >> +		compatible =3D "gpio-keys";
>> >> +		autorepeat;
>> >> +
>> >> +		pinctrl-0 =3D <&vol_up_n>;
>> >> +		pinctrl-names =3D "default";
>> >> +
>> >> +		key-vol-up {
>> >> +			label =3D "Volume Up";
>> >> +			linux,code =3D <KEY_VOLUMEUP>;
>> >> +			gpios =3D <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
>> >> +			debounce-interval =3D <15>;
>> >> +		};
>> >>  	};
>> >> =20
>> >>  	reserved-memory {
>> >> @@ -47,6 +54,15 @@ splash-region@b8000000 {
>> >>  			no-map;
>> >>  		};
>> >>  	};
>> >> +
>> >> +	vph_pwr: regulator-vph-pwr {
>> >> +		compatible =3D "regulator-fixed";
>> >> +		regulator-name =3D "vph_pwr";
>> >> +		regulator-min-microvolt =3D <3700000>;
>> >> +		regulator-max-microvolt =3D <3700000>;
>> >> +		regulator-always-on;
>> >> +		regulator-boot-on;
>> >> +	};
>> >>  };
>> >> =20
>> >>  &apps_rsc {
>> >> @@ -119,8 +135,27 @@ vreg_l1c_1p8: ldo1 {
>> >>  	};
>> >>  };
>> >> =20
>> >> +&pm8350_gpios {
>> >> +	vol_up_n: vol-up-n-state {
>> >> +		pins =3D "gpio6";
>> >> +		function =3D "normal";
>> >> +		power-source =3D <1>;
>> >> +		input-enable;
>> >> +	};
>> >> +};
>> >> +
>> >> +&pon_pwrkey {
>> >> +	status =3D "okay";
>> >> +};
>> >> +
>> >> +&pon_resin {
>> >> +	linux,code =3D <KEY_VOLUMEDOWN>;
>> >> +
>> >> +	status =3D "okay";
>> >> +};
>> >> +
>> >>  &tlmm {
>> >> -	gpio-reserved-ranges =3D <36 4>; /* SPI (not linked to anything) *=
/
>> >> +	gpio-reserved-ranges =3D <36 4>; /* SPI (Unused) */
>> >>  };
>> >> =20
>> >>  &usb_1 {
>> >> --=20
>> >> 2=2E51=2E0
>> >>=20
>> >
>> Resend because I forgot to CC the mailing lists
>

