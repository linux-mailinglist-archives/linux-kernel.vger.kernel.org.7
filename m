Return-Path: <linux-kernel+bounces-812020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84ADB531CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A652D586F94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44F3203B7;
	Thu, 11 Sep 2025 12:13:06 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD918C031
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592784; cv=none; b=h8Fy6088uG+G3Svrn5tfldo3dIHWT2cgiZwMTlEKjeGFjW54TB0h5es9dqJfHjcMbWnohEIaMVUvPjJdDtkp8ur1JRaqDcJ7YspQXlBAjkcK3bV4ERGWZFwnJb78CYmW9SDwXOvxyixhItgPVPNKn3YaRX8a+f5uqhYn6zUnXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592784; c=relaxed/simple;
	bh=4cxIUpfERdxVBQH+8YFM0cmNPO71wROCYNu2hLD/+mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu26s2pLLHBSkGQ/e5mOOenda4ioZgrEPc6mUcff+zbDpp1QeMSvLRrZBJ47CNGnfVGHmI9lcQzQQcR9NcnLM/1hERSkl2Bv+BtetAWlFi1Uhn+SiqQrs0Atgfo+KuzgRWEpFzyzhmlnULZlpYKfS+29jcwhUFLsE8UmkCkjfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [61.144.19.246])
	by APP-03 (Coremail) with SMTP id rQCowACXq4WlvMJouiJHAg--.45651S4;
	Thu, 11 Sep 2025 20:12:42 +0800 (CST)
From: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	zihong.plct@isrc.iscas.ac.cn,
	zihongyao@outlook.com,
	zhangyin2018@iscas.ac.cn,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v1 2/2] riscv: hwprobe: report Zicbop presence and block size
Date: Thu, 11 Sep 2025 20:12:09 +0800
Message-ID: <20250911121219.20243-3-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250911121219.20243-1-zihong.plct@isrc.iscas.ac.cn>
References: <20250911121219.20243-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXq4WlvMJouiJHAg--.45651S4
X-Coremail-Antispam: 1UD129KBjvdXoWruw4DWF18Ww1fJr48trykuFg_yoWkurX_uw
	nrWas8C348CFW09FWvkw4FywsIyw4kJa48Ar1ftr1UZ3WDZryUWas8Ca47Ww1DZ3WkWasx
	CFZ5WasFv3W7ZjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUblxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
	x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI
	1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxAqzxv2
	6xkF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRihSdDUUUU
	U==
X-CM-SenderInfo: p2lk00vjoszunw6l223fol2u1dvotugofq/

Plumb Zicbop into sys_hwprobe. Semantics mirror Zicbom/Zicboz
to keep userspace expectations aligned.

Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
---
 arch/riscv/kernel/sys_hwprobe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 0b170e18a2be..857d4e602e76 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -112,6 +112,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOM);
+		EXT_KEY(ZICBOP);
 		EXT_KEY(ZICBOZ);
 		EXT_KEY(ZICNTR);
 		EXT_KEY(ZICOND);
@@ -294,6 +295,11 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
 			pair->value = riscv_cbom_block_size;
 		break;
+	case RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE:
+		pair->value = 0;
+		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOP))
+			pair->value = riscv_cbop_block_size;
+		break;
 	case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
 		pair->value = user_max_virt_addr();
 		break;
-- 
2.47.2


