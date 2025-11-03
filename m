Return-Path: <linux-kernel+bounces-882270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AF2C2A08B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 05:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2D944E1BC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 04:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181BC2882A9;
	Mon,  3 Nov 2025 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6tuKXzI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591B23D7DA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762145023; cv=none; b=KuEs0rjMyoNLZp8u1YAxM2ksWlZlJTiCZhonGm3DZyh2xMazg9+w06kOo6sEaQcUDDzbYxshhTvDbGgeJ55588Pgfe3Y8ZAefZ323xn28CDDhhwzcs3BHhFTivOGuqkNuu+CZCg6welFn9SlILEnNarjL7F8hHwWEDTzk/Ko1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762145023; c=relaxed/simple;
	bh=33d+YZiDWFuxAUM/paTRrQcWI1uv6sSqzObX9bH5epU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUpZca9VI1oxyM5SbVQzYuRkL19kmV/NDLId6e6n2FfnoC2BkyfQr0INhfMh9IcL2n4Gh0B5mB1t0o058FKEmdrYDet4t+6OWNrKh9OpNJ3XT83uPPwSiXsZl+NxMOycjuG0JW1Bf3iqMT1UyuahqbKu4i0PbJGgJeLyNXj4le4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6tuKXzI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762145022; x=1793681022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=33d+YZiDWFuxAUM/paTRrQcWI1uv6sSqzObX9bH5epU=;
  b=f6tuKXzITzBqcPoe0mR7Z8Ra7uZrqc8t4d0K7v/gr3yPb1UqzAu7X4ez
   QZgGD6CMSlhDQE83hHn5spuXedBK/IAiBMzOHq25LNwkPHoKteUbGHcMR
   +e3WM9aE7VmOOlYSILtqu/N3LuKBOtc7/fNIb1C2n3sNAPQOfz9zML5sg
   XIjn6z11W8eDS6E+qrYor3X2oEBJFrmVPuoL/mrUEcXCD865KLhhzwakS
   GH7L8g96EvTGtiaCmVjOY27Olc7WleNuTe/GvhDe/HgrFFF/7G4RNmT7t
   qYTWey/TSjt1MMIEs+1BKucEqnNQolOwkSvy6qZQ85k/7O8dkzAokE7t8
   w==;
X-CSE-ConnectionGUID: euA5nO9SRj6BZRimB1uBPQ==
X-CSE-MsgGUID: Ys91YkCPQaOCDjBPjQpMxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="86839335"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="86839335"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 20:43:41 -0800
X-CSE-ConnectionGUID: uoKtMhQ+QHiICLbXNcjvvg==
X-CSE-MsgGUID: 5T0fYuxtTsGWN/krlxXtiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="191098982"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 02 Nov 2025 20:43:38 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFmPn-000PpY-2q;
	Mon, 03 Nov 2025 04:43:35 +0000
Date: Mon, 3 Nov 2025 12:42:37 +0800
From: kernel test robot <lkp@intel.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>,
	Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Cc: oe-kbuild-all@lists.linux.dev, jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org,
	syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix a drop_nlink warning in minix_rename
Message-ID: <202511031229.rqpKLU46-lkp@intel.com>
References: <20251102182532.2442670-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102182532.2442670-1-jkoolstra@xs4all.nl>

Hi Jori,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.18-rc4 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jori-Koolstra/Fix-a-drop_nlink-warning-in-minix_rename/20251103-022646
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251102182532.2442670-1-jkoolstra%40xs4all.nl
patch subject: [PATCH] Fix a drop_nlink warning in minix_rename
config: arc-randconfig-r073-20251103 (https://download.01.org/0day-ci/archive/20251103/202511031229.rqpKLU46-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251103/202511031229.rqpKLU46-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511031229.rqpKLU46-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/minix/namei.c: In function 'minix_unlink':
>> fs/minix/namei.c:151:11: error: 'EFSCORRUPTED' undeclared (first use in this function); did you mean 'FS_NRSUPER'?
      return -EFSCORRUPTED;
              ^~~~~~~~~~~~
              FS_NRSUPER
   fs/minix/namei.c:151:11: note: each undeclared identifier is reported only once for each function it appears in
   fs/minix/namei.c: In function 'minix_rename':
   fs/minix/namei.c:217:10: error: 'EFSCORRUPTED' undeclared (first use in this function); did you mean 'FS_NRSUPER'?
      err = -EFSCORRUPTED;
             ^~~~~~~~~~~~
             FS_NRSUPER


vim +151 fs/minix/namei.c

   140	
   141	static int minix_unlink(struct inode * dir, struct dentry *dentry)
   142	{
   143		struct inode * inode = d_inode(dentry);
   144		struct folio *folio;
   145		struct minix_dir_entry * de;
   146		int err;
   147	
   148		if (inode->i_nlink < 1) {
   149			printk(KERN_CRIT "minix-fs error: inode (ino: %ld) "
   150			       "has corrupted nlink", inode->i_ino);
 > 151			return -EFSCORRUPTED;
   152		}
   153	
   154		de = minix_find_entry(dentry, &folio);
   155		if (!de)
   156			return -ENOENT;
   157		err = minix_delete_entry(de, folio);
   158		folio_release_kmap(folio, de);
   159	
   160		if (err)
   161			return err;
   162		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
   163		inode_dec_link_count(inode);
   164		return 0;
   165	}
   166	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

