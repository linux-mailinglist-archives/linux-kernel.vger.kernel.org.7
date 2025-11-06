Return-Path: <linux-kernel+bounces-887929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C79C39645
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B1774F8626
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A2B2DE704;
	Thu,  6 Nov 2025 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRBaFamL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E5E573;
	Thu,  6 Nov 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413807; cv=none; b=pfAsZDGP9cTtdZMq5XIxteVGxzfFPzFwyIYSJu3mSxKKkrUjIPS5ojIFiA9afzue4czhuwm7i1kibtXhmBDP2KmO0l/Lb/CrvF4yHutRxXIR+s4bELyVBikgoSox+OMn5A4xE+Eumk+pldeWUK/RNZG+5h9td0I9kmvNng+kMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413807; c=relaxed/simple;
	bh=w4DsAJsiBy13rzqUL9z428ClYevdtkiyQuEM7KUjpeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTLCV+DCgbHYFfsq+TDGqAsrDXssg1pmfZtWnKaUvFEmpVoDe8s8tUykpxc+VhE3Ag99lidSvIEFUWWNyNULRL2PivZ53wsdkWVtgHJotX3GY+Q3oXW2ae+ZvcgiX4P0GTOIejpd4WBXv1BUroadYfGPgsn8/SSrjFdGn20nRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRBaFamL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762413805; x=1793949805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w4DsAJsiBy13rzqUL9z428ClYevdtkiyQuEM7KUjpeQ=;
  b=cRBaFamLnPTEBzL2PqDaqBWXqSK4nEzQW8fk5gs3xYTMD+MR1O9u6cYZ
   GRzbw+Tk1Hy6EjHmRllmM2kbxrq1RiBzjS6u2U/BlkVQbjSBhR2dnvS4S
   mGyFDEZf4Z34cGKZ1qaSENWTsXKW2Mr4L5pX+SeQho4uAE488ueNTWTSX
   SNNbhDaT3SKraUtmCzcOIXIGEfZ+8hCKX8p948ATQ6/1Urrsa4qJ+smjT
   q+Ht2DrK1NA6/bhCmcx7v0/dxw4Hki3YOGOsQXqwO8TBvfyih6OLpBJrc
   hRT3yrbz3xEwHeENSjuioldBBeaf9r4iSa2YE2cOw9PiGOVKr5Hh7+mAB
   w==;
X-CSE-ConnectionGUID: kfWgZFLtS8aJsID4gix1Lw==
X-CSE-MsgGUID: 8W/GRkiER1az+k/VhwmUpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64450470"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64450470"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:23:24 -0800
X-CSE-ConnectionGUID: L+xigtpISbGrDihEGTMtCw==
X-CSE-MsgGUID: hViJ7d9RQauCzjRFYOzZfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="188132996"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:23:22 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGuKz-000000061AB-1DtZ;
	Thu, 06 Nov 2025 09:23:17 +0200
Date: Thu, 6 Nov 2025 09:23:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Philip Li <philip.li@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [BUILD REGRESSION] LAST PATCH: [PATCH v1 1/1] kernel-doc: Issue
 warnings that were silently discarded
Message-ID: <aQxM5EG9bvU6u55c@smile.fi.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <202511060602.1xDZ7cIT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511060602.1xDZ7cIT-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 06:22:07AM +0800, kernel test robot wrote:
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/kernel-doc-Issue-warnings-that-were-silently-discarded/20251105-055629
> base:   git://git.lwn.net/linux.git docs-next
> patch link:    https://lore.kernel.org/r/20251104215502.1049817-1-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently discarded
> 
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> Error/Warning (recently discovered and may have been fixed):

Yeah, this is what we missed for these half a year...

>     https://lore.kernel.org/oe-kbuild-all/202511050706.NIxJwZER-lkp@intel.com
>     https://lore.kernel.org/oe-kbuild-all/202511050720.nJ9ccENC-lkp@intel.com
> 
>     Warning: arch/powerpc/kernel/eeh_driver.c:761 expecting prototype for eeh_check_slot_presence(). Prototype was for eeh_slot_presence_check() instead
>     Warning: arch/powerpc/kernel/eeh_event.c:102 expecting prototype for eeh_send_failure_event(). Prototype was for __eeh_send_failure_event() instead
>     Warning: arch/powerpc/kernel/eeh_pe.c:567 expecting prototype for eeh_pe_dev_state_mark(). Prototype was for eeh_pe_dev_mode_mark() instead
>     Warning: arch/powerpc/kernel/eeh_pe.c:567 function parameter 'mode' not described in 'eeh_pe_dev_mode_mark'
>     Warning: arch/powerpc/kernel/isa-bridge.c:157 expecting prototype for isa_bridge_find_early(). Prototype was for isa_bridge_init_non_pci() instead
>     Warning: arch/powerpc/kernel/isa-bridge.c:157 function parameter 'np' not described in 'isa_bridge_init_non_pci'
>     Warning: arch/powerpc/kernel/pci-common.c:1645 expecting prototype for pci_scan_phb(). Prototype was for pcibios_scan_phb() instead
>     Warning: arch/powerpc/kernel/pci_of_scan.c:60 expecting prototype for pci_parse_of_flags(). Prototype was for OF_PCI_ADDR0_SPACE() instead
>     Warning: arch/powerpc/kernel/pci_of_scan.c:60 function parameter 'ss' not described in 'OF_PCI_ADDR0_SPACE'
>     Warning: arch/powerpc/kernel/setup-common.c:453 expecting prototype for setup_cpu_maps(). Prototype was for smp_setup_cpu_maps() instead
>     Warning: arch/powerpc/platforms/52xx/mpc52xx_gpt.c:98 expecting prototype for struct mpc52xx_gpt. Prototype was for struct mpc52xx_gpt_priv instead
>     Warning: arch/powerpc/platforms/cell/spu_base.c:222 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: arch/powerpc/platforms/cell/spufs/sched.c:475 expecting prototype for spu_add_to_rq(). Prototype was for __spu_add_to_rq() instead
>     Warning: arch/powerpc/platforms/cell/spufs/switch.c:2182 expecting prototype for spu_alloc_csa(). Prototype was for spu_init_csa() instead
>     Warning: arch/powerpc/platforms/cell/spufs/switch.c:2182 function parameter 'csa' not described in 'spu_init_csa'
>     Warning: arch/powerpc/platforms/cell/spufs/syscalls.c:36 expecting prototype for sys_spu_run(). Prototype was for do_spu_run() instead
>     Warning: arch/powerpc/platforms/cell/spufs/syscalls.c:36 function parameter 'filp' not described in 'do_spu_run'
>     Warning: arch/powerpc/platforms/powernv/eeh-powernv.c:1166 expecting prototype for pnv_pe_err_inject(). Prototype was for pnv_eeh_err_inject() instead
>     Warning: arch/powerpc/platforms/ps3/htab.c:28 expecting prototype for enum lpar_vas_id. Prototype was for enum ps3_lpar_vas_id instead
>     Warning: arch/powerpc/platforms/ps3/interrupt.c:150 cannot understand function prototype: 'struct irq_chip ps3_irq_chip ='
>     Warning: arch/powerpc/platforms/ps3/interrupt.c:55 #define PS3_BMP_MINALIGN 64; error: Cannot parse struct or union!
>     Warning: arch/powerpc/platforms/ps3/mm.c:1092 expecting prototype for dma_unmap_area_linear(). Prototype was for dma_sb_unmap_area_linear() instead
>     Warning: arch/powerpc/platforms/ps3/mm.c:708 expecting prototype for dma_region_free(). Prototype was for dma_sb_region_free() instead
>     Warning: arch/powerpc/platforms/ps3/smp.c:26 expecting prototype for ps3_ipi_virqs(). Prototype was for MSG_COUNT() instead
>     Warning: arch/powerpc/platforms/pseries/lpar.c:1080 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: arch/powerpc/platforms/pseries/setup.c:945 expecting prototype for fw_cmo_feature_init(). Prototype was for pSeries_cmo_feature_init() instead
>     Warning: arch/powerpc/platforms/pseries/vio.c:106 expecting prototype for vio_cmo_OF_devices(). Prototype was for vio_cmo_num_OF_devs() instead
>     Warning: arch/powerpc/platforms/pseries/vio.c:1286 expecting prototype for vio_register_driver(). Prototype was for __vio_register_driver() instead
>     Warning: arch/powerpc/platforms/pseries/vio.c:1286 function parameter 'mod_name' not described in '__vio_register_driver'
>     Warning: arch/powerpc/platforms/pseries/vio.c:1286 function parameter 'owner' not described in '__vio_register_driver'
>     Warning: arch/powerpc/platforms/pseries/vio.c:51 cannot understand function prototype: 'struct vio_cmo_pool'
>     Warning: arch/powerpc/platforms/pseries/vio.c:68 cannot understand function prototype: 'struct vio_cmo_dev_entry'
>     Warning: arch/powerpc/platforms/pseries/vio.c:88 cannot understand function prototype: 'struct vio_cmo'
>     Warning: arch/x86/kernel/apic/apic.c:2145 expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead
>     Warning: arch/x86/kernel/apic/apic.c:2145 function parameter 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
>     Warning: block/blk-mq-dma.c:374 expecting prototype for blk_rq_integrity_dma_map_iter_start(). Prototype was for blk_rq_integrity_dma_map_iter_next() instead
>     Warning: drivers/dma/bestcomm/gen_bd.c:261 cannot understand function prototype: 'struct bcom_psc_params'
>     Warning: drivers/dpll/zl3073x/fw.c:365 expecting prototype for zl3073x_flash_bundle_flash(). Prototype was for zl3073x_fw_component_flash() instead
>     Warning: drivers/dpll/zl3073x/fw.c:365 function parameter 'comp' not described in 'zl3073x_fw_component_flash'
>     Warning: drivers/gpu/drm/msm/msm_gem_vma.c:96 expecting prototype for struct msm_vma_op. Prototype was for struct msm_vm_op instead
>     Warning: drivers/gpu/drm/msm/msm_iommu.c:376 expecting prototype for alloc_pt(). Prototype was for msm_iommu_pagetable_alloc_pt() instead
>     Warning: drivers/gpu/drm/msm/msm_iommu.c:421 expecting prototype for free_pt(). Prototype was for msm_iommu_pagetable_free_pt() instead
>     Warning: drivers/gpu/drm/xe/xe_migrate.c:1128 expecting prototype for xe_get_migrate_exec_queue(). Prototype was for xe_migrate_exec_queue() instead
>     Warning: drivers/gpu/drm/xe/xe_sriov_vf.c:303 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: drivers/gpu/drm/xe/xe_tlb_inval.c:126 expecting prototype for xe_gt_tlb_inval_init(). Prototype was for xe_gt_tlb_inval_init_early() instead
>     Warning: drivers/gpu/drm/xe/xe_tlb_inval_job.c:164 expecting prototype for xe_tlb_inval_alloc_dep(). Prototype was for xe_tlb_inval_job_alloc_dep() instead
>     Warning: drivers/md/bcache/request.c:308 expecting prototype for bch_data_insert(). Prototype was for CLOSURE_CALLBACK() instead
>     Warning: drivers/md/bcache/request.c:308 function parameter 'bch_data_insert' not described in 'CLOSURE_CALLBACK'
>     Warning: drivers/net/pse-pd/pse_core.c:246 expecting prototype for pse_control_find_net_by_id(). Prototype was for pse_control_find_by_id() instead
>     Warning: drivers/ps3/ps3-lpm.c:1056 expecting prototype for ps3_enable_pm_interrupts(). Prototype was for ps3_disable_pm_interrupts() instead
>     Warning: drivers/ps3/ps3-lpm.c:1056 function parameter 'cpu' not described in 'ps3_disable_pm_interrupts'
>     Warning: drivers/ps3/ps3-lpm.c:143 cannot understand function prototype: 'struct ps3_lpm_priv *lpm_priv;'
>     Warning: drivers/ps3/ps3-lpm.c:161 cannot understand function prototype: 'enum'
>     Warning: drivers/ps3/ps3-sys-manager.c:198 cannot understand function prototype: 'u32 user_wake_sources = PS3_SM_WAKE_DEFAULT;'
>     Warning: drivers/ps3/ps3-sys-manager.c:222 cannot understand function prototype: 'unsigned int ps3_sm_force_power_off;'
>     Warning: drivers/ps3/ps3-sys-manager.c:35 Incorrect use of kernel-doc format:  * struct ps3_sys_manager_header - System manager message header.
>     Warning: drivers/ps3/ps3-sys-manager.c:43 cannot understand function prototype: '* @version: Header version, currently 1.  * @size: Header size in bytes, currently 16.  * @payload_size: Message payload size in bytes.  * @service_id: Message type, one of enum ps3_sys_manager_service_id.  * @request_tag: Unique number to identify reply.  */  struct ps3_sys_manager_header'
>     Warning: drivers/ps3/ps3-sys-manager.c:66 Cannot find identifier on line:
>     Warning: drivers/ps3/ps3-sys-manager.c:69 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: drivers/ps3/ps3-vuart.c:36 cannot understand function prototype: 'enum'
>     Warning: drivers/ps3/sys-manager-core.c:14 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: drivers/ps3/sys-manager-core.c:30 expecting prototype for ps3_register_sys_manager_ops(). Prototype was for ps3_sys_manager_register_ops() instead
>     Warning: drivers/regulator/pf9453-regulator.c:303 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: drivers/scsi/mpt3sas/mpt3sas_ctl.c:2913 expecting prototype for mpt3sas_send_passthru_cmd(). Prototype was for mpt3sas_send_mctp_passthru_req() instead
>     Warning: drivers/sh/intc/irqdomain.c:29 expecting prototype for intc_irq_domain_evt_xlate(). Prototype was for intc_evt_xlate() instead
>     Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'ctrlr' not described in 'intc_evt_xlate'
>     Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'd' not described in 'intc_evt_xlate'
>     Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'intsize' not described in 'intc_evt_xlate'
>     Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'intspec' not described in 'intc_evt_xlate'
>     Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'out_hwirq' not described in 'intc_evt_xlate'
>     Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'out_type' not described in 'intc_evt_xlate'
>     Warning: drivers/tty/serial/mux.c:351 expecting prototype for mux_drv_poll(). Prototype was for mux_poll() instead
>     Warning: drivers/video/fbdev/mmp/hw/mmp_spi.c:30 expecting prototype for spi_write(). Prototype was for lcd_spi_write() instead
>     Warning: drivers/virtio/virtio_ring.c:3308 expecting prototype for virtqueue_mapping_error(). Prototype was for virtqueue_map_mapping_error() instead
>     Warning: fs/befs/datastream.c:131 expecting prototype for befs_read_lsmylink(). Prototype was for befs_read_lsymlink() instead
>     Warning: ipc/sem.c:629 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: kernel/nstree.c:215 expecting prototype for ns_tree_adjoined_rcu(). Prototype was for __ns_tree_adjoined_rcu() instead
>     Warning: kernel/nstree.c:215 function parameter 'ns_tree' not described in '__ns_tree_adjoined_rcu'
>     Warning: lib/hweight.c:13 expecting prototype for hweightN(). Prototype was for __sw_hweight32() instead
>     Warning: lib/hweight.c:13 function parameter 'w' not described in '__sw_hweight32'
>     Warning: mm/swap_state.c:294 expecting prototype for swap_cache_clear_shadow(). Prototype was for __swap_cache_clear_shadow() instead
>     Warning: mm/vmalloc.c:4129 expecting prototype for vrealloc_node_align_noprof(). Prototype was for vrealloc_node_align() instead
>     Warning: security/apparmor/af_unix.c:618 Cannot find identifier on line:
>     Warning: security/apparmor/af_unix.c:626 expecting prototype for Requires(). Prototype was for aa_unix_peer_perm() instead
>     Warning: security/apparmor/af_unix.c:626 function parameter 'label' not described in 'aa_unix_peer_perm'
>     Warning: security/apparmor/af_unix.c:626 function parameter 'op' not described in 'aa_unix_peer_perm'
>     Warning: security/apparmor/af_unix.c:626 function parameter 'peer_label' not described in 'aa_unix_peer_perm'
>     Warning: security/apparmor/af_unix.c:626 function parameter 'peer_sk' not described in 'aa_unix_peer_perm'
>     Warning: security/apparmor/af_unix.c:626 function parameter 'request' not described in 'aa_unix_peer_perm'
>     Warning: security/apparmor/af_unix.c:626 function parameter 'sk' not described in 'aa_unix_peer_perm'
>     Warning: security/apparmor/af_unix.c:626 function parameter 'subj_cred' not described in 'aa_unix_peer_perm'
>     Warning: sound/soc/fsl/mpc5200_psc_ac97.c:222 cannot understand function prototype: 'const struct snd_soc_dai_ops psc_ac97_analog_ops ='
>     Warning: sound/soc/fsl/mpc5200_psc_i2s.c:123 cannot understand function prototype: 'const struct snd_soc_dai_ops psc_i2s_dai_ops ='
>     Warning: sound/usb/usx2y/us144mkii.c:13 Cannot find identifier on line:
>     Warning: sound/usb/usx2y/us144mkii.c:15 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: sound/usb/usx2y/us144mkii_capture.c:100 cannot understand function prototype: 'const struct snd_pcm_ops tascam_capture_ops ='
>     Warning: sound/usb/usx2y/us144mkii_controls.c:100 cannot understand function prototype: 'const struct snd_kcontrol_new tascam_line_out_control ='
>     Warning: sound/usb/usx2y/us144mkii_controls.c:171 cannot understand function prototype: 'const struct snd_kcontrol_new tascam_digital_out_control ='
>     Warning: sound/usb/usx2y/us144mkii_controls.c:259 cannot understand function prototype: 'const struct snd_kcontrol_new tascam_capture_12_control ='
>     Warning: sound/usb/usx2y/us144mkii_controls.c:330 cannot understand function prototype: 'const struct snd_kcontrol_new tascam_capture_34_control ='
>     Warning: sound/usb/usx2y/us144mkii_controls.c:408 cannot understand function prototype: 'const struct snd_kcontrol_new tascam_samplerate_control ='
>     Warning: sound/usb/usx2y/us144mkii_controls.c:6 Cannot find identifier on line:
>     Warning: sound/usb/usx2y/us144mkii_controls.c:8 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: sound/usb/usx2y/us144mkii_midi.c:158 cannot understand function prototype: 'const struct snd_rawmidi_ops tascam_midi_in_ops ='
>     Warning: sound/usb/usx2y/us144mkii_midi.c:369 cannot understand function prototype: 'const struct snd_rawmidi_ops tascam_midi_out_ops ='
>     Warning: sound/usb/usx2y/us144mkii_playback.c:146 cannot understand function prototype: 'const struct snd_pcm_ops tascam_playback_ops ='
> 
> Unverified Error/Warning (likely false positive, kindly check if interested):
> 
>     Warning: arch/arm/mach-omap2/cpuidle44xx.c:75 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: arch/arm/mach-omap2/prm33xx.c:322 expecting prototype for am33xx_prm_global_warm_sw_reset(). Prototype was for am33xx_prm_global_sw_reset() instead
>     Warning: drivers/char/xilinx_hwicap/fifo_icap.c:357 expecting prototype for buffer_icap_reset(). Prototype was for fifo_icap_reset() instead
>     Warning: drivers/char/xilinx_hwicap/fifo_icap.c:51 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: drivers/clk/zynq/pll.c:52 expecting prototype for zynq_pll_round_rate(). Prototype was for zynq_pll_determine_rate() instead
>     Warning: drivers/clk/zynq/pll.c:52 function parameter 'req' not described in 'zynq_pll_determine_rate'
>     Warning: drivers/clk/zynqmp/divider.c:122 expecting prototype for zynqmp_clk_divider_round_rate(). Prototype was for zynqmp_clk_divider_determine_rate() instead
>     Warning: drivers/clk/zynqmp/divider.c:122 function parameter 'req' not described in 'zynqmp_clk_divider_determine_rate'
>     Warning: drivers/clk/zynqmp/pll.c:102 expecting prototype for zynqmp_pll_round_rate(). Prototype was for zynqmp_pll_determine_rate() instead
>     Warning: drivers/clk/zynqmp/pll.c:102 function parameter 'req' not described in 'zynqmp_pll_determine_rate'
>     Warning: drivers/cpufreq/gx-suspmod.c:142 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: drivers/cpufreq/longrun.c:125 expecting prototype for longrun_verify_poliy(). Prototype was for longrun_verify_policy() instead
>     Warning: drivers/cpufreq/longrun.c:20 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: drivers/gpu/drm/drm_gpusvm.c:1229 expecting prototype for drm_gpusvm_range_pages_valid_unlocked(). Prototype was for drm_gpusvm_pages_valid_unlocked() instead
>     Warning: drivers/gpu/drm/drm_gpusvm.c:1229 function parameter 'svm_pages' not described in 'drm_gpusvm_pages_valid_unlocked'
>     Warning: drivers/infiniband/hw/mlx5/umr.c:986 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     Warning: drivers/mailbox/mailbox-xgene-slimpro.c:42 cannot understand function prototype: 'struct slimpro_mbox_chan'
>     Warning: drivers/mailbox/mailbox-xgene-slimpro.c:61 cannot understand function prototype: 'struct slimpro_mbox'
>     Warning: drivers/net/ethernet/intel/idpf/idpf_txrx.c:2407 expecting prototype for idpf_tx_splitq_has_room(). Prototype was for idpf_txq_has_room() instead
>     Warning: sound/soc/sdca/sdca_interrupts.c:265 expecting prototype for sdca_request_irq(). Prototype was for sdca_irq_request() instead
>     Warning: sound/soc/sdca/sdca_interrupts.c:265 function parameter 'info' not described in 'sdca_irq_request'

-- 
With Best Regards,
Andy Shevchenko



