Return-Path: <linux-kernel+bounces-819526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10805B5A215
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FE21C04D94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D672FFFBB;
	Tue, 16 Sep 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2/WScE1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DA2DD60F;
	Tue, 16 Sep 2025 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053528; cv=none; b=Nvy56g1gmYNFRTNWnyZ4q1j3TTZlp3XOi8pNeKyNBuJ0f7cfKT0B/fFjQ/okIC3BQrEYZA2M3kgau+n+ycE3cg0jzHWRPJOz56DmWGBhLCiWD7vmYmo0yGmpam17wJNfryEzg+pGcESeThKnr5xqCeX5kaFmBcop6kKZwqQ3d8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053528; c=relaxed/simple;
	bh=8kayku5NBl2JfHdpwK5pr2SC0tbjz2aUQo+ZEPiSsHY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nhpXy2FTgFi/2sNgT6mdl+My9ejTtxZTHgPJcIo4M/nnOt5rL6kyKZemWOWl4U6EVppaO03qQgac1ht/Wwb5lq9RoFkUzKrck6mktJPBSPX1wQaMJdDGk4gIBKKrFGwJpqyi+7j3JPSj59YyBlGFjzLTD3OiG1BX/mUNEulopd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2/WScE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F5EC4CEF0;
	Tue, 16 Sep 2025 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758053528;
	bh=8kayku5NBl2JfHdpwK5pr2SC0tbjz2aUQo+ZEPiSsHY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=e2/WScE1msXXyzkubqEOkOf+NuRPtEUReD8DmdRMl6kA9jzxRcwj6602Pz+9v6Bzx
	 c2yedcgVmRtUbbWbplk9xwy38bltHgJb1cNc0ahFZeNrU7n9ZYgik6M0tv5Jo0ulJV
	 muFs3av4awKXqwFzGMjClyCHLwYpEtENhoosjG+usBphoiHygR8/tzgEWVq88zuO7q
	 LR5nTv3ReXTMwvu3me+KtboND4YqAiwqmHGg2m90KzGpoxPRlR0iHxe68zjZifND01
	 sz10SwN7eO4TaZapYjt32kCX7PmHv5onWLS4pKypuAEDkWiAvPQeFFeqC+mWdZWeUC
	 VKhPHvBEKeJ8Q==
Date: Tue, 16 Sep 2025 15:12:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
In-Reply-To: <20250916154809.545283-1-jm@ti.com>
References: <20250916154809.545283-1-jm@ti.com>
Message-Id: <175805351357.4005718.6551892700473732333.robh@kernel.org>
Subject: Re: [RFC PATCH] dt-bindings: nvmem: Introduce nvmem efuse binding
 for TI K3 SoCs


On Tue, 16 Sep 2025 10:48:09 -0500, Judith Mendez wrote:
> On K3 SoCs there are efuse registers scattered across the memory
> map. In order to reference these efuse registers like gp-sw which
> may store SW REV information or other general purpose information
> for drivers to consume, treat them appropriately as efuse devices
> with nvmem framework.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> This patch is not complete and is sent as an RFC to get some initial
> thoughts on this implementation to solve [0].
> 
> [0] https://lore.kernel.org/linux-mmc/736f09e0-075a-48e0-9b32-6b8805a7ee2a@kernel.org
> ---
>  .../devicetree/bindings/nvmem/ti,efuses.yaml  | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml: ignoring, error in schema: properties: compatible
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml: properties:compatible: [{'const': 'ti,am62p-efuse'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml: properties:compatible: [{'const': 'ti,am62p-efuse'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Documentation/devicetree/bindings/nvmem/ti,efuses.example.dtb: /example-0/efuse@43000230: failed to match any schema with compatible: ['ti,am62p-efuse']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250916154809.545283-1-jm@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


