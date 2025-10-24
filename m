Return-Path: <linux-kernel+bounces-868150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52205C047C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4F53AEAAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5692A26E716;
	Fri, 24 Oct 2025 06:21:44 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735DE1E51FA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286904; cv=none; b=SUyd3Lj/Bdy/HclsTyXZ8j+tIFyvLcuNEyE1s8hCHfd0t6tYXCBcvag4eAVCFI8vGX8aU63YwUnyqiCJqqjRZxu4OHD2LJ/2r2Ucb+q9+jI6LPGMv8asLbsBS9ZtZQ/IKuOhZ6c8uRqwnmAKo5Smg345cJEDWkUcJfPhwvuAntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286904; c=relaxed/simple;
	bh=V2J2UHds0RdOipBSWFozpaRZktnF0D0uH1n1AmtJFkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXZGtscA+rd+hO1/SbeaUuXX5yIc0qJaRYg8lMPsWyzGsUh/us/BXEhRcArCtGF+9SfkhH3CrgmvEFeFfahotOISYU3/wPZ8OrHaQ+8/eQA7I5xNocBO/KzD+D8n8sz9QjMaHpKtZ1dnZMXiG5yQZCEgsZ852Yhq9bC2WSmlpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202510241421317694;
        Fri, 24 Oct 2025 14:21:31 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 24 Oct 2025 14:21:32 +0800
Received: from inspur.com (10.100.2.108) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Oct 2025 14:21:32 +0800
Received: from localhost.localdomain.com (unknown [10.94.15.147])
	by app4 (Coremail) with SMTP id bAJkCsDwZrXrGvto2RwPAA--.3118S5;
	Fri, 24 Oct 2025 14:21:32 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>
CC: <ntb@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH for-next 1/1] net: ntb: migrate to dma_map_phys instead of map_page
Date: Fri, 24 Oct 2025 14:20:42 +0800
Message-ID: <20251024062042.29971-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251024062042.29971-1-chuguangqing@inspur.com>
References: <20251024062042.29971-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bAJkCsDwZrXrGvto2RwPAA--.3118S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW5Zw1kZw45Wr1rXw1DWrg_yoW8WFWkpF
	95JFW5Kr4Iqr45Z397Jw48Zry5Aayvq34IkFWxK3sIkFZ3Xr9ak3WrKayktrs7Gr48XayF
	qrWUA3WrC348C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE3s1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUemhwUUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?P1z5VpRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+Ka5/cslaGy953u1/jgndaEeL0IFV8HUJ6FIoYir7oYNEFrFd9ewyYrxBRY3r7zmrRFP8
	xHpvJK+5EwWCfDe4RvY=
Content-Type: text/plain
tUid: 20251024142131952affa8520047863c47f16539000d50
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

After introduction of dma_map_phys(), there is no need to convert
from physical address to struct page in order to map page. So let's
use it directly.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/ntb/ntb_transport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index eb875e3db2e3..f7121a517021 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1570,15 +1570,15 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 		goto err;
 
 	unmap->len = len;
-	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(offset),
-				      pay_off, len, DMA_TO_DEVICE);
+	unmap->addr[0] = dma_map_phys(device->dev, virt_to_phys(offset),
+				      len, DMA_TO_DEVICE, 0);
 	if (dma_mapping_error(device->dev, unmap->addr[0]))
 		goto err_get_unmap;
 
 	unmap->to_cnt = 1;
 
-	unmap->addr[1] = dma_map_page(device->dev, virt_to_page(buf),
-				      buff_off, len, DMA_FROM_DEVICE);
+	unmap->addr[1] = dma_map_phys(device->dev, virt_to_phys(buf),
+				      len, DMA_FROM_DEVICE, 0);
 	if (dma_mapping_error(device->dev, unmap->addr[1]))
 		goto err_get_unmap;
 
@@ -1851,8 +1851,8 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 		goto err;
 
 	unmap->len = len;
-	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(buf),
-				      buff_off, len, DMA_TO_DEVICE);
+	unmap->addr[0] = dma_map_phys(device->dev, virt_to_phys(buf),
+				      len, DMA_TO_DEVICE, 0);
 	if (dma_mapping_error(device->dev, unmap->addr[0]))
 		goto err_get_unmap;
 
-- 
2.43.7


