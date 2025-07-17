Return-Path: <linux-kernel+bounces-735423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B5CB08F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA74D18978B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9398E2F7CFA;
	Thu, 17 Jul 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcMOP/U/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291F2F6FA5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762261; cv=none; b=HIfm3xO555LZRBgXw/aMiwXHBrfTfu3MPPo8TRiaGMSKSLbFHMyX1fbQ9X2l6r5ch4V8vDh7o4+Zo6lewfZ/k/mrzVd5r33HEhx7CQmri4TsQ2mp/carBB8TF50jtDODWU/70PYpdz7tQ0mF2g7D4XbYC7/Vxb9vncjYJSO5+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762261; c=relaxed/simple;
	bh=i7bditcukXfbtIgrgmk0W5nYUhLIW6mPvpVST6FKUUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdfPUwvrA3fYq7u9aq3UHvAdf9B4J5JGMw6H8SaJ2oRLy96FGl6Gut/2Gd2H77PSFONvb/4LYO6eFd97+Hxh/8bvYQPDmsmVTTG1jzqccF1HCvkONqyIUVnXBSDGgjowIXHLDG/F5fAbEEg3KpxMzHgz4uV2W1DAo6+1Vlz9Lqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcMOP/U/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752762260; x=1784298260;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i7bditcukXfbtIgrgmk0W5nYUhLIW6mPvpVST6FKUUs=;
  b=mcMOP/U/C32EnHQeCUdZcDaXPNQdvlmXBf1Sf3mcuQp+1ki9sGBvRrLd
   zbpm1jpsB0LSbAHjRY7/blJ9aAtulWjvoJJ153ktBE1jkDokbrWqNZQB6
   hITfCc9yCTsJR20UPUMICaWJTW3wBmVUi0N2amQ8xpILTltME5WSAuEps
   m1XtD/VZYS24xTtsLxmC99+OYlQOqn36we/7XT3A7cdqjMYCDjFOvDRCH
   /voWM8SM0921eSGticgp0q55pkfCo4oUc1TwFEYWHIcYTZXzYJOgPWWMW
   4LRMfRS0BPWCDReJQ7Rmxul8DFI+EeTrQKW/pFZ64gi+aRNBDnV2Zoj4f
   w==;
X-CSE-ConnectionGUID: /fj7mzQzSceqLxln3yem3g==
X-CSE-MsgGUID: VEX88dQtTriyZdgr/JflaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="80486815"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="80486815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:24:19 -0700
X-CSE-ConnectionGUID: gaeRoKGUTIKbTVWCuIVQLg==
X-CSE-MsgGUID: PZ4hws9mSyCknwn9lTurpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="162105292"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:24:17 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next v4 0/3] mei: fix mei_device lifetime
Date: Thu, 17 Jul 2025 17:11:09 +0300
Message-ID: <20250717141112.1696482-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mei_device data structure is allocated using devm_* functions
and hooked to the parent device.
It works for client systems where parent device is pci one.
When parent device is auxiliary bus device produced by
graphics driver, the parent can be destroyed before child
and on the way it cleans all allocated memory.
This leads to use-after-free if mei character device is
opened when parent device is destroyed.

Connect mei_device structure lifteme to mei class device lifetime
by adding mei_device free to class device remove callback.
Decouple character device lifetime from parwnt structure lifetime.

As dev pointer in mei_device structure is converted to non-pointer
device all dev_* calls should be touched in this patch series.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14201

V2: Make cdev patches first to avoid double refcounting
    in the middle of the series.
    Replace manual refcount with special device.

V3: Use existing class device by Greg's insight, thanks!

V4: Merge cdev patches into main patch as cdev patches do not fix
    lifetime by itself and can't be merged standalone.
    This creates confusion in review and possibility of broken
    driver if only cdev patches are merged anywhere.

Alexander Usyskin (3):
  mei: bus: use cldev in prints
  mei: more prints with client prefix
  mei: hook mei_device on class device

 drivers/misc/mei/bus-fixup.c    |  16 ++--
 drivers/misc/mei/bus.c          |  42 +++++-----
 drivers/misc/mei/client.c       |  82 +++++++++----------
 drivers/misc/mei/client.h       |   6 +-
 drivers/misc/mei/dma-ring.c     |   8 +-
 drivers/misc/mei/gsc-me.c       |  16 ++--
 drivers/misc/mei/hbm.c          | 135 +++++++++++++++-----------------
 drivers/misc/mei/hw-me.c        | 100 +++++++++++------------
 drivers/misc/mei/hw-txe.c       |  60 +++++++-------
 drivers/misc/mei/init.c         |  47 ++++++-----
 drivers/misc/mei/interrupt.c    |  47 ++++++-----
 drivers/misc/mei/main.c         | 135 +++++++++++++++++++-------------
 drivers/misc/mei/mei_dev.h      |  12 +--
 drivers/misc/mei/pci-me.c       |  20 ++---
 drivers/misc/mei/pci-txe.c      |   4 +-
 drivers/misc/mei/platform-vsc.c |  26 +++---
 16 files changed, 390 insertions(+), 366 deletions(-)

-- 
2.43.0


