Return-Path: <linux-kernel+bounces-798215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686E7B41ABF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1797565526
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8DB2F361D;
	Wed,  3 Sep 2025 09:53:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D72F28ED;
	Wed,  3 Sep 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893214; cv=none; b=b1G6zrpWyJeSKNbqKIeR258Fs40QTXz1C5qx+iKqG3DUbXnab0Hkvws8djHBIOIvyU1X9EIlJFuU3FIsWfz1EbvM0Qn4sTVGdHJ45TQ3fBAhJ+knybK2w3VZDoVBwTWtsXnZazCOxxoIIgiUdfRifNSdcMVFGUbW4a1TSWrDLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893214; c=relaxed/simple;
	bh=XDP0wG8oJcBD8iSHmUgaU/ixC9iP7cOFsK+EMA7pI/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/qOgjVOXQ6TssWPtnXQLRsIOyy8UTQJzcfmEMDUUqk5OARL7Yssuy5VLWTGxzpCQ5MctW9A4kluSEy520wlMRk+pzIe2XEBoSU1Wig/JbN3p+7MpV8sYjXfWnMEWwBNEZJIDB6BEqnNWYfr5CsxHfWCIqV9KWPvWUe24Ok3oEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxbb8TELho7y0GAA--.11945S3;
	Wed, 03 Sep 2025 17:53:23 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxfcEMELhom_16AA--.5842S4;
	Wed, 03 Sep 2025 17:53:23 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>,
	rust-for-linux@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] LoongArch: Make LTO case independent in Makefile
Date: Wed,  3 Sep 2025 17:53:14 +0800
Message-ID: <20250903095315.15057-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250903095315.15057-1-yangtiezhu@loongson.cn>
References: <20250903095315.15057-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxfcEMELhom_16AA--.5842S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFyDXrW8ur45AF17Jw4fJFc_yoW8XryDpw
	sa9rZYqr4rWr4vgr9rJay5WrnxtFZrtr1xWFWxK3W8AF47Xw17Xr48tFyDXFyDJ3s3JrWI
	qrWfKr9xJF4UC3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUco7KUUUUU

LTO is not only used for Clang, it maybe used for Rust, make LTO case out
of CONFIG_CC_HAS_ANNOTATE_TABLEJUMP in Makefile.

This is preparation for later patch, no function changes.

Suggested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index a3a9759414f4..9d80af7f75c8 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -102,16 +102,16 @@ KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)
 
 ifdef CONFIG_OBJTOOL
 ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
+KBUILD_CFLAGS			+= -mannotate-tablejump
+else
+KBUILD_CFLAGS			+= -fno-jump-tables # keep compatibility with older compilers
+endif
+ifdef CONFIG_LTO_CLANG
 # The annotate-tablejump option can not be passed to LLVM backend when LTO is enabled.
 # Ensure it is aware of linker with LTO, '--loongarch-annotate-tablejump' also needs to
 # be passed via '-mllvm' to ld.lld.
-KBUILD_CFLAGS			+= -mannotate-tablejump
-ifdef CONFIG_LTO_CLANG
 KBUILD_LDFLAGS			+= -mllvm --loongarch-annotate-tablejump
 endif
-else
-KBUILD_CFLAGS			+= -fno-jump-tables # keep compatibility with older compilers
-endif
 endif
 
 KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat -Ccode-model=small
-- 
2.42.0


