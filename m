Return-Path: <linux-kernel+bounces-797993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8FFB41822
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8997D1B236B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7692EA468;
	Wed,  3 Sep 2025 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccvU4TE7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E622E7BAC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887262; cv=none; b=HERYUtwNUI7L4P0XnS8kmJiWSSTLsU8FyuaAOqtpbVwe9YB4W0DgRWI7IV+VTq/B0j8DKmWiAWSdMB7MWVuboSsarxdmu3Idp+aKdnlAc5+jxQQPDlBlQMMJeGBv+s6F4Po658+aJkT2MAo9Ab2YetZTpXAW7TYfY5mjgP+sCxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887262; c=relaxed/simple;
	bh=UsxmT48ZkvcIpmHsJt+8ZU+J2MNRX2CZYyGfQXr97Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hU/GLUnP5pDX2SJHmm+2flhQjCt+/UsGbEwu3YvIclugfLs8qTp7RBOXztXkxEYbmLRsDD7KGjYyT9Ub+zoJQYWUifchaNav6QR+8TuLGsYUyNf+puPLr7F0APd313+ax9S6ASfFF4zsmn0liJPO0DEc11jsrW2vuYlhj98oM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccvU4TE7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756887261; x=1788423261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UsxmT48ZkvcIpmHsJt+8ZU+J2MNRX2CZYyGfQXr97Ew=;
  b=ccvU4TE78hDDGkXVNxc+GbyU6VUV2TOpVObDbZz1UCyvEabzsfxBUndV
   yfY0HzTqHDZNP1XsiLH51yev/bURQfg47qvcJJ5CMaDcbIrdKj/FxjPnU
   J3hNtcv5paKskYh3vjUWJXjCACcGm6M2B/mhD6Lr+RWNhXnKpl/WAMr2Q
   OzAis/ykfHuOOIdx5ptLx/UchHnBg9eanUVl2Mx/2ac4daxm4I1/mLvMr
   LDKH83KwxPtTQYl2IxdcjaOFr/SLDZ0ZCHWAtR9TqweUqlOc0tbMKK3yr
   rYmWQVptV1paBeFQ7S19N2SLQiTEH5U/KFozWHTBuaToLbLpcO8WcMA95
   w==;
X-CSE-ConnectionGUID: vOA/4CN7SJC0vOZyh3DyRQ==
X-CSE-MsgGUID: 01nZUDpgSDGX5K4ocQHZdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70621389"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="70621389"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:14:19 -0700
X-CSE-ConnectionGUID: 3iw70NX3TBik9Edm5F8a4A==
X-CSE-MsgGUID: +oZj9FAqQvSXb5sRjLjPDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171092930"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 03 Sep 2025 01:14:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BB88894; Wed, 03 Sep 2025 10:14:15 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Peter Tyser <ptyser@xes-inc.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 0/2] mfd: lpc_ich: Simplify GPIO resource handling
Date: Wed,  3 Sep 2025 10:12:27 +0200
Message-ID: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper to iopoll.h which allows to simplify GPIO resource handling
in lpc_ich driver for the starter. The helper can be used in many other cases.

Andy Shevchenko (2):
  resource: Introduce resource_rebase() helper
  mfd: lpc_ich: Convert to use resource_rebase()

 drivers/mfd/lpc_ich.c  | 38 ++++++++------------------------------
 include/linux/ioport.h |  6 ++++++
 2 files changed, 14 insertions(+), 30 deletions(-)

-- 
2.50.1


