Return-Path: <linux-kernel+bounces-860851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E01BF12BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756E13B05C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B133311C3B;
	Mon, 20 Oct 2025 12:24:53 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF462FD7B2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963092; cv=none; b=mj/CjMIVbMV3C5rSYfVG9iIy5OkJCfQFhVGQ+h8IRQgY+sqpp/9XX/jNfQImxJ11ho/LCRaxPwfMww85PXlQlxbYNN9MTYxoLRzenMqFi9ZGQa58voKTQ0xD4x0HO8rxKfxp1ewpHnnAEaj3Ng6Gip+A82J3KJp/455MrmDKKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963092; c=relaxed/simple;
	bh=Qr7xE6U/A+NttNX0ZQWwv+Sri5jBhsjXcs0k9MrD0U0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQr5kvdLMj+PkW2NiL41c0fRKTC+k4vj5ZfSvIBSd9lh69RzDm5zc8lYH2hKV8HVgnuzS0oy8rwapUwuBUylJF8EJIsZZk1RoPL2U9o58CulYpdGsQwZ1zFcZonhUspVQc6WkQulWH4xyN7HZyzGENZ4CtkK/Orkv/m4msmBrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-05 (Coremail) with SMTP id zQCowABX+RLoKfZo2ywDEg--.13259S3;
	Mon, 20 Oct 2025 20:24:08 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 20 Oct 2025 20:23:55 +0800
Subject: [PATCH 1/2] riscv: tests: Rename kprobes_test_riscv to
 kprobes_riscv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-riscv-kunit-kconfig-fix-6-18-v1-1-d773b5d5ce48@iscas.ac.cn>
References: <20251020-riscv-kunit-kconfig-fix-6-18-v1-0-d773b5d5ce48@iscas.ac.cn>
In-Reply-To: <20251020-riscv-kunit-kconfig-fix-6-18-v1-0-d773b5d5ce48@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Inochi Amaoto <inochiama@gmail.com>, Yao Zi <ziyao@disroot.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowABX+RLoKfZo2ywDEg--.13259S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw1rGr15urykGr1xuryUWrg_yoWfGrb_C3
	WUtr93ur40yFyjqry5JanayFs3tw1xKFWrJrnxtry8Jw4UGF9Ika1vgr1Ut3yrWrZ0gFW7
	Kr47W34qva15ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbk8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
	x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E
	0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67
	AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48I
	cxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxw
	CY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73
	UjIFyTuYvjfU8T5lUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

According to Documentation/dev-tools/kunit/style.rst a KUnit test suite
normally should not have "test" in the name. Rename it to follow the
style guide.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/kernel/tests/kprobes/test-kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.c b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
index 6f6cdfbf5a95..0716c88bcec7 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes.c
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
@@ -49,7 +49,7 @@ static struct kunit_case kprobes_testcases[] = {
 };
 
 static struct kunit_suite kprobes_test_suite = {
-	.name = "kprobes_test_riscv",
+	.name = "kprobes_riscv",
 	.test_cases = kprobes_testcases,
 };
 

-- 
2.51.0


