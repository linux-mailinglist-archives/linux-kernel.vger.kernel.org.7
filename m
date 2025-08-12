Return-Path: <linux-kernel+bounces-764613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E42B22526
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B231AA6ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D582D3725;
	Tue, 12 Aug 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="R6cMjhg6"
Received: from mail-m15599.qiye.163.com (mail-m15599.qiye.163.com [101.71.155.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971D37160;
	Tue, 12 Aug 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996507; cv=none; b=UuHM278aHPkCwx1A2M+UpDfMjLNwcjZAvsolRMpSUxWLjQP27OojSvZYwrfZQOJ9jxV8yRnmG1glmNXnMiu0OFbXapkb3rgNOlGoA0Wh85P7SK+06r7fCeJy6W+7XvAHWkjuULGX8BQMaRj0mVdNJF7T8bHkNXiTAJ44Po0312c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996507; c=relaxed/simple;
	bh=p3IYKxaU+/meRUQ4f+b0xpMo6ZKjaxL1WRXC90FwBbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHV2VOVmjUpX+rN0AXXOSMDYYO3uvepxmV39iDyNVCJh6Fq4o/az0FjmpRFQjkgaXY82GxPCBgGDu1Wc5892DwfqPlnJdUbDu8nk+/T9ayQuo2I6Pc4KYKCpol/9xsia9BZt+HGFX+aRv/j9ggE0g6nmAlJyFexIWlY0SZ86jkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=R6cMjhg6; arc=none smtp.client-ip=101.71.155.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f1f76ade;
	Tue, 12 Aug 2025 19:01:35 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org,
	robin.murphy@arm.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v2 6/8] arm64: dts: bst: add support for Black Sesame Technologies C1200 CDCU1.0 board and defconfig
Date: Tue, 12 Aug 2025 19:01:34 +0800
Message-ID: <20250812110134.2058289-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702141957.GA1416711-robh@kernel.org>
References: <20250702141957.GA1416711-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a989df153ca09cckunm8cfa594f82ad04
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQh5KVh5IQkhLTEtIGEtPTFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1
	VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=R6cMjhg6DJxDLKlZvwR/6L7+tUqklWmyVmFCmNgWI28uX9GgtpTys5ESjcgv4ZkqWLM1MfZjSDa9AZOV+pH+f0j2RUVnPuS5mtRBSwb92GEkhnPOWnQR+r9d4ItrVx4Y1KV0NpnvXQzF8PrFErLUxXc/lJDYRvKHvuOYHIcig0A=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=1RHIAhihoE0dOLBMOC8doj7/5NPFu6/VcX0XdVcieyY=;
	h=date:mime-version:subject:message-id:from;

On Wed, Jul 02, 2025 at 01:15:13PM +0100, Robin Murphy wrote:
> On 2025-07-02 10:44 am, Albert Yang wrote:
> > +   timer {
> > +           compatible = "arm,armv8-timer";
> > +           interrupt-parent = <&gic>;
> > +           always-on;
> > +           interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +                        <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +                        <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +                        <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>
> Your PPIs target 8 of the 4 CPUS? Either way you don't have GICv2, please
> use the GICv3 binding.

 Thank you for pointing out the issue. The mask has been removed according to the GIC v3 
 format.

>
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
> > +                   dma-coherent;
>
> Given the funky DMA setup, I can't help be mildly suspicious of this - is
> the device genuinely I/O coherent and capable of snooping the CPU caches, or
> are you only getting away with it because dma_init_coherent_memory() happens
> to remap as non-cacheable regardless?

We allocated a portion of SRAM to serve as a bounce buffer. This buffer is incorporated 
into the system's CMA (Contiguous Memory Allocator) framework through a shared DMA mechanism
and requires memory coherency.

Best Regards,
Albert

