Return-Path: <linux-kernel+bounces-885082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CDC31F15
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440854254E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE382750FE;
	Tue,  4 Nov 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4L8N7ut"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F624E4C4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271504; cv=none; b=DXKKnjz7+OfJLXSf94WEMtpmfgPlOzEVTkGVaR1IdlfckIafapdeEgU6U5YDO6wZXu0QijRYNcISClPLF5ByHyJW3EVuivLeiFnWpxKMzvSZbkDaYxMB9RQ/c7ptavCgI+YGoFnr9dwEyzKenzDqO20jeEGjFmMMskKqyr7Ku5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271504; c=relaxed/simple;
	bh=wxTCQBE7jbi9ouK7W7f3XGlEyig480MXXNLlHFmDMBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikg7fDmU91S2NCWYfqaj1LXD29+moRqx2pkFbOX0f2uMNL/BZ7jNnbvHqvpt6H0Cdo5RYW6AQaPBaH9wdxoN6sH1Wj3WJjGkjkGhRGH/MoEEsXt+vTGyMwJ1AxkHLn/Ao9ZBzd70qer6qZuEn4JAvP9WUZEeGxA8Zt63JCnUNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4L8N7ut; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762271502; x=1793807502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wxTCQBE7jbi9ouK7W7f3XGlEyig480MXXNLlHFmDMBY=;
  b=k4L8N7utpUBvDizZdiqXLjQhQxglCLbzmIQByOdDB+BP3Vg1vjrItBod
   puZhswNV1ZHx3ZbUfOiXdG1JN3fp2jnbtcd79houNkLclk7MVorPeP7xo
   7lnRhPNEcgJzQW5kKfZEYUy/4CJiLpP9SJVWeae98LWFXi1kpOUIyQhKa
   i+6psXgcb3EI3z3L3cZCapW3Cb5GLVjD84nzxBoNDGgJ43MY4KjZCqOdY
   iz6/tn3ohS95po0/rsQNUII3eZpLdArIaqhk1lBJybPRbChdWoe8i3ID4
   qTjL9rZ6K2pq4cKDS51TE/IAjdnZVdbfGxfr+5BGeidINSnjWGJxooufx
   A==;
X-CSE-ConnectionGUID: x8+d+xiDQjSKH1X8umHEvg==
X-CSE-MsgGUID: oeVjsThBRYW9pKFdjKdixg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64286307"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64286307"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 07:51:42 -0800
X-CSE-ConnectionGUID: NJhAgFvpTuqIFskltf/CSw==
X-CSE-MsgGUID: 9vVe96BZSVeK6oxJGbPekw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191495242"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 07:51:41 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGJJq-00000005VGU-3vrM;
	Tue, 04 Nov 2025 17:51:38 +0200
Date: Tue, 4 Nov 2025 17:51:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQohCnVQfVsS7YYp@smile.fi.intel.com>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQogTFANK1fMtloW@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 05:48:29PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 04, 2025 at 03:32:59PM +0000, Mark Brown wrote:
> > On Tue, Nov 04, 2025 at 05:20:59PM +0200, Andy Shevchenko wrote:
> > 
> > > Something bad happened to the regulator branch [1].
> > > First of all, the merge message contains unneeded details (at least the
> > > author's email signature). Second, the few lines series becomes 3kLoCs
> > > merge commit. I think the base was wrong and `b4` (if you use that one)
> > > took too much to merge.
> > 
> > I forgot to trim the cover letter but otherwise I really can't see any
> > issues and you're not in the slightest bit specific about what you think
> > is a problem.  The diffstat for the tree is:
> > 
> >  13 files changed, 1149 insertions(+), 780 deletions(-)
> > 
> > which doesn't doesn't correspond to "thousands" of lines.  I really
> > can't tell what on earth you are talking about here.
> 
> I look at it via GitWeb [1] and that's what I see:
> 
> Age	Commit message (Expand)	Author	Files	Lines
> 2 hours	regulator: pf9453: optimize PMIC PF9453 driverHEADfor-nextfor-6.19	Mark Brown	253	-872/+2020
> 26 hours	regulator: pf9453: remove unused I2C_LT register	Joy Zou	1	-7/+0
> 26 hours	regulator: pf9453: remove low power mode	Joy Zou	1	-12/+0
> 26 hours	regulator: pf9453: change the device ID register address	Joy Zou	1	-2/+1
> 27 hours	regulator: Small cleanup in of_get_regulation_constraints()	Dan Carpenter	1	-3/+3
> 44 hours	Linux 6.18-rc4for-linusfor-6.18	Linus Torvalds	1	-1/+1
> ...
> 
> Which suggests the series changes only few lines, but if you click to the last
> merge commit, you will see the heck out of whole tree bound to it. This is
> usually the case when `b4 shazam` guesses the base in a way one doesn't expect
> (it may merge your local branch if it founds match in the series with what you
>  have).
> 
> So, in the merge commit the picture is
> 
> Diffstat
> -rw-r--r--	.mailmap	1	
> -rw-r--r--	CREDITS	4	
> -rw-r--r--	Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml	4	
> -rw-r--r--	Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml	4	
> -rw-r--r--	Documentation/netlink/specs/dpll.yaml	2	
> -rw-r--r--	Documentation/networking/netconsole.rst	3	
> -rw-r--r--	MAINTAINERS	16	
> -rw-r--r--	Makefile	2	
> -rw-r--r--	arch/arm64/net/bpf_jit_comp.c	5	
> -rw-r--r--	arch/s390/Kconfig	1	
> -rw-r--r--	arch/s390/configs/debug_defconfig	14	
> -rw-r--r--	arch/s390/configs/defconfig	14	
> -rw-r--r--	arch/s390/configs/zfcpdump_defconfig	1	
> -rw-r--r--	arch/s390/crypto/phmac_s390.c	52	
> -rw-r--r--	arch/s390/include/asm/pci.h	1	
> -rw-r--r--	arch/s390/mm/dump_pagetables.c	21	
> -rw-r--r--	arch/s390/pci/pci_event.c	4	
> -rw-r--r--	arch/s390/pci/pci_irq.c	9	
> -rw-r--r--	arch/x86/Makefile	2	
> -rw-r--r--	arch/x86/events/intel/core.c	1	
> -rw-r--r--	arch/x86/events/intel/ds.c	3	
> -rw-r--r--	arch/x86/events/intel/uncore.c	1	
> -rw-r--r--	arch/x86/include/asm/intel-family.h	6	
> -rw-r--r--	arch/x86/include/asm/page_64.h	3	
> -rw-r--r--	arch/x86/kernel/cpu/amd.c	12	
> -rw-r--r--	arch/x86/kernel/cpu/microcode/amd.c	20	
> -rw-r--r--	arch/x86/kernel/fpu/core.c	3	
> -rw-r--r--	arch/x86/net/bpf_jit_comp.c	2	
> -rw-r--r--	block/blk-crypto.c	2	
> -rw-r--r--	drivers/acpi/acpi_mrrm.c	3	
> -rw-r--r--	drivers/acpi/acpi_video.c	4	
> -rw-r--r--	drivers/acpi/button.c	4	
> -rw-r--r--	drivers/acpi/fan.h	7	
> -rw-r--r--	drivers/acpi/fan_attr.c	2	
> -rw-r--r--	drivers/acpi/fan_core.c	36	
> -rw-r--r--	drivers/acpi/fan_hwmon.c	11	
> -rw-r--r--	drivers/acpi/spcr.c	2	
> -rw-r--r--	drivers/base/regmap/regmap-slimbus.c	6	
> -rw-r--r--	drivers/bcma/main.c	6	
> -rw-r--r--	drivers/block/null_blk/main.c	1	
> -rw-r--r--	drivers/bluetooth/bpa10x.c	4	
> -rw-r--r--	drivers/bluetooth/btintel_pcie.c	11	
> -rw-r--r--	drivers/bluetooth/btmtksdio.c	12	
> -rw-r--r--	drivers/bluetooth/btmtkuart.c	4	
> -rw-r--r--	drivers/bluetooth/btnxpuart.c	4	
> -rw-r--r--	drivers/bluetooth/hci_ag6xx.c	2	
> -rw-r--r--	drivers/bluetooth/hci_aml.c	2	
> -rw-r--r--	drivers/bluetooth/hci_ath.c	2	
> -rw-r--r--	drivers/bluetooth/hci_bcm.c
> 
> and so on...
> 
> 
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/log/?h=for-6.19

Compare to [2] I made in my tree

Age	Commit message (Expand)	Author	Files	Lines
7 hours	Merge patch series "pinctrl: intel: Unify error messages"review-andyfor-next	Andy Shevchenko	5	-64/+35
7 hours	pinctrl: tangier: Unify messages with help of dev_err_probe()	Andy Shevchenko	1	-2/+1
7 hours	pinctrl: lynxpoint: Unify messages with help of dev_err_probe()	Andy Shevchenko	1	-18/+10
7 hours	pinctrl: intel: Unify messages with help of dev_err_probe()	Andy Shevchenko	1	-16/+8
7 hours	pinctrl: cherryview: Unify messages with help of dev_err_probe()	Andy Shevchenko	1	-16/+8
7 hours	pinctrl: baytrail: Unify messages with help of dev_err_probe()	Andy Shevchenko	1	-12/+8
2025-10-12	Linux 6.18-rc1v6.18-rc1fixes	Linus Torvalds	1	-2/+2

* You may already notice that the merge commit statistics correlates by numbers with the series below.

So it's definitely not a problem of GitWeb.

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel.git/log/?h=for-next

-- 
With Best Regards,
Andy Shevchenko



