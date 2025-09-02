Return-Path: <linux-kernel+bounces-796006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1193B3FAC5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C32C0BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBC22EAB81;
	Tue,  2 Sep 2025 09:36:37 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242B2EBB86
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805796; cv=none; b=A89uSClgDnUk0DtgV1D1HpfVNyUp52Fix4PvKDfrC2LOgTm/98WTIy8gsFr8YDn/5x4tAM2a3KFD4T6kwawZ/k8Wa761FWOgldBlGWr4eUshhaBRqsOA26Mot6Qz4tpcEsVm6azRNiv1HXNszXdPWgBphKySk+FknHJwvowghMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805796; c=relaxed/simple;
	bh=BTcpOOCrbW5VF2bYpKR9MMM4WJPreot90BbewPeRJbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L04ZomFPn0yyh0rm/AO+nUN8mKTptLMqj75KSg461GxQCKx8xS3N7vxCHMlq/kyP16iagFUOH31+Xx/C+Krj0IXIz0vVJLrFY2ULImWSxYx4zrsMA2wtyKc1wRWiZM1Ee7Eu8uKgxzF/FXd6FZ2uys4/t1GJnbOfZCcEsmuqOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cGLGm3zdzzYQvDZ
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:36:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 116661A10E0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:36:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IyburZob2GEBA--.23566S4;
	Tue, 02 Sep 2025 17:36:28 +0800 (CST)
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH V2] mtd: core: skip badblocks increment for blocks already known bad
Date: Tue,  2 Sep 2025 17:27:32 +0800
Message-Id: <20250902092732.2244544-1-wangzhaolong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8IyburZob2GEBA--.23566S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1kGw47Kw4UKryxuF1fXrb_yoW8ur4Up3
	y5AryrCw4Fgw1Iq3ZrC3yxZa4fKwnagFy5KF4xGw15Cr98XF17Wrn5KF18Xr1IgFn2yFnI
	grs5tayDWay0vrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Fix by checking if the block is already bad before calling
->_block_markbad() when _block_isbad is available. Only skip the counter
increment when we can confirm the block was already bad. In all other
cases continue incrementing the counter.

This keeps the logic centralized in mtdcore without requiring driver
changes.

Link: https://lore.kernel.org/all/ef573188-9815-4a6b-bad1-3d8ff7c9b16f@huaweicloud.com/ [1]
Signed-off-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
---

V2:
- Checks old state when _block_isbad exists and bails out early if already bad

 drivers/mtd/mtdcore.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5ba9a741f5ac..096a3c94670f 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2337,10 +2337,11 @@ int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs)
 EXPORT_SYMBOL_GPL(mtd_block_isbad);
 
 int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	loff_t moffs;
 	int ret;
 
 	if (!master->_block_markbad)
 		return -EOPNOTSUPP;
 	if (ofs < 0 || ofs >= mtd->size)
@@ -2349,11 +2350,19 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
 		return -EROFS;
 
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
 
-	ret = master->_block_markbad(master, mtd_get_master_ofs(mtd, ofs));
+	moffs = mtd_get_master_ofs(mtd, ofs);
+
+	if (master->_block_isbad) {
+		ret = master->_block_isbad(master, moffs);
+		if (ret > 0)
+			return 0;
+	}
+
+	ret = master->_block_markbad(master, moffs);
 	if (ret)
 		return ret;
 
 	while (mtd->parent) {
 		mtd->ecc_stats.badblocks++;
-- 
2.39.2


