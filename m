Return-Path: <linux-kernel+bounces-818334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5A1B59010
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AD4170A88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D275272E56;
	Tue, 16 Sep 2025 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cx+0tA/c"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8228134C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010247; cv=none; b=kdwGMY1twN3XqryXg0ZLLP0dd0oR5BOo2+C8gIa4gRd2U6MaK3cVj6bMSTCKA88lS7R5Ac2DdepzXKx1FitgKP3y4bJUNu5p5rJdjp/lzfhzHQWuevNgWn5uuT9EVFrxVq7/f2bs909rKB6SW25wUlrhU/aae2v6kbgwHrRFP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010247; c=relaxed/simple;
	bh=dgGzdivvfd8XES3PBExcVEm29A4m7AktXKrQeyYRmRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0MAUJ0+4acbVPgXPFOmw5jtb/RqJdjp2TMH0N0FH8z05yED7fvLS2EvVpJXU3Wq+ty224Ri3Sc1IpYbRKpfX6H8U78Sa8H1lVy5+1djVzcMCcZxtJdFpgO3PF4xuC2/8XrgseY8d7NiIXwEtUOu85EQmy42xOXPH/50pTnW6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cx+0tA/c; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso1389855a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758010243; x=1758615043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQP36cCGX22q0k7IcTILlGwR80arCJaxhV/jopp91Nw=;
        b=Cx+0tA/c7voNQrF2GNFWWPEPhLB765PRItVwvhNH4If+UtC4jEfHoi8JZmS35NApaJ
         dGBOUMJHsZI+SeI99qJro10VruK6qENg6tIUp6INOyHAmnikHxeZTGSmgsHHYP7Azz2U
         kHpJgP03U3QgXH/4PTmlQ4ZJnARIZK3xRsBuwfZ/5gqktAJMy2xOA4hIZ5MIJlPW5c5I
         Blj7asfPTPKPKxojyJkAkx7WS4OKubaN7DsT6qeUEZ8YAYeiqU221c6bnKiS/0puSnG8
         wzgSJuig1oc1//wYUiDVIGnug6lMRhWbFHnRkPZYaB2DLcRt+QphJlZ3B25pB52X67kJ
         aHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010243; x=1758615043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQP36cCGX22q0k7IcTILlGwR80arCJaxhV/jopp91Nw=;
        b=ikusjOHoLccxDaHezssnFJVFEQYvj9S6UmmOj2rfbAvmiLitSKZe5sKXGpALfgr2UE
         exT2Oy8BJj7sQzWBfBPgKFAkQwR28qgFyf4Ax+URWzg0QOYaP+ajupc/TdPW7jifh/wD
         lStI0NpXOXYDU9opcuzIHQK5eAOJGE7fzJmRAVoATErvePLO1znh1PQAvehCvkq/XC5q
         4AslpbM+BCL1F6qR16ccGELxWeqHbW7jS5OOMXc/UJT5LA/sKSiIQ4MiVaU8WbRdYWsZ
         3shOhWwX1d1XXH1HWhyE3aZf96HGEW8UNmVL9m1b3/3r7VORU1JNSV8UKFCD+6WqwQcT
         t5tw==
X-Forwarded-Encrypted: i=1; AJvYcCVD/p0CBM1HFgw5fSojVcDNz9res30gSlh0sKRoiiWatb86TXpj4By2c0nkhjJOB3XUhE281FMxt70Jk9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysgy7hWYNu/kP13QJlK2TtBx6pnoprrAeQvuJnmUN3DYsfBWs5
	9AmbRer4cJ+NtWT9SnuPOkS46SbMl0G3jZVx4441vDPG0INDpqG8XQkqwNyGkB7+lTBZylKcq+0
	xxOPu4xRMwJ0SYTngTV+OpykUCpKDUT2ackUr6gKBdw==
X-Gm-Gg: ASbGnct9FfYV/BZRDgDpfxxpOOysMnMKCm+DOdMUEJb3m7ewZfwXJ0Yh1MQ5SXxtnC1
	Y8UGmpo3Pm4cVZ7rN+Rcb/LesJNp1/l0pH0XPES6IhgzsqriXUns2nPII48SVQbATj99V3BcaMI
	+w800Q7BwlYufxjvGG033t2enrLpRrrgPiDKsexhizRA3YS2wiTY0EcGDHsceLagnZXOyjfKjg3
	rpfb+64Izy4MRSP6xghPgv9ydp+0AJib3k=
X-Google-Smtp-Source: AGHT+IF8s86824Z4r7SF4kEEtmlZBj5WGTNQHb7gb6RUflmAIF+L7mlo4qsXpdhcViNzJxq7Yyu7oe3gXzf0tllMkEY=
X-Received: by 2002:a05:6402:5cb:b0:62f:5424:7371 with SMTP id
 4fb4d7f45d1cf-62f54247560mr3409565a12.8.1758010243107; Tue, 16 Sep 2025
 01:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-2-vincent.guittot@linaro.org>
 <20250912225004.GA1651547@bhelgaas> <CAKfTPtCfjJ8-30aAeEyigeLyuKtTq+k6PQg+5w4-0Wa7pduZvg@mail.gmail.com>
In-Reply-To: <CAKfTPtCfjJ8-30aAeEyigeLyuKtTq+k6PQg+5w4-0Wa7pduZvg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 16 Sep 2025 10:10:31 +0200
X-Gm-Features: AS18NWDYHx07ASF7wSVWhK8zmCGbokPhdl-skcD1HANsfet_AGVNQ3t6EmLGaps
Message-ID: <CAKfTPtDog36hBZ0XvhC-NyfL0SwB5ve53nLFpofToKt1ebhuGQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Sept 2025 at 14:35, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Sat, 13 Sept 2025 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > > Describe the PCIe controller available on the S32G platforms.
> > >
> > > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > > Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > > Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > > Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > > Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 169 ++++++++++++++++++
> > >  1 file changed, 169 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..287596d7162d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> > > @@ -0,0 +1,169 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/nxp,s32-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NXP S32G2xx/S32G3xx PCIe controller
> > > +
> > > +maintainers:
> > > +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > > +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> > > +
> > > +description:
> > > +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> > > +  The S32G SoC family has two PCIe controllers, which can be configured as
> > > +  either Root Complex or End Point.
> >
> > s/End Point/Endpoint/ to match spec usage.
>
> Ok
>
> >
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - nxp,s32g2-pcie     # S32G2 SoCs RC mode
> > > +      - items:
> > > +          - const: nxp,s32g3-pcie
> > > +          - const: nxp,s32g2-pcie
> > > +
> > > +  reg:
> > > +    minItems: 7
> > > +    maxItems: 7
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: dbi2
> > > +      - const: atu
> > > +      - const: dma
> > > +      - const: ctrl
> > > +      - const: config
> > > +      - const: addr_space
> > > +
> > > +  interrupts:
> > > +    minItems: 8
> > > +    maxItems: 8
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: link_req_stat
> > > +      - const: dma
> > > +      - const: msi
> > > +      - const: phy_link_down
> > > +      - const: phy_link_up
> > > +      - const: misc
> > > +      - const: pcs
> > > +      - const: tlp_req_no_comp
> > > +
> > > +  msi-parent:
> > > +    description:
> > > +      Use this option to reference the GIC controller node which will
> > > +      handle the MSIs. This property can be used only in Root Complex mode.
> > > +      The msi-parent node must be declared as "msi-controller" and the list of
> > > +      available SPIs that can be used must be declared using "mbi-ranges".
> > > +      If "msi-parent" is not present in the PCIe node, MSIs will be handled
> > > +      by iMSI-RX -Integrated MSI Receiver [AXI Bridge]-, an integrated
> > > +      MSI reception module in the PCIe controller's AXI Bridge which
> > > +      detects and terminates inbound MSI requests (received on the RX wire).
> > > +      These MSIs no longer appear on the AXI bus, instead a hard-wired
> > > +      interrupt is raised, documented as "DSP AXI MSI Interrupt" in the SoC
> > > +      Reference Manual.
> > > +
> > > +  nxp,phy-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    description: Select PHY mode for PCIe controller
> > > +    enum:
> > > +      - crns  # Common Reference Clock, No Spread Spectrum
> > > +      - crss  # Common Reference Clock, Spread Spectrum
> > > +      - srns  # Separate reference Clock, No Spread Spectrum
> > > +      - sris  # Separate Reference Clock, Independent Spread Spectrum
> > > +
> > > +  max-link-speed:
> > > +    description:
> > > +      The max link speed is normaly Gen3, but can be enforced to a lower value
> > > +      in case of special limitations.
> >
> > s/normaly/normally/
> >
> > But I doubt you need this here at all.
>
> I'm going to remove the description
>
> >
> > > +    maximum: 3
> > > +
> > > +  num-lanes:
> > > +    description:
> > > +      Max bus width (1 or 2); it is the number of physical lanes
> > > +    minimum: 1
> > > +    maximum: 2
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - interrupts
> > > +  - interrupt-names
> > > +  - ranges
> > > +  - nxp,phy-mode
> > > +  - num-lanes
> > > +  - phys
> > > +
> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/phy/phy.h>
> > > +
> > > +    bus {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > > +        pcie0: pcie@40400000 {
> > > +            compatible = "nxp,s32g3-pcie",
> > > +                         "nxp,s32g2-pcie";
> > > +            dma-coherent;
> > > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > > +                  /* RC configuration space, 4KB each for cfg0 and cfg1
> > > +                   * at the end of the outbound memory map
> > > +                   */
> > > +                  <0x5f 0xffffe000 0x0 0x00002000>,
> > > +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> > > +                  reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> > > +                              "config", "addr_space";
> > > +                  #address-cells = <3>;
> > > +                  #size-cells = <2>;
> > > +                  device_type = "pci";
> > > +                  ranges =
> > > +                  /* downstream I/O, 64KB and aligned naturally just
> > > +                   * before the config space to minimize fragmentation
> > > +                   */
> > > +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> > > +                  /* non-prefetchable memory, with best case size and
> > > +                  * alignment
> > > +                   */
> > > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> > > +
> > > +                  nxp,phy-mode = "crns";
> > > +                  bus-range = <0x0 0xff>;
> > > +                  interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> > > +                  interrupt-names = "link_req_stat", "dma", "msi",
> > > +                                    "phy_link_down", "phy_link_up", "misc",
> > > +                                    "pcs", "tlp_req_no_comp";
> > > +                  #interrupt-cells = <1>;
> > > +                  interrupt-map-mask = <0 0 0 0x7>;
> > > +                  interrupt-map = <0 0 0 1 &gic 0 0 0 128 4>,
> > > +                                  <0 0 0 2 &gic 0 0 0 129 4>,
> > > +                                  <0 0 0 3 &gic 0 0 0 130 4>,
> > > +                                  <0 0 0 4 &gic 0 0 0 131 4>;
> > > +                  msi-parent = <&gic>;
> > > +
> > > +                  num-lanes = <2>;
> > > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> >
> > num-lanes and phys are properties of a Root Port, not the host bridge.
> > Please put them in a separate stanza.  See this for details and
> > examples:
> >
> >   https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
>
> Ok, I'm going to have a look

This driver relies on dw_pcie_host_init() to get common resources like
num-lane which doesn't look at childs to get num-lane.

I have to keep num-lane in the pcie node. Having this in mind should I
keep phys as well as they are both linked ?

>
> >
> > > +        };
> > > +    };
> > > --
> > > 2.43.0
> > >

