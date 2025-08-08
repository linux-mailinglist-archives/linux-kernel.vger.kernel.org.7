Return-Path: <linux-kernel+bounces-760072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1FB1E627
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226411AA3623
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFFC2701CA;
	Fri,  8 Aug 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UY2cD6QL"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D24188A0C;
	Fri,  8 Aug 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647858; cv=none; b=kAv/CBRIYHA3H/1ErOdZKw1AI2y4Tq5K3To+iY9s4Q8w6qnoh9SceH7BVo/7YVc1sNMDudLzxQxU1lmmNM0qWisWzJ4LxFBaRbNZqGTzSEF8edCHlH3dbm5Jn85wnsBnt761BbZI61Lef3PSugNwmP/dn3PTdE+ZFrMeQ8KudM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647858; c=relaxed/simple;
	bh=RggGRjMHU2R6gkBzlubXye+UKgPBHxSYw5o58uEuNPE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTSQXFFOU76hVj7weuZyPPQISzRFqDZy0zSR53ggJ3PA6/s2ZIUN9tuXSKooTK1Bl4KRt6E79nPr8DL0B+0+8wBamoBNcb6cRUQhdEruUphWqFB1VPkWajnF5i/PRKbHAaXdbv/atWxtQQvtcv6E80KsIRg+sdo4m20KSJeScOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=UY2cD6QL; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1754647840; x=1754907040;
	bh=Yq9VQhZI5mAsxhu/WxdvqFhc+hT1CLK+UVkJM6ho9rw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UY2cD6QL6Z23vuTH8SwENI1P/vPhlVOC0sEpCxucNH4Fjo70CHZQgdlKNhG+6/yvo
	 V7Ef8n9eBOhuVxSviIZPpEm8V4Lp0WXUcStRSA+xeGFURo1cgBHsW8r86vaiBeuQ6n
	 moPZyiqjJcwADczZnZ9BBFqOoM5V3bhZo2w+3n0iQz4Tx6t/sIGyx9FfoZ9GAuzTfz
	 THoh3WTG/65PJE+v2cEdcfkJASJmTON07MKLQagdl/UQ7+xEWC6DFEk1caJbp48zq1
	 7S/S2+tGSAm9uEdWLrPeWTGvYBVlTof7qYKFjm/QmPENccZFQGca0bXW4Y878UNaP0
	 bbyJ3R+6lsSeg==
Date: Fri, 08 Aug 2025 10:10:35 +0000
To: samuel.kayode@savoirfairelinux.com
From: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/6] dt-bindings: mfd: add pf1550
Message-ID: <gj565636v5qgohhf5usklfqydkc6lzifzhrbquoyawbwvhdlma@kajszdivkp2e>
In-Reply-To: <20250716-pf1550-v9-1-502a647f04ef@savoirfairelinux.com>
References: <20250716-pf1550-v9-0-502a647f04ef@savoirfairelinux.com> <20250716-pf1550-v9-1-502a647f04ef@savoirfairelinux.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 2267f331269a8e8c5fc399b9463def7d4fed3f7c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 11:11:44AM +0100, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>=20
> Add a DT binding document for pf1550 PMIC. This describes the core mfd
> device along with its children: regulators, charger and onkey.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v9:
>  - Add regulator suspend bindings in example
>  - Add binding for disabling onkey power down
>  - Fix thermal regulation temperature range
> v5:
>  - Address Krzystof's feedback:
>    - Drop monitored battery ref already included in power supply schema
>    - Move `additionalProperties` close to `type` for regulator
>    - Drop unneccessary |
>    - Change `additionalProperties` to `unevaluatedProperties` for the
>      PMIC
> v4:
>  - Address Krzystof's feedback:
>    - Filename changed to nxp,pf1550.yaml
>    - Replace Freescale with NXP
>    - Define include before battery-cell
>    - Drop operating-range-celsius in example since
>      nxp,thermal-regulation-celsisus already exists
>  - Not sure if there is similar binding to thermal-regulation...
>    for regulating temperature on thermal-zones? @Sebastian and @Krzysztof
> v3:
>  - Address Krzysztof's feedback:
>    - Fold charger and onkey objects
>    - Drop compatible for sub-devices: onkey, charger and regulator.
>    - Drop constant voltage property already included in
>      monitored-battery
>    - Fix whitespace warnings
>    - Fix license
> v2:
>  - Add yamls for the PMIC and the sub-devices
> ---
>  .../devicetree/bindings/mfd/nxp,pf1550.yaml        | 144 +++++++++++++++=
++++++
>  1 file changed, 144 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml b/Docu=
mentation/devicetree/bindings/mfd/nxp,pf1550.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..ede5b6a2106ff60f4b47b3602=
fea8dd0b62d6fcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/nxp,pf1550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PF1550 Power Management IC
> +
> +maintainers:
> +  - Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +
> +description:
> +  PF1550 PMIC provides battery charging and power supply for low power I=
oT and
> +  wearable applications. This device consists of an i2c controlled MFD t=
hat
> +  includes regulators, battery charging and an onkey/power button.
> +
> +$ref: /schemas/power/supply/power-supply.yaml
> +
> +properties:
> +  compatible:
> +    const: nxp,pf1550
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  regulators:
> +    type: object
> +    additionalProperties: false
> +
> +    patternProperties:
> +      "^(ldo[1-3]|sw[1-3]|vrefddr)$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml
> +        description:
> +          regulator configuration for ldo1-3, buck converters(sw1-3)
> +          and DDR termination reference voltage (vrefddr)
> +        unevaluatedProperties: false
> +
> +  monitored-battery:
> +    description: |
> +      A phandle to a monitored battery node that contains a valid value
> +      for:
> +      constant-charge-voltage-max-microvolt.
> +
> +  nxp,thermal-regulation-celsius:
> +    description:
> +      Temperature threshold for thermal regulation of charger in celsius=
.
> +    enum: [ 80, 95, 110, 125 ]
> +
> +  nxp,min-system-microvolt:
> +    description:
> +      System specific lower limit voltage.
> +    enum: [ 3500000, 3700000, 4300000 ]
> +
> +  nxp,disable-key-power:
> +    type: boolean
> +    description:
> +      Disable power-down using a long key-press. The onkey driver will r=
emove
> +      support for the KEY_POWER key press when triggered using a long pr=
ess of
> +      the onkey.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/input/linux-event-codes.h>
> +
> +    battery: battery-cell {
> +        compatible =3D "simple-battery";
> +        constant-charge-voltage-max-microvolt =3D <4400000>;
> +    };
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        pmic@8 {
> +            compatible =3D "nxp,pf1550";
> +            reg =3D <0x8>;
> +
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <2 IRQ_TYPE_LEVEL_LOW>;
> +            wakeup-source;
> +            monitored-battery =3D <&battery>;
> +            nxp,min-system-microvolt =3D <4300000>;
> +            nxp,thermal-regulation-celsius =3D <80>;
> +
> +            regulators {
> +                sw1_reg: sw1 {
> +                    regulator-name =3D "sw1";
> +                    regulator-min-microvolt =3D <600000>;
> +                    regulator-max-microvolt =3D <1387500>;
> +                    regulator-always-on;
> +                    regulator-ramp-delay =3D <6250>;
> +                };
> +
> +                sw2_reg: sw2 {
> +                    regulator-name =3D "sw2";
> +                    regulator-min-microvolt =3D <600000>;
> +                    regulator-max-microvolt =3D <1387500>;
> +                    regulator-always-on;
> +                };
> +
> +                sw3_reg: sw3 {
> +                    regulator-name =3D "sw3";
> +                    regulator-min-microvolt =3D <1800000>;
> +                    regulator-max-microvolt =3D <3300000>;
> +                    regulator-always-on;
> +                };
> +
> +                vldo1_reg: ldo1 {
> +                    regulator-name =3D "ldo1";
> +                    regulator-min-microvolt =3D <750000>;
> +                    regulator-max-microvolt =3D <3300000>;
> +                    regulator-always-on;
> +                };
> +
> +                vldo2_reg: ldo2 {
> +                    regulator-name =3D "ldo2";
> +                    regulator-min-microvolt =3D <1800000>;
> +                    regulator-max-microvolt =3D <3300000>;
> +                    regulator-always-on;
> +                };
> +
> +                vldo3_reg: ldo3 {
> +                    regulator-name =3D "ldo3";
> +                    regulator-min-microvolt =3D <750000>;
> +                    regulator-max-microvolt =3D <3300000>;
> +                    regulator-always-on;
> +                };
> +            };
> +        };
> +    };
>=20
> --
> 2.50.1
>=20
>=20

Does it make sense to show that the driver support suspend to mem
states? Like...


=09=09=09sw1_reg: sw1 {
=09=09=09=09regulator-name =3D "sw1";
=09=09=09=09regulator-min-microvolt =3D <1325000>;
=09=09=09=09regulator-max-microvolt =3D <1325000>;
=09=09=09=09regulator-always-on;

=09=09=09=09regulator-state-mem {
=09=09=09=09=09regulator-on-in-suspend;
=09=09=09=09=09regulator-suspend-max-microvolt =3D <900000>;
=09=09=09=09=09regulator-suspend-min-microvolt =3D <900000>;
=09=09=09=09};
=09=09=09};

=09=09=09sw2_reg: sw2 {
=09=09=09=09regulator-name =3D "sw2";
=09=09=09=09regulator-min-microvolt =3D <1350000>;
=09=09=09=09regulator-max-microvolt =3D <1350000>;
=09=09=09=09regulator-always-on;

=09=09=09=09regulator-state-mem {
=09=09=09=09=09regulator-on-in-suspend;
=09=09=09=09};
=09=09=09};

=09=09=09sw3_reg: sw3 {
=09=09=09=09regulator-name =3D "sw3";
=09=09=09=09regulator-min-microvolt =3D <3300000>;
=09=09=09=09regulator-max-microvolt =3D <3300000>;
=09=09=09=09regulator-always-on;

=09=09=09=09regulator-state-mem {
=09=09=09=09=09regulator-on-in-suspend;
=09=09=09=09};
=09=09=09};

=09=09=09vldo1_reg: ldo1 {
=09=09=09=09regulator-name =3D "ldo1";
=09=09=09=09regulator-min-microvolt =3D <2900000>;
=09=09=09=09regulator-max-microvolt =3D <2900000>;
=09=09=09=09regulator-always-on;

=09=09=09=09regulator-state-mem {
=09=09=09=09=09regulator-off-in-suspend;
=09=09=09=09};
=09=09=09};

Br,
Sean


