Return-Path: <linux-kernel+bounces-889999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFC1C3F0A2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A17C3AE87C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C664A2DF12F;
	Fri,  7 Nov 2025 08:53:34 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5B2D7DE4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505614; cv=none; b=vAPon1IGM4og4C+mGqBmay/AMOfZnV3bCvx13pTifWnJ81vPQm26E8rLt7UPztMug92bd131oS8V4ThMaUGjdW1eZ5PYxiCTZNDH3CGxJquxH5PM2sY1dpAieoE7um7EyeVMCK8429EaEdViDRm28c+VYtxkQ1Ut0xIQaLZWZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505614; c=relaxed/simple;
	bh=lZ8dxU6T0goAvvW9jXH3sqlt3KB8QjZC+eTqLRZD1yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqFJr4qzmqc39jpe6yBfxhsq5S7w/DVFpNaco9A9ff6FCDxBrAObZyUN1eKJi+WJiGf2FA3k230wmcMBvLSxJ+19f8IU7ete5KBrKRNI8/DDMdwQsQZX8f1KJ+4QGo460r/Z6Tro+ybXfKYvOsU1kXPcxonkJzx/4KYZm5lNOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAXlOt6sw1pKo3ZAQ--.8489S2;
	Fri, 07 Nov 2025 16:53:14 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] regulator: mt6363: Remove unneeded semicolon
Date: Fri,  7 Nov 2025 16:51:09 +0800
Message-Id: <20251107085109.2316999-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXlOt6sw1pKo3ZAQ--.8489S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DWw47ZrykGrg_yoW3ZrXEkF
	yfu3WxursrZFsrKr1xXa1q9rZ0q3Wqqa12g3yjgFWft347AFn8A347urW7Z39xJ3y8trnr
	Ww17Xr4fZr13ujkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0JUyUDXUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/regulator/mt6363-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6363-regulator.c b/drivers/regulator/mt6363-regulator.c
index 94ac955afa45..e0fbf92e7685 100644
--- a/drivers/regulator/mt6363-regulator.c
+++ b/drivers/regulator/mt6363-regulator.c
@@ -363,7 +363,7 @@ static unsigned int mt6363_regulator_get_mode(struct regulator_dev *rdev)
 			return REGULATOR_MODE_FAST;
 	} else {
 		val = 0;
-	};
+	}
 
 	ret = regmap_read(rdev->regmap, info->hw_lp_mode_reg, &val);
 	val &= info->hw_lp_mode_mask;
-- 
2.25.1


