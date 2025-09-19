Return-Path: <linux-kernel+bounces-824348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C4B88BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E963A2044
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C912F3C32;
	Fri, 19 Sep 2025 10:01:06 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43F381BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276065; cv=none; b=VBv2q1TfPKH1FfUXz5XCf1xaogtrTo1TBOGwvS4sPw1S+4d5v2YoI+BvTS2IugEGNEO3zyUMh7hmoREa5nbiIfMxW324nF3jjvgZvFLomDWtbM7qgriHjEy3r6WFecyZxGuTduk9tmzCMD0AN9Qg5IFQwS/JxwZhYd4D67nQPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276065; c=relaxed/simple;
	bh=QkHHeHVLuim+WHgjkfbHSWdkdWS3r6zLrWg8QMRsR08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p44V38mpMpYh4aoAMTzyp/KGOK1KCbjdcUlRF2FLOBgBeIHI3++u86fQObHC0XAumtSlf87MklgwZGCFMtPk0+w3CoV80/aq8ZbHlMXvKd2wn5s/eNxsTTzOTEsm9lljgcciwxMEk1ov763Dp88kv/N+CsD89nuA2WshYd5VQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 85917df4953f11f0b29709d653e92f7d-20250919
X-CID-CACHE: Type:Local,Time:202509191758+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7680da81-f567-4274-9f9e-e0aa43f6b56c,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:cb849cfafc49cff983d0e003fa13afb6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 85917df4953f11f0b29709d653e92f7d-20250919
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 325077837; Fri, 19 Sep 2025 18:00:50 +0800
From: Can Peng <pengcan@kylinos.cn>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH 1/1] arm/syscalls: mark syscall invocation as likely in invoke_syscall
Date: Fri, 19 Sep 2025 18:00:42 +0800
Message-Id: <20250919100042.497861-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The invoke_syscall() function is overwhelmingly called for
valid system call entries. Annotate the main path with likely()
to help the compiler generate better branch prediction hints,
reducing CPU pipeline stalls due to mispredictions.

This is a micro-optimization targeting syscall-heavy workloads.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 arch/arm64/kernel/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c442fcec6b9e..aba7ca6bca2d 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -43,7 +43,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 
 	add_random_kstack_offset();
 
-	if (scno < sc_nr) {
+	if (likely(scno < sc_nr)) {
 		syscall_fn_t syscall_fn;
 		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
 		ret = __invoke_syscall(regs, syscall_fn);
-- 
2.25.1


