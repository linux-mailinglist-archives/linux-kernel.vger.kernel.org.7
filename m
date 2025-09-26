Return-Path: <linux-kernel+bounces-834671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B76BA53C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30301B2732F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5C27F01B;
	Fri, 26 Sep 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewQbXV9B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC123D7CE;
	Fri, 26 Sep 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922789; cv=none; b=DOuPdt8LZskhT+pPmO6O/FG0olbmkzDNMm2s5gVGNtbXd/Kp6u59OQEuqjKYiaPU9hQwX9BY5fN1lEys6sx0kI1mc+1onK3lnwxzWdH2k1XK9JijFgdbpPbWoMPBNm4RIXCPvvrEqv5PtEIrx3jMBV84dOZ62vSweHiRM2K/5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922789; c=relaxed/simple;
	bh=d1AZ/+AAfFPaPOFnur+pV8mdqf1t1UoRekQUo75AdSQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=W/5FkneUWa2d4jKty7Yv5d3H0d9ltjfOz1S39USRBdbkET1ZZPZS//9+s1qTjNUM647b32wuIdF5cemprhoHRacENbTd9JVq7mG73TfYp9N/kGwDYMZuRJlrtoWFHYWYMEDaA0ewU8NZJmDQLztoF6tzkc9tlP0DLX1jmzPVeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewQbXV9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2721C4CEF4;
	Fri, 26 Sep 2025 21:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758922788;
	bh=d1AZ/+AAfFPaPOFnur+pV8mdqf1t1UoRekQUo75AdSQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ewQbXV9Bn49vaZ9y0XanGKzEcoXauPdYCmWpxL7p9Y8/kkOTx4Je3ft10zoqxb9ND
	 67bRs57XREasACO1XVtARN+fvRg3SIb+UM1hzKlyZozMBRBDaRSNQd7NN8u0pAXUpN
	 c6c/4ElUcSvu7O+pYP+pBaudWfQKAkVw9wZbilmO0oxOK2u7GGQcrSe4rUAde3p9Cj
	 fe+Ehygcm47ts33kBnLKr8kwxcjrux5jTQvQURXbxiAhf7HWDbkWrgIRF0ZlqlMWbi
	 f/ZDYH1j9zNcBXxy/Y5iP/F39lHoga5QljdQKIlpvWpiNvgtyweQyqGswp5ZiqufeD
	 5kDLM1UAU2mhg==
Date: Fri, 26 Sep 2025 16:39:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Shawn Anastasio <sanastasio@raptorengineering.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Georgy Yakovlev <Georgy.Yakovlev@sony.com>, 
 devicetree <devicetree@vger.kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
In-Reply-To: <948400747.1748562.1758824253627.JavaMail.zimbra@raptorengineeringinc.com>
References: <948400747.1748562.1758824253627.JavaMail.zimbra@raptorengineeringinc.com>
Message-Id: <175892278740.1727949.11517757635835328406.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: Add sony,cronos-cpld


On Thu, 25 Sep 2025 13:17:33 -0500, Timothy Pearson wrote:
> The Sony Cronos Platform Controller CPLD is a multi-purpose platform
> controller that provides both a watchdog timer and an LED controller for
> the Sony Interactive Entertainment Cronos x86 server platform. As both
> functions are provided by the same CPLD, a multi-function device is
> exposed as the parent of both functions.
> 
> Add a DT binding for this device.
> 
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  .../bindings/mfd/sony,cronos-cpld.yaml        | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml:
	Error in referenced schema matching $id: http://devicetree.org/schemas/mfd/leds-class-multicolor.yaml
	Tried these paths (check schema $id if path is wrong):
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/leds-class-multicolor.yaml
	/usr/local/lib/python3.13/dist-packages/dtschema/schemas/mfd/leds-class-multicolor.yaml

Lexical error: Documentation/devicetree/bindings/mfd/sony,cronos-cpld.example.dts:42.30-48 Unexpected 'LED_COLOR_ID_MULTI'
Lexical error: Documentation/devicetree/bindings/mfd/sony,cronos-cpld.example.dts:43.32-51 Unexpected 'LED_FUNCTION_STATUS'
Error: Documentation/devicetree/bindings/mfd/sony,cronos-cpld.example.dts:43.32-51 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/mfd/sony,cronos-cpld.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/948400747.1748562.1758824253627.JavaMail.zimbra@raptorengineeringinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


