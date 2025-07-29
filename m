Return-Path: <linux-kernel+bounces-748850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C10B146B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8994E0C66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778C120101F;
	Tue, 29 Jul 2025 03:17:59 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683A2260C;
	Tue, 29 Jul 2025 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753759079; cv=none; b=DBZbiGn7l9b7yGfrFdFxix10r9ApcVs5BbdKXDtogrvPaRQ2H8LuoJ+jLccW711s3KzhAzkPSnajf+wyod3Y9A3/RpwQ/elcZoq5WpEuwQAUlebFw6WI8aPeT81HnJvB3ypnPyRgnFlIUeHzLJmObGN8IqQYRhiCdHSAzpmGdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753759079; c=relaxed/simple;
	bh=tygmW2uoxQYzNKfTdHikqO3RxfdrjVAiULDXbrijOFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tiIipDLfatNFl2jrFUrvOuMVqeqCeqgnQvpowuqnCkpHtAFUD8sIvWYxJPK+Fg/7YsSct58p+6e6MAZZtZ8gwav1Fo0hJRUU1LbLxbPWS/346mXiHr4qDWl8+DoHIB2kKV2dN0uERP/IsExsYkknYoH1YAdOAVcKfItCMCGBraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADnPl9UPYhoGn_KBw--.58388S2;
	Tue, 29 Jul 2025 11:17:40 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: nichen@iscas.ac.cn,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: wmi-capdata01: Remove unneeded semicolon
Date: Tue, 29 Jul 2025 11:16:31 +0800
Message-Id: <20250729031631.1644740-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnPl9UPYhoGn_KBw--.58388S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DWrWDKryrCrg_yoW3Zwb_uF
	109F17Jw1DCa4vyr15trWS93sFyw4UWwsYgryxtFy3tayDZa1UJFy2va9rJ39xXry8JFyf
	C3yDGr93u34rAjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUUPrcDUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/platform/x86/lenovo/wmi-capdata01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-capdata01.c b/drivers/platform/x86/lenovo/wmi-capdata01.c
index c922680b3cba..fc7e3454e71d 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata01.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata01.c
@@ -93,7 +93,7 @@ int lwmi_cd01_get_data(struct cd01_list *list, u32 attribute_id, struct capdata0
 			continue;
 		memcpy(output, &list->data[idx], sizeof(list->data[idx]));
 		return 0;
-	};
+	}
 
 	return -EINVAL;
 }
-- 
2.25.1


