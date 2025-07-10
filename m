Return-Path: <linux-kernel+bounces-725098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A4EAFFAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9D11C82BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67179289344;
	Thu, 10 Jul 2025 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVQKw8Vz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE764288C18;
	Thu, 10 Jul 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132245; cv=none; b=GiFE90fRSO58eVAowPV8yotOsqUalE6oOgKkYK+j8zLinF430Np89OfSis0jarQRnfOrwQk5by8DQUoOhfIIvA3ckLLJe4JN53VNymF3xhUtDYmNNVB5e+RPkr2i2WPvwix66JFGUStmJdKVcZ/fsvidaRoRRypyrFqw755MIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132245; c=relaxed/simple;
	bh=SFkkw4ctGLrTmBRlu2RlFZWVe6en+oY/fO9F/Li48Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU46Ws4pFX2fwC0smOafcZqHhcT8S50oBo4fyXIOqeecm4P7JNne9ZhYRm2/onvkvt7h0GtSPZLES6YzgPHalzb4pSmc0OdSn+uMgmQiBs/+OR3HFp74sc2WfgTFDbhMrmWNvtGBGNHEZFW8TgscpSshI3+6fyvufCYZhtrE444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVQKw8Vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7134C4CEE3;
	Thu, 10 Jul 2025 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132245;
	bh=SFkkw4ctGLrTmBRlu2RlFZWVe6en+oY/fO9F/Li48Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVQKw8Vz982DsUsU73OrlqR9Y55+VP38DzfT2XJLoeZG00lmFYo3E39zm+suCvIKY
	 MvGr4NkqAfQ/nqr5cy4f9Ih6aKjQhz41zdwZNFU5Mxmn7cyp6OLy/BUwh5HuCuR53+
	 WPoe1HX25Lqs2ZuRVvTIEgyuSr1mDZci6QCMIFIOXd4d54YDlENJ3U8Mu+2xmFJ2ZE
	 fd6v1guQRQAru2rySgrmf5dpjXHscCtVX+2Y/XuISEF0/2W3xgBgzvoOzb06kzjmx8
	 mgth7ClVPnUpkbtuFLbMqi9+rKhtHnwTTz8Quv3S1l6j894c5fz9hlkO3JMBC3ECuy
	 zUkLk4k+PR8xQ==
Date: Thu, 10 Jul 2025 09:24:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karthik Poduval <kpoduval@lab126.com>
Cc: jyxiong@amazon.com, miguel.lopes@synopsys.com, anishkmr@amazon.com, 
	vkoul@kernel.org, kishon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: dw-dphy-rx: Add dt bindings for Synopsys
 MIPI D-PHY RX
Message-ID: <20250710-dainty-tarsier-from-hyperborea-ecf9d3@krzk-bin>
References: <cover.1752106239.git.kpoduval@lab126.com>
 <7f4b676678b27ea91314c834a297c1e057959b09.1752106239.git.kpoduval@lab126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f4b676678b27ea91314c834a297c1e057959b09.1752106239.git.kpoduval@lab126.com>

On Wed, Jul 09, 2025 at 07:42:21PM -0700, Karthik Poduval wrote:
> +---
> +$id: http://devicetree.org/schemas/phy/snps,dw-dphy-rx.yaml#

Filename and id should match compatible.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys Designware MIPI D-PHY RX
> +
> +maintainers:
> +  - Karthik Poduval <kpoduval@lab126.com>
> +  - Jason Xiong <jyxiong@amazon.com>
> +  - Miguel Lopes <miguel.lopes@synopsys.com
> +
> +description: |
> +  These are the bindings for Synopsys Designware MIPI DPHY RX phy driver.
> +  Currently only supported phy version is v1.2.
> +
> +properties:
> +  compatible:
> +    const: snps,dw-dphy-1p2

You should rather use SoC compatibles.

> +
> +  '#phy-cells':
> +    const: 0
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2

List the items instead

And fix the order, reg goes second.

> +
> +required:
> +  - compatible
> +  - '#phy-cells'
> +  - reg

Here as well

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dw_dphy_rx: dw-dphy@900000040 {

phy@

> +        compatible = "snps,dw-dphy-1p2";
> +        #phy-cells = <0>;
> +        reg = <0x0 0x90000040 0x0 0x20>, <0x0 0x90001000 0x0 0x8>;
> +        status = "disabled";

No, drop. And fix the order of properties, see DTS coding style.

> +    };

Best regards,
Krzysztof


