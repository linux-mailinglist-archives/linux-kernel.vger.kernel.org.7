Return-Path: <linux-kernel+bounces-878991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F3C21EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA526188E64C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3330F934;
	Thu, 30 Oct 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzGEyjyA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9E28727B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852076; cv=none; b=siGWvDRFyDE/SNAwocyGrQveKW/vWS+Mt4e68IYhnZ1D/y7Kmnc+m6uFaf2ZnaTkM/YQswutQHNKDwkKXAkuoQ6PsNayFmQXT5jqNWSLtNTJGFITW8yoNJv3D4ULBX7WtXZbMazFjm5knsfL57ACs1t67jPdJ2KzdTitOPv4e8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852076; c=relaxed/simple;
	bh=2hocMCYlkJ7vaHYBTlrKNpsTpQLXpL7Xf2mz6194Rbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1s1tHs6HreFgSLL7uI+F7hUNYiQBOzboy1eXLU5QUcmIYPv797jzizCqdY2vVUmsHX01gQfHpJCr3DSoUDh+RQmK8w14nRwHvTO9OhdC/YU4r36db0EPdjtm2qOkEguJkRG4Nx3Z0MrNFPT2jI3+MmMkbH+LZ4wAxT8KjuiQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzGEyjyA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761852075; x=1793388075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2hocMCYlkJ7vaHYBTlrKNpsTpQLXpL7Xf2mz6194Rbw=;
  b=ZzGEyjyApkMaEvTjUZKQVt7icMogaX7781GSwXwJqY4eS0wh6JYa1HAo
   fSvKgcMjdM7ROgZW/2/0IC1u6i6Ah1BVF++oS68oLQCktmRDuVJm8ESt2
   FkCgGuukss/7fTOfMf3n7YE9O4UpG7qyKncSNHX4t+lWwHE8HwzmP5FKF
   JdBpwfSyemyuCwc3R5M1rYFjXboAfJDdQaqwlSSy8jQStptap49mIaYXO
   xdzlydH9E9fZEmS9rG8K+CAVgSeFHQKYSwERXSN+VOSrTgd0GVtiCcUrs
   hNHNm4x9q37xQnKTK9YrYd1jyUhoyjX9kgcQ6VCbblM0gCv1sa2waio7D
   g==;
X-CSE-ConnectionGUID: rGKfFlkcT7akW5x32iXWIg==
X-CSE-MsgGUID: 0wEvD+z1Qqq8jZC01pWzXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67659537"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="67659537"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:21:14 -0700
X-CSE-ConnectionGUID: t8XJXzNkRM+8zkg6Ha6a5Q==
X-CSE-MsgGUID: 9XWg6FwWRmiFZOFHWR4AtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="191191981"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Oct 2025 12:21:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEYCr-000MRI-2r;
	Thu, 30 Oct 2025 19:21:09 +0000
Date: Fri, 31 Oct 2025 03:20:32 +0800
From: kernel test robot <lkp@intel.com>
To: Qiang Ma <maqianga@uniontech.com>, akpm@linux-foundation.org,
	bhe@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
Message-ID: <202510310332.6XrLe70K-lkp@intel.com>
References: <20251030073316.529106-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030073316.529106-1-maqianga@uniontech.com>

Hi Qiang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.18-rc3 next-20251030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qiang-Ma/kexec-print-out-debugging-message-if-required-for-kexec_load/20251030-153807
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251030073316.529106-1-maqianga%40uniontech.com
patch subject: [PATCH] kexec: print out debugging message if required for kexec_load
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251031/202510310332.6XrLe70K-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510310332.6XrLe70K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kexec.c:160:10: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
     159 |                 kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
         |                                        ~~
         |                                        %lu
     160 |                               i, ksegment->buf, ksegment->bufsz, ksegment->mem,
         |                               ^
   include/linux/kexec.h:531:55: note: expanded from macro 'kexec_dprintk'
     531 |         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
         |                                                ~~~    ^~~
   include/linux/printk.h:585:34: note: expanded from macro 'pr_info'
     585 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                                 ~~~     ^~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +160 kernel/kexec.c

   141	
   142		ret = machine_kexec_prepare(image);
   143		if (ret)
   144			goto out;
   145	
   146		/*
   147		 * Some architecture(like S390) may touch the crash memory before
   148		 * machine_kexec_prepare(), we must copy vmcoreinfo data after it.
   149		 */
   150		ret = kimage_crash_copy_vmcoreinfo(image);
   151		if (ret)
   152			goto out;
   153	
   154		kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
   155		for (i = 0; i < nr_segments; i++) {
   156			struct kexec_segment *ksegment;
   157	
   158			ksegment = &image->segment[i];
   159			kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
 > 160				      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
   161				      ksegment->memsz);
   162	
   163			ret = kimage_load_segment(image, i);
   164			if (ret)
   165				goto out;
   166		}
   167	
   168		kimage_terminate(image);
   169	
   170		ret = machine_kexec_post_load(image);
   171		if (ret)
   172			goto out;
   173	
   174		kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
   175			      image->type, image->start, image->head, flags);
   176	
   177		/* Install the new kernel and uninstall the old */
   178		image = xchg(dest_image, image);
   179	
   180	out:
   181	#ifdef CONFIG_CRASH_DUMP
   182		if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
   183			arch_kexec_protect_crashkres();
   184	#endif
   185	
   186		kimage_free(image);
   187	out_unlock:
   188		kexec_unlock();
   189		return ret;
   190	}
   191	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

