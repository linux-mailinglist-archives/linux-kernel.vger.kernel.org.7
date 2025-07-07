Return-Path: <linux-kernel+bounces-720418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26FBAFBB7F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0BEC7A9127
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E8265CCB;
	Mon,  7 Jul 2025 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8G0pTWS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5B221DA8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915299; cv=none; b=uw1125NjdgCGyhaW9JMBgjHdnerIu8t4cvneLN747oLpSmGL58F9UKb4t1yFOXcU7O1SllWkpvjW9RR5YLoZz4wx/msfitr3Sv7hboGakPZJVm27f/WVviKuW8QbSb7grkikrajjewOCkjx7U+96R9nsReguQzJ+c7K3yAgoFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915299; c=relaxed/simple;
	bh=c2YSEl9vpj0ifOWacuvN26c2JZ5CqpHX/3EngJUDEFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EtOUz6A9lY5fguBfr9B86pfcnR0A4G74miowKfTeX94VP29sLK2QKrFUou8qmiOWc/X3T8E56UJTKTTXn1o6pvMTqAiLb/Rjh5dgAQnx3z+2xKiPc4WMm9rqmHMvACUfrdr/IW1IjofOzV4x7WHiP6YkRjL47JXvMhkj98nvIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8G0pTWS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751915298; x=1783451298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c2YSEl9vpj0ifOWacuvN26c2JZ5CqpHX/3EngJUDEFk=;
  b=H8G0pTWShrpOPDmYkCV6eYSGHesUHsNXs6Xo6OPuG2k9hqP8wVIF/RYo
   by2UIhhFKD9zIEpj8udYJ6J4ddHQD26QhKzsR5YGMcjRbOVlmmP6uTvy6
   l/ePyxCmgLjiK/lwwtJ1LiSkIsGsFmbF7+4Qur/i9ljtti+hO8itONwZ5
   Ldkjfn5CFNwSwui83keIwWfCxZc76VHTCh0TvWmZaAhIXoB7WCo0bLRV9
   Y4CVxtjqjei+vPbPlUAP7leVYNIctozg8ob19UpAofzXLAi5SnFWHLUQp
   fa3652tIXSL7py1aDSU3jRjBy3qvx/csmoeysmhu++Q+CDDj5OweVe9ZS
   g==;
X-CSE-ConnectionGUID: a10k7r1oTqC8k6xXag6Irw==
X-CSE-MsgGUID: cRXiJrCURpaduYGZ1+va4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57945659"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="57945659"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:17 -0700
X-CSE-ConnectionGUID: /UdWRQuIRNiJ/blY2CBWHQ==
X-CSE-MsgGUID: CVpw7KzwSq6txjP5igm8sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154707401"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:13 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com
Subject: [PATCH v7 0/9] Introducing firmware late binding
Date: Tue,  8 Jul 2025 00:42:28 +0530
Message-Id: <20250707191237.1782824-1-badal.nilawar@intel.com>
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

 - Dropped patch 10

Alexander Usyskin (2):
  mei: bus: add mei_cldev_mtu interface
  mei: late_bind: add late binding component driver

Badal Nilawar (7):
  drm/xe/xe_late_bind_fw: Introducing xe_late_bind_fw
  drm/xe/xe_late_bind_fw: Initialize late binding firmware
  drm/xe/xe_late_bind_fw: Load late binding firmware
  drm/xe/xe_late_bind_fw: Reload late binding fw in rpm resume
  drm/xe/xe_late_bind_fw: Reload late binding fw during system resume
  drm/xe/xe_late_bind_fw: Introduce debug fs node to disable late
    binding
  drm/xe/xe_late_bind_fw: Extract and print version info

 drivers/gpu/drm/xe/Makefile                 |   1 +
 drivers/gpu/drm/xe/xe_debugfs.c             |  41 ++
 drivers/gpu/drm/xe/xe_device.c              |   5 +
 drivers/gpu/drm/xe/xe_device_types.h        |   6 +
 drivers/gpu/drm/xe/xe_late_bind_fw.c        | 462 ++++++++++++++++++++
 drivers/gpu/drm/xe/xe_late_bind_fw.h        |  17 +
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h  |  75 ++++
 drivers/gpu/drm/xe/xe_pci.c                 |   2 +
 drivers/gpu/drm/xe/xe_pci_types.h           |   1 +
 drivers/gpu/drm/xe/xe_pm.c                  |   8 +
 drivers/gpu/drm/xe/xe_uc_fw_abi.h           |  66 +++
 drivers/misc/mei/Kconfig                    |  11 +
 drivers/misc/mei/Makefile                   |   1 +
 drivers/misc/mei/bus.c                      |  13 +
 drivers/misc/mei/mei_late_bind.c            | 271 ++++++++++++
 include/drm/intel/i915_component.h          |   1 +
 include/drm/intel/late_bind_mei_interface.h |  62 +++
 include/linux/mei_cl_bus.h                  |   1 +
 18 files changed, 1044 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_late_bind_fw.c
 create mode 100644 drivers/gpu/drm/xe/xe_late_bind_fw.h
 create mode 100644 drivers/gpu/drm/xe/xe_late_bind_fw_types.h
 create mode 100644 drivers/misc/mei/mei_late_bind.c
 create mode 100644 include/drm/intel/late_bind_mei_interface.h

-- 
2.34.1


