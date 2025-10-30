Return-Path: <linux-kernel+bounces-878544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE20C20F40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 674FD4EB642
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B77363B84;
	Thu, 30 Oct 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ovu6xwBm"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CBE24337B;
	Thu, 30 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838429; cv=none; b=KAHGug5LGqflQBWEdbYA0kApY8MkPUuHP4fWOww6b11x8Kp5qTBOD47UY0HRy6w08SPlQwJYzE19u1i7otlXjn4QNlcOwVFOkZf7u2XPAR4OXfZ5eo3CoQ3pEWPINHaWxqDzbR4ivezRnEzTF0uc11tFX42lS8PIwagMVoxlfYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838429; c=relaxed/simple;
	bh=ZzSPTat0BVGngdsnYNxP8Ek97A8svu5diunoCTC10/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5DPkLVfJ+8IFReXsfBQ5rhciNK9TWBPZG6NjvyS9RJm9cMUTdkG7AZHOwtn7Lftax+a1tr0/aTxkDXLTUI8XKUglDRSIlvIj1Dig4TWHKUBqlBr+bTdQjpZ/Xv/WXe053jQ9yeZ/wAVMUYsNq72fHMieE+i1oOu4epLJz3UIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ovu6xwBm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3CEDXVoec8wgc5r2G05gXNhADvg0k7pAjCJbkzmWMlA=; b=ovu6xwBmi6bbWyq6A8FW+QrVkd
	Eb+1PnSyeh713Skmfl6rcJR1qspA/xanxl31WsekKebS1S8V8v16pYytvmELyn6IXIma8cARUviHU
	xAa1j73OqMptSya4dNwgvfgzLPS26sqAJCQhWpNzQq3AbdWudOvwwZinVKTylZkWaB7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEUei-00CWVh-V7; Thu, 30 Oct 2025 16:33:40 +0100
Date: Thu, 30 Oct 2025 16:33:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rabeeh Khoury <rabeeh@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10,
 pcie_x11 & pcie_x4
Message-ID: <05d450d8-8df9-490f-ac53-3f45544f1c29@lunn.ch>
References: <20251030-cn913x-pci-clk-v1-0-e034d5903df1@solid-run.com>
 <20251030-cn913x-pci-clk-v1-2-e034d5903df1@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-cn913x-pci-clk-v1-2-e034d5903df1@solid-run.com>

On Thu, Oct 30, 2025 at 04:16:26PM +0100, Josua Mayer wrote:
> CP110 based platforms rely on the bootloader for pci port
> initialization.
> TF-A actively prevents non-uboot re-configuration of pci lanes, and many
> boards do not have software control over the pci card reset.
> 
> If a pci port had link at boot-time and the clock is stopped at a later
> point, the link fails and can not be recovered.
> 
> PCI controller driver probe - and by extension ownership of a driver for
> the pci clocks - may be delayed especially on large modular kernels,
> causing the clock core to start disabling unused clocks.
> 
> Add the CLK_IGNORE_UNUSED flag to the three pci port's clocks to ensure
> they are not stopped before the pci controller driver has taken
> ownership and tested for an existing link.
> 
> This fixes failed pci link detection when controller driver probes late,
> e.g. with arm64 defconfig and CONFIG_PHY_MVEBU_CP110_COMPHY=m.

Seems like a reasonable compromise, given that TF-A could be classed
as broken. This must also prevent suspend/resume powering off PCI
devices, and then reconnecting them on resume.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

