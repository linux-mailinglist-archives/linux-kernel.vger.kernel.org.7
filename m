Return-Path: <linux-kernel+bounces-785804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7694B35145
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0B0207E46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12121A444;
	Tue, 26 Aug 2025 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQVHgb1P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3663BBF2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173338; cv=none; b=QiT7BB7Pv5drk5nLlyjuJfABPu2YkWYNZLqx8ykSQuS52Js3WwDMMIl2F3mp1fIix0NjbIhlQ+ze7rU7wt+XuzrBUfbl9SHtbPTyyxwUlq3poL9JdgEZB0QuXRap1v23qKpTFFTSvC57ApCDMet6cZYPJX+Ll3l/95yWzoicOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173338; c=relaxed/simple;
	bh=4hB1Ohdsu3e3OwOT9KZUcuu3uI7kLzVe0w65yF8+ZXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6Nr+so0e2OJX0wxxHdQy60u3Amfrua2l5KPboFcKbFSyuTJRtClLkJbyVYNo4gJk3mVjvHstOtUbgir6uCM/8F+os+UrXNWhX2bfNe/xWFOMwr4T+y61xw4jjHCsMOb/PrFHkD9kmMZaG/CCuBp5Oux0LjdgJVfwN6BxI+wvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQVHgb1P; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756173337; x=1787709337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4hB1Ohdsu3e3OwOT9KZUcuu3uI7kLzVe0w65yF8+ZXY=;
  b=KQVHgb1Pw4zchhR7/r59uCTWch8ml0AF3jcYPh48WMGKens4tzUav1Qs
   NnJryiHVrc2lUhbSZFgxbzDG868wxBBwqWxeMvlX01kFTcWM+J/gfSMy0
   PWYJIoopwxSfpN9ZTTt7yDn58NLqhG6FFPxLj4pevMBSP4s4u0qbzko/B
   21Y7WvtXEIHUzJGejk1dEEBbK1D7Ac3hcrnpHJKOpmjV03gdGWWoS31N5
   3xedYFd594JNzxJ7xlF56jFO+ujX1ZUBZHTa22l8A4TMi0xAivEVKG8dr
   ecIL4Tj3nUrLq1ZFVxPT1asxD/i3N80DkjyT0zTJbIgmgY1oYJEUpRilZ
   A==;
X-CSE-ConnectionGUID: Yic0J+Z6QH+kg+KbwN+S/A==
X-CSE-MsgGUID: j8LGBlCNSIyG7ap3etAWUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69832645"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69832645"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 18:55:36 -0700
X-CSE-ConnectionGUID: I8sPxLP7SFOCw2ef/84AXw==
X-CSE-MsgGUID: /LdffSHCTy2Cb9DFe9vTrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200396304"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 25 Aug 2025 18:55:33 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqiuJ-000O9f-0S;
	Tue, 26 Aug 2025 01:55:31 +0000
Date: Tue, 26 Aug 2025 09:55:13 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>, Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
Message-ID: <202508260914.Bjz2YQwS-lkp@intel.com>
References: <20250820055700.24344-3-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820055700.24344-3-youling.tang@linux.dev>

Hi Youling,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.17-rc3 next-20250825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/LoongArch-Add-struct-loongarch_image_header-for-kernel-image/20250820-140025
base:   linus/master
patch link:    https://lore.kernel.org/r/20250820055700.24344-3-youling.tang%40linux.dev
patch subject: [PATCH v2 2/5] LoongArch: Add kexec_file support
config: loongarch-randconfig-r121-20250826 (https://download.01.org/0day-ci/archive/20250826/202508260914.Bjz2YQwS-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce: (https://download.01.org/0day-ci/archive/20250826/202508260914.Bjz2YQwS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508260914.Bjz2YQwS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/loongarch/kernel/kexec_efi.c:61:22: sparse: sparse: cast to restricted __le64
   arch/loongarch/kernel/kexec_efi.c:62:23: sparse: sparse: cast to restricted __le64

vim +61 arch/loongarch/kernel/kexec_efi.c

    37	
    38	static void *efi_kexec_load(struct kimage *image,
    39					char *kernel, unsigned long kernel_len,
    40					char *initrd, unsigned long initrd_len,
    41					char *cmdline, unsigned long cmdline_len)
    42	{
    43		struct loongarch_image_header *h;
    44		struct kexec_buf kbuf;
    45		unsigned long text_offset, kernel_segment_number;
    46		struct kexec_segment *kernel_segment;
    47		int ret;
    48	
    49		h = (struct loongarch_image_header *)kernel;
    50		if (!h->image_size)
    51			return ERR_PTR(-EINVAL);
    52	
    53		/* Load the kernel */
    54		kbuf.image = image;
    55		kbuf.buf_max = ULONG_MAX;
    56		kbuf.top_down = false;
    57	
    58		kbuf.buffer = kernel;
    59		kbuf.bufsz = kernel_len;
    60		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
  > 61		kbuf.memsz = le64_to_cpu(h->image_size);
    62		text_offset = le64_to_cpu(h->text_offset);
    63		kbuf.buf_min = text_offset;
    64		kbuf.buf_align = SZ_2M;
    65	
    66		kernel_segment_number = image->nr_segments;
    67	
    68		/*
    69		 * The location of the kernel segment may make it impossible to satisfy
    70		 * the other segment requirements, so we try repeatedly to find a
    71		 * location that will work.
    72		 */
    73		while ((ret = kexec_add_buffer(&kbuf)) == 0) {
    74			/* Try to load additional data */
    75			kernel_segment = &image->segment[kernel_segment_number];
    76			ret = load_other_segments(image, kernel_segment->mem,
    77						  kernel_segment->memsz, initrd,
    78						  initrd_len, cmdline, cmdline_len);
    79			if (!ret)
    80				break;
    81	
    82			/*
    83			 * We couldn't find space for the other segments; erase the
    84			 * kernel segment and try the next available hole.
    85			 */
    86			image->nr_segments -= 1;
    87			kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
    88			kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
    89		}
    90	
    91		if (ret) {
    92			pr_err("Could not find any suitable kernel location!");
    93			return ERR_PTR(ret);
    94		}
    95	
    96		kernel_segment = &image->segment[kernel_segment_number];
    97	
    98		/* Make sure the second kernel jumps to the correct "kernel_entry". */
    99		image->start = kernel_segment->mem + h->kernel_entry - text_offset;
   100	
   101		kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
   102			      kernel_segment->mem, kbuf.bufsz,
   103			      kernel_segment->memsz);
   104	
   105		return NULL;
   106	}
   107	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

