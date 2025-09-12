Return-Path: <linux-kernel+bounces-814243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE70B5516D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319BFB606A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580B314A95;
	Fri, 12 Sep 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoWM21ca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C332BF38;
	Fri, 12 Sep 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687037; cv=none; b=K5RWXaurYcvKmzQqk6qRUXEzxUvkepwx0Kq2L9qGjXEdhpsOKaIqd/qaFZ0ZTrIH3NhiDsI+Tgqk+q2+Lh7fLBNgrukRPShQ2yQ6gIuUFlDDuoX69l2mwoX1yaXJnZWv4XVDEwy+mnhNntGP2bqQsYOkHjf4cH4sJOxHsQEGDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687037; c=relaxed/simple;
	bh=EEJh6LHueNJzaT1hgnBn4dZuI67YQLIzeq8MR0nLgIs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=S5x4qZp/S9qGaCGbY4OCdWzAPCNhKryHO4VhTq2ykhpLzJQVx+y0akb+q+GirrPHR7w/4Ii8a3+phFl3AiYc/adT0y4K5XzFZ6wKHOlgxiQhbdJZMAt6+/bzcANfSGmO5KW4AdF3jrGaulepqpytc7JykDfbY4dH3uwm+TSBDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoWM21ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8112FC4CEF1;
	Fri, 12 Sep 2025 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687036;
	bh=EEJh6LHueNJzaT1hgnBn4dZuI67YQLIzeq8MR0nLgIs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=SoWM21caN6bO8+Lcw2kH4X68aMNHTI8GakSLx7Br8yUtwMyKnT2qO88Okg6qWwHqi
	 UXrbCx2QuplVieWcBORO/buB/YbIfN5rHHOTYcJADlOBWSPgG90tZS0LC+EBk6Sc3M
	 jC7qMmlxsoyTZpja1VZWrn0yYRiWfto9gtaASsDdXt7QKB6tpJME67gsZ3rq1Rs8XF
	 ChtYrC8k/FBkTUJtKaRo8tG/avlDNIpFnFb2QBUegt+r1JY0SWokWKr3DqLL/bvo5x
	 jNroWWTekltfEBpOV4Zj3kDMcGBtVEUZbWP6j1zVimAZLgESlrzzcYwW2hXZC3DVtr
	 n/87zR++vqLrQ==
Date: Fri, 12 Sep 2025 09:23:55 -0500
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
 Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org
To: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <20250912104612.361125-2-sbinding@opensource.cirrus.com>
References: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
 <20250912104612.361125-2-sbinding@opensource.cirrus.com>
Message-Id: <175768614846.1334101.790430136214109294.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: cirrus,cs35l41: Document the
 cirrus,subsystem-id property


On Fri, 12 Sep 2025 11:45:37 +0100, Stefan Binding wrote:
> Add new property: cirrus,subsystem-id
> This new property is used to uniquely identify the system if device
> tree is used, to allow the driver to select the correct firmware and
> tuning for the system.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml: cirrus,subsystem-id: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml: properties:cirrus,subsystem-id:type: 'string' is not one of ['boolean', 'object']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml: properties:cirrus,subsystem-id:type: 'boolean' was expected
	hint: A vendor boolean property can use "type: boolean"
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250912104612.361125-2-sbinding@opensource.cirrus.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


