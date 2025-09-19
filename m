Return-Path: <linux-kernel+bounces-823959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D5B87D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22483AEAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1CE23182D;
	Fri, 19 Sep 2025 03:33:43 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D270809
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252823; cv=none; b=QjRQqFfXJyUIkeyMuuw9gpj4PBhQqV0bUGYhzCOsg7suCrlrnJ/Vnx68sj3OciRghWeQlz43zzxdFdzMpD+P8Mn8G/NYTRXsSpsxirQoaPrljZ06+Cc3t+y3dYGJTI5W3mFAIjsfya3pnCF+ZWvCga6aCi0tQPdxKg6xrgCpcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252823; c=relaxed/simple;
	bh=/UnOPcKFFbGPfThcVC8B9TUSk04qGoNtpPu9CnsDKpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aDvQwU4WBRLeLa6nEk919pbvfB3izKYkzKxibRXHMvVpKiDoF9bmYYIDE/7PpweZC69XF7iR8sKvTZPLIAGZUiGSV1TWxoABsekU9MnaYEUYiH4gY6v1O1GoEiTtnAl3YScDLf1hIH8tTbFIhfE25GBBmJle2QPfauLeqjoU07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6a81237e950911f0b29709d653e92f7d-20250919
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:dec5a508-240c-4c0a-ad30-88249f5b3bae,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:1dbd459edc4a7cb8f4dadc86968a2d0d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6a81237e950911f0b29709d653e92f7d-20250919
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 723830363; Fri, 19 Sep 2025 11:33:32 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0BF80E009009;
	Fri, 19 Sep 2025 11:33:32 +0800 (CST)
X-ns-mid: postfix-68CCCF0A-47649798
Received: from localhost.localdomain (unknown [10.42.20.41])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2371AE009008;
	Fri, 19 Sep 2025 11:33:29 +0800 (CST)
From: Li Qiang <liqiang01@kylinos.cn>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] arm64: add unlikely hint to MTE async fault check in el0_svc_common
Date: Fri, 19 Sep 2025 11:33:27 +0800
Message-Id: <20250919033327.1942730-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add unlikely() hint to the _TIF_MTE_ASYNC_FAULT flag check in
el0_svc_common() since asynchronous MTE faults are expected to be
rare occurrences during normal system call execution.

This optimization helps the compiler to improve instruction caching
and branch prediction for the common case where no asynchronous
MTE faults are pending, while maintaining correct behavior for
the exceptional case where such faults need to be handled prior
to system call execution.

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 arch/arm64/kernel/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c442fcec6b9e..7eb13f4c87da 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -96,7 +96,7 @@ static void el0_svc_common(struct pt_regs *regs, int sc=
no, int sc_nr,
 	 * (Similarly for HVC and SMC elsewhere.)
 	 */
=20
-	if (flags & _TIF_MTE_ASYNC_FAULT) {
+	if (unlikely(flags & _TIF_MTE_ASYNC_FAULT)) {
 		/*
 		 * Process the asynchronous tag check fault before the actual
 		 * syscall. do_notify_resume() will send a signal to userspace
--=20
2.25.1


