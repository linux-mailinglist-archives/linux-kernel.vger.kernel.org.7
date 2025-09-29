Return-Path: <linux-kernel+bounces-836474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF66BA9CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA9E1764DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4B30BBB8;
	Mon, 29 Sep 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUBt8klt"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5897B3002C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159537; cv=none; b=IUiqjsxg3X+VfwRosaCXBqP8radJGAydG5rXLohRDuQoQn8+lqKb2zHlhRyp7/p6ua/aBqAzSuNYgTpsxrtz6XkYGz3L3/027wW4zs+hpyox/9O6BrcyifgEO4wDrP5ZIun0BgODOdqNsjAz2+JXA6Zvy6QG8w2SNoIWsW1YKp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159537; c=relaxed/simple;
	bh=WqUBNIieLr+/SDUl7fJ2+wJvwBysLw779QEJCJRdSXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noLNiKtP5n5SQN0gQgd8MlRhXLvg9/YE3MgKxFvAPR6GtGw0G4Vp2m8S/dmDGZqjSdbV5/x2OFsCzTOvJyrr0oEtvJ1U+TSELU8jBvBqoVYytWlwhwWWF54lWXhSw8rRm7BDPqb6FDi5TYq9dYAQlCuCULDSI1l2bSpCS2fRYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUBt8klt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-636255b92c9so3799555a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759159534; x=1759764334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM7Ve+zCeQD9Us3byXLLiKeLQOT/5uriOByaGQErVyU=;
        b=NUBt8kltUqZhXyK4hJm8Cjkw+LC9UY2a0uGMWQkc2KXkIszHV3XgMds21ycusLnC0+
         S+pJ+uxDyLsadhukix2kkLod9udf8v1UYaQj4Gs3dSbMOTtBUtiBhFvfE01Y/dCAzY4i
         fZKmWpIxxFm8tDlBX3dtvLIRkZ6KlWw5R1tD92g3k3sv6qQtJwvof7bD6z486wc/VjZt
         W/gUI124PSCoVa1wMzrH6gsetOgQktN+53VCHzGJRaWsoYeEbxv+Gs4Has4jhsNSQxY7
         tjOVIurqM6YQDVvZBSYkonMI4t6SEd5S/r+Jud09VgwEd51evTV6GoIeuHw8fwKb3mDE
         bCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759159534; x=1759764334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM7Ve+zCeQD9Us3byXLLiKeLQOT/5uriOByaGQErVyU=;
        b=g1cXASRAHJ4duewkG5lpEQIjU9nGOmDCWhXoImxJqEcWMvvpZz00eu+xFYwiSOZc05
         rdaFOaQuomwHGpeSuDkNgI5k5qtcZdd6+Nr80FIB7q5mCRu2cqbTsvZg4eRofUB2oJQs
         nmbWIr47saGG9B05KU9zjbNb35VatxtK/+VXdExCLbHgfe2WD6NnKz0z5jrXKtLwiWT7
         a4DKbJ/QW/rVqWlHFCZT82Qqn1/m3US50qy8eRrPqHMQtnxAuaIJCUx+Ep44krQosJ8s
         rv9cQKm/FGn0jdqauXe3TpbOy8H4e5+c4zFdeIoNU3PwpIziiAyaUhYSV7aHgtj39iFZ
         UzNA==
X-Forwarded-Encrypted: i=1; AJvYcCURsg5CyL20jsSuZiyFYeXCgXw+OzyvFphWmDiO6c3aEwBLXbCvJ7MnchosWInOa1f4KzgNVlJUrTo4QO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXSqH/E0RVY4RmrvvV1hTxxXXjBcZuMlinSxfz549L6+TiyRlt
	C6uJKtNouiWs3DDSPndpgGx84vgYc6PYdaM+JEubtvOPPNQ7Tg57EYJGZtfZP/vuuuwFjH2NeUa
	320ILb/QKTqeAJgLI8S7HASAbnSn12nI=
X-Gm-Gg: ASbGnctPyErsd0fYnXvLeAjh3PV/vvtLEJ5ch9ihv45UQFEYKvHCCuxpTNesIrwqhK7
	NBUnxEspSqhasC7J9f54rxjnUSg/sPAs/VX52HVlGnWCibxg/lcBoBXBxltEZhpOb7XJbLKa8kI
	1Hk0/bebIzVRw30EDAMWdKO84tXBzZk5pnNBmc/eHZdM2ruNSpr9bh96gb0ll1aIXWcevTluiNr
	CMimm5z8c85Dz95
X-Google-Smtp-Source: AGHT+IFwe17UC7MYtlo9fqz6j6lKTKHcT6Cp15AoADwNa8B11f2RIkJdNXpIBJu2cwq7fPZxo+aZhrIt+fOXvufaEJs=
X-Received: by 2002:a50:ec8d:0:b0:62f:64b0:9cc2 with SMTP id
 4fb4d7f45d1cf-6349fa18ec3mr13281695a12.16.1759159533363; Mon, 29 Sep 2025
 08:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-2-linux.amoon@gmail.com> <CAL_JsqJr+h7pTvbRR=7eB4ognK70D1pgNXEORGXo=ndND=pMjw@mail.gmail.com>
 <CANAwSgT3jo35xBvkH4GmQcZuZH=D+SRKJ6e9fSBRz45zwuCmYw@mail.gmail.com> <CAL_JsqLsEDFv4T1ZMmjaoFfs7WNAjVvOk9o1eTXL2EeGF8uuDA@mail.gmail.com>
In-Reply-To: <CAL_JsqLsEDFv4T1ZMmjaoFfs7WNAjVvOk9o1eTXL2EeGF8uuDA@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 29 Sep 2025 20:55:15 +0530
X-Gm-Features: AS18NWCn_NJWEobZTnJPq6GUQ_ZdFFQBFLXaMyvo-IrsDPmU5O_jcKkJFA3qXlk
Message-ID: <CANAwSgTuX3t2-SNPe4OAzGuDpL5RotxX8t+Zx+gcwFKdj3ZEng@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: Convert the existing
 nvidia,tegra-pcie.txt bindings documentation into a YAML schema
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob

On Mon, 29 Sept 2025 at 19:19, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Sep 29, 2025 at 2:40=E2=80=AFAM Anand Moon <linux.amoon@gmail.com=
> wrote:
> >
> > Hi Rob,
> >
> > Thanks for your review comments
> >
> > On Fri, 26 Sept 2025 at 19:26, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Sep 26, 2025 at 2:29=E2=80=AFAM Anand Moon <linux.amoon@gmail=
.com> wrote:
> > > >
> > > > Convert the legacy text-based binding documentation for
> > > > nvidia,tegra-pcie into a nvidia,tegra-pcie.yaml YAML schema, follow=
ing
> > >
> > > s/YAML/DT/
> > >
> > Ok,
> > > > the Devicetree Schema format. This improves validation coverage and=
 enables
> > > > dtbs_check compliance for Tegra PCIe nodes.
> > >
> > > Your subject needs some work too. 'existing' and 'bindings
> > > documentation' are redundant.
> > >
> > Here is the simplified version
> >
> > dt-bindings: PCI: Convert the nvidia,tegra-pcie bindings documentation
> > into a YAML schema
>
> Still doesn't fit on one line and you say bindings twice:
>
> dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
>
Ok
> >
> > Convert the existing text-based DT bindings documentation for the
> > NVIDIA Tegra PCIe host controller to a YAML schema format.
>
> s/YAML/DT/
>
> Lots of things are YAML. Only one thing is DT schema.
Ok, understood.
>
> >
> > > >
> > > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > v1: new patch in this series.
> > > > ---
> > > >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 651 ++++++++++++++=
+++
> > > >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 --------------=
----
> > > >  2 files changed, 651 insertions(+), 670 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,te=
gra-pcie.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,te=
gra20-pcie.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pci=
e.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > > > new file mode 100644
> > > > index 000000000000..dd8cba125b53
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > > > @@ -0,0 +1,651 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: NVIDIA Tegra PCIe Controller
> > > > +
> > > > +maintainers:
> > > > +  - Thierry Reding <thierry.reding@gmail.com>
> > > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > > +
> > > > +description: |
> > >
> > > Don't need '|'.
> > >
> > Ok
> > > > +  PCIe controller found on NVIDIA Tegra SoCs including Tgra20, Teg=
ra30,
> > > > +  Tegra124, Tegra210, and Tegra186. Supports multiple root ports a=
nd
> > > > +  platform-specific clock, reset, and power supply configurations.
> > >
> > > I would suggest not listing every SoC here unless the list is not goi=
ng to grow.
> > >
> > Here is the short format.
> >   PCIe controller found on NVIDIA Tegra SoCs which supports multiple
> >   root ports and platform-specific clock, reset, and power supply
> >   configurations.
> > Ok
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > >
> > > Only 1 entry here, don't need 'oneOf'.
> >
> > I am observing the following warning if I remove this.
> >
> >  make ARCH=3Darm64 -j$(nproc) dt_binding_check
> > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/nvidia,tegra-pc=
ie.yaml
> >   CHKDT   ./Documentation/devicetree/bindings
> > /media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devicetree/bi=
ndings/pci/nvidia,tegra-pcie.yaml:
> > properties:compatible: [{'items': [{'enum': ['nvidia,tegra20-pcie',
> > 'nvidia,tegra30-pcie', 'nvidia,tegra124-pcie', 'nvidia,tegra210-pcie',
> > 'nvidia,tegra186-pcie']}]}] is not of type 'object', 'boolean'
>
> Because you made 'compatible' a list rather than a schema/map/dict.
> IOW, You need to remove the '-' as well.
>
Ok fixed.
>
> > > > +  nvidia,num-lanes:
> > > > +    description: Number of PCIe lanes used
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > >
> > > The examples show this in child nodes.
> > yes it patternProperties example I missed this.
> >
> > patternProperties:
> >   "^pci@[0-9a-f]+$":
> >     type: object
> >
> >     properties:
> >       reg:
> >         maxItems: 1
> >
> >       nvidia,num-lanes:
> >         description: Number of PCIe lanes used
> >         $ref: /schemas/types.yaml#/definitions/uint32
> >         minimum: 1
> >
> >     unevaluatedProperties: false
>
> What about all the other properties in the child nodes? You need a
> $ref to pci-pci-bridge.yaml as well.
Thanks for the input.

patternProperties:
  "^pci@[0-9a-f]+$":
    type: object
    allOf:
      - $ref: /schemas/pci/pci-host-bridge.yaml#
      - properties:
          reg:
            maxItems: 1
          "#address-cells":
            const: 3
          "#size-cells":
            const: 2
          nvidia,num-lanes:
            description: Number of PCIe lanes used
            $ref: /schemas/types.yaml#/definitions/uint32
            minimum: 1
        required:
          - "#address-cells"
          - "#size-cells"
          - nvidia,num-lanes
    unevaluatedProperties: false

> Rob

Thanks
-Anand

