Return-Path: <linux-kernel+bounces-877942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9712C1F65C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC89400E46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9A34D915;
	Thu, 30 Oct 2025 09:55:44 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659334D90C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818143; cv=none; b=CTyTLFtn+vS5wCJPFTyW/2br/WYAFhePh099awTFQRBaO1+F2PsC5cHoiyOCSRP8PTbI0AXppA9ctMejOTZ/tZT4z1NT4VU5iJU9JqjvEbmX+pIb3+wr2BhtuJPlh7YQ6NGyqwa2RChhmjPVmkqZbc+GR8WOXRToYHh4brXOKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818143; c=relaxed/simple;
	bh=AQfcfh8iEiqJtMWre2aQbJP2fzq+kUGxUInFCafhXK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AejBtXlyIZlDs0ADcyb9btqxzopnrHRbZ7M2/wwM+SLhZ08E+CRZozc7arb6Ut/3uHCv6SZE+750BenE/2CC56oFVa7bhFof7ik1gNoTIdmFYpWyFOMs4Jn7mnOCSW6VHRe4LNfdGWax91+51EYITYyUiUAem4noeK74ZwQDZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAAXgGoWNgNp5QUaAA--.986S2;
	Thu, 30 Oct 2025 17:55:36 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>
Cc: linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] fsi: master-hub: Fix of_node leak in probe error path
Date: Thu, 30 Oct 2025 17:55:33 +0800
Message-ID: <20251030095534.770-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXgGoWNgNp5QUaAA--.986S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1UGr4DAw1kWrWUZrWkWFg_yoW8GF1kpa
	1fGFWSkr1rJw4kur1jva18XayF9a1SqrWrGF48K3Z3u395Jr9xtr1xJFyIvwnrJrWkCF1F
	qF1jq3ykuw1rCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUjFALDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0LA2kDDd6oWAAAsK

If the call to fsi_master_register() fails, the function exits
without releasing the of_node reference previously acquired via
of_node_get(). This results in an of_node reference count leak.

Add a call to of_node_put() under a new label to ensure the
reference is correctly released before the function returns.

Fixes: f6a2f8eb73f0 ("fsi: Match fsi slaves and engines to available dt nodes")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/fsi/fsi-master-hub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 6568fed7db3c..e259ed1c17e0 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -241,7 +241,7 @@ static int hub_master_probe(struct device *dev)
 
 	rc = fsi_master_register(&hub->master);
 	if (rc)
-		goto err_release;
+		goto err_free_node;
 
 	/* At this point, fsi_master_register performs the device_initialize(),
 	 * and holds the sole reference on master.dev. This means the device
@@ -253,6 +253,8 @@ static int hub_master_probe(struct device *dev)
 	get_device(&hub->master.dev);
 	return 0;
 
+err_free_node:
+	of_node_put(hub->master.dev.of_node);
 err_release:
 	fsi_slave_release_range(fsi_dev->slave, FSI_HUB_LINK_OFFSET,
 			FSI_HUB_LINK_SIZE * links);
-- 
2.50.1.windows.1


