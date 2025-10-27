Return-Path: <linux-kernel+bounces-871432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F212EC0D3F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990044F3117
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02182FE047;
	Mon, 27 Oct 2025 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI/Ll8xX"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2C2FD699
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565531; cv=none; b=EVCUkeBQ1nWUczABOvOXgnSLy/zEdrSYe15j00mNr6r4Or69PBhOqVjM6ylPz7nuB7J8nBUkIe2JJFoUM841//YoK76oGndxxXpTRORxIssOr8Q+otR5Hlp4Q4WALOJZnikZRcatNv26fuorB7mk1LXVE/QoEN3B387Yt1QX1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565531; c=relaxed/simple;
	bh=DId7qrYduOi7rsQpusH3al8L0SA0hkuOAYv0jtZuJuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPFLj/Orn4So6hzHHhoGsPaMMWBXByHIevc3lSiowMZG9Fx51XGVGTEySFGl63C/KSIwuZ4MQDCf8/jA+ggyw4N7pkxV5Sr00wQjcrecBmKe1ky+T6OjMKjnMgAbuJih1P2vdqq/AILuuvH614SiJsj9Lboh7uXX9A1iYY8fx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI/Ll8xX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-592f1988a2dso5183871e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761565528; x=1762170328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu0yAB4Kq9ci15rhEMoRcDBRFGKvubFx0Hd0y0gzj18=;
        b=hI/Ll8xXTd40fl1UF1A0lagyS2RpX7pkI/vpWO22qpSsN52qVDOYqs2d9iWptOcU9/
         ltp8LqKIVOPvsYTzeEf+orkdOinXuhS5NN6593CcU8XGklLly22IqIlDdfuAkY8GjtJ8
         qgLFugox20z+vB0w8KKbgzbF1HyudhoDuIzQS0o6Ww0Tq+qesAOBSDN8ggIBFvHZyzex
         UpdoWNtnUcZ0VJVYHwxb008ZmNEekT0mRbLGCwNUru37r59vekOUh+lzkv/VoQhis5QG
         77ee0XHHcCcLf3JhHsx9pVUdJDYsFfJLTvuw2qSa6kAUJxZ2W4eENCiXaC+nLy30a2g9
         kzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565528; x=1762170328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu0yAB4Kq9ci15rhEMoRcDBRFGKvubFx0Hd0y0gzj18=;
        b=Mwsgbx29mFedEXe4iOy0JicPO17r5qX0HLbqla9sM+17atwC6Yvr2jQTfYX3yBYnwH
         5crTGmr71KDEWP9YTgeC3FQAWDqJUh+NpNQ/K6ZexOPv0TjqsJ/U+Mpak2bcxfx6dNBe
         X5jP6cOMw6qp6rzAf5aBBlp7sHmyzAdapyIXmxFcavuPK/1VInUxCMxJY12XRgZ4ogsi
         g9F08hRlFPJebKZqAlbCcS7vtBLd3b6Pe2pbA5bSN94Uv5Uvou6eLV0k3nxeRNnBeGf7
         eNKJGw1Qqz23Gn90fnPRKd761wc28VZSbNLfM646mb+NRSLkL2pAEv/CXVcvQHNFCCBh
         1dgg==
X-Forwarded-Encrypted: i=1; AJvYcCXLqrXAlWCgtlF2cAOcrKF3MUTKpMktLedSsP9nsjSGeQaFc3G3lO+eB0LjRCqT07uWEnu1RmboofrmhQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcISO5/oYYdui5731W0Uxissk6ZmkOM9vc2JcY4cMZGnkuB/od
	MeeX7ql+d39R9VD6n7qCwnbOTMDrk75cpF+ciFFFUo7xoiz1P2vy643X
X-Gm-Gg: ASbGnctW+S431kUr4MIDoXScaKDR/+pJ2Xu+Akw7TAdeonsLtUcKrNGNz6uCz9frC7t
	QqGi2PYl4Rwe8F/tf9PGuKoP3GO5dh/uviJCtt+njAuuefJNNeFx6QBeZMqFtla64IUCET+ALGZ
	BuJDDB1GU1G11nIkweGausU7qTooHf6Mpj0v/nwotNSKiyNj3IxgOcqKBQsnhII4K0yA1Tklxl8
	Jzy+6J1EjkGyxmXKfzDbt1g5YydHuK0i04OLT6FMkIjGbMQDKGS95IuyYakziQMuHB8PhcwpBlS
	z66whgt/5IQ9vrN3l6K7EqiqF/RLDfxTZwVK9eFmbvxixkGNPehJCubVEWCKOrnmll/jtzP1LCF
	q947xGhcd02wgD4OfMBqqwYQwam/oeFkJ5hiF7cHMeXzfWIkQOrZ6vjaO6t66RguPIJU2dOVhNk
	JAhobiykc=
X-Google-Smtp-Source: AGHT+IE4YlBL7y1GNkusKn3quFm5CcV3Gp1fcQiEbVskWmnnqdz/gdXp1LualBEs8jKDJNMzkAUW4A==
X-Received: by 2002:a05:6512:6183:b0:593:6b:520c with SMTP id 2adb3069b0e04-593006b5392mr2661528e87.10.1761565527766;
        Mon, 27 Oct 2025 04:45:27 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41bafsm2233916e87.12.2025.10.27.04.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:45:26 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:45:23 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 03/15] dt-bindings: power: supply: BD72720 managed battery
Message-ID: <e8d0273bcf0ac67382e17c40be87d345e28ac06c.1761564043.git.mazziesaccount@gmail.com>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e9WYiUNMm5xMUcJj"
Content-Disposition: inline
In-Reply-To: <cover.1761564043.git.mazziesaccount@gmail.com>


--e9WYiUNMm5xMUcJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The BD72720 PMIC has a battery charger + coulomb counter block. These
can be used to manage charging of a lithium-ion battery and to do fuel
gauging.

ROHM has developed a so called "zero-correction" -algorithm to improve
the fuel-gauging accuracy close to the point where battery is depleted.
This relies on battery specific "VDR" tables, which are measured from
the battery, and which describe the voltage drop rate. More thorough
explanation about the "zero correction" and "VDR" parameters is here:
https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeur=
ope.com/

Document the VDR zero-correction specific battery properties used by the
BD72720 and some other ROHM chargers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 RFCv1 =3D> v2:
 - Add units to rohm,volt-drop-soc (tenths of %)
 - Give real temperatures matching the VDR tables, instead of vague
   'high', 'normal', 'low', 'very low'. (Add table of temperatures and
   use number matching the right temperature index in the VDR table name).
 - Fix typoed 'algorithm' in commit message.

The parameters are describing the battery voltage drop rates - so they
are properties of the battery, not the charger. Thus they do not belong
in the charger node.

The right place for them is the battery node, which is described by the
generic "battery.yaml". I was not comfortable with adding these
properties to the generic battery.yaml because they are:
  - Meaningful only for those charger drivers which have the VDR
    algorithm implemented. (And even though the algorithm is not charger
    specific, AFAICS, it is currently only used by some ROHM PMIC
    drivers).
  - Technique of measuring the VDR tables for a battery is not widely
    known. AFAICS, only folks at ROHM are measuring those for some
    customer products. We do have those tables available for some of the
    products though (Kobo?).
---
 .../power/supply/rohm,vdr-battery.yaml        | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,vdr=
-battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/rohm,vdr-batter=
y.yaml b/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.ya=
ml
new file mode 100644
index 000000000000..1ab3418d4338
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/rohm,vdr-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery managed by the BD72720 PMIC
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description:
+  A battery which has VDR parameters measuerd for ROHM chargers.
+
+allOf:
+  - $ref: battery.yaml#
+
+properties:
+  rohm,voltage-vdr-thresh-microvolt:
+    description: Threshold for starting the VDR correction
+
+  rohm,volt-drop-soc:
+    description: Table of capacity values matching the values in VDR table=
s.
+      The value should be given as tenths of a percentage.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  rohm,volt-drop-temperatures-millicelsius:
+    description: An array containing the temperature in milli celsius, for=
 each
+      of the VDR lookup table.
+
+patternProperties:
+  '^rohm,volt-drop-[0-9]-microvolt':
+    description: Table of the voltage drop rate (VDR) values. Each entry i=
n the
+      table should match a capacity value in the rohm,volt-drop-soc table.
+      Furthermore, the values should be obtained for the temperature given=
 in
+      rohm,volt-drop-temperatures-millicelsius table at index matching the
+      number in this table's name.
+
+additionalProperties: false
+
+examples:
+  - |
+    power {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      battery: battery {
+        compatible =3D "simple-battery";
+
+        ocv-capacity-celsius =3D <25>;
+        ocv-capacity-table-0 =3D <4200000 100 4184314 100 4140723 95 40994=
87 90
+          4060656 85 4024350 80 3991121 75 3954379 70 3913265 65 3877821 60
+          3855577 55 3837466 50 3822194 45 3809012 40 3795984 35 3780647 30
+          3760505 25 3741532 20 3718837 15 3696698 10 3690594 5 3581427 0>;
+
+        rohm,volt-drop-soc =3D <1000 1000 950 900 850 800 750 700 650 600 =
550 500
+          450 400 350 300 250 200 150 100 50 00 (-50)>;
+
+        rohm,volt-drop-temperatures-millicelsius =3D <45000 25000 5000 0>;
+
+        rohm,volt-drop-0-microvolt =3D  <100 100 102 104 106 109 114 124
+          117 107 107 109 112 116 117 108 109 109 108 109 122 126 130>;
+
+        rohm,volt-drop-1-microvolt =3D <100 100 102 105 98 100 105 102
+          101 99 98 100 103 105 109 117 111 109 110 114 128 141 154>;
+
+        rohm,volt-drop-2-microvolt =3D <100 100 98 107 112 114 118 118 112
+          108 108 110 111 113 117 123 131 144 157 181 220 283 399>;
+
+        rohm,volt-drop-3-temp-microvolt =3D <86 86 105 109 114 110 115 115
+          110 108 110 112 114 118 124 134 136 160 177 201 241 322 403>;
+
+        rohm,voltage-vdr-thresh-microvolt =3D <4150000>;
+
+        charge-full-design-microamp-hours =3D <1799000>;
+        voltage-max-design-microvolt =3D <4200000>;
+        voltage-min-design-microvolt =3D <3500000>;
+        degrade-cycle-microamp-hours =3D <131>;
+      };
+    };
--=20
2.51.0


--e9WYiUNMm5xMUcJj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/W1MACgkQeFA3/03a
ocWa5wf9FIbY2brXI4P2K+SkKL5KeUWFhV759iXcCiZETbvISYLTQUgInwo/maR0
CIjloSV2ahJ6BrG6PxHcbD67kt0VrMsF9M1s5ILlfaQwDJ+xDNqz/jFyPsV1OvWZ
NhFwXu6P3hS3Z8Sz+EcHo4QxrH2PGDSbfn1ZhsSMT+j/Fgn6aOUIRBwFGSOluLfb
VQi3LvkEatX9krISzcP9y/1coBFjeaxbaR9O7ifPo19uSY1kQ5CrLMbGGu/YJ5sl
NetFxIsnpGdxMe288trS+BM400PIprVcdoNQwHrTtb8TmynyIExDr064x4KuHKY6
c2lMVwmaCFAU3JoJDueqjLI/FnjKmg==
=fE8w
-----END PGP SIGNATURE-----

--e9WYiUNMm5xMUcJj--

