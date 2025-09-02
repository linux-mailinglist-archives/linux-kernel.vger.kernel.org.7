Return-Path: <linux-kernel+bounces-795909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A419EB3F943
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A9E48566D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A02E8DE8;
	Tue,  2 Sep 2025 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E5W0Jcge"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD521FF38;
	Tue,  2 Sep 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803457; cv=none; b=aOVzl6nOcSlCZYqSo+g55+aECL0xaIjdGFcNCi9akdrMEoXzXHKYYSkwTkDTY99o+XwIUxFGtawHzuOSaiK93Rki0ufBu/aezJ/3hkOtZ1mb1fTMAJF1JvN0wJDApqqpSPlpn26f2Wp495fOjJJEu5P3za2+F0L66ljMPgeXaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803457; c=relaxed/simple;
	bh=/oGnBMreWPACxHfLBlaOCJWYITRtOg2q7GuC6elIIbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HC9TX/j88ikN15RJTemxW3+SE3itgQIYcwU1lNBVPr2WXh0naTX1WSU8x4T2rNymXMx0fZ+ip4AXFV20OyVBpz3vYHv8fa1BbACjmrNIsIO1V5wxHlPdsMzNL59mJQL2yA/jfyRk3+EsT2zyCRWWA4D6OnxtYRdT4VQSGXekn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E5W0Jcge; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5388F4E40BB5;
	Tue,  2 Sep 2025 08:57:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24C7A60695;
	Tue,  2 Sep 2025 08:57:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 053891C22D8A3;
	Tue,  2 Sep 2025 10:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756803451; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AyHIaf6WQe2QQWwuimh8OdfA1ncGmt0f0bFGO/cNShc=;
	b=E5W0Jcge/hsJprrkZR/JgqZzfWib5ksl3q8F3J4QBRVA/7uI5vTkpl0OjPTnZBrrnB80Ck
	nFyjnmY2d1dV6R5YlkdWKrlS+GDQ7xB8Sc5QjX2GZh6KMy6w/TSTq849TX2tNtifGweHCk
	hWVjN+t+bRDbGm2ZzDn4PjlDkc5MTknmZjpoSYqOxALhL5RUker7mq/vqNKcgGFE8hQmX0
	h8P0AuzZJJxM4GgKvDZWXW3/5Y6OT5UOxqgiWYYfu1VxBKhQbovI6SJSO9bfSOs9bn/eVl
	i1AsMG8wgxdELgknP3l1BGjsQ5KPuNMZoUb+kEq0AFFLX2oRzNmJgdZFdJCygQ==
Date: Tue, 2 Sep 2025 10:57:10 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, Rob
 Herring <robh@kernel.org>
Cc: Ayush Singh <ayush@beagleboard.org>, David Gibson
 <david@gibson.dropbear.id.au>, Jason Kridner <jkridner@gmail.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>,
 Andrew Davis <afd@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Device tree representation of (hotplug) connectors: discussion at
 ELCE
Message-ID: <20250902105710.00512c6d@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

[this main was co-written by Herv=C3=A9 and Luca]

Herv=C3=A9 and I are working since 1+y to allow describing hot-pluggable
add-ons and their connectors with device tree overlays. Our work is not
very much progressing because discussions about device tree bindings
has raised some issue that are not obvious to solve.

This e-mail is a report of the efforts we did last week during the
Embedded Linux Conference Europe to try to address the currently
blocking issues.

First, I gave a talk about the overall hotplug work, to provide a
status update but also to clarify the goals and use cases. Slides are
available at [2]. Goals include:

- decoupling base board and add-on, so an addon can have a single dtbo
  valid for any base board, and vice versa
- supporting main boards with multiple connectors where multiple
  instances of the same addon model can be connected independently
- allowing overlay insertion and removal at runtime (hotplug)

The first goal implies that addon overlays do not refer to anything
(phandles) beyond the connector node.

The talk has attracted a lot of people. All seats in the 200+ room were
taken, and when I asked who has a connector use case about 40-50
attendeed raised their hands. I also had several questions asked after
the talk and in the hallway.

After the talk we had planned a discussion about the topic. Krzysztof
Kozlowski was present in person (thanks!), while Ayush Singh and
Wolfram Sang connected remotely. Jason Kridner (beagleboard.org) and
Geert Uytterhoeven were present and actively constributing to the
discussion. Unfortunately Rob Herring was not connected, but still we
tried to make the best out of the discussion. So we focused on
discussing the current proposals to go past the issues with our
export-symbols proposal raised mainly by Rob.

Here is a summary of the ideas we have discussed, in order from
simplest discussion (looking like not doable) to most complex (which
look like doable).

---------------------------------------------------------------------

Idea #1: Label on __overlay__
Proposed by Rob in [0]

> Couldn't we make something like this work:
>
> connector: __overlay__ {
>    node {
>       foo-gpio =3D <&connector 0 GPIO_ACTIVE_HIGH>;
>    };
> };

This would be OK for simple cases but it only allows exporting one
label, for the connector (i.e. the overlay target node). More than one
label need to be referenced from the overlay for cases such as:

- pinmux, where each pinmux configuration is a node, and is defined
  in the pinmux node outside of the connector
- HDMI ddc-i2c property, for HDMI chips in the overlay which needs to
  point at an I2C adapter in the base tree

---------------------------------------------------------------------

Idea #2: add /export/ keyword to mark labels to be exported
Proposed by Rob in [1]

The idea is to mark modes in the base tree that can be referenced by
overlays:

> /export/ label: node {
> };
>
> And then __symbols__ can be only those exported labels (unless -@ is used=
).

This is an opt-in version of the "global" __symbols__ to limit the
issues __symbols__ introduces. However it is not sufficient for
connectors because it tells what can be exported but not on which
connector. Also, overlays would need to refer to the nodes in the main
tree, thus not decoupling mainboard and addon.

---------------------------------------------------------------------

Idea #3: label on empty (*) node
(*) until overlay applied
Proposed by Herv=C3=A9 at LPC2024 in a discussion with Krzysztof, later
abandoned

This is based on Idea #1 but tries to make HDMI ddc-i2c work:

connector1: connector1 {
    #gpio-cells =3D <2>;
    gpio-map =3D <0 0 &soc_gpio 12 0>;
    gpio-map-mask =3D <0xf 0x0>;
    gpio-map-pass-thru =3D <0x0 0xf>;

    i2c8: i2c-hdmi {                [**]
      i2c-parent =3D <&soc_i2c8>;
    }
};

connector: __overlay__ {
   node {
      foo-gpio =3D <&connector 0 GPIO_ACTIVE_HIGH>;
   };
   i2c_hdmi: i2c-hdmi {
     //empty
   };
   hdmictrl@99876 {
      ddc-i2c =3D <&i2c_hdmi>;
   };
};

This would leverage the i2c-bus-extension work (also under discussion
[3]). Since for HDMI an I2C device is not added it would have a node
(i2c-hdmi) that is empty in the overlay (but not in the base tree and
thus not in the live tree after the overlay is applied). This empty
node is needed to ensure we can have a label (i2c_hdmi) that can be
referenced from elsewhere in the overlay (ddc-i2c).

However there are various issues with this approach:

 - mainlin, it does not handle pinumxes nicely
 - if the node that is overlayed by the empty node (i2c-hdmi) has a
   label in the base tree (line [**]), then the overlay-provided
   phandle ID would screw up the base-tree phandle ID
 - in dtbo, the empty node (i2c-hdmi) has a property in the overlay
   (phandle) but the node exists in the base tree, thus the property
   would leak on removal

---------------------------------------------------------------------

Idea #4: resolving phandle errors by the connector driver
Proposed by Rob in [1]

> I'll throw out another idea. What if we make resolving phandle errors
> something that can be handled by the connector driver? The driver
> knows 'connector' resolves to the connector node it is applying the
> overlay to.

This idea looked promising, so we tried simulating the process with a
dts/dtso example:

Base tree:

connector1 {
    compatible =3D "myvendor,myconn";

    #gpio-cells =3D <2>;
    gpio-map =3D <0 0 &soc_gpio1 12 0>, <1 0 &soc_gpio3 42 0>;
    gpio-map-mask =3D <0xf 0x0>;
    gpio-map-pass-thru =3D <0x0 0xf>;

    i2c-sensors {
       compatible =3D "i2c-bus-extension";
       i2c-parent =3D <&i2c@abcd0000>;
    };

    hdmi-ddc-adapter =3D <&soc_i2c8>;

    // All pinctrls that addons may need
    pin12-pinctrl-i2c =3D <&pin12_mode_i2c>;
    pin1-pinctrl-gpio =3D <&pin1_mode_gpio>;
    pin2-pinctrl-gpio =3D <&pin2_mode_gpio>;
};

Overlay:

/ {
 fragment@0 {
  __overlay__ {
   node {
      foo-gpios =3D <&connector 0 GPIO_ACTIVE_HIGH>,  <&connector 1 GPIO_AC=
TIVE_HIGH>;
   };
   i2c-sensors {
      thm: thermal@15 {reg =3D <15>;...};
   };
   hdmictrl@12345678 {
      ddc-i2c =3D <&ddc_adapter>;   [*]
   };
   some_other_node {
      pinctrl-0 =3D <&pin12_pinctrl_i2c>;
      thermal =3D <&thm>;
   };
};

This is what would happen for the HDMI ddc-i2c at line [*]:

1. of_overlay_fdt_apply_new(..., resolve_dt_error_cb) is called;
   it is a variant of of_overlay_fdt_apply() (name to be defined!) that:
     a. takes a function pointer to invoke the connector for resolving
        unknown labels
     b. does not even try to resolve phandles beyond the connector
     c. if target node has no phandle, creates one with next unused
        number
2. resolver does not find 'ddc_adapter' label
3. before calling it a fatal error, resolver calls connector driver
   callback
4. connector driver callback knows the "ddc_adapter" string must be
   resolved using the "hdmi-ddc-adapter" property, returns soc_i2c8
   phandle ID

connector driver callback in pseudocode:

  resolve_dt_error_cb(conn, label)
  {
    switch (label) {
      case "connector":
        return conn->of_node;
      case "ddc_adapter":
        return resolve(conn->of_node, "hdmi-ddc-adapter");
      case "pin12_pinctrl_i2c":
        return resolve(conn->of_node, "pin12-pinctrl-i2c");
      }
  }

We discussed some possible issues, such as: what if a label is actually
found in the base tree and thus resolved? This is handled by point 1.b.
above: the OF core does not even try to resolve phandles beyond the
connector, it would not make sense for connector anyway. In other words
it only resolves local fixups, which are internal to the overlay, such
as "thm" in the example above.

This looked like the most promising approach because it handles nicely
HDMI DDC and pinmux and minimize pollution in the phandle ID space.

---------------------------------------------------------------------

So that was what we discussed in the meeting last Tuesday. We hope this
will help in setting the current point and let the discussion move
forward.

Anyone having taken part to the discussion is welcome to correct or add
any info we may have missed.

Best regards,
Herv=C3=A9 and Luca

[0] https://lore.kernel.org/all/CAL_JsqLT3prYBcxnsUwAShULCLJScYoU29ta29RJLG=
yiNkCrTg@mail.gmail.com/
[1] https://lore.kernel.org/all/CAL_JsqJCbmMJWJnmr8FneKrW4pjvTcyEco94Ot32o2=
YtaVxRQQ@mail.gmail.com/
[2] https://sched.co/25Vrw
[3] https://lore.kernel.org/all/20250618082313.549140-1-herve.codina@bootli=
n.com/


--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

