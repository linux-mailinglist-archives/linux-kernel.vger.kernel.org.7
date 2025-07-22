Return-Path: <linux-kernel+bounces-740104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A305B0CFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B0E3A907B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4D28B4F8;
	Tue, 22 Jul 2025 03:04:00 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187A28B7CC;
	Tue, 22 Jul 2025 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153439; cv=none; b=cYeiLsEC2GZlOlyzTFxvYlLl4V4nITXl+IDwglNSuwJZlYtfYWrST0E81RE5TCFyPktGOFEFzXJXDuuKvOCfjK4zVDCiTjEw44qgTqf0hFZGCNnk3TaYDQbwPEA+ABaGpJiPdlUO5DG5b9EHC6ecfq23XS4PnPrD/5PUsa1NyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153439; c=relaxed/simple;
	bh=/ZT7Fmmg5Mcs5JJJoFuAWdkaveP2C8n5+Dd1XOe2PmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPE19h7LwSN8NyjHU/5JfKIKt3D6OfcAjoIpI6LgQcs5Gc3K+8U5ZVzQJIjqhPgeT8D4LjArC9KUoLfdgQsa4PT/kVGgn7d1aKwk9D4rlJ7J/iaiSn4HRM26dOxPKYr5UdoXzYTwry3TgWsM+6KF9J0tlE5HiPxR52NM7gMwq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1753153367t556783c9
X-QQ-Originating-IP: aCLWc0Kp2cNwcfNNNDd42scjXvg1W6631ZIaocLO58U=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 11:02:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11057467750546591436
Date: Tue, 22 Jul 2025 11:02:45 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <D6DDF24A13236761+20250722030245.GA96891@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <32fc367c-46a4-4c76-b8a8-494bf79a6409@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32fc367c-46a4-4c76-b8a8-494bf79a6409@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MP9Cvol/R4C0Xz+FjoSeK4HMqzrRb160Pry1rmsIx5EI/NI8a/KBza1N
	T7MZKBzn4pL3ApxRmY7DnDqYPj93+E63Ez1L/Qq7AXrRAllGyb1ZU3RqJH0PGAKO53kel73
	7W82e19jmqokudRS7lfKZVsxZctUAynAJU5ARaqtCQuVngZirCB05AcKxKBaTs4a2pQPfuo
	xiAIK5xvo/K/lYYx7EPh2ruhFbGZb8+qkw1oVH+oEIv5W+gp9iJcOVd2fgZnJvXM9VQxmk0
	BqI3Cg2cL56ROl8B1NRQHblv9yGkOfyryEYsuUvm7qxlqwxjLoKDdVP7Ct8c8lVReQdrglg
	G4HV255d+mhVfS3OYTHbYVw/9HFlsQf/Nsl4s9G0N/gkRdr6VEi5PMhxHPLO27gWeDcI/3L
	qVsMl8VKVv4LE02NxvqM5g4ZNwtTtQI1NdMVTdQHUJXElqJ7s7MO2f026b+K4w7g+KDEZtu
	rln11wDF+cz9u6liqhi8iq4cMDugqQkZKw8Fk6OISCpcZV+ACI3J86ztQqfzh0oWghCvEGV
	Qg/UsjAzCOZ54Ttd2k0XAWREV40MGaMPttgDjlD0eLGh2wI7MA57JIBCNAgxtT3kQZhBBzz
	fS9rypaWuqviqlQZzclILP5Mr7xvyX7FC2E6iFiu2QBhZk/3nFqgsyl/tPt0ene9NKqOlcg
	CpfZo7zp2q4VSVqiDPDNhDpFoVbv/dfr6PtaEV0TUy0ebS7jimdBrLNvSEfKPiGcD0acefV
	m3JYNSjKN8wzspFAkvsllZUZfi80F6rCkG6+m09t8zQ3Z6eWmh+de6FGQbgcrho/ei4teVW
	KrSEap+AfpUt2qTPpAHz2IXJzEjW0TOuSGPERbwCHxa66eUrVTAuab37/nTlnqBFSgPDaQY
	RsQf0okZgQYLxflhRg4STnED2VL+MJo+WUrT1bgVaBwW3mq/qXOmaAjX+UNiUDOcEGmO5i7
	ebp7ZDrnumkVrD6z1tqQOS45iokyaKdSJ0oHbAYWYuhEtwpn/hRaMikZQ
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 02:30:40PM +0100, Vadim Fedorenko wrote:
> On 21/07/2025 12:32, Dong Yibo wrote:
> > Add build options and doc for mucse.
> > Initialize pci device access for MUCSE devices.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >   .../device_drivers/ethernet/index.rst         |   1 +
> >   .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 ++
> >   MAINTAINERS                                   |   8 +
> >   drivers/net/ethernet/Kconfig                  |   1 +
> >   drivers/net/ethernet/Makefile                 |   1 +
> >   drivers/net/ethernet/mucse/Kconfig            |  34 +++
> >   drivers/net/ethernet/mucse/Makefile           |   7 +
> >   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   9 +
> >   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  33 +++
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 226 ++++++++++++++++++
> >   10 files changed, 341 insertions(+)
> >   create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> >   create mode 100644 drivers/net/ethernet/mucse/Kconfig
> >   create mode 100644 drivers/net/ethernet/mucse/Makefile
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > 
> > diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
> > index 40ac552641a3..0e03c5c10d30 100644
> > --- a/Documentation/networking/device_drivers/ethernet/index.rst
> > +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> > @@ -61,6 +61,7 @@ Contents:
> >      wangxun/txgbevf
> >      wangxun/ngbe
> >      wangxun/ngbevf
> > +   mucse/rnpgbe
> >   .. only::  subproject and html
> > diff --git a/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst b/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> > new file mode 100644
> > index 000000000000..7562fb6b8f61
> > --- /dev/null
> > +++ b/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> > @@ -0,0 +1,21 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===========================================================
> > +Linux Base Driver for MUCSE(R) Gigabit PCI Express Adapters
> > +===========================================================
> > +
> > +MUCSE Gigabit Linux driver.
> > +Copyright (c) 2020 - 2025 MUCSE Co.,Ltd.
> > +
> > +Identifying Your Adapter
> > +========================
> > +The driver is compatible with devices based on the following:
> > +
> > + * MUCSE(R) Ethernet Controller N500 series
> > + * MUCSE(R) Ethernet Controller N210 series
> > +
> > +Support
> > +=======
> > + If you have problems with the software or hardware, please contact our
> > + customer support team via email at techsupport@mucse.com or check our
> > + website at https://www.mucse.com/en/
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1bc1698bc5ae..da0d12e77ddc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17033,6 +17033,14 @@ T:	git git://linuxtv.org/media.git
> >   F:	Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.yaml
> >   F:	drivers/media/i2c/mt9v111.c
> > +MUCSE ETHERNET DRIVER
> > +M:	Yibo Dong <dong100@mucse.com>
> > +L:	netdev@vger.kernel.org
> > +S:	Maintained
> > +W:	https://www.mucse.com/en/
> > +F:	Documentation/networking/device_drivers/ethernet/mucse/*
> > +F:	drivers/net/ethernet/mucse/*
> > +
> >   MULTIFUNCTION DEVICES (MFD)
> >   M:	Lee Jones <lee@kernel.org>
> >   S:	Maintained
> > diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> > index f86d4557d8d7..77c55fa11942 100644
> > --- a/drivers/net/ethernet/Kconfig
> > +++ b/drivers/net/ethernet/Kconfig
> > @@ -202,5 +202,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
> >   source "drivers/net/ethernet/wiznet/Kconfig"
> >   source "drivers/net/ethernet/xilinx/Kconfig"
> >   source "drivers/net/ethernet/xircom/Kconfig"
> > +source "drivers/net/ethernet/mucse/Kconfig"
> >   endif # ETHERNET
> > diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> > index 67182339469a..696825bd1211 100644
> > --- a/drivers/net/ethernet/Makefile
> > +++ b/drivers/net/ethernet/Makefile
> > @@ -107,3 +107,4 @@ obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
> >   obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
> >   obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
> >   obj-$(CONFIG_OA_TC6) += oa_tc6.o
> > +obj-$(CONFIG_NET_VENDOR_MUCSE) += mucse/
> > diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
> > new file mode 100644
> > index 000000000000..be0fdf268484
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/Kconfig
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Mucse network device configuration
> > +#
> > +
> > +config NET_VENDOR_MUCSE
> > +	bool "Mucse devices"
> > +	default y
> > +	help
> > +	  If you have a network (Ethernet) card from Mucse(R), say Y.
> > +
> > +	  Note that the answer to this question doesn't directly affect the
> > +	  kernel: saying N will just cause the configurator to skip all
> > +	  the questions about Mucse(R) cards. If you say Y, you will
> > +	  be asked for your specific card in the following questions.
> > +
> > +if NET_VENDOR_MUCSE
> > +
> > +config MGBE
> > +	tristate "Mucse(R) 1GbE PCI Express adapters support"
> > +	depends on PCI
> > +	select PAGE_POOL
> > +	help
> > +	  This driver supports Mucse(R) 1GbE PCI Express family of
> > +	  adapters.
> > +
> > +	  More specific information on configuring the driver is in
> > +	  <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
> > +
> > +	  To compile this driver as a module, choose M here. The module
> > +	  will be called rnpgbe.
> > +
> > +endif # NET_VENDOR_MUCSE
> > +
> > diff --git a/drivers/net/ethernet/mucse/Makefile b/drivers/net/ethernet/mucse/Makefile
> > new file mode 100644
> > index 000000000000..f0bd79882488
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the Mucse(R) network device drivers.
> > +#
> > +
> > +obj-$(CONFIG_MGBE) += rnpgbe/
> > +
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > new file mode 100644
> > index 000000000000..0942e27f5913
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright(c) 2020 - 2025 MUCSE Corporation.
> > +#
> > +# Makefile for the MUCSE(R) 1GbE PCI Express ethernet driver
> > +#
> > +
> > +obj-$(CONFIG_MGBE) += rnpgbe.o
> > +
> > +rnpgbe-objs := rnpgbe_main.o
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > new file mode 100644
> > index 000000000000..224e395d6be3
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#ifndef _RNPGBE_H
> > +#define _RNPGBE_H
> > +
> > +enum rnpgbe_boards {
> > +	board_n500,
> > +	board_n210,
> > +	board_n210L,
> > +};
> > +
> > +struct mucse {
> > +	struct net_device *netdev;
> > +	struct pci_dev *pdev;
> > +	/* board number */
> > +	u16 bd_number;
> > +
> > +	char name[60];
> > +};
> > +
> > +/* Device IDs */
> > +#ifndef PCI_VENDOR_ID_MUCSE
> > +#define PCI_VENDOR_ID_MUCSE 0x8848
> > +#endif /* PCI_VENDOR_ID_MUCSE */
> 
> this should go to include/linux/pci_ids.h without any ifdefs
> 

Got it, I will update this.

> > +
> > +#define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
> > +#define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> > +#define PCI_DEVICE_ID_N500_VF 0x8309
> > +#define PCI_DEVICE_ID_N210 0x8208
> > +#define PCI_DEVICE_ID_N210L 0x820a
> > +
> > +#endif /* _RNPGBE_H */
> 
> [...]
> 

