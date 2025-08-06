Return-Path: <linux-kernel+bounces-758440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5261B1CF28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1350567921
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2407D2356B9;
	Wed,  6 Aug 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lF1G4E16"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A822D9E9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519905; cv=none; b=tcSU/tqnF3QWP9KMUWEWlUUeSM2JggmZg6nl0oFrk8G9KsTNzkRogF1JE6bxelAZ8odpH/WJUzjYpit/Wk7buBjKn+W6ly/85hql0HdI4RPmiOwdiOoiHc0OffzcDuj08KIPT1bjYDCCzZju12Hqoan9SnelA5mIQIIBk0rYU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519905; c=relaxed/simple;
	bh=UsuoGBHjwewP1sIpW3nwpG6GLzYey9B8ms9eNCHQpgY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vFreWf53K/CFDDcj1sSe4Mzg0p5FAcET4JoI9omvZCOO1BD9E59q+yHQYmsObGbDZB4x10gUyB024OJE0NoEm6j2j9vxTw0jIwPmJzxQ581o5T79N0cllXd5zdQHR8zfhCmQV83XTprsLVxgMblRp6OhBXnc890uMqSIKQdFziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lF1G4E16; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754519903; x=1786055903;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UsuoGBHjwewP1sIpW3nwpG6GLzYey9B8ms9eNCHQpgY=;
  b=lF1G4E16YND8p1R/5L53SxUtAlhhnuW62cYtcomUs1EulbvqE5TUi99a
   0JsGHMYL2vocaeIFc21n2ZsFxWOIsE9a79F9LZ2jBhb+UD43IVCSGCPow
   IvhzA0w2RF5uXpWXe8GPNV2bqRLquN7qYS2aMxLaz3JyOPF71toeTmQZ4
   SxwTQRfbH8YiG0gtga3rJc1Q5oywfsaKt0BxRhBM09h/f/vUyliWDwBlx
   NP7F5jnEDn334vxVIlWvCA+ZkV0fmAGtmL9/fyzg23oLhxF9Ndga7jpPW
   p08JAyrwrq7fm1SY91ZLe+K1m1Nly89Rmx3RuywZpmk4g74FS0NUBEWmr
   w==;
X-CSE-ConnectionGUID: 2FzCL6KPTjuYcSu6Em0KhQ==
X-CSE-MsgGUID: rQkyxlxlQM2yzuzkHhc9Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56929073"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56929073"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 15:38:22 -0700
X-CSE-ConnectionGUID: 8m00+apCTBmu4Lz2CDHf1A==
X-CSE-MsgGUID: hH0MaZIxQvG8kYE6QXfNqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="188563345"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 06 Aug 2025 15:38:21 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujmlx-00029q-1A;
	Wed, 06 Aug 2025 22:38:15 +0000
Date: Thu, 7 Aug 2025 06:37:31 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:irq/urgent 6/8] ERROR: modpost: __ex_table+0x1584 references
 non-executable section '.rodata.__func__.103779'
Message-ID: <202508070607.QKVa8DiU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
head:   9f7488f24c7571d349d938061e0ede7a39b65d6b
commit: 5b65258229117995eb6c4bd74995e15fb5f2cfe3 [6/8] genirq/test: Resolve irq lock inversion warnings
config: riscv-randconfig-002-20250807 (https://download.01.org/0day-ci/archive/20250807/202508070607.QKVa8DiU-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070607.QKVa8DiU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070607.QKVa8DiU-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: xp_destroy+0xa (section: .text.xp_destroy) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xp_create_and_assign_umem+0x2a6 (section: .text.xp_create_and_assign_umem) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xp_assign_dev+0x136 (section: .text.xp_assign_dev) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xp_assign_dev+0x16c (section: .text.xp_assign_dev) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xp_assign_dev+0x174 (section: .text.xp_assign_dev) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xp_assign_dev+0x236 (section: .text.xp_assign_dev) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xp_assign_dev+0x264 (section: .text.xp_assign_dev) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xp_assign_dev+0x26c (section: .text.xp_assign_dev) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xp_assign_dev+0x274 (section: .text.xp_assign_dev) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xp_release_deferred+0x64 (section: .text.xp_release_deferred) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fdt_nop_property+0x1e (section: .text.fdt_nop_property) -> ics932s401_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: fdt_nop_property+0x2a (section: .text.fdt_nop_property) -> ics932s401_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: fdt_node_end_offset_+0x10 (section: .text.fdt_node_end_offset_) -> lkdtm_module_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: fdt_node_end_offset_+0x20 (section: .text.fdt_node_end_offset_) -> lkdtm_module_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: idr_alloc_u32+0x26 (section: .text.idr_alloc_u32) -> .LVL28 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: idr_alloc_u32+0x2a (section: .text.idr_alloc_u32) -> .LVL29 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: idr_alloc_u32+0x52 (section: .text.idr_alloc_u32) -> .LVL30 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: idr_alloc_u32+0x9e (section: .text.idr_alloc_u32) -> .LVL31 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_register_range+0x52 (section: .text.logic_pio_register_range) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_register_range+0xb0 (section: .text.logic_pio_register_range) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_register_range+0xbe (section: .text.logic_pio_register_range) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_register_range+0xde (section: .text.logic_pio_register_range) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_register_range+0x11c (section: .text.logic_pio_register_range) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_register_range+0x136 (section: .text.logic_pio_register_range) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_register_range+0x14c (section: .text.logic_pio_register_range) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: find_io_range_by_fwnode+0xc6 (section: .text.find_io_range_by_fwnode) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_to_hwaddr+0xdc (section: .text.logic_pio_to_hwaddr) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_trans_cpuaddr+0x7c (section: .text.logic_pio_trans_cpuaddr) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_trans_cpuaddr+0x118 (section: .text.logic_pio_trans_cpuaddr) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_trans_cpuaddr+0x122 (section: .text.logic_pio_trans_cpuaddr) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_trans_cpuaddr+0x132 (section: .text.logic_pio_trans_cpuaddr) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_trans_cpuaddr+0x146 (section: .text.logic_pio_trans_cpuaddr) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_trans_cpuaddr+0x170 (section: .text.logic_pio_trans_cpuaddr) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: logic_pio_trans_cpuaddr+0x1c4 (section: .text.logic_pio_trans_cpuaddr) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x426 (section: .text.mas_empty_area) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x548 (section: .text.mas_empty_area) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x55e (section: .text.mas_empty_area) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x574 (section: .text.mas_empty_area) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x57a (section: .text.mas_empty_area) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_root_expand+0x11c (section: .text.mas_root_expand) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_root_expand+0x128 (section: .text.mas_root_expand) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_root_expand+0x12c (section: .text.mas_root_expand) -> bh1770_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mas_new_root+0x116 (section: .text.mas_new_root) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __mt_destroy+0xa6 (section: .text.__mt_destroy) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x1ce (section: .text.mt_validate) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x1da (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x220 (section: .text.mt_validate) -> bh1770_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x228 (section: .text.mt_validate) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x360 (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x36e (section: .text.mt_validate) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x376 (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x386 (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x394 (section: .text.mt_validate) -> bh1770_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x3b8 (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x5f8 (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x61e (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x648 (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x65e (section: .text.mt_validate) -> bh1770_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0x6f2 (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0xbbe (section: .text.mt_validate) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0xbcc (section: .text.mt_validate) -> fpc202_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0xbe6 (section: .text.mt_validate) -> bh1770_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0xc26 (section: .text.mt_validate) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0xc40 (section: .text.mt_validate) -> bh1770_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0xc8c (section: .text.mt_validate) -> fpc202_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mt_validate+0xdd8 (section: .text.mt_validate) -> bh1770_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_putmem_hex+0x30 (section: .text.seq_buf_putmem_hex) -> wm8994_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_string+0xa (section: .text.ip6_string) -> wm8994_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_compressed_string+0xe8 (section: .text.ip6_compressed_string) -> wm8994_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mac_address_string+0x52 (section: .text.mac_address_string) -> wm8994_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: uuid_string+0x4c (section: .text.uuid_string) -> wcd934x_slim_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: uuid_string+0x5c (section: .text.uuid_string) -> wm8994_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: uuid_string+0x10c (section: .text.uuid_string) -> wcd934x_slim_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vbin_printf+0x234 (section: .text.vbin_printf) -> tps6594_esm_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vbin_printf+0x26a (section: .text.vbin_printf) -> tps6594_pfsm_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vbin_printf+0x27e (section: .text.vbin_printf) -> tps6594_pfsm_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vbin_printf+0x2b6 (section: .text.vbin_printf) -> tps6594_pfsm_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vbin_printf+0x2c2 (section: .text.vbin_printf) -> tps6594_esm_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vbin_printf+0x2ce (section: .text.vbin_printf) -> tps6594_esm_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x4 (section: .init.text.efi_pe_entry) -> pm800_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x4 (section: .init.text.efi_pe_entry) -> pm800_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.efi_pe_entry) -> pm800_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x4 (section: .init.text.efi_pe_entry) -> pm805_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.efi_pe_entry) -> pm805_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.exit_boot_func) -> pm805_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x4 (section: .init.text.exit_boot_func) -> pm805_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.exit_boot_func) -> pm805_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x4 (section: .init.text.exit_boot_func) -> pm886_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.exit_boot_func) -> pm886_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.get_fdt) -> pm886_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x4 (section: .init.text.get_fdt) -> pm805_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.get_fdt) -> pm886_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.efi_boot_kernel) -> pm886_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x4 (section: .init.text.efi_boot_kernel) -> pm805_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.efi_boot_kernel) -> pm886_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.efi_boot_kernel) -> pm886_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.efi_boot_kernel) -> pm805_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.efi_boot_kernel) -> pm805_i2c_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __efistub_.L0 +0x0 (section: .init.text.efi_boot_kernel) -> pm886_i2c_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: 0x1584 (section: __ex_table) -> __func__ (section: .rodata.__func__.103779)
>> ERROR: modpost: __ex_table+0x1584 references non-executable section '.rodata.__func__.103779'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1588 (section: __ex_table) -> __func__ (section: .rodata.__func__.103817)
ERROR: modpost: __ex_table+0x1588 references non-executable section '.rodata.__func__.103817'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1590 (section: __ex_table) -> __func__ (section: .rodata.__func__.103846)
ERROR: modpost: __ex_table+0x1590 references non-executable section '.rodata.__func__.103846'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1594 (section: __ex_table) -> __func__ (section: .rodata.__func__.103874)
ERROR: modpost: __ex_table+0x1594 references non-executable section '.rodata.__func__.103874'
WARNING: modpost: vmlinux: section mismatch in reference: 0x159c (section: __ex_table) -> __func__ (section: .rodata.__func__.103889)
ERROR: modpost: __ex_table+0x159c references non-executable section '.rodata.__func__.103889'
WARNING: modpost: vmlinux: section mismatch in reference: 0x15a0 (section: __ex_table) -> __func__ (section: .rodata.__func__.103874)
ERROR: modpost: __ex_table+0x15a0 references non-executable section '.rodata.__func__.103874'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16c8 (section: __ex_table) -> .LASF1478 (section: .debug_str)
ERROR: modpost: __ex_table+0x16c8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16cc (section: __ex_table) -> .LASF1480 (section: .debug_str)
ERROR: modpost: __ex_table+0x16cc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17a0 (section: __ex_table) -> .LASF1906 (section: .debug_str)
ERROR: modpost: __ex_table+0x17a0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17a4 (section: __ex_table) -> .LASF1908 (section: .debug_str)
ERROR: modpost: __ex_table+0x17a4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17ac (section: __ex_table) -> .LASF1910 (section: .debug_str)
ERROR: modpost: __ex_table+0x17ac references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17b0 (section: __ex_table) -> .LASF1908 (section: .debug_str)
ERROR: modpost: __ex_table+0x17b0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17b8 (section: __ex_table) -> .LASF1913 (section: .debug_str)
ERROR: modpost: __ex_table+0x17b8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17bc (section: __ex_table) -> .LASF1908 (section: .debug_str)
ERROR: modpost: __ex_table+0x17bc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17c4 (section: __ex_table) -> .LASF1916 (section: .debug_str)
ERROR: modpost: __ex_table+0x17c4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17c8 (section: __ex_table) -> .LASF1918 (section: .debug_str)
ERROR: modpost: __ex_table+0x17c8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17d0 (section: __ex_table) -> .LASF1920 (section: .debug_str)
ERROR: modpost: __ex_table+0x17d0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17d4 (section: __ex_table) -> .LASF1908 (section: .debug_str)
ERROR: modpost: __ex_table+0x17d4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17f4 (section: __ex_table) -> .LASF54 (section: .debug_str)
ERROR: modpost: __ex_table+0x17f4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17f8 (section: __ex_table) -> .LASF56 (section: .debug_str)
ERROR: modpost: __ex_table+0x17f8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1800 (section: __ex_table) -> .LASF57 (section: .debug_str)
ERROR: modpost: __ex_table+0x1800 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1804 (section: __ex_table) -> .LASF60 (section: .debug_str)
ERROR: modpost: __ex_table+0x1804 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x18f0 (section: __ex_table) -> .LLST174 (section: .debug_loc)
ERROR: modpost: __ex_table+0x18f0 references non-executable section '.debug_loc'
WARNING: modpost: vmlinux: section mismatch in reference: 0x18f4 (section: __ex_table) -> .LLST176 (section: .debug_loc)
ERROR: modpost: __ex_table+0x18f4 references non-executable section '.debug_loc'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19c8 (section: __ex_table) -> .LASF327 (section: .debug_str)
ERROR: modpost: __ex_table+0x19c8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19cc (section: __ex_table) -> .LASF329 (section: .debug_str)
ERROR: modpost: __ex_table+0x19cc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19d4 (section: __ex_table) -> .LASF331 (section: .debug_str)
ERROR: modpost: __ex_table+0x19d4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19d8 (section: __ex_table) -> .LASF329 (section: .debug_str)
ERROR: modpost: __ex_table+0x19d8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19e0 (section: __ex_table) -> .LASF334 (section: .debug_str)
ERROR: modpost: __ex_table+0x19e0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19e4 (section: __ex_table) -> .LASF336 (section: .debug_str)
ERROR: modpost: __ex_table+0x19e4 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19ec (section: __ex_table) -> .LASF338 (section: .debug_str)
ERROR: modpost: __ex_table+0x19ec references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19f0 (section: __ex_table) -> .LASF329 (section: .debug_str)
ERROR: modpost: __ex_table+0x19f0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19f8 (section: __ex_table) -> .LASF2616 (section: .debug_str)
ERROR: modpost: __ex_table+0x19f8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x19fc (section: __ex_table) -> .LASF2618 (section: .debug_str)
ERROR: modpost: __ex_table+0x19fc references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a04 (section: __ex_table) -> .LASF2620 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a04 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a08 (section: __ex_table) -> .LASF2622 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a08 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a10 (section: __ex_table) -> .LASF3063 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a10 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a14 (section: __ex_table) -> .LASF3065 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a14 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a1c (section: __ex_table) -> .LASF3067 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a1c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a20 (section: __ex_table) -> .LASF3069 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a20 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a28 (section: __ex_table) -> .LASF3071 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a28 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a2c (section: __ex_table) -> .LASF3073 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a2c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a34 (section: __ex_table) -> .LASF3075 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a34 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a38 (section: __ex_table) -> .LASF3077 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a38 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a40 (section: __ex_table) -> .LASF3079 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a40 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a44 (section: __ex_table) -> .LASF3081 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a44 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a4c (section: __ex_table) -> .LASF3083 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a4c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a50 (section: __ex_table) -> .LASF3085 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a50 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a58 (section: __ex_table) -> .LASF1824 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a58 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a5c (section: __ex_table) -> .LASF1826 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a5c references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1a64 (section: __ex_table) -> .LASF1828 (section: .debug_str)
ERROR: modpost: __ex_table+0x1a64 references non-executable section '.debug_str'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

