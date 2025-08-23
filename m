Return-Path: <linux-kernel+bounces-783346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BC5B32C00
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 22:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772D89E2A38
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 20:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218752EAD05;
	Sat, 23 Aug 2025 20:41:35 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13427202F93
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755981694; cv=none; b=mF6WCYUnI/rFjQP5Wq7nwXlErVVJLqfdGtE+XWsskQ1JXkzU6N0DgdTg1XAO7rrfnLnu+xKCC+XaS6/GlLL7HqDdq8zULTzxHlNSGvv6a54NDo9GGsKUN09XgqKgr+JgHTT1hciNIAFkfJ3zH1ROX2C4dBcKn/UKxLnY/HgYebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755981694; c=relaxed/simple;
	bh=wG3vvjHzyBSEBv33+pmHnTNn8b7XOAGIOz/5ug5o+HI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Tv29L7yz/gEFeKjCOoVCe0Wg+P2R3BDlIeN2dE5PBzFPdPv1VTasiU9FhT/uLxox4dcUhvY+aeftTCxCPfjiImfC3kZyhog0CUl1SudIfuNexW/dDS9K4ssRBof7z9pI+G6auYoA0DTxourbwO/XVJOs1AmyYth2MKUs4gq8yog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowAAnt3hmJ6poUtm0Dg--.189S2;
	Sun, 24 Aug 2025 04:41:11 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Sun, 24 Aug 2025 04:40:41 +0800
Subject: [PATCH] uio: uio_pdrv_genirq: Remove MODULE_DEVICE_TABLE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-uio-no-modalias-v1-1-aef6943d04ac@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAEgnqmgC/yXMQQ7CIBCF4auQWTsGKCr2KqYLoKNOIqDQNiZN7
 y6xy+8l71+hUmGq0IsVCi1cOacGdRAQni49CHlsBi31SVptcOaMKWPMo3uxq+iv3phOdtIGC+3
 1LnTn7794G3YX+swtPO0jeFcJQ46Rp14s56O6YAkKhm37AQMJIK6OAAAA
X-Change-ID: 20250824-uio-no-modalias-b9b4430308c8
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <monstr@monstr.eu>, Wolfram Sang <wsa@kernel.org>, 
 "Hans J. Koch" <hjk@hansjkoch.de>
Cc: Vivian Wang <uwu@dram.page>, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@suse.de>, Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:rQCowAAnt3hmJ6poUtm0Dg--.189S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4kXFW7tF1UJFyDZw4xJFb_yoW8GFyDpF
	48GFWayr4jgayUW3Z7A34fXa409347KrWv9FW7Kw1a9393AryjqF47KFnrG3s8Xr1rXay5
	AFWkXw18WFW0va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7
	UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

The struct of_device_id list here is filled in at load time. It does not
work with MODULE_DEVICE_TABLE, which generates an alias at build time.
In this case, it generates the aliases "of:N*T*" and "of:N*T*C*", which
matches *any* OF device node, which is obviously not intended. It
confuses userspace into loading this module for any OF device, and
confuses anyone trying to resolve an OF modalias.

Fixes: 27760f868663 ("uio: uio_pdrv_genirq: Add OF support")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 drivers/uio/uio_pdrv_genirq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index 2ec7d25e826490999404382e6aa69e4af56f7fe8..633ab6b916719e783d0f82cb2f8decac35a37054 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -276,7 +276,6 @@ static struct of_device_id uio_of_genirq_match[] = {
 	{ /* This is filled with module_parm */ },
 	{ /* Sentinel */ },
 };
-MODULE_DEVICE_TABLE(of, uio_of_genirq_match);
 module_param_string(of_id, uio_of_genirq_match[0].compatible, 128, 0);
 MODULE_PARM_DESC(of_id, "Openfirmware id of the device to be handled by uio");
 #endif

---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250824-uio-no-modalias-b9b4430308c8

Best regards,
-- 
Vivian "dramforever" Wang


