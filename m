Return-Path: <linux-kernel+bounces-814477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D86DB55489
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F227188D816
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE6E31A045;
	Fri, 12 Sep 2025 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkh6JTCW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A6311C03
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693718; cv=none; b=L4JxqcR6pcFDBzybIhfd9/B6RzFecbjXN8OT5CEzQKDLwVMxxkAY0+XjetMRvKwIl1fD4Ys3cArGsIDIAdbeM9sHdX1IxgVW061rJNkyNlJweHz1GUBHGVFqHImhdpm2RYDri4GFOCsOPmBGO4Y+GMUM/SJzTo3+KL57xqt8gO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693718; c=relaxed/simple;
	bh=UB5nB1zKXO3i6ZNdX3YVoESq8WNCHQer6cAJqxmAYis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G+VajjG6XO2oQJJXJKdT1lBfFWah4CWX8ojF9XqEBRdUtauzxrWZvkmAg64N6/pVUPuEbia8da3LHvB/6BN0qLoylLKC4+aJuMpPa62795WZHp5bUhnNZxLmdBbqcH7lV4p+Wgg0avDCyHiU44bHZ50HDlVX/Bga+fhaYCREV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkh6JTCW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757693717; x=1789229717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UB5nB1zKXO3i6ZNdX3YVoESq8WNCHQer6cAJqxmAYis=;
  b=dkh6JTCWrKXtp3CI0lEbCXLgE6LGgTwt978E+YkaGO/22bgfBR0PZKX8
   DzXhz6WZNnvG9wkq9y/eDIEGZZhuyIq4hGc7fyFq6i6UONTb9pZ0BXtoD
   Nm79R6pt+AP0AbRX//W2EcPmDnylwjDL4Y2IQfSeRtnnR356cOhtq1xNS
   qmIkz95kSs5ANCPI+6t49/Dy5FqzEeLm3NqRQoN9b0rGDYZ765jG+ZbxG
   TY7NJ5EUfRihaMrI+S7mBinEGd/OuCNY7gJQR5ALuxWLfl67RXDQnszDH
   DeRI5G68SKfVKrgirFL8VDsXZzR5B6iy0Fz5xM3Csf0l5muGCKCjt1fE0
   g==;
X-CSE-ConnectionGUID: X400umUeTkGaN2wPbdkUeg==
X-CSE-MsgGUID: gRWoqJUmR4Sx6xE2YWo/JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63863149"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63863149"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 09:15:17 -0700
X-CSE-ConnectionGUID: 1JvXhgfWQcSmIo7AAkNhrg==
X-CSE-MsgGUID: 4Nocg7h1SceunjpoFYvEgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="179176630"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa005.jf.intel.com with ESMTP; 12 Sep 2025 09:15:14 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] sched/deadline: Set cp->elements to NULL after kfree() in cpudl_init()
Date: Fri, 12 Sep 2025 21:43:38 +0530
Message-Id: <20250912161338.1079085-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set cp->elements to NULL after kfree() in the error path of cpudl_init()
to prevent potential use-after-free issues. This ensures that the pointer
is properly invalidated when memory allocation fails for cp->free_cpus,
making the code more robust against accidental access to freed memory.

Setting pointers to NULL after freeing helps debugging tools like kdgb,
drgn, and other kernel debuggers by providing clear indication that the
memory has been freed and the pointer is no longer valid.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/sched/cpudeadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index cdd740b3f774..0f7127b3a05c 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -276,6 +276,7 @@ int cpudl_init(struct cpudl *cp)
 
 	if (!zalloc_cpumask_var(&cp->free_cpus, GFP_KERNEL)) {
 		kfree(cp->elements);
+		cp->elements = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.34.1


