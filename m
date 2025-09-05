Return-Path: <linux-kernel+bounces-803278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD485B45CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918D21CC48AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93BF2FB0AA;
	Fri,  5 Sep 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YY12Ubh5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FB306B1C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087119; cv=none; b=sbbie51/ikZDg0tUpIhpDgmcpQpclxl+2VIw5EYfEGRwE0wbLfYlyTVPPWhPazlbbgAEDC2Y83eixg1yNY6EloVUSRxYSt55M0KdD2W82JOcke4SEEVg33xScuio7IEqNB0dZD/7EMJW3gzgWI+mI+2w4j0Rs+Y4EuZoDGqFjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087119; c=relaxed/simple;
	bh=ZA3KuiUrCXrGL+kA3QY+rg/vAplHfhJkpg1VyzIApQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kjB/8IZsHaDjayXO+jQ6XWbAQqItTeCZRb51Us+RHACjw7Bwg/ODOkAhBsl9MXeHJ4No79PWjqoSVtHSQFR9g5ixzpCie3tzPkj92UgutJKV1dtls1JvsqEpzryvIKD3yemOzDEUoSzqldt4lH6fFUi8diSkJoLS/47RfPrktjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YY12Ubh5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757087117; x=1788623117;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZA3KuiUrCXrGL+kA3QY+rg/vAplHfhJkpg1VyzIApQU=;
  b=YY12Ubh570G62glnaCH6yUoAr9WWmWJAFSVgr8vHY9hnVvam4KDiS2/Y
   7f90UoxnlLqBCvOYSZfgcDPlOfwFP1hTuw/zSrb1AQrmiRo1pp2WoSFRA
   ipVQO+6+Y+hBH6+cHSPNbfX5TUIhDS8lk50lKAXKgXOLoliPs5lLS/LJu
   j2ZPSWLpfqx2h7o0/FrOJZjfqnsPLjyeJtviceRXaJynG9GYQb80J7EFE
   39tO/SNRE0pHmpSY489KmMHRDAn3g30QBL/NKrkaBg5X59K1Nk5aPVQod
   qmTXIvPGAXefC5TOHZpB5XeNzww4aqNq5VoHS9lVpttW0R90chMwnTR5U
   g==;
X-CSE-ConnectionGUID: aAUjkFPbTLmzZPK/JhhdaQ==
X-CSE-MsgGUID: Izjm+p3OT+O+wmsrZ/sZtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70144625"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70144625"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:17 -0700
X-CSE-ConnectionGUID: ZLfsiy5bQHiMHsIcKKRT/g==
X-CSE-MsgGUID: 0mrTalSGTiSvVcPGDy7MPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172071699"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:13 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com,
	mika.westerberg@linux.intel.com,
	lucas.demarchi@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v9 0/9] Introducing firmware late binding
Date: Fri,  5 Sep 2025 21:19:44 +0530
Message-Id: <20250905154953.3974335-1-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing firmware late binding feature to enable firmware loading
for the devices, such as the fan controller and voltage regulator,
during the driver probe.
Typically, firmware for these devices are part of IFWI flash image but
can be replaced at probe after OEM tuning.

v2:
 - Dropped voltage regulator specific code as binaries for it will not
   be available for upstreaming as of now.
 - Address review comments
v3:
 - Dropped fwctl patch for now
 - Added new patch to extract binary version
 - Address v2 review comments
v4:
 - Address v3 review comments
v5:
 xe_kmd:
 - Dropped mutex is worker flush in unbind blocking component
   removal while fw download is in progress
 - Handled the fw load in all 3 scenarios (probe, system resume, rpm resume)
   by holding rpm wake ref in outer bounds of worker.
 mei:
 - Most of the review comments
v6:
 - rebased
 - Disabled fw load upon error
v7:
 xe_kmd:
 - resolved kernel doc warnings
 mei:
 - Address v6 review comments (greg kh)
v8:
 - https://lore.kernel.org/intel-xe/20250710150831.3018674-11-rodrigo.vivi@intel.com
v9:
 mei:
 - The MEI patches underwent internal review, as requested by Greg in v8.
 xe_kmd:
 - Rebased, Address review comments

Alexander Usyskin (2):
  mei: bus: add mei_cldev_mtu interface
  mei: late_bind: add late binding component driver

Badal Nilawar (7):
  drm/xe/xe_late_bind_fw: Introduce xe_late_bind_fw
  drm/xe/xe_late_bind_fw: Initialize late binding firmware
  drm/xe/xe_late_bind_fw: Load late binding firmware
  drm/xe/xe_late_bind_fw: Reload late binding fw in rpm resume
  drm/xe/xe_late_bind_fw: Reload late binding fw during system resume
  drm/xe/xe_late_bind_fw: Introduce debug fs node to disable late
    binding
  drm/xe/xe_late_bind_fw: Extract and print version info

 drivers/gpu/drm/xe/Makefile                |   1 +
 drivers/gpu/drm/xe/xe_debugfs.c            |  41 ++
 drivers/gpu/drm/xe/xe_device.c             |   5 +
 drivers/gpu/drm/xe/xe_device_types.h       |   6 +
 drivers/gpu/drm/xe/xe_late_bind_fw.c       | 464 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_late_bind_fw.h       |  17 +
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h |  75 ++++
 drivers/gpu/drm/xe/xe_pci.c                |   2 +
 drivers/gpu/drm/xe/xe_pci_types.h          |   1 +
 drivers/gpu/drm/xe/xe_pm.c                 |   8 +
 drivers/gpu/drm/xe/xe_uc_fw_abi.h          |  66 +++
 drivers/misc/mei/Kconfig                   |  13 +
 drivers/misc/mei/Makefile                  |   1 +
 drivers/misc/mei/bus.c                     |  13 +
 drivers/misc/mei/mei_lb.c                  | 312 ++++++++++++++
 include/drm/intel/i915_component.h         |   1 +
 include/drm/intel/intel_lb_mei_interface.h |  70 ++++
 include/linux/mei_cl_bus.h                 |   1 +
 18 files changed, 1097 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_late_bind_fw.c
 create mode 100644 drivers/gpu/drm/xe/xe_late_bind_fw.h
 create mode 100644 drivers/gpu/drm/xe/xe_late_bind_fw_types.h
 create mode 100644 drivers/misc/mei/mei_lb.c
 create mode 100644 include/drm/intel/intel_lb_mei_interface.h

-- 
2.34.1


