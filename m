Return-Path: <linux-kernel+bounces-892569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 401C5C455F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A9504E5D83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4D2F83A7;
	Mon, 10 Nov 2025 08:27:23 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3017218AB0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763243; cv=none; b=o7YQmoR0S3hT4V+v6cfMVAFzrSeQu3/PjVqwJrTrWA3eGzoOCt8K0k0XNlUNCWGtkPOCNoHEZTFQTefsMa/jsse4JUh5zEVTGJBTnlsDxmKw/ljqre7UG08YBQbKvDgH9zL35bizxRfcFCpNQsuM1czJK9ZDWNdFXKB5V0DHeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763243; c=relaxed/simple;
	bh=wJWHebgrYKzfaMDxrTJCt2SRjGANAbVo1bTHRG5X3NY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hcj39DPmo6c6PdmtOokIg2exI0wzH8Q21bs+TU6xNZGQPxYhMTZb4jpbnSlu//ZBEuxLXKGAo4N2HbE2Q7ARfKBdzuvWlhy0V/KIKme85XxKUNkaVNeA5anW3o0c4UArCmjvmb3kYal3ZV4tzzV8bafNamH+HEdTCzaFoEt6SCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAB3CNvjoRFp3aU2AA--.10298S2;
	Mon, 10 Nov 2025 16:27:15 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] nvmem: qnap-mcu-eeprom: Convert comma to semicolon
Date: Mon, 10 Nov 2025 16:27:06 +0800
Message-Id: <20251110082706.3258532-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3CNvjoRFp3aU2AA--.10298S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4rCw4kuw4kuw1xGrW3ZFb_yoWkXFX_Za
	48Zwn3Z3yjyr15Kr15Cr4avFW3tFyaga9Yvr1Ig39Iv3yUZay3WanrZrWDAry5uw45CF9x
	Kw1UG3ya9a429jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU04E_DUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/nvmem/qnap-mcu-eeprom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/qnap-mcu-eeprom.c b/drivers/nvmem/qnap-mcu-eeprom.c
index 0b919895b3b2..07bdaa2a33fa 100644
--- a/drivers/nvmem/qnap-mcu-eeprom.c
+++ b/drivers/nvmem/qnap-mcu-eeprom.c
@@ -86,10 +86,10 @@ static int qnap_mcu_eeprom_probe(struct platform_device *pdev)
 	nvcfg.read_only = true;
 	nvcfg.root_only = false;
 	nvcfg.reg_read = qnap_mcu_eeprom_read;
-	nvcfg.size = QNAP_MCU_EEPROM_SIZE,
-	nvcfg.word_size = 1,
-	nvcfg.stride = 1,
-	nvcfg.priv = mcu,
+	nvcfg.size = QNAP_MCU_EEPROM_SIZE;
+	nvcfg.word_size = 1;
+	nvcfg.stride = 1;
+	nvcfg.priv = mcu;
 
 	ndev = devm_nvmem_register(&pdev->dev, &nvcfg);
 	if (IS_ERR(ndev))
-- 
2.25.1


