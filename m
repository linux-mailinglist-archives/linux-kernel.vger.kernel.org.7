Return-Path: <linux-kernel+bounces-778975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECBB2ED6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434E96871F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF64C26CE2E;
	Thu, 21 Aug 2025 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ADTSZn+8"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3A3C17;
	Thu, 21 Aug 2025 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755752966; cv=none; b=n0g/OUb13Ufzp2cyj1TKUew/9StTG9hLpfoglUFJVeGaz14RZfkBW/CaP+N6YBGM2e+M21zs1SKp/40uO/mZEcRu2zFe+nWqJfEQ/AKpso+YUiRBD0M9sfex3h6pzZh/EftFw3F39FIUvfd+EoJxwx5dVTdagmPvmuHChj/CbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755752966; c=relaxed/simple;
	bh=7NK2zGbzjLLRpqod79quDmy2E0aLjV9FgP8j/73b5vE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO5CvAq9M+NXUeBKKjKdfWFcEWN3F3Pz7F2hgpDZrWmYpLbnDwGB82TShDagJ1J4XH4bwvMdlHvO9YcHC8Bo+cD9uVBCQSmzUoTiJAfMTBmvFZfrgv5NjtOjdStZy80mEmSCwOTn5G/b1SKfO8+jgrbElpYi8Bta4H5SMW5kTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ADTSZn+8; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57L59Hcf411850;
	Thu, 21 Aug 2025 00:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755752957;
	bh=hFB3oC/joJWZDcoQlOQoYsmel5gZzcnRSFC0rE3cftg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ADTSZn+8UYtlDiHeijjFNw4nqgkzvEBRHAmOdfnJDVjd91hUvHWgea8fWeW220BUr
	 3qe9QDWQYoQKoVhArf5XvRmhccoNIXoh/1F2cI+RLO7d2piuitCtjwmaE5Jg/TrN90
	 z5sSiKgk4hzEuYZnD/3Zo5wxVCHQlfiW2p4z/KUw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57L59Huj1883868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 21 Aug 2025 00:09:17 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 00:09:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 00:09:17 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57L59Gf41621045;
	Thu, 21 Aug 2025 00:09:16 -0500
Date: Thu, 21 Aug 2025 10:39:15 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Michael Walle <mwalle@kernel.org>
CC: s-vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-main: add legacy PCIe interrupts
Message-ID: <663079dc-54cf-4f29-a68b-fc9678c44af0@ti.com>
References: <20250819111317.1082515-1-mwalle@kernel.org>
 <ae898bf0-705f-4e36-9664-37c401f5fee7@ti.com>
 <DC7B5N92V9KZ.34OXBFYOIEWBO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DC7B5N92V9KZ.34OXBFYOIEWBO@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Aug 20, 2025 at 04:00:45PM +0200, Michael Walle wrote:
> Hi Siddharth,
> 
> On Wed Aug 20, 2025 at 3:52 PM CEST, s-vadapalli wrote:
> > On Tue, Aug 19, 2025 at 01:13:17PM +0200, Michael Walle wrote:
> >
> > Hello Michael,
> >
> >> The kernel will try to map the legacy interrupt pins, but the
> >> interrupt mapping is missing from the device tree and thus that
> >> fails with:
> >> 
> >>    pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> >> 
> >> Add the node for the legacy PCIe interrupts to fix that. This is just
> >> compile-time tested.
> >
> > INTx is not supported by the driver as explained at:
> > https://lore.kernel.org/r/be3e3c5f-0d48-41b0-87f4-2210f13b9460@ti.com/
> >
> > The patch to fix the error displayed in the logs was posted at:
> > https://lore.kernel.org/r/20240726135903.1255825-1-s-vadapalli@ti.com/
> > but wasn't accepted as-is. A different approach will be required to fix
> > of_irq_parse_pci() instead as pointed out at:
> > https://lore.kernel.org/r/20240729080006.GA8698@thinkpad/
> 
> Thanks for the pointers.
> 
> I've just checked the J722S errata sheet and there is no such
> erratum. So, is that sheet outdated or was it fixed?

According to the Errata documents, the errata only affects J721E SoC.
The procedure to enable the INTx support is the following:
1. Update DT bindings to indicate that INTx is valid only for SoCs other
   than J721E SoCs on the basis of the compatible.
2. Add support in the pci-j721e.c driver for INTx.
3. Finally, the current patch or patches for other SoCs to add INTx can
   be posted and merged.

The following series which was posted in 2021 corresponds to 1 and 2
above:
https://lore.kernel.org/r/20210811123846.31921-1-kishon@ti.com/

Please note that the above series was included in the downstream (TI)
Linux in the past. It was observed that despite the Errata not affecting
the AM64 SoC (contains a Cadence PCIe Controller and is programmed by the
same pci-j721e.c driver), legacy interrupts were missed and resulted in the
PCIe Endpoint device becoming non-functional. Resolving this issue
required retriggering the interrupt following which the device became
functional.

Therefore, it is encouraged that MSI/MSI-X are used instead. If INTx is a
necessity (unlike the current patch which only aims to prevent error logs
from showing up), then the aforementioned series can be used with the
disclaimer that it may still lead to interrupts being missed.

Regards,
Siddharth.

