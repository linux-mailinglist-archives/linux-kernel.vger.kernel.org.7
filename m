Return-Path: <linux-kernel+bounces-878222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E834C200D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EC43B4099
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A43631D375;
	Thu, 30 Oct 2025 12:38:07 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A631BC96
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827886; cv=none; b=o/eqixtQLxvRTmTsBfIrxozu+c16ToLDp+bvDddoNv304VvyhTeKIEWlpvBuqTn8jcYJIbq45Ihtknm2qNKbYjsIRTgjpcD9L2uWJWfyImerYkO6Le1v/TnBU+CvCifMhWD9lfKxxuTCzYf6iImolpN9qDeFQvGLLN+1sXpKrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827886; c=relaxed/simple;
	bh=wkC1PUt+I4W2r+dg4QBQFr+2AyRtCZt70S43hTUbEZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QIRsTVGkxZM/Rb60dKXUtEFgJfeaF3xjqtft8Hza8QRgs66AVDjhOAgw/+SCU2ULqoJ8cF8bPnrFtRDCZDLWj/Lw3mN1ZgXmxK1ogyWeOW1hGADLD9qiVpbzmXofe4ZhjMlyxohQRCq1RMAI1RjL/aBYXY0yC/jfJ9/BXFVuDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 44eb6260b58d11f0a38c85956e01ac42-20251030
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:0b462e32-9ca4-491f-9d6c-602029dc235c,IP:0,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:a9d874c,CLOUDID:f6a1a6658ce3373ee6fb7feb40b98371,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|15|50,EDM
	:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 44eb6260b58d11f0a38c85956e01ac42-20251030
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 791922154; Thu, 30 Oct 2025 20:37:59 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH v4] arch/x86/microcode: Mark early_parse_cmdline() as __init
Date: Thu, 30 Oct 2025 20:37:57 +0800
Message-Id: <20251030123757.1410904-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251029081644.4082219-1-pengyu@kylinos.cn>
References: <20251029081644.4082219-1-pengyu@kylinos.cn>
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

Changes in v4:
  - Resend to fix broken mail thread (v3 was not sent as a reply).

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


