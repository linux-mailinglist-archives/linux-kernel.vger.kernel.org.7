Return-Path: <linux-kernel+bounces-736929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93CB0A544
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A64116A792
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC312CD8B;
	Fri, 18 Jul 2025 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qWUQg+/7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sO5eZRYW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42372AD2F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845786; cv=none; b=comzaQLtRplUi+YsvW6uqoHx88e7+fXgtqXrTLomjBvjoZd/djV5ILudMBgqNN5571/oTiS7WpJ3Q/gLCcPcl25S0KtP++erNiOULyNVlSeuGJmWDgObZoQbkLX/58YoXKJ2pBl9Mq10RRtrCXuJaHwyJurBKEz5w79c6OISF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845786; c=relaxed/simple;
	bh=TLq/AwUcraFsxjNprggosu7NFWvhdleAStRhfHB2kS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YThPmWoqXYrDN5Mv/nSWPoohkVbUHq7VWorvTIKfxiPkgNOetL+K8HkYIJg2Mpp6GmthBkJ7Q/U6XrTCFcdyHQiZ6z6f98Z0YVLXi3yyFRX9CNk33aPxKpcXSOdQDS5fV9W3NeqYDwBcKHW8EFnCEASL4HgCdeHeZfuyQL59k4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qWUQg+/7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sO5eZRYW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752845783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7SY2lWqub/O6H7NZGvs+8STrU9xYd+pzRWQN2Ni+ikQ=;
	b=qWUQg+/7pjvAb0/r9kiHUCHdxa1wdfmlwoUn4DDLVud3h74aDJLS+0EQau9K10ACFrJrLk
	HU1HKeBV/qjiH3x7Odh43I+UU4PoczNnC6gilVoykNDn4J3FGa7KqkzZ/f1FquukuexBXX
	c8aLR1BTErJ5FBj0M26G6BEGrge+j4qCHaHsKDHCQCanAQt21ziCxR6ImWDLdBxUxzQAyI
	pSxS0s55TW/scZbcw5W4UmYGkYu39gEnAyQ9GzclH5iU0YLeJltauhl4OXXHV0fn5y4ehb
	dd9o0kR4FTtn04Kyz6BNEVg0IVR2ABtTglXH7Gq2bSFMDyjSCEsNuw0eS0EELQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752845783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7SY2lWqub/O6H7NZGvs+8STrU9xYd+pzRWQN2Ni+ikQ=;
	b=sO5eZRYW/vOK0HKh3MiRTpO+7+7DVk7Dggw/8Jlu0//51KLetYJabG3gFN95IBrmglsQBc
	ivizUXrJhML2/oAw==
Date: Fri, 18 Jul 2025 15:36:13 +0200
Subject: [PATCH] LoongArch/orc: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-restricted-pointers-loongarch-v1-1-1462e779375f@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAMxNemgC/x3MQQqDMBAF0KvIrDtgpGLbq5QuwuSrAyWRmVAE8
 e4NLt/mHeQwhdOrO8jwU9eSG8KtI1ljXsCammnoh7GfwoMNXk2lIvFWNFeY87eUvESTlSExhud
 8T1MQasdmmHW//vfnPP8MJkXsbwAAAA==
X-Change-ID: 20250718-restricted-pointers-loongarch-ecaa19f4d71c
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752845782; l=1399;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TLq/AwUcraFsxjNprggosu7NFWvhdleAStRhfHB2kS0=;
 b=f1e2YlLN+djPqGy1FavJepKubeflFdryBPpPNHNGwIfVoCfXmgFDmqvwj38lDBy2IJNuKX/S9
 BxcMImtu7UADXxIcr+ftsPeRXbybNTT+IgiEfsR40Cg60++TaKGj9B2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index 0005be49b0569f28e0ee4a4f926f77562b14301b..0d5fa64a222522897df7f7c4bfbad8d2262a207e 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -508,7 +508,7 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	state->pc = bt_address(pc);
 	if (!state->pc) {
-		pr_err("cannot find unwind pc at %pK\n", (void *)pc);
+		pr_err("cannot find unwind pc at %p\n", (void *)pc);
 		goto err;
 	}
 

---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250718-restricted-pointers-loongarch-ecaa19f4d71c

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


