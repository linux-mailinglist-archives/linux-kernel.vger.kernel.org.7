Return-Path: <linux-kernel+bounces-745379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B389FB11921
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF6189F0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF32BD58F;
	Fri, 25 Jul 2025 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx/k4h7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61733BE65;
	Fri, 25 Jul 2025 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753428326; cv=none; b=pu0LjV/qZBZyiQmwQf0yPSktcVQ0wa9AJEXyfwKCeaTiZbRJZKdfymb8mu7NKDBLBKo5sa3dbcaK528YmxTL5QWDk+3c6nnF9CGHF5I2AX+4Iio1A7oHML7OcX+zqTr9SAqzOZEC4SHzbLa84Y0+tgeu6C2BnI4fFKHW34yTcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753428326; c=relaxed/simple;
	bh=t6yI9W9ga2d5U86MGT4GedWz3RS3zaMqTHg3mi5MJtU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=STJ8j62utfD6angjqjvka6hILTna0LCIb6Lwx7oD/kEsbPRaMPn6mKXc+0+Ml3VLNdBuABwXtspjR3310X544T5SkGEMvmPXkAsYYJp22syJryrzdvQf6D3TsCbQ8rIcE7R97gesd1W4KCYcFKUHHD6f0eFJnZ59bFEUlKyhMhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx/k4h7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1828C4CEE7;
	Fri, 25 Jul 2025 07:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753428326;
	bh=t6yI9W9ga2d5U86MGT4GedWz3RS3zaMqTHg3mi5MJtU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bx/k4h7/0kJYBlhEQVSht+043C0sEVgpEsRPYLKQWiLVmnTbJPWAr+KHTy/hYyJIi
	 qwiyuB8Y8/BgU1AqVuBIphEyLZcydKUM+/R49ZoIWTUAEJAquXda+czLEwhpKF/wWh
	 PA7Yu0pf6zA8QYTiYh8Lto9Gw6ZoUHBAHjv7AZwYJeYp3kpHjv7ktS02SshLBHZY74
	 MFZqRt3mGlqiKWoOfcSOfa1lgGm/OzC4EBxt0v1TeREA0+lD0dy+F0V4IeyXTvzYkd
	 00YIc+aln/jPDrvU08yJPBU1tIN2XFKojOL+7d1GUaiKIukguPsObThWPaUxT5P9M+
	 1nJrcY9n/nTuA==
Date: Fri, 25 Jul 2025 02:25:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linuxppc-dev@lists.ozlabs.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexander Stein <alexander.stein@ew.tq-group.com>
In-Reply-To: <20250725055835.260930-1-alexander.stein@ew.tq-group.com>
References: <20250725055835.260930-1-alexander.stein@ew.tq-group.com>
Message-Id: <175342832496.81853.5141988537592299860.robh@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: fsl: fsl,rcpm: reference
 power-domains.yaml


On Fri, 25 Jul 2025 07:58:34 +0200, Alexander Stein wrote:
> dtbs_check for ls1021.dtsi warns about unsupported property:
>  power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 
> But if removed the check warns about missing property:
>  power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' is a required property
> 
> Given commit 8bcf67b8d893b ("ARM: dts: ls1021a: add #power-domain-cells
> for power-controller node") explicitly added that property, add a
> reference to the common bindings to fix the warning.
> 
> Fixes: ad21e3840a88 ("dt-bindings: soc: fsl: Convert rcpm to yaml format")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.example.dtb: global-utilities@e2000 (fsl,t4240-rcpm): $nodename:0: 'global-utilities@e2000' does not match '^(power-controller|power-domain|performance-domain)([@-].*)?$'
	from schema $id: http://devicetree.org/schemas/soc/fsl/fsl,rcpm.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.example.dtb: global-utilities@e2000 (fsl,t4240-rcpm): '#power-domain-cells' is a required property
	from schema $id: http://devicetree.org/schemas/soc/fsl/fsl,rcpm.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250725055835.260930-1-alexander.stein@ew.tq-group.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


