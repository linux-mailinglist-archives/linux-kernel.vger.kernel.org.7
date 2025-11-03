Return-Path: <linux-kernel+bounces-882186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEEC29D66
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 03:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BFA188F2E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 02:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFA927E05A;
	Mon,  3 Nov 2025 02:02:22 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAA1DC198;
	Mon,  3 Nov 2025 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762135342; cv=none; b=O2aENJwBN51dl0+BJCGiJwUBUKVTk63R2tqF8op7HouADau4Oh3FZLsi4wcSIHVEjTkA2xxZl5/ukCAH7WWjm6TRyb9kOQixv8inWijqU+AyoqRVMV+kBoRVMwH6YkvbMXNsttGMwMTKzWU5v4lOxolRxdLz4LqrConD+OV7bRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762135342; c=relaxed/simple;
	bh=Cm01nGDoGaXtlhaHwXjvtORV306MaykgatDv2UumqSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAUFOmbAZVCa0YZ3GqUHbJgAlYju0HQTzfpvjtLv9PNcGcUgF49nIgVX0a13qYUxgtjwzco3Tb2UCfXyJvAI4QwHYpgs2UvA6wJjvD5RNMCbGtGWEviohz3jc1qpwy5FJbqMej/Epc3XN5ntR/2du+U2Nk3vtQC7uMnWBzrgj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAD3dOwfDQhpdzckAQ--.20597S2;
	Mon, 03 Nov 2025 10:02:08 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] usb: musb: ux500: Fix PHY resource leak in error path
Date: Mon,  3 Nov 2025 10:02:04 +0800
Message-ID: <20251103020204.796-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3dOwfDQhpdzckAQ--.20597S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyxCw4rGFyDXw4xAF1fJFb_yoWDuwbE9F
	y8Wr4xW3Z093WDCr1DGrW3ZrWS9anrX3ykWF4IqF9xG3WjvF1Dur1qvrZ8Zr48Kw47ur1D
	tr98ur17uF1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcPA2kIAqYyZAAAsU

The ux500_musb_init() function calls usb_get_phy() to obtain a PHY
resource, but fails to release it with usb_put_phy() when
usb_register_notifier() fails. This leads to a resource leak as the
PHY reference count is not properly decremented.

Add usb_put_phy() call in the error path before returning to ensure
the PHY resource is properly released when notifier registration fails.

Fixes: 0135522c4898 ("usb: musb: ux500: add otg notifier support")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/usb/musb/ux500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 8c2a43d992f5..14c5e986937e 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -155,6 +155,7 @@ static int ux500_musb_init(struct musb *musb)
 	status = usb_register_notifier(musb->xceiv, &musb->nb);
 	if (status < 0) {
 		dev_dbg(musb->controller, "notification register failed\n");
+		usb_put_phy(musb->xceiv);
 		return status;
 	}
 
-- 
2.50.1.windows.1


