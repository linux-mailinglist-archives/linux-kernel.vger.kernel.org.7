Return-Path: <linux-kernel+bounces-875632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36CC1972D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2D19C28E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A1832779D;
	Wed, 29 Oct 2025 09:45:16 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8382E2EF5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731116; cv=none; b=jV1hRqZ8UJuz4ggBPbw/kqwrfLmeBKA5tVozpLrQAjMk3hne9+oh4uqGQtserS1Gkc8Ieqh8GIXv6Lp7UW7XisNnj+zEq16PU0K91YynjU0zpiVJTQ0vB+QYIlHJjkQLAd46VZElzlmefGyJM71X6hBt6ci0KMx+t7/BGNdpOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731116; c=relaxed/simple;
	bh=K4DPcyQrShsgMEMEr8z7oPWbOvZBvxCO+IY0EPfepyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNIv1PNQ7VX/8kDsfO8HIEOwKx6onAHhcTBDTrJeMg6FQsWwGsEkKfE4SA/glPmeg0omszSywfyxnMB8LJzAxbw3Z5R1YJTHOhluPE/SxBtH2HqFyREPDfBgF8W69KfBSKC84BHpxu9Qb78RBnVN3k9GYE7HQyATO8m+jRvEZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f15ae94ab4ab11f0a38c85956e01ac42-20251029
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3577bd4a-f6d2-4c19-9d45-08f70f7bd76e,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:524e2fa477effd2a1cd57698ae20ca6d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f15ae94ab4ab11f0a38c85956e01ac42-20251029
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 89511226; Wed, 29 Oct 2025 17:45:03 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	emil.renner.berthing@canonical.com,
	nicolas.schier@linux.dev,
	masahiroy@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH 1/2] riscv: Build loader.bin exclusively for Canaan K210
Date: Wed, 29 Oct 2025 17:44:28 +0800
Message-Id: <20251029094429.553842-1-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the explanation in commit ef10bdf9c3e6 ("riscv:
Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210"),
loader.bin is a special feature of the Canaan K210 and
is not applicable to other SoCs.

Fixes: e79dfcbfb902 ("riscv: make image compression configurable")
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 arch/riscv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index ecf2fcce2d92..3998d4036f15 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -159,7 +159,7 @@ boot-image-$(CONFIG_KERNEL_LZO)		:= Image.lzo
 boot-image-$(CONFIG_KERNEL_ZSTD)	:= Image.zst
 boot-image-$(CONFIG_KERNEL_XZ)		:= Image.xz
 ifdef CONFIG_RISCV_M_MODE
-boot-image-$(CONFIG_ARCH_CANAAN)	:= loader.bin
+boot-image-$(CONFIG_SOC_CANAAN_K210)	:= loader.bin
 endif
 boot-image-$(CONFIG_EFI_ZBOOT)		:= vmlinuz.efi
 boot-image-$(CONFIG_XIP_KERNEL)		:= xipImage
-- 
2.25.1


