Return-Path: <linux-kernel+bounces-891689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 236ADC43419
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 698304E4893
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5226C3A2;
	Sat,  8 Nov 2025 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQIc9+1R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397E1BFE00
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631324; cv=none; b=HkIm0+/lkWpYMMhWBdqeK+6yMoxVvM8j/Y0p+DHYfOAVaaR1DOG9o1Is2SuZNPr3g+NnacMBnkp33TkWzuO422d4aW5YEkdUir4lOxGYttHWNe26vmCJ1rVjiW/8OegcQJ2oi5urrxbb/rP8B6qiKqymHTYqgdseFEEgKB2Hb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631324; c=relaxed/simple;
	bh=RvkTAaVJzoCbyCRXezp8tG+q1LLsSH6C1TteZMVDSdE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jwxFWoEcVTzlo5OiCTRdnCHpipb74MsDqI6Uf+ETSuMf7CTbbMAMEY1y7h08Wz2x30V1ndMkJ33J8T/2/lyjZHB4mOfBIj8KP/cuGNpc1bBLssEl71/JZvOFCyRhHNYNWZYRMClwS8fUz2wdcDdgFqnk4v4p1LRBaT/Z9muRWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQIc9+1R; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762631321; x=1794167321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RvkTAaVJzoCbyCRXezp8tG+q1LLsSH6C1TteZMVDSdE=;
  b=HQIc9+1RLKPd77O1LmRYH4A701oxtUz2MLJxMxv8CeqIcwfTSqVkt4BX
   kZAMQcfpoTShUssVxlGdXudHOImvuQckinqW/22uL1Mr9HW07CU2A4dZo
   HD67qgExn1rL7PgdPb4oYAHgd537lkjOIHGhSp4SDHhzmQSvGd9D+uGc+
   Q0pJeCEZu2vBwf4G0NLFC1HxyANYoYHrrzpxOQWspAehERsl2jsmXpyNw
   Mya8wioKY/gYL4naqB2SQEppF9fJ09b8JANnxwJNzoEOCcjQueTziHXKl
   ysGQGn0qWPxjcviUedfcjpT7jWJvuYgng5U5UDz85LoJtvaxBBe1DFnpn
   A==;
X-CSE-ConnectionGUID: /JFyYleZRjaUj5GPs7Gj6Q==
X-CSE-MsgGUID: 9Zd5qdxQQpiaZMLYDoGdCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="63754787"
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="63754787"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 11:48:41 -0800
X-CSE-ConnectionGUID: P+CetlCRSweuwC0ji66vLw==
X-CSE-MsgGUID: dUo1hn9dTHGbRJTIb4LMgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="188281900"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Nov 2025 11:48:39 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHovM-0001O1-2M;
	Sat, 08 Nov 2025 19:48:36 +0000
Date: Sun, 9 Nov 2025 03:48:21 +0800
From: kernel test robot <lkp@intel.com>
To: Filipe Manana <fdmanana@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: fs/btrfs/tree-log.c:2649:32: warning: 'inode_item' may be used
 uninitialized
Message-ID: <202511090321.X08Rh6eK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0d7bee10beeb59b1133bf5a4749b17a4ef3bbb01
commit: 2ac70946621ff3d90eb84d2e3b74563f4154f24c btrfs: add current log leaf, key and slot to struct walk_control
date:   7 weeks ago
config: um-randconfig-001-20251109 (https://download.01.org/0day-ci/archive/20251109/202511090321.X08Rh6eK-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511090321.X08Rh6eK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511090321.X08Rh6eK-lkp@intel.com/

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   fs/btrfs/tree-log.c: In function 'replay_one_buffer':
>> fs/btrfs/tree-log.c:2649:32: warning: 'inode_item' may be used uninitialized [-Wmaybe-uninitialized]
    2649 |                         mode = btrfs_inode_mode(eb, inode_item);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/tree-log.c:2607:42: note: 'inode_item' was declared here
    2607 |                 struct btrfs_inode_item *inode_item;
         |                                          ^~~~~~~~~~


vim +/inode_item +2649 fs/btrfs/tree-log.c

e02119d5a7b439 Chris Mason   2008-09-05  2563  
e02119d5a7b439 Chris Mason   2008-09-05  2564  /*
e02119d5a7b439 Chris Mason   2008-09-05  2565   * the process_func used to replay items from the log tree.  This
e02119d5a7b439 Chris Mason   2008-09-05  2566   * gets called in two different stages.  The first stage just looks
e02119d5a7b439 Chris Mason   2008-09-05  2567   * for inodes and makes sure they are all copied into the subvolume.
e02119d5a7b439 Chris Mason   2008-09-05  2568   *
e02119d5a7b439 Chris Mason   2008-09-05  2569   * The second stage copies all the other item types from the log into
e02119d5a7b439 Chris Mason   2008-09-05  2570   * the subvolume.  The two stage approach is slower, but gets rid of
e02119d5a7b439 Chris Mason   2008-09-05  2571   * lots of complexity around inodes referencing other inodes that exist
e02119d5a7b439 Chris Mason   2008-09-05  2572   * only in the log (references come from either directory items or inode
e02119d5a7b439 Chris Mason   2008-09-05  2573   * back refs).
e02119d5a7b439 Chris Mason   2008-09-05  2574   */
efa44fc4fde3eb Filipe Manana 2025-08-26  2575  static int replay_one_buffer(struct extent_buffer *eb,
581c1760415c48 Qu Wenruo     2018-03-29  2576  			     struct walk_control *wc, u64 gen, int level)
e02119d5a7b439 Chris Mason   2008-09-05  2577  {
e02119d5a7b439 Chris Mason   2008-09-05  2578  	int nritems;
789d6a3a876e32 Qu Wenruo     2022-09-14  2579  	struct btrfs_tree_parent_check check = {
789d6a3a876e32 Qu Wenruo     2022-09-14  2580  		.transid = gen,
789d6a3a876e32 Qu Wenruo     2022-09-14  2581  		.level = level
789d6a3a876e32 Qu Wenruo     2022-09-14  2582  	};
e02119d5a7b439 Chris Mason   2008-09-05  2583  	struct btrfs_path *path;
2c123db1f0e1fb Filipe Manana 2025-08-26  2584  	struct btrfs_root *root = wc->root;
425652cf102838 Filipe Manana 2025-07-16  2585  	struct btrfs_trans_handle *trans = wc->trans;
e02119d5a7b439 Chris Mason   2008-09-05  2586  	int ret;
e02119d5a7b439 Chris Mason   2008-09-05  2587  
6cb7f0b8c9b0d6 Filipe Manana 2025-08-28  2588  	if (level != 0)
6cb7f0b8c9b0d6 Filipe Manana 2025-08-28  2589  		return 0;
6cb7f0b8c9b0d6 Filipe Manana 2025-08-28  2590  
789d6a3a876e32 Qu Wenruo     2022-09-14  2591  	ret = btrfs_read_extent_buffer(eb, &check);
912c257c88cd8c Filipe Manana 2025-07-18  2592  	if (ret) {
912c257c88cd8c Filipe Manana 2025-07-18  2593  		btrfs_abort_transaction(trans, ret);
018642a1f19788 Tsutomu Itoh  2012-05-29  2594  		return ret;
912c257c88cd8c Filipe Manana 2025-07-18  2595  	}
e02119d5a7b439 Chris Mason   2008-09-05  2596  
e02119d5a7b439 Chris Mason   2008-09-05  2597  	path = btrfs_alloc_path();
912c257c88cd8c Filipe Manana 2025-07-18  2598  	if (!path) {
912c257c88cd8c Filipe Manana 2025-07-18  2599  		btrfs_abort_transaction(trans, -ENOMEM);
1e5063d093b5f0 Mark Fasheh   2011-07-12  2600  		return -ENOMEM;
912c257c88cd8c Filipe Manana 2025-07-18  2601  	}
e02119d5a7b439 Chris Mason   2008-09-05  2602  
2ac70946621ff3 Filipe Manana 2025-09-01  2603  	wc->log_leaf = eb;
2ac70946621ff3 Filipe Manana 2025-09-01  2604  
e02119d5a7b439 Chris Mason   2008-09-05  2605  	nritems = btrfs_header_nritems(eb);
2ac70946621ff3 Filipe Manana 2025-09-01  2606  	for (wc->log_slot = 0; wc->log_slot < nritems; wc->log_slot++) {
e02119d5a7b439 Chris Mason   2008-09-05  2607  		struct btrfs_inode_item *inode_item;
e02119d5a7b439 Chris Mason   2008-09-05  2608  
2ac70946621ff3 Filipe Manana 2025-09-01  2609  		btrfs_item_key_to_cpu(eb, &wc->log_key, wc->log_slot);
0a32e4f0025a74 Filipe Manana 2025-07-30  2610  
2ac70946621ff3 Filipe Manana 2025-09-01  2611  		if (wc->log_key.type == BTRFS_INODE_ITEM_KEY) {
2ac70946621ff3 Filipe Manana 2025-09-01  2612  			inode_item = btrfs_item_ptr(eb, wc->log_slot,
2ac70946621ff3 Filipe Manana 2025-09-01  2613  						    struct btrfs_inode_item);
f2d72f42d5fa3b Filipe Manana 2018-10-08  2614  			/*
0a32e4f0025a74 Filipe Manana 2025-07-30  2615  			 * An inode with no links is either:
0a32e4f0025a74 Filipe Manana 2025-07-30  2616  			 *
0a32e4f0025a74 Filipe Manana 2025-07-30  2617  			 * 1) A tmpfile (O_TMPFILE) that got fsync'ed and never
0a32e4f0025a74 Filipe Manana 2025-07-30  2618  			 *    got linked before the fsync, skip it, as replaying
0a32e4f0025a74 Filipe Manana 2025-07-30  2619  			 *    it is pointless since it would be deleted later.
0a32e4f0025a74 Filipe Manana 2025-07-30  2620  			 *    We skip logging tmpfiles, but it's always possible
0a32e4f0025a74 Filipe Manana 2025-07-30  2621  			 *    we are replaying a log created with a kernel that
0a32e4f0025a74 Filipe Manana 2025-07-30  2622  			 *    used to log tmpfiles;
0a32e4f0025a74 Filipe Manana 2025-07-30  2623  			 *
0a32e4f0025a74 Filipe Manana 2025-07-30  2624  			 * 2) A non-tmpfile which got its last link deleted
0a32e4f0025a74 Filipe Manana 2025-07-30  2625  			 *    while holding an open fd on it and later got
0a32e4f0025a74 Filipe Manana 2025-07-30  2626  			 *    fsynced through that fd. We always log the
0a32e4f0025a74 Filipe Manana 2025-07-30  2627  			 *    parent inodes when inode->last_unlink_trans is
0a32e4f0025a74 Filipe Manana 2025-07-30  2628  			 *    set to the current transaction, so ignore all the
0a32e4f0025a74 Filipe Manana 2025-07-30  2629  			 *    inode items for this inode. We will delete the
0a32e4f0025a74 Filipe Manana 2025-07-30  2630  			 *    inode when processing the parent directory with
0a32e4f0025a74 Filipe Manana 2025-07-30  2631  			 *    replay_dir_deletes().
f2d72f42d5fa3b Filipe Manana 2018-10-08  2632  			 */
f2d72f42d5fa3b Filipe Manana 2018-10-08  2633  			if (btrfs_inode_nlink(eb, inode_item) == 0) {
f2d72f42d5fa3b Filipe Manana 2018-10-08  2634  				wc->ignore_cur_inode = true;
f2d72f42d5fa3b Filipe Manana 2018-10-08  2635  				continue;
f2d72f42d5fa3b Filipe Manana 2018-10-08  2636  			} else {
f2d72f42d5fa3b Filipe Manana 2018-10-08  2637  				wc->ignore_cur_inode = false;
f2d72f42d5fa3b Filipe Manana 2018-10-08  2638  			}
0a32e4f0025a74 Filipe Manana 2025-07-30  2639  		}
0a32e4f0025a74 Filipe Manana 2025-07-30  2640  
0a32e4f0025a74 Filipe Manana 2025-07-30  2641  		/* Inode keys are done during the first stage. */
2ac70946621ff3 Filipe Manana 2025-09-01  2642  		if (wc->log_key.type == BTRFS_INODE_ITEM_KEY &&
0a32e4f0025a74 Filipe Manana 2025-07-30  2643  		    wc->stage == LOG_WALK_REPLAY_INODES) {
0a32e4f0025a74 Filipe Manana 2025-07-30  2644  			u32 mode;
0a32e4f0025a74 Filipe Manana 2025-07-30  2645  
2ac70946621ff3 Filipe Manana 2025-09-01  2646  			ret = replay_xattr_deletes(wc, path);
4f764e5153616f Filipe Manana 2015-02-23  2647  			if (ret)
4f764e5153616f Filipe Manana 2015-02-23  2648  				break;
e02119d5a7b439 Chris Mason   2008-09-05 @2649  			mode = btrfs_inode_mode(eb, inode_item);
e02119d5a7b439 Chris Mason   2008-09-05  2650  			if (S_ISDIR(mode)) {
2ac70946621ff3 Filipe Manana 2025-09-01  2651  				ret = replay_dir_deletes(wc, path, wc->log_key.objectid, false);
b50c6e250ef913 Josef Bacik   2013-04-25  2652  				if (ret)
b50c6e250ef913 Josef Bacik   2013-04-25  2653  					break;
e02119d5a7b439 Chris Mason   2008-09-05  2654  			}
2ac70946621ff3 Filipe Manana 2025-09-01  2655  			ret = overwrite_item(wc, path);
b50c6e250ef913 Josef Bacik   2013-04-25  2656  			if (ret)
b50c6e250ef913 Josef Bacik   2013-04-25  2657  				break;
e02119d5a7b439 Chris Mason   2008-09-05  2658  
471d557afed155 Filipe Manana 2018-04-05  2659  			/*
471d557afed155 Filipe Manana 2018-04-05  2660  			 * Before replaying extents, truncate the inode to its
471d557afed155 Filipe Manana 2018-04-05  2661  			 * size. We need to do it now and not after log replay
471d557afed155 Filipe Manana 2018-04-05  2662  			 * because before an fsync we can have prealloc extents
471d557afed155 Filipe Manana 2018-04-05  2663  			 * added beyond the inode's i_size. If we did it after,
471d557afed155 Filipe Manana 2018-04-05  2664  			 * through orphan cleanup for example, we would drop
471d557afed155 Filipe Manana 2018-04-05  2665  			 * those prealloc extents just after replaying them.
e02119d5a7b439 Chris Mason   2008-09-05  2666  			 */
e02119d5a7b439 Chris Mason   2008-09-05  2667  			if (S_ISREG(mode)) {
5893dfb98f2578 Filipe Manana 2020-11-04  2668  				struct btrfs_drop_extents_args drop_args = { 0 };
b4c50cbb01a1b6 Filipe Manana 2025-03-06  2669  				struct btrfs_inode *inode;
471d557afed155 Filipe Manana 2018-04-05  2670  				u64 from;
471d557afed155 Filipe Manana 2018-04-05  2671  
2ac70946621ff3 Filipe Manana 2025-09-01  2672  				inode = btrfs_iget_logging(wc->log_key.objectid, root);
5f61b961599acb Filipe Manana 2025-06-18  2673  				if (IS_ERR(inode)) {
5f61b961599acb Filipe Manana 2025-06-18  2674  					ret = PTR_ERR(inode);
912c257c88cd8c Filipe Manana 2025-07-18  2675  					btrfs_abort_transaction(trans, ret);
471d557afed155 Filipe Manana 2018-04-05  2676  					break;
471d557afed155 Filipe Manana 2018-04-05  2677  				}
b4c50cbb01a1b6 Filipe Manana 2025-03-06  2678  				from = ALIGN(i_size_read(&inode->vfs_inode),
471d557afed155 Filipe Manana 2018-04-05  2679  					     root->fs_info->sectorsize);
5893dfb98f2578 Filipe Manana 2020-11-04  2680  				drop_args.start = from;
5893dfb98f2578 Filipe Manana 2020-11-04  2681  				drop_args.end = (u64)-1;
5893dfb98f2578 Filipe Manana 2020-11-04  2682  				drop_args.drop_cache = true;
425652cf102838 Filipe Manana 2025-07-16  2683  				ret = btrfs_drop_extents(trans, root, inode,  &drop_args);
912c257c88cd8c Filipe Manana 2025-07-18  2684  				if (ret) {
912c257c88cd8c Filipe Manana 2025-07-18  2685  					btrfs_abort_transaction(trans, ret);
912c257c88cd8c Filipe Manana 2025-07-18  2686  				} else {
b4c50cbb01a1b6 Filipe Manana 2025-03-06  2687  					inode_sub_bytes(&inode->vfs_inode,
2766ff61762c3f Filipe Manana 2020-11-04  2688  							drop_args.bytes_found);
f2d72f42d5fa3b Filipe Manana 2018-10-08  2689  					/* Update the inode's nbytes. */
425652cf102838 Filipe Manana 2025-07-16  2690  					ret = btrfs_update_inode(trans, inode);
912c257c88cd8c Filipe Manana 2025-07-18  2691  					if (ret)
912c257c88cd8c Filipe Manana 2025-07-18  2692  						btrfs_abort_transaction(trans, ret);
471d557afed155 Filipe Manana 2018-04-05  2693  				}
b4c50cbb01a1b6 Filipe Manana 2025-03-06  2694  				iput(&inode->vfs_inode);
b50c6e250ef913 Josef Bacik   2013-04-25  2695  				if (ret)
b50c6e250ef913 Josef Bacik   2013-04-25  2696  					break;
e02119d5a7b439 Chris Mason   2008-09-05  2697  			}
c71bf099abddf3 Yan, Zheng    2009-11-12  2698  
2ac70946621ff3 Filipe Manana 2025-09-01  2699  			ret = link_to_fixup_dir(wc, path, wc->log_key.objectid);
b50c6e250ef913 Josef Bacik   2013-04-25  2700  			if (ret)
b50c6e250ef913 Josef Bacik   2013-04-25  2701  				break;
e02119d5a7b439 Chris Mason   2008-09-05  2702  		}
dd8e721773fdab Josef Bacik   2013-09-11  2703  
f2d72f42d5fa3b Filipe Manana 2018-10-08  2704  		if (wc->ignore_cur_inode)
f2d72f42d5fa3b Filipe Manana 2018-10-08  2705  			continue;
f2d72f42d5fa3b Filipe Manana 2018-10-08  2706  
2ac70946621ff3 Filipe Manana 2025-09-01  2707  		if (wc->log_key.type == BTRFS_DIR_INDEX_KEY &&
dd8e721773fdab Josef Bacik   2013-09-11  2708  		    wc->stage == LOG_WALK_REPLAY_DIR_INDEX) {
2ac70946621ff3 Filipe Manana 2025-09-01  2709  			ret = replay_one_dir_item(wc, path);
dd8e721773fdab Josef Bacik   2013-09-11  2710  			if (ret)
dd8e721773fdab Josef Bacik   2013-09-11  2711  				break;
dd8e721773fdab Josef Bacik   2013-09-11  2712  		}
dd8e721773fdab Josef Bacik   2013-09-11  2713  
e02119d5a7b439 Chris Mason   2008-09-05  2714  		if (wc->stage < LOG_WALK_REPLAY_ALL)
e02119d5a7b439 Chris Mason   2008-09-05  2715  			continue;
e02119d5a7b439 Chris Mason   2008-09-05  2716  
e02119d5a7b439 Chris Mason   2008-09-05  2717  		/* these keys are simply copied */
2ac70946621ff3 Filipe Manana 2025-09-01  2718  		if (wc->log_key.type == BTRFS_XATTR_ITEM_KEY) {
2ac70946621ff3 Filipe Manana 2025-09-01  2719  			ret = overwrite_item(wc, path);
b50c6e250ef913 Josef Bacik   2013-04-25  2720  			if (ret)
b50c6e250ef913 Josef Bacik   2013-04-25  2721  				break;
2ac70946621ff3 Filipe Manana 2025-09-01  2722  		} else if (wc->log_key.type == BTRFS_INODE_REF_KEY ||
2ac70946621ff3 Filipe Manana 2025-09-01  2723  			   wc->log_key.type == BTRFS_INODE_EXTREF_KEY) {
2ac70946621ff3 Filipe Manana 2025-09-01  2724  			ret = add_inode_ref(wc, path);
7ebf381a69421a Filipe Manana 2025-07-11  2725  			if (ret)
b50c6e250ef913 Josef Bacik   2013-04-25  2726  				break;
2ac70946621ff3 Filipe Manana 2025-09-01  2727  		} else if (wc->log_key.type == BTRFS_EXTENT_DATA_KEY) {
2ac70946621ff3 Filipe Manana 2025-09-01  2728  			ret = replay_one_extent(wc, path);
b50c6e250ef913 Josef Bacik   2013-04-25  2729  			if (ret)
b50c6e250ef913 Josef Bacik   2013-04-25  2730  				break;
e02119d5a7b439 Chris Mason   2008-09-05  2731  		}
339d035424849c Filipe Manana 2021-10-25  2732  		/*
339d035424849c Filipe Manana 2021-10-25  2733  		 * We don't log BTRFS_DIR_ITEM_KEY keys anymore, only the
339d035424849c Filipe Manana 2021-10-25  2734  		 * BTRFS_DIR_INDEX_KEY items which we use to derive the
339d035424849c Filipe Manana 2021-10-25  2735  		 * BTRFS_DIR_ITEM_KEY items. If we are replaying a log from an
339d035424849c Filipe Manana 2021-10-25  2736  		 * older kernel with such keys, ignore them.
339d035424849c Filipe Manana 2021-10-25  2737  		 */
e02119d5a7b439 Chris Mason   2008-09-05  2738  	}
e02119d5a7b439 Chris Mason   2008-09-05  2739  	btrfs_free_path(path);
b50c6e250ef913 Josef Bacik   2013-04-25  2740  	return ret;
e02119d5a7b439 Chris Mason   2008-09-05  2741  }
e02119d5a7b439 Chris Mason   2008-09-05  2742  

:::::: The code at line 2649 was first introduced by commit
:::::: e02119d5a7b4396c5a872582fddc8bd6d305a70a Btrfs: Add a write ahead tree log to optimize synchronous operations

:::::: TO: Chris Mason <chris.mason@oracle.com>
:::::: CC: Chris Mason <chris.mason@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

