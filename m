Return-Path: <linux-kernel+bounces-818764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CB9B59625
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56214E7313
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871631329A;
	Tue, 16 Sep 2025 12:25:27 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55A312824;
	Tue, 16 Sep 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025527; cv=none; b=IxKeFN75m471rBlFKKv4+tQ1fLIBLIq5m+0wp+IU+ViXm5cMLQkhF5BMkfUoKVilWmOY5ULBYk50PsW0S9j0XP9Vw72Ntpeec6NessBy++NoMA3ZYA6Hlbc/JBkLbNfuhxKGVzPC/wFrEhNSjEQPIL+nelEg2vbUGckdEVOytnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025527; c=relaxed/simple;
	bh=biYVcZsr6avenyL+S5XwG0aYxE0pUuqhJ7XB6H97Aa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gr7frsTmu2TdjNInoR4fmJwc611CTr9GSDb8bialUQG9R09WL+pHoEdMDIK+57cHP1spSHawINdvmR3/nJhB1Ikzdkxo4iG/Wpd4igKZ3rB9oYi5q0pb/mry0Q68LaViAaVh2Orce8jgrFse0FVRllO88+VF4fhyvrFjUSDRuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxF9EuV8lo_PEKAA--.23305S3;
	Tue, 16 Sep 2025 20:25:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxXMEsV8lo4VSZAA--.42297S4;
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
Subject: [PATCH v2 2/2] objtool/LoongArch: Mark types based on break immediate code
Date: Tue, 16 Sep 2025 20:25:15 +0800
Message-ID: <20250916122516.21013-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJCxXMEsV8lo4VSZAA--.42297S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1DXF45CFyUtr4rur45Arc_yoW8GrWfpr
	s8ur9Fgr4UWF1fAwn7J3yUXas8JrZ3WrWIgF1Sg34Ikr9aq3s8Xr1UKFnFkFs7K3yFga48
	XFnxZr17uF4YywcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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

If the break immediate code is 0, it should mark the type
as INSN_TRAP. If the break immediate code is 1, it should
mark the type as INSN_BUG.

While at it, format the code style and add the code comment
for nop.

Suggested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/decode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 707f339b1840..2e555c4060c5 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -331,10 +331,16 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	if (decode_insn_reg3_fomat(inst, insn))
 		return 0;
 
-	if (inst.word == 0)
+	if (inst.word == 0) {
+		/* andi $zero, $zero, 0x0 */
 		insn->type = INSN_NOP;
-	else if (inst.reg0i15_format.opcode == break_op) {
-		/* break */
+	} else if (inst.reg0i15_format.opcode == break_op &&
+		   inst.reg0i15_format.immediate == 0x0) {
+		/* break 0x0 */
+		insn->type = INSN_TRAP;
+	} else if (inst.reg0i15_format.opcode == break_op &&
+		   inst.reg0i15_format.immediate == 0x1) {
+		/* break 0x1 */
 		insn->type = INSN_BUG;
 	} else if (inst.reg2_format.opcode == ertn_op) {
 		/* ertn */
-- 
2.42.0


