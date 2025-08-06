Return-Path: <linux-kernel+bounces-757250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B93B1BFD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 802CA7A6BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A03B1E230E;
	Wed,  6 Aug 2025 05:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+675fAs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C573FC7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754457335; cv=none; b=mdjvs1BzLk3fNC3r6ZBDjcUT+By3/4W6Z7btK19yoJ8I6dfXmxeXEl1ZfyRuQYUwiNMxW+y0+ErAeoxZmInXn3OEUDpmktKH+0Wan3Pss1SGBX1cdWFxHbLQnwkU61H1zqxOmzuw5RUZZQeGenkjHZIxKcvD6At6MEUxuS8Q3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754457335; c=relaxed/simple;
	bh=Phu7GDw6HlHqiB7OTMKgy1Rq4pUJLRJeX3kZiRsim+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dmwJ97JV/4h7PfFCfcz8leqtJ+8HNc3OVVyeQ75xjy5Gfom5tx+Qip6Oom3K6lXhrAMEYR1Um69Tz7Y1KtkdwHPloqz+hu25rwxbCeozpa0wc4P0FF1uu2amYQGv9/uYxMBvwDHUi7QmCB67BswXFyqvF685nr8AnioMbTaVYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+675fAs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754457333; x=1785993333;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Phu7GDw6HlHqiB7OTMKgy1Rq4pUJLRJeX3kZiRsim+Q=;
  b=X+675fAs8IDfqqCylAW0jCJtHb1loumT3e4dIOBHpJyyP5peQnwzaldV
   SjvtloR4zDvyHpFTk7hP+pit6OrqJonVcZZKjxeHIUmZ3Fja9lQsm8AGD
   9ZWOchcBMOglEkuvnYDyo8NxtXMfESuiKVegVo9amrWyQvHLqL68MLn9h
   ZnBYSgrJAH0rlw7H9K+5Z5Te4bO8MGbRRp7kdb/I5KtqW0LyDqP0vTbew
   9WFSf1wltM6V3X/hS3S2m31xf9yswe/ACR22wZWuQGaFSc7ihMkR6LlDI
   SQhdcWkA5eNCdtsOWaAd5Pa/cyeuPHNaZTAyUCUKqpMmHC5LMxrPo6LIq
   A==;
X-CSE-ConnectionGUID: oXwbZNXAT+iVlGA+phFruw==
X-CSE-MsgGUID: a7Hldq1CREmWjgN/ww/Wfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56726094"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56726094"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 22:15:33 -0700
X-CSE-ConnectionGUID: LEzVt5aoTN+dGen+NxgWgA==
X-CSE-MsgGUID: +hNJqmn3TiCjkD3LwW3SIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164583725"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa006.fm.intel.com with ESMTP; 05 Aug 2025 22:15:31 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujWUq-00028t-1Z;
	Wed, 06 Aug 2025 05:15:28 +0000
Date: Wed, 6 Aug 2025 07:14:50 +0200
From: kernel test robot <lkp@intel.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: lib/maple_tree.c:3783:19: warning: stack frame size (1032) exceeds
 limit (1024) in 'mas_wr_spanning_store'
Message-ID: <202508060727.LX1lVT66-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7881cd6886a89eda848192d3f5759ce08672e084
commit: bd164d81a767f33c30d5c5b50b775631699ee976 maple_tree: introduce store_type enum
date:   11 months ago
config: um-alldefconfig (https://download.01.org/0day-ci/archive/20250806/202508060727.LX1lVT66-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project faa4c4c2dc804c31845d8f036345fac00e016f2d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508060727.LX1lVT66-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508060727.LX1lVT66-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/maple_tree.c:351:21: warning: unused function 'mte_set_full' [-Wunused-function]
     351 | static inline void *mte_set_full(const struct maple_enode *node)
         |                     ^~~~~~~~~~~~
   lib/maple_tree.c:356:21: warning: unused function 'mte_clear_full' [-Wunused-function]
     356 | static inline void *mte_clear_full(const struct maple_enode *node)
         |                     ^~~~~~~~~~~~~~
   lib/maple_tree.c:361:20: warning: unused function 'mte_has_null' [-Wunused-function]
     361 | static inline bool mte_has_null(const struct maple_enode *node)
         |                    ^~~~~~~~~~~~
   lib/maple_tree.c:4161:20: warning: stack frame size (1080) exceeds limit (1024) in 'mas_wr_modify' [-Wframe-larger-than]
    4161 | static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
         |                    ^
>> lib/maple_tree.c:3783:19: warning: stack frame size (1032) exceeds limit (1024) in 'mas_wr_spanning_store' [-Wframe-larger-than]
    3783 | static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
         |                   ^
   5 warnings generated.


vim +/mas_wr_spanning_store +3783 lib/maple_tree.c

54a611b605901c Liam R. Howlett 2022-09-06  3724  
530f745c7620af Liam R. Howlett 2023-08-04  3725  static void mte_destroy_walk(struct maple_enode *, struct maple_tree *);
54a611b605901c Liam R. Howlett 2022-09-06  3726  /*
54a611b605901c Liam R. Howlett 2022-09-06  3727   * mas_new_root() - Create a new root node that only contains the entry passed
54a611b605901c Liam R. Howlett 2022-09-06  3728   * in.
54a611b605901c Liam R. Howlett 2022-09-06  3729   * @mas: The maple state
54a611b605901c Liam R. Howlett 2022-09-06  3730   * @entry: The entry to store.
54a611b605901c Liam R. Howlett 2022-09-06  3731   *
54a611b605901c Liam R. Howlett 2022-09-06  3732   * Only valid when the index == 0 and the last == ULONG_MAX
54a611b605901c Liam R. Howlett 2022-09-06  3733   *
54a611b605901c Liam R. Howlett 2022-09-06  3734   * Return 0 on error, 1 on success.
54a611b605901c Liam R. Howlett 2022-09-06  3735   */
54a611b605901c Liam R. Howlett 2022-09-06  3736  static inline int mas_new_root(struct ma_state *mas, void *entry)
54a611b605901c Liam R. Howlett 2022-09-06  3737  {
54a611b605901c Liam R. Howlett 2022-09-06  3738  	struct maple_enode *root = mas_root_locked(mas);
54a611b605901c Liam R. Howlett 2022-09-06  3739  	enum maple_type type = maple_leaf_64;
54a611b605901c Liam R. Howlett 2022-09-06  3740  	struct maple_node *node;
54a611b605901c Liam R. Howlett 2022-09-06  3741  	void __rcu **slots;
54a611b605901c Liam R. Howlett 2022-09-06  3742  	unsigned long *pivots;
54a611b605901c Liam R. Howlett 2022-09-06  3743  
54a611b605901c Liam R. Howlett 2022-09-06  3744  	if (!entry && !mas->index && mas->last == ULONG_MAX) {
54a611b605901c Liam R. Howlett 2022-09-06  3745  		mas->depth = 0;
54a611b605901c Liam R. Howlett 2022-09-06  3746  		mas_set_height(mas);
54a611b605901c Liam R. Howlett 2022-09-06  3747  		rcu_assign_pointer(mas->tree->ma_root, entry);
067311d33e650a Liam R. Howlett 2023-11-01  3748  		mas->status = ma_start;
54a611b605901c Liam R. Howlett 2022-09-06  3749  		goto done;
54a611b605901c Liam R. Howlett 2022-09-06  3750  	}
54a611b605901c Liam R. Howlett 2022-09-06  3751  
54a611b605901c Liam R. Howlett 2022-09-06  3752  	mas_node_count(mas, 1);
54a611b605901c Liam R. Howlett 2022-09-06  3753  	if (mas_is_err(mas))
54a611b605901c Liam R. Howlett 2022-09-06  3754  		return 0;
54a611b605901c Liam R. Howlett 2022-09-06  3755  
54a611b605901c Liam R. Howlett 2022-09-06  3756  	node = mas_pop_node(mas);
54a611b605901c Liam R. Howlett 2022-09-06  3757  	pivots = ma_pivots(node, type);
54a611b605901c Liam R. Howlett 2022-09-06  3758  	slots = ma_slots(node, type);
4ffc2ee2cf01f3 Liam R. Howlett 2023-08-04  3759  	node->parent = ma_parent_ptr(mas_tree_parent(mas));
54a611b605901c Liam R. Howlett 2022-09-06  3760  	mas->node = mt_mk_node(node, type);
067311d33e650a Liam R. Howlett 2023-11-01  3761  	mas->status = ma_active;
54a611b605901c Liam R. Howlett 2022-09-06  3762  	rcu_assign_pointer(slots[0], entry);
54a611b605901c Liam R. Howlett 2022-09-06  3763  	pivots[0] = mas->last;
54a611b605901c Liam R. Howlett 2022-09-06  3764  	mas->depth = 1;
54a611b605901c Liam R. Howlett 2022-09-06  3765  	mas_set_height(mas);
54a611b605901c Liam R. Howlett 2022-09-06  3766  	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
54a611b605901c Liam R. Howlett 2022-09-06  3767  
54a611b605901c Liam R. Howlett 2022-09-06  3768  done:
54a611b605901c Liam R. Howlett 2022-09-06  3769  	if (xa_is_node(root))
54a611b605901c Liam R. Howlett 2022-09-06  3770  		mte_destroy_walk(root, mas->tree);
54a611b605901c Liam R. Howlett 2022-09-06  3771  
54a611b605901c Liam R. Howlett 2022-09-06  3772  	return 1;
54a611b605901c Liam R. Howlett 2022-09-06  3773  }
54a611b605901c Liam R. Howlett 2022-09-06  3774  /*
54a611b605901c Liam R. Howlett 2022-09-06  3775   * mas_wr_spanning_store() - Create a subtree with the store operation completed
54a611b605901c Liam R. Howlett 2022-09-06  3776   * and new nodes where necessary, then place the sub-tree in the actual tree.
54a611b605901c Liam R. Howlett 2022-09-06  3777   * Note that mas is expected to point to the node which caused the store to
54a611b605901c Liam R. Howlett 2022-09-06  3778   * span.
54a611b605901c Liam R. Howlett 2022-09-06  3779   * @wr_mas: The maple write state
54a611b605901c Liam R. Howlett 2022-09-06  3780   *
54a611b605901c Liam R. Howlett 2022-09-06  3781   * Return: 0 on error, positive on success.
54a611b605901c Liam R. Howlett 2022-09-06  3782   */
54a611b605901c Liam R. Howlett 2022-09-06 @3783  static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
54a611b605901c Liam R. Howlett 2022-09-06  3784  {
54a611b605901c Liam R. Howlett 2022-09-06  3785  	struct maple_subtree_state mast;
54a611b605901c Liam R. Howlett 2022-09-06  3786  	struct maple_big_node b_node;
54a611b605901c Liam R. Howlett 2022-09-06  3787  	struct ma_state *mas;
54a611b605901c Liam R. Howlett 2022-09-06  3788  	unsigned char height;
54a611b605901c Liam R. Howlett 2022-09-06  3789  
54a611b605901c Liam R. Howlett 2022-09-06  3790  	/* Left and Right side of spanning store */
54a611b605901c Liam R. Howlett 2022-09-06  3791  	MA_STATE(l_mas, NULL, 0, 0);
54a611b605901c Liam R. Howlett 2022-09-06  3792  	MA_STATE(r_mas, NULL, 0, 0);
54a611b605901c Liam R. Howlett 2022-09-06  3793  	MA_WR_STATE(r_wr_mas, &r_mas, wr_mas->entry);
54a611b605901c Liam R. Howlett 2022-09-06  3794  	MA_WR_STATE(l_wr_mas, &l_mas, wr_mas->entry);
54a611b605901c Liam R. Howlett 2022-09-06  3795  
54a611b605901c Liam R. Howlett 2022-09-06  3796  	/*
54a611b605901c Liam R. Howlett 2022-09-06  3797  	 * A store operation that spans multiple nodes is called a spanning
54a611b605901c Liam R. Howlett 2022-09-06  3798  	 * store and is handled early in the store call stack by the function
54a611b605901c Liam R. Howlett 2022-09-06  3799  	 * mas_is_span_wr().  When a spanning store is identified, the maple
54a611b605901c Liam R. Howlett 2022-09-06  3800  	 * state is duplicated.  The first maple state walks the left tree path
54a611b605901c Liam R. Howlett 2022-09-06  3801  	 * to ``index``, the duplicate walks the right tree path to ``last``.
54a611b605901c Liam R. Howlett 2022-09-06  3802  	 * The data in the two nodes are combined into a single node, two nodes,
54a611b605901c Liam R. Howlett 2022-09-06  3803  	 * or possibly three nodes (see the 3-way split above).  A ``NULL``
54a611b605901c Liam R. Howlett 2022-09-06  3804  	 * written to the last entry of a node is considered a spanning store as
54a611b605901c Liam R. Howlett 2022-09-06  3805  	 * a rebalance is required for the operation to complete and an overflow
54a611b605901c Liam R. Howlett 2022-09-06  3806  	 * of data may happen.
54a611b605901c Liam R. Howlett 2022-09-06  3807  	 */
54a611b605901c Liam R. Howlett 2022-09-06  3808  	mas = wr_mas->mas;
54a611b605901c Liam R. Howlett 2022-09-06  3809  	trace_ma_op(__func__, mas);
54a611b605901c Liam R. Howlett 2022-09-06  3810  
54a611b605901c Liam R. Howlett 2022-09-06  3811  	if (unlikely(!mas->index && mas->last == ULONG_MAX))
54a611b605901c Liam R. Howlett 2022-09-06  3812  		return mas_new_root(mas, wr_mas->entry);
54a611b605901c Liam R. Howlett 2022-09-06  3813  	/*
54a611b605901c Liam R. Howlett 2022-09-06  3814  	 * Node rebalancing may occur due to this store, so there may be three new
54a611b605901c Liam R. Howlett 2022-09-06  3815  	 * entries per level plus a new root.
54a611b605901c Liam R. Howlett 2022-09-06  3816  	 */
54a611b605901c Liam R. Howlett 2022-09-06  3817  	height = mas_mt_height(mas);
54a611b605901c Liam R. Howlett 2022-09-06  3818  	mas_node_count(mas, 1 + height * 3);
54a611b605901c Liam R. Howlett 2022-09-06  3819  	if (mas_is_err(mas))
54a611b605901c Liam R. Howlett 2022-09-06  3820  		return 0;
54a611b605901c Liam R. Howlett 2022-09-06  3821  
54a611b605901c Liam R. Howlett 2022-09-06  3822  	/*
54a611b605901c Liam R. Howlett 2022-09-06  3823  	 * Set up right side.  Need to get to the next offset after the spanning
54a611b605901c Liam R. Howlett 2022-09-06  3824  	 * store to ensure it's not NULL and to combine both the next node and
54a611b605901c Liam R. Howlett 2022-09-06  3825  	 * the node with the start together.
54a611b605901c Liam R. Howlett 2022-09-06  3826  	 */
54a611b605901c Liam R. Howlett 2022-09-06  3827  	r_mas = *mas;
54a611b605901c Liam R. Howlett 2022-09-06  3828  	/* Avoid overflow, walk to next slot in the tree. */
54a611b605901c Liam R. Howlett 2022-09-06  3829  	if (r_mas.last + 1)
54a611b605901c Liam R. Howlett 2022-09-06  3830  		r_mas.last++;
54a611b605901c Liam R. Howlett 2022-09-06  3831  
54a611b605901c Liam R. Howlett 2022-09-06  3832  	r_mas.index = r_mas.last;
54a611b605901c Liam R. Howlett 2022-09-06  3833  	mas_wr_walk_index(&r_wr_mas);
54a611b605901c Liam R. Howlett 2022-09-06  3834  	r_mas.last = r_mas.index = mas->last;
54a611b605901c Liam R. Howlett 2022-09-06  3835  
54a611b605901c Liam R. Howlett 2022-09-06  3836  	/* Set up left side. */
54a611b605901c Liam R. Howlett 2022-09-06  3837  	l_mas = *mas;
54a611b605901c Liam R. Howlett 2022-09-06  3838  	mas_wr_walk_index(&l_wr_mas);
54a611b605901c Liam R. Howlett 2022-09-06  3839  
54a611b605901c Liam R. Howlett 2022-09-06  3840  	if (!wr_mas->entry) {
54a611b605901c Liam R. Howlett 2022-09-06  3841  		mas_extend_spanning_null(&l_wr_mas, &r_wr_mas);
54a611b605901c Liam R. Howlett 2022-09-06  3842  		mas->offset = l_mas.offset;
54a611b605901c Liam R. Howlett 2022-09-06  3843  		mas->index = l_mas.index;
54a611b605901c Liam R. Howlett 2022-09-06  3844  		mas->last = l_mas.last = r_mas.last;
54a611b605901c Liam R. Howlett 2022-09-06  3845  	}
54a611b605901c Liam R. Howlett 2022-09-06  3846  
54a611b605901c Liam R. Howlett 2022-09-06  3847  	/* expanding NULLs may make this cover the entire range */
54a611b605901c Liam R. Howlett 2022-09-06  3848  	if (!l_mas.index && r_mas.last == ULONG_MAX) {
54a611b605901c Liam R. Howlett 2022-09-06  3849  		mas_set_range(mas, 0, ULONG_MAX);
54a611b605901c Liam R. Howlett 2022-09-06  3850  		return mas_new_root(mas, wr_mas->entry);
54a611b605901c Liam R. Howlett 2022-09-06  3851  	}
54a611b605901c Liam R. Howlett 2022-09-06  3852  
54a611b605901c Liam R. Howlett 2022-09-06  3853  	memset(&b_node, 0, sizeof(struct maple_big_node));
54a611b605901c Liam R. Howlett 2022-09-06  3854  	/* Copy l_mas and store the value in b_node. */
0de56e38b307b0 Liam R. Howlett 2023-11-01  3855  	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
54a611b605901c Liam R. Howlett 2022-09-06  3856  	/* Copy r_mas into b_node. */
0de56e38b307b0 Liam R. Howlett 2023-11-01  3857  	if (r_mas.offset <= r_mas.end)
0de56e38b307b0 Liam R. Howlett 2023-11-01  3858  		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
54a611b605901c Liam R. Howlett 2022-09-06  3859  			   &b_node, b_node.b_end + 1);
54a611b605901c Liam R. Howlett 2022-09-06  3860  	else
54a611b605901c Liam R. Howlett 2022-09-06  3861  		b_node.b_end++;
54a611b605901c Liam R. Howlett 2022-09-06  3862  
54a611b605901c Liam R. Howlett 2022-09-06  3863  	/* Stop spanning searches by searching for just index. */
54a611b605901c Liam R. Howlett 2022-09-06  3864  	l_mas.index = l_mas.last = mas->index;
54a611b605901c Liam R. Howlett 2022-09-06  3865  
54a611b605901c Liam R. Howlett 2022-09-06  3866  	mast.bn = &b_node;
54a611b605901c Liam R. Howlett 2022-09-06  3867  	mast.orig_l = &l_mas;
54a611b605901c Liam R. Howlett 2022-09-06  3868  	mast.orig_r = &r_mas;
54a611b605901c Liam R. Howlett 2022-09-06  3869  	/* Combine l_mas and r_mas and split them up evenly again. */
54a611b605901c Liam R. Howlett 2022-09-06  3870  	return mas_spanning_rebalance(mas, &mast, height + 1);
54a611b605901c Liam R. Howlett 2022-09-06  3871  }
54a611b605901c Liam R. Howlett 2022-09-06  3872  

:::::: The code at line 3783 was first introduced by commit
:::::: 54a611b605901c7d5d05b6b8f5d04a6ceb0962aa Maple Tree: add new data structure

:::::: TO: Liam R. Howlett <Liam.Howlett@Oracle.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

