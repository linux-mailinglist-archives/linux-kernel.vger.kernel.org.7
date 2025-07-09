Return-Path: <linux-kernel+bounces-724025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7949DAFEDB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9326A176B97
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372692E8DF8;
	Wed,  9 Jul 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OG/j3EPF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E592E7F3B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074812; cv=none; b=E21ES7Y+oIHVRhdCdDD9FSEBT8rPrG4NVdsPo3w8J5LoI11QieeD6KU+gONRL06fb5YgMwmvzQaKs3AVGvOZl4oenRKm7QPcxwZ+5P5FWIv1ahitrZuMWfNqbtqyrgjn7H3ToNEU6NmsbAq/FBGTln51zuPCJLExc/lz+wVhW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074812; c=relaxed/simple;
	bh=fkqSrszonc6CYHM9mwCkBFQcYyL70DUkCfbaT0jpal8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kiquFvVTp/+o3BB0Qq5mSSdUuDMoy2OjSpKo8uohFEO9jreJ/t8XeUBu2T1Kq0tUKSGftZSpaIVv3D0LpCqPpmWOVOF8Mtw6Gzwc0jKrsCM33eVHh0Fs2QfMaQEcOfDi1m5Nec5wx29DscUiI+PnseWBR+7k1EiKHk9XFw9gXeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OG/j3EPF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752074811; x=1783610811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fkqSrszonc6CYHM9mwCkBFQcYyL70DUkCfbaT0jpal8=;
  b=OG/j3EPFbUoFBXLyFlW5Nk9KqaHNcQbZY6e1C1VSTUVNTuawqV7Ymqhc
   dMCQ/A3T6rvE+Lu/QOIxIWgBzO9A32yxT+d7Ng9KuI3i1fps0SsqBK2B6
   vQW5Xel0cCjmuoxsbs+RfeH3tLCZw7FoH0fTVQ8xQCNMTi7fmNJdANdVc
   0D5eCDfzNY94R2BlAwgAUu3Siabr+UFTPCzEbzrNppWaLzwlaAWKrCmAl
   m71k5YaProA1/wF+LQEQYE7Txxs9weYKHIbz3bqOE/ZZyGPDzL/lWO7Rs
   rFw3Zj3NWzFGTOrDBiseUCtPKEBnBqPZVp0ei0deVoJY3DyOuOw98TRsl
   A==;
X-CSE-ConnectionGUID: eW730pPGSheOvxn6BHCjKQ==
X-CSE-MsgGUID: bSQGbOjXQs6oCSvzOilNWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54487378"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54487378"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:50 -0700
X-CSE-ConnectionGUID: Af8xvLPrRaK7UTVT/Xd4VQ==
X-CSE-MsgGUID: UHnadyTgRWiaaYo4O+mCZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155557793"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:49 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next v3 0/5] mei: fix mei_device lifetime
Date: Wed,  9 Jul 2025 18:13:39 +0300
Message-ID: <20250709151344.104942-1-alexander.usyskin@intel.com>
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

Alexander Usyskin (5):
  mei: set parent for char device
  mei: make char device control its own lifetime
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


