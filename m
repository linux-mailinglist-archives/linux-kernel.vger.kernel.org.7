Return-Path: <linux-kernel+bounces-885079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111E2C31F02
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFC03A310F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23B627056D;
	Tue,  4 Nov 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lADO15w5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472ED199385
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271315; cv=none; b=iEYi0lFY50PTsKpMUXu0OY0lJL0TuVtQT77Ker4R1OBM2rGOKAjSU3FKPv/ppgPgwW/eu8j9/pJulsLFLVitsWIy9X0UDjN3yzRiCjbGPapSqNAKhvvPRGpBIDt6ZXCcrFprTcOANeAl3sPCl7+8KlURfV/ol8frosLMNdg+iHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271315; c=relaxed/simple;
	bh=JYoiADdkizF6moYjhP06xDcGgpcsjnWIwhGAON9FDDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M75S3QmfIKd2f/i+6t2LZSbenCEN3Zedw6UVZ7V7ctuDZvNZcxBfchztlAFektkb0p7/niIrhOPsjRCp0RitUuDVqCT2YK5TSy9B39Q7+1WGoPYJodaEmxsVyUIN8YFKomms8wZWlXo8wz77tgTqFScm9zagoyanaD7wdxOLBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lADO15w5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762271313; x=1793807313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JYoiADdkizF6moYjhP06xDcGgpcsjnWIwhGAON9FDDI=;
  b=lADO15w5ratFKfEIMhRlCND5MvyEW6I0yhqkX4QuQ6s+X3QMqkr4H9wF
   40Q/46GpJFtzq36D23keMLPmwNc/ceO6zxhqIQknAO50ftZ1C7GH2EbV7
   UZJRCh4m+zKUNNSm30+a0J4qn2G+PSj5VZntqCBcEw2mXHELXqOLfOWxu
   crdILzKWtXfjlY3cWZnA33EN3tB8JaI/3o8pREsu2eWrWmEcMVJSTb0CZ
   d0pUKYY8dG9h/1Jt7IoYLMEGNXKe4ViWvAHhGG2JlY54uu8Aij8xcGHcc
   C3qSzPWa1LaEgDxX0cvYhkdxVwmlA+9MRTQV5FsuGweYTJQW7LsoZl8k9
   g==;
X-CSE-ConnectionGUID: rCcfkEptS2iV3KJnM2ElrA==
X-CSE-MsgGUID: CiNlf4OnQAWjfyi9YyThTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="74974164"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="74974164"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 07:48:32 -0800
X-CSE-ConnectionGUID: U4w8Km4bR8SDP+b8YUM3NQ==
X-CSE-MsgGUID: ojkSh4VeQhuZyVMnU7AVpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="217841985"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 07:48:31 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGJGn-00000005VD3-0F8J;
	Tue, 04 Nov 2025 17:48:29 +0200
Date: Tue, 4 Nov 2025 17:48:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQogTFANK1fMtloW@smile.fi.intel.com>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 03:32:59PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2025 at 05:20:59PM +0200, Andy Shevchenko wrote:
> 
> > Something bad happened to the regulator branch [1].
> > First of all, the merge message contains unneeded details (at least the
> > author's email signature). Second, the few lines series becomes 3kLoCs
> > merge commit. I think the base was wrong and `b4` (if you use that one)
> > took too much to merge.
> 
> I forgot to trim the cover letter but otherwise I really can't see any
> issues and you're not in the slightest bit specific about what you think
> is a problem.  The diffstat for the tree is:
> 
>  13 files changed, 1149 insertions(+), 780 deletions(-)
> 
> which doesn't doesn't correspond to "thousands" of lines.  I really
> can't tell what on earth you are talking about here.

I look at it via GitWeb [1] and that's what I see:

Age	Commit message (Expand)	Author	Files	Lines
2 hours	regulator: pf9453: optimize PMIC PF9453 driverHEADfor-nextfor-6.19	Mark Brown	253	-872/+2020
26 hours	regulator: pf9453: remove unused I2C_LT register	Joy Zou	1	-7/+0
26 hours	regulator: pf9453: remove low power mode	Joy Zou	1	-12/+0
26 hours	regulator: pf9453: change the device ID register address	Joy Zou	1	-2/+1
27 hours	regulator: Small cleanup in of_get_regulation_constraints()	Dan Carpenter	1	-3/+3
44 hours	Linux 6.18-rc4for-linusfor-6.18	Linus Torvalds	1	-1/+1
...

Which suggests the series changes only few lines, but if you click to the last
merge commit, you will see the heck out of whole tree bound to it. This is
usually the case when `b4 shazam` guesses the base in a way one doesn't expect
(it may merge your local branch if it founds match in the series with what you
 have).

So, in the merge commit the picture is

Diffstat
-rw-r--r--	.mailmap	1	
-rw-r--r--	CREDITS	4	
-rw-r--r--	Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml	4	
-rw-r--r--	Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml	4	
-rw-r--r--	Documentation/netlink/specs/dpll.yaml	2	
-rw-r--r--	Documentation/networking/netconsole.rst	3	
-rw-r--r--	MAINTAINERS	16	
-rw-r--r--	Makefile	2	
-rw-r--r--	arch/arm64/net/bpf_jit_comp.c	5	
-rw-r--r--	arch/s390/Kconfig	1	
-rw-r--r--	arch/s390/configs/debug_defconfig	14	
-rw-r--r--	arch/s390/configs/defconfig	14	
-rw-r--r--	arch/s390/configs/zfcpdump_defconfig	1	
-rw-r--r--	arch/s390/crypto/phmac_s390.c	52	
-rw-r--r--	arch/s390/include/asm/pci.h	1	
-rw-r--r--	arch/s390/mm/dump_pagetables.c	21	
-rw-r--r--	arch/s390/pci/pci_event.c	4	
-rw-r--r--	arch/s390/pci/pci_irq.c	9	
-rw-r--r--	arch/x86/Makefile	2	
-rw-r--r--	arch/x86/events/intel/core.c	1	
-rw-r--r--	arch/x86/events/intel/ds.c	3	
-rw-r--r--	arch/x86/events/intel/uncore.c	1	
-rw-r--r--	arch/x86/include/asm/intel-family.h	6	
-rw-r--r--	arch/x86/include/asm/page_64.h	3	
-rw-r--r--	arch/x86/kernel/cpu/amd.c	12	
-rw-r--r--	arch/x86/kernel/cpu/microcode/amd.c	20	
-rw-r--r--	arch/x86/kernel/fpu/core.c	3	
-rw-r--r--	arch/x86/net/bpf_jit_comp.c	2	
-rw-r--r--	block/blk-crypto.c	2	
-rw-r--r--	drivers/acpi/acpi_mrrm.c	3	
-rw-r--r--	drivers/acpi/acpi_video.c	4	
-rw-r--r--	drivers/acpi/button.c	4	
-rw-r--r--	drivers/acpi/fan.h	7	
-rw-r--r--	drivers/acpi/fan_attr.c	2	
-rw-r--r--	drivers/acpi/fan_core.c	36	
-rw-r--r--	drivers/acpi/fan_hwmon.c	11	
-rw-r--r--	drivers/acpi/spcr.c	2	
-rw-r--r--	drivers/base/regmap/regmap-slimbus.c	6	
-rw-r--r--	drivers/bcma/main.c	6	
-rw-r--r--	drivers/block/null_blk/main.c	1	
-rw-r--r--	drivers/bluetooth/bpa10x.c	4	
-rw-r--r--	drivers/bluetooth/btintel_pcie.c	11	
-rw-r--r--	drivers/bluetooth/btmtksdio.c	12	
-rw-r--r--	drivers/bluetooth/btmtkuart.c	4	
-rw-r--r--	drivers/bluetooth/btnxpuart.c	4	
-rw-r--r--	drivers/bluetooth/hci_ag6xx.c	2	
-rw-r--r--	drivers/bluetooth/hci_aml.c	2	
-rw-r--r--	drivers/bluetooth/hci_ath.c	2	
-rw-r--r--	drivers/bluetooth/hci_bcm.c

and so on...



[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/log/?h=for-6.19



-- 
With Best Regards,
Andy Shevchenko



