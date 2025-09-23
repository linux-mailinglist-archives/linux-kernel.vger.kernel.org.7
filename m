Return-Path: <linux-kernel+bounces-828950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB0FB95EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAFF18A6822
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7071320CD6;
	Tue, 23 Sep 2025 13:01:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A6914A9B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632517; cv=none; b=BS+DgltQaqmC+8URFx/TYhj68WfqCw6xxH1fskTY3iXMdR5OVAF9K1eJcFV1re8LDdi4PzuwsFu9uETU2U2u90cxvk+9Ttjr+MQAghUAqdgjijBm5RmitdkvjJFUoXApzUCWgn+xIXjUgaBAPKzwKvNUix98o6gcdymYSXQZLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632517; c=relaxed/simple;
	bh=u2Zu3SbYsOko4xCdftQZw0rrh7SK+R8rMwwDRCnoEso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GA1QyJdqXLlWONjdKW2QethViMMPwrNC8XQAi8V+LfDaAZlSxXyb+nLrzqvJNh/Yez0gqjD9biFiCSspc1GgySKjZnBlTvgjeuWIbYi+6CHebvFh63lsnAieZ77azhVu2JRxqtnt7Zkn6ug4dk7LqqfBdLQs7u9pbZ/sVoaIlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8BxVNA6mtJo2akNAA--.29107S3;
	Tue, 23 Sep 2025 21:01:46 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJDxK8EtmtJoyiGoAA--.9124S2;
	Tue, 23 Sep 2025 21:01:45 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Nathan Chancellor <nathan@kernel.org>,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: Fix build error for LTO with LLVM-18
Date: Tue, 23 Sep 2025 21:01:22 +0800
Message-ID: <20250923130122.2321771-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxK8EtmtJoyiGoAA--.9124S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CryUGFW5KFyUKFyxWr4xZrc_yoW8Xr15p3
	9xCF90qrs5Gr4kK3s3JrWagrn5trsFya12gF1Sk3W8AFs5Xw4UXw18XF9rWFy8uws8JryI
	qryrK345JFZ5G3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOa93UUUUU=

Commit b15212824a01 ("LoongArch: Make LTO case independent in Makefile")
moves "KBUILD_LDFLAGS += -mllvm --loongarch-annotate-tablejump" out of
CONFIG_CC_HAS_ANNOTATE_TABLEJUMP, which breaks the build for LLVM-18, as
'--loongarch-annotate-tablejump' is unimplemented there:

ld.lld: error: -mllvm: ld.lld: Unknown command line argument '--loongarch-annotate-tablejump'.

Call ld-option to detect '--loongarch-annotate-tablejump' before use, so
as to fix the build error.

Fixes: b15212824a01 ("LoongArch: Make LTO case independent in Makefile")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ae419e32f22e..fcfa793f9bb0 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -115,7 +115,7 @@ ifdef CONFIG_LTO_CLANG
 # The annotate-tablejump option can not be passed to LLVM backend when LTO is enabled.
 # Ensure it is aware of linker with LTO, '--loongarch-annotate-tablejump' also needs to
 # be passed via '-mllvm' to ld.lld.
-KBUILD_LDFLAGS			+= -mllvm --loongarch-annotate-tablejump
+KBUILD_LDFLAGS			+= $(call ld-option,-mllvm --loongarch-annotate-tablejump)
 endif
 endif
 
-- 
2.47.3


