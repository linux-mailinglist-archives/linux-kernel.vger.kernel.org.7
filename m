Return-Path: <linux-kernel+bounces-615419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CBBA97CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 04:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E507A4614
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84764262FFE;
	Wed, 23 Apr 2025 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzYAGK2f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC02620E7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745375858; cv=none; b=iV+bbUEXAvx+bF88Upp06MLNbs524SUXEjZD9CFTKay83b1bVFa4kWLC5UckYsgURGW+Bqsj1ghWlUsdqQZr3aqr907gaZYKXaMHNDJYH507VoOBBhTSOSU5/oxkxwiM9LG970aMO1V6ovqCRw/YSDzbKSbI6s6nqVNGxkjqnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745375858; c=relaxed/simple;
	bh=D9lEisyhf1Jeo4cwBTYizw2974eKj7vbdo+IZSDFXEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LVnUZweAJpBO/5t0cQvyWrW7QehsK8edx4ST4eR3BTr6CNM1+Uh1xNDXfhpFbb6bgD2KY0XREyMoSCp0c84jvECD6VsxrBJdYaAfF6xUFyXw5252syy1fjAJEpCvv65lDhyVTrBlGqq98dx3e3hFxEXnXM2uHZKoKSs1lYXSPzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzYAGK2f; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745375856; x=1776911856;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D9lEisyhf1Jeo4cwBTYizw2974eKj7vbdo+IZSDFXEA=;
  b=lzYAGK2f/iBJV7E33TRXejTSRD8VxDGfl08EiK0046suCo3bYTkeizQh
   hmy5ja/515Q/tsaCzBJ3NP7PIsRmKu1kL92iLepSwHJbBHuBeSaHBnz0u
   8em7lCFrfhZd/B9cbEUGlONcx6ZF2xTSVuVz4oWSdH1B+yJzuaPZGGA4T
   VS8b6uDgY9weVdi99q2siZPg/VmTXVKwE1kRX9ZiKqNh8pGq3pn6i/seb
   lc6DaVqptycvtnTIEB/d9bpb7ZeOhgAJBm8q+YdTXVRj2YKNphD6EiH/S
   jUcufbYZIdmIxalz6onS28yOAukyw2Ffbigyq/L6Xdn2RBqjpCSfcMdAU
   g==;
X-CSE-ConnectionGUID: kWeTka6QQI+Qb36MmnCpAA==
X-CSE-MsgGUID: /Tdya+jSSAmGcMPTdJ4rlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57611633"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="57611633"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 19:37:35 -0700
X-CSE-ConnectionGUID: wTiubxkXSyyO4yakYWfzCQ==
X-CSE-MsgGUID: uS353M3ZToO5V8pe2fJCIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="132722172"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 22 Apr 2025 19:37:33 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7PzP-0001Xg-1u;
	Wed, 23 Apr 2025 02:37:31 +0000
Date: Wed, 23 Apr 2025 10:36:43 +0800
From: kernel test robot <lkp@intel.com>
To: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: drivers/gpu/drm/xe/xe_migrate.c:304:52: error: result of comparison
 of constant 274877906944 with expression of type 'resource_size_t' (aka
 'unsigned int') is always true
Message-ID: <202504231025.G7B2ddED-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Akshata,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bc3372351d0c8b2726b7d4229b878342e3e6b0e8
commit: 8d79acd567db183e675cccc6cc737d2959e2a2d9 drm/xe/migrate: Add helper function to program identity map
date:   9 months ago
config: i386-randconfig-052-20250423 (https://download.01.org/0day-ci/archive/20250423/202504231025.G7B2ddED-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250423/202504231025.G7B2ddED-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504231025.G7B2ddED-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/xe/xe_migrate.c:12:
   In file included from include/drm/ttm/ttm_tt.h:30:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/xe/xe_migrate.c:304:52: error: result of comparison of constant 274877906944 with expression of type 'resource_size_t' (aka 'unsigned int') is always true [-Werror,-Wtautological-constant-out-of-range-compare]
     304 |                 xe_assert(xe, (xe->mem.vram.actual_physical_size <= SZ_256G));
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_assert.h:108:54: note: expanded from macro 'xe_assert'
     108 | #define xe_assert(xe, condition) xe_assert_msg((xe), condition, "")
         |                                  ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_assert.h:111:24: note: expanded from macro 'xe_assert_msg'
     111 |         __xe_assert_msg(__xe, condition,                                                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     112 |                         "platform: %s subplatform: %d\n"                                        \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     113 |                         "graphics: %s %u.%02u step %s\n"                                        \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     114 |                         "media: %s %u.%02u step %s\n"                                           \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     115 |                         msg,                                                                    \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     116 |                         __xe->info.platform_name, __xe->info.subplatform,                       \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                         __xe->info.graphics_name,                                               \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     118 |                         __xe->info.graphics_verx100 / 100,                                      \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     119 |                         __xe->info.graphics_verx100 % 100,                                      \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     120 |                         xe_step_name(__xe->info.step.graphics),                                 \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     121 |                         __xe->info.media_name,                                                  \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     122 |                         __xe->info.media_verx100 / 100,                                         \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     123 |                         __xe->info.media_verx100 % 100,                                         \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     124 |                         xe_step_name(__xe->info.step.media),                                    \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     125 |                         ## arg);                                                                \
         |                         ~~~~~~~
   drivers/gpu/drm/xe/xe_assert.h:84:31: note: expanded from macro '__xe_assert_msg'
      84 |         (void)drm_WARN(&(xe)->drm, !(condition), "[" DRM_NAME "] Assertion `%s` failed!\n" msg, \
         |               ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      85 |                        __stringify(condition), ## arg);                                         \
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_print.h:635:7: note: expanded from macro 'drm_WARN'
     635 |         WARN(condition, "%s %s: [drm] " format,                         \
         |         ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     636 |                         dev_driver_string((drm)->dev),                  \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     637 |                         dev_name((drm)->dev), ## arg)
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:132:25: note: expanded from macro 'WARN'
     132 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   2 errors generated.


vim +304 drivers/gpu/drm/xe/xe_migrate.c

   177	
   178	static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
   179					 struct xe_vm *vm)
   180	{
   181		struct xe_device *xe = tile_to_xe(tile);
   182		u16 pat_index = xe->pat.idx[XE_CACHE_WB];
   183		u8 id = tile->id;
   184		u32 num_entries = NUM_PT_SLOTS, num_level = vm->pt_root[id]->level,
   185		    num_setup = num_level + 1;
   186		u32 map_ofs, level, i;
   187		struct xe_bo *bo, *batch = tile->mem.kernel_bb_pool->bo;
   188		u64 entry, pt30_ofs;
   189	
   190		/* Can't bump NUM_PT_SLOTS too high */
   191		BUILD_BUG_ON(NUM_PT_SLOTS > SZ_2M/XE_PAGE_SIZE);
   192		/* Must be a multiple of 64K to support all platforms */
   193		BUILD_BUG_ON(NUM_PT_SLOTS * XE_PAGE_SIZE % SZ_64K);
   194		/* And one slot reserved for the 4KiB page table updates */
   195		BUILD_BUG_ON(!(NUM_KERNEL_PDE & 1));
   196	
   197		/* Need to be sure everything fits in the first PT, or create more */
   198		xe_tile_assert(tile, m->batch_base_ofs + batch->size < SZ_2M);
   199	
   200		bo = xe_bo_create_pin_map(vm->xe, tile, vm,
   201					  num_entries * XE_PAGE_SIZE,
   202					  ttm_bo_type_kernel,
   203					  XE_BO_FLAG_VRAM_IF_DGFX(tile) |
   204					  XE_BO_FLAG_PINNED);
   205		if (IS_ERR(bo))
   206			return PTR_ERR(bo);
   207	
   208		/* PT31 reserved for 2M identity map */
   209		pt30_ofs = bo->size - 2 * XE_PAGE_SIZE;
   210		entry = vm->pt_ops->pde_encode_bo(bo, pt30_ofs, pat_index);
   211		xe_pt_write(xe, &vm->pt_root[id]->bo->vmap, 0, entry);
   212	
   213		map_ofs = (num_entries - num_setup) * XE_PAGE_SIZE;
   214	
   215		/* Map the entire BO in our level 0 pt */
   216		for (i = 0, level = 0; i < num_entries; level++) {
   217			entry = vm->pt_ops->pte_encode_bo(bo, i * XE_PAGE_SIZE,
   218							  pat_index, 0);
   219	
   220			xe_map_wr(xe, &bo->vmap, map_ofs + level * 8, u64, entry);
   221	
   222			if (vm->flags & XE_VM_FLAG_64K)
   223				i += 16;
   224			else
   225				i += 1;
   226		}
   227	
   228		if (!IS_DGFX(xe)) {
   229			/* Write out batch too */
   230			m->batch_base_ofs = NUM_PT_SLOTS * XE_PAGE_SIZE;
   231			for (i = 0; i < batch->size;
   232			     i += vm->flags & XE_VM_FLAG_64K ? XE_64K_PAGE_SIZE :
   233			     XE_PAGE_SIZE) {
   234				entry = vm->pt_ops->pte_encode_bo(batch, i,
   235								  pat_index, 0);
   236	
   237				xe_map_wr(xe, &bo->vmap, map_ofs + level * 8, u64,
   238					  entry);
   239				level++;
   240			}
   241			if (xe->info.has_usm) {
   242				xe_tile_assert(tile, batch->size == SZ_1M);
   243	
   244				batch = tile->primary_gt->usm.bb_pool->bo;
   245				m->usm_batch_base_ofs = m->batch_base_ofs + SZ_1M;
   246				xe_tile_assert(tile, batch->size == SZ_512K);
   247	
   248				for (i = 0; i < batch->size;
   249				     i += vm->flags & XE_VM_FLAG_64K ? XE_64K_PAGE_SIZE :
   250				     XE_PAGE_SIZE) {
   251					entry = vm->pt_ops->pte_encode_bo(batch, i,
   252									  pat_index, 0);
   253	
   254					xe_map_wr(xe, &bo->vmap, map_ofs + level * 8, u64,
   255						  entry);
   256					level++;
   257				}
   258			}
   259		} else {
   260			u64 batch_addr = xe_bo_addr(batch, 0, XE_PAGE_SIZE);
   261	
   262			m->batch_base_ofs = xe_migrate_vram_ofs(xe, batch_addr);
   263	
   264			if (xe->info.has_usm) {
   265				batch = tile->primary_gt->usm.bb_pool->bo;
   266				batch_addr = xe_bo_addr(batch, 0, XE_PAGE_SIZE);
   267				m->usm_batch_base_ofs = xe_migrate_vram_ofs(xe, batch_addr);
   268			}
   269		}
   270	
   271		for (level = 1; level < num_level; level++) {
   272			u32 flags = 0;
   273	
   274			if (vm->flags & XE_VM_FLAG_64K && level == 1)
   275				flags = XE_PDE_64K;
   276	
   277			entry = vm->pt_ops->pde_encode_bo(bo, map_ofs + (u64)(level - 1) *
   278							  XE_PAGE_SIZE, pat_index);
   279			xe_map_wr(xe, &bo->vmap, map_ofs + XE_PAGE_SIZE * level, u64,
   280				  entry | flags);
   281		}
   282	
   283		/* Write PDE's that point to our BO. */
   284		for (i = 0; i < map_ofs / PAGE_SIZE; i++) {
   285			entry = vm->pt_ops->pde_encode_bo(bo, (u64)i * XE_PAGE_SIZE,
   286							  pat_index);
   287	
   288			xe_map_wr(xe, &bo->vmap, map_ofs + XE_PAGE_SIZE +
   289				  (i + 1) * 8, u64, entry);
   290		}
   291	
   292		/* Set up a 1GiB NULL mapping at 255GiB offset. */
   293		level = 2;
   294		xe_map_wr(xe, &bo->vmap, map_ofs + XE_PAGE_SIZE * level + 255 * 8, u64,
   295			  vm->pt_ops->pte_encode_addr(xe, 0, pat_index, level, IS_DGFX(xe), 0)
   296			  | XE_PTE_NULL);
   297		m->cleared_mem_ofs = (255ULL << xe_pt_shift(level));
   298	
   299		/* Identity map the entire vram at 256GiB offset */
   300		if (IS_DGFX(xe)) {
   301			u64 pt31_ofs = bo->size - XE_PAGE_SIZE;
   302	
   303			xe_migrate_program_identity(xe, vm, bo, map_ofs, 256, pat_index, pt31_ofs);
 > 304			xe_assert(xe, (xe->mem.vram.actual_physical_size <= SZ_256G));
   305		}
   306	
   307		/*
   308		 * Example layout created above, with root level = 3:
   309		 * [PT0...PT7]: kernel PT's for copy/clear; 64 or 4KiB PTE's
   310		 * [PT8]: Kernel PT for VM_BIND, 4 KiB PTE's
   311		 * [PT9...PT27]: Userspace PT's for VM_BIND, 4 KiB PTE's
   312		 * [PT28 = PDE 0] [PT29 = PDE 1] [PT30 = PDE 2] [PT31 = 2M vram identity map]
   313		 *
   314		 * This makes the lowest part of the VM point to the pagetables.
   315		 * Hence the lowest 2M in the vm should point to itself, with a few writes
   316		 * and flushes, other parts of the VM can be used either for copying and
   317		 * clearing.
   318		 *
   319		 * For performance, the kernel reserves PDE's, so about 20 are left
   320		 * for async VM updates.
   321		 *
   322		 * To make it easier to work, each scratch PT is put in slot (1 + PT #)
   323		 * everywhere, this allows lockless updates to scratch pages by using
   324		 * the different addresses in VM.
   325		 */
   326	#define NUM_VMUSA_UNIT_PER_PAGE	32
   327	#define VM_SA_UPDATE_UNIT_SIZE		(XE_PAGE_SIZE / NUM_VMUSA_UNIT_PER_PAGE)
   328	#define NUM_VMUSA_WRITES_PER_UNIT	(VM_SA_UPDATE_UNIT_SIZE / sizeof(u64))
   329		drm_suballoc_manager_init(&m->vm_update_sa,
   330					  (size_t)(map_ofs / XE_PAGE_SIZE - NUM_KERNEL_PDE) *
   331					  NUM_VMUSA_UNIT_PER_PAGE, 0);
   332	
   333		m->pt_bo = bo;
   334		return 0;
   335	}
   336	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

