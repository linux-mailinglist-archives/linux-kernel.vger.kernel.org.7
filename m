Return-Path: <linux-kernel+bounces-786076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388B4B354B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726AA1B609DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B802D3A9E;
	Tue, 26 Aug 2025 06:40:12 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A42853E9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190412; cv=none; b=rYj+gCG6+3p5rvv1jz3qD4FuXPTSjj0/tCw7Sdxn+6asrXEIrOi9UlfqkGQtZdH6iidCdFz8W8+K1OQ8z1WnLrI2Qy2INIp4mG6DfP1sePU8g3HCxTbWr1Mcor0cbV/AgjzFYHHgQI8OB0Lv7F0592G/l9MHdJjf2MGMZtU05v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190412; c=relaxed/simple;
	bh=j5zAOK6fBSRN91+APJen8U5aoH29TE+tQ6Bm3G+v6Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuWYk6vyU62XfZg1SXPuoy7ktkAkeDXmgpjiWWMAn8dAnFTPpB5X/BxiZk0pe3zEYQpuA7Gbn/OSsbqUJbDM0fnuHPsyy9ZUxOsWgbtWFBMH4j+K6npPBj72xhWG5zfoQX8AuMBLeniDSDYYWcpHmPMlWaUiGEEtTmZTK6Tbs3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx6tHCVq1ozEADAA--.6220S3;
	Tue, 26 Aug 2025 14:40:02 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxTMHBVq1o8mdpAA--.11124S2;
	Tue, 26 Aug 2025 14:40:02 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Handle newly added llsc instructions for probes
Date: Tue, 26 Aug 2025 14:39:56 +0800
Message-ID: <20250826063956.6950-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxTMHBVq1o8mdpAA--.11124S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF13AF45JF1rWryxWw4fCrX_yoW8CFy7pF
	Zrurn5GrWUWrn3ArnrJan29r45AF1kKrW2qFnIk34xCr1aqF17twn7GF1DuFyDK398GF40
	gFW5Xryaqa15JacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UUUUU==

The atomic instructions sc.q, llacq.{w/d}, screl.{w/d} were newly added
in the LoongArch Reference Manual v1.10, it is necessary to handle them
in insns_not_supported() to avoid putting a breakpoint in the middle of
a ll/sc atomic sequence, otherwise it will loop forever for kprobes and
uprobes.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h |  5 +++++
 arch/loongarch/kernel/inst.c      | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 277d2140676b..55e64a12a124 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -77,6 +77,10 @@ enum reg2_op {
 	iocsrwrh_op     = 0x19205,
 	iocsrwrw_op     = 0x19206,
 	iocsrwrd_op     = 0x19207,
+	llacqw_op	= 0xe15e0,
+	screlw_op	= 0xe15e1,
+	llacqd_op	= 0xe15e2,
+	screld_op	= 0xe15e3,
 };
 
 enum reg2i5_op {
@@ -189,6 +193,7 @@ enum reg3_op {
 	fldxd_op	= 0x7068,
 	fstxs_op	= 0x7070,
 	fstxd_op	= 0x7078,
+	scq_op		= 0x70ae,
 	amswapw_op	= 0x70c0,
 	amswapd_op	= 0x70c1,
 	amaddw_op	= 0x70c2,
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 72ecfed29d55..4026edea9bdd 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -141,6 +141,18 @@ bool insns_not_supported(union loongarch_instruction insn)
 	case amswapw_op ... ammindbdu_op:
 		pr_notice("atomic memory access instructions are not supported\n");
 		return true;
+	case scq_op:
+		pr_notice("sc.q instruction is not supported\n");
+		return true;
+	}
+
+	switch (insn.reg2_format.opcode) {
+	case llacqw_op:
+	case llacqd_op:
+	case screlw_op:
+	case screld_op:
+		pr_notice("llacq and screl instructions are not supported\n");
+		return true;
 	}
 
 	switch (insn.reg2i14_format.opcode) {
-- 
2.42.0


