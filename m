Return-Path: <linux-kernel+bounces-837919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD6ABAE0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B4332660A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4F250C06;
	Tue, 30 Sep 2025 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7TMdf3c"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D4246BB0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249969; cv=none; b=QrMDrn92dZ4WK5rvLKS6xDZeDqseL8j6Ra5IBqFgufGiSSoAxiYDn/+ljDgwNry8qCyFnQ+eD1VuCN1j7dFW+NT8lf4I4MhxnhLltliug6DJNU75m9N7xQpbo1MloNFHxj4jbh8Vro22F1oDL9gRpLTNWdOoKy5ChYp3KrMi4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249969; c=relaxed/simple;
	bh=oGF9yTei1g4gjv/QnS3yVyRP9PJi1rFlCgAm1v7R6Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aouhp9S/4Uj/G+EYopTXAR3dNSmu+BfW37zOYYTUdtDVm3a9kyT9av0sxoMCPGA1BWdWQVB84Z+UmGRoyeh6aAuxeKcMCnO5/n1GvaTAd8pz8pvkCZ82+dFi4K6nI3AppPaOGA9gQFPd7nXYkd8kJYscTi2q8hW962nknh2+rGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7TMdf3c; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso11648323a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759249966; x=1759854766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywr/T8H21r9AOyqjIoUOVLC27W+yILSMEGkAVkNfxfs=;
        b=G7TMdf3cbEgC8ruzjQ/JedFDAGQBz35rZtqyh5LkKc7R6XvJOSjv/SM2wBW68YceZY
         S3NC0IMiV3uWjR5j3McYbz49lEMMfl14gYl/F9Co7IW5p08jZZDq0MxPIrFkrUOSlxoT
         k6pR0Sn7/9PWhkY40lt9KnJa74j6sAv4GHNHqiFE7Fz25Aff2wOvm6VWBhmCBRbs8C1a
         3f0t9nE5Xx7B27qVGXyzx2LtkrHA8HlRFWgO+nU/F0Bt9Y0WH8cwkYVQJipQAn3uEW8T
         LyXY8b5e325zk4Ox3mLdnQjyEPLoWxJTrSY5GQMx39t2vj6UmjedDvc+Ty4fI+/V66uH
         B1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759249966; x=1759854766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ywr/T8H21r9AOyqjIoUOVLC27W+yILSMEGkAVkNfxfs=;
        b=YHi9SNa3RMuogVhDbxoMWtLuyHSCT2LF+VQkEwRYMv8ncfDS1MIDboup6IgEIQ64Do
         oJ2MSgamQ3XwRHOrckzaRnt7N7sOwiXTuBV1sh496q0NXDmI4WV4roX0S2imDByzj/vy
         c4/t2VX563FlZfwL6g1cOVqJyMYseXt1hk6pI/qpZUEHMtUNeyGHLFMyuCXW3Lp+aXt+
         ORS3eJplyub3xKUXuNwQMfvQIAo7bCWHQu9PcXCTAPFLM9CUcWCwgvtV5Oqb+JWqC6FI
         AWAgtr/wFV6haFA8uAAR9wYkZi5yczfvpp+MuMa5dPXI21516AgQ4Ocq23Ex+y/NXp1z
         OEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Oihuu1QatT9DZ+VVeyt0JAuTZwQgKVtTWANEYmBbBROdbrGx3BA3uv/DONKRBt8ws3rvu9aR+PJHjHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySZaAx106baHMjQwyOOuau2ryXtzlnzLLDT89FKqJliBaXgo3
	FTKbVXHlwJwGKMfAwk3gnccd0HnWtLjJn/RgK+2sSKaA3BTre1FAQP1GJkuQ4JYmGVCf47/yrfZ
	FahOTqOpbLxdPFF0moLoncss34c4bIMY=
X-Gm-Gg: ASbGncuJZ/tP+Vdr2ng9zdl0bcFn+Mny+cykYUgRW/oNLyig0Z67z87aiDld15IGcmS
	ZhhwtqPRnBfQMs3IbVGJTrLCiSiGu+HmXDQS/nmXg11C2uzErh8ZhhbNvjUealJdsK0ke8RI0G9
	f15VevO1RaCo9BwefP90Kjr0UeGNYpSGuR85vL7WAz04oq5SVqAe7SMucYAG/l6a+6olqqXbfAK
	7r9YRRrftn1DApqZHflOyn9bS3MqQ==
X-Google-Smtp-Source: AGHT+IEJHPU/9y3qBt/SABv++MOXGcN86o3VBfE4lwa8ckg4ceTKcaWY4Edg+8QEKEvz47kn06lNSjx+U7OGCjruhFQ=
X-Received: by 2002:a05:6402:51c6:b0:634:ba7e:f6c8 with SMTP id
 4fb4d7f45d1cf-63678d17922mr511880a12.34.1759249965859; Tue, 30 Sep 2025
 09:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-2-linux.amoon@gmail.com> <CAL_JsqJr+h7pTvbRR=7eB4ognK70D1pgNXEORGXo=ndND=pMjw@mail.gmail.com>
 <CANAwSgT3jo35xBvkH4GmQcZuZH=D+SRKJ6e9fSBRz45zwuCmYw@mail.gmail.com>
 <CAL_JsqLsEDFv4T1ZMmjaoFfs7WNAjVvOk9o1eTXL2EeGF8uuDA@mail.gmail.com>
 <CANAwSgTuX3t2-SNPe4OAzGuDpL5RotxX8t+Zx+gcwFKdj3ZEng@mail.gmail.com> <CAL_JsqKBhzPwxYguy+N=eddG2nwB54dzw307A6KT5NJpRSh-Mg@mail.gmail.com>
In-Reply-To: <CAL_JsqKBhzPwxYguy+N=eddG2nwB54dzw307A6KT5NJpRSh-Mg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 30 Sep 2025 22:02:28 +0530
X-Gm-Features: AS18NWDpwy8wPfpGXTgiB-hfuQbqsocd9S2KZlBOjIaIkDW6NFhuEmGm8l9CeiA
Message-ID: <CANAwSgTKFSf-EUGSpErdS1Y93AwunFOK7omH4T+gE_z2XttVtw@mail.gmail.com>
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

On Tue, 30 Sept 2025 at 20:07, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Sep 29, 2025 at 10:25=E2=80=AFAM Anand Moon <linux.amoon@gmail.co=
m> wrote:
> >
> > Hi Rob
> >
> > On Mon, 29 Sept 2025 at 19:19, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Sep 29, 2025 at 2:40=E2=80=AFAM Anand Moon <linux.amoon@gmail=
.com> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > Thanks for your review comments
> > > >
> > > > On Fri, 26 Sept 2025 at 19:26, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, Sep 26, 2025 at 2:29=E2=80=AFAM Anand Moon <linux.amoon@g=
mail.com> wrote:
> > > > > >
> > > > > > Convert the legacy text-based binding documentation for
> > > > > > nvidia,tegra-pcie into a nvidia,tegra-pcie.yaml YAML schema, fo=
llowing
> > > > >
> > > > > s/YAML/DT/
> > > > >
> > > > Ok,
> > > > > > the Devicetree Schema format. This improves validation coverage=
 and enables
> > > > > > dtbs_check compliance for Tegra PCIe nodes.
> > > > >
> > > > > Your subject needs some work too. 'existing' and 'bindings
> > > > > documentation' are redundant.
> > > > >
> > > > Here is the simplified version
> > > >
> > > > dt-bindings: PCI: Convert the nvidia,tegra-pcie bindings documentat=
ion
> > > > into a YAML schema
> > >
> > > Still doesn't fit on one line and you say bindings twice:
> > >
> > > dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
> > >
> > Ok
> > > >
> > > > Convert the existing text-based DT bindings documentation for the
> > > > NVIDIA Tegra PCIe host controller to a YAML schema format.
> > >
> > > s/YAML/DT/
> > >
> > > Lots of things are YAML. Only one thing is DT schema.
> > Ok, understood.
> > >
> > > >
> > > > > >
> > > > > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > > ---
> > > > > > v1: new patch in this series.
> > > > > > ---
> > > > > >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 651 ++++++++++=
+++++++
> > > > > >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ----------=
--------
> > > > > >  2 files changed, 651 insertions(+), 670 deletions(-)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/pci/nvidi=
a,tegra-pcie.yaml
> > > > > >  delete mode 100644 Documentation/devicetree/bindings/pci/nvidi=
a,tegra20-pcie.txt
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra=
-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..dd8cba125b53
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.y=
aml
> > > > > > @@ -0,0 +1,651 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: NVIDIA Tegra PCIe Controller
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Thierry Reding <thierry.reding@gmail.com>
> > > > > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > > > > +
> > > > > > +description: |
> > > > >
> > > > > Don't need '|'.
> > > > >
> > > > Ok
> > > > > > +  PCIe controller found on NVIDIA Tegra SoCs including Tgra20,=
 Tegra30,
> > > > > > +  Tegra124, Tegra210, and Tegra186. Supports multiple root por=
ts and
> > > > > > +  platform-specific clock, reset, and power supply configurati=
ons.
> > > > >
> > > > > I would suggest not listing every SoC here unless the list is not=
 going to grow.
> > > > >
> > > > Here is the short format.
> > > >   PCIe controller found on NVIDIA Tegra SoCs which supports multipl=
e
> > > >   root ports and platform-specific clock, reset, and power supply
> > > >   configurations.
> > > > Ok
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    oneOf:
> > > > >
> > > > > Only 1 entry here, don't need 'oneOf'.
> > > >
> > > > I am observing the following warning if I remove this.
> > > >
> > > >  make ARCH=3Darm64 -j$(nproc) dt_binding_check
> > > > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/nvidia,tegr=
a-pcie.yaml
> > > >   CHKDT   ./Documentation/devicetree/bindings
> > > > /media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devicetre=
e/bindings/pci/nvidia,tegra-pcie.yaml:
> > > > properties:compatible: [{'items': [{'enum': ['nvidia,tegra20-pcie',
> > > > 'nvidia,tegra30-pcie', 'nvidia,tegra124-pcie', 'nvidia,tegra210-pci=
e',
> > > > 'nvidia,tegra186-pcie']}]}] is not of type 'object', 'boolean'
> > >
> > > Because you made 'compatible' a list rather than a schema/map/dict.
> > > IOW, You need to remove the '-' as well.
> > >
> > Ok fixed.
> > >
> > > > > > +  nvidia,num-lanes:
> > > > > > +    description: Number of PCIe lanes used
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > >
> > > > > The examples show this in child nodes.
> > > > yes it patternProperties example I missed this.
> > > >
> > > > patternProperties:
> > > >   "^pci@[0-9a-f]+$":
> > > >     type: object
> > > >
> > > >     properties:
> > > >       reg:
> > > >         maxItems: 1
> > > >
> > > >       nvidia,num-lanes:
> > > >         description: Number of PCIe lanes used
> > > >         $ref: /schemas/types.yaml#/definitions/uint32
> > > >         minimum: 1
> > > >
> > > >     unevaluatedProperties: false
> > >
> > > What about all the other properties in the child nodes? You need a
> > > $ref to pci-pci-bridge.yaml as well.
> > Thanks for the input.
> >
> > patternProperties:
> >   "^pci@[0-9a-f]+$":
> >     type: object
> >     allOf:
> >       - $ref: /schemas/pci/pci-host-bridge.yaml#
>
> That's not the one you need. Read my reply again.
>
I'm sorry, I missed pci-pci-bridge.yaml
> >       - properties:
>
> properties doesn't need to go under allOf. Actually, don't need allOf
> here at all.
>
> >           reg:
> >             maxItems: 1
>
> >           "#address-cells":
> >             const: 3
> >           "#size-cells":
> >             const: 2
>
> These 2 are already defined in the referenced schema.
Earlier, I had tried to search for these reference schemas,
but I could not find them.
>
> >           nvidia,num-lanes:
> >             description: Number of PCIe lanes used
> >             $ref: /schemas/types.yaml#/definitions/uint32
> >             minimum: 1
>
> I assume there's a maximum <=3D16?
I will check and update
>
> blank line here and between all DT properties.
>
> >         required:
> >           - "#address-cells"
> >           - "#size-cells"
>
> These 2 are already required in the referenced schema.
Ok dropped
>
> >           - nvidia,num-lanes
> >     unevaluatedProperties: false
> >
> > > Rob
Thanks
-Anand

