Return-Path: <linux-kernel+bounces-749218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A11CB14B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B19189B9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611D0288525;
	Tue, 29 Jul 2025 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="b+ta6P8G"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122322DA15;
	Tue, 29 Jul 2025 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782293; cv=none; b=EihAKqqgpIMpbK+TeM51gpi2YBCwFFHM0QVuNGfNmxdpDIW6xHau8SdbYVZlSprW+iEw+3Vamo1W6PvBf4tN3oiMnIKENv1VqKXgrInjskgew5ZHUOz38Pe4q8JOlnL4zemV5g9OHK6YcjyDRjQUEv/c3EAqsjP117TacWyONkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782293; c=relaxed/simple;
	bh=wwhfdEjKk3TD0g/+LXfOKPPQJZrSqxYsRtEHez2gGEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJga7czfAdAUHwqEJqifQx8cRokHyn0aNnn1WvyFw6EgWlcKfex06CW8HGGk1IatDW9DRHDZsadx95JyeWttTfYTgTxhE76JurT2kCpFYEv6VQTb3KdvxQZ8/45ZQiLuCGnGWfjmrN2/vp7fVuvPUFdG7zWW26kXtT1F5Lx3CQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=b+ta6P8G; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AB7BE22E3A;
	Tue, 29 Jul 2025 11:44:50 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VG1y5xU0OrVJ; Tue, 29 Jul 2025 11:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753782289; bh=wwhfdEjKk3TD0g/+LXfOKPPQJZrSqxYsRtEHez2gGEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b+ta6P8GfdeL2XpBmv4IbvF6ca52Tkf9nYHzCEKOcEZ6dxiQC87AOb7dmQjNI0kW+
	 dTmcsSrR8iTyN4+UCJ6j+A7yJAppQu/CXkc4pasuuAOjgPgWYt+9b9X1RD74kJDDpj
	 RDYBe8llF+zGEvpP5UnCvPWjMzh3GiB6jUItGfm0MnZ5agxWAWKXOXxjI30y+K/lDo
	 mJ5W+SDybRsXe3znDYxeRfwjVe1zYkiTpA9+kJSO6rIX3bwyizEtYpQKXe9/lTXJMe
	 2wDyg7Hue6mL32UTbdQJMQktsth6Jj9Mt8UUzZOHzQSOKslVwfguWhlPTYh3+K1LRD
	 HYMUPj1/I7W1w==
Date: Tue, 29 Jul 2025 09:44:37 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ze Huang <huangze@whut.edu.cn>, Ze Huang <huang.ze@linux.dev>,
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
Message-ID: <aIiYBaEMNWg20f8-@pie>
References: <20250729-dwc3_generic-v7-0-5c791bba826f@linux.dev>
 <20250729-dwc3_generic-v7-1-5c791bba826f@linux.dev>
 <aIgmrQ7afSO5sjB_@pie>
 <aIhi9JKZvuYh2Rz_@cse-cd03-lnx.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIhi9JKZvuYh2Rz_@cse-cd03-lnx.ap.qualcomm.com>

On Tue, Jul 29, 2025 at 01:58:12PM +0800, Ze Huang wrote:
> On Tue, Jul 29, 2025 at 01:41:01AM +0000, Yao Zi wrote:
> > On Tue, Jul 29, 2025 at 12:33:55AM +0800, Ze Huang wrote:
> > > Add support for the USB 3.0 Dual-Role Device (DRD) controller embedded
> > > in the SpacemiT K1 SoC. The controller is based on the Synopsys
> > > DesignWare Core USB 3 (DWC3) IP, supporting USB3.0 host mode and USB 2.0
> > > DRD mode.
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: Ze Huang <huang.ze@linux.dev>
> > > ---
> > >  .../devicetree/bindings/usb/spacemit,k1-dwc3.yaml  | 124 +++++++++++++++++++++
> > >  1 file changed, 124 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..7007e2bd42016ae0e50c4007e75d26bada34d983
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
> > > @@ -0,0 +1,124 @@
> > 
> > ...
> > 
> > > +  resets:
> > > +    items:
> > > +      - description: USB3.0 AHB reset
> > > +      - description: USB3.0 VCC reset
> > > +      - description: USB3.0 PHY reset
> > > +      - description: PCIE0 global reset (for combo phy)
> > 
> > Why should the USB driver takes care of the PCIe stuff? This sounds
> > strange to me.
> > 
> 
> On K1, PHY depends on the clocks and resets it shares with the controller,
> and the controller driver is guarantees that any needed clocks are enabled,
> and any resets that affect the PHY are de-asserted before using the PHY.

So does the "PCIe0 global reset" make effects to both USB3 and PCIe
**controllers**? If not, this is something wrong in the devicetree side.

> RESET_PCIE0_GLOBAL reset is necessary during, and only, the calibration stage
> of combo phy.

If it's only used by PHY, why couldn't it be a property of the PHY?
Sorry, but I still cannot get the point.

Regards,
Yao Zi

> To simplify both the driver architecture and the device tree files,
> RESET_PCIE0_GLOBAL (and some other clk/reset) are now managed by the
> relevant controller driver (either USB3 or PCIe0) instead of PHY driver.
> 
> Only one of USB3.0 SuperSpeed and PCIe-0 will be activated in a boot.
> PCIe-0 will not be affected when it's working.

