Return-Path: <linux-kernel+bounces-758215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D183B1CC95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584E818C1431
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455221ABDD;
	Wed,  6 Aug 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P56v+kgk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F51FBCB5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509529; cv=none; b=n4EdbLLnBqyonyHWmW+QJ1VN7gdKP1k7AZ6vJYJyjFGsD7uc8AnE2vpmWiLbvO6XJi3ESM/OMHSc4f7JMlGoEBejztF7tKPHYVmGhjSjbkfZcO13jyAQWNtgJFDGntwRDTQ6q655rjousyoXJ2tzoP1O8aySCFz4Kh0VdDDiqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509529; c=relaxed/simple;
	bh=PHSbwYIQhxWlqkYmx2TlmpPz5Tj+JhG6IBOTdEluDig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyCVsKf88vGJIKiApYSWLmI/g+4DQjF52e4ts+HpwXHm/M+f+qY2fEJNaAVGXWaixL/ZMEhc5+0sd1At18uNRab4foTjzw1/JO4KZTVlL2bFW0wgckTBfWYbeB6NDWmrjL6+cAfPS8Q0T8bql2WmkSTgvDgHfevIVC/pEnV27J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P56v+kgk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754509527; x=1786045527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PHSbwYIQhxWlqkYmx2TlmpPz5Tj+JhG6IBOTdEluDig=;
  b=P56v+kgkUhtm/Hy7xESJKPyPSsSKgzM8giVc+7Zw+0/JZj4BVGtG6kF8
   Ux0ommESrxpiNT3Fj+MewBiT0BJ+b7D2v1m7e4Op0sJkd4X0p9EBa21+0
   WoZZkrO6Ul7U8VXAuCcXQDRCKqz9a8dCkVHngnJQrzmEsVLfwJbVb+ef7
   xIht8T7sSrzQCgpv37m/vWLBmniQ43j3gHAWtSBfq58kiAYNQDHRmISt6
   RS+LdYuL3jlEJC339E+4yVmeCqwaOGtSyBR5wjptFWpcIaqDpkugcmMwc
   mDtHs5Oxnc12rLqvwEc51i9oHzkQHoaz9CctfsWljtlGbMBprXqowX6ns
   w==;
X-CSE-ConnectionGUID: mLz6S26YRya3DU0MrADMOg==
X-CSE-MsgGUID: dq98w4TKQCeLCJ4M4hsMjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56971859"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56971859"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 12:45:26 -0700
X-CSE-ConnectionGUID: s6re+NOZT8OyWcgCf5S0Ig==
X-CSE-MsgGUID: 6joJOnm1QkiEJH4+/9hQuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164379697"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 06 Aug 2025 12:45:22 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujk4e-000226-1a;
	Wed, 06 Aug 2025 19:45:20 +0000
Date: Thu, 7 Aug 2025 03:44:47 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuu?= <linux@weissschuh.net>,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdx: don't select CONFIG_GENERIC_MSI_IRQ
Message-ID: <202508070308.opy5dIFX-lkp@intel.com>
References: <20250805161059.4006484-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805161059.4006484-1-arnd@kernel.org>

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20250806]
[cannot apply to soc/for-next v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/cdx-don-t-select-CONFIG_GENERIC_MSI_IRQ/20250806-121343
base:   linus/master
patch link:    https://lore.kernel.org/r/20250805161059.4006484-1-arnd%40kernel.org
patch subject: [PATCH] cdx: don't select CONFIG_GENERIC_MSI_IRQ
config: hexagon-randconfig-002-20250807 (https://download.01.org/0day-ci/archive/20250807/202508070308.opy5dIFX-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7b8dea265e72c3037b6b1e54d5ab51b7e14f328b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070308.opy5dIFX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070308.opy5dIFX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/vfio/cdx/intr.c:41:8: error: call to undeclared function 'msi_domain_alloc_irqs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      41 |         ret = msi_domain_alloc_irqs(dev, MSI_DEFAULT_DOMAIN, nvec);
         |               ^
   drivers/vfio/cdx/intr.c:41:8: note: did you mean 'msi_domain_get_virq'?
   include/linux/msi_api.h:58:14: note: 'msi_domain_get_virq' declared here
      58 | unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index);
         |              ^
>> drivers/vfio/cdx/intr.c:135:2: error: call to undeclared function 'msi_domain_free_irqs_all'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     135 |         msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
         |         ^
   2 errors generated.


vim +/msi_domain_alloc_irqs +41 drivers/vfio/cdx/intr.c

848e447e000c418 Nipun Gupta 2024-04-23   23  
848e447e000c418 Nipun Gupta 2024-04-23   24  static int vfio_cdx_msi_enable(struct vfio_cdx_device *vdev, int nvec)
848e447e000c418 Nipun Gupta 2024-04-23   25  {
848e447e000c418 Nipun Gupta 2024-04-23   26  	struct cdx_device *cdx_dev = to_cdx_device(vdev->vdev.dev);
848e447e000c418 Nipun Gupta 2024-04-23   27  	struct device *dev = vdev->vdev.dev;
848e447e000c418 Nipun Gupta 2024-04-23   28  	int msi_idx, ret;
848e447e000c418 Nipun Gupta 2024-04-23   29  
848e447e000c418 Nipun Gupta 2024-04-23   30  	vdev->cdx_irqs = kcalloc(nvec, sizeof(struct vfio_cdx_irq), GFP_KERNEL);
848e447e000c418 Nipun Gupta 2024-04-23   31  	if (!vdev->cdx_irqs)
848e447e000c418 Nipun Gupta 2024-04-23   32  		return -ENOMEM;
848e447e000c418 Nipun Gupta 2024-04-23   33  
848e447e000c418 Nipun Gupta 2024-04-23   34  	ret = cdx_enable_msi(cdx_dev);
848e447e000c418 Nipun Gupta 2024-04-23   35  	if (ret) {
848e447e000c418 Nipun Gupta 2024-04-23   36  		kfree(vdev->cdx_irqs);
848e447e000c418 Nipun Gupta 2024-04-23   37  		return ret;
848e447e000c418 Nipun Gupta 2024-04-23   38  	}
848e447e000c418 Nipun Gupta 2024-04-23   39  
848e447e000c418 Nipun Gupta 2024-04-23   40  	/* Allocate cdx MSIs */
848e447e000c418 Nipun Gupta 2024-04-23  @41  	ret = msi_domain_alloc_irqs(dev, MSI_DEFAULT_DOMAIN, nvec);
848e447e000c418 Nipun Gupta 2024-04-23   42  	if (ret) {
848e447e000c418 Nipun Gupta 2024-04-23   43  		cdx_disable_msi(cdx_dev);
848e447e000c418 Nipun Gupta 2024-04-23   44  		kfree(vdev->cdx_irqs);
848e447e000c418 Nipun Gupta 2024-04-23   45  		return ret;
848e447e000c418 Nipun Gupta 2024-04-23   46  	}
848e447e000c418 Nipun Gupta 2024-04-23   47  
848e447e000c418 Nipun Gupta 2024-04-23   48  	for (msi_idx = 0; msi_idx < nvec; msi_idx++)
848e447e000c418 Nipun Gupta 2024-04-23   49  		vdev->cdx_irqs[msi_idx].irq_no = msi_get_virq(dev, msi_idx);
848e447e000c418 Nipun Gupta 2024-04-23   50  
848e447e000c418 Nipun Gupta 2024-04-23   51  	vdev->msi_count = nvec;
848e447e000c418 Nipun Gupta 2024-04-23   52  	vdev->config_msi = 1;
848e447e000c418 Nipun Gupta 2024-04-23   53  
848e447e000c418 Nipun Gupta 2024-04-23   54  	return 0;
848e447e000c418 Nipun Gupta 2024-04-23   55  }
848e447e000c418 Nipun Gupta 2024-04-23   56  
848e447e000c418 Nipun Gupta 2024-04-23   57  static int vfio_cdx_msi_set_vector_signal(struct vfio_cdx_device *vdev,
848e447e000c418 Nipun Gupta 2024-04-23   58  					  int vector, int fd)
848e447e000c418 Nipun Gupta 2024-04-23   59  {
848e447e000c418 Nipun Gupta 2024-04-23   60  	struct eventfd_ctx *trigger;
848e447e000c418 Nipun Gupta 2024-04-23   61  	int irq_no, ret;
848e447e000c418 Nipun Gupta 2024-04-23   62  
848e447e000c418 Nipun Gupta 2024-04-23   63  	if (vector < 0 || vector >= vdev->msi_count)
848e447e000c418 Nipun Gupta 2024-04-23   64  		return -EINVAL;
848e447e000c418 Nipun Gupta 2024-04-23   65  
848e447e000c418 Nipun Gupta 2024-04-23   66  	irq_no = vdev->cdx_irqs[vector].irq_no;
848e447e000c418 Nipun Gupta 2024-04-23   67  
848e447e000c418 Nipun Gupta 2024-04-23   68  	if (vdev->cdx_irqs[vector].trigger) {
848e447e000c418 Nipun Gupta 2024-04-23   69  		free_irq(irq_no, vdev->cdx_irqs[vector].trigger);
848e447e000c418 Nipun Gupta 2024-04-23   70  		kfree(vdev->cdx_irqs[vector].name);
848e447e000c418 Nipun Gupta 2024-04-23   71  		eventfd_ctx_put(vdev->cdx_irqs[vector].trigger);
848e447e000c418 Nipun Gupta 2024-04-23   72  		vdev->cdx_irqs[vector].trigger = NULL;
848e447e000c418 Nipun Gupta 2024-04-23   73  	}
848e447e000c418 Nipun Gupta 2024-04-23   74  
848e447e000c418 Nipun Gupta 2024-04-23   75  	if (fd < 0)
848e447e000c418 Nipun Gupta 2024-04-23   76  		return 0;
848e447e000c418 Nipun Gupta 2024-04-23   77  
848e447e000c418 Nipun Gupta 2024-04-23   78  	vdev->cdx_irqs[vector].name = kasprintf(GFP_KERNEL, "vfio-msi[%d](%s)",
848e447e000c418 Nipun Gupta 2024-04-23   79  						vector, dev_name(vdev->vdev.dev));
848e447e000c418 Nipun Gupta 2024-04-23   80  	if (!vdev->cdx_irqs[vector].name)
848e447e000c418 Nipun Gupta 2024-04-23   81  		return -ENOMEM;
848e447e000c418 Nipun Gupta 2024-04-23   82  
848e447e000c418 Nipun Gupta 2024-04-23   83  	trigger = eventfd_ctx_fdget(fd);
848e447e000c418 Nipun Gupta 2024-04-23   84  	if (IS_ERR(trigger)) {
848e447e000c418 Nipun Gupta 2024-04-23   85  		kfree(vdev->cdx_irqs[vector].name);
848e447e000c418 Nipun Gupta 2024-04-23   86  		return PTR_ERR(trigger);
848e447e000c418 Nipun Gupta 2024-04-23   87  	}
848e447e000c418 Nipun Gupta 2024-04-23   88  
848e447e000c418 Nipun Gupta 2024-04-23   89  	ret = request_irq(irq_no, vfio_cdx_msihandler, 0,
848e447e000c418 Nipun Gupta 2024-04-23   90  			  vdev->cdx_irqs[vector].name, trigger);
848e447e000c418 Nipun Gupta 2024-04-23   91  	if (ret) {
848e447e000c418 Nipun Gupta 2024-04-23   92  		kfree(vdev->cdx_irqs[vector].name);
848e447e000c418 Nipun Gupta 2024-04-23   93  		eventfd_ctx_put(trigger);
848e447e000c418 Nipun Gupta 2024-04-23   94  		return ret;
848e447e000c418 Nipun Gupta 2024-04-23   95  	}
848e447e000c418 Nipun Gupta 2024-04-23   96  
848e447e000c418 Nipun Gupta 2024-04-23   97  	vdev->cdx_irqs[vector].trigger = trigger;
848e447e000c418 Nipun Gupta 2024-04-23   98  
848e447e000c418 Nipun Gupta 2024-04-23   99  	return 0;
848e447e000c418 Nipun Gupta 2024-04-23  100  }
848e447e000c418 Nipun Gupta 2024-04-23  101  
848e447e000c418 Nipun Gupta 2024-04-23  102  static int vfio_cdx_msi_set_block(struct vfio_cdx_device *vdev,
848e447e000c418 Nipun Gupta 2024-04-23  103  				  unsigned int start, unsigned int count,
848e447e000c418 Nipun Gupta 2024-04-23  104  				  int32_t *fds)
848e447e000c418 Nipun Gupta 2024-04-23  105  {
848e447e000c418 Nipun Gupta 2024-04-23  106  	int i, j, ret = 0;
848e447e000c418 Nipun Gupta 2024-04-23  107  
848e447e000c418 Nipun Gupta 2024-04-23  108  	if (start >= vdev->msi_count || start + count > vdev->msi_count)
848e447e000c418 Nipun Gupta 2024-04-23  109  		return -EINVAL;
848e447e000c418 Nipun Gupta 2024-04-23  110  
848e447e000c418 Nipun Gupta 2024-04-23  111  	for (i = 0, j = start; i < count && !ret; i++, j++) {
848e447e000c418 Nipun Gupta 2024-04-23  112  		int fd = fds ? fds[i] : -1;
848e447e000c418 Nipun Gupta 2024-04-23  113  
848e447e000c418 Nipun Gupta 2024-04-23  114  		ret = vfio_cdx_msi_set_vector_signal(vdev, j, fd);
848e447e000c418 Nipun Gupta 2024-04-23  115  	}
848e447e000c418 Nipun Gupta 2024-04-23  116  
848e447e000c418 Nipun Gupta 2024-04-23  117  	if (ret) {
848e447e000c418 Nipun Gupta 2024-04-23  118  		for (--j; j >= (int)start; j--)
848e447e000c418 Nipun Gupta 2024-04-23  119  			vfio_cdx_msi_set_vector_signal(vdev, j, -1);
848e447e000c418 Nipun Gupta 2024-04-23  120  	}
848e447e000c418 Nipun Gupta 2024-04-23  121  
848e447e000c418 Nipun Gupta 2024-04-23  122  	return ret;
848e447e000c418 Nipun Gupta 2024-04-23  123  }
848e447e000c418 Nipun Gupta 2024-04-23  124  
848e447e000c418 Nipun Gupta 2024-04-23  125  static void vfio_cdx_msi_disable(struct vfio_cdx_device *vdev)
848e447e000c418 Nipun Gupta 2024-04-23  126  {
848e447e000c418 Nipun Gupta 2024-04-23  127  	struct cdx_device *cdx_dev = to_cdx_device(vdev->vdev.dev);
848e447e000c418 Nipun Gupta 2024-04-23  128  	struct device *dev = vdev->vdev.dev;
848e447e000c418 Nipun Gupta 2024-04-23  129  
848e447e000c418 Nipun Gupta 2024-04-23  130  	vfio_cdx_msi_set_block(vdev, 0, vdev->msi_count, NULL);
848e447e000c418 Nipun Gupta 2024-04-23  131  
848e447e000c418 Nipun Gupta 2024-04-23  132  	if (!vdev->config_msi)
848e447e000c418 Nipun Gupta 2024-04-23  133  		return;
848e447e000c418 Nipun Gupta 2024-04-23  134  
848e447e000c418 Nipun Gupta 2024-04-23 @135  	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
848e447e000c418 Nipun Gupta 2024-04-23  136  	cdx_disable_msi(cdx_dev);
848e447e000c418 Nipun Gupta 2024-04-23  137  	kfree(vdev->cdx_irqs);
848e447e000c418 Nipun Gupta 2024-04-23  138  
848e447e000c418 Nipun Gupta 2024-04-23  139  	vdev->cdx_irqs = NULL;
848e447e000c418 Nipun Gupta 2024-04-23  140  	vdev->msi_count = 0;
848e447e000c418 Nipun Gupta 2024-04-23  141  	vdev->config_msi = 0;
848e447e000c418 Nipun Gupta 2024-04-23  142  }
848e447e000c418 Nipun Gupta 2024-04-23  143  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

