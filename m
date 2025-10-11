Return-Path: <linux-kernel+bounces-848995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F8CBCEF9A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32CBA4E23A8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 04:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC3487BE;
	Sat, 11 Oct 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1nnR3xA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B25B663
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760155272; cv=none; b=OJ9/grn9atlKQIvJg8MLOUzRaMsimifi/F/hWe3elObYvEcehhlXiu7cEWNWdKQBsmynqYMgaxVMAO0ReJXqioEEUBBT1Lt3caPBc8ij28GDeoCEne+ablgZdMHdO7mFJ4I2xBFdG04hO1i14brRozHG6rm3PlaKgVdng1QXKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760155272; c=relaxed/simple;
	bh=LAWqyZh6RM8QY+k+7Vznz1/hpDEza9OmeHL4c2f30eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+A4QnzigAmJS/+WxA9qfTcSfN395TleckWp690NFaRh63TVaxhv7KM04CRlF4vBxweCo47n3Kcm6TXYsfDtvyl4dMbfc5pvZZgz/ciKsqZuxTMn1pa9nDVMYhdjH5qc0+I+0DxnS5NxXanizSxZ6oIiUqj6H+jMqpn9riQJjpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1nnR3xA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760155271; x=1791691271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAWqyZh6RM8QY+k+7Vznz1/hpDEza9OmeHL4c2f30eI=;
  b=Q1nnR3xAJcxcRXnsM1S+gBYYvDV4UASsKT9fgxhcklrVUmB8ZBCYsmOM
   Dl78EJl6SqGN3w/cOHgw223/AUgLALkxv18WahvpW+ziSqngmFBlPr7pV
   /WD3rBt3NqZqE8IJnNKWSJ9Qnn3ocZbDF4is198EdbpD1C8CQKAx0hEmF
   1VGO8ITs4DYDbgfjLyyeBv2USSzngqgAvUoHMa8XhgCSRGpZP9ziI3qUR
   y9XPrsRfdCGAo2hc0rixjPAofxbGxpW4vdRqcXlJsSKrErc5bLaDzGSTk
   /8y5h/3MfKKVctExRwIfy9O4+Vh4q8KpWQjWRTmjvfU/ukQC5lYEAX+1H
   g==;
X-CSE-ConnectionGUID: xGiJpulITcGbShEB3LxXow==
X-CSE-MsgGUID: EW3CW/JNSBOuPQiVWGNqbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62413670"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62413670"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 21:01:10 -0700
X-CSE-ConnectionGUID: 4/hOoYOkRbiH6Nc5ln8nTw==
X-CSE-MsgGUID: MBRpolQIQk22GzppLy2fsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="185501395"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Oct 2025 21:01:07 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7Qn3-0003VX-0y;
	Sat, 11 Oct 2025 04:01:05 +0000
Date: Sat, 11 Oct 2025 12:00:49 +0800
From: kernel test robot <lkp@intel.com>
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: oe-kbuild-all@lists.linux.dev, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs: revert summary entry count from 2048 to 512 in
 16kb block support
Message-ID: <202510111151.zDEs4Y0k-lkp@intel.com>
References: <20251007180819.3858285-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007180819.3858285-1-daeho43@gmail.com>

Hi Daeho,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.17]
[cannot apply to jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev linus/master next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daeho-Jeong/f2fs-revert-summary-entry-count-from-2048-to-512-in-16kb-block-support/20251010-093707
base:   v6.17
patch link:    https://lore.kernel.org/r/20251007180819.3858285-1-daeho43%40gmail.com
patch subject: [PATCH] f2fs: revert summary entry count from 2048 to 512 in 16kb block support
config: arc-randconfig-002-20251011 (https://download.01.org/0day-ci/archive/20251011/202510111151.zDEs4Y0k-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111151.zDEs4Y0k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111151.zDEs4Y0k-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/f2fs/gc.c: In function 'do_garbage_collect':
>> fs/f2fs/gc.c:1861:1: error: label at end of compound statement
    1861 | skip:
         | ^~~~


vim +1861 fs/f2fs/gc.c

7bc0900347e069 Jaegeuk Kim             2012-11-02  1718  
718e53fa633f84 Chao Yu                 2016-01-23  1719  static int do_garbage_collect(struct f2fs_sb_info *sbi,
718e53fa633f84 Chao Yu                 2016-01-23  1720  				unsigned int start_segno,
7dede88659df38 Chao Yu                 2021-02-20  1721  				struct gc_inode_list *gc_list, int gc_type,
9748c2ddea4a3f Daeho Jeong             2024-09-09  1722  				bool force_migrate, bool one_time)
7bc0900347e069 Jaegeuk Kim             2012-11-02  1723  {
c718379b6b0954 Jaegeuk Kim             2013-04-24  1724  	struct blk_plug plug;
718e53fa633f84 Chao Yu                 2016-01-23  1725  	unsigned int segno = start_segno;
a60108f7dfb586 Jaegeuk Kim             2024-02-06  1726  	unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
8c890c4c603427 Daeho Jeong             2024-09-09  1727  	unsigned int sec_end_segno;
e3080b0120a15e Chao Yu                 2018-10-24  1728  	int seg_freed = 0, migrated = 0;
718e53fa633f84 Chao Yu                 2016-01-23  1729  	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
718e53fa633f84 Chao Yu                 2016-01-23  1730  						SUM_TYPE_DATA : SUM_TYPE_NODE;
9bf1dcbdfdc889 Chao Yu                 2023-08-08  1731  	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
2e154d8454d8bc Daeho Jeong             2025-10-07  1732  	int submitted = 0, sum_blk_cnt;
7bc0900347e069 Jaegeuk Kim             2012-11-02  1733  
8c890c4c603427 Daeho Jeong             2024-09-09  1734  	if (__is_large_section(sbi)) {
8c890c4c603427 Daeho Jeong             2024-09-09  1735  		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
e3080b0120a15e Chao Yu                 2018-10-24  1736  
de881df97768d0 Aravind Ramesh          2020-07-16  1737  		/*
de881df97768d0 Aravind Ramesh          2020-07-16  1738  		 * zone-capacity can be less than zone-size in zoned devices,
de881df97768d0 Aravind Ramesh          2020-07-16  1739  		 * resulting in less than expected usable segments in the zone,
8c890c4c603427 Daeho Jeong             2024-09-09  1740  		 * calculate the end segno in the zone which can be garbage
8c890c4c603427 Daeho Jeong             2024-09-09  1741  		 * collected
de881df97768d0 Aravind Ramesh          2020-07-16  1742  		 */
de881df97768d0 Aravind Ramesh          2020-07-16  1743  		if (f2fs_sb_has_blkzoned(sbi))
8c890c4c603427 Daeho Jeong             2024-09-09  1744  			sec_end_segno -= SEGS_PER_SEC(sbi) -
2af583afcf9d54 liuderong               2024-09-11  1745  					f2fs_usable_segs_in_sec(sbi);
de881df97768d0 Aravind Ramesh          2020-07-16  1746  
9748c2ddea4a3f Daeho Jeong             2024-09-09  1747  		if (gc_type == BG_GC || one_time) {
2223fe652f7596 Daeho Jeong             2024-09-09  1748  			unsigned int window_granularity =
8c890c4c603427 Daeho Jeong             2024-09-09  1749  				sbi->migration_window_granularity;
8c890c4c603427 Daeho Jeong             2024-09-09  1750  
2223fe652f7596 Daeho Jeong             2024-09-09  1751  			if (f2fs_sb_has_blkzoned(sbi) &&
2223fe652f7596 Daeho Jeong             2024-09-09  1752  					!has_enough_free_blocks(sbi,
9a481a1c16f465 Daeho Jeong             2024-09-09  1753  					sbi->gc_thread->boost_zoned_gc_percent))
9a481a1c16f465 Daeho Jeong             2024-09-09  1754  				window_granularity *=
1d4c5dbba1a53a Daeho Jeong             2025-07-28  1755  					sbi->gc_thread->boost_gc_multiple;
2223fe652f7596 Daeho Jeong             2024-09-09  1756  
2223fe652f7596 Daeho Jeong             2024-09-09  1757  			end_segno = start_segno + window_granularity;
2223fe652f7596 Daeho Jeong             2024-09-09  1758  		}
2223fe652f7596 Daeho Jeong             2024-09-09  1759  
8c890c4c603427 Daeho Jeong             2024-09-09  1760  		if (end_segno > sec_end_segno)
8c890c4c603427 Daeho Jeong             2024-09-09  1761  			end_segno = sec_end_segno;
8c890c4c603427 Daeho Jeong             2024-09-09  1762  	}
8c890c4c603427 Daeho Jeong             2024-09-09  1763  
093749e296e29a Chao Yu                 2020-08-04  1764  	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
093749e296e29a Chao Yu                 2020-08-04  1765  
2e154d8454d8bc Daeho Jeong             2025-10-07  1766  	segno = rounddown(segno, SUMS_PER_BLOCK);
2e154d8454d8bc Daeho Jeong             2025-10-07  1767  	sum_blk_cnt = (end_segno - segno + SUMS_PER_BLOCK - 1) / SUMS_PER_BLOCK;
718e53fa633f84 Chao Yu                 2016-01-23  1768  	/* readahead multi ssa blocks those have contiguous address */
2c70c5e3874e8c Chao Yu                 2018-10-24  1769  	if (__is_large_section(sbi))
4d57b86dd86404 Chao Yu                 2018-05-30  1770  		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
2e154d8454d8bc Daeho Jeong             2025-10-07  1771  					sum_blk_cnt, META_SSA, true);
718e53fa633f84 Chao Yu                 2016-01-23  1772  
718e53fa633f84 Chao Yu                 2016-01-23  1773  	/* reference all summary page */
718e53fa633f84 Chao Yu                 2016-01-23  1774  	while (segno < end_segno) {
2e154d8454d8bc Daeho Jeong             2025-10-07  1775  		struct folio *sum_folio = f2fs_get_sum_folio(sbi, segno);
2e154d8454d8bc Daeho Jeong             2025-10-07  1776  
2e154d8454d8bc Daeho Jeong             2025-10-07  1777  		segno += SUMS_PER_BLOCK;
5d895f7beae94f Matthew Wilcox (Oracle  2025-03-31  1778) 		if (IS_ERR(sum_folio)) {
5d895f7beae94f Matthew Wilcox (Oracle  2025-03-31  1779) 			int err = PTR_ERR(sum_folio);
edc55aaf0d1712 Jaegeuk Kim             2018-09-17  1780  
2e154d8454d8bc Daeho Jeong             2025-10-07  1781  			end_segno = segno - SUMS_PER_BLOCK;
2e154d8454d8bc Daeho Jeong             2025-10-07  1782  			segno = rounddown(start_segno, SUMS_PER_BLOCK);
2e154d8454d8bc Daeho Jeong             2025-10-07  1783  			while (segno < end_segno) {
5d895f7beae94f Matthew Wilcox (Oracle  2025-03-31  1784) 				sum_folio = filemap_get_folio(META_MAPPING(sbi),
edc55aaf0d1712 Jaegeuk Kim             2018-09-17  1785  						GET_SUM_BLOCK(sbi, segno));
5d895f7beae94f Matthew Wilcox (Oracle  2025-03-31  1786) 				folio_put_refs(sum_folio, 2);
2e154d8454d8bc Daeho Jeong             2025-10-07  1787  				segno += SUMS_PER_BLOCK;
edc55aaf0d1712 Jaegeuk Kim             2018-09-17  1788  			}
edc55aaf0d1712 Jaegeuk Kim             2018-09-17  1789  			return err;
edc55aaf0d1712 Jaegeuk Kim             2018-09-17  1790  		}
5d895f7beae94f Matthew Wilcox (Oracle  2025-03-31  1791) 		folio_unlock(sum_folio);
718e53fa633f84 Chao Yu                 2016-01-23  1792  	}
7bc0900347e069 Jaegeuk Kim             2012-11-02  1793  
c718379b6b0954 Jaegeuk Kim             2013-04-24  1794  	blk_start_plug(&plug);
c718379b6b0954 Jaegeuk Kim             2013-04-24  1795  
2e154d8454d8bc Daeho Jeong             2025-10-07  1796  	segno = start_segno;
2e154d8454d8bc Daeho Jeong             2025-10-07  1797  	while (segno < end_segno) {
2e154d8454d8bc Daeho Jeong             2025-10-07  1798  		unsigned int cur_segno;
718e53fa633f84 Chao Yu                 2016-01-23  1799  		/* find segment summary of victim */
5d895f7beae94f Matthew Wilcox (Oracle  2025-03-31  1800) 		struct folio *sum_folio = filemap_get_folio(META_MAPPING(sbi),
718e53fa633f84 Chao Yu                 2016-01-23  1801  					GET_SUM_BLOCK(sbi, segno));
2e154d8454d8bc Daeho Jeong             2025-10-07  1802  		unsigned int block_end_segno = rounddown(segno, SUMS_PER_BLOCK)
2e154d8454d8bc Daeho Jeong             2025-10-07  1803  						+ SUMS_PER_BLOCK;
2e154d8454d8bc Daeho Jeong             2025-10-07  1804  
2e154d8454d8bc Daeho Jeong             2025-10-07  1805  		if (block_end_segno > end_segno)
2e154d8454d8bc Daeho Jeong             2025-10-07  1806  			block_end_segno = end_segno;
2e154d8454d8bc Daeho Jeong             2025-10-07  1807  
2e154d8454d8bc Daeho Jeong             2025-10-07  1808  		if (!folio_test_uptodate(sum_folio) ||
2e154d8454d8bc Daeho Jeong             2025-10-07  1809  		    unlikely(f2fs_cp_error(sbi)))
2e154d8454d8bc Daeho Jeong             2025-10-07  1810  			goto next_block;
2e154d8454d8bc Daeho Jeong             2025-10-07  1811  
2e154d8454d8bc Daeho Jeong             2025-10-07  1812  		for (cur_segno = segno; cur_segno < block_end_segno;
2e154d8454d8bc Daeho Jeong             2025-10-07  1813  				cur_segno++) {
2e154d8454d8bc Daeho Jeong             2025-10-07  1814  			struct f2fs_summary_block *sum;
718e53fa633f84 Chao Yu                 2016-01-23  1815  
2e154d8454d8bc Daeho Jeong             2025-10-07  1816  			if (get_valid_blocks(sbi, cur_segno, false) == 0)
d6c66cd19ef322 Yunlong Song            2018-10-24  1817  				goto freed;
dabfbbc8f91450 Jaegeuk Kim             2020-02-09  1818  			if (gc_type == BG_GC && __is_large_section(sbi) &&
e3080b0120a15e Chao Yu                 2018-10-24  1819  					migrated >= sbi->migration_granularity)
e3080b0120a15e Chao Yu                 2018-10-24  1820  				goto skip;
de0dcc40f6e24d Jaegeuk Kim             2016-10-12  1821  
2e154d8454d8bc Daeho Jeong             2025-10-07  1822  			sum = SUM_BLK_PAGE_ADDR(sum_folio, cur_segno);
10d255c3540239 Chao Yu                 2018-07-04  1823  			if (type != GET_SUM_TYPE((&sum->footer))) {
2e154d8454d8bc Daeho Jeong             2025-10-07  1824  				f2fs_err(sbi, "Inconsistent segment (%u) type "
2e154d8454d8bc Daeho Jeong             2025-10-07  1825  						"[%d, %d] in SSA and SIT",
2e154d8454d8bc Daeho Jeong             2025-10-07  1826  						cur_segno, type,
2e154d8454d8bc Daeho Jeong             2025-10-07  1827  						GET_SUM_TYPE((&sum->footer)));
a9cfee0ef98e99 Chao Yu                 2022-09-28  1828  				f2fs_stop_checkpoint(sbi, false,
a9cfee0ef98e99 Chao Yu                 2022-09-28  1829  					STOP_CP_REASON_CORRUPTED_SUMMARY);
e3080b0120a15e Chao Yu                 2018-10-24  1830  				goto skip;
10d255c3540239 Chao Yu                 2018-07-04  1831  			}
7bc0900347e069 Jaegeuk Kim             2012-11-02  1832  
9236cac5666ea8 Jaegeuk Kim             2015-05-28  1833  			/*
9236cac5666ea8 Jaegeuk Kim             2015-05-28  1834  			 * this is to avoid deadlock:
9236cac5666ea8 Jaegeuk Kim             2015-05-28  1835  			 * - lock_page(sum_page)     - f2fs_replace_block
3d26fa6be3c487 Chao Yu                 2017-10-30  1836  			 *  - check_valid_map()        - down_write(sentry_lock)
3d26fa6be3c487 Chao Yu                 2017-10-30  1837  			 *   - down_read(sentry_lock) - change_curseg()
9236cac5666ea8 Jaegeuk Kim             2015-05-28  1838  			 *                              - lock_page(sum_page)
9236cac5666ea8 Jaegeuk Kim             2015-05-28  1839  			 */
718e53fa633f84 Chao Yu                 2016-01-23  1840  			if (type == SUM_TYPE_NODE)
2e154d8454d8bc Daeho Jeong             2025-10-07  1841  				submitted += gc_node_segment(sbi, sum->entries,
2e154d8454d8bc Daeho Jeong             2025-10-07  1842  						cur_segno, gc_type);
48018b4cfd07dd Chao Yu                 2018-09-13  1843  			else
2e154d8454d8bc Daeho Jeong             2025-10-07  1844  				submitted += gc_data_segment(sbi, sum->entries,
2e154d8454d8bc Daeho Jeong             2025-10-07  1845  						gc_list, cur_segno,
2e154d8454d8bc Daeho Jeong             2025-10-07  1846  						gc_type, force_migrate);
c718379b6b0954 Jaegeuk Kim             2013-04-24  1847  
9bf1dcbdfdc889 Chao Yu                 2023-08-08  1848  			stat_inc_gc_seg_count(sbi, data_type, gc_type);
07c6b5933ebf58 Daeho Jeong             2021-07-09  1849  			sbi->gc_reclaimed_segs[sbi->gc_mode]++;
8c7b9ac129d096 Jaegeuk Kim             2020-02-09  1850  			migrated++;
c56f16dab0dfc8 Chao Yu                 2017-08-11  1851  
d6c66cd19ef322 Yunlong Song            2018-10-24  1852  freed:
c56f16dab0dfc8 Chao Yu                 2017-08-11  1853  			if (gc_type == FG_GC &&
2e154d8454d8bc Daeho Jeong             2025-10-07  1854  				get_valid_blocks(sbi, cur_segno, false) == 0)
c56f16dab0dfc8 Chao Yu                 2017-08-11  1855  				seg_freed++;
e3080b0120a15e Chao Yu                 2018-10-24  1856  
e219aecfd4b766 Yonggil Song            2022-11-22  1857  			if (__is_large_section(sbi))
e219aecfd4b766 Yonggil Song            2022-11-22  1858  				sbi->next_victim_seg[gc_type] =
2e154d8454d8bc Daeho Jeong             2025-10-07  1859  					(cur_segno + 1 < sec_end_segno) ?
2e154d8454d8bc Daeho Jeong             2025-10-07  1860  						cur_segno + 1 : NULL_SEGNO;
e3080b0120a15e Chao Yu                 2018-10-24 @1861  skip:
2e154d8454d8bc Daeho Jeong             2025-10-07  1862  		}
2e154d8454d8bc Daeho Jeong             2025-10-07  1863  next_block:
5d895f7beae94f Matthew Wilcox (Oracle  2025-03-31  1864) 		folio_put_refs(sum_folio, 2);
2e154d8454d8bc Daeho Jeong             2025-10-07  1865  		segno = block_end_segno;
718e53fa633f84 Chao Yu                 2016-01-23  1866  	}
718e53fa633f84 Chao Yu                 2016-01-23  1867  
48018b4cfd07dd Chao Yu                 2018-09-13  1868  	if (submitted)
9bf1dcbdfdc889 Chao Yu                 2023-08-08  1869  		f2fs_submit_merged_write(sbi, data_type);
718e53fa633f84 Chao Yu                 2016-01-23  1870  
718e53fa633f84 Chao Yu                 2016-01-23  1871  	blk_finish_plug(&plug);
718e53fa633f84 Chao Yu                 2016-01-23  1872  
9bf1dcbdfdc889 Chao Yu                 2023-08-08  1873  	if (migrated)
9bf1dcbdfdc889 Chao Yu                 2023-08-08  1874  		stat_inc_gc_sec_count(sbi, data_type, gc_type);
17d899df4678a1 Chao Yu                 2016-02-22  1875  
c56f16dab0dfc8 Chao Yu                 2017-08-11  1876  	return seg_freed;
7bc0900347e069 Jaegeuk Kim             2012-11-02  1877  }
7bc0900347e069 Jaegeuk Kim             2012-11-02  1878  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

