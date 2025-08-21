Return-Path: <linux-kernel+bounces-779292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D121B2F1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7F4604CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1868B2F0C6B;
	Thu, 21 Aug 2025 08:22:25 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E62F0C57
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764544; cv=none; b=DLlXsVuvzsuLJ1V+J3iQwdhuH1BlvhHAM05RyImq2kr+JJXdT+o1H/0jTyCyaUb4d1VNdW+JPbmpJbKnoN7VUGETjeeQUeiGH6lPJutK06d5dkngsOuNnrTnbBSJoR1AmbYc8h97viw0qfiNEcvUjZ9RduuytsGBFfWFH2oGMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764544; c=relaxed/simple;
	bh=GM6vYbI37qNlJSnNSofRaqt+bjYceTxlIAvWCfrrNXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bYDD7k3CXldMxwIQU9+Vt9DChA/jvhRSmg5BMaiAuiQoJeQ+vtAchPSeICFO9O819ADOMdxqZKVZyK8FA8jJh2xWJUnneYswZcFqxa3oem+WNawfSKlwimi7Ci5aXbIYY01QL9Rm5uyZrlst0A6s23PGiE8v2K73iwTNxsOKOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADnPl8016ZoUOL4DQ--.15326S2;
	Thu, 21 Aug 2025 16:22:12 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	abd.masalkhi@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] misc: eeprom/m24lr: Remove unneeded semicolon
Date: Thu, 21 Aug 2025 16:18:04 +0800
Message-Id: <20250821081804.3168680-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnPl8016ZoUOL4DQ--.15326S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWr1ktw4xGr1rWF48CFyfWFg_yoWxXrX_C3
	y0gFsrAry5Cas8Kr15Jw4S9ryjya18u34kuw1IqF4Sy342vw4xA34Uur4rXw4DZF10vF97
	Wr1Dua4Skr109jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUj9mRUUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/misc/eeprom/m24lr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/m24lr.c b/drivers/misc/eeprom/m24lr.c
index 0e37f74881ce..7a9fd45a8e46 100644
--- a/drivers/misc/eeprom/m24lr.c
+++ b/drivers/misc/eeprom/m24lr.c
@@ -350,7 +350,7 @@ static ssize_t m24lr_read_reg_le(struct m24lr *m24lr, u64 *val,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	return 0;
 }
-- 
2.25.1


