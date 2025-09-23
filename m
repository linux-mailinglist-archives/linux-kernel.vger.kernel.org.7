Return-Path: <linux-kernel+bounces-828395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F271BB9488A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B404F178708
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435330EF9E;
	Tue, 23 Sep 2025 06:17:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0E26B971
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608254; cv=none; b=BCEE7A1x75GcwE2/iI/rY09yv78J6NvtZu1iHJO0fmEULHX2eIeZZsNXjY7vb+DXGNXb8A3nU3/1Ucw0mQdtPu0jKX6SpYgKm9BrUpoMIs+b1u0c3XgWrbUT7+Hz+6gv5IbVxLix2S0WckeZ+q7QB3J1fMqaYkq2G7wWKO+CfXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608254; c=relaxed/simple;
	bh=Ot3cQ1dGKJvGM/EFa5jQVKEs2WGkwmPE9dWJxsfKB48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LOzVvgTcUqyuQB+4W7X02xx3EMejShE14BtCdJ/+InGh4DJuU+FVotob2I3Dm3EayvgEBYejDhFpHy+lnMid9cKxfQ0CcT000SXkUAmPlCYFrzeA91fZPT3AozNzb175QI5L0e0+FSgqqO3u7RJdlLfbWPfZSpAI2Xd8EXXFbr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxO9J0O9JoYokNAA--.29081S3;
	Tue, 23 Sep 2025 14:17:24 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxZORyO9Jox2GnAA--.6633S2;
	Tue, 23 Sep 2025 14:17:23 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] LoongArch: Add -fno-isolate-erroneous-paths-dereference in Makefile
Date: Tue, 23 Sep 2025 14:17:22 +0800
Message-ID: <20250923061722.24457-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxZORyO9Jox2GnAA--.6633S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF1rGw1DXF47Kry8AF45CFX_yoW8ZrWxpF
	WxuF1UZFWkXFn7Zas7JryrurnIyrnxGF4xuFW3CFy8ArWxZ3yjqayxtry3GFyxCwnY93yS
	v3WrGFnrXF1qy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUUUUU==

Currently, when compiling with GCC, there is no "break 0x7" instruction
for zero division due to using the option -mno-check-zero-division, but
the compiler still generates "break 0x0" instruction for zero division.

Here is a simple example:

  $ cat test.c
  int div(int a)
  {
	  return a / 0;
  }
  $ gcc -O2 -S test.c -o test.s

GCC generates "break 0" On LoongArch and "ud2" on x86, objtool decodes
"ud2" as INSN_BUG for x86, so decode "break 0" as INSN_BUG can fix the
objtool warnings for LoongArch, but this is not the intention.

When decoding "break 0" as INSN_TRAP in the previous commit, the aim is
to handle "break 0" as a trap. The generated "break 0" for zero division
by GCC is not proper, it should generate a break instruction with proper
bug type, so add the GCC option -fno-isolate-erroneous-paths-dereference
to avoid generating the unexpected "break 0" instruction for now.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202509200413.7uihAxJ5-lkp@intel.com/
Fixes: baad7830ee9a ("objtool/LoongArch: Mark types based on break immediate code")
Suggested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ae419e32f22e..f2a585b4a937 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -129,7 +129,7 @@ KBUILD_RUSTFLAGS_KERNEL		+= -Crelocation-model=pie
 LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext $(call ld-option, --apply-dynamic-relocs)
 endif
 
-cflags-y += $(call cc-option, -mno-check-zero-division)
+cflags-y += $(call cc-option, -mno-check-zero-division -fno-isolate-erroneous-paths-dereference)
 
 ifndef CONFIG_KASAN
 cflags-y += -fno-builtin-memcpy -fno-builtin-memmove -fno-builtin-memset
-- 
2.42.0


