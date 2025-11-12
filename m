Return-Path: <linux-kernel+bounces-896736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B8CC51158
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A071894243
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA6B2DEA6F;
	Wed, 12 Nov 2025 08:22:29 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFC186294
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935749; cv=none; b=iKa4uXCVjx3ecIW0cAlDgmmXQ0xP+WrUqBScmxbA2YuuLPhqr0Kau7u+DzS9KJmxJ7lu+3eMsYEtDhouDXKVJVV7tUE1HZCf1OaNrHSfpluA1I5auL7UP1QufztkI1JNnLK0fhWucTjpZiKj3I+M9HFLbDqrUK7wZIFQQBOF4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935749; c=relaxed/simple;
	bh=QNumVf59qzQB51ZSyMfW94XWugLFRV2Fh5+/YBr0Jpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XiUwrJEftnqs2vSIMlFq545Cv2tIWi1h1A33Qdx77cRvMzCebURBel57yWDTBP3fdBefleWE3zS+uvtnHAqvQdL6ngk5Y08R5wUxqE2WkdXQux9K7qPHQCPjsl6o6xBgQSYv+yR7hFIoSKrOunMKkLol6draXqR69oH6u8xnk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowABHm928QxRpxgN2AA--.23911S2;
	Wed, 12 Nov 2025 16:22:21 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Bob Copeland <me@bobcopeland.com>
Cc: linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] omfs: check sb_set_blocksize return value
Date: Wed, 12 Nov 2025 16:21:13 +0800
Message-ID: <20251112082114.1105-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHm928QxRpxgN2AA--.23911S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4DAw43uFy8Aw1xJr1kKrg_yoWkXrb_A3
	W7ZrykGw4Fqr1Fyws8C34YyrZY9rsruw1xWF43tr15uF98KFn8Xw4qgF98GF4DWa48W398
	u3ykWFW5Jr1Y9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUVMKAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoEA2kUGH2txwAAs4

The code validates that sbi->s_sys_blocksize does not exceed PAGE_SIZE,
but fails to verify that the block size is a power of two, which could
lead to memory corruption or system crashes.

Check the return value of sb_set_blocksize() and return -EINVAL on failure.

Fixes: 555e3775ced1 ("omfs: add inode routines")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 fs/omfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 135c49c5d848..24f58d10a93e 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -523,7 +523,11 @@ static int omfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * Use sys_blocksize as the fs block since it is smaller than a
 	 * page while the fs blocksize can be larger.
 	 */
-	sb_set_blocksize(sb, sbi->s_sys_blocksize);
+	if (!sb_set_blocksize(sb, sbi->s_sys_blocksize)) {
+		pr_err("omfs: Invalid system block size %d\n",
+				sbi->s_sys_blocksize);
+		goto out_brelse_bh;
+	}
 
 	/*
 	 * ...and the difference goes into a shift.  sys_blocksize is always
-- 
2.50.1.windows.1


