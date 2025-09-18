Return-Path: <linux-kernel+bounces-822815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64CB84BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E31896ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67851D88B4;
	Thu, 18 Sep 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXxzNZJl"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41059305E1E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200581; cv=none; b=cT277MR+uXSXp+w8lTNC4vLLVn+f1YmcY5Qk8Ap4DUUQR/+Zf1YGdRdb5LiqN+1elD7GwN9bHRHiATFhfbPkV7TxdiL7W8vw/NZ0GpIuimJIyJpjYJRl0pkj1smUyVAE9FB0iwZBpR1B6XhQUGSDRBie/beu+HhTC/lOYgCxNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200581; c=relaxed/simple;
	bh=xFgFQQBU+eaUTlmzE+vuY2J0SoHpSu7LpdqT0cdq3tI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNwzo4LQCv/NDiXdh8WEBgXUBchYhGKK8DYkbZWJh/DPlQK7q24djfhqjkNsv6W2r8Di9O1D/OSBuFcXKsxoT4/wWXwfseaaj/GHo7PZdIBOAyOzBt5TsgdpzG5xBer/CZlNZYQhCwGCyLYnOcy0nLlt7YUDKi64zBZxGk1jk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXxzNZJl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so369349f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758200577; x=1758805377; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xFgFQQBU+eaUTlmzE+vuY2J0SoHpSu7LpdqT0cdq3tI=;
        b=UXxzNZJlYwxqS2aMQJXXt8XjFFN2AyuJBeVxiD7DURnzmV79/h1WTluOjRLohmzf5t
         EMbQbp4uPeHECQ6mfYvFdyiBqAU6fLodUxyHBgRAjSKOCUMsXevchLbkz4GXUwJbj2Ms
         l4zBeTvBvCsn7+vcdKFymJGzR5NRNiCaqLV07fjpem4HY9kCtT1I930N+DxS3A5ZVHj1
         E235VkEc834jUZozXnMbXVJC7wACBfGjCN6H+rDDtAhpKMJmQHJdr+m5trzZ8gX7s/8h
         oD+C2Ch5aJLs7kK0I4/LinfIOVvcuR3QFxiQdOWuIadva57XtxpwnFHt+ssJe4+E6oc+
         9JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200577; x=1758805377;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFgFQQBU+eaUTlmzE+vuY2J0SoHpSu7LpdqT0cdq3tI=;
        b=YD3XU+xkVmNtAXK9D128rIXukK3DDdglzCWbIR2QeTMc1b7B8rLlmw+5Gi411Q1/Ph
         tbI6oEJSi6Uy/Bq/uo8CqrI0Qq3UPXiEqg2K73f2q/v/bcBIgQxsvWfLUwHXswHdPP6b
         P7P54hznFnbVk+BB0kochJAuP36cMV/H9PVG5wWI7kZ4B7aE7P+xN1Lnf8AweW0zk2dh
         26N6IVQzVqB43ezz3DF1RpnaGcSA0cbJhh4agg7eqIWyaKq5GRvwRBIcyDuT01M/A9r7
         g6NoQU21JnLgg3t4megbfgNFm61X+67jCn0UbwnVCoK1yP9TVACdLyl/vIKRLfM/0FUc
         l1PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8nsmbAJGEM4J2h76EcRrrvXuKeTCVW9wiNdqJnxKJmUP3qfqd5cZmr2BFz6Q51MO1mJEF0jPVdOlhPTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFllbusLZA7HN5ahOg00B4zEkDpNIa9XKJ8S23lLKboBOlsJW
	XHCykWNsSqGSyQ+1u01V/WcXB0kxLPRWqoylH2qJsb0idiiuJTy5KP27r2rIyRuwouQ=
X-Gm-Gg: ASbGncucMh+SchhdVjcBlAulNq6gIYi59CpMrOX0aqXrBlWJiCXaxYUhLF35i2YtrWn
	o8B4pb+z+ZcEq1uKZDfgiLjgNG4+uF9sZ5UD0IR+DZf+M+qUwgEGawERbvIicnH4grFzEtxs5IG
	/2h+tOJhFpDV00z05e0rhgUenDiabPigp9r5yc/SFCv5YpfcpufQaWBbVooPL01BPk/+ZINjKuv
	5CeHTd4B99l4K6W9UzjwU2gjJiR59PoueQJvvjq5HVCUtTmiNulNaTIA3MCouOhgVZXlbgPGG4u
	R8yX1tvmbynK8PpxjrgFDePZV32aujQcCLkxEtNW/mcZZ8rTfiCfJqikzsz9Bvd1XJtk26EYaAU
	TPLMSEeeRPXORDOvpNz5TkKL8a50GuLDgtlbo/rv9jYzWkLCz0OQ9fcg=
X-Google-Smtp-Source: AGHT+IH4qQOMI9kRkElC4uk5etAMC5b6ho5cgmHk+GAS+1rAKNDqsnHvTpg/dVWhQwEl7v3wwQvq3g==
X-Received: by 2002:a05:6000:2501:b0:3ed:8e48:640f with SMTP id ffacd0b85a97d-3edd43b5ffbmr2760931f8f.8.1758200577315;
        Thu, 18 Sep 2025 06:02:57 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d0asm3646419f8f.17.2025.09.18.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:02:56 -0700 (PDT)
Message-ID: <a55d7e6e6d9515293ca735f25ffd5c925a6ec617.camel@linaro.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Antoine <t.antoine@uclouvain.be>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Peter Griffin	 <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 18 Sep 2025 14:02:55 +0100
In-Reply-To: <c5f2e6e8-2ada-476a-8557-85273b9a93b7@uclouvain.be>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
	 <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>
	 <20250915-presoak-answering-2df6fca532ad@spud>
	 <c5f2e6e8-2ada-476a-8557-85273b9a93b7@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2025-09-18 at 14:36 +0200, Thomas Antoine wrote:
> Hello,
>=20
>=20
> On 9/15/25 7:31 PM, Conor Dooley wrote:
> > On Mon, Sep 15, 2025 at 12:14:11PM +0200, Thomas Antoine via B4 Relay w=
rote:
> > > From: Thomas Antoine <t.antoine@uclouvain.be>
> > >=20
> > > The Maxim MAX77759 is a companion PMIC for USB Type-C. It contains
> > > Battery Charger, Fuel Gauge, temperature sensors, USB Type-C Port
> > > Controller (TCPC), NVMEM, and additional GPIO interfaces
> > >=20
> > > Use max77759-fg compatible to avoid conflict with drivers for other
> > > functions.
> > >=20
> > > The battery node is used to pass the REPCAP and ICHGTERM values
> > > needed for the initialization of the fuel gauge.
> > >=20
> > > The nvmem cells are used to get initialization values and to backup
> > > the learning and the number of cycles. It should work out of the box
> > > with gs101-oriole and gs101-raven which were previously running
> > > Android.
> > >=20
> > > Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> > > ---
> > > =C2=A0.../bindings/power/supply/maxim,max77759.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 78 ++++++++++++++++++++++
> > > =C2=A01 file changed, 78 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max=
77759.yaml
> > > b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..4d45739fcaf26273ec57b=
60049d6d0421df38efb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759.y=
aml
> > > @@ -0,0 +1,78 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/power/supply/maxim,max77759.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Maxim Integrated MAX77759 fuel gauge
> > > +
> > > +maintainers:
> > > +=C2=A0 - Thomas Antoine <t.antoine@uclouvain.be>
> > > +
> > > +allOf:
> > > +=C2=A0 - $ref: power-supply.yaml#
> > > +
> > > +properties:
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 const: maxim,max77759-fg
> >=20
> > Compatible doesn't match the filename, why?
> > I assume the "fg" is fuel-gauge, but can this device be anything else?
>=20
> The max77759 is a multifunction chip.
> The following compatibles are already used for some of those functions:
> - maxim,max77759 (for the pmic)
> - maxim,max77759-gpio
> - maxim,max77759-nvmem
> - maxim,max77759-tcpci
>=20
> The fuel gauge functionality that is added with this patch is very simila=
r
> to the functionality of the max1720x which is why the filename was chosen
> to fit other maxim fuel gauge chips pattern.
>=20
> Maybe it would be better to use the maxim,max77759-battery compatible to
> match the filename? It would also fit with the already existing
> maxim,max77705-battery and maxim,max77849-battery compatibles.

It also has a (battery) charger, a -battery compatible could be misleading.
The datasheet refers to these subblocks as FG (for fuelgauge) and CHARGER.
I'd suggest keeping those terms.

Additionally, the FG block can also measure temperature and battery ID. For
those, a combination of (top-level) PMIC and FG registers are needed
unfortunately. Which means that the FG should probably be an MFD child
device, even though the FG itself doesn't depend on the top-level. Otherwis=
e
it'd be hard to access the top-level PMIC register.


Cheers,
Andre'


