Return-Path: <linux-kernel+bounces-879254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52D5C22A64
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A63188C4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE433BBA1;
	Thu, 30 Oct 2025 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu7+0WuW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C882F49E3;
	Thu, 30 Oct 2025 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865683; cv=none; b=heObQLy9FogZM7B+18JzNtonz+2o8HJmA6+9nxhE5Ymdfz0RNCG/pXF+rWgMgwAqK6ThbzCKiUuet4KssBbOBgD6YZkbywpXwZ/YJPZj9f8yldF97EPkzZVY30KIMiF7e2jYwCV0um/v+zrm2I4m0vzXnWnz0TLXTomXcizf7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865683; c=relaxed/simple;
	bh=Hhw2jTxSrvIEy2c0QEBAcQT6LpKNYPq4ieFoWvYy+PM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gejPvCQiyCpzWvPWnkdCUHBlCj6FrNmgtyk0m0dokchKj+AX8BvABK0lOFBsq4r1wSlXmZkyjVHJXOo6fyzy5CX+lEpGFgAZ18mavH20XJ43c/AR3dhzu+5xClP9dlvHfCFFD2WiJiO3UuVBbZoY+kuLOgOvfmG7cxrMpMOnn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu7+0WuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89F8C4CEF1;
	Thu, 30 Oct 2025 23:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761865683;
	bh=Hhw2jTxSrvIEy2c0QEBAcQT6LpKNYPq4ieFoWvYy+PM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Cu7+0WuWK26SqRg2QXxQec4K85YUonv/QEL4nOlHAMH2Rfx2AEEyIsWIokySSoknL
	 IMegYPEIo3S/ZfBia6pXO6gQ0fo0lEVN+wsWYekUE/TJ1nITUf/JTkxfSU6aZOp0em
	 05+Xq8qrQONacUARBVl6CcglHO6YChgDoYk91nTNaFdax8IpzHs4uD1sN3r3LJBumD
	 DH8lHrJdDDmsEoqKJ9zE64StIYEQIZnjARLqYSPu9+JCyKxTvFbhieE4vh2B3XgnQs
	 ss08RhwhVBzaegeESDm8JN8Rbt0wv4OUSp7dl26Ax7EZKOSXmNJpMxxmDsDDgqQl8h
	 IsuyOVHmtM0Mg==
Date: Thu, 30 Oct 2025 18:08:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, dlan@gentoo.org,
	aurelien@aurel32.net, johannes@erdfelt.com, p.zabel@pengutronix.de,
	christian.bruel@foss.st.com, thippeswamy.havalige@amd.com,
	krishna.chundru@oss.qualcomm.com, mayank.rana@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, shradha.t@samsung.com,
	inochiama@gmail.com, guodong@riscstar.com,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: spacemit: introduce SpacemiT PCIe host driver
Message-ID: <20251030230801.GA1660222@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030220259.1063792-6-elder@riscstar.com>

In subject, capitalize "introduce" to match history.  Or you could
just use "Add ...", which has the advantage of being shorter.

On Thu, Oct 30, 2025 at 05:02:56PM -0500, Alex Elder wrote:
> Introduce a driver for the PCIe host controller found in the SpacemiT
> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
> The driver supports three PCIe ports that operate at PCIe gen2 transfer
> rates (5 GT/sec).  The first port uses a combo PHY, which may be
> configured for use for USB 3 instead.
> ...

I guess this doesn't support INTx interrupts at all?

> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -509,6 +509,17 @@ config PCI_KEYSTONE_EP
>  	  on DesignWare hardware and therefore the driver re-uses the
>  	  DesignWare core functions to implement the driver.
>  
> +config PCIE_SPACEMIT_K1
> +	tristate "SpacemiT K1 PCIe controller (host mode)"

Move this to keep the menu items alphabetized by vendor.

> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	depends on PCI && OF && HAS_IOMEM

I don't think you need PCI or OF.

> +	select PCIE_DW_HOST
> +	select PCI_PWRCTRL_SLOT
> +	default ARCH_SPACEMIT
> +	help
> +	  Enables support for the PCIe controller in the K1 SoC operating
> +	  in host mode.

Most help text includes both the vendor and the product line names.

