Return-Path: <linux-kernel+bounces-729606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D6FB03904
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A973ABF33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5DF23B605;
	Mon, 14 Jul 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjU9wg+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEAB23A566;
	Mon, 14 Jul 2025 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481050; cv=none; b=QNRvv/CjIr1t0ZJoiVW/NicimaQjQus9yT5vBwGiLebKEHR4Bqxz09PBSHQd7OwTIanlnqaoJn340aVJ9qxatrbk0/xq7IF01qygDBDbKQcNS01Fq58YxQsZvM01TyF1P1Pwne3Qb6QP+d3r5OW2RXgUC30AtlrZYlHF/AJSxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481050; c=relaxed/simple;
	bh=HU6qaRX0H63WQNkChMnnlLrTNSnQpYkD+nlgW/FZX3w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DOJAsBrcZo/C1owy2/uDO5ukiPTSM43koSmTr4eT4p4kIiNOPZXHzhlR+v0XGaqFwFNyMYRFXgOPml1iTuPRhptFVb7KbnGHABmry5i1RK52ebKoltYEt1qu9MzrzhIpHk6D72kYC4n6F0ba0zrgoxmVgFVOna6QA+y1xsgVeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjU9wg+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23362C4CEED;
	Mon, 14 Jul 2025 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752481050;
	bh=HU6qaRX0H63WQNkChMnnlLrTNSnQpYkD+nlgW/FZX3w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JjU9wg+caJG31D0CW4bhBC6zj/xORL/KaedDTektBzMxDD00Ne35k+DcPKouPhcZ8
	 V+siYdxAN+xOF3XN/bSuv/wv6lQ8iIT5gqFGEW76EZCU87Kf3pqQecKJ2hfIPDR6u0
	 GMH73EEQQ1FXlyjMXNtfxfDUd+r3Fnln5FctxZNOazceKS1QOrgTSsWGT7d+MeHEn7
	 4HOruxq8gJLGD0xTE2fSGNtNkHiBiu+8dhSOkb5pOvIZOgqfqokMFd8ZqkBAEOQra5
	 Y6Ylb6tA4w1496Umb7Lueq4Ut1Xfy2/YoanxIIhR1M3Z/Ca7GM2S38NAJ2eV/1v62f
	 S2XmkXcPA39tw==
Date: Mon, 14 Jul 2025 03:17:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Joel Stanley <joel@jms.id.au>, 
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Chen <kevin_chen@aspeedtech.com>, 
 devicetree@vger.kernel.org
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20250714071753.2653620-1-ryan_chen@aspeedtech.com>
References: <20250714071753.2653620-1-ryan_chen@aspeedtech.com>
Message-Id: <175248104913.1053585.2976024588034663905.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: aspeed: Refine
 AST2700 binding description and example


On Mon, 14 Jul 2025 15:17:53 +0800, Ryan Chen wrote:
> - Update block diagram for better readability and accuracy.
> - Clarify the relationship and function of INTC0, INTC1, and the GIC.
> - Documentation and example refine.
> 
> This enhances the documentation quality and helps developers understand
> the interrupt controller hierarchy and usage.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc.yaml                  | 155 +++++++++++++-----
>  1 file changed, 112 insertions(+), 43 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml: address-cells: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml: size-cells: missing type definition
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dts:39.15-41: Warning (reg_format): /example-0/bus/interrupt-controller@12100000/interrupt-controller@1b00:reg: property has invalid length (12 bytes) (#address-cells == 2, #size-cells == 2)
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: interrupt-controller@12100000 (aspeed,ast2700-intc0): '#address-cells', '#size-cells' do not match any of the regexes: '^interrupt-controller@', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: interrupt-controller@12100000 (aspeed,ast2700-intc0): interrupt-controller@1b00:reg:0: [0, 303045376, 16] is too short
	from schema $id: http://devicetree.org/schemas/reg.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: interrupt-controller@14c18000 (aspeed,ast2700-intc1): '#address-cells', '#size-cells' do not match any of the regexes: '^interrupt-controller@', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: interrupt-controller@14c18000 (aspeed,ast2700-intc1): interrupt-controller@100: 'interrupts' is a required property
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250714071753.2653620-1-ryan_chen@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


