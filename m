Return-Path: <linux-kernel+bounces-751597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17317B16B58
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E3518C6A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4D23B614;
	Thu, 31 Jul 2025 04:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe4pY5LF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07541E51D;
	Thu, 31 Jul 2025 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753937310; cv=none; b=EcB0MLXjz55WnfQfVJ+Hra6wkdCu/8g5bAEY/TMHQPhdXpvGy7AQNJDJdovF3sb+HZzQ+vYa+xcq3r5RCw8/773LyXyNNA5MyzDfnrbF8OuTCeTA1dalYP5XtAWtAtuDSm6j/GXDscFB35UVlmWHf3LUA+ccjtwEXHdYQl/wmXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753937310; c=relaxed/simple;
	bh=421rybQ166C4QO6pZb2rKtZco472OCS4dzXrKWAj3r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXgKIMGlexYnf81zbgUf65L4XwD7SCm6ndg/mzgHx4iRS7CIofY2xyVJDbEQCZTMidKLvERTv9eoEA2eGtfnVJG7FccHrJDYHMbOuWVGkjpNWGT4zZV3ar6+0M+1f6lHmU4JAB5skKxKqaP6VIxtEHeUFsGQUKGPpeIn899D29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe4pY5LF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso5009045e9.1;
        Wed, 30 Jul 2025 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753937307; x=1754542107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+OrFG1RW/4OrT91GMBpoWi+WkQwdsqdJLp/SCREI/0=;
        b=Pe4pY5LFqvadR50j+qNBmljfkUr5+cxj3GoHe5pqZhzukmWv8XT2jE/uMKQPpK7jQh
         /x/GTl9dd8kPXlXqGmCNLEfWjukFBWcZKQpFSVbTT6ET2wr6cVX9qys846oVNP7NRwbr
         sehtLyLsCXiL+Xml8BPG/QXvcr1/1owqwoREF5lC3Pa8b5F5ISrMrMm4apHh9q4W6p3N
         zPSJVYn70JHzSUHToqCkIaFCch0nDG/MN1c6y1KdL2YYaQKR0kjKIcDDJclC2bIdecQk
         iWsPrl7AwLc23nzF9zK6ulOJ6DEnSWi7WORNN+CzW7QrfLYGpKFSINQrqSSA/llt0KgJ
         1OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753937307; x=1754542107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+OrFG1RW/4OrT91GMBpoWi+WkQwdsqdJLp/SCREI/0=;
        b=OZdI6tEBJ2c5hCoWU6a1Rfm2T4xd/e375bWrt3Pg8bBRcKazl9dvyM7FrL37dlLy3+
         AQGbtKH1xPI2PCe4dgWr6gMoHx64nmPkJYuq13nOmNxuStukMkVQE8D+UPDLZ5O6FBzD
         KOO56gApvd7QjdXnOXQriwCcWKA6YQkztCokA8Dlj1qKKr2BZSEgf9BjkERy17UGe+iA
         z0BUfXsye+uwT7aKv9mKeyqF8ajjnBmj9Zgyw03UsgEoBEN4JsvsuJcXyPTlhqFH4EGN
         hSokx4QsXM1lLl4mm3KOkEaI7B4tTf8CQovQst/kYokB81pGeiVaDV4uFKiypaXjFiwS
         +sxw==
X-Forwarded-Encrypted: i=1; AJvYcCU4+VoFn0JHrozu0M5WOKIds+1IBdZurCGV3Yi4KaVwDyzp7UGRFFJRW6VFNg757zEpiCX8ugldK0LL@vger.kernel.org, AJvYcCUMIfvB6k5+3COFYarK8S+K06o7fkGkb0MApNs2huJxxRG+fL7422h36RRj7Zn19VWnxSkE5FefCikFP9Nh@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFR9R5prYuZ3KcK9q9pv03duTKnHvjGGcWa2Grtczw4DGpJOV
	bSMVLPu8xfdb5x0Ao7DrXf4ZnZGYn2GI5mtA5fZwl3gyPUu5JI1NZqi4
X-Gm-Gg: ASbGncuZG5YGl7uBj6BYO2YtqdIY0hzKKxNU9FG06iskZVKb1Hf512Y3gHjFfiZvP6O
	+WF9pcnvm99hahWRtgGfVD+mcB0ZdOJswmkjqbnKyz86+0GZXU5KfKDnzqIqoIeYUKgdrUFkxvc
	dT8LcSI0ALMjjVAGITX12j/NOTHn+dVH47cBJBRc+btLOMSJGBf2YmAntLmkHsjtJzqvmi+bKgt
	HlysiotARUrztBsxWEm5oeZRQs0qL7KFK+dv2opeIa/+dbJbbOFCvp88C30ioEmWVXpKfv+FMXd
	/PXy/PENJySMtV0K4d8aUyRARNooxGVxMKxMazKIJD3t+tHOp/9FHjj5D08Skfjr4VF9HFe5KcS
	2FiVW0OyJ0jV11+trIA/9PYKJLRlfBlU=
X-Google-Smtp-Source: AGHT+IFCKD8iIuL/MkTHk1LNw7dIB6eXL268mG1FZ3NC7vk5GOS2xCLYOJP6CKbFGwLGoLV6x8T+EQ==
X-Received: by 2002:a05:600c:45cc:b0:456:2dc1:a603 with SMTP id 5b1f17b1804b1-4589eeb25cbmr7156195e9.5.1753937306889;
        Wed, 30 Jul 2025 21:48:26 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:60f:e800:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cff16sm49305285e9.19.2025.07.30.21.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 21:48:26 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:48:24 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: add support for NXPs TJA1145 CAN
 transceiver
Message-ID: <20250731044824.GA3815@legfed1>
References: <20250728-tja1145-support-v1-0-ebd8494d545c@liebherr.com>
 <20250728-tja1145-support-v1-1-ebd8494d545c@liebherr.com>
 <20250730-aromatic-optimistic-hyena-f1db1a@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-aromatic-optimistic-hyena-f1db1a@kuoka>

Hi Krzysztof,

Am Wed, Jul 30, 2025 at 09:35:12AM +0200 schrieb Krzysztof Kozlowski:
> On Mon, Jul 28, 2025 at 05:39:29PM +0200, Dimitri Fedrau wrote:
> > Adding documentation for NXPs TJA1145 CAN transceiver.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  .../devicetree/bindings/phy/nxp,tja1145-can.yaml   | 79 ++++++++++++++++++++++
> 
> Why isn't this in can directory with rest of CAN bindings?
> 
The directory contains CAN controller bindings. This is a CAN transceiver
binding. And the only CAN transceiver binding I could find so far is this:
https://elixir.bootlin.com/linux/v6.16/source/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
The driver uses the generic PHY framework as the driver for the tja1145
does.

> >  1 file changed, 79 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..10bf2bce1b35788b3284c42e544a56eda6d79947
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
> 
> Filename should match compatible.
> 
Ok, will fix this.

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
> 
> Missing ref to transceiver properties. Look at other CAN bindings.
>
There is only one transceiver property(max-bitrate) which I don't need
because the max-bitrate is known for the device. So why should I add it
to the DT ?
I'm only aware of CAN controller bindings making use of the transceiver
property which I think is because the PHYs they are supporting with this
are very simple which need no or little configuration to operate and the
max-bitrate property is needed to limit the bitrate.

> > +
> > +properties:
> > +  compatible:
> > +    const: nxp,tja1145
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  reg:
> > +    maxItems: 1
> 
> reg is the second property, also in "required:" block.
> 
Will fix this.

> > +
> > +  spi-max-frequency:
> > +    maximum: 4000000
> > +
> > +  spi-cpha: true
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
> > +  - "#phy-cells"
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        canphy@0 {
> 
> can-phy if something like this exist. If not, then probably can-transceiver
>
Will fix this.

> > +            compatible = "nxp,tja1145";
> > +            #phy-cells = <0>;
> > +            reg = <0>;
> 
> Please follow DTS coding style.
>
Ok.

Best regards,
Dimitri Fedrau

