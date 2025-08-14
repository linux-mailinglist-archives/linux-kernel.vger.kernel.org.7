Return-Path: <linux-kernel+bounces-768475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E736B2616E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32E05A4557
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC292E7F18;
	Thu, 14 Aug 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u78ATZLq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FD280024
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164502; cv=none; b=b4xh8HU0+bmwHSTsPmy1BdQbCcSmK3gkbWmbkeXK11G8OCFIXu7YtUwDmT0gsap8zfY4r1laLtgn/HAVOGStpHDPciSDuJMtKIHr78iyenSVJDfkZRVnh12rULF1vcOrnwAr2NM+UTicOyVHKi1+7c2XR5dcJRrNBrErVzdDwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164502; c=relaxed/simple;
	bh=VAMwO3NcuTmsk/BxtnuIKVOvPEmhRux3rWhojqXD2c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1iCfNOoWeJiMgm7XLjWfYhcAMUx4S+TWeeIr84PL4Db9TwObp5HrEVUozB70F1PPDWjLbNKoFG6/51Vutgd4STh9kKBBE098Wn5VLo5WQs5iOjSS3/ZYzQu7sJIBu58LvfsueE5MK9FWJf292NkXACjsFrK/jgn5b8SHEc27SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u78ATZLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48831C4CEED;
	Thu, 14 Aug 2025 09:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755164501;
	bh=VAMwO3NcuTmsk/BxtnuIKVOvPEmhRux3rWhojqXD2c4=;
	h=From:To:Cc:Subject:Date:From;
	b=u78ATZLq9SbXaYfX6zNgkrXe9P4pFSv+sxeyrfiwK/go0Jh4dPxi2LfElXXPQrMaE
	 lxH6ov2PoHVpLptAHHjhwckBmBaNb263RJ2yYqy5pnb7TMNUUEjIpmihjZOxxQOw7+
	 8HOorzX7lhDTwVtFcodI633ofu2tNU+DzjHhN2aNfEFTYSp6bXhsdyF9zpx4OApPMl
	 OxEEhuvMqPlwbuiQMBm0qzj3dJl5SGhtaOpLNaFIZpQa5djNMzH1JnrJo5GgNYsZXY
	 jsqtmLjdzEouQECYg66pNtA0TF4mbmYS4ktCIYLRv8DjSPqECF2ijzsykjNbkbRqis
	 FVnUyZl76W/Lw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/gic-v5: Remove undue WARN_ON()s in the IRS affinity parsing
Date: Thu, 14 Aug 2025 11:41:38 +0200
Message-ID: <20250814094138.1611017-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gicv5_irs_of_init_affinity() a WARN_ON() is triggered if:

(1) a phandle in the "cpus" property does not correspond to a valid OF
    node
(2) a cpu logical id does not exist for a given OF cpu_node

(1) is a firmware bug and should be reported as such but does not grant
a WARN_ON() backtrace.

(2) is not necessarily an error condition (eg a kernel can be booted
with nr_cpus=X limiting the number of cores artificially) and therefore
there is no reason to clutter the kernel log with WARN_ON() output when
the condition is hit.

Rework the IRS affinity parsing code to remove undue WARN_ON()s thus
making it less noisy.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-irs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index e8a576f66366..ce2732d649a3 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -626,12 +626,14 @@ static int __init gicv5_irs_of_init_affinity(struct device_node *node,
 		int cpu;
 
 		cpu_node = of_parse_phandle(node, "cpus", i);
-		if (WARN_ON(!cpu_node))
+		if (!cpu_node) {
+			pr_warn(FW_BUG "Erroneous CPU node phandle\n");
 			continue;
+		}
 
 		cpu = of_cpu_node_to_id(cpu_node);
 		of_node_put(cpu_node);
-		if (WARN_ON(cpu < 0))
+		if (cpu < 0)
 			continue;
 
 		if (iaffids[i] & ~iaffid_mask) {
-- 
2.48.0


