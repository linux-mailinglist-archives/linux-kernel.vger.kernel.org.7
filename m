Return-Path: <linux-kernel+bounces-775050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9CB2BAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272F23AB1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E9F27FB2A;
	Tue, 19 Aug 2025 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qzjFMNPw"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF01204C1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588558; cv=none; b=NetgvYmGwNHh1PS0eOT46AnLVK7IiSorr2++qu59TSaINF2fHbg5+DLWybV5S0RgmXyhG4aLTNGfQKEq++lAaH8OQyzWv3ZQaOuH8mA95lzwfWQUsM8XIbxiEhjntu7Yify91oA+WzUII8rrBgxL/tqNrVZ6DXnVtnA7xCDDzKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588558; c=relaxed/simple;
	bh=m1aYf3xZAZVvz4CxnxX2rny5oQi/QetklYuiYkrwR7I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=SzdVRSH98YH5dmFGlXqTP7mPIbIvtHl2BvzAtTUt7+MW43uJM8u/CWSBj9oyLv+QX+GBk5JX+Xue0qg5rbLU+WDhh35LXEEEKxXTF1cVjcaXk8zsBKtahWsMPoOLVrfnRnkfWWt8fC/sHcWzOBNRkEisULcqqZwiGh/7vTS25jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qzjFMNPw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so7517681a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755588555; x=1756193355; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9ZFTd8tc9t9Q9OjuU9qYv3SoRwzk7BH/sXXxyKX4kU=;
        b=qzjFMNPwXMk3Baem+MODxVSu5zgC9JTBI95bCL8lP6qv53TemneQBGUzYw/+Pg+irv
         css65pnCr77eZwVQ0FLq7bT67GgNsoBKdj3GwReLKFUpHcntBOhXQRcaYY3f0zZwXqUn
         cGzWv4NXaakj6dAGkMauEINTs8hO7W8iw0uo3csRXd3sfSXcIISELbj7fd554hH4oU+X
         aHnq4Q3rGhXH9kdZAudwKSFXqC7DBSBivP2BkFjqNjn7wXTKKCmFXHLP/xwb8RgzQRMM
         56Z8Loizxbt+SDHMjdX7+ZpGCwnDNwXQcfPRi+xItqKI3HQ4i8lkS9xLwkKNvIfqQvTo
         UTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588555; x=1756193355;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9ZFTd8tc9t9Q9OjuU9qYv3SoRwzk7BH/sXXxyKX4kU=;
        b=s5ZKItZ+zSn2o7t+lITFAM/AGEUS11OEOPqJISwgpLk3to3TImso4eRCxSqpIeZrrl
         zBqGz3sbY0/xIKULy9rJXhjFUk/TVMJZ9TIvjmzfcPV+eEYd+C3EMPraSLyM8nI7EOYY
         0k+Iyuwb2pwaAqMaBkVnP4SwU01jaXqyjqSPvr9wa2Uliz5cT15gCRRsBtxiZyUheeRV
         pibzdKk2/L+k4WRt2tk9iPA/S5aae+L0cuIA3IamSxDMq6U7IMUwKt66hqyj3ODH2hn2
         MjbFy+eMhFCQFdiPACGRXLQSU334xPm3LPAsAO4qg4LyXHpIZzYxQrPP0b+OEliOLFdw
         0QMw==
X-Forwarded-Encrypted: i=1; AJvYcCWRxpHf5dik0LxEOxsPt7vSQPG33zwq8y2riB/ilzO2wiZ7UA6aZBaRyYQ9HSwxZZXeUjlwoeAkvouU3Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WEJ4AXfq/Nv8bgWr9L8MiCdkok3dz3rTJw7hBlbdWZWALIbd
	aTTcGx//FwvJVposyzTy8mL69wJjhnjzcJTqLrzZwvmOlg9v4bUhWz/GuNeTsEdcNh0=
X-Gm-Gg: ASbGncvCT8ZoGLjII93z0iU22xN79L0h/YhZe48BXPPzufOuBsRqUk8BOAMszwHdOyJ
	Sv1MogO1wrlwwyt68mcpPWej7U/o1a/u3tYMlLJsfeyYus1+CBhBuHd7z3AXBiVuIPe7ppMlZ+b
	HRkqBGCnCe6eut9o6Tv32jb/vSbOaGr0a2QydvPnA6U8V+NeHHQTxfrou1R6dp5mwAXo6nBYNs+
	9+dsSjkFJ4PxIwajNjyrMvrrY8s0sOwYoghPCBEUDFOGvx+z3/1yls2N7wlfJV2VEk08CW4GTqm
	lt1/OJo2JWPNjNkl94iXvfdHJQ5AOzPa+WltyPWF/WD91rpoQdl6yGHPFc7Wq8egRcbW4IpWdWe
	XunkA2qvLrLDTaA==
X-Google-Smtp-Source: AGHT+IE9wLYwAW2XtUVFFG4Q3+Y1T5+7hm1Q9Ud5QfsQac1N+Q9TsAULmLjg/st6avEy4koFeXHX4A==
X-Received: by 2002:a05:6402:440a:b0:608:f493:871c with SMTP id 4fb4d7f45d1cf-61a7e6e082fmr1337394a12.14.1755588554037;
        Tue, 19 Aug 2025 00:29:14 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a755d9d26sm1201899a12.10.2025.08.19.00.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e73662955d5075bedea110cf04232664a8d147c373d1a0aa2f0fc2ec91d6;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 19 Aug 2025 09:29:02 +0200
Message-Id: <DC6876NJBA2V.3OEXXYEA6Z9TK@baylibre.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: can: m_can: Add wakeup properties
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>
Cc: "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, "Simon Horman" <horms@kernel.org>,
 "Vincent MAILHOL" <mailhol.vincent@wanadoo.fr>,
 <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com> <20250812-topic-mcan-wakeup-source-v6-12-v8-1-6972a810d63b@baylibre.com> <20250813-energetic-hare-of-pizza-6ad6df-mkl@pengutronix.de> <DC680MA7LMN0.33Q95D1CT5TVK@baylibre.com>
In-Reply-To: <DC680MA7LMN0.33Q95D1CT5TVK@baylibre.com>

--e73662955d5075bedea110cf04232664a8d147c373d1a0aa2f0fc2ec91d6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Aug 19, 2025 at 9:20 AM CEST, Markus Schneider-Pargmann wrote:
> Hi,
>
> On Wed Aug 13, 2025 at 9:23 AM CEST, Marc Kleine-Budde wrote:
>> On 12.08.2025 11:10:22, Markus Schneider-Pargmann wrote:
>>> The pins associated with m_can have to have a special configuration to
>>> be able to wakeup the SoC from some system states. This configuration i=
s
>>> described in the wakeup pinctrl state while the default state describes
>>> the default configuration.
>>>=20
>>> Also m_can can be a wakeup-source if capable of wakeup.
>>>=20
>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>> ---
>>>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 22 ++++++++++++++=
++++++++
>>>  1 file changed, 22 insertions(+)
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml=
 b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..ecba8783198fc1658fcc236=
d8aa3c89d8c90abbd 100644
>>> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> @@ -106,6 +106,22 @@ properties:
>>>          maximum: 32
>>>      minItems: 1
>>> =20
>>> +  pinctrl-0:
>>> +    description: Default pinctrl state
>>> +
>>> +  pinctrl-1:
>>> +    description: Wakeup pinctrl state
>>> +
>>> +  pinctrl-names:
>>> +    description:
>>> +      When present should contain at least "default" describing the de=
fault pin
>>> +      states. The second state called "wakeup" describes the pins in t=
heir
>>> +      wakeup configuration required to exit sleep states.
>>> +    minItems: 1
>>> +    items:
>>> +      - const: default
>>> +      - const: wakeup
>>> +
>>
>> This breaks at least the stm32mp15 SoCs that define a sleep state:
>>
>> &m_can1 {
>> 	resets =3D <&rcc FDCAN_R>;
>> 	pinctrl-names =3D "default", "sleep";
>> 	pinctrl-0 =3D <&m_can1_pins_b>;
>> 	pinctrl-1 =3D <&m_can1_sleep_pins_b>;
>> 	status =3D "okay";
>> };
>
> I am struggling to find binding documentation that explicitly lists
> this sleep pinctrl state. So what is the intended purpose here? Also the
> driver does nothing with this at the moment right?
>
> I mean I can also add a sleep state to the binding or just leave the
> binding empty so it can be anything, but that feels wrong.

Sorry, I missed the sleep use in the driver, will add it to the binding. I =
am
wondering why it wasn't in the binding before.

Thanks!

Best
Markus

>
> Best
> Markus
>
>>
>>>    power-domains:
>>>      description:
>>>        Power domain provider node and an args specifier containing
>>> @@ -122,6 +138,12 @@ properties:
>>>      minItems: 1
>>>      maxItems: 2
>>> =20
>>> +  wakeup-source:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description:
>>> +      List of phandles to system idle states in which mcan can wakeup =
the system.
>>> +
>>> +
>>
>> One newline should be enough.
>>
>>>  required:
>>>    - compatible
>>>    - reg
>>>=20
>>> --=20
>>> 2.50.1
>>>=20
>>>=20
>>>=20
>>
>> Marc


--e73662955d5075bedea110cf04232664a8d147c373d1a0aa2f0fc2ec91d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKQnvxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPP
rAEAix0I/gCgDfYKzMJnmHATT2WVT1En56x9X5XEKWTKVuEBAMYebehnEGgV7WUd
4T8g6EWORqZoNeTDer5yG3A2eCEI
=Ol5u
-----END PGP SIGNATURE-----

--e73662955d5075bedea110cf04232664a8d147c373d1a0aa2f0fc2ec91d6--

