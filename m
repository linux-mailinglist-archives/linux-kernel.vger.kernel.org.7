Return-Path: <linux-kernel+bounces-892144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E6C4470D
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 22:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 248584E35DE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910FE2620FC;
	Sun,  9 Nov 2025 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="iQpw8Sg0"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E591537E9;
	Sun,  9 Nov 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722755; cv=none; b=ZF9NV/cUIBa+YINUjSX5KRh3d0kXh7I/1XD5TaoT5PNK45suXaWldoNbdtdpMLvOVKn5YyYTYQ0TnfuPBfWfgVqS/irC06Q/01IPjEPsisDPJS8FyOUP5kobUcGIh6Spw/o/1KTnufVlGypU01VPM5blOKMCkWst5tiDQ4DNZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722755; c=relaxed/simple;
	bh=n0RLN6sZCgLfMIbZ3gKcNgN3Enym6QBgeGbHnp5iD5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdaBjnbuRViTLzh2ILRWcFW0z95WPcjhaOvTT2MWxyf6/vNPGAgt7hzJZYaQPUz8hSvkyuzEimTqm3McGDO/c7v1/PTDlsWfUpjwFB98gxcnj32pEa1PrHK9zN6GfF6MitFdY55gk2vSH1TV2jjOKZr/G3r9ulsG70/qZP7xTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=iQpw8Sg0; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VdB9AxYT6F4feb9njK2Q9Wfb29In+2yyrhF+dKbwVI8=; b=iQpw8Sg0WROi/XYKtwYpi+6SoO
	ba8ZIeo+9TA7jgw6KkGcNQe2S2WhHSp16eTEEKDMhx1p+5GkKMYWiEu9keNmZUi7uUID9tdKeWjkU
	Ls6nOjsSrzheNZABBI0rXwrpohh54Yv6+UHmmnxEKJePd5DzHxcTaj8ngyLbRg0Yqgl/6WRsqaSRL
	OUqvNALCtGjwBwPDgndNuy/wzvaCKSlLBgPd87/rUKb4G00HEkNbo0RwgRezvYzqplcAgiqzZUiPx
	zNtpQSPs5hmyClWOFuxwlxRBHF3qVa2KVUl0mLeRUsBzRF8ZMBfsla4uSnWDlsAvSEkt9NAOKb7i+
	E41XYfiw==;
Date: Sun, 9 Nov 2025 22:12:12 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add Fitipower FP9931/JD9930
Message-ID: <20251109221212.182d7862@kemnade.info>
In-Reply-To: <aa54cf7c-cabd-490b-9bdd-a7a077ced35c@kernel.org>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
	<20251107-fp9931-submit-v1-2-aa7b79d9abb6@kemnade.info>
	<20251108-vagabond-lyrical-hawk-ad3490@kuoka>
	<20251108152114.53422ea6@kemnade.info>
	<aa330123-e6d9-44ce-b030-b266cba1df9c@kernel.org>
	<20251108175244.0b51fac6@kemnade.info>
	<aa54cf7c-cabd-490b-9bdd-a7a077ced35c@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Nov 2025 18:13:11 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 08/11/2025 17:52, Andreas Kemnade wrote:
> > On Sat, 8 Nov 2025 15:46:01 +0100
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> >>>>> +  fiti,tdly:      
> >>>>
> >>>> No, look at datasheet. What values are there? ms.
> >>>>    
> >>> Hmm, no to what? I do not understand your comment.    
> >>
> >> Please use proper units for the field expressed in the property name
> >> suffix and possible values (enum).
> >> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> >>
> >> You also need default.
> >>  
> >>> So I guess a bit what might be options to discuss here:
> >>> - put raw value for the bitfield here (what is currently done).
> >>> - put the ms values here (then I would expect a suffix in the property name)
> >>>   We have the mapping 0ms - 0, 1ms - 1, 2ms - 2, 4ms - 3, so it is
> >>>   not identical.    
> >> I don't know what has to be identical. You want here 0, 1, 2 or 4 ms.
> >> BTW, if you speak about driver complexity, getting register value out of
> >> above is absolutely trivial, so not a suitable argument.  
> > 
> > Ok, no problem with doing that trivial conversion in the driver.
> > 
> > Playing around with dt-binding-check and add enums (and the -ms in a
> > second step):
> >   fitipower,tdlys:
> >     $ref: /schemas/types.yaml#/definitions/uint32-array
> >     description:
> >       Power up soft start delay settings tDLY1-4 bitfields in the
> >       POWERON_DELAY register
> >     default: <0 0 0 0>
> >     items:
> >       - enum:
> >           - 0
> >           - 1
> >           - 2
> >           - 4
> >       - enum:
> >           - 0
> >           - 1
> >           - 2
> >           - 4
> >       - enum:
> >           - 0
> >           - 1
> >           - 2
> >           - 4
> >       - enum:
> >           - 0
> >           - 1
> >           - 2
> >           - 4
> > 
> > 
> > dt-binding-check accepts this, including the example. But if I change it to -ms
> > as you requested, I get
> > 
> > /home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
> > 	'maxItems' is a required property
> > 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> > 	'$ref' is not one of ['maxItems', 'description', 'deprecated']
> > 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> > 	'default' is not one of ['maxItems', 'description', 'deprecated']
> > 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> > 	'items' is not one of ['maxItems', 'description', 'deprecated']
> > 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> > 	Additional properties are not allowed ('$ref', 'default' were unexpected)
> > 		hint: Arrays must be described with a combination of minItems/maxItems/items
> > 	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
> > 	'<0 0 0 0>' is not of type 'integer'
> > 	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
> > 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> > /home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: '$ref' should not be valid under {'const': '$ref'}
> > 	hint: Standard unit suffix properties don't need a type $ref
> > 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> > /home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
> > 	'maxItems' is a required property
> > 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> > 	'$ref' is not one of ['maxItems', 'description', 'deprecated']
> > 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> > 	'default' is not one of ['maxItems', 'description', 'deprecated']
> > 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> > 	'items' is not one of ['maxItems', 'description', 'deprecated']
> > 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> > 	Additional properties are not allowed ('$ref', 'default' were unexpected)
> > 		hint: Arrays must be described with a combination of minItems/maxItems/items
> > 	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
> > 	'<0 0 0 0>' is not of type 'integer'
> > 	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
> > 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> > /home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: '$ref' should not be valid under {'const': '$ref'}
> > 	hint: Standard unit suffix properties don't need a type $ref
> > 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#  
> 
> You must drop ref. That's the entire point of common unit suffix.
> 
I tried without it:

  fitipower,tdly-ms:
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


Errors:

  CHKDT   ./Documentation/devicetree/bindings
/home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'default' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'items' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('default' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'<0 0 0 0>' is not of type 'integer'
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'default' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'items' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('default' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'<0 0 0 0>' is not of type 'integer'
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

maxItems is required according to error message, so trying with...

  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
/home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: {'description': 'Power up soft start delay settings tDLY1-4 bitfields in the POWERON_DELAY register', 'default': '<0 0 0 0>', 'maxItems': 4, 'items': [{'enum': [0, 1, 2, 4]}, {'enum': [0, 1, 2, 4]}, {'enum': [0, 1, 2, 4]}, {'enum': [0, 1, 2, 4]}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
	'default' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'items' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('default' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'<0 0 0 0>' is not of type 'integer'
	1 was expected
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
	'default' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'items' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('default' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'<0 0 0 0>' is not of type 'integer'
	1 was expected
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#


BTW: before you ask: dt-schema is version 2025.8

removing items and default removes all problems. 
So working: 
  - fitipower,tdly without -ms suffix
  - fitipower,tdly-ms without default and items but maxItems.


Regards,
Andreas

