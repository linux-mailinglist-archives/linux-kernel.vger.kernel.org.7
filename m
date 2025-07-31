Return-Path: <linux-kernel+bounces-751986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716BEB17004
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520C64E2600
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7552BEC3C;
	Thu, 31 Jul 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXscO2qT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8872BDC2C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959461; cv=none; b=cxDb/py3Wvy4wsI5tZwtFtj2SyzEGLxVqcq57I7MR6JWAuFiO9YmrBZags4oV1qc7eR5MMxFZvl0z19FRUUJsCPKTElBk1e3T8p3PHCZMN+q2Naov/LdYGwgWMtcTmqTMJRXYSZykW3ZLTXHbIxsU8MD8ZbXuci2O4pYE+HPC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959461; c=relaxed/simple;
	bh=xA/qc/HHenJ3kcIccjvw7ALJ3eZIt6umnSxO98K1Ytk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D5N6CYQYOocsOhYaV0XXbTZQVQbKMCxGeDJd58qwuidQ6nuEAvosYUZHK2xWFnofnWu0GW320R7FydgxS5Cg6x8VvRsgcGh8kPE3k+o8aqJVYPqvZI/0wovxL/q7BqETA4nV/fn0DPrDnn+FroFs5vI0mpL+NAqEA614llTZj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXscO2qT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753959459; x=1785495459;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xA/qc/HHenJ3kcIccjvw7ALJ3eZIt6umnSxO98K1Ytk=;
  b=RXscO2qTNkIc/RjdDI6sQlqcmhw2GIpBmaMYvAk+o6uSlYLRYzPOgRgW
   dKsa3yzeerpAMMrJNNSQZpCVMXhFfSfmxFlsSB3DGrDWC+fxV+bbIpV4X
   zxAGX+CePs3wtrgTgJrMtQKPqSfU0v8GLojEHfwEcg0jCg+NlkdLzQOcE
   +RA4XMdoOyMSKzlumPymH6J7t10N0yM3lvzBPIB8ncAm38Pype7i7l40v
   b/vHu9VFbJs0XxRwQgePwcDc3b9OsKS4P/YSW7Tn+QQMUW3+Q+6mmcfi1
   fCWfDtj1EziikU1nM4gwNhlK7VhvOG2O7GWJigBKBz2Ddvf0hJUv2MWFb
   g==;
X-CSE-ConnectionGUID: dNGDmNYBSl6vzxoV78Lszg==
X-CSE-MsgGUID: ulL6jPbnSG+U5TKY3hDiWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56210427"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56210427"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 03:57:38 -0700
X-CSE-ConnectionGUID: CZwN+yVASLO9owPwiqLLIg==
X-CSE-MsgGUID: 97Y1c0+aRfiWzTiF7Nawbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="167415180"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 31 Jul 2025 03:57:37 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhQyc-0003hQ-1w;
	Thu, 31 Jul 2025 10:57:34 +0000
Date: Thu, 31 Jul 2025 18:56:57 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: vmlinux.o: warning: objtool: ktime_get_clock_ts64+0x50: sibling call
 from callable instruction with modified stack frame
Message-ID: <202507311809.WhtatIKx-lkp@intel.com>
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
commit: 5b605dbee07dda8fd538af1f07cbf1baf0a49cbc timekeeping: Provide ktime_get_clock_ts64()
date:   4 weeks ago
config: loongarch-randconfig-002-20250730 (https://download.01.org/0day-ci/archive/20250731/202507311809.WhtatIKx-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507311809.WhtatIKx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507311809.WhtatIKx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: do_bp+0x94: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: do_name+0x150: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: memblock_init+0xb8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: recompute_jump+0x11c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: init_node_memblock+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: reboot_setup+0xf4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rcu_torture_init+0x1a0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: acpi_parse_entries_array+0xdc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: control_setup+0x190: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: pnpacpi_add_device+0x43c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: pnpacpi_option_resource+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: isapnp_create_device+0x1c4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: create_one_pll+0x180: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: clk_starfive_jh7100_probe+0x290: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jh7110_syscrg_probe+0x350: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: parse_options+0x9c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ips_module_init+0x108: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: qla1280_setup+0x194: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: scsi_debug_init+0xd8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: it87_find+0x88c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ibft_check_initiator_for+0x48: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ibft_check_tgt_for+0x48: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sysfb_init+0xb4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: efi_esrt_init+0x168: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: of_unittest_parse_phandle_with_args+0x13c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: of_unittest_parse_phandle_with_args_map+0x268: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: of_unittest_parse_interrupts+0x198: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: of_unittest_parse_interrupts_extended+0xc8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: unxz+0x398: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cpu_probe+0xf0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: arch_do_signal_or_restart+0x134: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: simu_pc+0xa4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: simu_branch+0x120: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: arch_ptrace+0xb0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: tso_write+0x7c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bt_address+0xc0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: reenter_kprobe+0x58: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: flush_cache_leaf+0x10c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cpu_hotplug_pm_callback+0x40: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: kernel_waitid_prepare+0xa0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: ptrace_request+0xe8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sys_prctl+0xb4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: prctl_set_mm+0x358: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jhash+0x134: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jhash+0x134: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jhash+0x134: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: jhash+0x134: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: task_work_add+0xe0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: register_sys_off_handler+0x138: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sched_balance_rq+0xe3c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sched_balance_find_dst_cpu+0x6a4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: kcpustat_field+0x1b8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: stress+0xf4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __msi_domain_alloc_irqs+0x4cc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rcu_torture_writer+0x45c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rcu_torture_fakewriter+0x124: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: rcu_pm_notify+0x24: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sys_kcmp+0x1d0: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: ktime_get_clock_ts64+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: second_overflow+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: do_timer_create+0x248: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: clockevents_switch_state+0xac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: time64_to_tm_test_date_range+0x19c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cgroup2_parse_param+0x7c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __cgroup_account_cputime_field+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cgroup1_parse_param+0x14c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cpuset_common_seq_show+0x7c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: update_parent_effective_cpumask+0xd30: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cpuset_partition_show+0x5c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cpuset_read_u64+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cpuset_write_u64+0xbc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: hungtask_pm_notify+0x40: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btf_record_free+0xbc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btf_record_dup+0x110: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_obj_free_fields+0xd0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_map_value_size+0x48: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_map_update_value+0x128: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_map_copy_value+0x88: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_sys_bpf+0x78: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: kern_sys_bpf+0x74: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_and_init_map_value+0x108: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __sys_bpf+0x1e8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: map_create+0x4e4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_prog_load+0x268: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_prog_attach+0x1d0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_prog_detach+0x1ac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_prog_query+0xa0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: map_lookup_and_delete_elem+0x364: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: link_create+0x144: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: link_create+0x3a0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: map_check_btf+0x2e4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_prog_load_check_attach+0x11c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: attach_type_to_prog_type+0x3c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_prog_attach_check_attach_type+0xac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_raw_tp_link_attach+0x60: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_check_attach_target+0x210: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_check+0x2e04: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: resolve_pseudo_ldimm64+0x220: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_attach_btf_id+0x14c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: compute_live_registers+0x580: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __add_used_map+0x228: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: add_kfunc_call+0x444: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: do_check_common+0x1cb8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_mem_access+0xb8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: save_aux_ptr_type+0xf4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_kfunc_call+0x7c8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_helper_call+0x23dc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_return_code+0x300: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_ld_imm+0x290: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: states_equal+0x83c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: regsafe+0x128: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: adjust_reg_min_max_vals+0x490: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: adjust_ptr_min_max_vals+0x1c0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: sanitize_err+0x98: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: btf_field_type_name+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __check_mem_access+0xfc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: atomic_ptr_type_ok+0xc4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_ptr_alignment+0x74: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_map_direct_read+0x98: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_stack_read+0x5fc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_stack_write+0xa7c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_func_arg_reg_off+0x8c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_helper_mem_access+0xa4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: is_ptr_cast_function+0x4c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: check_map_func_compatibility+0x6b4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: may_update_sockmap+0xf8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: is_branch_taken+0x464: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: reg_set_min_max+0xa8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: try_match_pkt_pointers+0xac: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: regs_refine_cond_op+0x68: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: insn_def_regno+0x50: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_any_put+0x3c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_parse_param+0xa4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __bpf_dynptr_write+0xc0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_dynptr_data+0xb8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_base_func_proto+0x5cc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_obj_new_impl+0x124: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_dynptr_slice+0xa8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __bpf_dynptr_read+0xc0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __bpf_strtoull+0xa4: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: dynptr_type_str+0x40: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_iter_attach_map+0xa8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: htab_map_alloc+0x4dc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: htab_map_free+0x9c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: htab_map_free_timers_and_wq+0xa8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: htab_map_mem_usage+0xe8: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_percpu_hash_copy+0x210: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: prealloc_init+0x58: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: htab_map_hash+0x144: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __htab_map_lookup_and_delete_batch+0xaa0: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __htab_map_lookup_and_delete_elem+0x574: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __bpf_hash_map_seq_show+0x244: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_percpu_array_copy+0x200: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __bpf_array_map_seq_show+0x224: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: hash+0x158: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: cgroup_storage_update_elem+0x1dc: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_cgroup_storage_alloc+0x20c: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: bpf_ringbuf_query+0x48: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: print_bpf_insn+0x8c: sibling call from callable instruction with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

