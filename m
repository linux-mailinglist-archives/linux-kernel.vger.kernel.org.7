Return-Path: <linux-kernel+bounces-764904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DF9B228A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E981BC0E97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9628136F;
	Tue, 12 Aug 2025 13:27:27 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E478283FE2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005247; cv=none; b=M65OLHH4afw9LGgbWvPxO6xiNWKoVDlPqqGmHuDMDf/FvNeBFHynXluLwT7LIHG1R4PO1foZtGF//88kyXzVt0zt+Rdv58VoHU/p4ee/T2DyVSHm3fonLF+1ULNfgvYLZW8sSO1txTbAZa/WCTQg60m48QIpu5SH/YqI0CkCKHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005247; c=relaxed/simple;
	bh=tngOegCMF2+ifcukaZaIpv4er4BJ1QQq8DzIk3OXdD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OM7hPnrU8wy7PExHLSzWPlLVLExXG9C/gL74XCAGZpxM3HlH+R5Bg5o20KhQTVs2Hc6v+hVATzp/bF2CNA0AKCDAJ4onUR/UlaaHuMr+lpZFaMXGfZOUM9bOtA/e66MMOKvwFRESbyvo1tTb9CPKiPuuW5AIHORSiT5bQIYGH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxfeE4QZtoHfg+AQ--.13775S3;
	Tue, 12 Aug 2025 21:27:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOQ0QZtoOLVGAA--.6029S2;
	Tue, 12 Aug 2025 21:27:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix objtool warnings if LTO is enabled for LoongArch
Date: Tue, 12 Aug 2025 21:27:14 +0800
Message-ID: <20250812132716.1465-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOQ0QZtoOLVGAA--.6029S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4xuw1ftw13KFy8Aw4rCrX_yoWfCFb_Jr
	1fG34kG3yUua1DtayIgF9Ygryqga18Xrn8JF1IqryfCw13AwsrGw4jqw15Zr1vkayUJrs8
	GrWkZFy8uw12yosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_
	Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

The patch #1 should be a preparation for patch #2, that is to say,
the patch #2 is dependent on the patch #1, otherwise there is build
error if LTO is enabled after only applying patch #2.

With this series, most of warnings have been silenced, only remains
the following warning by now, it needs more analysis:

  vmlinux.o: warning: objtool: __efistub_efi_boot_kernel() falls through
  to next function __efistub_exit_boot_func()

How to reproduce:

  $ make ARCH=loongarch LLVM=1 clean defconfig
  $ scripts/config -d LTO_NONE -e LTO_CLANG_THIN
  $ make ARCH=loongarch LLVM=1 olddefconfig all

Tiezhu Yang (2):
  objtool/LoongArch: Get table size correctly if LTO is enabled
  LoongArch: Pass annotate-tablejump option if LTO is enabled

 arch/loongarch/Makefile                |  6 ++++++
 tools/objtool/arch/loongarch/special.c | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.42.0


