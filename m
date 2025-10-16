Return-Path: <linux-kernel+bounces-856439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9404BE4290
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8033B1894643
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E18B3314CB;
	Thu, 16 Oct 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhxVMjnd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE561E1C22;
	Thu, 16 Oct 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627779; cv=none; b=reJi2NQ2YGJvMLMEWb/9h53Trw4Yg4P0E6GpWNthKhraO/beAVZEZ25Zi1iuEUaumYrrAvY3gTDdhK8FeNM2W3bgfeNmnJTDemWVh2rLHjtkcWyxC4hizbcU12vTT+cJiPMWyH1TP3kELHWhh9Dm5t7kCPVam++BK+jMqt4vBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627779; c=relaxed/simple;
	bh=c6jBR8EJqt9K3r1V0mUxxAx+8Q24oK/BcmBCgypzn3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnQLWmENe+StXE+KdGbg3PhkmfFsJg/D5uEq9WdgsTgseXT5kcvnACzQRCtg18myEMV1MnAxG1mP9dYeoaTbb5nrIo0JAqBOCcyfOfD+t2Q+a6nJTxpABcEsFmR9BDaGVFQsil87x1FgAN+SdDcyCupnO9vwvV55yH3c23It7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhxVMjnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02839C4CEF1;
	Thu, 16 Oct 2025 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760627779;
	bh=c6jBR8EJqt9K3r1V0mUxxAx+8Q24oK/BcmBCgypzn3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhxVMjndmyBeuDMGBXVK/HalxbOtc0jP3Iio5LkWu2XztV5ZNQ2yLbS4xbmEPDnUu
	 MAQSt2Vfyw37q5/V+3ouspJDX9XlL39rziB+wSbAEORMzeiv0RjgbXSBoHYNU1AqYV
	 5lWts9o6gVY7DzDiGWgSdgip4IMb1s9BlPGTgzjujVWzbL/asMaHoiA4LK1DdsQTzx
	 NZj5uISnSA04cIP1o8s10AOKrmxveuRTI0l6ZnTn0kUmFIqDEuuQPms0xpQ1HhcU6e
	 n9TddO8ixXzmKmAlZD3EUOxD09PuZspg2omExdX2b5N7IcS7HvDRSI2R+pV1dlCgwU
	 4fLBjIBhmDeaw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v9PiG-000000006kJ-2Lct;
	Thu, 16 Oct 2025 17:16:21 +0200
Date: Thu, 16 Oct 2025 17:16:20 +0200
From: Johan Hovold <johan@kernel.org>
To: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: Re: [tip:irq/drivers 11/18] drivers/irqchip/irq-imx-mu-msi.c:419:16:
 error: implicit declaration of function 'imx_mu_probe'; did you mean
 'imx_mu_write'?
Message-ID: <aPEMRBTVR6rT4MzJ@hovoldconsulting.com>
References: <202510162257.g1RUy0bT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510162257.g1RUy0bT-lkp@intel.com>

On Thu, Oct 16, 2025 at 10:47:56PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
> head:   45f8fdcfbf4e49075172cf1a3fd812b90160e903
> commit: 4265aed28d7de2a643b8e441bc25344f421f2f78 [11/18] irqchip: Pass platform device to platform drivers
> config: arm-randconfig-004-20251016 (https://download.01.org/0day-ci/archive/20251016/202510162257.g1RUy0bT-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 14.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510162257.g1RUy0bT-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510162257.g1RUy0bT-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/irqchip/irq-imx-mu-msi.c: In function 'imx_mu_imx7ulp_probe':
> >> drivers/irqchip/irq-imx-mu-msi.c:419:16: error: implicit declaration of function 'imx_mu_probe'; did you mean 'imx_mu_write'? [-Wimplicit-function-declaration]
>      419 |         return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx7ulp);
>          |                ^~~~~~~~~~~~
>          |                imx_mu_write
>    drivers/irqchip/irq-imx-mu-msi.c: At top level:
> >> drivers/irqchip/irq-imx-mu-msi.c:299:12: warning: 'imx_mu_of_init' defined but not used [-Wunused-function]
>      299 | static int imx_mu_of_init(struct platform_device *pdev, struct device_node *parent,
>          |            ^~~~~~~~~~~~~~

Thomas, this looks like a bad edit on your part where you renamed
imx_mu_probe() back to imx_mu_init() when you removed a line break from
the function header.

Johan

