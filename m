Return-Path: <linux-kernel+bounces-751607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CF0B16B69
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29FC1AA1321
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D923E25B;
	Thu, 31 Jul 2025 05:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arli8rnz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E0EC5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938245; cv=none; b=G5GcgVQlt/j6wZWJMucn9eIL9hPo+nSz1jpDLOwDm4doiXWOcj3/fUeEILotthspSSWmjeBF9C28urG0c/UipMqoYiAhS8fxOkCybyg9DAVx906THuA0z2Qqjm/zzXo0oINA5injyU7SM54usOeZjKZya6YPFdWTxRLTSifEsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938245; c=relaxed/simple;
	bh=HLh+SzsBDaSybeLdR8dTKEfaf9k9S0tpDAjlGLoQvC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VVKb3ui6hDPGaPf2brv7oj2YHcTmRSM94GEJjYA6MhcAspVg3TjnD1HTb82aofyvgWtLgBYZMZxyTUSqsWQZz/HvS8oVjMboMnEfXUFHYVFH73D6Qf5mD670fComwt+CVZguBRzWExORiZmcGiXYZihmmhVQYP7namPUeP0mk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arli8rnz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753938243; x=1785474243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HLh+SzsBDaSybeLdR8dTKEfaf9k9S0tpDAjlGLoQvC4=;
  b=arli8rnzPhbSIRxTqrXrV5dHKMNLtBdmR39Q/0AHYEvTnxkNytQrgk1m
   GY+wuxHfO59kdA4qrm1xte0VqCP2s5k2jd+FKQrmttlbUqTbbYoR9nOlA
   IXBhb04eAAY6RWgyaMGXOVyuat/7w/FK1I2Qm9Bisrz79KkNWfcW+v+/k
   QH/hFbwirkfdC4bew3mPRL0IhMV1DoUttaHEp3eeKhUHK8my3yFGl90hU
   LPqGIahO30GQqhqDxgLdkxM5Gv70qkMrBTF1JLqxbsh0ldqQ5pP2bv5BT
   xGIiaLxBLDvbAQxG0mP/VSg6ysv8vN9atcXLBjTyRcM4IoPaFw17CdNL+
   Q==;
X-CSE-ConnectionGUID: iGaPdk07Tsq+HbyFWHy4IA==
X-CSE-MsgGUID: 9YrsbWBVS8u+e+xLUSWgrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="59896147"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="59896147"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 22:04:03 -0700
X-CSE-ConnectionGUID: K8T9ubTFQqSh82nlOeM6tQ==
X-CSE-MsgGUID: B8SS4GoAS1W6Q0uWoZdMaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163617088"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Jul 2025 22:03:59 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhLSP-0003Qy-1c;
	Thu, 31 Jul 2025 05:03:57 +0000
Date: Thu, 31 Jul 2025 13:03:00 +0800
From: kernel test robot <lkp@intel.com>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: vmlinux.o: warning: objtool: blk_validate_limits+0x86c: sibling call
 from callable instruction with modified stack frame
Message-ID: <202507311259.ES1keZGh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   260f6f4fda93c8485c8037865c941b42b9cba5d2
commit: 76e45252a4cefa205439eb6610a244771e7d88da block: introduce pi_tuple_size field in blk_integrity
date:   4 weeks ago
config: loongarch-randconfig-002-20250730 (https://download.01.org/0day-ci/archive/20250731/202507311259.ES1keZGh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507311259.ES1keZGh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507311259.ES1keZGh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: befs_parse_param+0xa8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: debugfs_parse_param+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_parse_param+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_get_extent_inline_ref_type+0xa0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __btrfs_run_delayed_refs+0x3e0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: alloc_reserved_file_extent+0xd0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: lookup_inline_extent_backref+0x66c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: update_inline_extent_backref+0x240: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: setup_inline_extent_backref+0x118: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_print_leaf+0x7a0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_extent_item_to_extent_map+0x184: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_get_global_root+0x6c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_encoded_io_compression_from_extent+0x4c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_encoded_read_inline+0x1e4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_do_encoded_write+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_sysfs_add_space_info_type+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_ioctl+0x9c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_ioctl_subvol_sync+0x138: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: alloc_workspace+0x58: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: free_workspace+0x44: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: get_workspace+0x44: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: put_workspace+0x44: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: find_parent_nodes+0xe9c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: tree_backref_for_extent+0x1c0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_backref_iter_next+0xe4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: send_create_inode+0xfc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: inconsistent_snapshot_error+0x3c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_init_dev_replace+0x214: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_dev_replace_cancel+0xac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_resume_dev_replace_async+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __btrfs_check_leaf+0x37c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_leaf_item+0x1af0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __reserve_bytes+0x438: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: flush_space+0x80: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_init_root_block_rsv+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: tree_mod_log_rewind+0x154: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btrfs_build_ref_tree+0x4f4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ea_list_i+0xd0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_dump_glock+0x144: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: finish_xmote+0x3d8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_llseek.llvm.12545040364124102697+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_parse_param+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_fill_super+0xa68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_quota_get_state.llvm.13406532287823096530+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_show_options.llvm.15561301667184293420+0x24c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: status_show+0x70: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_do_shutdown+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __f2fs_ioctl+0x100: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_llseek.llvm.14381227317962981855+0x84: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_iget+0x2f8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: parse_options+0xcc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_show_options+0x6e0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __f2fs_is_valid_blkaddr.llvm.1264594648585668604+0x6c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_ra_meta_pages+0x174: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_get_victim+0x2e0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_map_blocks+0x604: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_available_free_memory+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_truncate_inode_blocks+0x36c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: new_curseg+0x1d0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_get_segment_temp+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __get_segment_type+0x638: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_sbi_store+0xcb0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __struct_ptr+0x54: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ramoops_pstore_erase+0x58: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: erofs_fc_parse_param+0x94: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: erofs_iget+0x470: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: keyring_get_key_chunk+0x58: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: keyctl_reject_key+0xcc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: keyctl_set_reqkey_keyring+0x7c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sys_keyctl+0x68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: key_task_permission+0x58: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: lookup_user_key+0xe8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: request_key_and_link+0x32c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: keyctl_pkey_params_get_2+0x1b8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: datablob_parse+0xc8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cap_task_fix_setuid+0x40: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cap_task_prctl+0x7c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rsa_set_pub_key+0xdc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rsa_set_priv_key+0x158: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: generate_random_testvec_config+0xb4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: generate_random_length+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: crypto_gcm_setauthsize+0x40: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: michael_final+0x4c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ecc_get_curve+0x40: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ecc_is_key_valid+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ecc_gen_privkey+0x54: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ecc_make_pub_key+0x70: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: crypto_ecdh_shared_secret+0x74: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: vli_mmod_fast+0x268: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ecrdsa_param_curve+0x64: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: async_raid6_2data_recov+0x248: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: x509_note_sig_algo+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: x509_process_extension+0x68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: pkcs7_sig_note_digest_algo+0x80: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: pkcs7_sig_note_pkey_algo+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: pkcs7_sig_note_authenticated_attr+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: pkcs7_verify+0x68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: biovec_slab+0x40: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: submit_bio_noacct+0x320: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: blk_flush_complete_seq+0xbc: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: blk_validate_limits+0x86c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bio_split_to_limits+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: blk_attempt_bio_merge+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: blk_mq_submit_bio+0x278: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: blkdev_ioctl+0x134: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ioprio_check_cap+0x44: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sys_ioprio_set+0x68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: msdos_partition+0x3dc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bsg_ioctl+0x90: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bfq_bfqq_expire+0x518: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bfq_set_next_ioprio_data+0x68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bfq_get_queue+0xb4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sed_ioctl+0x134: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: start_generic_opal_session+0x148: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: response_get_string+0xc0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: kiocb_done+0x108: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: io_timeout_remove+0x20c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __io_timeout_prep+0x334: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sys_io_uring_register+0x280: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: io_parse_restrictions+0xd8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: do_swap+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: match_token+0x18c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: extract_iter_to_sg+0x98: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: _copy_to_iter+0x1e8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: _copy_from_iter+0x1e4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: _copy_from_iter_nocache+0x168: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: copy_page_to_iter_nofault+0x390: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: iov_iter_zero+0x1c4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: copy_folio_from_iter_atomic+0x3e8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: iov_iter_advance+0xbc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: iov_iter_revert+0xd4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: iov_iter_single_seg_count+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: iov_iter_is_aligned+0xe0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: iov_iter_alignment+0xa8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: iov_iter_npages+0xd8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: iov_iter_extract_pages+0x1dc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rhashtable_jhash2+0x128: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: refcount_warn_saturate+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: string_unescape+0x2ac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: string_escape_mem+0x3d4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: kstrtobool+0xa0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: vvar_fault.llvm.6795815868049752848+0x4c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __devm_ioremap.llvm.11647403529210784867+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: zlib_inflate+0x174: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: find_poly_roots+0x5cc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: HUF_compress1X_usingCTable_internal.llvm.16785660852261606571+0x118: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_cParam_getBounds+0x84: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_CCtx_setParameter+0x144: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_CCtxParams_setParameter+0xb0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_CCtxParams_getParameter+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_CCtx_setCParams+0x184: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_buildEntropyStatisticsAndEstimateSubBlockSize+0x150: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_loadDictionaryContent+0x45c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_buildCTable+0x84: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_compressSuperBlock+0x180: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_fillDoubleHashTable+0x428: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_compressBlock_doubleFast_extDict+0x2a0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_fillHashTable+0x484: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_compressBlock_fast_extDict+0x2f4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_dedicatedDictSearch_lazy_loadDictionary+0x680: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_insertAndFindFirstIndex+0x240: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_insertBt1+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: HUF_readDTableX1_wksp+0x4d4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: HUF_decompress1X2_usingDTable_internal+0x118: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: HUF_decompress1X1_usingDTable_internal+0x128: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: HUF_decompress4X2_usingDTable_internal+0x1014: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: HUF_decompress4X1_usingDTable_internal+0xeac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: HUF_fillDTableX2ForWeight+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: BIT_initDStream+0x104: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: BIT_initDStream+0x104: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_getFrameHeader_advanced+0x30c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_nextInputType+0x44: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_decompressContinue+0x12c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_dParam_getBounds+0x40: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_DCtx_setParameter+0x84: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_DCtx_getParameter+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_decompressStream+0x33c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_decodeLiteralsBlock+0x108: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_buildSeqTable+0x80: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_decompressSequencesLong+0x208: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_decompressSequencesSplitLitBuffer+0x1e4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ZSTD_decompressSequences+0x20c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ERR_getErrorString+0xb0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: FSE_decompress_wksp_bmi2+0x3bc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xz_dec_run+0x100: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xz_dec_lzma2_run+0xec: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bcj_apply+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: xz_dec_bcj_reset+0x4c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ei_seq_show+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: stack_depot_save_flags+0x128: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: asn1_ber_decoder+0x1a4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: msi_lib_init_dev_msi_info+0x90: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rza1_irqc_set_type+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rzv2h_icu_set_type+0xe4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: lpic_get_gsi_domain_id+0x44: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: complete_irq_moving+0xbc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: liointc_set_type+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: pch_pic_set_type+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: mchp_eic_domain_alloc+0xc4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: mchp_eic_irq_set_type+0x70: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: mhi_intvec_threaded_handler+0x130: sibling call from callable instruction with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

