Return-Path: <linux-kernel+bounces-896866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2025EC5170A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AEDE4FF5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F42FF149;
	Wed, 12 Nov 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4hiLWPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03C2FE050;
	Wed, 12 Nov 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940114; cv=none; b=b8xiorRnCwTc5P0gK86xZulAtwAhT76jq3nSJg5QLuXBOyxH3T4tgKenFNSWodXX1nnxMH9dMMWkPhaC8YMOgYyvPYP7DSMmzzYK6Us0p3mQ6d9Am5x0WDpfF2mYRBRYmRZYCOx344JoCuTWp4teLdiGvrT4/dKosUzZfB9jQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940114; c=relaxed/simple;
	bh=IOdEi/7nm6gSBW15F/BMgBUX9SN7wqTjO+nYOESPGFQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=h7ilUPtY2o6OzIkq7bPo9M4fZfqs1FB8Nrj3f5c8Qdb+iMS5eRNf9HtmBo99OWq84yNxe3Oi57VKyiGFp0ohqr4ZMRCQiHFb2vqZ/3wmImi63j/peSP4k/oGOx5vruYM+rgACM9QdOH/z6PcEIiHEfJTdJHEs81UtDigpH4Hg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4hiLWPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBD8C16AAE;
	Wed, 12 Nov 2025 09:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762940113;
	bh=IOdEi/7nm6gSBW15F/BMgBUX9SN7wqTjO+nYOESPGFQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=B4hiLWPdZ/fueJdOAr9IS/urlVJh7yN5P0kCLtBPV9aDAvSeV/XJeWkQB46RNUP2G
	 Pw/fPY5UyXbRDrb8qvfGG/b4EUiuugOKpmfPFPEJ/NYVE6gnsJj7zYeDENJFx2y33X
	 R1DpIfXpL6asKQAQyEL+oDd1N7u0I/C3dJ7/TOnEqhjaGOVPyp60ZzepvU00kQiXpE
	 DGsUQxTiAAOpspJtsnmTA6sHpzO6XsM+hmPLzVY8tTU4jBHYCCUQWbscl0oBvHYcOg
	 gdshp+3bFlgkmNtKYox2uuUVVbKjn7MP17FCTKLrrH9W4eLK6c/D3MD5pKqzTvGMvb
	 GaFFZOJlUuc1w==
Date: Wed, 12 Nov 2025 03:35:11 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, 
 Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
To: Anshul Dalal <anshuld@ti.com>
In-Reply-To: <20251112-k3_syscon_add_boot_mailboxes-v2-1-aebc1e47b391@ti.com>
References: <20251112-k3_syscon_add_boot_mailboxes-v2-0-aebc1e47b391@ti.com>
 <20251112-k3_syscon_add_boot_mailboxes-v2-1-aebc1e47b391@ti.com>
Message-Id: <176294011177.754689.174685485920424984.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: keystone: add missing items
 to mboxes


On Wed, 12 Nov 2025 14:00:53 +0530, Anshul Dalal wrote:
> The mailboxes for the ti,sci node were not documented, this patch adds
> the description for the two channel entries as per TI-SCI spec[1].
> 
> [1]:
> https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am65x/sec_proxy.html
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml: properties:mboxes: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'description': 'RX thread'}, {'description': 'TX thread'}] is too long
	[{'description': 'RX thread'}, {'description': 'TX thread'}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251112-k3_syscon_add_boot_mailboxes-v2-1-aebc1e47b391@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


