Return-Path: <linux-kernel+bounces-774445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12648B2B252
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E2A5831F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FA2288E3;
	Mon, 18 Aug 2025 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic8tObN8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBD1FDD;
	Mon, 18 Aug 2025 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548700; cv=none; b=MOTUi+21+0b4NkCoL1UjlLE4uzOwDj5d4/k7QOC1z5qD+RsucCnsdKPQHlTXb1t+IRSut8UWSNOyUmUhniB6AZXIoxeEVg+VWhCo51ZJtSmfIPTb3519L7uasg1GJqWeQ8eEyzty08+XtmYAWbomDyp4Bt/1H9FpTR/u27938lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548700; c=relaxed/simple;
	bh=DWORNPSoaH+MkjUCn75Qd2KiRx9On7Gotf+b7ngssYs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Ckv2+BL9phOnnU1u5HC94Z/fe9A4sC/AyimIJwV9pBtC/DgC5/zquReY2khMNOiZ+lMcUv9sYcUa5l+ChELULVfHJcOqyZCIVrvA4xCrIoEewSziC8vTX6OZx+WbozFYX00Q/dfmutfnUK940ECG3ZhbKccbazakLt+4Xpxr/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic8tObN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8369DC4CEEB;
	Mon, 18 Aug 2025 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755548700;
	bh=DWORNPSoaH+MkjUCn75Qd2KiRx9On7Gotf+b7ngssYs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ic8tObN8DjU6IWxKiOeUkHXlkzm6Ho162M8Ov3UaeqzH7pN/YMUQuwGmAuFx47ius
	 MdA34L14QpFsZUs0iM3927gfqeD5/OwbmXbmADzTqvPTVUhqeniEQdqJkfBxHM+0yg
	 5e/+nxMtA8SxUGZ9YQwSyOk/r7QlfQTMtlQwRtxIXDCImfQ/GQq1LXZ/w/4ShPCFKQ
	 APvr+K1EZSLsflkmA4kop8gVAnr0ol6ed1pbWwh1JdxLppWSA6UZ/6fYBoKvBEYFOG
	 UJuwBDZqBqgBAwFk3VLgWTX+vIn8FA+oOmyNXxzmA6bca0NeuEWNjfTIi06cPAIwJP
	 qcpCS8jBN+WXA==
Date: Mon, 18 Aug 2025 15:24:59 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: imx@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250818183427.3601986-1-Frank.Li@nxp.com>
References: <20250818183427.3601986-1-Frank.Li@nxp.com>
Message-Id: <175554869942.1999698.5388783109628696157.robh@kernel.org>
Subject: Re: [RESEND v2 1/1] dt-bindings: soc: add vf610 reboot syscon
 controller


On Mon, 18 Aug 2025 14:34:26 -0400, Frank Li wrote:
> Add vf610 reboot controller, which used to reboot whole system. Fix below
> CHECK_DTB warnings:
> 
> arch/arm/boot/dts/nxp/vf/vf610-bk4.dtb: /soc/bus@40000000/src@4006e000:
>     failed to match any schema with compatible: ['fsl,vf610-src', 'syscon']
> 
> IC reference manual call it as system reset controller(SRC), but it is not
> module as linux reset controller, which used to reset individual device.
> SRC work as reboot controller, which reboot whole system. It provides a
> syscon interface to syscon-reboot.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change in v2
> - change description to avoid confuse about reset controller.
> - it is legacy device, more than 10 year. So try keep existed dts as it.
> ---
>  .../bindings/soc/fsl/fsl,vf610-src.yaml       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml: $id: 'http://devicetree.org/schemas//soc/fsl/fsl,vf610-src.yaml#' does not match 'http://devicetree.org/schemas(/[^/ ]+)+\\.yaml#'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250818183427.3601986-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


