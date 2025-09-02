Return-Path: <linux-kernel+bounces-795793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CFDB3F7DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6E04877C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93892EA755;
	Tue,  2 Sep 2025 08:10:22 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5932F757
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800622; cv=none; b=JY8UNmTTuN5vTyWTqk9Yo2Y9Xtmh7hrJ53q5JEKCuC6R5gOStmps+mcnRdWho91bRsa/dXtndtlk3W5JNMTmJPBbQrYtC64k5xaMdm+p5PgApEqXZ41fQhLKzT287QEuW/cOWnDjwIs9Bf3uJxGcq4UjpNx+Jj7/B+6D0EgokxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800622; c=relaxed/simple;
	bh=VUsbJf13eTWHHzO6E1Tbng496k0TXqy2c0B2KcPX72E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rXpHTFNaPmLDuGMw950UALpnyiiwOV+46sjyXeGPtfi6Z4jhmhE13paMcdB/pkkznDdZq0BWuozWri+ceX0JlEUkCmzD0DFVJWDmfZ6dWBnPIzy4k9jZa1GvX4GGbnjLUZGb5fSQgNjW14Pjp1qg/akEl3S715J+MDAiUhL/lCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGJMB18b1zKHNS1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:10:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 07BEA1A1912
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:10:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY1jprZoh4x9BA--.23817S4;
	Tue, 02 Sep 2025 16:10:13 +0800 (CST)
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] mtd: core: only increment ecc_stats.badblocks on confirmed good->bad transition
Date: Tue,  2 Sep 2025 16:01:17 +0800
Message-Id: <20250902080117.3658372-1-wangzhaolong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY1jprZoh4x9BA--.23817S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr48Aw1UZF17Cr4UGFy8Krg_yoW5Jw1fpa
	15JryrGw4UWw1Iq3ZrAryIgwnag34fWFyUGF4xA3s8CF98Wa13Wrn5KFy8Xr12gF12yFnr
	Wr45t3yUWay09rDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: pzdqw6xkdrz0tqj6x35dzhxuhorxvhhfrp/

Repeatedly marking the same eraseblock bad inflates
mtd->ecc_stats.badblocks because mtd_block_markbad() unconditionally
increments the counter on success, while some implementations (e.g.
NAND) return 0 both when the block was already bad and when it has just
been marked[1].

Fix by probing the bad-block state before and after calling
->_block_markbad() (when _block_isbad is available) and only increment
the counter on a confirmed good->bad transition. If _block_isbad is not
implemented, be conservative and do not increment.

Keep the logic centralized in mtdcore; the markbad path is not a hot
path, so the extra IO is acceptable.

Link: https://lore.kernel.org/all/ef573188-9815-4a6b-bad1-3d8ff7c9b16f@huaweicloud.com/ [1]
Signed-off-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
---
 drivers/mtd/mtdcore.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5ba9a741f5ac..a6d38da651e9 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2338,10 +2338,12 @@ EXPORT_SYMBOL_GPL(mtd_block_isbad);
 
 int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 	int ret;
+	loff_t moffs;
+	int oldbad = -1;
 
 	if (!master->_block_markbad)
 		return -EOPNOTSUPP;
 	if (ofs < 0 || ofs >= mtd->size)
 		return -EINVAL;
@@ -2349,17 +2351,35 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
 		return -EROFS;
 
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
 
-	ret = master->_block_markbad(master, mtd_get_master_ofs(mtd, ofs));
+	moffs = mtd_get_master_ofs(mtd, ofs);
+
+	/* Pre-check: remember current state if available. */
+	if (master->_block_isbad)
+		oldbad = master->_block_isbad(master, moffs);
+
+	ret = master->_block_markbad(master, moffs);
 	if (ret)
 		return ret;
 
-	while (mtd->parent) {
-		mtd->ecc_stats.badblocks++;
-		mtd = mtd->parent;
+	/*
+	 * Post-check and bump stats only on a confirmed good->bad transition.
+	 * If _block_isbad is not implemented, be conservative and do not bump.
+	 */
+	if (master->_block_isbad) {
+		/* If it was already bad, nothing to do. */
+		if (oldbad > 0)
+			return 0;
+
+		if (master->_block_isbad(master, moffs) > 0) {
+			while (mtd->parent) {
+				mtd->ecc_stats.badblocks++;
+				mtd = mtd->parent;
+			}
+		}
 	}
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mtd_block_markbad);
-- 
2.39.2


