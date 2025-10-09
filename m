Return-Path: <linux-kernel+bounces-846880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647BCBC9528
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C913A5B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CCF2E093A;
	Thu,  9 Oct 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nNQHAAbT"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C40450F2
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016878; cv=none; b=k9fGLXSWniBK+D4hf6ojMv90eCVHTIcIgtDLNWcZHyiX8AlPtXxjjuAzbycd5j8FmXnvbiE7R2Sb/Zums/5MWFRLy4cFWtKcpEWfAtJfI8a3dYzmbyDG4oK+jP34umQU1ZJQoWDcY47/47XPX/aanqvZU7d9FuN+jEg0MqVks6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016878; c=relaxed/simple;
	bh=lLCmM9foRlsu43SQNNjwJvzcXcQ42xByO22XUF+i63A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOpopZN6DjgiX3M8/giJw1LylUoAS2hAJ50c3pozEydsmrDsQIaRnalxhxTBwit/mpnHFPalQVNileZMZ+CSmwVPF6swevGS/q2giwYgv3egHX25hbIpjs1g0SOCzNjjVeE+rS6AR6aftYjMWWNoWf2GuSC4l4y9GVAWqwipLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nNQHAAbT; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-373ac916b35so16348611fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760016874; x=1760621674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dSErVy5gy3iTqfs+Fv+uBfQPNdt1PnHnP4LjyzMeiA=;
        b=nNQHAAbTzcnDRdpgBFABbvUftF3azzU+g/NQDvWd2xwtfLIK/S9Orx5I6Y5TaS8sHz
         b535J7ANx/wyEYdtu8liqVimuSf0Yr3QepNzDNW4Us29sspEf3bfnyP2t0OrVjR5IrYq
         CMqVQfE6p+GvMqSyIi42DoHeAwt5Ou5FZlWpE4l8imv6IlHFgMEQfdFRUVOmQ4PEyNHO
         i8yeahV7HRT5h6ubbCLxXKcktteAWiW9HcqJekcIhvuHTYUdLUETkUsjovlf5OEMAxFU
         o4QvOaCKRmckIHN+nT4fFaVJdmpQRJeMaG/f2PzJMvcHWF/5k75/bPIVxHIH+VbKPGf+
         7gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016874; x=1760621674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dSErVy5gy3iTqfs+Fv+uBfQPNdt1PnHnP4LjyzMeiA=;
        b=Cj8kx35Ux5VfW3tTzxlvy2k3YtScRwTU48hGMEnar/4wWLHQcbyVYg6Xvq4+x++iBX
         HmfK0KCMauwTi7veOlgry6rlE2VCjT4A7MW9zwSQpm1UOxKdw3OHJVUwO4k4RhauOcE3
         76Qx3Qgu50d3qQ6wRHs3+E/sb8wzDUt30DooiYdiJGdGEqZEXYlVSRVaB5htu+JP2rAK
         JoS+JifH5IF3jR2q/9UER543QvCegnSkYKzIMCqByfOXf3pk5Bh4yHXB3qWjbs3fJ81Y
         dGtKABkAzeFzEh2PhFk0p+L2wneC7oBZ8gkOQ3YTBL5GPx7RRYOCs7Twvx7L9OYR7PCG
         PBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0C6caYWC49Gr/G1XOKcxeut9yBqKZ797a+JVLg8R7Qilp7+2U55v7TCG2N4rVZLC2W1c0L5E2JkNfUMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/45REo4aWsHosDFasb/dRMOaP2TOXhnRNokBaXrWELoCKJsnh
	Wz+/tnGAPbwek6wds3orzHLXNkW0euBeBMsmCoZxOOuX5xtvAM4SdakcnTueOYSEu8ZPCwaLUXw
	JFuL3g0N459XxU0f5t+lrX2oHaqSIEPdmQeaZhUy29Q==
X-Gm-Gg: ASbGncuPeR1ZJeKA6THUeuHXNpct9YlnpQaL5xKBWSIbwb2QyXB3n1jXHG4AV3tFaga
	fX4VvVB1QECxbhiOhltKoBTOampPfcQr+6e5fRV96MahJnOlXw1huHGnkl4UbW3LYrksT0sQwvO
	A+beeDinv0c7bToYSa5GERh+ZQvHd+1aX2csBdeSuKoYGBZz/7I+YQQ5Dw7cG11PNrd7nN2cSjg
	Ab+4VYzUxhZMgTATtK0shFZ2+TAllzG5Pt2ZI/k/w==
X-Google-Smtp-Source: AGHT+IHWWJUMwgLO59lk5lakKRaZ+/wVoeJhFN8a16uOzpMmsGJAl1afZO0Y0UWvv4eDfAIFgKUZh54hbk7hVJVmV4E=
X-Received: by 2002:a05:6512:23a8:b0:571:d258:5639 with SMTP id
 2adb3069b0e04-5905e398890mr3351104e87.25.1760016874419; Thu, 09 Oct 2025
 06:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-2-apatel@ventanamicro.com> <20251002192506.GA236729-robh@kernel.org>
In-Reply-To: <20251002192506.GA236729-robh@kernel.org>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 9 Oct 2025 19:04:22 +0530
X-Gm-Features: AS18NWACKtl7ERcN8H5MlfK2QBMUHI9VMMe2RI6b1AOyUjn27L1IFJvaV0ijKkc
Message-ID: <CAK9=C2WO5vNs0Y_w8Pk9WWMeYe8Kxhaow5b_QxQWfobL5mrZoQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: Add RISC-V trace component bindings
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Greg KH <gregkh@linuxfoundation.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Mayuresh Chitale <mchitale@gmail.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Apologies for the delayed response ...

On Fri, Oct 3, 2025 at 12:55=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Oct 02, 2025 at 11:37:22AM +0530, Anup Patel wrote:
> > Add device tree bindings for the memory mapped RISC-V trace components
> > which support both the RISC-V efficient trace (E-trace) protocol and
> > the RISC-V Nexus-based trace (N-trace) protocol.
> >
> > The RISC-V trace components are defined by the RISC-V trace control
> > interface specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../bindings/riscv/riscv,trace-component.yaml | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/riscv,trace=
-component.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/riscv,trace-compon=
ent.yaml b/Documentation/devicetree/bindings/riscv/riscv,trace-component.ya=
ml
> > new file mode 100644
> > index 000000000000..78a70fe04dfe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/riscv,trace-component.yam=
l
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/riscv,trace-component.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V Trace Component
> > +
> > +maintainers:
> > +  - Anup Patel <anup@brainfault.org>
> > +
> > +description:
> > +  The RISC-V trace control interface specification standard memory map=
ped
> > +  components (or devices) which support both the RISC-V efficient trac=
e
> > +  (E-trace) protocol and the RISC-V Nexus-based trace (N-trace) protoc=
ol.
> > +  The RISC-V trace components have implementation specific directed ac=
yclic
> > +  graph style interdependency where output of one component serves as =
input
> > +  to another component and certain components (such as funnel) can tak=
e inputs
> > +  from multiple components.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - qemu,trace-component
> > +      - const: riscv,trace-component
>
> Given the generic-ness of these names, I'm assuming the exact type of
> component is discoverable. I don't like to assume things in bindings, so
> spell that out.
>
> Is the implementer discoverable? If so, you could omit the 1st
> compatible.

The component type and component version is discoverable through
read-only MMIO registers but the implementer of the component
needs to be inferred using implementation specific compatible string.
I will add some text along these lines in the above description.

>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  cpu:
>
> 'cpus' is the more standard property.

Okay, I will update.

>
> > +    description:
> > +      phandle to the cpu to which the RISC-V trace component is bound.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>
> which already has a type. So just 'maxItems: 1' here.

Okay, I will update.

>
> > +
> > +  in-ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    patternProperties:
> > +      '^port(@[0-7])?$':
> > +        description: Input connections from RISC-V trace component
> > +        $ref: /schemas/graph.yaml#/properties/port
>
> If the N ports are N of the same data (like a mux), then fine. If each
> port is different, then you need to define what each port is.

Yes, the data (aka trace packets) is the same for all input trace ports
even in-case of funnel (aka mux). Same thing also applies to the
output ports.

>
> > +
> > +  out-ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    patternProperties:
> > +      '^port(@[0-7])?$':
> > +        description: Output connections from RISC-V trace component
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    // Example 1 (Per-hart encoder and ramsink components):
> > +
> > +    encoder@c000000 {
>
> Perhaps it is time to standardize the node names here. Perhaps 'trace'.

It is better to not fix the node names because this allows users
to infer type of component from node name hence more human
readable.

>
> > +      compatible =3D "qemu,trace-component", "riscv,trace-component";
> > +      reg =3D <0xc000000 0x1000>;
> > +      cpu =3D <&CPU0>;
> > +      out-ports {
> > +        port {
> > +          CPU0_ENCODER_OUTPUT: endpoint {
> > +            remote-endpoint =3D <&CPU0_RAMSINK_INPUT>;
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +    ramsink@c001000 {
> > +      compatible =3D "qemu,trace-component", "riscv,trace-component";
> > +      reg =3D <0xc001000 0x1000>;
> > +      cpu =3D <&CPU0>;
> > +      in-ports {
> > +        port {
> > +          CPU0_RAMSINK_INPUT: endpoint {
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +    encoder@c002000 {
> > +      compatible =3D "qemu,trace-component", "riscv,trace-component";
> > +      reg =3D <0xc002000 0x1000>;
> > +      cpu =3D <&CPU1>;
> > +      out-ports {
> > +        port {
> > +          CPU1_ENCODER_OUTPUT: endpoint {
> > +            remote-endpoint =3D <&CPU1_RAMSINK_INPUT>;
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +    ramsink@c003000 {
> > +      compatible =3D "qemu,trace-component", "riscv,trace-component";
> > +      reg =3D <0xc003000 0x1000>;
> > +      cpu =3D <&CPU1>;
> > +      in-ports {
> > +        port {
> > +          CPU1_RAMSINK_INPUT: endpoint {
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +...
> > --
> > 2.43.0
> >

Regards,
Anup

