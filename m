Return-Path: <linux-kernel+bounces-748940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C18B147DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3108189B9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857D62512FC;
	Tue, 29 Jul 2025 05:43:25 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25F23D2A2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767805; cv=none; b=l8qp0qz/p8k+aAuJlsoFnAecW6AdHeA/cXcUb2+J36etm4oi3ZAvQiJ4F8q6nYeZWnQ8F60GGyg64qb/80fyH+ymMhdZmd2fy8hxHPdkuyv05W0CjqIw/pG8W8JJR8bvLNGhYOJvCDguaqI2CtFf+xj2hPalbcBCJaNhVEY1fDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767805; c=relaxed/simple;
	bh=rfA1JS/fvd9p4kryGFPlRgls9rZsx7+PUcj+yzGF/G4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWYUGH1/oZylQkGPKXNbj2gLLutMXmuRHYGXC78mJ80v8co8rjdcp9IICTo9iRbU9XRLzex4RRJ1XAVoeU93SEScIGib/txIof+IkB7um1ASBvrR4rs1YE+63cHjqnYuUH6C0xZh5CGgVhIFbd1wDj9QcawlQlz/qMV2zeB+UdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABHNqpsX4ho97DhBw--.735S2;
	Tue, 29 Jul 2025 13:43:08 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/panel: himax-hx8279: Remove unneeded semicolon
Date: Tue, 29 Jul 2025 13:42:14 +0800
Message-Id: <20250729054214.2264377-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHNqpsX4ho97DhBw--.735S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DXFWDWrWrAFb_yoW3JFb_C3
	Wjqa4xurWDCFn0gF1xAay7ZF9Ika1kuan7Z3Wvkasakry7ur4UXa4xWrsxZw1DWr1jyF98
	Ca18XFyFvFnrWjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfkuxUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/panel/panel-himax-hx8279.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8279.c b/drivers/gpu/drm/panel/panel-himax-hx8279.c
index fb302d1f91b9..9e443c719843 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8279.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8279.c
@@ -935,7 +935,7 @@ static int hx8279_check_dig_gamma(struct hx8279 *hx, struct device *dev, const u
 			j++;
 			x++;
 		} while (x < 4);
-	};
+	}
 
 	return 0;
 }
-- 
2.25.1


