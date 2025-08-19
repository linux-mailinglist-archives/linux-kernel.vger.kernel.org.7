Return-Path: <linux-kernel+bounces-775040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE09B2BAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE811BC09DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2311F2BE7BE;
	Tue, 19 Aug 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GU+V76tk"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1EC28489E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588042; cv=none; b=XiFtMVlpMV/UA6pR01GEfROeEC/XldeG7K9Nn/cvnF4fCdWm90pSnTXI3Ro2LdPXOjeW7kiFBwoUVfGFZIvoVZL3velTCa1EAruaoU1VrBahYC+7qOKXPgKijbgLTauT9PaSu7N2x4cF9HsjVOURsZBf6q3hGIHYDxP+QaMBZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588042; c=relaxed/simple;
	bh=nvfY0GK2083Ir+nclH0mStfqg39/xjitbuTFa8M/Wxk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=oiJ6zyjhDd+Lj8AV6fIVUAmduZT9q8Gq+2VFCTWB2KSBj7intbrkPhNkFeq3iLXnIZevdLtdsXirpfKuiPfA/uZX6V3HZZIeol7BczRIlbOOZR/WJNhCfZWEjWM3BD1Qn8fgzWs8jT3D7rZW4rk51SLhwplFa25booC2O81ghJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GU+V76tk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b7532f3so8953050a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755588039; x=1756192839; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YDerhS9g1vRICq7Rt5WRYWuEsiOUKiC9gj7unZzIWD0=;
        b=GU+V76tkhIjJjMKT5PxFJSgJzXJB4OjN0rA0krb3RSXk3MACDohfWHFMqDzLSIp+c8
         U2HvzLrl6ZyBXFfPxWVKdRGcjwEhGlm4qTHvqQ0yrA56pvXq9+74M4EZZ59LupsWTkd7
         SndoCpfh1PzDGZQxcchSz8Bnbkt5ytuJlEDN+vlkvg+ZfQykU3ETI8LgG1K88beul3gM
         LOjSUZKBj5b1PLw7idSsCEL4vRrA3sut7s5lCMuIMyqyDrpg9ZeZ0+ceK1Z2+mAgAs99
         GlmYPVyC2XqpyXGlKJLVf2yKu3e1fawgQBAoXTa6+09CMJSj2Z3+4CO+zCPz+q+iTICB
         SusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588039; x=1756192839;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDerhS9g1vRICq7Rt5WRYWuEsiOUKiC9gj7unZzIWD0=;
        b=rbeELzqkOrPb1HWkEnKFkoRinBosvBuZJN7IaGBcj5Sn0MwmvzHWCFmH87x/vebFbj
         bti4us4a3RyKT5p9Cj9W4HjIeErpRt5Fe87L1mSL9gJNLm93ZiGpPdZ2Uu+NwKFfL6Dl
         z6adp2Zm4vu0qBZocV95FfPre5qttHNP8onvXgsKsHhD9aFGfvdP3+Tcjoe0aJh5tfEh
         nqbQk4xDwAAD0IqKxHgU1Yh+SO8yJXt5FAfUl7mrkwvVTlROdvktjtz5Baxb6ky1w5DZ
         e3r+UVhvGuAHsq/8TyGacJ7m8aoM6K241wBXDvqIMUwsEQdi0qawfFmT0nES9nhh2b1R
         My5w==
X-Forwarded-Encrypted: i=1; AJvYcCUmOglO8bhUQ44f1mCZDq1GP+xGuWroRTJ+yu8kIABeluQFNBK2rTc/zdY71Qrt3vjj9Gu9PclrDcy9pA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjmPTo9Xtr30l+65Q/ij4SzFe4RZURWeN8MGJ0lkqxUIy9A8ph
	Xd7YNqprYLlzXEIzMzyXWq6WAI6nVbsFIjPE5RnOhjJgpVOh1+R1T96jALYdQm7lgCI=
X-Gm-Gg: ASbGncs8kpp/ZDvE+RM7uceRcCYpQDVah4M46gOQNRVWNBJ7bYeQnVKO5Uq5Ku1Zt7b
	8JcVlXABiwi/+mFdMiR7bcBwTv4d2/4lMEqbf8FFSlj4JYwQHUpA7IXZmHDHnLNdLvC3xuTE6OY
	KsnT58XZQdkn4qmdKViY6zExr0NTwb2m9bHB0KXM3yr4ljudA3XU22Tt+aWUccu5JGujZDodpdP
	m0ruCYnKqJgw8c14UGHmHfhfArbxp4AESUZuvj5YYFrVZ1URtIwKJD44rswk4PPunrs+r2FHWFE
	d5QpxDUMegihaqDacR8GbrU6YG3fbCLve+lQmFMk86GeJJI1K32VojGWsLYipeN3C6MpmMKJ9mn
	ZQb20P2r4LZfy0Q==
X-Google-Smtp-Source: AGHT+IFTE4hF1AUdRJXz2aI8p4Oj/UQ0e9w4t3Li+mxqyWXJYIk67Rom66979p+Z9BPZkccukwg/lA==
X-Received: by 2002:a05:6402:a0d5:b0:61a:343a:f2f5 with SMTP id 4fb4d7f45d1cf-61a7e748d60mr1118954a12.27.1755588037095;
        Tue, 19 Aug 2025 00:20:37 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a757b9b39sm1199070a12.48.2025.08.19.00.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=5dc0421f1ec0527eb46a4fc47472493a82a4c39419dea34004a893d55dc2;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 19 Aug 2025 09:20:28 +0200
Message-Id: <DC680MA7LMN0.33Q95D1CT5TVK@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, "Simon Horman" <horms@kernel.org>,
 "Vincent MAILHOL" <mailhol.vincent@wanadoo.fr>,
 <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/4] dt-bindings: can: m_can: Add wakeup properties
X-Mailer: aerc 0.20.1
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com> <20250812-topic-mcan-wakeup-source-v6-12-v8-1-6972a810d63b@baylibre.com> <20250813-energetic-hare-of-pizza-6ad6df-mkl@pengutronix.de>
In-Reply-To: <20250813-energetic-hare-of-pizza-6ad6df-mkl@pengutronix.de>

--5dc0421f1ec0527eb46a4fc47472493a82a4c39419dea34004a893d55dc2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Aug 13, 2025 at 9:23 AM CEST, Marc Kleine-Budde wrote:
> On 12.08.2025 11:10:22, Markus Schneider-Pargmann wrote:
>> The pins associated with m_can have to have a special configuration to
>> be able to wakeup the SoC from some system states. This configuration is
>> described in the wakeup pinctrl state while the default state describes
>> the default configuration.
>>=20
>> Also m_can can be a wakeup-source if capable of wakeup.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 22 +++++++++++++++=
+++++++
>>  1 file changed, 22 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml =
b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>> index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..ecba8783198fc1658fcc236d=
8aa3c89d8c90abbd 100644
>> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>> @@ -106,6 +106,22 @@ properties:
>>          maximum: 32
>>      minItems: 1
>> =20
>> +  pinctrl-0:
>> +    description: Default pinctrl state
>> +
>> +  pinctrl-1:
>> +    description: Wakeup pinctrl state
>> +
>> +  pinctrl-names:
>> +    description:
>> +      When present should contain at least "default" describing the def=
ault pin
>> +      states. The second state called "wakeup" describes the pins in th=
eir
>> +      wakeup configuration required to exit sleep states.
>> +    minItems: 1
>> +    items:
>> +      - const: default
>> +      - const: wakeup
>> +
>
> This breaks at least the stm32mp15 SoCs that define a sleep state:
>
> &m_can1 {
> 	resets =3D <&rcc FDCAN_R>;
> 	pinctrl-names =3D "default", "sleep";
> 	pinctrl-0 =3D <&m_can1_pins_b>;
> 	pinctrl-1 =3D <&m_can1_sleep_pins_b>;
> 	status =3D "okay";
> };

I am struggling to find binding documentation that explicitly lists
this sleep pinctrl state. So what is the intended purpose here? Also the
driver does nothing with this at the moment right?

I mean I can also add a sleep state to the binding or just leave the
binding empty so it can be anything, but that feels wrong.

Best
Markus

>
>>    power-domains:
>>      description:
>>        Power domain provider node and an args specifier containing
>> @@ -122,6 +138,12 @@ properties:
>>      minItems: 1
>>      maxItems: 2
>> =20
>> +  wakeup-source:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      List of phandles to system idle states in which mcan can wakeup t=
he system.
>> +
>> +
>
> One newline should be enough.
>
>>  required:
>>    - compatible
>>    - reg
>>=20
>> --=20
>> 2.50.1
>>=20
>>=20
>>=20
>
> Marc


--5dc0421f1ec0527eb46a4fc47472493a82a4c39419dea34004a893d55dc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKQlvBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPN
KQD+Knn1k4Cw2JWSJG551zETnb2ds6letWMDFSx8CJXYB0IBAPB6PazRR/kivR9j
3OLypsfrQyvGmNAZ+Q8n0nQmQyAF
=HKvx
-----END PGP SIGNATURE-----

--5dc0421f1ec0527eb46a4fc47472493a82a4c39419dea34004a893d55dc2--

