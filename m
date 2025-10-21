Return-Path: <linux-kernel+bounces-862179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF267BF49BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD2918A734D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E53257448;
	Tue, 21 Oct 2025 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSnNvN2s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646E24C676;
	Tue, 21 Oct 2025 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761022458; cv=none; b=jgHTFrIeVrMEZtyWq1wNeQUa3e0jJW2oUB635UpLBagOGOmBzp34XgkWJ3FwTNGK5OUltB6D5xWkKwEYVqxQnvv28D0l/UiLCWB2nFEGYENAsJRK8ow4tIzajhlM2bqZK0Z15jmnDHEe/BOuPOTclUUeN3tdV3tW0QmcPOKfl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761022458; c=relaxed/simple;
	bh=cp2MWKweKeqkkK10axCIthyBxdGN4x5OPDkgdyYEZkQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ShGR9PFPY0h6LnOdEbH63CYrj+gcnfjsMAajLY4cUupWcBcFLVSr71R0qEba8I3kt4P4bpwqIND81lj4swch/S0fSMChHCbCD+evLLtC/a97WfBin9UVHHkyOHfuj5utivT/aHb+cM3EkffIbT1wWabg8qKGi6IOJ6kbbBRCRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSnNvN2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADE1C4CEF1;
	Tue, 21 Oct 2025 04:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761022457;
	bh=cp2MWKweKeqkkK10axCIthyBxdGN4x5OPDkgdyYEZkQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rSnNvN2slUpFH+oequP9kgu2WPs5mGq65AOmJHlVo3U18Q6cOi3maowa0XZ5I/pxU
	 ORdH/T9S3udm1pf9H0B8hEJemMOqWFjQr+QdFt9jzgAajfOLqnjdsUiXsaUV3Fr/np
	 dSd9p1MQsONbSZOLy+5PD5xguKEkgJnxMAIwTdy0rPvQV0SnH89MUu8d0ffTAi50Y3
	 vHWC3J3z/aDBHnxff1nHPg6XCre6DTopcBAJjMw2dYnhaL0b5sZE700cyokN7txUFI
	 zI8Tov648wXhkS52weipHrxpMFFaUtic9YG7LJFe33h7rlSfyxpDI06bcqy0jVoLnp
	 n8OkQr+FrM88Q==
Date: Mon, 20 Oct 2025 23:54:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: sugar.zhang@rock-chips.com, sboyd@kernel.org, 
 linux-rockchip@lists.infradead.org, huangtao@rock-chips.com, 
 linux-arm-kernel@lists.infradead.org, finley.xiao@rock-chips.com, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, heiko@sntech.de, 
 krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org, 
 mturquette@baylibre.com
To: Elaine Zhang <zhangqing@rock-chips.com>
In-Reply-To: <20251021033834.1390006-7-zhangqing@rock-chips.com>
References: <20251021033834.1390006-1-zhangqing@rock-chips.com>
 <20251021033834.1390006-7-zhangqing@rock-chips.com>
Message-Id: <176102245398.2690195.14711542090978775144.robh@kernel.org>
Subject: Re: [PATCH v4 6/7] dt-bindings: clock: rockchip: Add RK3506 clock
 and reset unit


On Tue, 21 Oct 2025 11:38:33 +0800, Elaine Zhang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Add device tree bindings for clock and reset unit on RK3506 SoC.
> Add clock and reset IDs for RK3506 SoC.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rk3506-cru.yaml   |  45 +++
>  .../dt-bindings/clock/rockchip,rk3506-cru.h   | 285 ++++++++++++++++++
>  .../dt-bindings/reset/rockchip,rk3506-cru.h   | 211 +++++++++++++
>  3 files changed, 541 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3506-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rk3506-cru.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/clock/rockchip,clk-pvtpll.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/slimbus/slimbus.example.dtb: slim@28080000 (qcom,slim-ngd-v1.5.0): 'audio-codec@1,0' does not match any of the regexes: '^pinctrl-[0-9]+$', '^slim@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/slimbus/slimbus.example.dtb: slim@28080000 (qcom,slim-ngd-v1.5.0): #address-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/slimbus/slimbus.example.dtb: slim@28080000 (qcom,slim-ngd-v1.5.0): 'dmas' is a required property
	from schema $id: http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/slimbus/slimbus.example.dtb: slim@28080000 (qcom,slim-ngd-v1.5.0): 'dma-names' is a required property
	from schema $id: http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251021033834.1390006-7-zhangqing@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


