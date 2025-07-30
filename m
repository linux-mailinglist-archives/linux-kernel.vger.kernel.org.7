Return-Path: <linux-kernel+bounces-750373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C130B15A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396155A1AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C8299950;
	Wed, 30 Jul 2025 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqX2wqJj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DB268C40
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864116; cv=none; b=kEIZ9OabxjF1t4uRtZfRaaDJU0BMJagbRaTsRSg0Nk24gbe/oMj+d8vS46GFaloA4QOzZ2wjIZiFO88C4vGCxaErtiQX/AlkobjttWSEWRzbBjP83olM3lVMOcRitFdIRTfGwJzkK0NqaK53KrybTlKzYSyIuVIYgVHEHV49JNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864116; c=relaxed/simple;
	bh=as+n3pxiGRQ/kvnFsuGMC8r1E3u+Q5ggaFjAAcNwmGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VpgRykRkQ9OPEQULj+Ld81tKq1vcfOdk6bLJ5thBsAFnbv/7fWltWK8uM/+YqPQxNNt3hFrSqomk4fEOX19U//i0209/W9C4fDO2jWIN0vbSuiC++6PMlEZxmnHAkxOaWXjfLpyxudPXh/5JtU5wDxOSq0fhfzMj0Czuf9d4T+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqX2wqJj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753864114; x=1785400114;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=as+n3pxiGRQ/kvnFsuGMC8r1E3u+Q5ggaFjAAcNwmGw=;
  b=dqX2wqJjjZlqkEla3Hg3xuTzeslwArbisWwdwSUY3fLctx1phpZhokm5
   tyC8MBxoiFW4cNLfiDZcacSWhrYOltbhixyu6TppUzyF7F5emN8YWWzkG
   A/NQa8xYC0otAhSisq6xdgGBX6K7V0x91QKNeOiQg/FlNGdhc9sEpgci8
   tNpzy3sMjJscsm70Ej2Q9EUjGaoXqale7mDgjki+4VnR4p3KZvGcPK2YZ
   F+BM4MLNac7P8Vpva7L08oPYrusP65Tv6Alj/w51U/GIucp4C0mRscFxs
   M/k/iWvVoPWJzOX0ItYcokUkcbusNGdhcUbSyIDR2oa73Evr7f3RBfnkL
   A==;
X-CSE-ConnectionGUID: PU6awd20RSOQXqn41qXOFw==
X-CSE-MsgGUID: 9h3QtqzRToeQTK+PD/jYeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="55855250"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="55855250"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 01:28:33 -0700
X-CSE-ConnectionGUID: HzR/XW3vQu69eE1suOYAKA==
X-CSE-MsgGUID: yYOErs37Qay4VxUuOESyjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162950342"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Jul 2025 01:28:32 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh2Am-0002DA-3D;
	Wed, 30 Jul 2025 08:28:28 +0000
Date: Wed, 30 Jul 2025 16:27:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kara <jack@suse.cz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: vmlinux.o: warning: objtool: __isofs_iget+0x9bc: sibling call from
 callable instruction with modified stack frame
Message-ID: <202507301645.x47E3dIH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b290aae788e06561754b28c6842e4080957d3f7
commit: 0a9e7405131380b57e155f10242b2e25d2e51852 isofs: Verify inode mode when loading from disk
date:   3 weeks ago
config: loongarch-randconfig-002-20250730 (https://download.01.org/0day-ci/archive/20250730/202507301645.x47E3dIH-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507301645.x47E3dIH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507301645.x47E3dIH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: cg_sockopt_convert_ctx_access+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cgroup_common_func_proto+0xe0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_cgroup_atype_find+0x3c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __bpf_core_types_are_compat+0x230: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_core_parse_spec+0x100: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_core_patch_insn+0xe0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_core_format_spec+0x118: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: core_relo_kind_str+0x3c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_core_calc_relo_insn+0x2f8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_core_calc_relo+0xf8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __bpf_core_types_match+0x10c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_core_match_member+0x478: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_core_calc_field_relo+0x500: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_core_calc_type_relo+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btf_field_iter_init+0xc0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btf_relocate+0x98c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: scftorture_invoker+0x3e8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: generic_fadvise+0x130: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: reclaim_throttle+0xd4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: shrink_lruvec+0x548: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: shmem_parse_one+0x90: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: shmem_show_options+0x16c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __list_lru_walk_one.llvm.16695623116034764270+0x1ec: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: generic_access_phys+0x12c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: alloc_vmap_area+0x958: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: pcpu_get_vm_areas+0xa44: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: can_modify_vma_madv+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __rmqueue_pcplist+0x26c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: slab_memory_callback+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: isolate_lock_cluster+0xb0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sys_get_mempolicy+0x4cc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: mempolicy_slab_node+0xa0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: policy_nodemask+0x70: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __mpol_equal+0x138: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: mpol_misplaced+0x164: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: mpol_parse_str+0x114: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: mpol_to_str+0x14c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: madvise_collapse+0x5c0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gup_test_ioctl+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: damos_commit_filter_arg+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: damon_pa_scheme_score+0x58: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: damon_pa_apply_scheme+0x74: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: damos_pa_filter_out+0xbc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: generic_file_llseek_size+0x68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: generic_llseek_cookie+0xa4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: default_llseek+0x90: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fifo_open.llvm.4537652392892592089+0xdc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: may_open+0x80: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: do_mknodat+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sys_fcntl+0x100: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_fcntl_cmd+0x44: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: file_ioctl+0x6c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ns_ioctl.llvm.1994339309172771654+0xbc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sys_fsconfig+0xa4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: pidfd_ioctl+0x6e0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __block_write_begin_int+0x55c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fsnotify_data_inode+0x48: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fsnotify+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fsnotify_handle_inode_event+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fsnotify_conn_mask+0x54: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __fsnotify_recalc_mask+0x16c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fsnotify_detach_connector_from_object+0xd0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fsnotify_find_mark+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ep_poll_callback+0x12c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: signalfd_read_iter+0x2a0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: posix_acl_valid+0xa0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: posix_acl_equiv_mode+0x94: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: posix_acl_permission+0x94: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: posix_acl_create_masq+0xac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __posix_acl_chmod+0xb4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: posix_acl_from_xattr+0x164: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __iomap_dio_rw+0x550: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: iomap_to_fiemap+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: prepare_warning+0x6c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: do_quotactl+0x140: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: quotactl_cmd_write+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4fs_dirhash+0x128: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __ext4_iget+0xf58: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4_ioctl+0xf4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4_mb_good_group+0xe0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: dx_probe+0xd4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: _ext4_show_options+0xa60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4_parse_param+0x218: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4_fill_super+0x90c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4_load_and_init_journal+0xe54: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4_attr_show+0x54: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4_attr_store+0x328: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4_fc_replay+0x10c0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ext4_get_acl+0x2a0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __ext4_set_acl+0x19c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __jbd2_journal_file_buffer+0x1f4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __jbd2_journal_temp_unlink_buffer+0xf0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: squashfs_read_inode+0x1ac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fat_parse_param+0x108: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fat_fill_super+0x318: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: vfat_add_entry+0x4f8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: exfat_get_entry_type+0xd0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: exfat_init_dir_entry+0xdc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: exfat_get_dentry_set+0x11c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: exfat_parse_param+0x80: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: __isofs_iget+0x9bc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: isofs_parse_param+0xa8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: parse_rock_ridge_inode_internal+0x3ac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rock_ridge_symlink_read_folio.llvm.395270614351283941+0x29c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: hfsplus_iget+0x130: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: hfsplus_write_inode+0xf0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: hfsplus_parse_param+0xe4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: hfs_parse_param+0xb0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ecryptfs_inode_set+0x100: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ecryptfs_parse_param+0x98: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ecryptfs_decode_and_decrypt_filename+0x210: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: vxfs_bmap1+0x6c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: vxfs_bmap_indir+0x198: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: hpfs_readdir.llvm.5778750988433584430+0x240: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: hpfs_chk_name+0x124: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: hpfs_parse_param+0x84: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: valid_windows_name+0x100: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ni_parse_reparse+0x310: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: log_replay+0x3294: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: do_action+0x790: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_index_root+0x130: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ntfs_iget5+0x129c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: run_pack+0x888: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: run_unpack+0x16c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: run_get_highest_vcn+0xbc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ntfs_fs_parse_param+0x80: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: efs_iget+0x354: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_compress+0x9c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_link_node_ref+0x160: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_do_read_inode+0xa8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_do_read_inode_internal+0x17d8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_scan_medium+0x730: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_garbage_collect_pass+0x784: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_iget+0x184: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_listxattr+0x16c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_get_acl+0x2a0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __jffs2_set_acl+0x120: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_sum_add_mem+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_sum_add_kvec+0xcc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_sum_scan_sumnode+0x328: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jffs2_sum_write_sumnode+0x224: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: affs_parse_param+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: affs_fill_super+0x5ec: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: affs_iget+0x3a8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: autofs_parse_param+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: autofs_notify_daemon+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: adfs_parse_param+0x7c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __fuse_simple_request+0x1c0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_dev_do_write+0x1a4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_dentry_revalidate.llvm.14650613247705834737+0x404: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_valid_type+0x54: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_invalid_attr+0x64: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_lookup_name+0x210: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_update_get_attr.llvm.14650613247705834737+0x434: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_do_setattr+0x69c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_do_getattr+0x164: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: create_new_entry+0x200: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_file_llseek+0x6c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_init_inode+0xe4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fuse_parse_param+0xe0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ovl_create_real+0xd0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ovl_parse_param+0xf0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ovl_do_parse_layer+0x2a0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: get_opname_string+0xa0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: fsid_of_op+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: orangefs_devreq_ioctl.llvm.11983675510506615328+0xbc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __udf_iget+0xbd4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: udf_parse_param+0x98: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: udf_process_sequence+0x164: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: udf_symlink_filler.llvm.10127036170908717075+0x1ec: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jfs_parse_param+0x94: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: copy_from_dinode+0x70: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_ag_resv_needed+0x54: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_ag_resv_alloc_extent+0x58: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_ag_resv_free_extent+0x64: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_attr_set_iter+0x70: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_attr_set+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_bmap_add_extent_unwritten_real+0x5d8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_bmap_add_extent_hole_real+0x4f0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_bmap_del_extent_delay+0x2d0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_bmap_del_extent_cow+0x1c8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_bmap_add_extent_delay_real+0x668: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_bmap_del_extent_real+0x500: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_bmbt_init_cursor+0xf4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_mode_to_ftype+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_dir_createname_args+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_dir_lookup_args+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_dir_removename_args+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_dir_replace_args+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_iformat_data_fork+0xf4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_iflush_fork+0x18c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_dinode_verify+0x618: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_dinode_verify_forkoff+0x6c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_dinode_verify_fork+0x320: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_inode_init+0x2b0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __xfs_rmap_finish_intent+0x64: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_rmap_convert+0x66c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_rmap_convert_shared+0x4d8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_refcount_finish_one+0x190: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_rtrefcount_finish_one+0x158: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xfs_validate_sb_common+0x824: sibling call from callable instruction with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

