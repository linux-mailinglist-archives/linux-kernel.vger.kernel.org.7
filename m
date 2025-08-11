Return-Path: <linux-kernel+bounces-761754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B28B1FE0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C5B3B7D39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AA3239E8B;
	Mon, 11 Aug 2025 03:19:01 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AC712B93
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754882341; cv=none; b=i+4/RCcDYZtwHh4MNaBC2bTy2pdqfk+6VYzGMIj6RVctA0z2lHhqAf1LvNabF8eMA1kwzpw9VWqW/ugcuP1WrllJFCVvKxHXhTWmEtDLLUMQyUls/Y3Smye1e4jhwSEC9uoiwYflYFRlBME3TBmmo3zsKIMvSURuiMAc3mcYjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754882341; c=relaxed/simple;
	bh=dXP9lLZtsM7Eml06bZKAtBCOHfRmonm1yc9CSB0UGyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IbuGPKqKDl0v+p9PmxdXpHmirjOgfd4CZlUUTcyTbgXq2ZeUTwc78TU0vVcOXyx415XpoSe5ICrUmhxZYsz4GO2HIOY8S/CEIe3Ohm+ROw5U2WRmZAeSlFEfW5PBefJAPgogf5NHv2iU56ka15rUuWJNcEYPz0onkJ3V8Yy4574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8CxPuMeYZlo9iQ+AQ--.17199S3;
	Mon, 11 Aug 2025 11:18:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJCxH8IdYZloy9FBAA--.60913S2;
	Mon, 11 Aug 2025 11:18:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	lixianglai@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Use kvm_get_vcpu_by_id() instead of  kvm_get_vcpu()
Date: Mon, 11 Aug 2025 10:55:44 +0800
Message-Id: <20250811025544.458422-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxH8IdYZloy9FBAA--.60913S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Use kvm_get_vcpu() may can't get vcpu context, use kvm_get_vcpu_by_id()
instead of kvm_get_vcpu().

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 arch/loongarch/kvm/intc/eiointc.c | 5 ++++-
 arch/loongarch/kvm/intc/ipi.c     | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index a3a12af9ecbf..5180da91d2e6 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -45,7 +45,10 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 	}
 
 	cpu = s->sw_coremap[irq];
-	vcpu = kvm_get_vcpu(s->kvm, cpu);
+	vcpu = kvm_get_vcpu_by_id(s->kvm, cpu);
+	if (unlikely(vcpu == NULL)) {
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


