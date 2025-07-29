Return-Path: <linux-kernel+bounces-748777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F1B145EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A04543534
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF361F8ACA;
	Tue, 29 Jul 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="B9KloKMh"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F71F37C5;
	Tue, 29 Jul 2025 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753753288; cv=none; b=aqqKhnVidR/V4eChmH8R2voTyQlSPzM30SmNddMm7r36+3bACgwQHqiEZquD4fjfkerqDaW6hhRPy96dVTYqdoCxv+V+es57Ax3p/fd09w5Q/L8GH7W4R2L4eYQcMidFnP5qsWmCDG6bjsZFmLcqClGA2hR/89nItZgz3ovJIu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753753288; c=relaxed/simple;
	bh=7jL0NE4cF4xqYnGuVecwCuQthPBG5AwQZhJM7XTG5Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Prmy/GL+LEDh92MBcrcaCpJ63B4bx3JPc85AX8cu4LcKhBJe+q6q+ntvfiOrvuHnhC+ZVpuYXTjQMlckIbr6vJ8EsI1pk5iHxFui+kgFb5VECTL8z7rxlHjlrHB7y2WXXsNm/rc6H5Mi/ltnH2pOdG46mD6eB3oxkyrGGKCvR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=B9KloKMh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4A82325D07;
	Tue, 29 Jul 2025 03:41:23 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ckl6WRtZjqNd; Tue, 29 Jul 2025 03:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753753282; bh=7jL0NE4cF4xqYnGuVecwCuQthPBG5AwQZhJM7XTG5Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B9KloKMhlJyyRh81m9m/G3F+TnYK+unb5HmSIcZYXv9skznThsPV7h/WJffNlxaJj
	 GgelXZd6oZyPw3DHn2h5K07c7MdBLXmnkcXFhOCDK/lbxmgM2JtehkiPcayyUeZLPA
	 CxOt4PLcDLpw7MfjzJ569Yu1jHgXTqSh42zh47HsACMyiVQg/6sJJZnjh1TTSjYhfZ
	 AFWr+MskYiXsSrZT2kLjXuenqSzj67q532Gvy79Xvk/YwuvxoUDyTLwAXRg6ZCfZEk
	 KOov8Z0BmgN26+ZXXUU1EY2M2Go+57hXmXtLODAkruVnsjzMIf4llmKPDmKGsCh0Pb
	 Sn3Y0xyX8GMMw==
Date: Tue, 29 Jul 2025 01:41:01 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ze Huang <huang.ze@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: usb: dwc3: add support for SpacemiT
 K1
Message-ID: <aIgmrQ7afSO5sjB_@pie>
References: <20250729-dwc3_generic-v7-0-5c791bba826f@linux.dev>
 <20250729-dwc3_generic-v7-1-5c791bba826f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-dwc3_generic-v7-1-5c791bba826f@linux.dev>

On Tue, Jul 29, 2025 at 12:33:55AM +0800, Ze Huang wrote:
> Add support for the USB 3.0 Dual-Role Device (DRD) controller embedded
> in the SpacemiT K1 SoC. The controller is based on the Synopsys
> DesignWare Core USB 3 (DWC3) IP, supporting USB3.0 host mode and USB 2.0
> DRD mode.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Ze Huang <huang.ze@linux.dev>
> ---
>  .../devicetree/bindings/usb/spacemit,k1-dwc3.yaml  | 124 +++++++++++++++++++++
>  1 file changed, 124 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..7007e2bd42016ae0e50c4007e75d26bada34d983
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
> @@ -0,0 +1,124 @@

...

> +  resets:
> +    items:
> +      - description: USB3.0 AHB reset
> +      - description: USB3.0 VCC reset
> +      - description: USB3.0 PHY reset
> +      - description: PCIE0 global reset (for combo phy)

Why should the USB driver takes care of the PCIe stuff? This sounds
strange to me.

> +  reset-names:
> +    items:
> +      - const: ahb
> +      - const: vcc
> +      - const: phy
> +      - const: pcie0

Best regards,
Yao Zi

