Return-Path: <linux-kernel+bounces-839832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A500BB2864
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2026917A539
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF927FD4A;
	Thu,  2 Oct 2025 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKGxZJVE"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088D26B748
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382562; cv=none; b=SHBK6CwZA6F46JcqTTE2bTStu4QOXpvDpD0EkM69gZxGFSK1owzlUuJMxsRL8W2W5gMYpEOYaOdSWAppiL/beCBD6N9pq7Sov2OeQvOm9p0lqT16xVqdQrBjOz7gZPPViPI8eZwks25S16d1INq5fCrJ7g2UN9ledtVBbqfJfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382562; c=relaxed/simple;
	bh=+UEvtO4ohS3SCkCNVu2PUUuKQQlaqciarVlUS651gmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nO8O4xgA6k31ueB9v0QGWtFMrs+YKCd4DxSOfYkT69iBwbScBx3BWHg1KoBbOZGpvFkhFfwAS2SdMfMjrSAvN7c4JvMjY1MPreNZclYW0s1fAi1iPo9dydBzCToaDVVda1dw+/V2oZEDE2yFlVQy3BP9Mpe0luXijhl7+fsxqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKGxZJVE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f44000626bso274687f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759382559; x=1759987359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIoTAVA9sjHnC7mbYGlDJX9XNa4jYRX+mhTFjapnGcE=;
        b=WKGxZJVE9bc9SdJlNJbo6f51KykHP+8ayxVAoueB945lem4+eUB16Iscu5i2SEmc69
         AetrqMXauSPz/IixB1UKxkh5VDFNZdYRXXZj+bzrw2MsWo18aD7PQcgREI+iYYDAr5vZ
         KPEFpPs2JQ3T1P8+86RYn7R/Rtp5/zFvq+LUCXtObyYhdzkjToAS0ulqjpnikjOPs1UO
         q2kMkeSiR7uPHwtLWPhjsH1DA6IXnzPVGoA9V8gRfHiIU5NxB1pBDeG6YBAKSYH0FNnC
         HSjNLCKDdp6GHMzheLmA6vvv2tmWWYCIq7kCTlZ9iL4ll3s63IPYAg77//QIVB8VWX2P
         JRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759382559; x=1759987359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIoTAVA9sjHnC7mbYGlDJX9XNa4jYRX+mhTFjapnGcE=;
        b=G7oasKM4B44BLn62QjECyfrC3xYhkESaHxeXorRO8rmbWeoO0UW+WNKl4XVZgSzn0r
         a0Um24WfpQW+Fd2jpyh6kxuSomEukpzm8v8MI4TGLm9TdHTJ8x/oebp+MEa7N5nZlX5+
         64NHgxs5rtGq+x2uuJglH3BFVQdGSrnExronzyw2vOYsRQeSY93AbehAb9KUN44ndT65
         6qGfm5RXSVxyhqZGseJ8dd3MZT3ECXWseuwyfm4AuM/GsiT/knStm2mFW0zkeYL6Bq9O
         Tn23juTXMvJ+d0/tXTvKzG8Owmov+7UE/NPIwnqZTdWPRT9gBqjSOiE3JZ5ymgjTQWrQ
         TGWA==
X-Forwarded-Encrypted: i=1; AJvYcCVO3GPl8EUi9dDm0lTcAXZ9N0SMqTwGoVgMbjRI+vQdaPDLIWyEYJUaKu4mDFBHEtekPQQp/VKqbickNbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFJxBfZMnIAjgVvgJsnvzhcr8PWMjcbiZUqvnDQPsGWbXG6AZ
	Nd/JIZ5NzOEqTTe7sGsAg8j+K2afR7q52bM67+SdEBelooGfxKEordFVHt46V23EmXY+hfBhW6h
	6oWB/WPssRr2dQk5456mM7qGjvGUz/KH36F4I
X-Gm-Gg: ASbGncvPUQFEfoiSim8wVSeXEDpaf5VYhX/KO0Ohty3WJ9pNaIQBL2KG6Yab4AEWvKh
	Co4KXR3/+ZgEEOMsXOcJh8ZGtVZVnk9/cz6HPl6J9i0krvfHjsJ+/TJvlhpi333yhUvCYlHrPzm
	eNCwBMgWkrUk3rU9qmZ4qNKffbLSAYwyZOo393BLZaTbY9kgDzc+7UiX9RviuxknCPlBRfQgSen
	1A1oWL/ziSksYq/KqdJbrcjRsvfkydM
X-Google-Smtp-Source: AGHT+IG0e+DFVcA7EGV4f6gb3cVHuiVS4JYjGsGK6v4oRblkAeW4rQLj6q0R0ldwH/G+/sN3B7OHJYVi23raS5THltw=
X-Received: by 2002:a5d:5f52:0:b0:3ff:d5c5:6b03 with SMTP id
 ffacd0b85a97d-4255781466fmr4232925f8f.35.1759382558942; Wed, 01 Oct 2025
 22:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925152806.80386-1-clamor95@gmail.com> <20250925152806.80386-2-clamor95@gmail.com>
 <20251002015554.GA2880078-robh@kernel.org>
In-Reply-To: <20251002015554.GA2880078-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 2 Oct 2025 08:22:27 +0300
X-Gm-Features: AS18NWCy4o_ayBLITcbOWaJzzbRVpQSybS31RCoaoa8CEb7E1WnQEhadEGX4bl0
Message-ID: <CAPVz0n150FGUvgmxM8tLyQanWjhsmi4j=DaSa-JW2JSjCM4=tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: media: i2c: document Sony IMX111 CMOS sensor
To: Rob Herring <robh@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hansg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dongcheng Yan <dongcheng.yan@intel.com>, =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, 
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>, Jingjing Xiong <jingjing.xiong@intel.com>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 2 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 04:55=
 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Sep 25, 2025 at 06:28:05PM +0300, Svyatoslav Ryhel wrote:
> > Add bindings for Sony IMX111 CMOS Digital Image Sensor found in LG
> > Optimus 4X (P880) and Optimus Vu (P895) smartphones.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/media/i2c/sony,imx111.yaml       | 112 ++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,im=
x111.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx111.ya=
ml b/Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
> > new file mode 100644
> > index 000000000000..a70017588891
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
> > @@ -0,0 +1,112 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/sony,imx111.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sony IMX111 8MP CMOS Digital Image Sensor
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  IMX111 sensor is a Sony CMOS active pixel digital image sensor with =
an active
> > +  array size of 2464H x 3280V. It is programmable through I2C interfac=
e. Image
> > +  data is sent through MIPI CSI-2, through 1 or 2 lanes.
> > +
> > +allOf:
> > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > +  - $ref: /schemas/nvmem/nvmem-consumer.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sony,imx111
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: EXTCLK with possible frequency from 6 to 54 MHz
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  iovdd-supply:
> > +    description: Digital IO power supply (1.8V)
> > +
> > +  dvdd-supply:
> > +    description: Digital power supply (1.2V)
> > +
> > +  avdd-supply:
> > +    description: Analog power supply (2.7V)
> > +
> > +  port:
> > +    additionalProperties: false
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/media/video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          data-lanes: true
> > +          bus-type: true
>
> I assume not *bus* types are supported, so this should constrain it to
> valid ones. If it is only 1 type, you shouldn't really need the type in
> DT.
>

Better, properties can be dropped and only required left with
data-lanes and link-frequencies. Thank you for a hint

> Rob
>

