Return-Path: <linux-kernel+bounces-820557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB14B7D0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F73517CF91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D634AAF8;
	Wed, 17 Sep 2025 11:27:28 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887442F83CD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108447; cv=none; b=qnXXfaHIZUBiHdUtCQqlG+/mnD0yjucU3ajMH+Ue8UY732Jr8lgNyya0SOf3bGAMrEN4ygACaBdyHIvQTsX5utDtVSc034Lj3ODEKqWRC3IzvStl88zzcuLCX9qA3pGPwsc/KczI1Hxd2uNbqrLk6BeXlosI2APdaTHMtHpjOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108447; c=relaxed/simple;
	bh=D8Oi/ITHNctMWAOJLI9GyQG9ArU1oDsuJ4DMd1sl/68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owjt4oULKqf6YbtAk1LR/TGHIUOi22cnJXVh4tTyxAEANOp+fZ6O0S0G0oCTMxNF2MNKmFjOos5e8WE2gALW8IkFy3BuEOyHzK0dk77dgsBbB6rZmk1TGiZafxTYURAX6Z5nOlGTRyDmQhQMWg3fuSrYtCt4z97f4aRa34oq+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx2tEXm8poD1kLAA--.24707S3;
	Wed, 17 Sep 2025 19:27:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxQ+QVm8por2abAA--.39884S2;
	Wed, 17 Sep 2025 19:27:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Fix objtool warnings if LTO is enabled for LoongArch (Part 2)
Date: Wed, 17 Sep 2025 19:27:13 +0800
Message-ID: <20250917112716.24415-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxQ+QVm8por2abAA--.39884S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4kKr15Kw4UAFW3Wr4kuFX_yoW8Ar1rpF
	43uay7Gr4rtF4kG3ykJw4S9Fy3AwsxGr1aq3WUK345A390vFsFqws2yrWIqF1DK3sagry0
	qF4rKa4UKFyDZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYSoJUUUUU=

The previous patches [1] [2] are to fix most of the warnings (total 3030):

  sibling call from callable instruction with modified stack frame

This series is a follow up to fix 2 kinds of warnings (total 24), it only
touches the objtool and LoongArch related code:

  falls through to next function
  unreachable instruction

With this series, there is only 1 kind of warning (total 3), it does not
only touch the objtool and LoongArch related code:

  missing __noreturn in .c/.h or NORETURN() in noreturns.h

In order to silence the above warnings, it needs to change the related
code to give the functions __noreturn attribute, and have a NORETURN()
annotation in tools/objtool/noreturns.h. IMO, it will touch all of the
archs and the generic code, so this needs much more work to avoid the
side effect or regression, once it is done I will send out the patch.

How to reproduce:

  $ make ARCH=loongarch LLVM=1 clean defconfig
  $ scripts/config -d LTO_NONE -e LTO_CLANG_THIN
  $ make ARCH=loongarch LLVM=1 olddefconfig all

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a47bc954cf0e [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5dfea6644d20 [2]

Tiezhu Yang (3):
  objtool/LoongArch: Fix fall through warning about efistub
  LoongArch: Fix unreachable instruction warnings about head.S
  LoongArch: Remove is_entry_func() related code

 arch/loongarch/kernel/Makefile     |  2 --
 arch/loongarch/kernel/head.S       |  7 +++----
 arch/loongarch/kernel/unwind_orc.c | 11 -----------
 tools/objtool/check.c              |  4 ++++
 4 files changed, 7 insertions(+), 17 deletions(-)

-- 
2.42.0


