Return-Path: <linux-kernel+bounces-749927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BBEB154DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2827916B42A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A727816B;
	Tue, 29 Jul 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgZKISEq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27F275867
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753826057; cv=none; b=HAJtzKywhodm1eOd58CEJiL2u9zphtVGyM2dcyEEC3XUE9huhF4qQHqbS3dZwhnza4u/jYpHGptKsG2mKQPl8bnpX2kBYiqKqRuXzYSRrWId1NKivaRLLvTpqoZQtieXJ3wTrzzsiBCKWSNqrcb3JgqROrFmxJxS3W83T+QStsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753826057; c=relaxed/simple;
	bh=evS40yylMk96Q2EfrX13gozbYMbsq+8jb5WxuwkNloo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fRdtKhAM2DZtsgUgjKubml0AgOg7IpFPjxtKvJ3yM/xYh1M3Eaye3bwet+H0ZtHhSQ6c09w5v8SwE7RXkNy0xPEq7pmkszm+7Am3KghtU1HJezxCedTJyFBeNF32dyO9ZQchiVTfMqWkHuNhuzcuoxq8PKWM042lJ695XIuxctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgZKISEq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753826055; x=1785362055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=evS40yylMk96Q2EfrX13gozbYMbsq+8jb5WxuwkNloo=;
  b=GgZKISEqK9JNpPhLoFX711f787n5SJ+Re0hKwKaIdsE7ahgQQuLG5Wth
   gGW6L38klgbEhuOiPrVxai5EMcZWhfJlCa13JDR22AoBQuOPfL2BlmcBe
   MO+TIaDw20BhPZYTb2XIF+SoB11+544VHg/euqBR/1kcy0w86i8OinCOs
   vZ6w88b7w6h6+pu3LIPeL9pjUM6j8yfXl3zzvL/X22J5vzoPPkTuCyQSQ
   Sn4SeJo2lDAYKrSIK5W83vZr8PMOvyiw6TFIxccn3au4fsZCOoyjYh9PT
   C+DMkZSJ7ZyDU9pfJ7ufqxXRWXpETp9S/I5PANzCf+/4EkRXNA0GtdYPG
   w==;
X-CSE-ConnectionGUID: Is2KmAp9R3KrGMxUiiGgCQ==
X-CSE-MsgGUID: UHfqFH8IRkiWmkf9akexGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="66682763"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="66682763"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 14:54:14 -0700
X-CSE-ConnectionGUID: ilGF+0OoTfaWUwofWho3/g==
X-CSE-MsgGUID: fcwKNlUERkSw7vihcvlC0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163270886"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Jul 2025 14:54:12 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugsGw-0001j3-07;
	Tue, 29 Jul 2025 21:54:10 +0000
Date: Wed, 30 Jul 2025 05:53:24 +0800
From: kernel test robot <lkp@intel.com>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: vmlinux.o: warning: objtool: blk_get_meta_cap+0x1a8: sibling call
 from callable instruction with modified stack frame
Message-ID: <202507300521.IZ4mbJwu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0db240bc077fd16cc16bcecfd7f4645bc474aa7e
commit: bc5b0c8febccbeabfefc9b59083b223ec7c7b53a block: fix lbmd_guard_tag_type assignment in FS_IOC_GETLBMD_CAP
date:   6 days ago
config: loongarch-randconfig-002-20250730 (https://download.01.org/0day-ci/archive/20250730/202507300521.IZ4mbJwu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507300521.IZ4mbJwu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507300521.IZ4mbJwu-lkp@intel.com/

All warnings (new ones prefixed by >>):

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
   vmlinux.o: warning: objtool: gfs2_llseek.llvm.1880751065968454877+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_parse_param+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_fill_super+0xa68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_quota_get_state.llvm.1910101736943174531+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: gfs2_show_options.llvm.7655142120699730860+0x24c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: status_show+0x70: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_do_shutdown+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __f2fs_ioctl+0x100: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_llseek.llvm.4505012802978155059+0x84: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_iget+0x2f8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: parse_options+0xcc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: f2fs_show_options+0x6e0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __f2fs_is_valid_blkaddr.llvm.12814712387801535868+0x6c: sibling call from callable instruction with modified stack frame
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
   vmlinux.o: warning: objtool: blk_validate_limits+0x86c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bio_split_to_limits+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: blk_attempt_bio_merge+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: blk_mq_submit_bio+0x278: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: blkdev_ioctl+0x69c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ioprio_check_cap+0x44: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sys_ioprio_set+0x68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: msdos_partition+0x3dc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bsg_ioctl+0x90: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bfq_bfqq_expire+0x518: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bfq_set_next_ioprio_data+0x68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bfq_get_queue+0xb4: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: blk_get_meta_cap+0x1a8: sibling call from callable instruction with modified stack frame
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
   vmlinux.o: warning: objtool: __devm_ioremap.llvm.14098161117420859606+0x78: sibling call from callable instruction with modified stack frame
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
   vmlinux.o: warning: objtool: mhi_process_ctrl_ev_ring+0x270: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: parse_xfer_event+0xf0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: mhi_pm_st_worker+0x154: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: mhi_async_power_up+0x14c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: phy_g12a_mipi_dphy_analog_power_on+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: brcm_sata_phy_init+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: brcm_pm_notifier+0x48: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: brcm_usb_phy_xlate+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: usb_init_xhci+0x1c0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cdns_torrent_phy_probe+0x824: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cdns_torrent_phy_configure_multilink+0x8d4: sibling call from callable instruction with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

