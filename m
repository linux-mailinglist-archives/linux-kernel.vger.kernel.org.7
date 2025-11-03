Return-Path: <linux-kernel+bounces-882439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCE7C2A78B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B634F4ED02B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103402D3218;
	Mon,  3 Nov 2025 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOtD0K+V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33592D24AC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156722; cv=none; b=MuARBcV1TmJw1nXU2lITHsvE+BQtFM4t6hIu71a1YIhvea7tn6KV7JFbDUHj4JdErqDv8TRgjVaGUmkgc8EIObiwlEGtlQ9Em1EXOj9NhAajoSM9a682xnBu7fQNFqSe9UOpn1oRSfHs5Uy7izuM43VT16XU8ZzbW4F8mPXhmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156722; c=relaxed/simple;
	bh=1FNm0IkM1sY0ABEEDPCU3w2p5wh4CFQ4+1Miq44uQxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+vrv6mfg465+OdLbL591I52yljmjw45RXX5VCS7KubAC0PWt0npY/9x8VWXm/Hey0/uvpAznEcjabu11sinI9q5U4OVzizaWKWsI4rTrc48VoP0yQ2MepfT0ncFbF+xOKEvBv8DoAu9o+pnXzaUECXrsj99RpLyw+sUqS3BNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOtD0K+V; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762156721; x=1793692721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1FNm0IkM1sY0ABEEDPCU3w2p5wh4CFQ4+1Miq44uQxU=;
  b=WOtD0K+VhGg/4X/R5dU9hWtY+hFs1PvecjSSWB56Oux6NAFaVDhh5YBz
   X5bbk0YY8cVGnJUnlXExTTnfKYEj8xVeq/sZ7HJUsAjFTJ6J/xUcaBfjo
   SLURAtdS04kopIcSEabpfa8vI+WdLDeO04R7ScHs/014OLulcidFQ/nt5
   JWFwScti3mYIqRsixnH5SN6AxoZ2buxqG/AqtgBT65zFcOutciD0VHnRr
   2iUanPIn+AhjWeOmenoQbLvOk+OfT3Cn/tAUr+RaYu0qjJOSDQ440CxFK
   O7hSt4J8NKKYwy/cY6CEq3DEB4xVSFdTUeWrG8RTS03+bt1prx2SMwaEg
   A==;
X-CSE-ConnectionGUID: n+zWUZsyQoKDpnnObZRfrw==
X-CSE-MsgGUID: Ssw+CrmISMy9/xS4sAIz8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64265113"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="64265113"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:58:40 -0800
X-CSE-ConnectionGUID: /JX1QDGhT/qZ5qvkq8W++Q==
X-CSE-MsgGUID: ElpOeLaWQEOEFXRdrwRkMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186675874"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 02 Nov 2025 23:58:37 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFpSJ-000Pw4-2S;
	Mon, 03 Nov 2025 07:58:28 +0000
Date: Mon, 3 Nov 2025 15:58:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>,
	Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org,
	syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix a drop_nlink warning in minix_rename
Message-ID: <202511031556.5N9lmsZB-lkp@intel.com>
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
[also build test ERROR on linus/master v6.18-rc4 next-20251103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jori-Koolstra/Fix-a-drop_nlink-warning-in-minix_rename/20251103-022646
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251102182532.2442670-1-jkoolstra%40xs4all.nl
patch subject: [PATCH] Fix a drop_nlink warning in minix_rename
config: arm-randconfig-004-20251103 (https://download.01.org/0day-ci/archive/20251103/202511031556.5N9lmsZB-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251103/202511031556.5N9lmsZB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511031556.5N9lmsZB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/minix/namei.c:151:11: error: use of undeclared identifier 'EFSCORRUPTED'
     151 |                 return -EFSCORRUPTED;
         |                         ^~~~~~~~~~~~
   fs/minix/namei.c:217:10: error: use of undeclared identifier 'EFSCORRUPTED'
     217 |                 err = -EFSCORRUPTED;
         |                        ^~~~~~~~~~~~
   2 errors generated.


vim +/EFSCORRUPTED +151 fs/minix/namei.c

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

