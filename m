Return-Path: <linux-kernel+bounces-776897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315EEB2D2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3A87AB309
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5811C5D57;
	Wed, 20 Aug 2025 03:45:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B23179A3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755661557; cv=none; b=Wx4/X+OCKXQq4+lm1zw3AzZudaSRPJiITew2e3+8JEe9q9USZVhcEK04ir7I0mdkJ1Lbzj7of+ZZbGIK0XKwStZvsn+ZaVExRoHqjKVPD4Jy+15WppISVuwxNi+o5dB01E8OZc35LSAatBEnLFEtZvWsvjYHgio72TqwLZfs6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755661557; c=relaxed/simple;
	bh=WTXWNo+8E1X+chuNWr88tcEsODferF2t7m6sSFkY1qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eFxcKyFosZTe2Z3oZ1eQe0ab8y89wmx0BZEpHvqXG1NGb12Vqu4vIPdS8Rj4IFA9hCTnc8HBSufa27S88pHpDoO8C1XNKjcjCvYzCfkGCbMvV4MCrL+XMoE62b6gTu3Ku8k2dpVOgj6Gw4KYWJrBKJJqC2v7ldPS5OFIt9xUz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8DxLvDsRKVoNLcAAA--.1435S3;
	Wed, 20 Aug 2025 11:45:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJAxQMLqRKVo5uVZAA--.7887S2;
	Wed, 20 Aug 2025 11:45:47 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	lixianglai@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yanteng Si <siyanteng@cqsoftware.com.cm>
Subject: [PATCH v2] LoongArch: KVM: Use kvm_get_vcpu_by_id() instead of kvm_get_vcpu()
Date: Wed, 20 Aug 2025 11:22:29 +0800
Message-Id: <20250820032229.913361-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxQMLqRKVo5uVZAA--.7887S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Since using kvm_get_vcpu() may fail to retrieve the vcpu context,
kvm_get_vcpu_by_id() should be used instead.

Fixes: 8e3054261bc3 ("LoongArch: KVM: Add IPI user mode read and write function")
Fixes: 3956a52bc05b ("LoongArch: KVM: Add EIOINTC read and write functions")
Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cm>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 arch/loongarch/kvm/intc/eiointc.c | 6 +++++-
 arch/loongarch/kvm/intc/ipi.c     | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index a3a12af9ecbf..b3829fb4f64e 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -45,7 +45,11 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 	}
 
 	cpu = s->sw_coremap[irq];
-	vcpu = kvm_get_vcpu(s->kvm, cpu);
+	vcpu = kvm_get_vcpu_by_id(s->kvm, cpu);
+	if (unlikely(vcpu == NULL)) {
+		kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
+		return;
+	}
 	if (level) {
 		/* if not enable return false */
 		if (!test_bit(irq, (unsigned long *)s->enable.reg_u32))
diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index e658d5b37c04..0348a83a7ed7 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -298,7 +298,7 @@ static int kvm_ipi_regs_access(struct kvm_device *dev,
 	cpu = (attr->attr >> 16) & 0x3ff;
 	addr = attr->attr & 0xff;
 
-	vcpu = kvm_get_vcpu(dev->kvm, cpu);
+	vcpu = kvm_get_vcpu_by_id(dev->kvm, cpu);
 	if (unlikely(vcpu == NULL)) {
 		kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
 		return -EINVAL;
-- 
2.39.3


