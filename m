Return-Path: <linux-kernel+bounces-827792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55104B92F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A312E029D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B8313532;
	Mon, 22 Sep 2025 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSlPx4Sh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C92F39BF;
	Mon, 22 Sep 2025 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570056; cv=none; b=WefLcJugXAmGsX8TUCgPlyNKHV8QWPCCq6CfRDSRPVCoUAnwd9/qha7tiSxhLzzDSapkJo6nc+Y8i/cc4Kjji3b2sYVZgeu7rioGV4jfnBT1hLHFGi2xY+YCA5MZef5bo7rxFFEPHoEL0qZikvB9z/vSBkr0ivpHX4IVUw1KoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570056; c=relaxed/simple;
	bh=iiqDCDgZdcVZr0vXnR7UqoT7M33BpEH7LbsLXcuX/3c=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iXa4Ycl+Re6lE2FxHZGT2u3UpHpVqdmW7DZQLKMvyOqOScyXK2sqTMo6YhhM+EF743RqrrPyPSgNkyrkhiRfXkaIdbk1YMSC6r+3RtrHFS84IkiU29Gx+ZvpzUwFGmaKMc+v9HMVCm52AQWeSGJUrU3NQWwTnAdhFG1dPPTNEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSlPx4Sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61220C4CEF0;
	Mon, 22 Sep 2025 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758570056;
	bh=iiqDCDgZdcVZr0vXnR7UqoT7M33BpEH7LbsLXcuX/3c=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QSlPx4ShwYgZuryexQpl/Rr0eN1QmDS/HtHyyF87LjYA2N89dhSy0aGR2k34xVe5g
	 FKVTU7i7bDebF9i2EZTBMiIK7bKp47zIhvE5SE001ojwjeBqK1qN3V4T9eI1YpewPQ
	 Ib45b7GffShCUjdCKTZg1HpcatP7lhLZZ2Dl7vxgSHRYu8fIUXmzbKnLH9rTQqFjUv
	 2tp1KvdGvDXT9BUzxwcU3LlG3Eiq76FlKYnln968CCSr4drkxf88QeSFpjeuPMo4Sr
	 lWMsl7xkITD3yMiMKI1qfduJwIhN1MZ0YC62PU7QiX0QLsDuVCJW6TMFtdijvaYaB5
	 WhiAzzOOKUPDQ==
Date: Mon, 22 Sep 2025 14:40:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 devicetree@vger.kernel.org, Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
In-Reply-To: <20250922160715.346137-1-jm@ti.com>
References: <20250922160715.346137-1-jm@ti.com>
Message-Id: <175857005548.994643.9822023252083969281.robh@kernel.org>
Subject: Re: [RFC PATCH v2] dt-bindings: nvmem: Introduce nvmem efuse
 binding for TI K3 SoCs


On Mon, 22 Sep 2025 11:07:15 -0500, Judith Mendez wrote:
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
> 
> Changes since v1 RFC:
> - Drop depreciated nvmem-deprecated-cells.yaml since nvmem.yaml
>   already includes nvmem-layout.yaml.
> - gp-sw efused-backed reg is 128 bits, so update size of example
>   to 0x10.
> 
> Link to RFC v1:
> https://lore.kernel.org/linux-devicetree/20250916154809.545283-1-jm@ti.com/
> ---
>  .../devicetree/bindings/nvmem/ti,efuses.yaml  | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250922160715.346137-1-jm@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


