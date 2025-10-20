Return-Path: <linux-kernel+bounces-860850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BEBF1248
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851911882EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95DF30F951;
	Mon, 20 Oct 2025 12:24:52 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C52F83DF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963092; cv=none; b=oWJwGUhL4qLSse55XgqNUaLoYt0D8j2mUjAott3LLqPL+auyWWqMu+j899UqkRIVn0eyYcJV7v6moo5/AWK/bmrDX7kwjaHpxHCS5LuP+yQ3ErdM7GDhLd8TOqHHaouejULypwyyAOHb6fJeFGLyFXG/OIDvTmk2YZhwA+7ZBH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963092; c=relaxed/simple;
	bh=gwEI5kPYPzDyaWOyf4D1GxZoYl8jeYQvChCpIt7F388=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pk2j5sMjKMR1sw2/vJKAmfvAJNfRoZ4Gd5W37B2N7fuRPLmEpSgI7A/UMfZamHW3FPKvog49lKxFBYnnNz6XThnzwv+zm2zEuZ0EvEixyN2Q2pVZ4QhrbSPJ4Ukhuxyy2HGraYRQmRAGsvOEuPQSbk64oDqziZ1Q7jKmw4XqhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-05 (Coremail) with SMTP id zQCowABX+RLoKfZo2ywDEg--.13259S4;
	Mon, 20 Oct 2025 20:24:08 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 20 Oct 2025 20:23:56 +0800
Subject: [PATCH 2/2] riscv: tests: Make RISCV_KPROBES_KUNIT tristate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-riscv-kunit-kconfig-fix-6-18-v1-2-d773b5d5ce48@iscas.ac.cn>
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
X-CM-TRANSID:zQCowABX+RLoKfZo2ywDEg--.13259S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw18CryxJFyrAFy5tF4UCFg_yoW8tw4fpF
	4DGwn09r4xG3WDG343A3s2g3yxG3WDGw43uF1UC348Gr47Ar45Awn2g3yDXrn2grWqqrZ3
	Cwn5urZ8KryDJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbH5lUUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

This disallows KUNIT=m and RISCV_KPROBES_KUNIT=y, which produces these
relocs_check.sh warnings when RELOCATABLE=y:

    WARNING: 3 bad relocations
    ffffffff81e24118 R_RISCV_64        kunit_unary_assert_format
    ffffffff81e24a60 R_RISCV_64        kunit_binary_assert_format
    ffffffff81e269d0 R_RISCV_JUMP_SLOT  __kunit_do_failed_assertion

This fixes allmodconfig build.

Reported-by: Inochi Amaoto <inochiama@gmail.com>
Fixes: f2fab612824f ("riscv: Add kprobes KUnit test")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/kernel/tests/Kconfig.debug          | 2 +-
 arch/riscv/kernel/tests/kprobes/Makefile       | 4 +++-
 arch/riscv/kernel/tests/kprobes/test-kprobes.c | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/tests/Kconfig.debug b/arch/riscv/kernel/tests/Kconfig.debug
index 5db4df44279e..40f8dafffa0a 100644
--- a/arch/riscv/kernel/tests/Kconfig.debug
+++ b/arch/riscv/kernel/tests/Kconfig.debug
@@ -31,7 +31,7 @@ config RISCV_MODULE_LINKING_KUNIT
          If unsure, say N.
 
 config RISCV_KPROBES_KUNIT
-       bool "KUnit test for riscv kprobes" if !KUNIT_ALL_TESTS
+       tristate "KUnit test for riscv kprobes" if !KUNIT_ALL_TESTS
        depends on KUNIT
        depends on KPROBES
        default KUNIT_ALL_TESTS
diff --git a/arch/riscv/kernel/tests/kprobes/Makefile b/arch/riscv/kernel/tests/kprobes/Makefile
index 4cb6c66a98e8..df7256f62313 100644
--- a/arch/riscv/kernel/tests/kprobes/Makefile
+++ b/arch/riscv/kernel/tests/kprobes/Makefile
@@ -1 +1,3 @@
-obj-y += test-kprobes.o test-kprobes-asm.o
+obj-$(CONFIG_RISCV_KPROBES_KUNIT) += kprobes_riscv_kunit.o
+
+kprobes_riscv_kunit-objs := test-kprobes.o test-kprobes-asm.o
diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.c b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
index 0716c88bcec7..664535ca0a98 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes.c
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
@@ -54,3 +54,6 @@ static struct kunit_suite kprobes_test_suite = {
 };
 
 kunit_test_suites(&kprobes_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test for riscv kprobes");

-- 
2.51.0


