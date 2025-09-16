Return-Path: <linux-kernel+bounces-818763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C8B59623
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FFF1BC7B90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68F313267;
	Tue, 16 Sep 2025 12:25:26 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632830FC15;
	Tue, 16 Sep 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025526; cv=none; b=K1swAcgmqDc2U2dZHucBAh2zyZ6yhRtg7lm723YfdCtnj/ZICcHFyrjPIFEDx5lWG0ug/jJg+amcZwcyVC6a5r3TBDW4ZRu9k+iC0ibRV6WKKb74U1RYNNgHX5LRPZEHBbCLF4gekcs+mFGBXO/TtTsECFy3xSbdStbqFyCvRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025526; c=relaxed/simple;
	bh=pncgwftl2MGsAF4N7q+zqQcHheOR4n68YnBtiTiOJqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utwxEzJCa7KAY40VKJ46z4tuHLcF4dBbtpfRXfxocp8pyHE4JO01owSaMV1IHv7EfaGlUCKYtO92fpQvP+wVElcVwVo82wRGwsv0/pQVgygsqsojRomMuS/w3uvsokDod+IAtUYMG6c3o9btxFYdcposfV4rtWwhfySUPR+Y/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxO9ItV8lo+PEKAA--.23470S3;
	Tue, 16 Sep 2025 20:25:17 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxXMEsV8lo4VSZAA--.42297S3;
	Tue, 16 Sep 2025 20:25:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: WANG Rui <wangrui@loongson.cn>,
	rust-for-linux@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] objtool/LoongArch: Mark special atomic instruction as INSN_BUG type
Date: Tue, 16 Sep 2025 20:25:14 +0800
Message-ID: <20250916122516.21013-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250916122516.21013-1-yangtiezhu@loongson.cn>
References: <20250916122516.21013-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxXMEsV8lo4VSZAA--.42297S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF47JF4kXFWrCw4DKr1UXFc_yoW5CFW8pa
	1DZ3s5Jr4rWrn3KwnrJ3y5urW3Krs3WrWIqFnxG3s2krWaqr95XF1kKr10yF1kJw4Fgr1I
	9rn3Zw17uF1jyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

When compiling with LLVM and CONFIG_RUST is set, there exists the
following objtool warning:

  rust/compiler_builtins.o: warning: objtool: __rust__unordsf2(): unexpected end of section .text.unlikely.

objdump shows that the end of section .text.unlikely is a atomic
instruction:

  amswap.w        $zero, $ra, $zero

According to the LoongArch Reference Manual, if the amswap.w atomic
memory access instruction has the same register number as rd and rj,
the execution will trigger an Instruction Non-defined Exception, so
mark the above instruction as INSN_BUG type to fix the warning.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/loongarch/include/asm/inst.h | 12 ++++++++++++
 tools/objtool/arch/loongarch/decode.c   | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/arch/loongarch/include/asm/inst.h b/tools/arch/loongarch/include/asm/inst.h
index c25b5853181d..d68fad63c8b7 100644
--- a/tools/arch/loongarch/include/asm/inst.h
+++ b/tools/arch/loongarch/include/asm/inst.h
@@ -51,6 +51,10 @@ enum reg2i16_op {
 	bgeu_op		= 0x1b,
 };
 
+enum reg3_op {
+	amswapw_op	= 0x70c0,
+};
+
 struct reg0i15_format {
 	unsigned int immediate : 15;
 	unsigned int opcode : 17;
@@ -96,6 +100,13 @@ struct reg2i16_format {
 	unsigned int opcode : 6;
 };
 
+struct reg3_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int rk : 5;
+	unsigned int opcode : 17;
+};
+
 union loongarch_instruction {
 	unsigned int word;
 	struct reg0i15_format	reg0i15_format;
@@ -105,6 +116,7 @@ union loongarch_instruction {
 	struct reg2i12_format	reg2i12_format;
 	struct reg2i14_format	reg2i14_format;
 	struct reg2i16_format	reg2i16_format;
+	struct reg3_format	reg3_format;
 };
 
 #define LOONGARCH_INSN_SIZE	sizeof(union loongarch_instruction)
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index b6fdc68053cc..707f339b1840 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -278,6 +278,25 @@ static bool decode_insn_reg2i16_fomat(union loongarch_instruction inst,
 	return true;
 }
 
+static bool decode_insn_reg3_fomat(union loongarch_instruction inst,
+				   struct instruction *insn)
+{
+	switch (inst.reg3_format.opcode) {
+	case amswapw_op:
+		if (inst.reg3_format.rd == LOONGARCH_GPR_ZERO &&
+		    inst.reg3_format.rk == LOONGARCH_GPR_RA &&
+		    inst.reg3_format.rj == LOONGARCH_GPR_ZERO) {
+			/* amswap.w $zero, $ra, $zero */
+			insn->type = INSN_BUG;
+		}
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    struct instruction *insn)
@@ -309,6 +328,8 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		return 0;
 	if (decode_insn_reg2i16_fomat(inst, insn))
 		return 0;
+	if (decode_insn_reg3_fomat(inst, insn))
+		return 0;
 
 	if (inst.word == 0)
 		insn->type = INSN_NOP;
-- 
2.42.0


