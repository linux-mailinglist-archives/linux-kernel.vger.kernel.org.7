Return-Path: <linux-kernel+bounces-819816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D9B7ECDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343A44602BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65192205AB6;
	Wed, 17 Sep 2025 01:10:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3BB1E492D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071424; cv=none; b=dn723qZbo/3liUIORF01+9jIGp/K4xL5pwvoHX6pGFF+Ot20UPN+tP4T2+fFxB7yZ5yVf/q9XpJq/49DY6kjd7HIvZVHxFYfEU92P6zEltdXNXY6od43Gb98wN4UrfNaZptiNi0Gn+YSMbusQHyjS+Xb37XAq3O4hLDg+iWhtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071424; c=relaxed/simple;
	bh=QfrYnkE+7NUVkdHiavBpJx3gy03Ynprngwwcd3bbCLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUFOkpLn6gw5pgb62L4IsDlkDMm4woHqPXzP0IBlBLAYmwtFQNqplfVAzteAzSE3IFpLsJN3cbnShMiKlLVP0bJn8hRlIbXjLvqk6CXBDPTnWECKZzxPWwh6WNhCYSEQWMQ31hPjTlUOQHN/atoyuA/jix9itHJx05Xq0f63DZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx3797CspoHi4LAA--.22701S3;
	Wed, 17 Sep 2025 09:10:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxE+RwCsposWOaAA--.35728S3;
	Wed, 17 Sep 2025 09:10:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] objtool/LoongArch: Fix fall through warning about efi_boot_kernel()
Date: Wed, 17 Sep 2025 09:10:04 +0800
Message-ID: <20250917011007.4540-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250917011007.4540-1-yangtiezhu@loongson.cn>
References: <20250917011007.4540-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+RwCsposWOaAA--.35728S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AryrKr1fKry3XrW7tryktFc_yoW8Zr4rpF
	45CrWakrZ8WrWkG3W8Jw48Wr9xCrsxtrW7Gry8J3sIy3s0qrnFqw4akF10va9rXrnag3WI
	qay0gryakayqyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07j0HqcUUUUU=

When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
the following objtool warning:

  vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
  falls through to next function __efistub_exit_boot_func()

This is because efi_boot_kernel() doesn't end with a return instruction
or an unconditional jump, then objtool has determined that the function
can fall through into the next function.

At the beginning, try to do something to make efi_boot_kernel() ends with
an unconditional jump instruction, but this modification seems not proper
and makes LoongArch different to other architectures.

Furthermore, it is not proper to link efistub separately for LoongArch,
ARM64 and RISC-V too due to there is technical reason why vmlinux.o needs
efistub linked in.

For example, there are two ways of populating the core kernel's struct
screen_info via the stub, the latter is preferred because it makes the
EFIFB earlycon available very early, but it only works if the EFI stub
is part of the core kernel image itself. For more information, please
see the comments in drivers/firmware/efi/libstub/screen_info.c.

After more analysis, one simple way is to ignore these EFISTUB functions
in validate_branch() of objtool since they are useless for stack unwinder.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d14f20ef1db1..2dcebf75d95e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3567,6 +3567,10 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			    !strncmp(func->name, "__pfx_", 6))
 				return 0;
 
+			/* Ignore EFISTUB functions which are useless for stack unwinder */
+			if (!strncmp(func->name, "__efistub_", 10))
+				return 0;
+
 			if (file->ignore_unreachables)
 				return 0;
 
-- 
2.42.0


