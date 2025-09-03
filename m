Return-Path: <linux-kernel+bounces-799396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB42B42B06
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149843AF9AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A722EA46F;
	Wed,  3 Sep 2025 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6YenAC0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A41E2E8B62;
	Wed,  3 Sep 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931593; cv=none; b=a6jEBrzL6Juxw+KsK7a3VytJIdT2yKpIyOSxsLQ9OnknpqjUFur/1qWM9xe6iLA/OlZ6WhSgM4q7AWUvjjgNIqTqYEj9ffm3i96VFsXPg88W6f4lvPwxk+ZV2EJq/eGbnuxEukXJApF/TYYD1aDhBSi+XwM6XqLsfbF3Bk69ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931593; c=relaxed/simple;
	bh=CtdGRL4LXSJzr3WbRmYyBBmngF23nTaLOSKpyQOxxgk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=A7/jFrjUv42fIS94emXVjQ6j4Vvh3boksqIg5xGkdBwQbo31X/vU8eef6+LR60jYMTah3QiISGDLeY1jzQZL3NGRFK8pLNIWaq9G/9Bg+I/Kg31+V8zyABVu8nJFI/+CTumOLfHG/lh6bcT6HZ6j69mtulYsbXmRMrLZ92Q5L6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6YenAC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE2AC4CEF4;
	Wed,  3 Sep 2025 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756931592;
	bh=CtdGRL4LXSJzr3WbRmYyBBmngF23nTaLOSKpyQOxxgk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=j6YenAC0EhhwYKZROMiDnNX4EtchA309kTM5B+ccl9xLeDa904mhV+CTy2pwTVim9
	 oRT6nJAaxGfvT7Hm4ebSEPY1ugSbQouD3wVbCyhWPQ3megoFExy578TVMPgRrPF6Bm
	 AZ6Ab/q9XAh/HAe6M0pbEWUjWjPAug6ilAY2QkjGh2hqrMd43cR1pG7rYd77MzjBic
	 xbevMnRPRiAXtkUNzKHIEM9VZ8gfl7K2V2B4AzafLBuooWwxP9OpaSbPrrGTA11aZG
	 jUZm4UTgd5sK02cx6kRHxHP79TNxWwe4tKgaEmWeWdS7foQlpOduQm1Moml19mUfD3
	 L7lXgZPpChp9A==
Date: Wed, 03 Sep 2025 15:33:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Woodrow Douglass <wdouglass@carnegierobotics.com>
In-Reply-To: <20250902-pf530x-v3-2-4242e7687761@carnegierobotics.com>
References: <20250902-pf530x-v3-0-4242e7687761@carnegierobotics.com>
 <20250902-pf530x-v3-2-4242e7687761@carnegierobotics.com>
Message-Id: <175693109173.2632698.2374155993251530154.robh@kernel.org>
Subject: Re: [PATCH v3 2/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator


On Wed, 03 Sep 2025 11:31:38 -0400, Woodrow Douglass wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250902-pf530x-v3-2-4242e7687761@carnegierobotics.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


