Return-Path: <linux-kernel+bounces-894663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BEDC4B8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16A03A8EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF83D28468D;
	Tue, 11 Nov 2025 05:26:48 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1F237A4F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762838808; cv=none; b=gcRGUC2WJ+v9ukJ4JWj2Fy7nzQctfiU7Ec2vWy62wRBlByGMq1cPesv6nUJ6OuNGKLU+xDwWtBLEHREGwWgHFsPwo62EC4xpKxgrmVi8NFRXYWAEx10Zhw+WyjzvSn1JdrmWUBGYT02hGd8TCcMzkVPRj0+KRgklMPpia1f3V9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762838808; c=relaxed/simple;
	bh=l5rjWQGKvU9HKfeIJsveKeznQBmRCpC1TOoGh0InXdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p38yPxGR+arTCuHLWu3tHSjhz1nInoEvDJ9fuXSkFTHuu2t8GeRNLrfwZuiKssUZFwugxSo6mERKi1HkCHRZ4/VUyYY5JI4YIi2NtpNI8vb/eXWfITE/BiWOahXTYK3RsVIRxdPwBbfCWpFRZQN8XLl+BZ35NB/rKC9doDRkXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAAnvMsLyRJpGqBOAA--.3148S2;
	Tue, 11 Nov 2025 13:26:35 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: zhoubinbin@loongson.cn,
	qiaochong@loongson.cn,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] mfd: ls2kbmc: Remove unneeded semicolon
Date: Tue, 11 Nov 2025 13:24:51 +0800
Message-Id: <20251111052451.3687740-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnvMsLyRJpGqBOAA--.3148S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DWrWkZr4ktFb_yoWxAwb_uF
	1DZw47Wr9xAwnIv3WUXr4fZryvy3WDur48XF40yF45JFy2vF47XF90vF15Z345Aw1UuF95
	GFyjqFyjv34xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUjvD73UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/mfd/ls2k-bmc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 69387dad6661..e42f1de9e641 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -265,7 +265,7 @@ static int ls2k_bmc_recover_pci_data(void *data)
 		if (!ls2k_bmc_bar0_addr_is_set(parent))
 			break;
 		mdelay(1);
-	};
+	}
 
 	if (i == 0)
 		return false;
-- 
2.25.1


