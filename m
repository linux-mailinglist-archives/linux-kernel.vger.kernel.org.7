Return-Path: <linux-kernel+bounces-878188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E75C1FFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3E1F34E21B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386F2EBBB2;
	Thu, 30 Oct 2025 12:21:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326B3F9C5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826902; cv=none; b=jhOYC/X+IWjfDILgVK8L4mAFpJbZnDyI4OeNTW5uO6To9Fr13DW9J2sEnT0SwrHw3XODIGB9OQh9KuJF4tsrK7W/94J18GKnF2eust460W6BpQja8IBq/gXfKwCl8Qbx7wV3znwWMdEJZF/YrhutlcohA/SVCUEW+ce3eOnyUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826902; c=relaxed/simple;
	bh=V4xzQhAJ9xAGNxC/CzElAQ3qSL4KygnQMpAzX8Gfg7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kIUYbAPFPurbKsXPRtMtRXKMwr5EbHF9AGfryI6jlverEEcujKh1kKOzkJ8dsY2VG9DwpxHrUPFLEX0IqHMtWByPIvWhp2v4VFJffj5KkHJULtgcyIbP+TgBIHhu3EgMSlkwyVdijPVFmaINbPxp+/OT4we8KXMDyTxErP7NXY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f5869fcab58a11f0a38c85956e01ac42-20251030
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:55fd8289-df6b-4af7-8330-c5fa5204d938,IP:0,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:a9d874c,CLOUDID:15497eaa1c29a836e773eb15bd369132,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|15|50,EDM:5,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f5869fcab58a11f0a38c85956e01ac42-20251030
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1484032101; Thu, 30 Oct 2025 20:21:27 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH v3] arch/x86/microcode: Mark early_parse_cmdline() as __init
Date: Thu, 30 Oct 2025 20:19:48 +0800
Message-Id: <20251030121948.1395870-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix section mismatch warning reported by modpost:
  .text:early_parse_cmdline() -> .init.data:boot_command_line

The function early_parse_cmdline() is only called during init and
accesses init data, so mark it __init to match its usage.

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 arch/x86/kernel/cpu/microcode/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes in v3:
  - Fix Signed-off-by email address.

Changes in v2:
  - Resend to add correct email.
  - No code changes.
  
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index d7baec8ec0b4..ccc83b0bf63c 100644
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


