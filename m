Return-Path: <linux-kernel+bounces-765583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0099EB23A55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0623B352E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C7629BDAE;
	Tue, 12 Aug 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5ts5EMZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810152D7388
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032419; cv=none; b=TvJkFdvPgOYpAhto2uwwkytDOwVpnMcC5+NBJkRSne7iQdRPKNz11O0lUeafL4Fq4g0hjudbFLSRnyDrtM43CdVYjnSYgeLtRC7LW/Yr0qdl5sWaDzDOza0h7mPssZqdz6QydH3CqztIJrnUXu0rIul7UPkH0ltmx90xGE8srR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032419; c=relaxed/simple;
	bh=RfNW80uw+KxM91xbMmHBARmklA9UD9Srj74FMwQeLBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UBRILkemVvGB2NfS8Q/OFsmPH9mQgVncHG38xsV+2VpEuMxNDU+lF3XJVae8MgB++bqHcrG3b37YPZt02o5UO+BVF0y+Xhbd1FX//DyUbuLAT2i5zxaeJraGh22mRdLnQoAgyg9tVv2RNk4ldnYwcL4Z5ZQZuxENbddevd7EFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5ts5EMZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755032417; x=1786568417;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=RfNW80uw+KxM91xbMmHBARmklA9UD9Srj74FMwQeLBE=;
  b=j5ts5EMZsNlLrhV0DimboA4MX9zF5uTLpZOGVWzABd/NCMASL6YZAM/K
   sDOnD/GVwLZxn5QAWb39KhqvS8Bz5jdAntIWre9Jp+ULP9/WejDLCbvrA
   mrVrkmZQT+JmBdOrV6TmiU8Hyaqn8Pd0U2kRsq2SYdiZkm8WrIRLwO1TE
   CJkfEMQbyWfKnlgNTVbZDd/DVRwzZ/3bwclYbmRfHNRJojfDH0qENAfQp
   GOVx1SPzWCcp+oOfkzwm6BSyQ4+326vS7O+nLTcIbItp8gQM1MXr9SeNO
   9sO2TxHnamXF+DUC3TkRFXvzq6snHi1YYKGFUmc9saJQlZviBPgZyCN74
   Q==;
X-CSE-ConnectionGUID: aWMgJoaMR6u0e5xaeBDTOg==
X-CSE-MsgGUID: zzSCVPxrQNW/z2Br77WsMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57220415"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57220415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 14:00:15 -0700
X-CSE-ConnectionGUID: o7k18JraSCWWuwRI/Pmoeg==
X-CSE-MsgGUID: qxACX5n0S3i3pxPMGvwUPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="203476565"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 14:00:16 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 12 Aug 2025 14:00:28 -0700
Subject: [PATCH] genirq/debugfs: Fix a typo in IRQ effective affinity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rneri-irq-debugfs-typo-v1-1-f29777b4024d@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAGurm2gC/x3MQQ5AMBBA0avIrE2iTUi5ilhoTWs2xRQh4u4ay
 794/4FEwpSgKx4QOjnxEnOosgA3jzEQ8pQbdKXryiiNEjNAlg0nskfwCfd7XVB7W5NpXKtaAxm
 vQp6vf9wP7/sBadiFxmgAAAA=
To: Thomas Gleixner <tglx@linutronix.de>
Cc: ricardo.neri@intel.com, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755032455; l=1030;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=RfNW80uw+KxM91xbMmHBARmklA9UD9Srj74FMwQeLBE=;
 b=R5H1L86iZnUdVna4+dPyZzdxCxH/qDolh1sCYg1Sje5jJkjaLzeNEjxDFgIwyn5M+16MJersB
 /UbVRFguNpdClfOHR/XY2bFwKwaWLSMppYi+aosVWc3Ttfpd7PcqENE
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Fix a typo in the line that prints the effective affinity of the IRQ.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 kernel/irq/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 3527defd2890..ee5e70751e83 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -30,7 +30,7 @@ static void irq_debug_show_masks(struct seq_file *m, struct irq_desc *desc)
 	seq_printf(m, "affinity: %*pbl\n", cpumask_pr_args(msk));
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	msk = irq_data_get_effective_affinity_mask(data);
-	seq_printf(m, "effectiv: %*pbl\n", cpumask_pr_args(msk));
+	seq_printf(m, "effective: %*pbl\n", cpumask_pr_args(msk));
 #endif
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	msk = desc->pending_mask;

---
base-commit: f6636ec7a7297f6ce226fae06ba6ace5419d38cd
change-id: 20250812-rneri-irq-debugfs-typo-2fb5e86c9198

Best regards,
-- 
Ricardo Neri <ricardo.neri-calderon@linux.intel.com>


