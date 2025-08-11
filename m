Return-Path: <linux-kernel+bounces-761865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3935AB1FF68
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D8757A445E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E4274B34;
	Mon, 11 Aug 2025 06:35:03 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2B275AE4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894103; cv=none; b=ipNgGTfo6K8Cveonphn9m9lREHZLCvBoM8O37nWcJrR7qhVHgpOwzpM5cONeLadan0rsUgGTGAJTzNlz5mRkY/kUEtl4NgHPCzegGZfnZLx0wXYt1252k9YceOhU4wzJLI0twPkj2UmTaoxtjx6VALK5Lt+LydHwMlKUVoEpRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894103; c=relaxed/simple;
	bh=oOVkSModVj6oy67yH3vCuzlfZcVVnejd0mcHgqGcQ3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jpMJBNrA5EqESGaAs8jYX5yBvxxxQtsnsM+UqbWPoA5LMyPG4xTGT6mAfpgqyO0N+rkFu5E7XNKHOUZGDOM1StxQHyLu6fCYYtFoK2wAzkVIQLVvdsmmRG33ZHQXpIFH336SOJCw2DvZUM1QFB74nAo44LclKGZPg5PKLbTF9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <ajones@ventanamicro.com>, <cleger@rivosinc.com>,
	<charlie@rivosinc.com>, <jesse@rivosinc.com>, <evan@rivosinc.com>, Fushuai
 Wang <wangfushuai@baidu.com>
Subject: [PATCH] riscv: Use for_each_online_cpu() instead of for_each_cpu()
Date: Mon, 11 Aug 2025 14:33:52 +0800
Message-ID: <20250811063352.1770-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc11.internal.baidu.com (172.31.3.21) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the opencoded for_each_cpu(cpu, cpu_online_mask) loop with the
more readable and equivalent for_each_online_cpu(cpu) macro.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 arch/riscv/kernel/unaligned_access_speed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index ae2068425fbc..5e11b1bd9b2a 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -150,7 +150,7 @@ static void __init check_unaligned_access_speed_all_cpus(void)
 	 * Allocate separate buffers for each CPU so there's no fighting over
 	 * cache lines.
 	 */
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
 		if (!bufs[cpu]) {
 			pr_warn("Allocation failure, not measuring misaligned performance\n");
@@ -165,7 +165,7 @@ static void __init check_unaligned_access_speed_all_cpus(void)
 	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
 
 out:
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		if (bufs[cpu])
 			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
 	}
-- 
2.36.1


