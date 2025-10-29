Return-Path: <linux-kernel+bounces-875238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C6BC187BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054BC1C65FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58702307AC4;
	Wed, 29 Oct 2025 06:32:27 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFCA23D7EA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719546; cv=none; b=dfjnryJZI5EM57e5AE6cyTZV9lWjpYQrnvG55edYtyCmaHl2BRvnFI+hXN5zXe79x0e3JQQ2pnRxEX14Oi4Ezgy1V0TWjZaDrQs8/+s2oePsjV/fL30DPAFwegbenJzfdsYM/+oajvaAuqWlLWbXVfSOCJO3HGV3p+aOUK6QnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719546; c=relaxed/simple;
	bh=e2KPx6xdlOd1QY5kXKGuadYLtuuzcx1D4r/VGSCnT9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RutpgRreWvcfejPstkyJVo/ZSG+EBoa25iO5r57UZF3O8eRxB6yUUoaWmOEc98EneeLiFufqWonv29tBIFjuDAoVCPrFmf5fkICPzcfsvCZkKslZrMmUjYaOiyQhmcwwwEGW5TRaLPG1fA1Orn2C9MEG2Ys8N04qWClCi2gqMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 02325f70b49111f0a38c85956e01ac42-20251029
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:fd15174d-0d77-4a29-803a-befe6d6f8927,IP:0,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:2465552e03f5bd9d6f459d9287bdc0c9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|15|50,EDM:1,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 02325f70b49111f0a38c85956e01ac42-20251029
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 741109458; Wed, 29 Oct 2025 14:32:14 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
	"dave.hansen@linux.intel.comx86"@kernel.org
Cc: hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.com>
Subject: [PATCH] arch/x86/microcode: Mark early_parse_cmdline() as __init
Date: Wed, 29 Oct 2025 14:32:05 +0800
Message-Id: <20251029063205.3976555-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Peng <pengyu@kylinos.com>

Fix section mismatch warning reported by modpost:
  .text:early_parse_cmdline() -> .init.data:boot_command_line

The function early_parse_cmdline() is only called during init and
accesses init data, so mark it __init to match its usage.

Signed-off-by: Yu Peng <pengyu@kylinos.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index f75c140906d0..539edd6d6dc8 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -136,7 +136,7 @@ bool __init microcode_loader_disabled(void)
 	return dis_ucode_ldr;
 }
 
-static void early_parse_cmdline(void)
+static void __init early_parse_cmdline(void)
 {
 	char cmd_buf[64] = {};
 	char *s, *p = cmd_buf;
-- 
2.43.0


