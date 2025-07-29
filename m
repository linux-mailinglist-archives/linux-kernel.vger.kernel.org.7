Return-Path: <linux-kernel+bounces-748873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95340B14705
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB161AA1618
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898FC225760;
	Tue, 29 Jul 2025 04:01:45 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973178F5E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753761705; cv=none; b=O5BHxCj5cbTEAPUmV00c/IVrP+oLxZE/jod8BZAPDXYmnpuyAloP8ozcLaU4kh/FiAl+CHy2pHXBHp+hZp+8YDXP6TrUCrugjPYvKI1meOmrOn38HJmwQtmtHvOs/wbSGFxTd71C4pEB2UDEDdYj8sEf0GJHf8xrASUYQHSsD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753761705; c=relaxed/simple;
	bh=fCVQW2oU71n8RwIXwCAb+vtSST06warG6ccYt/cCBTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jStcqsqBoMiF+XEx0w587fa9U2WpvKOGavVLewRf4Gi2CAQX/Hj32QxaYEZG1vvlok22wVUSdWrQGtjo4z23TFfIwJQY2cenWmq+URRQpscLSqSHj8kL7yxZnwow6ZxbHU7r4LRnsLnaE1It8n8LmDGj/CeadeT7NijifcuffDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABn_FyiR4hor3TNBw--.62141S2;
	Tue, 29 Jul 2025 12:01:38 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] regulator: tps6594-regulator: Remove unneeded semicolon
Date: Tue, 29 Jul 2025 12:00:44 +0800
Message-Id: <20250729040044.1851988-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn_FyiR4hor3TNBw--.62141S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DWw47CFWfKrg_yoW3Wrg_Cw
	17Za1xWr4kZF4Ykr1UJa1qyF90vwnFva1Igr4qgFZxJ3y2v3WDJa4fWry7C398Aw4UJrnx
	WwsxWr45Cr1SgjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUbzVUUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/regulator/tps6594-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index ab882daec7c5..645e83462c64 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -647,7 +647,7 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 	default:
 		dev_err(tps->dev, "unknown chip_id %lu\n", tps->chip_id);
 		return -EINVAL;
-	};
+	}
 
 	enum {
 		MULTI_BUCK12,
-- 
2.25.1


