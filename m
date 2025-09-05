Return-Path: <linux-kernel+bounces-803188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D6B45BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8AF188DF59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAA8309EED;
	Fri,  5 Sep 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwS+zBKi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8761C701F;
	Fri,  5 Sep 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084575; cv=none; b=RHgZiQIEGtsAS6ufs1dweYtr0cbH5DKxo1Y68bTdsIPYHoygYrOFjZ1+ublzZmEt0ocgb/IZMkzXFeCAMs9381pWUyiI2hqEbKb8s2PxsaI3wzLLuD1n/CTpiNHzAoIVu/02mq7b8mTFKI521PGxUvvS9djLMAcDHk9mijmtIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084575; c=relaxed/simple;
	bh=ebSK5L00ENVHa6bUlXpVtE0ozImvuhAtZkPqI47++wI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iC+dBLsVCdyVypMipaWsZmWcwaoExGgAqW2Zkv/PwRUyO32Qq1sS/79PdD5zqXjqnYGTN2ZoERO7ZVMBsB6Sp9ptaxPrWZ4gVnAb+w6o/0zHgt9dWWbViu5TaFPkZt8eRaRnm71TWIkd0lfEmp/OExSO111NMOTTeyy4BIYT6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwS+zBKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F021C4CEF1;
	Fri,  5 Sep 2025 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084575;
	bh=ebSK5L00ENVHa6bUlXpVtE0ozImvuhAtZkPqI47++wI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IwS+zBKioHzYtJFaft6zCEvJh10s3WE1qRdebkmWb3RB6ZgrzORUXwe7yRkcZDed0
	 +BQGlz1cfucrA4cITUDRtWt894ks+Jiv+iNEF3w0iAAeqIDXN9HCHyYBeM3TMK5gaG
	 boNRqHysKEcrNzoRGm0c2Y/HOmHzkcUrENkD4oUc6xqG59CztSCXj/K/95sXHEd6JU
	 P/2v6fvehRByIrg4tnrphPUMfYbGAENoWtBO5FwI6HZw8qH/eqImwes+fd2wqM9WDk
	 vG8FF7csDJHotP/gP+p8Y3eqGWLjeDnqH7Ax4kZPo4cK9kevuAU1BP6IIGZ8r1+Ezc
	 LqIkgyd8kCC7Q==
Date: Fri, 05 Sep 2025 10:02:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250904195338.530618-1-Frank.Li@nxp.com>
References: <20250904195338.530618-1-Frank.Li@nxp.com>
Message-Id: <175708447771.930391.632007325677210221.robh@kernel.org>
Subject: Re: [PATCH 1/1] bindings: siox: convert eckelmann,siox-gpio.txt to
 yaml format


On Thu, 04 Sep 2025 15:53:35 -0400, Frank Li wrote:
> Convert eckelmann,siox-gpio.txt to yaml format.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/siox/eckelmann,siox-gpio.txt     | 19 --------
>  .../bindings/siox/eckelmann,siox-gpio.yaml    | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250904195338.530618-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


