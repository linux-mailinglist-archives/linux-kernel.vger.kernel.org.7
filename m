Return-Path: <linux-kernel+bounces-748950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F01DB147F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2323BA923
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F72475E3;
	Tue, 29 Jul 2025 05:58:24 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA31C84D6;
	Tue, 29 Jul 2025 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753768703; cv=none; b=My7OAwpGz0LJDHnE6kL9znxu136BvvA/COsGJr08R3GXtZJoyf6odTsrRy0YPEzMHORvlt0pQ7UASdOMS6+YFtSSfKe9NqcovqGhD8sd8drJNyDjfvNcs6FA8StJgtInEaSxSR7n4Wy00wL2xIl0NpsbRmZg2w2YZRd7aQUOuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753768703; c=relaxed/simple;
	bh=UVtJkUYCbOCf3Xc1JFWl4zmDPnvOktYHaga7VdFr12A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9OUPOHQtgI4C1cdX43VeCyZt3n/C/La/sOf67swWUWuuX2wydwaIVvOxLSoXztke+R3eDvssto5ym1NoXyVJXStitcA0QbD9ps78Ap7HRAsdjrJV77KAEEikXTaByzRkrxZ0rl9j4mrVjXSwWExFgLQKUP/dowgo9etsO8frWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from localhost (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [114.94.8.21])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1d9200ef5;
	Tue, 29 Jul 2025 13:58:13 +0800 (GMT+08:00)
Date: Tue, 29 Jul 2025 13:58:12 +0800
From: Ze Huang <huangze@whut.edu.cn>
To: Yao Zi <ziyao@disroot.org>, Ze Huang <huang.ze@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ze Huang <huangze@whut.edu.cn>
Subject: Re: [PATCH v7 1/2] dt-bindings: usb: dwc3: add support for SpacemiT
 K1
Message-ID: <aIhi9JKZvuYh2Rz_@cse-cd03-lnx.ap.qualcomm.com>
References: <20250729-dwc3_generic-v7-0-5c791bba826f@linux.dev>
 <20250729-dwc3_generic-v7-1-5c791bba826f@linux.dev>
 <aIgmrQ7afSO5sjB_@pie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIgmrQ7afSO5sjB_@pie>
X-HM-Tid: 0a9854c28f5e03a1kunm053f6d441bb8a9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTx4dVk9CGhgZS0xMGB4aSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk9VQk9VQ1VJSllXWRYaDxIVHRRZQVlPS0hVSktJQk1LSlVKS0tVS1kG

On Tue, Jul 29, 2025 at 01:41:01AM +0000, Yao Zi wrote:
> On Tue, Jul 29, 2025 at 12:33:55AM +0800, Ze Huang wrote:
> > Add support for the USB 3.0 Dual-Role Device (DRD) controller embedded
> > in the SpacemiT K1 SoC. The controller is based on the Synopsys
> > DesignWare Core USB 3 (DWC3) IP, supporting USB3.0 host mode and USB 2.0
> > DRD mode.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Ze Huang <huang.ze@linux.dev>
> > ---
> >  .../devicetree/bindings/usb/spacemit,k1-dwc3.yaml  | 124 +++++++++++++++++++++
> >  1 file changed, 124 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..7007e2bd42016ae0e50c4007e75d26bada34d983
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
> > @@ -0,0 +1,124 @@
> 
> ...
> 
> > +  resets:
> > +    items:
> > +      - description: USB3.0 AHB reset
> > +      - description: USB3.0 VCC reset
> > +      - description: USB3.0 PHY reset
> > +      - description: PCIE0 global reset (for combo phy)
> 
> Why should the USB driver takes care of the PCIe stuff? This sounds
> strange to me.
> 

On K1, PHY depends on the clocks and resets it shares with the controller,
and the controller driver is guarantees that any needed clocks are enabled,
and any resets that affect the PHY are de-asserted before using the PHY.

RESET_PCIE0_GLOBAL reset is necessary during, and only, the calibration stage
of combo phy.

To simplify both the driver architecture and the device tree files,
RESET_PCIE0_GLOBAL (and some other clk/reset) are now managed by the
relevant controller driver (either USB3 or PCIe0) instead of PHY driver.

Only one of USB3.0 SuperSpeed and PCIe-0 will be activated in a boot.
PCIe-0 will not be affected when it's working.



Hi Alex, please correct me if anything wrong

> > +  reset-names:
> > +    items:
> > +      - const: ahb
> > +      - const: vcc
> > +      - const: phy
> > +      - const: pcie0
> 
> Best regards,
> Yao Zi
> 
> 
> 

