Return-Path: <linux-kernel+bounces-861661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4779BF3494
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 088D14E10EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BAC2D322F;
	Mon, 20 Oct 2025 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0UGo7l7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3802D838F;
	Mon, 20 Oct 2025 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989943; cv=none; b=tqvMunfPG9/Eo4CWyg77tU94CuNS5EO83OYgL3VBnq96DuwfAMI4H+c0dDXiQ2Nq6VrKn2PG3H+hV6zrI9R7OlGRVsz5pQTghKdsfXOhqbXgbIcZMsDF5+DuDd+Q8jjWuQc9cdF3b3T7Kh+9uosv+FupgWmrD71DHXN6hOu/9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989943; c=relaxed/simple;
	bh=va0wG1wDdAFRl4AGRygp4LMv6jhCscs65wJDRZ8/7wo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Et4FwPJSvyHPID38x4w1mvxrivmoxfxuGhSI7J86GQhbbzLMmvH2pZIYJj9M2Nrxj1lDCEWy2LL3m1aGwlB6PIuyz5aq2P70vQYN2UonA2gYM0D/qfYg7aAHqENaSE/szCIaV6s8Z0kT9jsRJjrQz4aJxRnr6ppO/d+sZRTEqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0UGo7l7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23CBC113D0;
	Mon, 20 Oct 2025 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760989943;
	bh=va0wG1wDdAFRl4AGRygp4LMv6jhCscs65wJDRZ8/7wo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=t0UGo7l7wlZH7k/LCR4n1SznE6Y+R0hGLbpDANumg0HIfQFrAFQ6V2ezjEKOQkx0b
	 cPVYsJ0GFSFVUJyt9Iygm+iZGdFN2XqlnhKxivu04ljItrb4H+qOijV3A4F+UZJmBM
	 p0fFYHWdsj3GUZIsv29w377zuZfqCFNPV3RLBEgA2kSEsBTz9RpCKMlu4F4sm26skO
	 78W9AZQ2niwImm6MBBYg9Oo1oIaNX7/KaKdJL+u5Z/i9xDO9+LEytetE+lZT0gtk4s
	 HvSpt1IPw+xrbS3Ziytkz9hJWHT6Ib2sUchKFKi6+LiaIg6+JbACiNf7QWkOAZVOwa
	 kuGxzr+WTezjQ==
Date: Mon, 20 Oct 2025 14:52:20 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Lee Jones <lee@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
 devicetree <devicetree@vger.kernel.org>, 
 Georgy Yakovlev <Georgy.Yakovlev@sony.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
In-Reply-To: <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com>
References: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com>
 <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com>
Message-Id: <176098994074.1437219.893450741336500812.robh@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Add sony,cronos-smc


On Mon, 20 Oct 2025 13:12:01 -0500, Timothy Pearson wrote:
> The Sony Cronos Platform Controller is a multi-purpose platform controller
> that provides both a watchdog timer and an LED controller for the Sony
> Interactive Entertainment Cronos x86 server platform. As both functions
> are provided by the same CPLD, a multi-function device is exposed as the
> parent of both functions.
> 
> Add a DT binding for this device.
> 
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  .../bindings/mfd/sony,cronos-smc.yaml         | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-smc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sony,cronos-smc.yaml:
	Error in referenced schema matching $id: http://devicetree.org/schemas/mfd/leds-class-multicolor.yaml
	Tried these paths (check schema $id if path is wrong):
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/leds-class-multicolor.yaml
	/usr/local/lib/python3.13/dist-packages/dtschema/schemas/mfd/leds-class-multicolor.yaml

/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sony,cronos-smc.example.dtb: smc@3f (sony,cronos-smc): $nodename:0: 'smc@3f' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/mfd/sony,cronos-smc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sony,cronos-smc.example.dtb: smc@3f (sony,cronos-smc): leds:multi-led@0: {'reg': [[0]], 'color': 8, 'function': ['status']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/mfd/leds-class-multicolor.yaml#"}
	from schema $id: http://devicetree.org/schemas/mfd/sony,cronos-smc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sony,cronos-smc.example.dtb: smc@3f (sony,cronos-smc): leds:multi-led@0: Unevaluated properties are not allowed ('color', 'function' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/sony,cronos-smc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sony,cronos-smc.example.dtb: smc@3f (sony,cronos-smc): Unevaluated properties are not allowed ('leds' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/sony,cronos-smc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


