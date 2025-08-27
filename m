Return-Path: <linux-kernel+bounces-787876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80948B37CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0781BA2BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE113314A7;
	Wed, 27 Aug 2025 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fDMVk27s"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028A32A3F9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281898; cv=none; b=LnLnfUGvLBQ4pBKy58IXU72xCA18hlgyp7fJIcD/iv+A2dtrkKe1O0Hfp0C9hybW/dC8BMOaEke3jnsiBzNVf4BZicma/e+C2nI6XCBg0keRitwbLwRC88CfubpEFaGluRHZRJdBLv2NGWXJwSU1RKI7e9UGXSZu8y7FFwtBAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281898; c=relaxed/simple;
	bh=g+KW9TEeVGqYphEisf/ETPbXzv+fd0lBq6e6n0plR/M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=etuewo+0wf/gTft27LUWokxw7yijRMEDhs66qArTAA8THg9Xxnk13d9pLkPxaXqHvqzBOEIEhdVU3yqLAhT1PZAEV+6MqfWiOjkb31FvLmcntx5u42F8imoTKJ3TmUcTGot9+hlDEOENj4++7HshFFqaoH2b8lnJWkJUo2Ojp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fDMVk27s; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afe84202bc2so431169166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756281893; x=1756886693; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o38urx3Y5liCjRZycGC30h3AxkEKhcqPAFepRrs3ec0=;
        b=fDMVk27sioxSQfUj+NERtZPfo0GlsETGlORLyy3ZT+lzjJ+z7XeF8r4tSxc0W5mxVb
         bR1216Db1cFXjPU5M+QfdPo42l5ADMzwKKtiJSdV6Fzzs7dsUwQ2krYvIYga30Mke6pJ
         g/Ua8WLE5hc34IjEPCvocqcCgC0bkFTVsmDc65dVV3mPsBGaT+9RvfqapaXrOncOp27b
         HtG1x7KsEuupa8heo31rfFHSHwaCO4TXQAHNi3x7A0UQYPGE2cXCGG6xDS51QUFul2yn
         T+zhWRtcrR5mDXVvKWIl9r0pVwu9/G2MdYTgH/5kGxriNy196EG+AssHwdv9TkZkmC1v
         JeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756281893; x=1756886693;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o38urx3Y5liCjRZycGC30h3AxkEKhcqPAFepRrs3ec0=;
        b=hKrQIir8Beme9WyMBEsz33mVgshPVwKygK9sYICKk4GUIrATsg+yNkSBvJGqb8q2hn
         IJW1DuQIXt0C8B8oP9eQCr79I28DbIadoZ4ADI8i2ykeBHs2j15X9YX0K+EANvZWjENb
         DOupBv6Cy1GVi/bRHvBVy4xvJpzg8HgqdTIMA4RrVz6aHGdSYJfg8Iy2Kpas2KppP+ct
         tEBbQOtnCHHiD+TwGJWw8loRKFNGp2jQWl9e2WFLWBsKkf12yq183jxVms3uPUN9XeQb
         IgiYGjbMEoukgaKjJ2C6Ikzv8GTxxgoX5uJ+dZurwWNK/YLxZDDZ+/QWIodCQawjlLwu
         ILVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI/lJwpySkuDNhxJ//LYVu5qdsCWP3r3wf6nfjBJndRxBOfgu/m2hDj7c92lQ8MlaKkfe7Ckxf1BeNtPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBp80DwnLlXE34fGQ8tSkzW2zylKKzZ9d6ZKLdAlmBF2TpFMt1
	e785D0X4/NWctgy7Vg9+VVWulNAfqWXVJEF176sNqh8QxcTaaSY/QyYnbr3PeudNkJQ=
X-Gm-Gg: ASbGnctxhtc1wjm47mh7OS05TSkbmZh5UNnZrGihJch8avVfRFBtb+ep+mTK3G6PiJy
	Y+5x+X8Nk/dgAnpLzqLHefkDQS8AplGnBS6vobLdAniPz9E+x8S9qIW69aB8dTkgmeZRc/yrLHC
	cgtPXc2l1Icq6qzgCqkhdWLRdNSTgHx7Y1K9dawFY4UegxmnPD1RAAmYZBby2X7hHiwPq2DFSxD
	Hrw+LdwsYN2tW127v0+adQ8VFqZo7okxd/+OFpjp3tH1HyBInar126sHbjiFkUqdVSlioAPSNcR
	w38z4ViM9bPlwlLq/0huc9/ciGYGBun6JPYribDOP4Az/FX6H6ITA1d0kq5B8ZI5az/14j3op9y
	mdHUuLaKHfyQR2zxY3xZn7upLDLD6Il9gNhBB88FsFe9a5u/M
X-Google-Smtp-Source: AGHT+IHAZruNO8PxiQDS6YA+oxemi3oPab4ygrNWQ7snhZ/72+NK1dE4fWGZyqEZWKw8iTnURGRP8A==
X-Received: by 2002:a17:907:6096:b0:afe:7d3b:8463 with SMTP id a640c23a62f3a-afe7d4ace6fmr1003276666b.62.1756281892878;
        Wed, 27 Aug 2025 01:04:52 -0700 (PDT)
Received: from localhost (83-97-14-186.biz.kpn.net. [83.97.14.186])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afeaf41dc6fsm283102066b.18.2025.08.27.01.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 01:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=41c8a4c6eaeda649630e38b4e0028da409cd67aaf3a4c32373d96e5bca68;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 27 Aug 2025 10:04:32 +0200
Message-Id: <DCD1YPX4T779.ADK4JCGW1MU7@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Rob Herring" <robh@kernel.org>
Cc: "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, "Simon Horman" <horms@kernel.org>,
 "Vincent MAILHOL" <mailhol.vincent@wanadoo.fr>,
 <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 1/4] dt-bindings: can: m_can: Add wakeup properties
X-Mailer: aerc 0.20.1
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com> <20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com> <20250822143549.GA3664230-robh@kernel.org>
In-Reply-To: <20250822143549.GA3664230-robh@kernel.org>

--41c8a4c6eaeda649630e38b4e0028da409cd67aaf3a4c32373d96e5bca68
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Rob,

On Fri Aug 22, 2025 at 4:35 PM CEST, Rob Herring wrote:
> On Wed, Aug 20, 2025 at 02:42:25PM +0200, Markus Schneider-Pargmann wrote=
:
>> The pins associated with m_can have to have a special configuration to
>> be able to wakeup the SoC from some system states. This configuration is
>> described in the wakeup pinctrl state while the default state describes
>> the default configuration. Also add the sleep state which is already in
>> use by some devicetrees.
>>=20
>> Also m_can can be a wakeup-source if capable of wakeup.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 +++++++++++++++=
+++++++
>>  1 file changed, 25 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml =
b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>> index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..0e00be18a8be681634f25378=
bb2cdef034dc4e6b 100644
>> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>> @@ -106,6 +106,26 @@ properties:
>>          maximum: 32
>>      minItems: 1
>> =20
>> +  pinctrl-0:
>> +    description: Default pinctrl state
>> +
>> +  pinctrl-1:
>> +    description: Can be Sleep or Wakeup pinctrl state
>> +
>> +  pinctrl-2:
>> +    description: Can be Sleep or Wakeup pinctrl state
>> +
>> +  pinctrl-names:
>> +    description:
>> +      When present should contain at least "default" describing the def=
ault pin
>> +      states. Other states are "sleep" which describes the pinstate whe=
n
>> +      sleeping and "wakeup" describing the pins if wakeup is enabled.
>> +    minItems: 1
>> +    items:
>> +      - const: default
>> +      - const: sleep
>> +      - const: wakeup
>
> This doesn't allow '"default", "wakeup"' which I think you want.
>
> "sleep" and "wakeup" seem mutually exclusive and really are just the=20
> same thing. Both apply to the same mode/state. Whether you can wake from=
=20
> it is just an additional property (of the state).=20
>
> So I think you want:
>
> items:
>   - const: default
>   - enum: [ sleep, wakeup ]
>
>
> Or you should just drop 'wakeup' and just support wakeup with 'sleep'=20
> when 'wakeup-source' is present.

Thanks for your feedback. I see they seem to be mutually exclusive, but
I think they serve different purposes. The sleep state describes the
pins when sleeping with wakeup disabled. The wakeup state describes the
pins when sleeping or off and wakeup is enabled.

Only allowing one of the two states or only using the sleep state will
enable or disable wakeup statically, there is no way to choose one or
the other.

For my specific setup, the name of a sleep state is also kind of
misleading. The SoC is in a poweroff state and sensitive to activity on
the pins configured for wakeup. It is not just sleeping, it will do a
fresh boot once woken up.=20

Best
Markus

--41c8a4c6eaeda649630e38b4e0028da409cd67aaf3a4c32373d96e5bca68
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaK68EhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlN4
dwEAmJszUShVvXfS2LCmLmEu7BZUsJ2zzz7SGnnInFEs3FEBAOcxPEuvnj7hWYdH
3c/Loa6iaWxbVEoBV2+H35Z3algJ
=jiEZ
-----END PGP SIGNATURE-----

--41c8a4c6eaeda649630e38b4e0028da409cd67aaf3a4c32373d96e5bca68--

