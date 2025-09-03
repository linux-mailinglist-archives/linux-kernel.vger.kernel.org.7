Return-Path: <linux-kernel+bounces-797828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EFDB415DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26265E5E74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F482D94BB;
	Wed,  3 Sep 2025 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="h823sxDy"
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com [220.197.32.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313604F5E0;
	Wed,  3 Sep 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883381; cv=none; b=BQMDf5hge6qDyQPtKDfwmljWTs9UjlFsdedpuW7NnnOybAU+PwdqJAt75qDC33wj2omKJ6ZttSRJP6OBHqQXmwxpItefxAXpMKPB4Ih/dWeL+Ed6dIs2Gp6uFCjAHLEP7EDT/J1zfNR7PeMyVp6XRoq8/CTB5ozYlRqcK7AjgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883381; c=relaxed/simple;
	bh=HZM07RzOMMhrU+nCjoLRXuM4rzVlBLGCFPd2V1j84i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Na3CawjMukXbxDeWIdMI5xbZyLEPQMEdVClKhP+ctl5Ca6Oav7CDX3f06pWGyqM8YcgHHnmAQm/MCzim0Sw+mnIfKJ3MikZWieMtx6NjHVyRVzG4gVIFY69mA8lyRx64FjnPUdFdPEf8PoX3l4xxJQbYfAKQtHcWbvsGZxYtlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=h823sxDy; arc=none smtp.client-ip=220.197.32.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 21811dac9;
	Wed, 3 Sep 2025 11:40:18 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org
Cc: adrian.hunter@intel.com,
	arnd@arndb.de,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gordon.ge@bst.ai,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v3 6/8] arm64: dts: bst: add support for Black Sesame Technologies C1200 CDCU1.0 board
Date: Wed,  3 Sep 2025 11:40:16 +0800
Message-ID: <20250903034018.3422601-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ce1285be-5a3f-4d4b-bca1-e31f56573597@kernel.org>
References: <ce1285be-5a3f-4d4b-bca1-e31f56573597@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a990da93a8209cckunm8503e29c32ceb9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGk9DVkkaSB8ZGB1KH0tKS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=h823sxDypYoSJgayVX0U9DHevrcw9a5zlIxxSNfQqEPzSwlsPjultw7uxMH6+9fM9xemCwZCD4RkEjzkJZw3R5M7Xf7rp+rwgFU6NgZ1kpAyHO99ptWQ02xoHV2DcLmdyXdYCCfSMgFWNFTIQfW7FfCpEnHB4vP8rwupiHIbp98=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=VabSWEHZKq/Uo/eI7fVeM6GFJkY3NwC9Mx0za1md01Y=;
	h=date:mime-version:subject:message-id:from;

On Tue, Aug 12, 2025 at 06:16:08PM +0200, Krzysztof Kozlowski wrote:
> On 12/08/2025 14:31, Albert Yang wrote:

Thank you for the detailed review and your patience. Apologies for not addressing these properly in v1/v2.
I have fixed the issues in my local tree and will send v4. Below are my point-by-point replies.


> > +&uart0 {
> > +   status = "okay";
> > +};
> > +
> > +&mmc0 {
>
> This is none of the two approved ordering styles from DTS coding style.
> What sort of coding style are you using?
>
Thank you for pointing this out. I did not follow the DTS coding style correctly earlier. I have re-read the DTS coding style and the relevant dt-bindings documentation:
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html


> > +           cpu@0 {
> > +                   compatible = "arm,cortex-a78";
> > +                   device_type = "cpu";
> > +                   enable-method = "psci";
> > +                   next-level-cache = <&l2_cache>;
> > +                   reg = <0>;
>
> 0x0
>
> And why reg is the last? Please follow DTS coding style.
>
> I already asked for this at v1. How did you resolve that comment?
>
> Then I asked about this at v2:
>
> "Nothing improved. I asked to follow DTS coding style in ordering."
>
> So can you please respond to comments? You keep sending the same - third
> time - and this is waste of our time.
>
I referenced the ARM CPU node binding: Documentation/devicetree/bindings/arm/cpus.yaml
Updated as follows
		cpu@0 {
			device_type = "cpu";
			compatible = "arm,cortex-a78";
			reg = <0x0>;
			enable-method = "psci";
			next-level-cache = <&l2_cache>;
		};


> > +           mmc0: mmc@22200000 {
> > +                   compatible = "bst,c1200-dwcmshc-sdhci";
> > +                   reg = <0x0 0x22200000 0x0 0x1000>,
> > +                         <0x0 0x23006000 0x0 0x1000>;
> > +                   interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> > +                   clocks = <&clk_mmc>;
> > +                   clock-names = "core";
> > +                   max-frequency = <200000000>;
> > +                   bus-width = <8>;
> > +                   non-removable;
>
> Hm, this is odd to see in SoC. Are you saying that your SoC (!) has MMC
> memory embedded?
>
> > +                   dma-coherent;
> > +                   status = "disabled";
>
> If so, why is it disabled?

Good catch. The device is not SoC-embedded; it is a board-level eMMC. Changes:
- Removed non-removable from the SoC dtsi
- Kept the controller disabled in the SoC dtsi
- Enabled the controller and set non-removable in the board DTS (&mmc0)
Updates:
in bstc1200.dtsi:
		mmc0: mmc@22200000 {
			compatible = "bst,c1200-dwcmshc-sdhci";
			reg = <0x0 0x22200000 0x0 0x1000>,
			      <0x0 0x23006000 0x0 0x1000>;
			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
			clocks = <&clk_mmc>;
			clock-names = "core";
			max-frequency = <200000000>;
			status = "disabled";
		};
in board bstc1200-cdcu1.0-adas_4c2g.dts:
&mmc0 {
	bus-width = <8>;
	memory-region = <&mmc0_reserved>;
	non-removable;
	status = "okay";
};


> > +           gic: interrupt-controller@32800000 {
> > +                   compatible = "arm,gic-v3";
> > +                   #interrupt-cells = <3>;
> > +                   #address-cells = <2>;
> > +                   #size-cells = <2>;
> > +                   interrupt-controller;
> > +                   ranges;
> > +                   reg = <0x0 0x32800000 0x0 0x10000>,
> > +                         <0x0 0x32880000 0x0 0x100000>;
>
> Random order...

Refs: arm,gic‑v3 binding
https://raw.githubusercontent.com/torvalds/linux/master/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
Updated as follows:
		gic: interrupt-controller@32800000 {
			compatible = "arm,gic-v3";
			#interrupt-cells = <3>;
			#address-cells = <2>;
			#size-cells = <2>;
			ranges;
			interrupt-controller;
			reg = <0x0 0x32800000 0x0 0x10000>,
			      <0x0 0x32880000 0x0 0x100000>;
			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
		};
  
Thanks again for the review. If you have no objections to the current modifications,
I’ll post v4 accordingly.

Best regards,
Albert

