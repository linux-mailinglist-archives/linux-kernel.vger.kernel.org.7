Return-Path: <linux-kernel+bounces-895573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2C6C4E4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DA5188E763
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C835307ACF;
	Tue, 11 Nov 2025 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI9bp722"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D23128AA;
	Tue, 11 Nov 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870172; cv=none; b=Cmx3+v+mrrmkmw+lGwlHXo7P6CLusKEEwESL05rj3L3oFfDJ9UB//c/ZP7pKnt7VN18R5bmvHk1lUQmlKaQgf+j55WaUazrYz29S12DxGpoTiRFPI2FSQnkFcYmxYkdiAcic2t8aKWOPsibRMyp7BL3UTQOpqQLtDMO+glP6D7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870172; c=relaxed/simple;
	bh=9XZLn3hwcBgcwon0Do7gSmY8VNlXuhNqzv0X7kReqCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg2Sd55ZwzGoDjr50TnO4HZAdJYX86hkrPIH1+b4hfUwllkiFALBA1WNxTAIf4tbqmkPUPCrodLOvlrnCmxg2Qae93vvu310m+MjLdY+O8/1TOrfYTQBFDOvcmBmwiwhwklqJ81b80ESC3WUtlcmSRsNFTuwf7YqDiXWW+o2aMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI9bp722; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FB0C19425;
	Tue, 11 Nov 2025 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870172;
	bh=9XZLn3hwcBgcwon0Do7gSmY8VNlXuhNqzv0X7kReqCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aI9bp722FUSmUJr6eRfL2udVl2sgClyb0uGJH7X9OkkvEC63NbLuQrCp2bZIIxIgp
	 HHY1L+UcFDKGMIHcaEdJR9GBIlQ3nkKto24GfmVmbaGF9dta80rsZcDesI5TEr32/e
	 bI+JKTf5CPOzywaJuV5mtYGh1mMS4Ukq4JxAjrr+HGcUw2UNlL4fLfPbEysi1S7t5w
	 9TS3i5V8atu9+e9UYnV/mdFCIKnmQQoIWK7vqZxD6nlF2GqzrE1sQUZzmMAKf7TNJD
	 EAZ5dhobTzWb1i/4X7neVkJgbFyOz8CTAoC/SO416Qz113HMTc+Mai0exGaY09LynE
	 BnrrHmxnnq/5A==
Date: Tue, 11 Nov 2025 19:39:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: kernel test robot <lkp@intel.com>, 
	Chen Wang <unicorn_wang@outlook.com>, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci/controller/cadence/pci-j721e.c:648:undefined
 reference to `cdns_pcie_host_disable'
Message-ID: <znkojajaxfudm3xn43ed4my5fcwyszv4gxajnizonqu3pf5t6g@bph3av5mzmg7>
References: <202511111705.MZ7ls8Hm-lkp@intel.com>
 <h4yvzfhpd7exv2o2oxed7ocobn5zpwmtvzoxffj4rqsiq2dqfr@sobzxhwa5c23>
 <cc48c040dac2edc27b453bc482d62309cea25c06.camel@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc48c040dac2edc27b453bc482d62309cea25c06.camel@ti.com>

On Tue, Nov 11, 2025 at 05:09:25PM +0530, Siddharth Vadapalli wrote:
> On Tue, 2025-11-11 at 16:24 +0530, Manivannan Sadhasivam wrote:
> 
> Hello Mani,
> 
> > + Siddharth
> 
> Thank you for notifying me of this.
> 
> > 
> > On Tue, Nov 11, 2025 at 05:28:54PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
> > > commit: 1c72774df028429836eec3394212f2921bb830fc PCI: sg2042: Add Sophgo SG2042 PCIe driver
> > > date:   8 weeks ago
> > > config: loongarch-randconfig-r113-20251110 (https://download.01.org/0day-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/config)
> > > compiler: loongarch64-linux-gcc (GCC) 15.1.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    loongarch64-linux-ld: drivers/pci/controller/cadence/pci-j721e.o: in function `j721e_pcie_remove':
> > > > > drivers/pci/controller/cadence/pci-j721e.c:648:(.text+0x83c): undefined reference to `cdns_pcie_host_disable'
> > > 
> > 
> > From .config:
> > 
> > CONFIG_PCIE_CADENCE=y
> > CONFIG_PCIE_CADENCE_HOST=m
> > CONFIG_PCIE_CADENCE_EP=y
> > CONFIG_PCIE_CADENCE_PLAT=y
> > # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
> > CONFIG_PCIE_CADENCE_PLAT_EP=y
> > CONFIG_PCIE_SG2042_HOST=m
> > CONFIG_PCI_J721E=y
> > # CONFIG_PCI_J721E_HOST is not set
> > CONFIG_PCI_J721E_EP=y
> > 
> > PCI_J721E selects PCIE_CADENCE_HOST only if PCI_J721E_HOST is selected,
> > otherwise, it will not select it. This will take care of the dependency between
> > PCI_J721E and PCIE_CADENCE_{HOST/EP}.
> > 
> > But if PCIE_CADENCE_HOST is selected as a module by other drivers like,
> > CONFIG_PCIE_SG2042_HOST=m, then if PCI_J721E is selected as a built-in using
> > CONFIG_PCI_J721E_EP=y, it results in this build error as the built-in driver
> > becomes dependent on a symbol from a loadable module.
> 
> While I don't deny the build error associated with the above config, it is
> an invalid config in the sense that the Glue drivers for two different
> devices are being enabled. This seems to be a generic issue wherein
> multiple drivers tend to depend on a library/common driver. How is it
> handled in such cases?

AFAIK, the common library should be built-in to avoid issues like this.

> Is there a notion of reordering configs to ensure that such build errors
> are avoided?
> 
> If PCI_J721E_EP was selected as 'y' before 'PCI_SG2042_HOST' being selected
> as 'm', it would have resulted in 'PCIE_CADENCE_EP' being selected as 'y'
> and this won't cause a build error even with 'PCI_SG2042_HOST' selected as
> 'm'.
> 
> > 
> > I guess, we should force PCIE_CADENCE_{HOST/EP} to be 'bool' as it is getting
> > selected by multiple drivers.
> 
> This will defeat the purpose of the series that enabled loadable module
> support for the pci-j721e.c driver and the pcie-cadence-host/ep.c drivers.
> 

Your 'pci-j721e.c' can still be a loadable module, only the common library will
be built-in, which is not that bad.

> Is there a way to address the issue by updating Kconfig? Specifically, is
> there a way to re-order the 'select' scheme to fix the build error?
> 

Not that I'm aware of atm.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

