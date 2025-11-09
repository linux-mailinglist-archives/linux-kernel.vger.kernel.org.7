Return-Path: <linux-kernel+bounces-891892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1B5C43C3E
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EB144E1497
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD02DC32C;
	Sun,  9 Nov 2025 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9grP9zL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F234D381
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686339; cv=none; b=GaWVlSVdQYRAp0q8xDelQ7NBz5Ocx7Y8lJZShtXBcAgqI+ef3ILF3GWyw9nelucOYaPVkohLa5ajJ6St/U+WEnLphk4AEhUz8ZZCXMR0Iz9pyPdsnSM1FoOOQdO6zO6r/5SFi2TtkoDVa8YxGU7Exz3nLIygCjm2RcAPH7sKk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686339; c=relaxed/simple;
	bh=HrMUzheQaOv9R4Evprn/x622r03F+FlEJxIhmxwu/A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eO11rO6y94UWbDRluAk/HPTRstZ0wM3OY5REzkaX9dwjCvQ5E/NHwoGJ28NDvMx9KgOsCQmOE/8Im9DgEQFa0KSGQg7l3qYTDQQEHPZJ7awYY0RKuyYyCLk7zJwop4VUwE0OD02VzAiFj4d4tTN+RVSLChluKkNMHF9XMEJpF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9grP9zL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762686337; x=1794222337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HrMUzheQaOv9R4Evprn/x622r03F+FlEJxIhmxwu/A4=;
  b=U9grP9zL5sCIaAUu+FH4Dwx5hqn4eGwrs6TC4UBqdtM+s4/9zEtCpnCa
   6RQ+7oNk7B1UTJU80Kv5JvDW/Jtr8e0NCZbMK3/+YLyaS41tU2pw5Y0PZ
   r2o2izx6UXqEy2E8J2cFeFZnQzB+T34H/ZLJE00f2nvBxXEMDe/2shNdJ
   SOisdsfEdnTlH6DQxp78tSuRTnG6tx4YeKbs2FxPdmck/ZO8RzszLehnq
   NB++3ibVp6J8GOHwrEGDyxpTWisT2YyzZAmBW76wvvFtzg3bMFTRqW85m
   RGHYlmK4nuWZ5KLnFsQLQd3zyaa7UYMGMFk6NQAk5khe5BpkQqLOgD9+r
   A==;
X-CSE-ConnectionGUID: NCESTAOVRh2rqpeH93SXfA==
X-CSE-MsgGUID: G5QwJ/zbQBKiO6OxHaOcxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="90235733"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="90235733"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 03:05:36 -0800
X-CSE-ConnectionGUID: XWLJAbMVTyyLRRN7OTwMJw==
X-CSE-MsgGUID: EUPCigK0TBeeinhHSUL0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="189153446"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Nov 2025 03:05:35 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI3Ei-0001x1-2Y;
	Sun, 09 Nov 2025 11:05:32 +0000
Date: Sun, 9 Nov 2025 19:05:11 +0800
From: kernel test robot <lkp@intel.com>
To: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: Forwarded: [PATCH] fs: fix inode use-after-free in chown_common
 delegation retry
Message-ID: <202511091815.6q5WUuzH-lkp@intel.com>
References: <691059ff.a70a0220.22f260.00a6.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691059ff.a70a0220.22f260.00a6.GAE@google.com>

Hi syzbot,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.18-rc4 next-20251107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/syzbot/Forwarded-PATCH-fs-fix-inode-use-after-free-in-chown_common-delegation-retry/20251109-171000
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/691059ff.a70a0220.22f260.00a6.GAE%40google.com
patch subject: Forwarded: [PATCH] fs: fix inode use-after-free in chown_common delegation retry
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20251109/202511091815.6q5WUuzH-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project b9ea93cd5c37fb6d606502fd01208dd48330549d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511091815.6q5WUuzH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511091815.6q5WUuzH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/open.c:771:9: warning: format specifies type 'void *' but the argument has type 'long' [-Wformat]
     769 |         printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
         |                                                                              ~~
         |                                                                              %ld
     770 |                current->comm, inode, atomic_read(&inode->i_count),
     771 |                atomic_long_read(&inode->i_rwsem.owner));
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   fs/open.c:785:31: warning: format specifies type 'void *' but the argument has type 'long' [-Wformat]
     784 |         printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
         |                                                                       ~~
         |                                                                       %ld
     785 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), current);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   fs/open.c:798:31: warning: format specifies type 'void *' but the argument has type 'long' [-Wformat]
     797 |         printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
         |                                                                          ~~
         |                                                                          %ld
     798 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), delegated_inode);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   fs/open.c:801:31: warning: format specifies type 'void *' but the argument has type 'long' [-Wformat]
     800 |         printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
         |                                                                         ~~
         |                                                                         %ld
     801 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner));
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   4 warnings generated.


vim +771 fs/open.c

   750	
   751	int chown_common(const struct path *path, uid_t user, gid_t group)
   752	{
   753		struct mnt_idmap *idmap;
   754		struct user_namespace *fs_userns;
   755		struct inode *inode = path->dentry->d_inode;
   756		struct inode *delegated_inode = NULL;
   757		int error;
   758		struct iattr newattrs;
   759		kuid_t uid;
   760		kgid_t gid;
   761	
   762		uid = make_kuid(current_user_ns(), user);
   763		gid = make_kgid(current_user_ns(), group);
   764	
   765		idmap = mnt_idmap(path->mnt);
   766		fs_userns = i_user_ns(inode);
   767	
   768	retry_deleg:
   769		printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
   770		       current->comm, inode, atomic_read(&inode->i_count),
 > 771		       atomic_long_read(&inode->i_rwsem.owner));
   772		newattrs.ia_vfsuid = INVALID_VFSUID;
   773		newattrs.ia_vfsgid = INVALID_VFSGID;
   774		newattrs.ia_valid =  ATTR_CTIME;
   775		if ((user != (uid_t)-1) && !setattr_vfsuid(&newattrs, uid))
   776			return -EINVAL;
   777		if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
   778			return -EINVAL;
   779		printk("DEBUG: [%s] before inode_lock: inode=%p, i_count=%d\n",
   780		       current->comm, inode, atomic_read(&inode->i_count));
   781		error = inode_lock_killable(inode);
   782		if (error)
   783			return error;
   784		printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
   785		       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), current);
   786		if (!S_ISDIR(inode->i_mode))
   787			newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
   788					     setattr_should_drop_sgid(idmap, inode);
   789		/* Continue to send actual fs values, not the mount values. */
   790		error = security_path_chown(
   791			path,
   792			from_vfsuid(idmap, fs_userns, newattrs.ia_vfsuid),
   793			from_vfsgid(idmap, fs_userns, newattrs.ia_vfsgid));
   794		if (!error)
   795			error = notify_change(idmap, path->dentry, &newattrs,
   796					      &delegated_inode);
   797		printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
   798		       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), delegated_inode);
   799		inode_unlock(inode);
   800		printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
   801		       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner));
   802		if (delegated_inode) {
   803			printk("DEBUG: [%s] calling break_deleg_wait: inode=%p, i_count=%d, delegated_inode=%p\n",
   804			       current->comm, inode, atomic_read(&inode->i_count), delegated_inode);
   805			error = break_deleg_wait(&delegated_inode);
   806			printk("DEBUG: [%s] after break_deleg_wait: inode=%p, i_count=%d, error=%d\n",
   807			       current->comm, inode, atomic_read(&inode->i_count), error);
   808			if (!error)
   809				goto retry_deleg;
   810		}
   811		return error;
   812	}
   813	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

