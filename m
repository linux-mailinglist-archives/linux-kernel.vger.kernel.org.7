Return-Path: <linux-kernel+bounces-891926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D5C43D4A
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D649F347419
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5372EBDDC;
	Sun,  9 Nov 2025 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbRnrfl7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B592EBBB0
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690726; cv=none; b=c4Z6z/HBIV3fWXvVn2xXkB7e9wzqh+narhgT8Dc4cMp77HsuGnyFSJAS4eitem5TO71hpR/swTxucAxDYdXdzGcNjyfqJgzebkQ7EiwTZLF0vRuwOFLxC7vgjG732ZFtdnD6m7shlbL79Jlo74Hnl7kyUYmsAgPoDYfOk4awetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690726; c=relaxed/simple;
	bh=kdq7CfSKQoXAZqvOSWm0UNmZpsX9oRj61NJt+Q5iyvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtDLXNrZVQ9pOtZ+bf9HnkLYO4weakiYz6vcQ3SEAfMwGcRwMrbfKovdrbPSXZFj/T+STpNqR7XqAi5e72RDQjd3G+Y3xopshEsbUUxTzbX/az4iLgiG/1ZTct07ti6/NxT9tzOBpgXAWm/CEBx913ouVLLGNIKPZGX72f/HvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbRnrfl7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762690724; x=1794226724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kdq7CfSKQoXAZqvOSWm0UNmZpsX9oRj61NJt+Q5iyvI=;
  b=MbRnrfl7Xl7J/uGlxVW/mkvid2AtSdyCshEoJZAF9HVi3piB+Bx9zBXR
   xkxMFq3yN5hSGyuAz8Q9QAVIjMabn/rznjPGIsSGgKWhAxZhs6N5nV+55
   ld3rlB1RI43Wv7KvXjKbC0WHIfiLvgX49PWnGzzLq9uH+ROZdcNo8wqb1
   0jvqQJN03RykGiAY0wx4zoUgFPWqXYbeGRnmeJHYCjro66GFkwo1WYxg2
   DBJ/G4g/McDw73f3rGID2EVwUWx7jW7FJ6D1j6d5lrGrdhGToDSXjWDrz
   3QBKlqWP2y40phrxT+CQX+TStfEE0sGCHIKNNqR8NBYraJK95OSNqEgV3
   A==;
X-CSE-ConnectionGUID: WqwJzjmdTC+KZeSNgyTsag==
X-CSE-MsgGUID: kPcn24iyTvq7qw/bKa4sng==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64694899"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64694899"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 04:18:43 -0800
X-CSE-ConnectionGUID: XlpkRqI+TF2hqiezRpE5gw==
X-CSE-MsgGUID: hBHcxq8nRTuGzZrzsSTB4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188287206"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Nov 2025 04:18:41 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI4NT-0001zH-1R;
	Sun, 09 Nov 2025 12:18:39 +0000
Date: Sun, 9 Nov 2025 20:17:42 +0800
From: kernel test robot <lkp@intel.com>
To: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: Forwarded: [PATCH] fs: fix inode use-after-free in chown_common
 delegation retry
Message-ID: <202511091831.tPcsumuB-lkp@intel.com>
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
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20251109/202511091831.tPcsumuB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511091831.tPcsumuB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511091831.tPcsumuB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:108,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from fs/open.c:9:
   fs/open.c: In function 'chown_common':
>> fs/open.c:769:16: warning: format '%p' expects argument of type 'void *', but argument 5 has type 'long int' [-Wformat=]
     769 |         printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     770 |                current->comm, inode, atomic_read(&inode->i_count),
     771 |                atomic_long_read(&inode->i_rwsem.owner));
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                |
         |                long int
   include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   fs/open.c:769:9: note: in expansion of macro 'printk'
     769 |         printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
         |         ^~~~~~
   fs/open.c:769:79: note: format string is defined here
     769 |         printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
         |                                                                              ~^
         |                                                                               |
         |                                                                               void *
         |                                                                              %ld
   fs/open.c:784:16: warning: format '%p' expects argument of type 'void *', but argument 4 has type 'long int' [-Wformat=]
     784 |         printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     785 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), current);
         |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      |
         |                                      long int
   include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   fs/open.c:784:9: note: in expansion of macro 'printk'
     784 |         printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
         |         ^~~~~~
   fs/open.c:784:72: note: format string is defined here
     784 |         printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
         |                                                                       ~^
         |                                                                        |
         |                                                                        void *
         |                                                                       %ld
   fs/open.c:797:16: warning: format '%p' expects argument of type 'void *', but argument 4 has type 'long int' [-Wformat=]
     797 |         printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     798 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), delegated_inode);
         |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      |
         |                                      long int
   include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   fs/open.c:797:9: note: in expansion of macro 'printk'
     797 |         printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
         |         ^~~~~~
   fs/open.c:797:75: note: format string is defined here
     797 |         printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
         |                                                                          ~^
         |                                                                           |
         |                                                                           void *
         |                                                                          %ld
   fs/open.c:800:16: warning: format '%p' expects argument of type 'void *', but argument 4 has type 'long int' [-Wformat=]
     800 |         printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     801 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner));
         |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      |
         |                                      long int
   include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   fs/open.c:800:9: note: in expansion of macro 'printk'
     800 |         printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
         |         ^~~~~~
   fs/open.c:800:74: note: format string is defined here
     800 |         printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
         |                                                                         ~^
         |                                                                          |
         |                                                                          void *
         |                                                                         %ld


vim +769 fs/open.c

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
 > 769		printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
   770		       current->comm, inode, atomic_read(&inode->i_count),
   771		       atomic_long_read(&inode->i_rwsem.owner));
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

