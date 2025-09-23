Return-Path: <linux-kernel+bounces-828112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DBDB93F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF5218A64C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02856274658;
	Tue, 23 Sep 2025 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhXrKeh4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B82749C1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758593364; cv=none; b=q86SnycsTXQVHbA7RuzC17Eh9sBzE/q+SKEzEk2hhK+68cKHCaSllL3xNXb4MTNt10EgmmRKCVBbLkWswt5BqdxCe9trHoLnqQn+z0r/ftp0wReuQj7e2eQ35kDr2Cbp2W2CNlP7tHmRzADp5RrNefUC1k1OwaJNLK/KR01g648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758593364; c=relaxed/simple;
	bh=g7DmpIPs15UHBB9LtMIq6t6tGz0g4/OwnNpVLGfrMDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fuss//xnu8CWG0PKZX+Vvmocx0pFfgCwaoPyGelMW81rdxVV3rpGwDDrzdzbRjWG+esSs3SBlm9FuZ+xHeVMpNBO10KyulQoyn6hS3Pe0YM5TgerUzDobcji2KG7BlEUHDnQOQ+xqSzmo+RQaRJ711TPxeel0g5eAdPr2wpbQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhXrKeh4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758593362; x=1790129362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g7DmpIPs15UHBB9LtMIq6t6tGz0g4/OwnNpVLGfrMDs=;
  b=NhXrKeh4aUOARIuwX/ITNuMbeHKA+DlKZvNtEW6QCusb+ABfe7zC8UWf
   yQ2wS1uF2h/PMYA1Qewrwga6TlHKSHmrJkmesD+Cz6UAO3pi/A5KA9Ar4
   CZbWm9v6AUmMk2xcFH+v+4/OS2Sk0IPe0QGWa06JxCEtYXTx2o0UYNx2S
   hQjI3C7L6BWLQxotC3+80MjIAClLqXQk4DZwYCpFFPdJu6sMXmWrlpKRm
   fuwWES+BS3iM02ccVkR9UF7gTwjWuRO4qALfou3W2Vx9jEfF6u+IGPmhO
   gbxdYjRGCJ8Yg2MtJ0FgRKfrFWgIov/TM3yAmsQjHhbvt465FJ+v9t7we
   w==;
X-CSE-ConnectionGUID: MUMs3qM3Sm664dw0Zc8mxw==
X-CSE-MsgGUID: n1i5re9WT8Gt6EIOTIU6Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60780559"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60780559"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 19:09:22 -0700
X-CSE-ConnectionGUID: sorZ0l60T5WHS+bcQyMbHQ==
X-CSE-MsgGUID: 2X2TVSbzRm+e8OQWXwzEVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="180632784"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Sep 2025 19:09:19 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0sSz-0002ef-06;
	Tue, 23 Sep 2025 02:09:17 +0000
Date: Tue, 23 Sep 2025 10:08:45 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: add direct I/O support for compressed data
Message-ID: <202509231206.6HNck2h0-lkp@intel.com>
References: <20250922124304.489419-1-guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922124304.489419-1-guochunhai@vivo.com>

Hi Chunhai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xiang-erofs/dev-test]
[also build test WARNING on xiang-erofs/dev xiang-erofs/fixes linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-add-direct-I-O-support-for-compressed-data/20250922-204843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250922124304.489419-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: add direct I/O support for compressed data
config: loongarch-randconfig-r072-20250923 (https://download.01.org/0day-ci/archive/20250923/202509231206.6HNck2h0-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231206.6HNck2h0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231206.6HNck2h0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/erofs/zdata.c:2069:6: warning: variable 'tmp_cnt' set but not used [-Wunused-but-set-variable]
    2069 |         int tmp_cnt = 0;
         |             ^
   1 warning generated.


vim +/tmp_cnt +2069 fs/erofs/zdata.c

  2056	
  2057	static ssize_t z_erofs_dio_read_iter(struct kiocb *iocb, struct iov_iter *iter)
  2058	{
  2059		struct inode *inode = file_inode(iocb->ki_filp);
  2060		Z_EROFS_DEFINE_FRONTEND(f, inode, iocb->ki_pos);
  2061		ssize_t err, off0;
  2062		loff_t offset = iocb->ki_pos;
  2063		unsigned int i = 0, total_pages, nr_pages = 0;
  2064		struct folio *head = NULL, *folio;
  2065		struct dio_erofs dio;
  2066		struct page **pages;
  2067		loff_t i_size;
  2068		struct iov_iter iter_saved = *iter;
> 2069		int tmp_cnt = 0;
  2070	
  2071		if (!iov_iter_count(iter))
  2072			return 0;
  2073	
  2074		i_size = i_size_read(inode);
  2075		if (offset >= i_size)
  2076			return 0;
  2077	
  2078		memset(&dio, 0, offsetof(struct dio_erofs, pages));
  2079		atomic_set(&dio.ref, 1);
  2080		dio.should_dirty = user_backed_iter(iter) && iov_iter_rw(iter) == READ;
  2081		dio.iocb = iocb;
  2082		dio.pos = ALIGN(min(iocb->ki_pos + (loff_t)iov_iter_count(iter),
  2083					i_size), PAGE_SIZE);
  2084		dio.is_pinned = iov_iter_extract_will_pin(iter);
  2085		dio.waiter = current;
  2086		f.dio = &dio;
  2087		iter_saved = *iter;
  2088		inode_dio_begin(inode);
  2089		pages = dio.pages;
  2090		total_pages = DIV_ROUND_UP(dio.pos - iocb->ki_pos, PAGE_SIZE);
  2091		for (; total_pages > 0; total_pages -= nr_pages) {
  2092			err = iov_iter_extract_pages(iter, &pages, LONG_MAX,
  2093					min(ARRAY_SIZE(dio.pages), total_pages), 0,
  2094					&off0);
  2095			if (err <= 0) {
  2096				err = -EFAULT;
  2097				goto fail_dio;
  2098			}
  2099			DBG_BUGON(off0);
  2100			iov_iter_revert(iter, err & ~PAGE_MASK);
  2101			nr_pages = DIV_ROUND_UP(err, PAGE_SIZE);
  2102			tmp_cnt += nr_pages;
  2103			for (i = 0; i < nr_pages; i++) {
  2104				folio = page_folio(pages[i]);
  2105				if (folio_test_large(folio) ||
  2106						folio_test_private(folio)) {
  2107					err = -EFAULT;
  2108					goto fail_dio;
  2109				}
  2110				folio->private = head;
  2111				head = folio;
  2112			}
  2113		}
  2114	
  2115		z_erofs_pcluster_readmore(&f, NULL, true);
  2116		while (head) {
  2117			folio = head;
  2118			head = folio_get_private(folio);
  2119			dio.pos -= folio_size(folio);
  2120			err = z_erofs_scan_folio(&f, folio, false);
  2121			if (err && err != -EINTR)
  2122				erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
  2123					  folio->index, EROFS_I(inode)->nid);
  2124		}
  2125		z_erofs_pcluster_end(&f);
  2126	
  2127		err = z_erofs_runqueue(&f, 0);
  2128		erofs_put_metabuf(&f.map.buf);
  2129		erofs_release_pages(&f.pagepool);
  2130	
  2131		if (!atomic_dec_and_test(&dio.ref)) {
  2132			for (;;) {
  2133				set_current_state(TASK_UNINTERRUPTIBLE);
  2134				if (!READ_ONCE(dio.waiter))
  2135					break;
  2136	
  2137				blk_io_schedule();
  2138			}
  2139			__set_current_state(TASK_RUNNING);
  2140		}
  2141	
  2142		err = err ?: dio.eio;
  2143		if (likely(!err)) {
  2144			err = dio.size;
  2145			if (offset + dio.size > i_size) /* check for short read */
  2146				err = i_size - offset;
  2147			iocb->ki_pos += err;
  2148		}
  2149		inode_dio_end(inode);
  2150		return err;
  2151	
  2152	fail_dio:
  2153		if (dio.is_pinned) {
  2154			while (head) {
  2155				folio = head;
  2156				head = folio_get_private(folio);
  2157				unpin_user_page(folio_page(folio, 0));
  2158			}
  2159			for (; i < nr_pages; i++)
  2160				unpin_user_page(dio.pages[i]);
  2161		}
  2162		*iter = iter_saved;
  2163		return err;
  2164	}
  2165	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

