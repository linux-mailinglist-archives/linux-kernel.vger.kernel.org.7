Return-Path: <linux-kernel+bounces-891542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 246BDC42E30
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 324DC4E933A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4721EA7CB;
	Sat,  8 Nov 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="rx+uvZ3B"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4E1C84DF;
	Sat,  8 Nov 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611683; cv=none; b=qK0rDH+BK5KCuHSmtuM+/wOcevaaGXlNbccW/vs/miWozU6kNh3/QaGP+CAsVnPWECYVfBcgUaCHwE2elMKAgFDVGcQmkNrQddxUJcv5NvTUrDhX0aen9KhaPcDSh8vPTmOBfCb/PDL6ZINkmZS3UEduEziSEYkKQLQRYimaLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611683; c=relaxed/simple;
	bh=PXg7E1CyCSktm5smzwdhzbzx/0EVSt3oxzgJwWhcu0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cT2FfgCA7/go4PI+eDhVC9qo+JWWkYRV+LTO69eg+fIA56hlWfans/F7MpvpNLpNircPugBLwjL/Ob9lk7TyYkkiumjGQxILhv2/K/Kx/RfjOJPt9NPj5cSiijVto9fJDmQISMBygqLymS5PjWBTENmYR7bDfS0jsOjiVP/KGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=rx+uvZ3B; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yY/Mw/fA6kA1tDgGp7D6XVfmNBQBiknCOSNWaztlke0=; b=rx+uvZ3BNntqZcdm1nm4mz20cj
	UXhcEa37E/wxuHfnmWmyQWb0OEKp/jWuHN9B4g5I6vQ/QjnUDKrcS1DdGwNRdsYU6qHQvJhpT5x6h
	3A44EtJyjwdKZrAQBqZ0PEx8XK4I5I1xsyHpPkYmw8ua9cnVR24+izd4mE3zig8xYv1ABmbc4TZEp
	KMJlmDgTFTauVo57gMknIYQtfNJxtLd7o+4KXnqEqGBBDXMqM9ekFXrl3oxIWO2wRQQkuz6fgbToN
	dFJnwNoe5LFgOFs2G4yujvMprvl04Bvjv0S5hsaE3KE5lF8DyvZ1IiTem4b0XL4uc1mDr2xh/tMt0
	uQLcVUOQ==;
Date: Sat, 8 Nov 2025 15:21:14 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add Fitipower FP9931/JD9930
Message-ID: <20251108152114.53422ea6@kemnade.info>
In-Reply-To: <20251108-vagabond-lyrical-hawk-ad3490@kuoka>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
	<20251107-fp9931-submit-v1-2-aa7b79d9abb6@kemnade.info>
	<20251108-vagabond-lyrical-hawk-ad3490@kuoka>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 13:17:31 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Nov 07, 2025 at 09:06:45PM +0100, Andreas Kemnade wrote:
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: fiti,fp9931
> > +
> > +      - items:
> > +          - const: fiti,jd9930
> > +          - const: fiti,fp9931
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#thermal-sensor-cells':  
> 
> Why is this a thermal zone sensor? Aren't you mixing temperature
> reading with soc? For temperature reading you can use hwmon, for
> example.
> 
well, I just took the SY7636A as reference. Is there any document describing
the terme "thermal zone sensor". I would define a thermal zone as an area
with things influencing each other thermically. These things are
sensors, heat sources and sinks. Well, the panel typically does not produce
much heat.
But I do not insist on having that property here. As far as I understand,
the hwmon uses this property as an indication to also create a thermal zone
sensor.

> > +    const: 0
> > +
> > +  enable-gpios:
> > +    maxItems: 1
> > +
> > +  pg-gpios:
> > +    maxItems: 1
> > +
> > +  ts-en-gpios:  
> 
> It's called EN_TS, so en-ts-gpios.
> 
ok
> 
> > +    maxItems: 1
> > +
> > +  xon-gpios:  
> 
> That's powerdown-gpios, see gpio-consumer-common.
> 
looking a bit around: powerdown-gpios e.g. in the MCP4801
describe an *input*, which should be connected to an output of the SoC. 
Looking at the datasheet, I see "XON Open Drain N-MOS On-Resistance" so it is
an *output* (same as for PG). So it is something different then the
powerdown-gpios in e.g. the MCP4801.
So it is a signal coming from the JD9930 after EN goes low in the power down
sequence.

> > +    maxItems: 1
> > +
> > +  vin-supply:
> > +    description:
> > +      Supply for the whole chip. Some vendor kernels and devicetrees
> > +      declare this as a non-existing GPIO named "pwrall".
> > +
> > +  fiti,tdly:  
> 
> No, look at datasheet. What values are there? ms.
> 
Hmm, no to what? I do not understand your comment.
So I guess a bit what might be options to discuss here:
- put raw value for the bitfield here (what is currently done).
- put the ms values here (then I would expect a suffix in the property name)
  We have the mapping 0ms - 0, 1ms - 1, 2ms - 2, 4ms - 3, so it is
  not identical.

Regards,
Andreas

