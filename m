Return-Path: <linux-kernel+bounces-852551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E36BD94E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1964242FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF354313536;
	Tue, 14 Oct 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e26WMm9v"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2543128C9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444373; cv=none; b=OVwiFlQ2ScLgIbxFCtlZlfPwoQcOmRb2PmooUcqkevisZU+Df3g90B83VVwQ4SpzO+Fd+4BX646wPWH1qo8byBcJH58PZvKktHCpVUkFLJc3QnGE4uYInLGGxoV5IxwzHgZjeCUFr2Y9PaWRgXopkSimdesxbT8ExjrIiBSUZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444373; c=relaxed/simple;
	bh=+1zKWPalXJXneZqiPMx/hvBzngz50IBlE4Ff9W5rpR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFT31nSByv7Hp0D1zX7Vg6g/k09VHaBGXcsPZyQi3JPKfEQOi8F69+JxJKfBbn41iCfuzdKGkhi03fiRuROLbi0z169T0NU9e3fLFMvp2F9BaMYkliNfsn8zB67CeqslDm1MN/Zx9ieXjy73Xy6AkTPPKi5Eq5IWHJ9bNcVQZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e26WMm9v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e504975dbso31308645e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760444369; x=1761049169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NXdPaciUzkmwtjhiuah7SoNF0Jn6KSlADxbD7J4quk=;
        b=e26WMm9vhN0WQKhBXNjOyExqeKe9OZH/fr6UOa8LFDIsZBiNngzbchRNqfW2GEc1c9
         LRnoZh76Dp7ZCZ+RHjJuXwZVjhq3vGzid88euy0tKLYwHgCnEXUF3b6EgIPnrz207CKP
         cmeh8TlEdWcLwCJZh7TfGVlmwObc/JVOrkb0HhqC4qk8uStYd4QPxkehGS2RydX62Awl
         lN+eoCbeNFzpk3AcVkNAlSrKNfj+fmn6dtq41Rp40VRTjrhnXwnC8YxwBq6y+OtdZdhX
         EM4L63+/7iqHHItUK0YXR1zCwhwswwLbvRz9rALJhlLZ4ffWqpXCA+3wzlLJTgc2w7xq
         mK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444369; x=1761049169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NXdPaciUzkmwtjhiuah7SoNF0Jn6KSlADxbD7J4quk=;
        b=Mb1YP5tPjmBV0uff6aUR1q884EspBm+rS0FHiIkFVLHKEu1evkkt+8cZMcB4QKA2c1
         vW5ybkf3hCz0ux4261/ME0f6/Yqz6pEKNYcAl3RVECIjVJMCvvtZ+5SWkDzn0bZQgIU6
         pP5u7bPmSwikCfbZJxYdAj9XbvrLm3LU/+RUmVMH1beW3Vmtn9JNSvYkFnbRHLJGrL4I
         udmEzeXokAL+y3+YDK/f5lbqBeIqpY+tLNuFonbyZvw0vNgvVzKnC4FjsBTZ8wqsWFhb
         ZldGL6Nb0dIJflsCYrDsFg+JjPgdB//sOy0Ubi2EIWJ2JuXWhIYVsjk4HE4Mmzb79HpZ
         JptQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7my3gNNakrDPDsk8EhEqdO63J+HPB86B7T4Fpz/jUpH/Iic99bxQ3IDAxe29gsQTXZXOKwjf15JH6dL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCf3Z6CVPaP/Ac1YnI3LJ8F6DkcjGEJJ0awyzBZseihMvFg6nZ
	GGMsMohz7vqA2brYFetaIdhWDCTeCSUxx4hfXfEPhDxfX0LWR66ynKOr
X-Gm-Gg: ASbGncv5ZAOVDkDCUHD5LSJ8cFNJ50QcMFPfelqSFntfOqBmVrE4HqcYCaZRNd9hhrU
	e5n8xER63/PsHTxAUvb30Qn1wYFPwK2LkQp23D7NT/N0pFVIeG374YOEQPhP18y6rgtRLbqWxpc
	HmYQ6W3CT2PcBKntezPk8E6qaFfGCBxgASRBBJNIYOVlIwOOGc0eHVYLWyAKMplAXG6w+VOTKlt
	PrZcDvb7s/1NjrONkHvEuex5ObSn6VcBRAIy6p6tXk0gc4m9G9V1cKKxt1hhoffoHY6YIBwSYGA
	hJ99T4/Bjm+EH4SouNBbpOUW2aEOMMpXnUtXwMTn4ND5TX8Xr3OlnTZlqZcqmFSn21Yw1qKwkfK
	+/X8XslaXmFPWvKY2AeOVlIasSwS4a3o/k3f2gZcxohCWnwjO7uuE0loe7n4=
X-Google-Smtp-Source: AGHT+IEtq2qk43DUx3Tekk3H1O0Yj52quZDJgPjlvM1teoyT/1HnDwsFwZ9RqTFP55MEyX2ZO4zCeQ==
X-Received: by 2002:a05:600c:820a:b0:46e:4704:b01e with SMTP id 5b1f17b1804b1-46fa9a8631fmr169279315e9.8.1760444368506;
        Tue, 14 Oct 2025 05:19:28 -0700 (PDT)
Received: from legfed1 (lis01.vpn.liebherr.com. [193.27.220.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f3fa3bdasm985060f8f.46.2025.10.14.05.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:19:28 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:19:26 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: add support for NXPs TJA1145
 CAN transceiver
Message-ID: <20251014121926.GA63762@legfed1>
References: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
 <20251013-tja1145-support-v3-1-4a9d245fe067@liebherr.com>
 <20251013-supplier-edition-0ffc88286b5d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-supplier-edition-0ffc88286b5d@spud>

Am Mon, Oct 13, 2025 at 08:41:49PM +0100 schrieb Conor Dooley:
> On Mon, Oct 13, 2025 at 11:19:18AM +0200, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > Adding documentation for NXPs TJA1145 CAN transceiver, which resides like
> > the ti,tcan104x-can.yaml in the same directory as other generic PHY
> > subsystem bindings. At the moment there is only support for simple PHYs
> > by using regulator bindings in combination with can-transceiver.yaml or
> > PHYs that implement the generic PHY subsystem like the NXP TJA1145.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  .../devicetree/bindings/phy/nxp,tja1145-can.yaml   | 79 ++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..3b81a2e1ead8452ed5fcf2021f33d628d4e12346
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
> > @@ -0,0 +1,79 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/nxp,tja1145-can.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TJA1145 CAN transceiver
> > +
> > +maintainers:
> > +  - Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: nxp,tja1145-can
> 
> I'd drop the -can here, since I don't think the device can be anything
> else?
>
Will drop the -can. Device cannot be anything else.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  spi-max-frequency:
> > +    maximum: 4000000
> > +
> > +  spi-cpha: true
> 
> Is this optionally cpha or always? I'd mark it required if it is always
> needed for the device to function.
> 
According to the datasheet it is cpha. Didn't test if the device is
running with a different configuration. I mark it as required then.

> > +
> > +  spi-cs-setup-delay-ns:
> > +    minimum: 50
> > +    default: 50
> > +
> > +  spi-cs-hold-delay-ns:
> > +    minimum: 50
> > +    default: 50
> > +
> > +  spi-cs-inactive-delay-ns:
> > +    minimum: 250
> > +    default: 250
> > +
> > +  vcc-supply:
> > +    description:
> > +      CAN transceiver supply voltage
> > +
> > +  vio-supply:
> > +    description:
> > +      Supply voltage for I/O level adaptor
> > +
> > +  vbat-supply:
> > +    description:
> > +      Battery supply voltage
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#phy-cells"
> > +
> > +unevaluatedProperties: false
> 
> If the properties you've listed above from spi-peripheral-props are the
> only ones suitable for the device, I think additionalProperties: false
> is sufficient here.
> 
I switch to additionalProperties: false then

Best regards,
Dimitri Fedrau

