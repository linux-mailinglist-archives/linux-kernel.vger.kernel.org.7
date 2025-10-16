Return-Path: <linux-kernel+bounces-856455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8585DBE4330
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 334F14FDAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBE334DCEE;
	Thu, 16 Oct 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnTWn0Lp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177134AAFB;
	Thu, 16 Oct 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628047; cv=none; b=HbSZ4W6JRZ5S4qsVJgfN5NHshPwao9tn3i+qv2r7ot7NYz7tlpxjBjqOL0gki3ErYol/nTaur7iRxXn9aFPZ75YyFwMbPc+jk8b+Ubi83/cEE9sQ4RQ9QQJphcrJwK4Zqf043D3hOUFaSx7Il/9dBGmdn7oKVrLwvIUIkjjK3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628047; c=relaxed/simple;
	bh=YsYP4uh9MOE6nCku635QoIr2FRjU31t7RRgYVAqHqsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5Ewm6B6OuvijL7XSBmq6ymjD3kj9bjYSkq+KbSHN36ES+Uhg+GSBuCsR17xb8cML9klX9sUxfZEQvx5M8k/RofyxhmpmIAxQJrGwhYSBwmjdWMjibXRBvIyqhowMYVF2++1NcjEpxM7v/JhWRHE481N+4YyTAeynnuUGGJ9Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnTWn0Lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE17C4CEF1;
	Thu, 16 Oct 2025 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760628047;
	bh=YsYP4uh9MOE6nCku635QoIr2FRjU31t7RRgYVAqHqsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnTWn0LpOZKub3oDRSlSffhT/pPriwTSn99HYtbBnkJ6gDYi1mtmf3zo5uzs7WDq+
	 aXTRMw3dyfH4hBSoQ7g7r9YJaKuwAtVaFzW4s/h7HrZD/X9+ALaMwXBdmhsEMc/NN1
	 DaOL7WAmH6qgi52AYkjEy1vFVRBkl8AJeWDFKr7bxLvg6Mc2RnDjX+xlUjcn2fl5Ah
	 KWT8x6Fk7Y7mHIYGMFDBRqKwKwqPpDi0nLLyVzs394pTVC18IzvPWVG0aQka9A0xxX
	 tBBIeWx5oFvwekwdw/UKW/vjnaO2Waaa+Y4YsT+zVFJXOH9kaW1khLs+neN1buffTI
	 rpF5X1o2kj5vw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v9Pmb-000000006pF-06En;
	Thu, 16 Oct 2025 17:20:49 +0200
Date: Thu, 16 Oct 2025 17:20:49 +0200
From: Johan Hovold <johan@kernel.org>
To: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: Re: [tip:irq/drivers 11/18] drivers/irqchip/irq-imx-mu-msi.c:419:16:
 error: implicit declaration of function 'imx_mu_probe'; did you mean
 'imx_mu_write'?
Message-ID: <aPENUdGUywB88-LD@hovoldconsulting.com>
References: <202510162257.g1RUy0bT-lkp@intel.com>
 <aPEMRBTVR6rT4MzJ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPEMRBTVR6rT4MzJ@hovoldconsulting.com>

On Thu, Oct 16, 2025 at 05:16:21PM +0200, Johan Hovold wrote:
> On Thu, Oct 16, 2025 at 10:47:56PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
> > head:   45f8fdcfbf4e49075172cf1a3fd812b90160e903
> > commit: 4265aed28d7de2a643b8e441bc25344f421f2f78 [11/18] irqchip: Pass platform device to platform drivers

> >    drivers/irqchip/irq-imx-mu-msi.c: In function 'imx_mu_imx7ulp_probe':
> > >> drivers/irqchip/irq-imx-mu-msi.c:419:16: error: implicit declaration of function 'imx_mu_probe'; did you mean 'imx_mu_write'? [-Wimplicit-function-declaration]
> >      419 |         return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx7ulp);
> >          |                ^~~~~~~~~~~~
> >          |                imx_mu_write
> >    drivers/irqchip/irq-imx-mu-msi.c: At top level:
> > >> drivers/irqchip/irq-imx-mu-msi.c:299:12: warning: 'imx_mu_of_init' defined but not used [-Wunused-function]
> >      299 | static int imx_mu_of_init(struct platform_device *pdev, struct device_node *parent,
> >          |            ^~~~~~~~~~~~~~
> 
> Thomas, this looks like a bad edit on your part where you renamed
> imx_mu_probe() back to imx_mu_init() when you removed a line break from
> the function header.

Actually the line break is still there, but the function has its old
name in your tree for some reason.

Johan

