Return-Path: <linux-kernel+bounces-724648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58834AFF567
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522871C465F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16D82609D9;
	Wed,  9 Jul 2025 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cirGtbSo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D733993;
	Wed,  9 Jul 2025 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752103835; cv=none; b=Kt+NUV68O5iqWttNbeODPeb+KwwUEC3PlqsUkMlB01/aJDsRMM7LWCq2vXz0KmUOChb3skPDXyxIWv1yW2a4kvC+nmGZYUauG5eomdD0fcKIMoAPCLycQPIzuxq1yvQfPwO+YaW4omV+gpuQe+r7J/G5IfzakBiVyssTipgJOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752103835; c=relaxed/simple;
	bh=XuaRcAgoN0AxdCzQdQl12wDD/O9qp7Ie+TcWhj5ipYw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZUAcgAN2F/YvMRyMPtTxaM7g8DLTi9gj2IXtWTBT0DDq7VE8E3h4FXevGSwwhLaXCN5VllYW0F9/oEuEEENK/cUrYy1EA1J38h3Q3a1qvihU7lJnbvdjzHJ+eUpEx5LAUE5x93MRV9Lfb7mdXazJRLDIsjvJJ2yrp3piw7/cmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cirGtbSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9515BC4CEEF;
	Wed,  9 Jul 2025 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752103834;
	bh=XuaRcAgoN0AxdCzQdQl12wDD/O9qp7Ie+TcWhj5ipYw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=cirGtbSoLuEJcfpwna9P4x6JMFaId24y2UJdczDxKpWwiCg9WqZ666J9+JNccM45J
	 waVTWcURXNCjfngjTk4gERXXI/gNIRb9I/XblhDlq2fv1ZZIpe9/5cfXKX/L0RlGCy
	 +wdRWgeFANN2xogqpl89vQFMkucl4aWeOSL9eObhap39QBpWUMbjlYWJeSsOxnM/yc
	 qnyb/hE1YuFc/qQGeoB1GibvoGF+ZEiyWxbiwcuW65Hy6qCq6wCFOOEBzQzLMrY0uw
	 KnVO3f9r2kd1EXumnByvoEdjXafq0VTJXKOPWAAi+5seFWbN+swkgmT9sW4y+/8/Br
	 524ltuSgdFGtA==
Date: Wed, 09 Jul 2025 18:30:33 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: vkoul@kernel.org, linux-phy@lists.infradead.org, conor+dt@kernel.org, 
 jyxiong@amazon.com, devicetree@vger.kernel.org, anishkmr@amazon.com, 
 kishon@kernel.org, linux-kernel@vger.kernel.org, miguel.lopes@synopsys.com, 
 krzk+dt@kernel.org
To: Karthik Poduval <kpoduval@lab126.com>
In-Reply-To: <20250709221724.1276428-2-kpoduval@lab126.com>
References: <20250709221724.1276428-1-kpoduval@lab126.com>
 <20250709221724.1276428-2-kpoduval@lab126.com>
Message-Id: <175210383317.4144520.12202639911629037597.robh@kernel.org>
Subject: Re: [PATCH 2/2] phy: dw-dphy-rx: Add dt bindings for Synopsys MIPI
 D-PHY RX


On Wed, 09 Jul 2025 15:17:24 -0700, Karthik Poduval wrote:
> Add DT Bindings for Synopsys D-PHY RX, presently tested on version 1.2
> 
> Signed-off-by: Karthik Poduval <kpoduval@lab126.com>
> ---
>  .../bindings/phy/snps,dw-dphy-rx.yaml         | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml: ignoring, error in schema: properties: reg
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml: properties:reg: [{'minItems': 2}, {'maxItems': 2}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml: properties:reg: [{'minItems': 2}, {'maxItems': 2}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/phy/snps,mipi-dphy-rx.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.example.dtb: /example-0/dw-dphy@900000040: failed to match any schema with compatible: ['snps,dw-dphy-1p2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250709221724.1276428-2-kpoduval@lab126.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


