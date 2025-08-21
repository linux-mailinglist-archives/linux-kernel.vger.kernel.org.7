Return-Path: <linux-kernel+bounces-780803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B590B30998
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8421893A15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9E2F3636;
	Thu, 21 Aug 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb3myAfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E982F360E;
	Thu, 21 Aug 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815994; cv=none; b=siFUJ3dcqYbygOAUoQc87fnO+fs5B2DnfKTfQeb1kz2UXu4moymcPDQzy96FeybgTLIKf2YcZjyC8hmRElFHy6q26brQkz3H5DX+1IJV04T7czvsZ3Cu3EhhSJ7mUjHqX/J9exGrZex2ts5l8yeQdoc4c3UpK6EzA2YYEnwr+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815994; c=relaxed/simple;
	bh=GD7PJkZToLyN/G6cbgeaBFRiaVPlRrInWRqkwNMGA5A=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qqYAMNHYD8uBeRZpbZkkeZ3h3OHhWUYSBze6exh5VKOONYq8M+Gv4IwkjdBdweJEEQCW91vtESBaAt0lPo8x+cZhSjr9XLd7LolBAyWweyHR+N2nxNmCLR63Lnigqn3Yn8gitUjOlUGCSF6tYNsFHXLBRY4fkvJZX0xM6rCgHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb3myAfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1335BC4CEEB;
	Thu, 21 Aug 2025 22:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755815993;
	bh=GD7PJkZToLyN/G6cbgeaBFRiaVPlRrInWRqkwNMGA5A=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Yb3myAfSJfILtlMiaszHClJxxkXZ/Ultvs3mR7J9CqIP/z5wf+Q+VV8xV2mB7QtYa
	 lKxj+Ia0ox6sV6AkZ/SbA01BNTer2ER7hqcDX59Q8seqkSdHjCZYbX0nqWBXop1sbH
	 /lo4hRoYzz7p9JTJVxVKAwJPAOWmKwWhGRWXNXXltewAGNs1itzUmdsGjOYs2siaX/
	 DjbILz797hYqIg1DwLGJbzagSL82A2zGYPk706ZxQUmXoaR+NRAejIpSe05ZCQQUQO
	 j6bBRkdHutGkLdqHnFrz0/ln2tLn9tTc4xP5ntfuKxZ2/wyiZu7J4jCAIf4pVHLa6j
	 NSpF0t2DgaXjg==
Date: Thu, 21 Aug 2025 17:39:52 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Janne Grunau <j@jannau.net>, Felipe Balbi <balbi@kernel.org>, 
 linux-usb@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, asahi@lists.linux.dev
To: Sven Peter <sven@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-3-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-3-172beda182b8@kernel.org>
Message-Id: <175581575975.1136737.15772006298653971684.robh@kernel.org>
Subject: Re: [PATCH RFC 03/22] dt-bindings: phy: Add Apple Type-C PHY


On Thu, 21 Aug 2025 15:38:55 +0000, Sven Peter wrote:
> Apple's Type-C PHY (ATCPHY) is a PHY for USB 2.0, USB 3.x,
> USB4/Thunderbolt, and DisplayPort connectivity found in Apple Silicon
> SoCs.
> 
> The PHY handles muxing between these different protocols and also provides
> the reset controller for the attached dwc3 USB controller.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  .../devicetree/bindings/phy/apple,atcphy.yaml      | 210 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 211 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/apple,atcphy.yaml: properties:power-domains: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/power-domain.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/apple,atcphy.example.dtb: phy@383000000 (apple,t8103-atcphy): reg: [[3, 2197815296], [0, 311296], [3, 2198142976], [0, 32768], [3, 2147483648], [0, 16384], [3, 2192113664], [0, 16384], [3, 2192064512], [0, 16384]] is too long
	from schema $id: http://devicetree.org/schemas/phy/apple,atcphy.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250821-atcphy-6-17-v1-3-172beda182b8@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


