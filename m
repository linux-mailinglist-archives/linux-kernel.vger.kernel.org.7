Return-Path: <linux-kernel+bounces-835816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99965BA8239
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E31818940F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579682BD5A7;
	Mon, 29 Sep 2025 06:35:54 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1850256C87
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127754; cv=none; b=tkpBbEwmjTP0VwmbFStVWNtDfnk4l3VHiKbcpC5v8/5AUT1Dh5C0LIzkYtpY+tns+K/iUqLFM7W2Xd3Fq63mXrSOofBhBcTUBelTBpZ5AJazsUH1zuchdLMkO2a34KD7dIru2HGO2WRX+TC+OdP4ubqujAPXaQgrlGiPAHh/tvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127754; c=relaxed/simple;
	bh=amBmvfPdJq5nYuTEQxhZgfISPVwHTD8YQl26g4U1KuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upmTzmLeNUTdDldUCNG68K+4HocVQffbKzW4dm+ptaqikbjkeyDPUbTMQ8JxEdb6S3Rhau/frUmCMaNpOpPB51l3ycQ/da+cTyE5dzP06hzRewzSbvmH1KXUbsmJPn5JRU5ElGGcnNMuTs0UzT+MdxcPsSh9vdt16Gg0GOxL144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8BxVNDEKNpov_wPAA--.33373S3;
	Mon, 29 Sep 2025 14:35:48 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJCxrsPAKNpo3s+8AA--.60247S2;
	Mon, 29 Sep 2025 14:35:47 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Init acpi_gbl_use_global_lock to false
Date: Mon, 29 Sep 2025 14:35:34 +0800
Message-ID: <20250929063534.784235-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxrsPAKNpo3s+8AA--.60247S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF13Xr1xKF4fCryDCF48AFc_yoWDAFc_Gr
	y7Ja1kGr4xAa1Yv3WYqFWfJryFya1xZF4YkFn7WrW7KFy7J3W7Crs3Aa4fZr98KFWDCrZ0
	y397GFn8uw1IqosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

Init acpi_gbl_use_global_lock to false, in order to void error messages
during boot phase:

 ACPI Error: Could not enable GlobalLock event (20240827/evxfevnt-182)
 ACPI Error: No response from Global Lock hardware, disabling lock (20240827/evglock-59)

Fixes: 628c3bb40e9a8cefc0a6 ("LoongArch: Add boot and setup routines")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
Note: Depend on feb8ae81b2378b75 ("ACPICA: Allow to skip Global Lock initialization").

 arch/loongarch/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 075b79b2c1d3..69c17d162fff 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -355,6 +355,7 @@ void __init platform_init(void)
 
 #ifdef CONFIG_ACPI
 	acpi_table_upgrade();
+	acpi_gbl_use_global_lock = false;
 	acpi_gbl_use_default_register_widths = false;
 	acpi_boot_table_init();
 #endif
-- 
2.47.3


