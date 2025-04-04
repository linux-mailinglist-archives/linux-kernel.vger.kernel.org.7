Return-Path: <linux-kernel+bounces-589422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B5CA7C5B8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 23:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE4F189F525
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CAE21C176;
	Fri,  4 Apr 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7/uv1Bb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E99215075
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802991; cv=none; b=U+YEB044CCWLg6skLWgIP5fciDgGqgpu7/0oSSDJpborsGScOO1fjR0GDDf2yktbjQj1AduVX/xWhuG2gmgIsFek0iZf9sAbCmKWKItdXR8v2EHKBw5pF9KHTF6pl0AsPsWfVvexJ6zwadOYbkY5LKpWIEMYqSWjQbed2Re0/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802991; c=relaxed/simple;
	bh=TksxcX6AdjZlTL0ygptGA4S0Olsrdx/aBxNS5l7SdNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F9okTOspLwpJ8y9c3Ti591aOqniiPOrQLcZES026rsi4d/pXCLthi2FpiSVmjYmuO/coaR4XldGA8J7EqOP+2W4a8Blm9xJA8M+/GzJPYk12yprFwUQFI3CFnlQ/GKkyiUJU3elX+HtzK3IVlRVQ0Z2c6euJ2JS9hyzNudKk6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7/uv1Bb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743802989; x=1775338989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TksxcX6AdjZlTL0ygptGA4S0Olsrdx/aBxNS5l7SdNU=;
  b=b7/uv1BbNETuEqVdh6zyXkWXQyi2UolsP1s4USXZQLJwh77uuUrwSLwW
   fa0m4qIV/OPE+p06wczd8CI9PlvKDsrVhiVw9Wv9mw/QdPeSEYr/k9jTS
   3BwR/0lHdleTuyFx0RJv5Z7y4mX3HSwycT4qsTEvHbQGraTXQYtl7SRZM
   gF8dsYXGMv5tRIytTFPh54vUhZotZfDHtLL90VJTxrHj8XHE56FbL+rL6
   4rscz90fzzfn2i97nVokTfMydDz1lLsuwUR2zRs4WejWFbwjrfcHMuGGt
   ZJceCml4Z5pWy+E8em4Yw8feTjx+39Qhibfc7zNkynx218LFL/V90Wjmt
   A==;
X-CSE-ConnectionGUID: XgRdDff7Rbato/IkUYEA3g==
X-CSE-MsgGUID: Nu+UdulTTdOebC3VMjHlTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="44975516"
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="44975516"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 14:43:08 -0700
X-CSE-ConnectionGUID: WDewsu9oRaOgt3KLt6epZQ==
X-CSE-MsgGUID: jTN2VY/pSPeATeneR47uOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="127399011"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 04 Apr 2025 14:43:06 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0ooa-0001ZD-20;
	Fri, 04 Apr 2025 21:43:04 +0000
Date: Sat, 5 Apr 2025 05:42:44 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [tip:timers/cleanups 1/11] drivers/usb/host/xhci.c:1074:4: error:
 call to undeclared function 'timer_delele_sync'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202504050709.BeTrXJO5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/cleanups
head:   b33f0e454c28ce1fd504367575accecdf4c64dc3
commit: 6bcfaeda89efec08e5fb2010927a1cf4e89f0f4d [1/11] treewide: Switch to timer_delete[_sync]()
config: i386-buildonly-randconfig-004-20250405 (https://download.01.org/0day-ci/archive/20250405/202504050709.BeTrXJO5-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250405/202504050709.BeTrXJO5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504050709.BeTrXJO5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/host/xhci.c:1074:4: error: call to undeclared function 'timer_delele_sync'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1074 |                         timer_delele_sync(&xhci->comp_mode_recovery_timer);
         |                         ^
   drivers/usb/host/xhci.c:1074:4: note: did you mean 'timer_delete_sync'?
   include/linux/timer.h:166:12: note: 'timer_delete_sync' declared here
     166 | extern int timer_delete_sync(struct timer_list *timer);
         |            ^
   drivers/usb/host/xhci.c:5360:23: warning: shift count >= width of type [-Wshift-count-overflow]
    5360 |                         !dma_set_mask(dev, DMA_BIT_MASK(64))) {
         |                                            ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   drivers/usb/host/xhci.c:5362:30: warning: shift count >= width of type [-Wshift-count-overflow]
    5362 |                 dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
         |                                            ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   2 warnings and 1 error generated.


vim +/timer_delele_sync +1074 drivers/usb/host/xhci.c

   990	
   991	/*
   992	 * start xHC (not bus-specific)
   993	 *
   994	 * This is called when the machine transition from S3/S4 mode.
   995	 *
   996	 */
   997	int xhci_resume(struct xhci_hcd *xhci, bool power_lost, bool is_auto_resume)
   998	{
   999		u32			command, temp = 0;
  1000		struct usb_hcd		*hcd = xhci_to_hcd(xhci);
  1001		int			retval = 0;
  1002		bool			comp_timer_running = false;
  1003		bool			pending_portevent = false;
  1004		bool			suspended_usb3_devs = false;
  1005	
  1006		if (!hcd->state)
  1007			return 0;
  1008	
  1009		/* Wait a bit if either of the roothubs need to settle from the
  1010		 * transition into bus suspend.
  1011		 */
  1012	
  1013		if (time_before(jiffies, xhci->usb2_rhub.bus_state.next_statechange) ||
  1014		    time_before(jiffies, xhci->usb3_rhub.bus_state.next_statechange))
  1015			msleep(100);
  1016	
  1017		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
  1018		if (xhci->shared_hcd)
  1019			set_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
  1020	
  1021		spin_lock_irq(&xhci->lock);
  1022	
  1023		if (xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken_suspend)
  1024			power_lost = true;
  1025	
  1026		if (!power_lost) {
  1027			/*
  1028			 * Some controllers might lose power during suspend, so wait
  1029			 * for controller not ready bit to clear, just as in xHC init.
  1030			 */
  1031			retval = xhci_handshake(&xhci->op_regs->status,
  1032						STS_CNR, 0, 10 * 1000 * 1000);
  1033			if (retval) {
  1034				xhci_warn(xhci, "Controller not ready at resume %d\n",
  1035					  retval);
  1036				spin_unlock_irq(&xhci->lock);
  1037				return retval;
  1038			}
  1039			/* step 1: restore register */
  1040			xhci_restore_registers(xhci);
  1041			/* step 2: initialize command ring buffer */
  1042			xhci_set_cmd_ring_deq(xhci);
  1043			/* step 3: restore state and start state*/
  1044			/* step 3: set CRS flag */
  1045			command = readl(&xhci->op_regs->command);
  1046			command |= CMD_CRS;
  1047			writel(command, &xhci->op_regs->command);
  1048			/*
  1049			 * Some controllers take up to 55+ ms to complete the controller
  1050			 * restore so setting the timeout to 100ms. Xhci specification
  1051			 * doesn't mention any timeout value.
  1052			 */
  1053			if (xhci_handshake(&xhci->op_regs->status,
  1054				      STS_RESTORE, 0, 100 * 1000)) {
  1055				xhci_warn(xhci, "WARN: xHC restore state timeout\n");
  1056				spin_unlock_irq(&xhci->lock);
  1057				return -ETIMEDOUT;
  1058			}
  1059		}
  1060	
  1061		temp = readl(&xhci->op_regs->status);
  1062	
  1063		/* re-initialize the HC on Restore Error, or Host Controller Error */
  1064		if ((temp & (STS_SRE | STS_HCE)) &&
  1065		    !(xhci->xhc_state & XHCI_STATE_REMOVING)) {
  1066			if (!power_lost)
  1067				xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);
  1068			power_lost = true;
  1069		}
  1070	
  1071		if (power_lost) {
  1072			if ((xhci->quirks & XHCI_COMP_MODE_QUIRK) &&
  1073					!(xhci_all_ports_seen_u0(xhci))) {
> 1074				timer_delele_sync(&xhci->comp_mode_recovery_timer);
  1075				xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
  1076					"Compliance Mode Recovery Timer deleted!");
  1077			}
  1078	
  1079			/* Let the USB core know _both_ roothubs lost power. */
  1080			usb_root_hub_lost_power(xhci->main_hcd->self.root_hub);
  1081			if (xhci->shared_hcd)
  1082				usb_root_hub_lost_power(xhci->shared_hcd->self.root_hub);
  1083	
  1084			xhci_dbg(xhci, "Stop HCD\n");
  1085			xhci_halt(xhci);
  1086			xhci_zero_64b_regs(xhci);
  1087			retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
  1088			spin_unlock_irq(&xhci->lock);
  1089			if (retval)
  1090				return retval;
  1091	
  1092			xhci_dbg(xhci, "// Disabling event ring interrupts\n");
  1093			temp = readl(&xhci->op_regs->status);
  1094			writel((temp & ~0x1fff) | STS_EINT, &xhci->op_regs->status);
  1095			xhci_disable_interrupter(xhci->interrupters[0]);
  1096	
  1097			xhci_dbg(xhci, "cleaning up memory\n");
  1098			xhci_mem_cleanup(xhci);
  1099			xhci_debugfs_exit(xhci);
  1100			xhci_dbg(xhci, "xhci_stop completed - status = %x\n",
  1101				    readl(&xhci->op_regs->status));
  1102	
  1103			/* USB core calls the PCI reinit and start functions twice:
  1104			 * first with the primary HCD, and then with the secondary HCD.
  1105			 * If we don't do the same, the host will never be started.
  1106			 */
  1107			xhci_dbg(xhci, "Initialize the xhci_hcd\n");
  1108			retval = xhci_init(hcd);
  1109			if (retval)
  1110				return retval;
  1111			comp_timer_running = true;
  1112	
  1113			xhci_dbg(xhci, "Start the primary HCD\n");
  1114			retval = xhci_run(hcd);
  1115			if (!retval && xhci->shared_hcd) {
  1116				xhci_dbg(xhci, "Start the secondary HCD\n");
  1117				retval = xhci_run(xhci->shared_hcd);
  1118			}
  1119			if (retval)
  1120				return retval;
  1121			/*
  1122			 * Resume roothubs unconditionally as PORTSC change bits are not
  1123			 * immediately visible after xHC reset
  1124			 */
  1125			hcd->state = HC_STATE_SUSPENDED;
  1126	
  1127			if (xhci->shared_hcd) {
  1128				xhci->shared_hcd->state = HC_STATE_SUSPENDED;
  1129				usb_hcd_resume_root_hub(xhci->shared_hcd);
  1130			}
  1131			usb_hcd_resume_root_hub(hcd);
  1132	
  1133			goto done;
  1134		}
  1135	
  1136		/* step 4: set Run/Stop bit */
  1137		command = readl(&xhci->op_regs->command);
  1138		command |= CMD_RUN;
  1139		writel(command, &xhci->op_regs->command);
  1140		xhci_handshake(&xhci->op_regs->status, STS_HALT,
  1141			  0, 250 * 1000);
  1142	
  1143		/* step 5: walk topology and initialize portsc,
  1144		 * portpmsc and portli
  1145		 */
  1146		/* this is done in bus_resume */
  1147	
  1148		/* step 6: restart each of the previously
  1149		 * Running endpoints by ringing their doorbells
  1150		 */
  1151	
  1152		spin_unlock_irq(&xhci->lock);
  1153	
  1154		xhci_dbc_resume(xhci);
  1155	
  1156		if (retval == 0) {
  1157			/*
  1158			 * Resume roothubs only if there are pending events.
  1159			 * USB 3 devices resend U3 LFPS wake after a 100ms delay if
  1160			 * the first wake signalling failed, give it that chance if
  1161			 * there are suspended USB 3 devices.
  1162			 */
  1163			if (xhci->usb3_rhub.bus_state.suspended_ports ||
  1164			    xhci->usb3_rhub.bus_state.bus_suspended)
  1165				suspended_usb3_devs = true;
  1166	
  1167			pending_portevent = xhci_pending_portevent(xhci);
  1168	
  1169			if (suspended_usb3_devs && !pending_portevent && is_auto_resume) {
  1170				msleep(120);
  1171				pending_portevent = xhci_pending_portevent(xhci);
  1172			}
  1173	
  1174			if (pending_portevent) {
  1175				if (xhci->shared_hcd)
  1176					usb_hcd_resume_root_hub(xhci->shared_hcd);
  1177				usb_hcd_resume_root_hub(hcd);
  1178			}
  1179		}
  1180	done:
  1181		/*
  1182		 * If system is subject to the Quirk, Compliance Mode Timer needs to
  1183		 * be re-initialized Always after a system resume. Ports are subject
  1184		 * to suffer the Compliance Mode issue again. It doesn't matter if
  1185		 * ports have entered previously to U0 before system's suspension.
  1186		 */
  1187		if ((xhci->quirks & XHCI_COMP_MODE_QUIRK) && !comp_timer_running)
  1188			compliance_mode_recovery_timer_init(xhci);
  1189	
  1190		if (xhci->quirks & XHCI_ASMEDIA_MODIFY_FLOWCONTROL)
  1191			usb_asmedia_modifyflowcontrol(to_pci_dev(hcd->self.controller));
  1192	
  1193		/* Re-enable port polling. */
  1194		xhci_dbg(xhci, "%s: starting usb%d port polling.\n",
  1195			 __func__, hcd->self.busnum);
  1196		if (xhci->shared_hcd) {
  1197			set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
  1198			usb_hcd_poll_rh_status(xhci->shared_hcd);
  1199		}
  1200		set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
  1201		usb_hcd_poll_rh_status(hcd);
  1202	
  1203		return retval;
  1204	}
  1205	EXPORT_SYMBOL_GPL(xhci_resume);
  1206	#endif	/* CONFIG_PM */
  1207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

