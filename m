Return-Path: <linux-kernel+bounces-741938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698CEB0EAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32265580516
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111226FD9D;
	Wed, 23 Jul 2025 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="BLjxWriK"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80969191493;
	Wed, 23 Jul 2025 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253270; cv=none; b=ir9lE4k3558hp305d7gZMeAY1hBMIgid/lgWqO7l2JajLmBR84p/sEFdzpFhOQl4W/pb7eKqV6MZFjrN6x1+fp7Np42UqEaqilieC+9zaiG9gM84ri3XVhatCiDa4dlJA7bUO8ccqXEu2kqmjkczysIc7UoDDkVDG52vOfyRK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253270; c=relaxed/simple;
	bh=+Yb4Wy6t52M4grBsczbkb2a6ETobnuJy4+jhoGQ6wxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJSpmXj2QeWmBvJmED2KWvuAPXtC/KtPsKtRtwuAyBOYt2gSTh6hVxE8+g0qLvxgD7ZoBvevhSq6+Fttg0Ixv/fCVIHbirxMU4v+NPcVdZfh/obvNlHWaZOQu7lVz7DMQ+VUqpkUmoZT9THcDg1Qk6JzYmyvSBCtAOO+acJ5ABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=BLjxWriK; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753253263;
	bh=i1P2/ELUd1b9ULWl8PKW1VUWLzj7JvUrI0bGxJFYGBQ=; l=4628;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=BLjxWriKj3LAllpK8YtS3Lzo/Xt/Nte/71T9DSdXP6dFMxx+/1Gca2dmP2kWFqa8w
	 Umlt7hBpdEm7/XkM+ZXy+xva8PWE6q+yxzLDLRUyJMtKWaqIvLFtuOUmkZD25qIbG+
	 08G+GONfzhDn4qhepRB2x4YkLgNuAWOufH9E3CHIW3crFwkJgxxzLajPyXhQAaQPtr
	 q+C0TEixfw0FO5GQKCGk6tSYtIh0IEKmHX7GI7caS/nW1ua1lslfHvDZU2jrtw2xQs
	 +D2J0U0wR6YZAbxze30iT+sUzN5Qv/iONqTfaIwo0s89QOmzvT+tPD0tv/xDVB2wqr
	 HZOT1z3dltneQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244587:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 23 Jul 2025 14:47:35 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 23 Jul
 2025 14:47:34 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 23 Jul 2025 14:47:34 +0800
From: <jeff_chang@richtek.com>
To: <krzk@kernel.org>
CC: <broonie@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<jeff_chang@richtek.com>, <krzk+dt@kernel.org>, <lgirdwood@gmail.com>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: regulator: Add Richtek RTR5133 Support
Date: Wed, 23 Jul 2025 14:47:38 +0800
Message-ID: <20250723064813.2742303-1-jeff_chang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <4ba4c608-e2e1-46e8-b796-e07c7c97dbb3@kernel.org>
References: <4ba4c608-e2e1-46e8-b796-e07c7c97dbb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Dear Krzysztof Kozlowski:

	Thanks for your reply.

	Please review my explanation for your questions.

	If I have misunderstood or if there are any parts that need correction, please let me know.

Thanks
Jeff


On 22/07/2025 10:34, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
> 
> Add bindings for Richtek RT5133 IC Controlled PMIC

Subject - RTR or RT? Google tells me nothing about RTR.

--> I will fix it to RT5133 in next patch.


> +
> +    properties:
> +      base:
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Properties for base regulator which control force-off base circuit.
> +          Base circuit is the power source for LDO1~LDO6. Disabling it will
> +          reduce IQ for Chip.

I don't understand what this regulator is for. Your example is also
incomplete - missing min/max constraints like voltage.

Explain, what is this output pin? I already asked for explanations. I
have diagram in front of me, so explain precisely instead of sending THE
SAME again - which pin is it?

Also, what is IQ? Except Intelligence Quotient?

--> Thanks to Mark's Suggestion. It's the top-level supply for LDO1 to LDO6.
    It is not externally visible and functions merely as an on/off switch rather
    than regulating voltages.
    I will update the description as follows.

   Properties for the base regulator, which is the top-level supply for LDO1 to LDO6.
   It functions merely as an on/off switch rather than regulating voltages.
   If none of LDO1 to LDO6 are in use, switching off the base will reduce the quiescent current.


> +
> +        properties:
> +          richtek,oc-shutdown-all:
> +            type: boolean
> +            description:
> +              Anyone of LDO is in OC state, shut down all channels to protect CHIP.
> +              Without this property, only shut down the OC LDO channel.

I don't understand this. I also do not understand why this is property
of "base" not the chip itself...

So don't send next version with the same.

--> It is a protection for LDO Over Current . The Description in datasheet like below. 

    Anyone of LDO OC state, shut down all LDO channels
    0 : LDO OC only shut down itself (default)
    1 : LDO OC shut down all channels
    We set it as a property of "base" for using regulator_desc -> of_parse_cb.
    Should I move them to chip property? We bind it to base regulator for easily programming.


> +
> +          richtek,pgb-shutdown-all:
> +            type: boolean
> +            description:
> +              Anyone of LDO is in PGB state, shut down all channels to protect CHIP.

CHIP is an acronym? Or chip?
--> chip! I will use "chip" in next patch.

> +              Without this property, only shut down the PGB LDO channel.
> +
> +        required:
> +          - regulator-name
> +
> +    patternProperties:
> +      "^ldo([1-6])$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Properties for single LDO regulator
> +
> +        required:
> +          - regulator-name
> +
> +      "^ldo([7-8])$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Properties for single LDO regulator
> +
> +        properties:
> +          rt5133-ldo1-supply:

supplies do not have vendor prefixes.

> +            description: |
> +              Only for ldo7 ldo8, pvin7 and pvin8 reference design are RT5133 ldo1.
> +              If not connect to ldo1 vout, this property for pvin7 and pvin8 is necessary.

I don't understand why LDO1 supply is here.

Again, which pin is it?

--> Please refer to PVIN7 and PVIN8 in the diagram. They are the power supplies
    for LDO7 and LDO8, respectively. The reference for PVIN7 and PVIN8 is the VOUT of LDO1 (VOUT1).
    In the driver, we set "rt5133-ldo1" as the supply_name in the regulator_desc
    for LDO7 and LDO8. Users can overwrite the rt5133-ldo1-supply property according to their own layout.
    Anyway I will just use vin-supply and I will remove vendor prefixes of supplies in next version.



> +
> +        required:
> +          - regulator-name
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - wakeup-source
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt5133@18 {

Nothing improved.

> +        compatible = "richtek,rt5133";
> +        reg = <0x18>;
> +        wakeup-source;
> +        interrupts-extended = <&gpio 187 0x0>;

Nothing improved

--> I will update them like below.

    pmic@18 {
    interrupts-extended = <&gpio 187 IRQ_TYPE_LEVEL_LOW>;


Implement previous comments and respond to each of them to confirm you
understood them.

> 


Best regards,
Krzysztof


