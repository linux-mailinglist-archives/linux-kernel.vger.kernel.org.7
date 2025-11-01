Return-Path: <linux-kernel+bounces-881576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C43C287C2
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 21:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53E0B4E341C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 20:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A422FC874;
	Sat,  1 Nov 2025 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITqIffq2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60325EFBE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762028846; cv=none; b=lKfUSLg+FyPHoRwN/iEfhA6/yLBRmziVj6tKm8oP1orrVzviN0DoS/UpVaKxqW/WKLtZ+WgF4aTGSaGCjcA4OVLD2Qqtmcx57hxNuBGtJiN8VWoFxrNJpafb+aqAtL+5oEZEuTdONsUL2ew1gLXAJj9Q9e7KDProeCBXVIxDAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762028846; c=relaxed/simple;
	bh=6aVeH/rTG4HOmS+cTJSOypdXBhW0yIojB7FcYCG22rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS2I7CtRqaWLhuvZEy2B2QvfOkVPah0rSAhZhkaZOIbANYTdBbnkjxxXG+r6YRrdoeRdWNJhWpmrcwLDHd+2bNFNOPvhVOwNndMfLXh9/k4QeD+ZXP7369Uq2t84WfbYo0VaMBTqUliFX/14GYFHCUTf+BgT3AeUkuXqXfqTBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITqIffq2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762028843; x=1793564843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6aVeH/rTG4HOmS+cTJSOypdXBhW0yIojB7FcYCG22rA=;
  b=ITqIffq24PR96Tqyu6/c+K0hiomhbtwWXlSW1l+lZpg64rYWcee7ib5b
   hsAZDQS0eqWjkJCQ5HjROXS2woy6CtsIJ+MXXSWApCeBq+SX8NgiFqhoN
   T9RqutR2suDQFEVP5U8+KsgzFvWCRtouy+kitAgU06FHmwUGqMaNmjX/0
   qFk35rvA3hNOWFI4k5908aJLvnFAG66Cs1vua7onKSi61nArqMPvqc7dN
   oboAy9f9hbYWWfjRY4Vyy8vrbNaBBcz5WUSmCbNK4CldRIoXWSAz9FnS3
   /ddCL1QGElDcBJuAeM8DUqn9Fbag5Qc5vbANFgpWIG2OxKVKeZD3BBM40
   w==;
X-CSE-ConnectionGUID: 9eJ8Ov2hRHKMVqWNr+HOAQ==
X-CSE-MsgGUID: Y40Z3jh0RgelRBcglayxQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64065444"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64065444"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 13:27:23 -0700
X-CSE-ConnectionGUID: ajmX241sTKiWe/VHbwKosg==
X-CSE-MsgGUID: CZm8ERT7Ry2qNsRTUk06ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="217356608"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 01 Nov 2025 13:27:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFIBy-000OfI-1M;
	Sat, 01 Nov 2025 20:27:18 +0000
Date: Sun, 2 Nov 2025 04:27:11 +0800
From: kernel test robot <lkp@intel.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>,
	Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Cc: oe-kbuild-all@lists.linux.dev, jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Message-ID: <202511020315.RrrqmaRR-lkp@intel.com>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028205857.386719-1-jkoolstra@xs4all.nl>

Hi Jori,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jori-Koolstra/Add-error-handling-to-minix-filesystem-similar-to-ext4/20251029-050224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251028205857.386719-1-jkoolstra%40xs4all.nl
patch subject: [PATCH] Add error handling to minix filesystem similar to ext4
config: x86_64-randconfig-161-20251101 (https://download.01.org/0day-ci/archive/20251102/202511020315.RrrqmaRR-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511020315.RrrqmaRR-lkp@intel.com/

smatch warnings:
fs/minix/inode.c:342 minix_fill_super() warn: inconsistent indenting

vim +342 fs/minix/inode.c

270ef41094e9fa Eric Biggers       2020-08-11  282  
7cd7bfe5932874 Bill O'Donnell     2024-03-07  283  static int minix_fill_super(struct super_block *s, struct fs_context *fc)
^1da177e4c3f41 Linus Torvalds     2005-04-16  284  {
e54e25638fc1ea Jori Koolstra      2025-10-28  285  	struct minix_fs_context *ctx = fc->fs_private;
^1da177e4c3f41 Linus Torvalds     2005-04-16  286  	struct buffer_head *bh;
^1da177e4c3f41 Linus Torvalds     2005-04-16  287  	struct buffer_head **map;
^1da177e4c3f41 Linus Torvalds     2005-04-16  288  	struct minix_super_block *ms;
939b00df0306bc Andries Brouwer    2007-02-12  289  	struct minix3_super_block *m3s = NULL;
939b00df0306bc Andries Brouwer    2007-02-12  290  	unsigned long i, block;
^1da177e4c3f41 Linus Torvalds     2005-04-16  291  	struct inode *root_inode;
^1da177e4c3f41 Linus Torvalds     2005-04-16  292  	struct minix_sb_info *sbi;
a90a088021f8f1 David Howells      2008-02-07  293  	int ret = -EINVAL;
7cd7bfe5932874 Bill O'Donnell     2024-03-07  294  	int silent = fc->sb_flags & SB_SILENT;
^1da177e4c3f41 Linus Torvalds     2005-04-16  295  
f8314dc60ccba7 Panagiotis Issaris 2006-09-27  296  	sbi = kzalloc(sizeof(struct minix_sb_info), GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds     2005-04-16  297  	if (!sbi)
^1da177e4c3f41 Linus Torvalds     2005-04-16  298  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds     2005-04-16  299  	s->s_fs_info = sbi;
^1da177e4c3f41 Linus Torvalds     2005-04-16  300  
2ecd05ae68a903 Alexey Dobriyan    2006-10-11  301  	BUILD_BUG_ON(32 != sizeof (struct minix_inode));
2ecd05ae68a903 Alexey Dobriyan    2006-10-11  302  	BUILD_BUG_ON(64 != sizeof(struct minix2_inode));
^1da177e4c3f41 Linus Torvalds     2005-04-16  303  
^1da177e4c3f41 Linus Torvalds     2005-04-16  304  	if (!sb_set_blocksize(s, BLOCK_SIZE))
^1da177e4c3f41 Linus Torvalds     2005-04-16  305  		goto out_bad_hblock;
^1da177e4c3f41 Linus Torvalds     2005-04-16  306  
^1da177e4c3f41 Linus Torvalds     2005-04-16  307  	if (!(bh = sb_bread(s, 1)))
^1da177e4c3f41 Linus Torvalds     2005-04-16  308  		goto out_bad_sb;
^1da177e4c3f41 Linus Torvalds     2005-04-16  309  
^1da177e4c3f41 Linus Torvalds     2005-04-16  310  	ms = (struct minix_super_block *) bh->b_data;
^1da177e4c3f41 Linus Torvalds     2005-04-16  311  	sbi->s_ms = ms;
e54e25638fc1ea Jori Koolstra      2025-10-28  312  	sbi->s_mount_opt = ctx->s_mount_opt;
e54e25638fc1ea Jori Koolstra      2025-10-28  313  	sbi->s_def_mount_opt = ctx->s_def_mount_opt;
^1da177e4c3f41 Linus Torvalds     2005-04-16  314  	sbi->s_sbh = bh;
^1da177e4c3f41 Linus Torvalds     2005-04-16  315  	sbi->s_mount_state = ms->s_state;
^1da177e4c3f41 Linus Torvalds     2005-04-16  316  	sbi->s_ninodes = ms->s_ninodes;
^1da177e4c3f41 Linus Torvalds     2005-04-16  317  	sbi->s_nzones = ms->s_nzones;
^1da177e4c3f41 Linus Torvalds     2005-04-16  318  	sbi->s_imap_blocks = ms->s_imap_blocks;
^1da177e4c3f41 Linus Torvalds     2005-04-16  319  	sbi->s_zmap_blocks = ms->s_zmap_blocks;
^1da177e4c3f41 Linus Torvalds     2005-04-16  320  	sbi->s_firstdatazone = ms->s_firstdatazone;
^1da177e4c3f41 Linus Torvalds     2005-04-16  321  	sbi->s_log_zone_size = ms->s_log_zone_size;
32ac86efff91a3 Eric Biggers       2020-08-11  322  	s->s_maxbytes = ms->s_max_size;
^1da177e4c3f41 Linus Torvalds     2005-04-16  323  	s->s_magic = ms->s_magic;
^1da177e4c3f41 Linus Torvalds     2005-04-16  324  	if (s->s_magic == MINIX_SUPER_MAGIC) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  325  		sbi->s_version = MINIX_V1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  326  		sbi->s_dirsize = 16;
^1da177e4c3f41 Linus Torvalds     2005-04-16  327  		sbi->s_namelen = 14;
8de52778798fe3 Al Viro            2012-02-06  328  		s->s_max_links = MINIX_LINK_MAX;
^1da177e4c3f41 Linus Torvalds     2005-04-16  329  	} else if (s->s_magic == MINIX_SUPER_MAGIC2) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  330  		sbi->s_version = MINIX_V1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  331  		sbi->s_dirsize = 32;
^1da177e4c3f41 Linus Torvalds     2005-04-16  332  		sbi->s_namelen = 30;
8de52778798fe3 Al Viro            2012-02-06  333  		s->s_max_links = MINIX_LINK_MAX;
^1da177e4c3f41 Linus Torvalds     2005-04-16  334  	} else if (s->s_magic == MINIX2_SUPER_MAGIC) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  335  		sbi->s_version = MINIX_V2;
^1da177e4c3f41 Linus Torvalds     2005-04-16  336  		sbi->s_nzones = ms->s_zones;
^1da177e4c3f41 Linus Torvalds     2005-04-16  337  		sbi->s_dirsize = 16;
^1da177e4c3f41 Linus Torvalds     2005-04-16  338  		sbi->s_namelen = 14;
8de52778798fe3 Al Viro            2012-02-06  339  		s->s_max_links = MINIX2_LINK_MAX;
^1da177e4c3f41 Linus Torvalds     2005-04-16  340  	} else if (s->s_magic == MINIX2_SUPER_MAGIC2) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  341  		sbi->s_version = MINIX_V2;
^1da177e4c3f41 Linus Torvalds     2005-04-16 @342  	sbi->s_nzones = ms->s_zones;
^1da177e4c3f41 Linus Torvalds     2005-04-16  343  		sbi->s_dirsize = 32;
^1da177e4c3f41 Linus Torvalds     2005-04-16  344  		sbi->s_namelen = 30;
8de52778798fe3 Al Viro            2012-02-06  345  		s->s_max_links = MINIX2_LINK_MAX;
939b00df0306bc Andries Brouwer    2007-02-12  346  	} else if ( *(__u16 *)(bh->b_data + 24) == MINIX3_SUPER_MAGIC) {
939b00df0306bc Andries Brouwer    2007-02-12  347  		m3s = (struct minix3_super_block *) bh->b_data;
939b00df0306bc Andries Brouwer    2007-02-12  348  		s->s_magic = m3s->s_magic;
939b00df0306bc Andries Brouwer    2007-02-12  349  		sbi->s_imap_blocks = m3s->s_imap_blocks;
939b00df0306bc Andries Brouwer    2007-02-12  350  		sbi->s_zmap_blocks = m3s->s_zmap_blocks;
939b00df0306bc Andries Brouwer    2007-02-12  351  		sbi->s_firstdatazone = m3s->s_firstdatazone;
939b00df0306bc Andries Brouwer    2007-02-12  352  		sbi->s_log_zone_size = m3s->s_log_zone_size;
32ac86efff91a3 Eric Biggers       2020-08-11  353  		s->s_maxbytes = m3s->s_max_size;
939b00df0306bc Andries Brouwer    2007-02-12  354  		sbi->s_ninodes = m3s->s_ninodes;
939b00df0306bc Andries Brouwer    2007-02-12  355  		sbi->s_nzones = m3s->s_zones;
939b00df0306bc Andries Brouwer    2007-02-12  356  		sbi->s_dirsize = 64;
939b00df0306bc Andries Brouwer    2007-02-12  357  		sbi->s_namelen = 60;
939b00df0306bc Andries Brouwer    2007-02-12  358  		sbi->s_version = MINIX_V3;
939b00df0306bc Andries Brouwer    2007-02-12  359  		sbi->s_mount_state = MINIX_VALID_FS;
939b00df0306bc Andries Brouwer    2007-02-12  360  		sb_set_blocksize(s, m3s->s_blocksize);
8de52778798fe3 Al Viro            2012-02-06  361  		s->s_max_links = MINIX2_LINK_MAX;
^1da177e4c3f41 Linus Torvalds     2005-04-16  362  	} else
^1da177e4c3f41 Linus Torvalds     2005-04-16  363  		goto out_no_fs;
^1da177e4c3f41 Linus Torvalds     2005-04-16  364  
32ac86efff91a3 Eric Biggers       2020-08-11  365  	if (!minix_check_superblock(s))
270ef41094e9fa Eric Biggers       2020-08-11  366  		goto out_illegal_sb;
270ef41094e9fa Eric Biggers       2020-08-11  367  
^1da177e4c3f41 Linus Torvalds     2005-04-16  368  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  369  	 * Allocate the buffer map to keep the superblock small.
^1da177e4c3f41 Linus Torvalds     2005-04-16  370  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  371  	i = (sbi->s_imap_blocks + sbi->s_zmap_blocks) * sizeof(bh);
f8314dc60ccba7 Panagiotis Issaris 2006-09-27  372  	map = kzalloc(i, GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds     2005-04-16  373  	if (!map)
^1da177e4c3f41 Linus Torvalds     2005-04-16  374  		goto out_no_map;
^1da177e4c3f41 Linus Torvalds     2005-04-16  375  	sbi->s_imap = &map[0];
^1da177e4c3f41 Linus Torvalds     2005-04-16  376  	sbi->s_zmap = &map[sbi->s_imap_blocks];
^1da177e4c3f41 Linus Torvalds     2005-04-16  377  
^1da177e4c3f41 Linus Torvalds     2005-04-16  378  	block=2;
^1da177e4c3f41 Linus Torvalds     2005-04-16  379  	for (i=0 ; i < sbi->s_imap_blocks ; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  380  		if (!(sbi->s_imap[i]=sb_bread(s, block)))
^1da177e4c3f41 Linus Torvalds     2005-04-16  381  			goto out_no_bitmap;
^1da177e4c3f41 Linus Torvalds     2005-04-16  382  		block++;
^1da177e4c3f41 Linus Torvalds     2005-04-16  383  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  384  	for (i=0 ; i < sbi->s_zmap_blocks ; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  385  		if (!(sbi->s_zmap[i]=sb_bread(s, block)))
^1da177e4c3f41 Linus Torvalds     2005-04-16  386  			goto out_no_bitmap;
^1da177e4c3f41 Linus Torvalds     2005-04-16  387  		block++;
^1da177e4c3f41 Linus Torvalds     2005-04-16  388  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  389  
^1da177e4c3f41 Linus Torvalds     2005-04-16  390  	minix_set_bit(0,sbi->s_imap[0]->b_data);
^1da177e4c3f41 Linus Torvalds     2005-04-16  391  	minix_set_bit(0,sbi->s_zmap[0]->b_data);
^1da177e4c3f41 Linus Torvalds     2005-04-16  392  
016e8d44bc06dd Josh Boyer         2011-08-19  393  	/* Apparently minix can create filesystems that allocate more blocks for
016e8d44bc06dd Josh Boyer         2011-08-19  394  	 * the bitmaps than needed.  We simply ignore that, but verify it didn't
016e8d44bc06dd Josh Boyer         2011-08-19  395  	 * create one with not enough blocks and bail out if so.
016e8d44bc06dd Josh Boyer         2011-08-19  396  	 */
016e8d44bc06dd Josh Boyer         2011-08-19  397  	block = minix_blocks_needed(sbi->s_ninodes, s->s_blocksize);
016e8d44bc06dd Josh Boyer         2011-08-19  398  	if (sbi->s_imap_blocks < block) {
016e8d44bc06dd Josh Boyer         2011-08-19  399  		printk("MINIX-fs: file system does not have enough "
6d6747f8531468 Qi Yong            2014-08-08  400  				"imap blocks allocated.  Refusing to mount.\n");
ca85c07809ca19 Al Viro            2012-02-12  401  		goto out_no_bitmap;
016e8d44bc06dd Josh Boyer         2011-08-19  402  	}
016e8d44bc06dd Josh Boyer         2011-08-19  403  
016e8d44bc06dd Josh Boyer         2011-08-19  404  	block = minix_blocks_needed(
6d6747f8531468 Qi Yong            2014-08-08  405  			(sbi->s_nzones - sbi->s_firstdatazone + 1),
016e8d44bc06dd Josh Boyer         2011-08-19  406  			s->s_blocksize);
016e8d44bc06dd Josh Boyer         2011-08-19  407  	if (sbi->s_zmap_blocks < block) {
016e8d44bc06dd Josh Boyer         2011-08-19  408  		printk("MINIX-fs: file system does not have enough "
016e8d44bc06dd Josh Boyer         2011-08-19  409  				"zmap blocks allocated.  Refusing to mount.\n");
ca85c07809ca19 Al Viro            2012-02-12  410  		goto out_no_bitmap;
ca85c07809ca19 Al Viro            2012-02-12  411  	}
ca85c07809ca19 Al Viro            2012-02-12  412  
ca85c07809ca19 Al Viro            2012-02-12  413  	/* set up enough so that it can read an inode */
ca85c07809ca19 Al Viro            2012-02-12  414  	s->s_op = &minix_sops;
22b139691f9eb8 Deepa Dinamani     2019-07-30  415  	s->s_time_min = 0;
22b139691f9eb8 Deepa Dinamani     2019-07-30  416  	s->s_time_max = U32_MAX;
ca85c07809ca19 Al Viro            2012-02-12  417  	root_inode = minix_iget(s, MINIX_ROOT_INO);
ca85c07809ca19 Al Viro            2012-02-12  418  	if (IS_ERR(root_inode)) {
ca85c07809ca19 Al Viro            2012-02-12  419  		ret = PTR_ERR(root_inode);
ca85c07809ca19 Al Viro            2012-02-12  420  		goto out_no_root;
016e8d44bc06dd Josh Boyer         2011-08-19  421  	}
016e8d44bc06dd Josh Boyer         2011-08-19  422  
d6042eac44b54d Al Viro            2012-01-04  423  	ret = -ENOMEM;
ca85c07809ca19 Al Viro            2012-02-12  424  	s->s_root = d_make_root(root_inode);
d6042eac44b54d Al Viro            2012-01-04  425  	if (!s->s_root)
ca85c07809ca19 Al Viro            2012-02-12  426  		goto out_no_root;
d6042eac44b54d Al Viro            2012-01-04  427  
bc98a42c1f7d0f David Howells      2017-07-17  428  	if (!sb_rdonly(s)) {
d6042eac44b54d Al Viro            2012-01-04  429  		if (sbi->s_version != MINIX_V3) /* s_state is now out from V3 sb */
d6042eac44b54d Al Viro            2012-01-04  430  			ms->s_state &= ~MINIX_VALID_FS;
d6042eac44b54d Al Viro            2012-01-04  431  		mark_buffer_dirty(bh);
d6042eac44b54d Al Viro            2012-01-04  432  	}
d6042eac44b54d Al Viro            2012-01-04  433  	if (!(sbi->s_mount_state & MINIX_VALID_FS))
d6042eac44b54d Al Viro            2012-01-04  434  		printk("MINIX-fs: mounting unchecked file system, "
d6042eac44b54d Al Viro            2012-01-04  435  			"running fsck is recommended\n");
d6042eac44b54d Al Viro            2012-01-04  436  	else if (sbi->s_mount_state & MINIX_ERROR_FS)
d6042eac44b54d Al Viro            2012-01-04  437  		printk("MINIX-fs: mounting file system with errors, "
d6042eac44b54d Al Viro            2012-01-04  438  			"running fsck is recommended\n");
d6042eac44b54d Al Viro            2012-01-04  439  
^1da177e4c3f41 Linus Torvalds     2005-04-16  440  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  441  
^1da177e4c3f41 Linus Torvalds     2005-04-16  442  out_no_root:
^1da177e4c3f41 Linus Torvalds     2005-04-16  443  	if (!silent)
^1da177e4c3f41 Linus Torvalds     2005-04-16  444  		printk("MINIX-fs: get root inode failed\n");
^1da177e4c3f41 Linus Torvalds     2005-04-16  445  	goto out_freemap;
^1da177e4c3f41 Linus Torvalds     2005-04-16  446  
^1da177e4c3f41 Linus Torvalds     2005-04-16  447  out_no_bitmap:
^1da177e4c3f41 Linus Torvalds     2005-04-16  448  	printk("MINIX-fs: bad superblock or unable to read bitmaps\n");
^1da177e4c3f41 Linus Torvalds     2005-04-16  449  out_freemap:
^1da177e4c3f41 Linus Torvalds     2005-04-16  450  	for (i = 0; i < sbi->s_imap_blocks; i++)
^1da177e4c3f41 Linus Torvalds     2005-04-16  451  		brelse(sbi->s_imap[i]);
^1da177e4c3f41 Linus Torvalds     2005-04-16  452  	for (i = 0; i < sbi->s_zmap_blocks; i++)
^1da177e4c3f41 Linus Torvalds     2005-04-16  453  		brelse(sbi->s_zmap[i]);
^1da177e4c3f41 Linus Torvalds     2005-04-16  454  	kfree(sbi->s_imap);
^1da177e4c3f41 Linus Torvalds     2005-04-16  455  	goto out_release;
^1da177e4c3f41 Linus Torvalds     2005-04-16  456  
^1da177e4c3f41 Linus Torvalds     2005-04-16  457  out_no_map:
a90a088021f8f1 David Howells      2008-02-07  458  	ret = -ENOMEM;
^1da177e4c3f41 Linus Torvalds     2005-04-16  459  	if (!silent)
^1da177e4c3f41 Linus Torvalds     2005-04-16  460  		printk("MINIX-fs: can't allocate map\n");
^1da177e4c3f41 Linus Torvalds     2005-04-16  461  	goto out_release;
^1da177e4c3f41 Linus Torvalds     2005-04-16  462  
f5fb09fa3392ad Andries Brouwer    2006-08-27  463  out_illegal_sb:
f5fb09fa3392ad Andries Brouwer    2006-08-27  464  	if (!silent)
f5fb09fa3392ad Andries Brouwer    2006-08-27  465  		printk("MINIX-fs: bad superblock\n");
f5fb09fa3392ad Andries Brouwer    2006-08-27  466  	goto out_release;
f5fb09fa3392ad Andries Brouwer    2006-08-27  467  
^1da177e4c3f41 Linus Torvalds     2005-04-16  468  out_no_fs:
^1da177e4c3f41 Linus Torvalds     2005-04-16  469  	if (!silent)
939b00df0306bc Andries Brouwer    2007-02-12  470  		printk("VFS: Can't find a Minix filesystem V1 | V2 | V3 "
939b00df0306bc Andries Brouwer    2007-02-12  471  		       "on device %s.\n", s->s_id);
^1da177e4c3f41 Linus Torvalds     2005-04-16  472  out_release:
^1da177e4c3f41 Linus Torvalds     2005-04-16  473  	brelse(bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  474  	goto out;
^1da177e4c3f41 Linus Torvalds     2005-04-16  475  
^1da177e4c3f41 Linus Torvalds     2005-04-16  476  out_bad_hblock:
11b8448751ba11 Denis Vlasenko     2006-03-25  477  	printk("MINIX-fs: blocksize too small for device\n");
^1da177e4c3f41 Linus Torvalds     2005-04-16  478  	goto out;
^1da177e4c3f41 Linus Torvalds     2005-04-16  479  
^1da177e4c3f41 Linus Torvalds     2005-04-16  480  out_bad_sb:
^1da177e4c3f41 Linus Torvalds     2005-04-16  481  	printk("MINIX-fs: unable to read superblock\n");
^1da177e4c3f41 Linus Torvalds     2005-04-16  482  out:
^1da177e4c3f41 Linus Torvalds     2005-04-16  483  	kfree(sbi);
e54e25638fc1ea Jori Koolstra      2025-10-28  484  	fc->s_fs_info = NULL;
a90a088021f8f1 David Howells      2008-02-07  485  	return ret;
^1da177e4c3f41 Linus Torvalds     2005-04-16  486  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  487  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

