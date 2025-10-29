Return-Path: <linux-kernel+bounces-875445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF05C1904F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6412B568B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FAE3195E2;
	Wed, 29 Oct 2025 08:17:00 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5EF317711
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725820; cv=none; b=hrRl2v8gaZ9MXnskpj6qt6gRC+kLV/cKdWzytVQ216FODj5t/3WjLb7u5WwhL0q1z7cMAs5B31kXrd++nzanGjk5Jbz0VWZENN5vMyQ9ZDXmaeHuxWqkadCLvlidvTFjCj8dXYu7IWxWVLNYMx4WHUGDjODC/avXBnyZDNPJNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725820; c=relaxed/simple;
	bh=ayJBTKLyF/5f9x7hDkFsZkRi3+Lk/+fs6pYChxHJ2wE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q/XZPHchDMaZHhEZi7o8Zc28kC5lLRr59uRvElk+/Bwcv4+O62meqOiSWa/sCiKTHoxW9CEmmZpN2lb2B5bT4K9WTuRRqHSJr8OOP98qS7VEkV3Vt/AQCgGUuYRalhJtB1EhQH0UuazNfViV9pk36T0/bbzv9OWfpHAYrB4GR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9cb75b78b49f11f0a38c85956e01ac42-20251029
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f9a4ad5c-19a6-43d0-a411-2418079ae15a,IP:0,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:a9d874c,CLOUDID:11d456b7dbb30dfe6ac41e9368e31934,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|15|50,EDM:5,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9cb75b78b49f11f0a38c85956e01ac42-20251029
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1658968133; Wed, 29 Oct 2025 16:16:47 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.com>
Subject: [PATCH v2] arch/x86/microcode: Mark early_parse_cmdline() as __init
Date: Wed, 29 Oct 2025 16:16:44 +0800
Message-Id: <20251029081644.4082219-1-pengyu@kylinos.cn>
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


