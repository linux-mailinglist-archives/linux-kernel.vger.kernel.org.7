Return-Path: <linux-kernel+bounces-891589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45206C43020
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D46B74E3519
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9D22F74E;
	Sat,  8 Nov 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="A/N5y4PY"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A0158874;
	Sat,  8 Nov 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762620773; cv=none; b=Zh01wtKyxlJ5VS5Ggy/x/rBYvVHT2ILRgirQpg+4DdhBF6K1cWyVtK1SH1pyT38IuhRM8exJO8qKG0w29nei/0jZL45Piil8Pul+MRrAZUS1wP3+u/Kr9ntSI41tZr880VtdO0xWdkby/v7YvpMM6M4B1bjTCAHbjK1jT1aCbkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762620773; c=relaxed/simple;
	bh=ONTa+cHS9I/e+sqfzot1zE/bRY0nqRHXeJIm7rj1qSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuRgqwibCUD/pUoXfzxBOstUBVdbsQmwnU2fk+3xKjttRKvvt1xXF18idFAjSvpoB2LdTKw1APDNj3BNypbfslhirsh/JJu4mEkUZSh+N7ftegOLaAnYReW52q6DfFtnSUMA2xnX5qm7CVy+613SF+imB8urfIv5UDu37bbeBFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=A/N5y4PY; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2pOc/mV98yYfx/itftIN+rSXJdRkRrRhjmWi04usANg=; b=A/N5y4PYErNcOGS55WXfq5Ajsx
	KQngsaLMh1cvty9+1VzdScBf9EyEbIR+o8Z5JwAbfO1+YiHanli9sCAsShFRkj+MBD76LJFGU9bY8
	mKt5SlYXm55bVVQ8N4rl3cRuMnKvP9o+5la/4AUGLgeIRqxVSIpauGL1pdZLu9bO4ON05Kr59J3o9
	pySYo7zXOzivyhYZtErX+PQrKYJmoNYN69QWTO7iVMRycmIepERWamZn6kDc5WbukPw28ptxR6CmB
	zQrlWhcHC6/0cJTSlYfCdxvm+jTolCOibtvq66R1Tim608x5XPfzxVA8ZY5SAf+y9z6zbb0DKlSEL
	8f24ghGQ==;
Date: Sat, 8 Nov 2025 17:52:44 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add Fitipower FP9931/JD9930
Message-ID: <20251108175244.0b51fac6@kemnade.info>
In-Reply-To: <aa330123-e6d9-44ce-b030-b266cba1df9c@kernel.org>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
	<20251107-fp9931-submit-v1-2-aa7b79d9abb6@kemnade.info>
	<20251108-vagabond-lyrical-hawk-ad3490@kuoka>
	<20251108152114.53422ea6@kemnade.info>
	<aa330123-e6d9-44ce-b030-b266cba1df9c@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 15:46:01 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> >>> +  fiti,tdly:    
> >>
> >> No, look at datasheet. What values are there? ms.
> >>  
> > Hmm, no to what? I do not understand your comment.  
> 
> Please use proper units for the field expressed in the property name
> suffix and possible values (enum).
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> 
> You also need default.
> 
> > So I guess a bit what might be options to discuss here:
> > - put raw value for the bitfield here (what is currently done).
> > - put the ms values here (then I would expect a suffix in the property name)
> >   We have the mapping 0ms - 0, 1ms - 1, 2ms - 2, 4ms - 3, so it is
> >   not identical.  
> I don't know what has to be identical. You want here 0, 1, 2 or 4 ms.
> BTW, if you speak about driver complexity, getting register value out of
> above is absolutely trivial, so not a suitable argument.

Ok, no problem with doing that trivial conversion in the driver.

Playing around with dt-binding-check and add enums (and the -ms in a
second step):
  fitipower,tdlys:
    $ref: /schemas/types.yaml#/definitions/uint32-array
    description:
      Power up soft start delay settings tDLY1-4 bitfields in the
      POWERON_DELAY register
    default: <0 0 0 0>
    items:
      - enum:
          - 0
          - 1
          - 2
          - 4
      - enum:
          - 0
          - 1
          - 2
          - 4
      - enum:
          - 0
          - 1
          - 2
          - 4
      - enum:
          - 0
          - 1
          - 2
          - 4


dt-binding-check accepts this, including the example. But if I change it to -ms
as you requested, I get

/home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'$ref' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'default' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'items' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('$ref', 'default' were unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'<0 0 0 0>' is not of type 'integer'
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'$ref' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'default' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'items' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('$ref', 'default' were unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'<0 0 0 0>' is not of type 'integer'
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

Leaving out the type $ref does not improve things much.
What is going on here?

Regards,
Andreas

