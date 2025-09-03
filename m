Return-Path: <linux-kernel+bounces-799544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D55B42D62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592F51BC83A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80792F3626;
	Wed,  3 Sep 2025 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB0Hk3+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5122EDD6C;
	Wed,  3 Sep 2025 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942066; cv=none; b=bDjMK6evt2GJZstIDNeyiyeMN3JQaluN/Uos3VWC4gvA6GePgXvgZz7zdnPTP3nFugw5lS9/hBKerHJJBonNF9oq5LPxGP2+3NiCPI5fMSVL3uXZwkekpUhx5Y6WQY8IGcd+zEwaGLAxe+J0JnZkufT0g/CY6YcFxZXfXPxfKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942066; c=relaxed/simple;
	bh=QXdrXsTmqaP2eMpQURKuHbkMTfr/gKClmNGhozn3isQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=l/vOazmx8sLgfEGIg+OwHnr2Vz2fzz9k69ldbfneQN56KPgALCJt3JqQHzU9tEhHSHo2xIWSXC1GFEYODQe6jWzZDXoUKGB/YfmsP0qXu8sG5dIU/hCarIvTcVq3eqR9pZHtwwHuFgGDj+XX15Umfk+maHk6xUW+TkgnpKIvFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB0Hk3+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A77C4CEF9;
	Wed,  3 Sep 2025 23:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756942065;
	bh=QXdrXsTmqaP2eMpQURKuHbkMTfr/gKClmNGhozn3isQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HB0Hk3+WAuu1bzEvsuM8Tmo3KePBiQP52k8bQoDeWss20JREBl06Jifso2DiJvfCg
	 2sRPU3k5peykG87O/dnZLRlmSr2IoxDReWN5Dh0fXm8i67KY+TZNq+vYMAmQQCgVWw
	 Y/dR052JSqt2T1gmz7Jg2Tg9umqRliVA6j0OdfZnKkjfUffE471lbYkBg0/ANd2kux
	 EjI8jLAbPptTgx8S22Q9V4qs88Myd+79CRD1LNOZorT4B2szL3VU2+3FPmJ1A233rQ
	 eEWXxEYnjjugNHuSOv7tKIWcm4bRW1ag2+UMqKI4u55lyF0NY9AokNKdbEN5swAQB5
	 SrYZK3f71fKHw==
Date: Wed, 03 Sep 2025 18:27:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
To: Woodrow Douglass <wdouglass@carnegierobotics.com>
In-Reply-To: <20250902-pf530x-v4-2-4727f112424e@carnegierobotics.com>
References: <20250902-pf530x-v4-0-4727f112424e@carnegierobotics.com>
 <20250902-pf530x-v4-2-4727f112424e@carnegierobotics.com>
Message-Id: <175694204424.3260245.17206589935554456036.robh@kernel.org>
Subject: Re: [PATCH v4 2/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator


On Wed, 03 Sep 2025 16:03:42 -0400, Woodrow Douglass wrote:
> Bindings for the pf530x series of voltage regulators
> 
> Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
> ---
>  .../devicetree/bindings/regulator/nxp,pf5300.yaml  | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml: properties: 'additionalProperties' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/regulator/nxp,pf530x-regulator.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pf5300.example.dtb: regulator@28 (nxp,pf5302): 'regulator-always-on', 'regulator-boot-on', 'regulator-max-microvolt', 'regulator-min-microvolt' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/regulator/nxp,pf530x-regulator.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pf5300.example.dtb: regulator@28 (nxp,pf5302): 'regulators' is a required property
	from schema $id: http://devicetree.org/schemas/regulator/nxp,pf530x-regulator.yaml#

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml
MAINTAINERS: Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250902-pf530x-v4-2-4727f112424e@carnegierobotics.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


