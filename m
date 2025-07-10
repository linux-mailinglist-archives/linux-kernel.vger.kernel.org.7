Return-Path: <linux-kernel+bounces-724843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFF1AFF782
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670A91C43700
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDD5280017;
	Thu, 10 Jul 2025 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAoVTWu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAB8821;
	Thu, 10 Jul 2025 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118344; cv=none; b=ZTisUnhIe7gf/c6OorKfXsBNl+85c6DGaqhmYxyCVo/JoxW8rG9YNxnr9YlRjyQQttNnejuCji6wo3l8wDNCqbNcMVe23XXhErCkw+1g0WmFy0cC2H/S7gVEU0yPm+mNYF0cGvZLaZglUWEHSAEzPZgqGUa+qx+oMEeIaBMtUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118344; c=relaxed/simple;
	bh=oxGPO90kQ8j+s8Nl8EgW9xfp03BNzI52lv+hwW5eeqI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Nl3w443AZ1vp4AUFQM2M0zquYZDrTp/RkJG7Hu+o91QXDp7k/v8UrhxQE7Si/lx4aiRw0nPO9eHh5j31UoD7mFuTU5c3hNR1o1QdsSHH+PbxILmuXDKgb8HL9YD6lQ7K1QOkP+2VnGCgJvfClWmcFT0DkIfATtDPHdzDns6is64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAoVTWu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A33C4CEEF;
	Thu, 10 Jul 2025 03:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752118343;
	bh=oxGPO90kQ8j+s8Nl8EgW9xfp03BNzI52lv+hwW5eeqI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=hAoVTWu32BeoY6rMDV1LAW6x1InCW45cEMjW3Ok3rX1vaXaAkfIybTgrZQ6DrfF0C
	 yK/0L8ipNICEfa/yzlJHR1Tb7iWiq42J6Ca77rFmVkfWZrqq2qlR28KIArzhoFS/zr
	 94/tTOFTfGlTuYtNaaPkD3un3cdGZyEZqglmlHu7gRSAM6A78M5O6ICyedni4N9DpP
	 fqTLhR+jt9PlLmKZC11MK5d9So7/BF4z11ZtMhF1z+qvTGhno21FD6eqmOV9YwdznQ
	 rt5dVkeV6vjfS4JDzs/VVYakb8x94IE3zrb1e8qujyJ/VDt+rr2ovWlCRslG2La/db
	 0lwpKxUzAHzWA==
Date: Wed, 09 Jul 2025 22:32:22 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, vkoul@kernel.org, anishkmr@amazon.com, 
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 jyxiong@amazon.com, miguel.lopes@synopsys.com, kishon@kernel.org, 
 linux-phy@lists.infradead.org
To: Karthik Poduval <kpoduval@lab126.com>
In-Reply-To: <7f4b676678b27ea91314c834a297c1e057959b09.1752106239.git.kpoduval@lab126.com>
References: <cover.1752106239.git.kpoduval@lab126.com>
 <7f4b676678b27ea91314c834a297c1e057959b09.1752106239.git.kpoduval@lab126.com>
Message-Id: <175211834224.541763.16377287764717313428.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] phy: dw-dphy-rx: Add dt bindings for Synopsys
 MIPI D-PHY RX


On Wed, 09 Jul 2025 19:42:21 -0700, Karthik Poduval wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.example.dtb: dw-dphy@900000040 (snps,dw-dphy-1p2): reg: [[0, 2415919168], [0, 32], [0, 2415923200], [0, 8]] is too long
	from schema $id: http://devicetree.org/schemas/phy/snps,dw-dphy-rx.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/7f4b676678b27ea91314c834a297c1e057959b09.1752106239.git.kpoduval@lab126.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


