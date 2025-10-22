Return-Path: <linux-kernel+bounces-863976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA97BF9A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AFA3ABCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7D73F9D2;
	Wed, 22 Oct 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6jhyx/N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18C199FB0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097660; cv=none; b=qhm8V5/oEArfqrjxM5bp4Z2sSE6Z8GNQQXFoWng0++alBevIC9FV8Y+odGHUSJDgDuu9NzZmaQYVj/U5ZZaOsZUPhsxOhnPwZtOa6qRtpC2lSVeE+bTw+6tt1jByJNbawLUwyItFfFIFQPrTL7PpZ2SRYUPKHbjsPQahOAcT2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097660; c=relaxed/simple;
	bh=sKGJ26nwcdWxIdtYVShog8SgA1AwD3KpqLda6XcoQ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTLSbif0Uve9v6n4wx9yHB7tfEq91emFGgERQJGlmGa35/96KSj+SIdeVQa4cNJTm6Kc9aKtN+srRegJx8phOYS60s8F55wfURw3ACWD3whe10F+0KX79RxhGOjSVMEzb0xtd4tCL34VQvoh2e5T0hTO7oBBC4A5NJHFCkvC5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6jhyx/N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761097659; x=1792633659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sKGJ26nwcdWxIdtYVShog8SgA1AwD3KpqLda6XcoQ2c=;
  b=R6jhyx/NJ7+6WGULxw9fhkBS1KZVZFgMJ3l2pk2b8N2dq5qVr8xcN2B7
   E0gOFz008DTBIH/Aook2son+NKIZkY2WWGIrdrZl+Y7gE3KX3X8yiE8wU
   7rbFY5nPHpvMrRl9oDbcZCc6pq4ugJ+YMA5VYdDXBcZ1AHUJCX5bO8Y64
   0h7L98W6mGSovhfMw6g5dYLexwvWyOX88ZkoHBNjswteNv28JbV3axlls
   BYrsigTVJ1p8w5//OgmzL3wFEMERNYSZrR48oirsbyljPoorb8mD67n/j
   ChtN+6/O+CXAoLRAscXFGJONedyG6B1IKAV6V6uSHlEjPJ/QZK2tf2etL
   w==;
X-CSE-ConnectionGUID: KvQWlZx6R5mS0LE37FkO3g==
X-CSE-MsgGUID: /aVJFllIRluhUN+fC/cdVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66876429"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="66876429"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 18:47:39 -0700
X-CSE-ConnectionGUID: F06MRBqFRl+MbppalCGidA==
X-CSE-MsgGUID: DnM8K+CpRHGLilbqjD0Siw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="207417379"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Oct 2025 18:47:36 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBNws-000BuP-24;
	Wed, 22 Oct 2025 01:47:34 +0000
Date: Wed, 22 Oct 2025 09:47:29 +0800
From: kernel test robot <lkp@intel.com>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: Re: [PATCH] dma-buf: improve dma_buf_show_fdinfo output
Message-ID: <202510220948.fae9xJYg-lkp@intel.com>
References: <20251021133132.29751-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021133132.29751-1-biancaa2210329@ssn.edu.in>

Hi Biancaa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.18-rc2 next-20251021]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Biancaa-Ramesh/dma-buf-improve-dma_buf_show_fdinfo-output/20251021-213541
base:   linus/master
patch link:    https://lore.kernel.org/r/20251021133132.29751-1-biancaa2210329%40ssn.edu.in
patch subject: [PATCH] dma-buf: improve dma_buf_show_fdinfo output
config: x86_64-randconfig-002-20251022 (https://download.01.org/0day-ci/archive/20251022/202510220948.fae9xJYg-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510220948.fae9xJYg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510220948.fae9xJYg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma-buf/dma-buf.c:581:36: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
     581 |     seq_printf(s, "flags:\t%lu\n", f->f_flags);
         |                            ~~~     ^~~~~~~~~~
         |                            %u
>> drivers/dma-buf/dma-buf.c:582:36: warning: format specifies type 'unsigned long long' but the argument has type 'size_t' (aka 'unsigned long') [-Wformat]
     582 |     seq_printf(s, "size:\t%llu\n", dmabuf->size);
         |                           ~~~~     ^~~~~~~~~~~~
         |                           %zu
   drivers/dma-buf/dma-buf.c:584:62: error: no member named 'num_attachments' in 'struct dma_buf'; did you mean 'attachments'?
     584 |     seq_printf(s, "attachments:\t%d\n", atomic_read(&dmabuf->num_attachments));
         |                                                              ^~~~~~~~~~~~~~~
         |                                                              attachments
   include/linux/dma-buf.h:315:19: note: 'attachments' declared here
     315 |         struct list_head attachments;
         |                          ^
   drivers/dma-buf/dma-buf.c:585:59: error: no member named 'num_mappings' in 'struct dma_buf'
     585 |     seq_printf(s, "mappings:\t%d\n", atomic_read(&dmabuf->num_mappings));
         |                                                   ~~~~~~  ^
   2 warnings and 2 errors generated.


vim +581 drivers/dma-buf/dma-buf.c

   573	
   574	static void dma_buf_show_fdinfo(struct seq_file *s, struct file *f)
   575	{
   576	    struct dma_buf *dmabuf = f->private_data;
   577	
   578	    if (!dmabuf)
   579	        return;
   580	
 > 581	    seq_printf(s, "flags:\t%lu\n", f->f_flags);
 > 582	    seq_printf(s, "size:\t%llu\n", dmabuf->size);
   583	    seq_printf(s, "count:\t%ld\n", file_count(dmabuf->file) - 1);
   584	    seq_printf(s, "attachments:\t%d\n", atomic_read(&dmabuf->num_attachments));
   585	    seq_printf(s, "mappings:\t%d\n", atomic_read(&dmabuf->num_mappings));
   586	    seq_printf(s, "exp_name:\t%s\n", dmabuf->exp_name ? dmabuf->exp_name : "N/A");
   587	
   588	    spin_lock(&dmabuf->name_lock);
   589	    if (dmabuf->name)
   590	        seq_printf(s, "name:\t%s\n", dmabuf->name);
   591	    spin_unlock(&dmabuf->name_lock);
   592	}
   593	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

