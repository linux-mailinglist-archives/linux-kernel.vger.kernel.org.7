Return-Path: <linux-kernel+bounces-695096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071FAAE1542
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 09:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B133C3B8649
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CEC233128;
	Fri, 20 Jun 2025 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0qlmAo6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA2230BF0;
	Fri, 20 Jun 2025 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405985; cv=none; b=cCG/onzIIry5Sph7MZEWr0jDaJqrDgWKDh8acETGpKtdWZEdtbdKZ+v2HmmTxh7k4lCkZfFAtHGy8NVvm6ETgewVHtz4HL4z0VyA7qWkhkJQt8W/Rcl/vIxUK9zce45uciDlwAxXe8sw1QqJEKfY+cQN9RVOqKn+l7LoXnpploM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405985; c=relaxed/simple;
	bh=4m726/Z0me12Me+hnL7MnK4ol0AFM26gZ8tqBJ8UZHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyhBLyJUbAoqBphxShymUcNSgIRDZLP9isd3FiwssEoqERGG0VxF1qpwMteifKsBRg5lv50p1xLSlmqGrtMYVTc/lwzWbSZZtwBy6IcYmBZwf6x35jbQvX/uU1SXyk5xWLtsUivTzpRVjVs1Lmxrlp7wehtpObzEw/AoAKr0XW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0qlmAo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CF9C4CEED;
	Fri, 20 Jun 2025 07:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750405985;
	bh=4m726/Z0me12Me+hnL7MnK4ol0AFM26gZ8tqBJ8UZHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0qlmAo65bRWeUlFDIeElHSlh4l/ayGsWEX6JUZ093r4Q3ZYb3XIAq/+ZDziGhFFt
	 hyLFw4gzwjY9GE3pJfOwRv8ij+j06A66cK+JfskFOgnzLK8eU6C0dB0tKXlxgoC3+o
	 6ijUUtjhR/Eo9cyOuFWOaDBAMApb4gw4AaJJwig1KS2lyUVcdskkSRvy6xspBO2sJA
	 8U9G1PuY8NpEZNiaZF88uW2H0W+AUGtvzd/SdWP7iHbY3kAyfemQsZRhKPeyOKbgSG
	 h5I+fPW/3iyG3d9DhqIh/AisUvv/tCr/d2L9r6seTOjp21aQw70mmRcvqfa5aHU+ur
	 SQ7p6sNFTLOAA==
Date: Fri, 20 Jun 2025 09:53:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-binding: pci-imx6: Add external reference
 clock mode support
Message-ID: <20250620-honored-versed-donkey-6d7ef4@kuoka>
References: <20250620031350.674442-1-hongxing.zhu@nxp.com>
 <20250620031350.674442-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250620031350.674442-2-hongxing.zhu@nxp.com>

On Fri, Jun 20, 2025 at 11:13:49AM GMT, Richard Zhu wrote:
> On i.MX, the PCIe reference clock might come from either internal
> system PLL or external clock source.
> Add the external reference clock source for reference clock.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index ca5f2970f217..c472a5daae6e 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -219,7 +219,12 @@ allOf:
>              - const: pcie_bus
>              - const: pcie_phy
>              - const: pcie_aux
> -            - const: ref
> +            - description: PCIe reference clock.
> +              oneOf:
> +                - description: The controller might be configured clocking
> +                    coming in from either an internal system PLL or an
> +                    external clock source.
> +                  enum: [ref, gio]

Internal like within PCIe or coming from other SoC block? What does
"gio" mean?

Best regards,
Krzysztof


