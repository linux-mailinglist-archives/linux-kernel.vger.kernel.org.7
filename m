Return-Path: <linux-kernel+bounces-736935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB11B0A557
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA0116C1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4B313A3F2;
	Fri, 18 Jul 2025 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMluozId";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hdIzQ3dU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616962AD2F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846037; cv=none; b=IdSPmTZCcRtvG8guIhmB6PXQsyDrlS2qnC7GC+r6fX71AMw8/JzaYWpp83FjRu9R2oDlq5jAgO4a6XLeUX4eoQGvuxkRZq1OJhF3skF5aPl9g8zSD3NdX27zNLwe9qcd6ND2+AdCf2Zilwsrc7gkA2rlsyvhQ+4fyNpSfX5Q85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846037; c=relaxed/simple;
	bh=LjAcRieKgnMNYcLnZrs27PGMwV9sd+uOX82BwodEtro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q02bCun/hccsqUlxHVQWztY3q3C/7hQW9NkothzuWKsyy1m2+aSh3S3vFDvdxsKBQY7Ndp0+5RszeXy3IG+2bT8ysBL5ErkcD46HFdPGmsiC0CGtpWrybfAZ7Z/YHBzhQgqs5qQAJ419nH4nWXicalWtqjhleTjkvOCmJiaQTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMluozId; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hdIzQ3dU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752846034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mo94wdkZNDuu5QGZVvAPQQVCJz7QXGr0/48yptUJ974=;
	b=pMluozIdK72HGQH3aouNde4Sy8FLnoDw6EvYthFAqhtDJApHP5b1VV+saucTVGPZgSvLQ/
	QPLsAXqCHZGRX+d5JUkvEtWbrUs2AxC8mZJU3iDrNGT7OG8pCVxZUSzSSs7QVbO8p3oVXQ
	2oIhEA/kAH8FiYUPCksu+tHQfSOwad08orrYTL2N6uh62iwybs4gacV42V36szUcY7XChG
	KWMPtZJy5oaUJN0E/0eoEhusNgkjD+conIob31AwIl+wZtr9MhqVxhSiMbdcHUBGk/wjH/
	nL2iy8BUNh1Ya5Nd9zNKsPvwqx+QS12HxDP7fzZgzlWKwELqXGij6EcdJe2gaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752846034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mo94wdkZNDuu5QGZVvAPQQVCJz7QXGr0/48yptUJ974=;
	b=hdIzQ3dUq2/DyohiQtlXkFcSpDOfDUbpjTBI6U0HUYlN6mwq22xDvpd38/KwWEDeG3g+jX
	3vo3dZXc5+T2ShDg==
Date: Fri, 18 Jul 2025 15:40:32 +0200
Subject: [PATCH] soc: ti: pruss: don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-restricted-pointers-soc-v1-1-c0d0d0bc2e39@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAM9OemgC/x3MPQqAMAxA4atIZgMqFn+uIg6aRs3SSlJEEO9uc
 fyG9x4wVmGDsXhA+RKTGDLqsgA6lrAzis+Gpmpc1dU9KltSocQezyghsRpaJGyHoWt77xytBLk
 +lTe5//M0v+8HPaDLd2kAAAA=
X-Change-ID: 20250718-restricted-pointers-soc-499748d55cbc
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752846034; l=1493;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LjAcRieKgnMNYcLnZrs27PGMwV9sd+uOX82BwodEtro=;
 b=q94Q80T1q0imLgWgj4Y25ibsdl1Sv4feNSwafmljzXXGeaVEusmw2CTN8r+ycppoVa+Ucmoy0
 sBNWr6vfvfOBJ14oQ6CDECTADQr+MVkI4HMGBiJ9XboQffjJawv2ag+
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
 drivers/soc/ti/pruss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index d7634bf5413a3421da296103fc1591030cd00cbc..038576805bfa0f8dece569cf6faecedfb43a392f 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -449,7 +449,7 @@ static int pruss_of_setup_memories(struct device *dev, struct pruss *pruss)
 		pruss->mem_regions[i].pa = res.start;
 		pruss->mem_regions[i].size = resource_size(&res);
 
-		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %pK\n",
+		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %p\n",
 			mem_names[i], &pruss->mem_regions[i].pa,
 			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
 	}

---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250718-restricted-pointers-soc-499748d55cbc

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


