Return-Path: <linux-kernel+bounces-822840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D37B84C57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE67C14C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6230C0F8;
	Thu, 18 Sep 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9CI3B3W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E010530BF72
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201439; cv=none; b=SEoj/exMpokLiMC1LEx/z/9mwU2OZe/zCMIys+yD/l2Ncc/+TsW1hl8c4pMX23L/gImba3T3+eh84fAkpdEUyQguTcLYGjzxRt07VCJzWiEc41u8auxT9oZX5/rTCvQZ3erSeZSz9rWZ0YEfSeUiKyxYCAAKAPOSn0N33izjF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201439; c=relaxed/simple;
	bh=cCKdZ3ZZ1wN9QStz9vQvSl2cJMIHWSxg2MtRAGlyOvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRj4q6e/ty0w7/1W4z8t6ihSRWzOwl9Jk1+E33mC5gBtLhKGn3ZDgPj7egHy+xeEkv4S3JIyB4CQKDmUKNRezOsw3ob4aaxyJ6RWBTiNtnwgRJs8N47gslWiSyJtIiQkfekSoGzB0Iw+OoUdkd6JO4cQ0qeHeyaSz8fx9BU+WZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9CI3B3W; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758201438; x=1789737438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCKdZ3ZZ1wN9QStz9vQvSl2cJMIHWSxg2MtRAGlyOvw=;
  b=c9CI3B3WCEg/HN2XwpIQi16hCcSdhL9DdmpVI8ZyFkviXI2UJeYdHJol
   AyHoD7oqF4Q3kxc5vR8cFX/0HTx6mnmZ/nSLsty5DfbcZ99Z9L3lYOmnC
   sEBiO7uYsuzpe0lDe8vqNwR9apJpfsLRn3pQJO+NsQZpOPO0sG5s5qEi1
   bTvrMCPWe1IZA5ADayFcRb4UVSbkSdMFV63eW0UHgLOxmzslOjm1t+EK2
   8dpmgRBHz5vPXqrF9quNyB1wfO5TL/wf06erDqsWKuWz8KaaOCFdamTTw
   Xt4eKDsMI0InSLPQDfIF505uxr9kKUJUp9nRRO1C7m/iYna+0hBby9jaL
   A==;
X-CSE-ConnectionGUID: ELtz1gDfRkWynApQJhs4jQ==
X-CSE-MsgGUID: STP0o3ogQ26snJrlce6/2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77970716"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="77970716"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:17 -0700
X-CSE-ConnectionGUID: 6gF2HXcETfiH8kx7vOr6Bg==
X-CSE-MsgGUID: jyapRIJyTkmnbVwd0tfogg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="174648826"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:16 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next 4/5] mei: bus: demote error on connect
Date: Thu, 18 Sep 2025 16:04:34 +0300
Message-ID: <20250918130435.3327400-5-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918130435.3327400-1-alexander.usyskin@intel.com>
References: <20250918130435.3327400-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are flows, like exit from D3cold where connect via bus can fail.
Demote error print to debug level to unclutter dmesg.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 6c8ec5c0d359..38735a41f750 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -814,7 +814,7 @@ int mei_cldev_enable(struct mei_cl_device *cldev)
 
 	ret = mei_cl_connect(cl, cldev->me_cl, NULL);
 	if (ret < 0) {
-		dev_err(&cldev->dev, "cannot connect\n");
+		dev_dbg(&cldev->dev, "cannot connect\n");
 		mei_cl_bus_vtag_free(cldev);
 	}
 
-- 
2.43.0


