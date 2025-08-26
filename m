Return-Path: <linux-kernel+bounces-786079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF71B354BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48651205CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500762F60C1;
	Tue, 26 Aug 2025 06:46:49 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0642641CA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190808; cv=none; b=XdM1tuHhfomr6+XwYJCYa8sLa2UD1qBhJr+RGca77Xd7YMO++NYTw1szvvux3LFKMxajXtbiQeFUfGliZf4OE3Y8ZQ9JtWjU/35VIN3GIuPKpPGt/iF2NwRMSYA9ivQbgq8uc4qlkHfsxfpiVdrVRJohVuoWxDByTsmKqtQ8Oek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190808; c=relaxed/simple;
	bh=w0qS4kCOp7ylBVCxLD0AVRIRenhm1PIkxviGeN4Ri/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ardZsJs+RU3vzE5quWd/KuWTuFL6xUHB5up2FabU8Z9Rl4O129IE8sRihC1aFrs7DTwBMxAO3LJiWYv22z4OthnfCsfg6vDIzFGiMkZ8PWzyYiv0EzuXa9CUoXO/P1iqEfr2u+s79RSFES3NEA0KzPrJ7DsEpQ5r2a13KlAO0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxxtBRWK1oJEEDAA--.6033S3;
	Tue, 26 Aug 2025 14:46:41 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxTMFKWK1o6GppAA--.11160S3;
	Tue, 26 Aug 2025 14:46:40 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] objtool/LoongArch: Fix fall through warning about efi_boot_kernel()
Date: Tue, 26 Aug 2025 14:46:30 +0800
Message-ID: <20250826064631.9617-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250826064631.9617-1-yangtiezhu@loongson.cn>
References: <20250826064631.9617-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxTMFKWK1o6GppAA--.11160S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4rCF15tF13ury3Ar4rtFc_yoW5Cry7p3
	WUCrWUWr4Fyrs7Aa48Jw4Y9ry3Zws7trWagasrXryrZanIqFsIvr4qvrnFvF4kAFWDKw4Y
	qFy8tr9Iya1DArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
the following objtool warning:

  vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
  falls through to next function __efistub_exit_boot_func()

This is because efi_boot_kernel() doesn't end with a return instruction
or an unconditional jump, then objtool has determined that the function
can fall through into the next function.

Actually, efi_boot_kernel()'s last instruction is "jirl $ra, $a3, 0", it
is a call to a noreturn function pointer real_kernel_entry() which points
to the symbol kernel_entry() in arch/loongarch/kernel/head.S.

drivers/firmware/efi/libstub/loongarch.c:

typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
					  unsigned long systab);

efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
			     unsigned long kernel_addr, char *cmdline_ptr)
{
	kernel_entry_t real_kernel_entry;
	...
	real_kernel_entry = (void *)kernel_entry_address(kernel_addr, image);

	real_kernel_entry(true, (unsigned long)cmdline_ptr,
			  (unsigned long)efi_system_table);
}

According to the description of tools/objtool/Documentation/objtool.txt,
in order to silence this warning, at the beginning just add the noreturn
real_kernel_entry() to objtool's hard-coded global_noreturns array, but
there is no effect, because it is not a valid symbol.

There exists an alternative way to silence this warning, the first thing
is to remove the attribute __noreturn for real_kernel_entry(), otherwise
the compiler can not generate instructions after that, and then just add
"while (1);" at the end of efi_boot_kernel(), so that efi_boot_kernel()
ends with an unconditional jump instruction "b".

Note that at the end of efi_boot_kernel(), using unreachable() has no
effect because it can still generate fall-through code, using BUG() is
not proper because it will generate the following ld.lld warning:

  vmlinux.o:(.init__bug_table) is being placed in '.init__bug_table'

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/firmware/efi/libstub/loongarch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 3782d0a187d1..e309fd78fca7 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -10,7 +10,7 @@
 #include "efistub.h"
 #include "loongarch-stub.h"
 
-typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
+typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
 					  unsigned long systab);
 
 efi_status_t check_platform_features(void)
@@ -81,4 +81,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 
 	real_kernel_entry(true, (unsigned long)cmdline_ptr,
 			  (unsigned long)efi_system_table);
+
+	/* We should never get here */
+	while (1);
 }
-- 
2.42.0


