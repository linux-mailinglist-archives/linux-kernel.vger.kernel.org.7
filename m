Return-Path: <linux-kernel+bounces-895228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554BEC4D498
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FE6189F860
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE93570AB;
	Tue, 11 Nov 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEWf0jRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC5354716;
	Tue, 11 Nov 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858473; cv=none; b=CrQUDNBaDqAvfj36SGXKUOBq6h1JzfcbqiAEV0eb+A1VT2E69N3c1VbMQBDul8eC/dpie5dO3n5Y05YZtuxK9EJcJ4/yeRNyhm8UCZv9b8O6yMLf60xEr5uDHUyytsfkQwrjYFncgmMm6HgDYXC+m4laC9ofCs4nhwIpFQ7je70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858473; c=relaxed/simple;
	bh=c9lRNJCk9FO4/69rGwSyG6RzsupdcHyYlff3JO8n/Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNbr7fM2SJb8ZHx1TLv9tVi5iWMSWwVXiee9cWLGd8sZR3Vks5BALLgpq633cLO/DA6HRXaSb8xITgeh7Y5SkOuKyzMmmMfp2kRq5LfB+8bgS322dyDkvWWhkrcwuL+3J2x8WMn4+mqLMgkbttxBuWqyvbZXfbQFYTaDKcKjYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEWf0jRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54369C4CEFB;
	Tue, 11 Nov 2025 10:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762858473;
	bh=c9lRNJCk9FO4/69rGwSyG6RzsupdcHyYlff3JO8n/Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEWf0jROjm2ur9crQXKmls6txil8YDeTuV8MCgLsiYInHji0efJci4Y7rOQaul+TE
	 2t1aPMsp1Ax32jpQ8WwX8m2ruNwPm4/oIkdczr88Wic+Ifn6PlaLCeB/U9s0/TFIVu
	 L5HpkVFZ4vZX0JqcIiqEZtr/+1p+FoyZXFzqK2egzOY6M2ReEXXESsfXP/U+fxNmga
	 cPk5Jjy3t1k9k/9cpTpjrnZAyJ9/iZSCY7OVIDraO6boFMAl/K+62AWejgViU1Xjx6
	 3WxzuwggFLkXZkkXoFj9O8Xz60ZdHZcgJWekBQ4uqcmU+BFeZ1M4jMULRKHVhJ6ePn
	 hBjeI4kMnZg3w==
Date: Tue, 11 Nov 2025 16:24:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: kernel test robot <lkp@intel.com>, s-vadapalli@ti.com
Cc: Chen Wang <unicorn_wang@outlook.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: drivers/pci/controller/cadence/pci-j721e.c:648:undefined
 reference to `cdns_pcie_host_disable'
Message-ID: <h4yvzfhpd7exv2o2oxed7ocobn5zpwmtvzoxffj4rqsiq2dqfr@sobzxhwa5c23>
References: <202511111705.MZ7ls8Hm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202511111705.MZ7ls8Hm-lkp@intel.com>

+ Siddharth

On Tue, Nov 11, 2025 at 05:28:54PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
> commit: 1c72774df028429836eec3394212f2921bb830fc PCI: sg2042: Add Sophgo SG2042 PCIe driver
> date:   8 weeks ago
> config: loongarch-randconfig-r113-20251110 (https://download.01.org/0day-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    loongarch64-linux-ld: drivers/pci/controller/cadence/pci-j721e.o: in function `j721e_pcie_remove':
> >> drivers/pci/controller/cadence/pci-j721e.c:648:(.text+0x83c): undefined reference to `cdns_pcie_host_disable'
> 

From .config:

CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=m
CONFIG_PCIE_CADENCE_EP=y
CONFIG_PCIE_CADENCE_PLAT=y
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
CONFIG_PCIE_CADENCE_PLAT_EP=y
CONFIG_PCIE_SG2042_HOST=m
CONFIG_PCI_J721E=y
# CONFIG_PCI_J721E_HOST is not set
CONFIG_PCI_J721E_EP=y

PCI_J721E selects PCIE_CADENCE_HOST only if PCI_J721E_HOST is selected,
otherwise, it will not select it. This will take care of the dependency between
PCI_J721E and PCIE_CADENCE_{HOST/EP}.

But if PCIE_CADENCE_HOST is selected as a module by other drivers like,
CONFIG_PCIE_SG2042_HOST=m, then if PCI_J721E is selected as a built-in using
CONFIG_PCI_J721E_EP=y, it results in this build error as the built-in driver
becomes dependent on a symbol from a loadable module.

I guess, we should force PCIE_CADENCE_{HOST/EP} to be 'bool' as it is getting
selected by multiple drivers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

