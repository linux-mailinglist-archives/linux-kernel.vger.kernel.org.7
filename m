Return-Path: <linux-kernel+bounces-822838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8174DB84C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AB11C27E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DB30BB86;
	Thu, 18 Sep 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdyXsoJs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9E1A9FB8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201435; cv=none; b=Z0I1ngEKiSrhh1YI5qKxPgVA0eYTZ/TmPUJvdWG0ThX/dN18xoQ1LmIjaTnGleho+f1iSN8p3AfMFGQ7gdEDH95XnxQEVrNMutAv20t93niMiBkdJziC1d/LofygPOMDZeTHpkXMWHhtGAcqOuYgI+lgsj7X5Oymans3g5ERT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201435; c=relaxed/simple;
	bh=wmpH1IZheL6VhPF2kJkl7JWLrU5CCHpllonvyugZuLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNgz4KfkzCvfxhpT1MNNTL4GwKYRGd9BfGsRwwhemlbHqT61rwg8rMelKactpSIMUVxzuWKuI0AZXaBVT3rYXCpJSPgLVZxl6hA54S5AKmxZS+5WvT/lcKRExHrWuHh6OidE7l6KOtmZ8a02tjLVJJX3Cz/PTX39gDU8xQP64/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdyXsoJs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758201434; x=1789737434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wmpH1IZheL6VhPF2kJkl7JWLrU5CCHpllonvyugZuLM=;
  b=hdyXsoJs7GrNyGeiz5N3zX2uS3U+7mdt7fx4Od+8/jbS/dqTUAa/LUI5
   MW5/35oO+qsKfnCxTewjra3PWmJSgm8ImKRyDpGuK9zbtUIO8j7a8uuM3
   odmN3kjKKFyHN4l0nov5WOaFuHBp9S7GdCpGQeCkvNXEMalDfW19DzBFK
   bzhOACgkx6fSss/1LirQ7d2bFTs0QSIOFAq57fAP4m8F1XDgeMxPhV6Qf
   7Ud+EacJ1jAOzW/u9ThyBPTw9wmIBDEXPapfKQrg6ZlpFa0ICodpqK6ov
   ULrIG7EOEEAaIL/KzzaARZ8qp7eXNVMeMvR4IzFIJh9g3Zen2vSidmtwq
   g==;
X-CSE-ConnectionGUID: V/UNihOvTn6TKgvu6H2DtA==
X-CSE-MsgGUID: 2AWhan4hS0yE8aISLIUnNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77970705"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="77970705"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:13 -0700
X-CSE-ConnectionGUID: Oa8Q/8KNT329sbeah5lbYw==
X-CSE-MsgGUID: UcoAoAgjSFquIsX/aApd9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="174648798"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:12 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next 2/5] mei: make a local copy of client uuid in connect
Date: Thu, 18 Sep 2025 16:04:32 +0300
Message-ID: <20250918130435.3327400-3-alexander.usyskin@intel.com>
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

Connect ioctl has the same memory for in and out parameters.
Copy in parameter (client uuid) to the local stack to avoid it be
overwritten by out parameters fill.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index f37f9b8b1f51..2d41a05b8694 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -646,7 +646,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 	struct mei_cl *cl = file->private_data;
 	struct mei_connect_client_data conn;
 	struct mei_connect_client_data_vtag conn_vtag;
-	const uuid_le *cl_uuid;
+	uuid_le cl_uuid;
 	struct mei_client *props;
 	u8 vtag;
 	u32 notify_get, notify_req;
@@ -674,18 +674,18 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 			rets = -EFAULT;
 			goto out;
 		}
-		cl_uuid = &conn.in_client_uuid;
+		cl_uuid = conn.in_client_uuid;
 		props = &conn.out_client_properties;
 		vtag = 0;
 
-		rets = mei_vt_support_check(dev, cl_uuid);
+		rets = mei_vt_support_check(dev, &cl_uuid);
 		if (rets == -ENOTTY)
 			goto out;
 		if (!rets)
-			rets = mei_ioctl_connect_vtag(file, cl_uuid, props,
+			rets = mei_ioctl_connect_vtag(file, &cl_uuid, props,
 						      vtag);
 		else
-			rets = mei_ioctl_connect_client(file, cl_uuid, props);
+			rets = mei_ioctl_connect_client(file, &cl_uuid, props);
 		if (rets)
 			goto out;
 
@@ -707,14 +707,14 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 			goto out;
 		}
 
-		cl_uuid = &conn_vtag.connect.in_client_uuid;
+		cl_uuid = conn_vtag.connect.in_client_uuid;
 		props = &conn_vtag.out_client_properties;
 		vtag = conn_vtag.connect.vtag;
 
-		rets = mei_vt_support_check(dev, cl_uuid);
+		rets = mei_vt_support_check(dev, &cl_uuid);
 		if (rets == -EOPNOTSUPP)
 			cl_dbg(dev, cl, "FW Client %pUl does not support vtags\n",
-				cl_uuid);
+				&cl_uuid);
 		if (rets)
 			goto out;
 
@@ -724,7 +724,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 			goto out;
 		}
 
-		rets = mei_ioctl_connect_vtag(file, cl_uuid, props, vtag);
+		rets = mei_ioctl_connect_vtag(file, &cl_uuid, props, vtag);
 		if (rets)
 			goto out;
 
-- 
2.43.0


