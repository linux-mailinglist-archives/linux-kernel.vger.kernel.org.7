Return-Path: <linux-kernel+bounces-713425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08ABAF5992
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 15:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3F24E2341
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 13:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E528A72F;
	Wed,  2 Jul 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+L7XG7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EBD28A417;
	Wed,  2 Jul 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462912; cv=none; b=FjBG6CN6HUlXx7XNoHibsN+WZvApBsnyGXTVxd9IJyYEFADNj96WcKppjGqxCBoEfnJB8659rbJXUvEdGNZZX8gT3pM2O3M31TlD6zqLG79T5lhNA2jFxztXpbxFRqhlvwQ+rEjykLAJ8GpiQPhKTmKTjIm7+bQepgEqx1Hy+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462912; c=relaxed/simple;
	bh=W9XodcjS6MwWFvJvPEDVqH/NZzKjV2TWILtJFHqZS6Q=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dIrODqbh7KxiEJYiRVvMljqClMLnf381mVCykqJZSosaIoVL5D3464bomHx+MDux4jsPM5/byuKVhSdQsCvrTL3P5jDDYbFddt5hSuo0vQoIJsfqX9tFh9gXH3OcsSZkPv3z37TITcKUoL/NBsGN5+X6gzZ5pCEKgSzycNQzJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+L7XG7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4557BC4CEFA;
	Wed,  2 Jul 2025 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462912;
	bh=W9XodcjS6MwWFvJvPEDVqH/NZzKjV2TWILtJFHqZS6Q=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=n+L7XG7iqZOyytYWe0jFdY9wVWNtXMvtKCpDOfzkLoKo07dO4yPPvWT+rnzM7bP6d
	 +gksqHZwZcqR48HCjl8kGjNRCnuaj2/gRucyCa35rFLWt6mTkbmoSBXlyRyTLdSFG7
	 itAsTnGiSJcWRlQIVsfY1t6xLCtSaf9nYiB97pe3yRXkjoUFwDjEgCwHBhKGavaBqO
	 WqYF2XzkKJ5czG7BQ87v22De/doI1GJ7KWxOJOyVwO1ppY5CLz0RIUHB99NKq8vEtc
	 hjYoZXHsG03tJSPOcBFN32bhb0DA6b2vjsLql6oOJ3n8pnqwOtMkvcuLUuFxWScFlB
	 XupdldHsfkhBw==
Date: Wed, 02 Jul 2025 08:28:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 bsp-development.geo@leica-geosystems.com, lee@kernel.org, 
 devicetree@vger.kernel.org, pavel@kernel.org, linux-leds@vger.kernel.org
To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20250702114759.223925-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20250702114759.223925-1-Qing-wu.Li@leica-geosystems.com.cn>
Message-Id: <175146290821.1131432.4001907939183416459.robh@kernel.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: leds: pwm: Add enable-gpios
 property


On Wed, 02 Jul 2025 19:47:58 +0800, LI Qingwu wrote:
> Some PWM LED chips have a dedicated enable GPIO.
> This commit adds the support to specify such GPIO.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/leds/leds-pwm.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/leds/leds-pwm.yaml:44:21: [error] empty value in block mapping (empty-values)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-pwm.yaml: ignoring, error in schema: patternProperties: ^led(-[0-9a-f]+)?$: properties: enable-gpios: description
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-pwm.yaml: patternProperties:^led(-[0-9a-f]+)?$:properties:enable-gpios:description: None is not of type 'string'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-pwm.yaml: patternProperties:^led(-[0-9a-f]+)?$:properties:enable-gpios: 'anyOf' conditional failed, one must be fixed:
	'enable-gpios' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-pwm.yaml: patternProperties:^led(-[0-9a-f]+)?$:properties:enable-gpios: 'anyOf' conditional failed, one must be fixed:
	'enable-gpios' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('enable-gpios' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'enable-gpios' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/gpios.yaml#
Documentation/devicetree/bindings/leds/leds-pwm.example.dtb: /example-0/led-controller: failed to match any schema with compatible: ['pwm-leds']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250702114759.223925-1-Qing-wu.Li@leica-geosystems.com.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


