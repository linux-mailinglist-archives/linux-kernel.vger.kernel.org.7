Return-Path: <linux-kernel+bounces-870921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16386C0BFC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857CE3B81B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B102F4A;
	Mon, 27 Oct 2025 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lE629Zb2"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC462D5A01
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547511; cv=none; b=mulAzjbu0gLQHIayjzQBQzmj6NXNoDt/NeVE+1O3RkQEF4pUVV2wqPYq1mxylU990Mm5e6K/G7bjB8+Ogr07DAgxz693IfB9pdgWI/1mRzgjUSruvBeTk+cQDA9CBW0QMlENIbyXYp9AyNSPVDaRB3xAAqqYzL4XXNh4LRZ3/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547511; c=relaxed/simple;
	bh=qvxtg5gk0Lr/ga/OeGDgHXNL3rEoGup+muqlFn3EJ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQngmQ25yaDuQDuFUXSwOD8M3efzWxOYupr6vK+QOT3KycwotybLme+qoNqtbf5BVoGiOIxSYBRpUYNr0QjHcQeK0+J8vzxuCmcOKVGbxY6k9F5xVNyMHk0Ol7wEXgYFyVzA6We5zXiCJoKiI9vp0Pn2CXwfoKNV0Eo63kzlGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lE629Zb2; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=uTONtzzDCzYkWQwYqhc3PDl6+i8mJOuSLhFAjzgzdlI=;
	b=lE629Zb2rdpzW8UCnswCe24aAxqKE7PzYPKYv8FSfJfe39kvC3PYFzD2iF3UI2
	dZD/Ezqj9quZ3mcfCLp0R8BIsAAdt9rE7aRL5lo5DaeqKw8AtHxDCXjvAdVvQrUC
	OLCrvAelb2cUlAF+/+ZUSwHShxmubUDQ4ZyD7LlIm5CZ8=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD331XQFP9oZPu+AA--.28142S3;
	Mon, 27 Oct 2025 14:44:34 +0800 (CST)
Date: Mon, 27 Oct 2025 14:44:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] firmware: imx: scu: Misc update
Message-ID: <aP8U0PNGA2d0kSZE@dragon>
References: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
X-CM-TRANSID:Ms8vCgD331XQFP9oZPu+AA--.28142S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUemhFUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNBJTuGj-FNJBTgAA3T

On Fri, Oct 17, 2025 at 09:56:23AM +0800, Peng Fan wrote:
> Peng Fan (8):
>       firmware: imx: scu-irq: fix OF node leak in
>       firmware: imx: scu-irq: Free mailbox client on failure at imx_scu_enable_general_irq_channel()
>       firmware: imx: scu-irq: Init workqueue before request mbox channel
>       firmware: imx: scu-irq: Set mu_resource_id before get handle
>       firmware: imx: scu-irq: Remove unused export of imx_scu_enable_general_irq_channel
>       firmware: imx: scu: Update error code
>       firmware: imx: scu: Suppress bind attrs
>       firmware: imx: scu: Use devm_mutex_init

Applied all, thanks!


