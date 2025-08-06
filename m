Return-Path: <linux-kernel+bounces-757353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1C1B1C128
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF0418A174A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061CF213E94;
	Wed,  6 Aug 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uh88DQL+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6851EB9F2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464724; cv=none; b=bwpd90Syz89nrR/o3cCiN1tojACYpxgHS+C7jDW2SMOrMQpZ1EL3HfHNf5wAP3l9OJaTm9TWwfgIk5Qw4dvISAr8bKMHWstGiNGh63zyje3b09GmGETaSAzN17RW2NGrePjmhiXS+xXvZEt2ITqqngciI5csWMoZOiTzSxCCC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464724; c=relaxed/simple;
	bh=nNxhoKULW/u7Nvh1p4ZhOqCELveHSO6eUylzpEfTeqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hN7zeiYJBoekz4XBhM/UQTFcNgRJZOGznnIkRL2gdO/3vBz7pmjRiuLga4s+it/+tuQwJpA6fCC2Kt3YM1Asb/6pF68zRrEQWX6E59fFh/9oCq2nLgGBPUR+5VMyPKaMepFzBsDrYGCPDUcwN9Zt41zMUFRRNqpxMADH3wlpoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uh88DQL+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754464722; x=1786000722;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nNxhoKULW/u7Nvh1p4ZhOqCELveHSO6eUylzpEfTeqE=;
  b=Uh88DQL+b1jBCpc8VmN7AffcryBteb0nU1dPwVMIGk9MikCqZJlT9uYp
   UggS+NybswtPxzSFrx/oF+hFpNJJQ6jEjASIFve+su1Cl057vhy+pKQbO
   OgMEkZvKznJmUGZPP/JnhamiyAwUMVPcSwtfkN6vGbiLufQjKs47hbMZc
   nL6hXMK2Pz22AlVobwnRhNqoHKwbxK/gCM1sijbHSa/Bn/MO6o0QTnEPJ
   svw2bhHdk+OZ2RQz7I36+3/aUBvKF4Tl7MNaVVMx1FlJ/MGyksewB1z1U
   8/LMs/0UQ+I7nrz8TbsYJEILlaahiGyh+45Pi5O9x1ptVtJzjc6Lm5uIK
   w==;
X-CSE-ConnectionGUID: YPMSJwaFRZmGH/ommQl9ZA==
X-CSE-MsgGUID: +EcAAhJ6QIC1fiZPj/xa9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="68147896"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="68147896"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 00:18:40 -0700
X-CSE-ConnectionGUID: CqvA096ZSvWDZuOfLE9yzg==
X-CSE-MsgGUID: 8AqaE68FQEWjiOwfSZkBHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="201879694"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2025 00:18:38 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujYPz-00029j-2C;
	Wed, 06 Aug 2025 07:18:35 +0000
Date: Wed, 6 Aug 2025 09:18:07 +0200
From: kernel test robot <lkp@intel.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: lib/maple_tree.c:4206:20: warning: stack frame size (1064) exceeds
 limit (1024) in 'mas_wr_store_entry'
Message-ID: <202508060948.H36grbYA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   479058002c32b77acac43e883b92174e22c4be2d
commit: 1fd7c4f3228e9775c97b25a6e5e2420df8cf0e76 maple_tree: convert mas_insert() to preallocate nodes
date:   11 months ago
config: um-alldefconfig (https://download.01.org/0day-ci/archive/20250806/202508060948.H36grbYA-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project faa4c4c2dc804c31845d8f036345fac00e016f2d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508060948.H36grbYA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508060948.H36grbYA-lkp@intel.com/

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
   lib/maple_tree.c:4161:20: warning: unused function 'mas_wr_modify' [-Wunused-function]
    4161 | static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
         |                    ^~~~~~~~~~~~~
>> lib/maple_tree.c:4206:20: warning: stack frame size (1064) exceeds limit (1024) in 'mas_wr_store_entry' [-Wframe-larger-than]
    4206 | static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
         |                    ^
   lib/maple_tree.c:3783:21: warning: stack frame size (1032) exceeds limit (1024) in 'mas_wr_spanning_store' [-Wframe-larger-than]
    3783 | static noinline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
         |                     ^
   6 warnings generated.


vim +/mas_wr_store_entry +4206 lib/maple_tree.c

54a611b605901c Liam R. Howlett 2022-09-06  4198  
54a611b605901c Liam R. Howlett 2022-09-06  4199  /*
54a611b605901c Liam R. Howlett 2022-09-06  4200   * mas_wr_store_entry() - Internal call to store a value
54a611b605901c Liam R. Howlett 2022-09-06  4201   * @mas: The maple state
54a611b605901c Liam R. Howlett 2022-09-06  4202   * @entry: The entry to store.
54a611b605901c Liam R. Howlett 2022-09-06  4203   *
54a611b605901c Liam R. Howlett 2022-09-06  4204   * Return: The contents that was stored at the index.
54a611b605901c Liam R. Howlett 2022-09-06  4205   */
739820a6178b03 JaeJoon Jung    2024-06-14 @4206  static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
54a611b605901c Liam R. Howlett 2022-09-06  4207  {
54a611b605901c Liam R. Howlett 2022-09-06  4208  	struct ma_state *mas = wr_mas->mas;
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4209  	unsigned char new_end = mas_wr_new_end(wr_mas);
54a611b605901c Liam R. Howlett 2022-09-06  4210  
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4211  	switch (mas->store_type) {
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4212  	case wr_invalid:
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4213  		MT_BUG_ON(mas->tree, 1);
739820a6178b03 JaeJoon Jung    2024-06-14  4214  		return;
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4215  	case wr_new_root:
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4216  		mas_new_root(mas, wr_mas->entry);
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4217  		break;
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4218  	case wr_store_root:
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4219  		mas_store_root(mas, wr_mas->entry);
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4220  		break;
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4221  	case wr_exact_fit:
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4222  		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4223  		if (!!wr_mas->entry ^ !!wr_mas->content)
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4224  			mas_update_gap(mas);
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4225  		break;
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4226  	case wr_append:
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4227  		mas_wr_append(wr_mas, new_end);
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4228  		break;
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4229  	case wr_slot_store:
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4230  		mas_wr_slot_store(wr_mas);
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4231  		break;
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4232  	case wr_node_store:
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4233  		mas_wr_node_store(wr_mas, new_end);
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4234  		break;
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4235  	case wr_spanning_store:
54a611b605901c Liam R. Howlett 2022-09-06  4236  		mas_wr_spanning_store(wr_mas);
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4237  		break;
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4238  	case wr_split_store:
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4239  	case wr_rebalance:
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4240  		mas_wr_bnode(wr_mas);
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4241  		break;
54a611b605901c Liam R. Howlett 2022-09-06  4242  	}
54a611b605901c Liam R. Howlett 2022-09-06  4243  
580fcbd67ce2cd Sidhartha Kumar 2024-08-14  4244  	return;
54a611b605901c Liam R. Howlett 2022-09-06  4245  }
54a611b605901c Liam R. Howlett 2022-09-06  4246  

:::::: The code at line 4206 was first introduced by commit
:::::: 739820a6178b03b1b6b99a467c85e9e7146d51c1 maple_tree: modified return type of mas_wr_store_entry()

:::::: TO: JaeJoon Jung <rgbi3307@gmail.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

