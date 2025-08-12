Return-Path: <linux-kernel+bounces-764905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC6CB228B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC71B580352
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BD2285411;
	Tue, 12 Aug 2025 13:27:33 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3D281376
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005253; cv=none; b=PILS+xJW55vsNJkdO3tk7TJChOjUjkiILMUig0NO2fAxa1mUbeqEWpi0YAuCjPGxUvYuHkXtTq1bnbW4CXz6dvyHr0h8PfjFez//r72ReCkwpwhdNCC/XR4G6vZQPfeAcfaKVsfSWn+oWJNklXTKCpHS3yukoiymmST2vqymkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005253; c=relaxed/simple;
	bh=YsfABY+geXyns0rel8JN53SfnmFhuUqAJoYdE0vpRKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpUkP8yH0I1oSMlckYuEHbNTPsF6kt1SfqcsqJLq2vhhccvICV/Gs2xaHNE+8v/zUBoo9QqFAA8BqMBUu1WLKX1LeX4o3928UH1FXLGxZr1lfK0bQtWSgqqX6tNkxJvPh6+F9yGKssqpWs1L3/0SNfZqI4SvJSTz5j/1ELlYyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Ax3eI6QZtoI_g+AQ--.15924S3;
	Tue, 12 Aug 2025 21:27:22 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOQ0QZtoOLVGAA--.6029S3;
	Tue, 12 Aug 2025 21:27:20 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] objtool/LoongArch: Get table size correctly if LTO is enabled
Date: Tue, 12 Aug 2025 21:27:15 +0800
Message-ID: <20250812132716.1465-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250812132716.1465-1-yangtiezhu@loongson.cn>
References: <20250812132716.1465-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOQ0QZtoOLVGAA--.6029S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF47XFyftw1UAryUGFWDKFX_yoW5Cw4rpF
	W5C3srtrW5Xry2gw1ayayjgFW3t397GF12grnxK348Aw4aq3Waqa17Z3sIvFyFgrZ5Ar4I
	qrs3KryUGF4qyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU

When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist
many objtool warnings "sibling call from callable instruction with
modified stack frame".

For this special case, the related object file shows that there is
no generated relocation section '.rela.discard.tablejump_annotate'
for the table jump instruction jirl, thus objtool can not know that
what is the actual destination address.

It needs to do something on the LLVM side to make sure that there is
the relocation section '.rela.discard.tablejump_annotate' if LTO is
enabled, but in order to maintain compatibility for the current LLVM
compiler, this can be done in the kernel Makefile for now. Ensure it
is aware of linker with LTO, '--loongarch-annotate-tablejump' needs
to be passed via '-mllvm' to ld.lld.

Before doing the above changes, it should handle the special case of
the relocation section '.rela.discard.tablejump_annotate' to get the
correct table size first, otherwise there are many objtool warnings
and errors if LTO is enabled.

There are many different rodata for each function if LTO is enabled,
it is necessary to enhance get_rodata_table_size_by_table_annotate().

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/loongarch/20250731175655.GA1455142@ax162/
Fixes: b95f852d3af2 ("objtool/LoongArch: Add support for switch table")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/special.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
index e39f86d97002..a80b75f7b061 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -27,6 +27,7 @@ static void get_rodata_table_size_by_table_annotate(struct objtool_file *file,
 	struct table_info *next_table;
 	unsigned long tmp_insn_offset;
 	unsigned long tmp_rodata_offset;
+	bool is_valid_list = false;
 
 	rsec = find_section_by_name(file->elf, ".rela.discard.tablejump_annotate");
 	if (!rsec)
@@ -35,6 +36,12 @@ static void get_rodata_table_size_by_table_annotate(struct objtool_file *file,
 	INIT_LIST_HEAD(&table_list);
 
 	for_each_reloc(rsec, reloc) {
+		if (reloc->sym->sec->rodata)
+			continue;
+
+		if (strcmp(insn->sec->name, reloc->sym->sec->name))
+			continue;
+
 		orig_table = malloc(sizeof(struct table_info));
 		if (!orig_table) {
 			WARN("malloc failed");
@@ -49,6 +56,22 @@ static void get_rodata_table_size_by_table_annotate(struct objtool_file *file,
 
 		if (reloc_idx(reloc) + 1 == sec_num_entries(rsec))
 			break;
+
+		if (strcmp(insn->sec->name, (reloc + 1)->sym->sec->name)) {
+			list_for_each_entry(orig_table, &table_list, jump_info) {
+				if (orig_table->insn_offset == insn->offset) {
+					is_valid_list = true;
+					break;
+				}
+			}
+
+			if (!is_valid_list) {
+				list_del_init(&table_list);
+				continue;
+			}
+
+			break;
+		}
 	}
 
 	list_for_each_entry(orig_table, &table_list, jump_info) {
-- 
2.42.0


