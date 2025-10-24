Return-Path: <linux-kernel+bounces-868184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2135C04990
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292223A95E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471CC27AC21;
	Fri, 24 Oct 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnkHuVoi"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED02749CE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289152; cv=none; b=KCu91vL24lZBNCkrE7DnpAyJQLAEsTPlQAIq4+l1I8xUDr1/ilrwn2Y93KN5eH0h+ijm9K1wGgg0oDBGvDABVOuRVvQ/8a642ad6Qh8anzF/r7NrZDcwc6ppohumIVPv+/pHn+3bIhEDzjCfnYojNCKdJIdGiLQSZ4UaQGywnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289152; c=relaxed/simple;
	bh=VGMnhyjAZP03c1OP/Kj3eN4sUi7Fp0RT19Yo6no/M6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXPoMakZbQNg3ZJk7C2i5anbd6jfiRcB5gcS6Zrr9St/yqTxe78rckHB41YXcfZpyjeDyr6MFZkflcvrZPOjbBrQ1np6czPs5VaSQ3YU45VOorErdpXRjwkUY7Hmpk10Ih0mBP99MtuoKaCoC3n6gORo813D09WbsnWMiiMXASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cnkHuVoi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c4b5a1b70so3208091a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761289148; x=1761893948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ugqv1s44lLqcX4JmETo9JSdUQjRGtApJwylkT2MhNI=;
        b=cnkHuVoi6trn7BgTCnZ2072RWjmYvJLg+HjNPcVD45bzQU1ITXZQAWHz258fKLbA5X
         1UGIAm9gKdNXSDc7EgzjCRJHB3BmfUlOjPfvt/w/AMbeex8cTNVj4HF2S+CZB/2ayeBl
         JlUCu5I1Sgun1nfLIxAwZDnhTKNqQxPp8TnPgZD8r+yFy3HxOH6I9viz9XaH8PHvvKVW
         OCuUXJ1Z/oEdxdqJjySw6dx9DyLTZXRG1g+eQ5B49vLcM3601PZcBR1GKe9sMR+SK1j6
         9AvwNf/eSObyC96YxMnnMG2XHiEM7U7aVI0oC52CENqs5wmKKA7gYDZODvCu889DpT1/
         EwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289148; x=1761893948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ugqv1s44lLqcX4JmETo9JSdUQjRGtApJwylkT2MhNI=;
        b=NJRPmooPqjyrHfWgyWZShwxnLAL1nQB2vVxHkZAcT4imasXqU6ya4HHCI3Lhkw7mzc
         NRBgOHtUTmp/LqIJS3j7itSqlHeKHlpdjNwooWS0bHIJRD9XI6mUPhbpbGuVLG5GC80y
         xf0TKd1IHAyrIn8K03zkfgOUGoO6i6sSZHDzuosoP4Y743XwBIbOW/JCVqZ/IbFllH6G
         vZWPp+2V1BQMkf20dqGKl8lsT2ZRHBXg3Agdp+nNZ1MCba2RW/hNsq0KmBC2hK9/yB3Z
         DZBJ642lY7LhgC5ds/0MLfxWeENAJwhOxMB8nlGwMDACiB3Bmh8r2CQqoYhyC8RWEra8
         QfmA==
X-Forwarded-Encrypted: i=1; AJvYcCX07UXVZPZgWSg31Yh7HvjsugKwLdJkWvrpTV+eQZmmljf//SeuCPZRxoalI/l4+oTP40FbMTyUkKpR3O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlX8kv3Bg3kHb+H0vK4JYqbTda8Wi865SIxVFXHX9Orw7NsXv
	Bk6p/0qUL7ABRqtxYFsjrk8Z8cBAU5qoAT3i9dA+zEazyVIuK+8QKWB6f4SZDa0KWMYJZ8c6CL3
	meuvlHCVx2gaoifeIAW5mgJgLHWa41BM7fw6v8mTg1w==
X-Gm-Gg: ASbGncuFa1YZ4MtB7oCey7sPiQ6kvECBTpVag/zN69vV6ZwZQg6HzFrdBf0m32Jup30
	ZNkw0XlMwIJqLmyJtqYY5WVSqotUoNaFFfJKuve0pjChMYmiyG8FrYPAwn2YZPpLLC6W9v4qFw0
	KAkZ6VovO/nLvE4/M6z7SA1QP0BYoIcE+xPh0YP+zHcgT3h3K6ZpzpHWpz7ySBk+lpZ8iP23aGw
	NyRVLMdCQ5TLoBLCeR4N0AqxB+l+RjXplaWxtNvDk7RmeDQwktelg0+7AlEQY4JlGJAFnJCQBnk
	Ve3IU2xckw4Q3Ok+asmkOtH7
X-Google-Smtp-Source: AGHT+IFAhTtwkuQJ8tJVRO47CmkrlfK4n6utip+dcl9Wbc27L/1MyGaOtTTrwRtxBRNLnwzLIx8auf00o2MEwmZjM6I=
X-Received: by 2002:a05:6402:304a:20b0:638:3f72:1266 with SMTP id
 4fb4d7f45d1cf-63c1f640163mr23343462a12.16.1761289148308; Thu, 23 Oct 2025
 23:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022174309.1180931-1-vincent.guittot@linaro.org>
 <20251022174309.1180931-2-vincent.guittot@linaro.org> <aPkt5sigtL/EN0A3@lizhi-Precision-Tower-5810>
In-Reply-To: <aPkt5sigtL/EN0A3@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 24 Oct 2025 08:58:57 +0200
X-Gm-Features: AWmQ_bk6VPRIEAG_QafjLl74cCVYdfxYgbB6ZD71K263u0GS0jqTcUigkEeIqKs
Message-ID: <CAKfTPtAz_joc4KFnxypFXJQTPeRF5y5UKhRyoW6kcMrwQgu+7g@mail.gmail.com>
Subject: Re: [PATCH 1/4 v3] dt-bindings: PCI: s32g: Add NXP PCIe controller
To: Frank Li <Frank.li@nxp.com>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 21:18, Frank Li <Frank.li@nxp.com> wrote:
>
> On Wed, Oct 22, 2025 at 07:43:06PM +0200, Vincent Guittot wrote:
> > Describe the PCIe host controller available on the S32G platforms.
> >
> > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  .../bindings/pci/nxp,s32g-pcie.yaml           | 102 ++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > new file mode 100644
> > index 000000000000..2d8f7ad67651
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > @@ -0,0 +1,102 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/nxp,s32g-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP S32G2xxx/S32G3xxx PCIe Root Complex controller
> > +
> > +maintainers:
> > +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> > +
> > +description:
> > +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> > +  The S32G SoC family has two PCIe controllers, which can be configured as
> > +  either Root Complex or Endpoint.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - nxp,s32g2-pcie
> > +      - items:
> > +          - const: nxp,s32g3-pcie
> > +          - const: nxp,s32g2-pcie
> > +
> > +  reg:
> > +    maxItems: 6
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: dbi2
> > +      - const: atu
> > +      - const: dma
> > +      - const: ctrl
> > +      - const: config
> > +
> > +  interrupts:
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: dma
> > +      - const: msi
>
> Most likely dma irq is optional irq, seldom use built-in edma in RC mode.
> so put msi to the first.
>
> interrupt-names:
>   items:
>     - const: msi
>     - const: dma
>   minItems: 1
>
> missed phys
>
> phys:
>   maxItems: 1

okay

>
> Frank
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - ranges
> > +  - phys
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/phy/phy.h>
> > +
> > +    bus {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pcie@40400000 {
> > +            compatible = "nxp,s32g3-pcie",
> > +                         "nxp,s32g2-pcie";
> > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>;  /* config space */
> > +            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
> > +            dma-coherent;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            ranges =
> > +                     <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> > +                     <0x82000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
> > +                     <0x82000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;
> > +
> > +            bus-range = <0x0 0xff>;
> > +            interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "dma", "msi";
> > +            #interrupt-cells = <1>;
> > +            interrupt-map-mask = <0 0 0 0x7>;
> > +            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +            phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > +        };
> > +    };
> > --
> > 2.43.0
> >

