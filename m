Return-Path: <linux-kernel+bounces-744097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04847B107F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B347A3713
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD826980E;
	Thu, 24 Jul 2025 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij5GF3TL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA1267732;
	Thu, 24 Jul 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353724; cv=none; b=ZmT1PIjU3Wn6LB6N/SFM6vMAdhfHIu+JuJPYouqI1yN60W0844t6bM7fyuPJOkkcBmdeQd7ilkZhvkSRAef1CWcYS4vVYyYmEIwGJv0KwaNZtZybebrGnbZALX81NAB89KmVTzIvNKN9veRt9hMebOJGUb0u0DhU5tLDAxWMp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353724; c=relaxed/simple;
	bh=mCKEW6/KqNeqo19+vOe+eL12z6sA/4SWr9mucf2bm9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmEnwzKINIt6OqFNKAZxTq52GXGFYRICQ2SDuSmBCd0LsEhBLLQCJtT288BdZtAW3nyIryooWfXnmi3rE3G1f26A5phwm0xzDotJSDbDuh3cIdLLweROkHQZ0mw5Xrkh1WZSeyjYA7De91kImDfqouu9FVmbWpYXe1yJN1Rlw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij5GF3TL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a510432236so606470f8f.0;
        Thu, 24 Jul 2025 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753353721; x=1753958521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VuhuHbBmeifTsbb3fFBxEKhPdDmR0mlneU3PFRFcuhI=;
        b=ij5GF3TLEPev2YdGnwATY2WDi2urMNE47z9gZhHoiiP6L9xmA7NcIo5iiuL/mdO+ez
         THsykfo1HgGXSgQVZmGcv1zQj0icFcXiA0vdbvJynLsKybz7m+Wz+mACePBqOg22BoZc
         ehE1z6dQkyuPJ0KdJGreflRNyvBPz0FYBnTaYHL7w5SRlpjWXp+cnahfcx7cvM0Gsglf
         tna/PlfL2oUXtxFJBlmL8kWJt+y9/7Guqka6D3BrLbmWs5Fl93T2HnL2Z1huoHshTiQ6
         23Mhk5gnPggwCnLCFucNtUvGxxuCzEYNnRzjWcmSoIeHgZK+Pb9L590xaXj2eKLZK1K6
         qEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753353721; x=1753958521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuhuHbBmeifTsbb3fFBxEKhPdDmR0mlneU3PFRFcuhI=;
        b=qTRVT6BXbDxU8ocdgLbKuIVTq5v84W1SuuanG3Tr6/kz4veUdcnktV2LLm8GNHmDD0
         TrGaJkEy1rdiUvXFE8c02V9dZQuxBfZCOAYrhxkGOrzw8nfI3gVTe9+v2Gpm9/iiQww7
         SS1+ILvfOylhmAmix62mSfJ8rt0Yecblgiprh/vLZDDOiKHfqcCoXtOI70wEHJcYWJMX
         MVHmKviy37M0IV+AddvlRyKa1JtynqE9QoWCaGanQBOqnf/3K4cGAlrpzyosU55mGodn
         E3sfOftRBKMVJy2cueyPXUQ7klghp/37RF+rsn4nLJjHRKon/iDieJivanGlWOYgsOFV
         da5w==
X-Forwarded-Encrypted: i=1; AJvYcCVA+ogRvjlVXOh7F/cU5EphXpbBK/1ndq0JfWlA3ztEcBxktPay1DC57pZZFg53ccn4Y0gcO5PzFtRgUTPw@vger.kernel.org, AJvYcCWtW5IdSNWxOtjWfPthoQjG9fLaFckYl1zmm3D7TMlkfpYxr7HUeU1hh8GJRKyM5RCGK3pgjHH6JY+i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/S0qDXnf5HzOk2EZy3PXYrC9kJv2l+YI/+g0qu8zCtH3rlTJ
	5eBlJKFVNWvyda9vVxj1k5omanMukjoABOyJI24II3VfoFSwVBqRy4bW
X-Gm-Gg: ASbGnct11JZXfZklDAvFBdMVJ5aB9OtAkkt7lcY2v/T3dU36JN2Zn/+8KMfrkbnyIYO
	rnC1IX4t38GcOhgTwJ6htvGjeY7Dbac6CnUD65u+AS2fu77c/iu1fPCPCejAiDv4fnhrJyA7iwc
	8fTjidlfMUa0G1pN7NXeXbcC2mH8XX3EAE3/toK3CvfNbzmKFT4O/+SCDClBVANLcuPKhKq0E9g
	om7bU6iE5Enndfa2DnUSaf+04wp/MPTfS5eKZCxF+hUjPAgTWSDUppwO3ueKYGrs1GIsJOv70Ef
	YaCRlzKwJq58ec69eg52fyHEOJFQBgeBRgBB+nua5948OUI2i7N0BOOOGuPOSoE39jsWlL+llv2
	Qk6lxcVhMjeL9MU4sork7XM8LHSdD7n0gjgYh5FrxkLRg9nGHiLb32Q==
X-Google-Smtp-Source: AGHT+IHev4fUzCaklvZiT4w7bm1C1QbDRx77ancF77FzVoueNZXiu6S14A8hR65jLlLCu51WRc4AXg==
X-Received: by 2002:a5d:584c:0:b0:3b4:9721:2b1c with SMTP id ffacd0b85a97d-3b768ee078emr4914068f8f.6.1753353720183;
        Thu, 24 Jul 2025 03:42:00 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870553c78sm15344185e9.15.2025.07.24.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 03:41:59 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:41:56 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Jorge Marques <jorge.marques@analog.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <7bbopefg4ordtycyoeqijegzzhypqj7w6l7gjkacjl2hz6olce@npzdsv4j6eto>
References: <20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com>
 <20250717-adi-i3c-master-v6-1-6c687ed71bed@analog.com>
 <20250720232726.GA3055763-robh@kernel.org>
 <20250721-large-daffy-vole-d2d25d@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-large-daffy-vole-d2d25d@kuoka>


On Mon, Jul 21, 2025 at 09:37:39AM +0200, Krzysztof Kozlowski wrote:
> On Sun, Jul 20, 2025 at 06:27:26PM -0500, Rob Herring wrote:
> > > +description: |
> > > +  FPGA-based I3C controller designed to interface with I3C and I2C peripherals,
> > > +  implementing a subset of the I3C-basic specification. The IP core is tested
> > > +  on arm, microblaze, and arm64 architectures.
> > > +
> > > +  https://analogdevicesinc.github.io/hdl/library/i3c_controller
> > > +
> > > +maintainers:
> > > +  - Jorge Marques <jorge.marques@analog.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: adi,i3c-master-v1
> > 
Hi Krzysztof and Rob,

> > If you want to use version numbers, they need to correlate to something 
> > and you need to document what that is. I don't see anything in the above 
> > link about a version 1. Kind of feels like you just made it up.
I will need a week or two before resubmitting the final version style.
We are in the process of reviewing how we version things in general
and how to comply with internal guidelines also.
For the IP Cores, it was already an internal guideline to use semantic
versioning, and I am making it public here:

* https://github.com/analogdevicesinc/hdl/pull/1831 :

  The IP cores typically should follow `Semantic Versioning <https://semver.org/>`
  ``v<major>.<minor>.<patch>`` format.
  In summary, a fix increases the patch number, a feature the minor number, and a
  breaking change the major number. The first stable release version should be
  higher or equal to v1.0.0.
  
  Device tree compatible take the major number prefixed by ``v``, for example,
  for *axi_my_ip* v1.2.3, the *compatible* is *adi,axi-my-ip-v1* and the
  *dt-binding* filename is *adi,axi-my-ip.yaml* (no major suffix). Per the last
  paragraph, *adi,axi-my-ip-v0* is **never** appropriate. Software drivers parse
  the ``VERSION`` register for feature handling across versions. The patch number
  shouldn't have to be handled by software drivers, if it seems necessary to,
  consider incrementing the minor number instead.
  
  Due to AMD Xilinx old default IP core version, many IP cores bindings start at
  1.00.a. For compatibility, the patch value is kept, but should be treated as
  decimal instead of character.

(I should have had put as a dependency in this patch submission).
The dt-binding major suffix correlates with the major version it
supports all v1.xx.xx releases.
It takes time to get to a final format because versioning may mean
different things to different people/scopes.
The PR that bumps the core to v1 is here and should be merged in the
following week:

  https://github.com/analogdevicesinc/hdl/pull/1724

At the linux level, should I add the following to the
adi,i3c-master-v1.yml?

 +Description: |
 +  FPGA-based I3C controller designed to interface with I3C and I2C peripherals,
 +  implementing a subset of the I3C-basic specification. The IP core is tested
 +  on arm, microblaze, and arm64 architectures. The IP Core versioning follows
 +  semantic versioning and divergent major versions are not compatible
 +  with this binding.

or create a dedicated file for ADI IP Cores with the guideline?

> 
> I asked already at v4 to document the naming/versioning, which was a
> result of one of previous discussions, in the binding description. :/
> 
> > 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    minItems: 1
> > > +    items:
> > > +      - description: The AXI interconnect clock, drives the register map.
> > > +      - description: The I3C controller clock. AXI clock drives all logic if not provided.
> > 
> > Is that a description of how the h/w works? The controller clock input 
> > can literally be left disconnected? If 1 clock source drives both 
> > inputs, then the binding should reflect that.
>
It cannot be left disconnected if the IP Core was synthesized for 2
clock inputs (1). The dt-binding reflects the topology dictated by the
synthesis parameter.

(1) https://analogdevicesinc.github.io/hdl/library/i3c_controller/i3c_controller_host_interface.html#configuration-parameters
    ASYNC_CLK

How about then:

  +      - description: The AXI interconnect clock, drives the register map.
  +      - description: |
  +          The IP Core may be synthesized with a second clock input
  +          called "i3c" to drive the internal logic asynchronously to
  +          the register map. The absence of this entry reflects the
  +          topology where the "axi" clock input drives all the internal
  +          logic. 

> This was explained in reply, but never made as proper explanation to the binding.
> 
> Jorge,
> When you answer to a review about uncertain pieces like that, usually
> outcome of the discussion must end up also in new patch - either in
> commit msg or better in the binding itself. I also asked about this -
> documenting the outcode - in v4.
> 
> Best regards,
> Krzysztof
> 

Best regards,
Jorge

