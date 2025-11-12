Return-Path: <linux-kernel+bounces-897291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D874C52801
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8645D1892B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792613385A1;
	Wed, 12 Nov 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlzeIPsT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A04335574;
	Wed, 12 Nov 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954541; cv=none; b=jOtL4cOGrOyu4XxKt5sW4nHfibVgEYuIwA9A0UVaWxc7HzI7X8wljfMGpQusAyDOOIodNacVGkYnTodU+R0td7ZU7xsdCvfxDX3d+iDy2RGGhrZFYgZPigw4Frh+c6WCp0U9GpV3RDmSDafMfUv1ucczZr8JryW/xrWeo1jtxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954541; c=relaxed/simple;
	bh=WQooiilA0TAh5yRJIjN6xbNOHfGAkuOUYWmZ7ZJbrHQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rswM5tYv39gFTHDEx4UWTPFqOUFNrWJvedKY8JhfIPcGyyg8HH4I5WQoeSE5Lh21nEO+1nc7NOsQRMj4tj1xRTcN1JIgHHu1CmvbSfjqTQWuI4qUyjPQmwT/FQiufBBggTF/jPqFxvA9qdAZbbe75Ixjptnqu+RLccsG5TEY+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlzeIPsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF02C4CEF8;
	Wed, 12 Nov 2025 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762954541;
	bh=WQooiilA0TAh5yRJIjN6xbNOHfGAkuOUYWmZ7ZJbrHQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YlzeIPsT/HYtB4K/EBbUjxY4oNSvOSq+5xIOMQVqTuFy+qKjYMgzEhp3s0Zlk8TG1
	 AdIrI8V5gXBjTziR3XZWNlXzGnTxkE5K991rQYbEDpsCeEmyZl11qXZ3RM1xF7nLMW
	 w59o2yfrLNXsVGi6kdWsqOlmXQuAChJDy8D8XJ3gkYMC0KmsNCiSN6ozFo7xJ/TZY5
	 JFdgJiYdbeQZO3Q+z753cBfTCfAzOBt91a0Y5SFNHhjKXQulZdTZDPa3mMuCxb1yj/
	 Y50IRzJlWj+v/niCdwQS1s2J8N96dnv1tjo8bI+8MzbbyERJdZGX7+C4rmIvRnyj89
	 8Z4+ohw8dPcew==
Date: Wed, 12 Nov 2025 07:35:39 -0600
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
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
In-Reply-To: <20251112121710.2623143-1-martijn.de.gouw@prodrive-technologies.com>
References: <20251112121710.2623143-1-martijn.de.gouw@prodrive-technologies.com>
Message-Id: <176295453963.1617799.11924741308480396991.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: pca9540: add debounce
 timer configuration


On Wed, 12 Nov 2025 13:17:08 +0100, Martijn de Gouw wrote:
> Make the different debounce timers configurable from the devicetree.
> Depending on the board design, these have to be set different than the
> default register values.
> 
> Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
> ---
>  .../regulator/nxp,pca9450-regulator.yaml      | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml: properties:nxp,pmic_on_req-on-debounce-us: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml: properties:nxp,pmic_on_req-off-debounce-us: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml: properties:nxp,power-on-step-ms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml: properties:nxp,power-down-step-ms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml: properties:nxp,restart-ms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml: properties:npx,pmic_rst_b-debounce-ms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251112121710.2623143-1-martijn.de.gouw@prodrive-technologies.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


