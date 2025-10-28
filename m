Return-Path: <linux-kernel+bounces-874305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8DEC15FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B91C9355EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A4432AAB2;
	Tue, 28 Oct 2025 16:55:47 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F15220F49
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670546; cv=none; b=XNNqQesb6wH4xpXEa06yisZ6pVCyFr/JEzSxxPbLXh+TAhqn6baSa/64+D53MOtPsx4U1qHrcCOpyne+symTWnUkJjS9rGgSEkcK9c7vrdIujooQ+rGjmmQwbm39VpOw2p4VUfaUxGBEALF0XMXkW1/dDgsjmGRBblmTJC+FjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670546; c=relaxed/simple;
	bh=wLepN27H/rXjaFTfzdsDWDFJJCwoZQxsK2vgjctlbcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E41GMR0g6wHGh1vnWKizVbk33av88c006lGTM8mU/1tfEneJ3qBcMZI1CB9stZvoze4gGa6OH5B5+PP+Z5UGI6zYgbnMWFFDtaP94b0Jo0WKgyPpb3p3iadHFm8nGO6b2dPfNKF9fwp5TcOXbXD4OxDu7NseFrCZfwLgrvoF0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [114.245.38.183])
	by APP-01 (Coremail) with SMTP id qwCowACHZrmK9QBpBvyUBA--.8952S2;
	Wed, 29 Oct 2025 00:55:39 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] nvmem: core: fix GPIO descriptor resource leak
Date: Wed, 29 Oct 2025 00:55:26 +0800
Message-ID: <20251028165526.534-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHZrmK9QBpBvyUBA--.8952S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr13XF1UuFWUKF4fZr1rtFb_yoWktrc_Cw
	1jgr97XF4fAr1DKF1Y9r43Zw4Syan8trWYyF4IqF93J34jvrsrZ34qv3sIg342gr4xur9r
	JFyUArWIk347ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0JA2kArMPDGgAAse

The driver calls gpiod_get_optional() in nvmem_register() but never
calls gpiod_put() in nvmem_device_release() or in the register error
path. This leads to a GPIO descriptor resource leak.

Add gpiod_put() in nvmem_device_release() and in the register error
path to fix the resource leak.

Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 387c88c55259..597598db88f4 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1043,6 +1043,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_put_device:
+	gpiod_put(nvmem->wp_gpio);
 	put_device(&nvmem->dev);
 
 	return ERR_PTR(rval);
@@ -1062,6 +1063,7 @@ static void nvmem_device_release(struct kref *kref)
 
 	nvmem_device_remove_all_cells(nvmem);
 	nvmem_destroy_layout(nvmem);
+	gpiod_put(nvmem->wp_gpio);
 	device_unregister(&nvmem->dev);
 }
 
-- 
2.50.1.windows.1


