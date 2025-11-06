Return-Path: <linux-kernel+bounces-889435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C9FC3D8CB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4783C1886022
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DAF30AADC;
	Thu,  6 Nov 2025 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LNWyeaod"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965D30ACF0;
	Thu,  6 Nov 2025 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467061; cv=none; b=i0vm1nKojEcaVuylHBdts5ejX1LZZrPNT32DDRs9xZWe4HdjQZ91qyhMMMHFGJKbHDYoRvpnJj8BvNzbpXjcRxXqxOLXmtk5uLRAauXHkWGhDdK5AQ7J0zSXWvDlhYQHbmS4BU5va02fUDxf31RdLNBVgztZny52w0R2dM+0fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467061; c=relaxed/simple;
	bh=HLoD4g3lh4r2aFWPC1V6XVbRCNdGy200d6QwXjEHzEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+1uoO0Qxa1WffSRfAUhuHtYUhxOyRto9IWJnWsEsr9/g8JY9hEpwOy/QSuotHvyQDo7DQ+wNsBxh/zbiZ2SLSZAYw3tbUU+BWGPgsRKwk7MOw/GAgjG2ZMFnXgQCw3FcmIN0PcGaWom82iPRG6hwxmXRx4NTMtvAwE9trpsVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LNWyeaod; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0EE5EC0FA93;
	Thu,  6 Nov 2025 22:10:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BC48D606EE;
	Thu,  6 Nov 2025 22:10:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF70C1185174E;
	Thu,  6 Nov 2025 23:10:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762467051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=okGwbLaxnS8zbdut10ECdw0yQyNum6PGNoZZb6TW6os=;
	b=LNWyeaodd4SCncG0c7HUkCFjEY3ShkHP92Yed/PJEFu+IMwo3GZnS4/MbLLPDRI1xRLvFH
	u6J9aZXrhU+RYmafKfh4eJpUst3lAg+2t6xEwq2qbNf7++SODCIqndlvxbwizqnY7yVXgB
	w8P8Vin1tu/Gb2war5hSPjE1N5yhyEzpK3zpHznDlX0BGLMxN4FmIYX475KgMFY4C6mhcw
	gwz86O9fM2r1c3s2b9e4HKcoiQGO7DOo07mTsFXWf461JFWtSem9IowGIVaDJgyovBfh1S
	o4mF7zd0AcTd4Wxg9kPWryNUxAotUJctduOrj/KqzdDa2UV90i0X+d8jckqJhw==
Date: Thu, 6 Nov 2025 23:10:48 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: adrianhoyin.ng@altera.com
Cc: Frank.Li@nxp.com, wsa+renesas@sang-engineering.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] i3c: dw: Add support for Device NACK Retry count
Message-ID: <20251106221048367d654a@mail.local>
References: <cover.1762245890.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762245890.git.adrianhoyin.ng@altera.com>
X-Last-TLS-Session-Version: TLSv1.3

On 04/11/2025 16:51:07+0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> This series adds support for configuring the Device NACK Retry count
> in the Synopsys DesignWare I3C master controller and enables the
> corresponding property in the Altera Agilex5 device tree.
> 
> Some I3C slave devices may temporarily NACK transactions when they are
> busy or not ready to respond. To enhance bus reliability, the DesignWare
> I3C controller supports a programmable retry mechanism that automatically
> reissues NACKed transactions. This series introduces the
> snps,dev-nack-retry-cnt device tree property to configure this retry
> count. The value is written into the Device Address Table (DAT) entry for
> each I3C device, enabling fine-grained control of retry behavior.
> 

As Frank explained, this needs to be a per device sysfs file because
this is definitively policy and not HW related. This file should only be
visible when the bus supports retrying.

Don't forget to add documentation in ABI/testing/sysfs-bus-i3c

> This series also fixes an issue where existing DAT entries could be
> overwritten when the driver restores device addresses. Update
> dw_i3c_master_restore_addrs to preserve existing bits in each
> DAT entry when restoring addresses.
> 
> Adrian Ng Ho Yin (4):
>   dt-bindings: i3c: Add snps,dev-nack-retry-cnt property to Synopsys I3C
>     master
>   arm64: dts: intel: agilex5: Add snps,dev-nack-retry-cnt property for
>     I3C controllers
>   i3c: dw: Add support for Device NACK Retry count
>   i3c: dw: Preserve DAT entry bits when restoring addresses
> 
>  .../bindings/i3c/snps,dw-i3c-master.yaml      |  8 ++++
>  .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |  2 +
>  drivers/i3c/master/dw-i3c-master.c            | 40 ++++++++++++++++++-
>  drivers/i3c/master/dw-i3c-master.h            |  1 +
>  4 files changed, 49 insertions(+), 2 deletions(-)
> 
> -- 
> 2.49.GIT
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

