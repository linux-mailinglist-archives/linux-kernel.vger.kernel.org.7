Return-Path: <linux-kernel+bounces-797269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21307B40E35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA8A5E2553
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FF135084E;
	Tue,  2 Sep 2025 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMZcEiVS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E63054D5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843068; cv=none; b=VK+AaWBN8O63OHzVzmI2brtDrKNCpCAkU2N2e0VIacMsUIzBLu5C/y17j6xe7MqJC0dfR1Uwp8SJQZPQ79qj1du1e56hcAKyFfSh/KYQMBsE7ISILY+4XgyEmcnDjxwJigvZt+s0TPJtr+aolsNWQlexmSPrnxKxVE+jTVZeh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843068; c=relaxed/simple;
	bh=GuDqHJsSdu8ChIWUwNjL0iNMkZ40CpT0PFK4K8JK8pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miQvl7v5zHCUWtu5QrjMeqMZoLt7l9G3WLEHzFze/vYfoBmIASMn0cLQibLHHtFscRSovPJLHrMnSABTACNe74ltdrIgWaOzgsEBtYlheGHW9ZUTbhJJPtugZpOE+ICgL9wwV+41qHlu3afGyNEgyjXZqJARDF+4c2dspQ8Ovy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMZcEiVS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756843067; x=1788379067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GuDqHJsSdu8ChIWUwNjL0iNMkZ40CpT0PFK4K8JK8pg=;
  b=VMZcEiVSSMldLcls6Fbcyf7PHhc5OJhwWcsWpygh4U8stCCAE1ZdwZw1
   EPCsVLkm1g4lGF2uaH0lFHV/x9mDhp3m2B0Ca/vR+BN7wLiKKjZsrsvhx
   ZmVeCW048T8ssjWeJ+C9fIsPuj13B1W3/Z6fL/ymnDjEjIhx1EdZ9Njx9
   ao9N9VhAxfmmaZJviRbK71bsGbZ2I7TjDIf6NxSIm9bWB9NacXDoISOml
   pmnIdoEo1hDOt4ICR/ZMVX3Eb0eTEK/qK02P2q8iB4AXlvZdsDm8Fagkz
   ysIjTDE4m7wfMdbtqEnJbbxGH04uG6e5KC9iEuTX4LDpRsv2hsOdJlz4h
   A==;
X-CSE-ConnectionGUID: +l5Ause9SMSemvUqUs2S7A==
X-CSE-MsgGUID: buuuK+HTTWy2NSASgSiBsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62967176"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62967176"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 12:57:46 -0700
X-CSE-ConnectionGUID: sI83OD8IT5mgZ4cJ7LSJFA==
X-CSE-MsgGUID: XfLLH7WjQMWAHr9i4Q21Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="170647120"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Sep 2025 12:57:45 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utX8Q-0002z5-03;
	Tue, 02 Sep 2025 19:57:42 +0000
Date: Wed, 3 Sep 2025 03:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: YangWen <anmuxixixi@gmail.com>, hirofumi@mail.parknet.co.jp
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	YangWen <anmuxixixi@gmail.com>
Subject: Re: [PATCH] fat: fix data-race between fat12_ent_put() and
 fat_mirror_bhs()
Message-ID: <202509030347.6cUT1zxe-lkp@intel.com>
References: <20250902081727.7146-1-anmuxixixi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902081727.7146-1-anmuxixixi@gmail.com>

Hi YangWen,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.17-rc4 next-20250902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/YangWen/fat-fix-data-race-between-fat12_ent_put-and-fat_mirror_bhs/20250902-162253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250902081727.7146-1-anmuxixixi%40gmail.com
patch subject: [PATCH] fat: fix data-race between fat12_ent_put() and fat_mirror_bhs()
config: csky-randconfig-002-20250903 (https://download.01.org/0day-ci/archive/20250903/202509030347.6cUT1zxe-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509030347.6cUT1zxe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509030347.6cUT1zxe-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/fat/fatent.c: In function 'fat_mirror_bhs':
>> fs/fat/fatent.c:382:25: error: called object 'is_fat12' is not a function or function pointer
     382 |         bool is_fat12 = is_fat12(sbi);
         |                         ^~~~~~~~
   fs/fat/fatent.c:382:14: note: declared here
     382 |         bool is_fat12 = is_fat12(sbi);
         |              ^~~~~~~~


vim +/is_fat12 +382 fs/fat/fatent.c

   374	
   375	/* FIXME: We can write the blocks as more big chunk. */
   376	static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
   377				  int nr_bhs)
   378	{
   379		struct msdos_sb_info *sbi = MSDOS_SB(sb);
   380		struct buffer_head *c_bh;
   381		int err, n, copy;
 > 382		bool is_fat12 = is_fat12(sbi);
   383	
   384		err = 0;
   385		for (copy = 1; copy < sbi->fats; copy++) {
   386			sector_t backup_fat = sbi->fat_length * copy;
   387	
   388			for (n = 0; n < nr_bhs; n++) {
   389				c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
   390				if (!c_bh) {
   391					err = -ENOMEM;
   392					goto error;
   393				}
   394				/* Avoid race with userspace read via bdev */
   395				lock_buffer(c_bh);
   396				/*
   397				 * For FAT12, protect memcpy() of the source sector
   398				 * against concurrent 12-bit entry updates in
   399				 * fat12_ent_put(), otherwise we may copy a torn
   400				 * pair of bytes into the mirror FAT.
   401				 */
   402				if (is_fat12)
   403					spin_lock(&fat12_entry_lock);
   404				memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
   405				if (is_fat12)
   406					spin_unlock(&fat12_entry_lock);
   407				set_buffer_uptodate(c_bh);
   408				unlock_buffer(c_bh);
   409				mark_buffer_dirty_inode(c_bh, sbi->fat_inode);
   410				if (sb->s_flags & SB_SYNCHRONOUS)
   411					err = sync_dirty_buffer(c_bh);
   412				brelse(c_bh);
   413				if (err)
   414					goto error;
   415			}
   416		}
   417	error:
   418		return err;
   419	}
   420	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

