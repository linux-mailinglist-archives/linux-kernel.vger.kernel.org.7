Return-Path: <linux-kernel+bounces-857580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 586BDBE730D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A4B750426F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345C22BE02A;
	Fri, 17 Oct 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSxYK2kD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559D29A31D;
	Fri, 17 Oct 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689909; cv=none; b=Cw7VdikmW2nfjv3s3x69iXQKqX6x76h2EhdpQX6DWqvHyeJ+vqx8f9yXbAM0iSajFIwpHlzS2Cw3/ptwk63mRGtfekLvtkFGa77/eskzLhtfEA8PSa/Vx4rJW3Y1t0sJ14sF00oyW6D3qRzW7dAb1oClmLHz2cVMj3cMUSSPpYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689909; c=relaxed/simple;
	bh=8JUiOrjDfOdA/96I1n2RoxKgJNH0r2C48Z5YYltnGhg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dBOiLDtZVGt29Ubh66K3Ek3jjd7T+G+S6+ELRlvNdKSOrjiuOOBEMLAbBwk3BcUsZKssvYPK/v/yg87Zrox/O8762emWQEgfjFnZ4/iqmAyEvOrzWd12RbxQgRWALgtgJKzdcEBoMdke4h3H+WhRyAupWqFGPcXJwCabe99peoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSxYK2kD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED015C4CEE7;
	Fri, 17 Oct 2025 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760689908;
	bh=8JUiOrjDfOdA/96I1n2RoxKgJNH0r2C48Z5YYltnGhg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bSxYK2kDJV4zgONmPeuPitDLrbENAOcdwhHNI9fk2w0/zI5It/AVh5B3m2jkhK9S7
	 geXRz55eImzmjpiK8aUGHgF8yVZhmi8zxkgihRCKnMIWmnCqMFPZMUomGx2keiu7H5
	 TDWkfMaZgaKdT5MHSOx2Hxdy4ZoLUQGuBSytAwCdaVRGR9t5WY96tAUTsNsARIPvc4
	 OW4xweUoJtc4gGXNhSkQg3OxGtfijv6DD9W0NDlgC8MimW8fVppaqm3rUS8FdJehf2
	 nb8B/nVLpIqWKO4ZekSXkLFbOnMNF3onDdBkYeo+s/ZbYRqUkKh5JIYy6wGz8qdH3n
	 6benPmRb8/eoA==
Date: Fri, 17 Oct 2025 03:31:46 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: sugar.zhang@rock-chips.com, krzysztof.kozlowski+dt@linaro.org, 
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de, 
 mturquette@baylibre.com, conor+dt@kernel.org, huangtao@rock-chips.com, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-clk@vger.kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org
To: Elaine Zhang <zhangqing@rock-chips.com>
In-Reply-To: <20251017063107.1606965-5-zhangqing@rock-chips.com>
References: <20251017063107.1606965-1-zhangqing@rock-chips.com>
 <20251017063107.1606965-5-zhangqing@rock-chips.com>
Message-Id: <176068990653.1336490.3635831064787473495.robh@kernel.org>
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: Add support for rockchip
 pvtpll


On Fri, 17 Oct 2025 14:31:06 +0800, Elaine Zhang wrote:
> Add pvtpll documentation for rockchip.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,clk-pvtpll.yaml   | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.example.dtb: pvtpll-core@20480000 (rockchip,rv1126b-core-pvtpll): compatible: ['rockchip,rv1126b-core-pvtpll', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/clock/rockchip,clk-pvtpll.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.example.dtb: pvtpll-npu@22080000 (rockchip,rv1126b-npu-pvtpll): compatible: ['rockchip,rv1126b-npu-pvtpll', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/clock/rockchip,clk-pvtpll.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251017063107.1606965-5-zhangqing@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


