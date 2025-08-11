Return-Path: <linux-kernel+bounces-761981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA381B200B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CC4189D134
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332892D94A8;
	Mon, 11 Aug 2025 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNxaHmBV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sfL3U6A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376442D6629
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898516; cv=none; b=Ev84wl9BisEPagf/Who3XEdM/CrpiVLxYWco3uZn0uflSDqchJwp4kwPzqAUZy7Eo6eH0eTdQPFQMRniNucNekxfAaOwWtjHR5UzgIRznN/FwIwpcQ7Ve9yjy+3i5gjz1E5JV07lRt+dRpRhBpudBkL4xZD5O4xz2uoWMzJSXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898516; c=relaxed/simple;
	bh=M/jsQQIqEt8T29bnGJ7SJxDDqUjOBN3iPrs3SE5Ackk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kGyirqxZVcxgXMWI1IQ1/nHD+rM/cwBBWruOh0Nl9FwCMzgnmyu75JvXgksrks/D1BPh158TwPO7/TH2clf3IrcMLqEjysy5rjx33b1rnQ0Psy8ZBvVKa46646fC7on2sUixAuMi1YiCpB6tko42R6LCUF91l5ZdhjkFj7SQMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNxaHmBV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sfL3U6A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754898512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nbhzm2pjgxTnUGsWXEMLCLIOKDMpK0vdgym9Uw6mltg=;
	b=aNxaHmBVlpTu1AEdTMm8kk9NDfz8glu3DqSWp+tUObUBjOCJQy0ue8PMZzln1tZN1kuwGC
	HJeYP+sU3QzOlzom6g//AQDRYXuI3o0+f3fxqnBN9utO02xHRmAYkEo9BLhlcNH9SQvGm7
	RPrZ1Mo6pOA4LbKPPi2hAJEeNJeiU7EVoxNrsH08+pyXxNHqoX34y8VaJRO4qJdwaHZLF8
	dC0slX1GmQv+jyM+lelNriBrORUhYF/ioJ6hbe/CzT9A86KFvBXKlZsouciJuFWHCZNBM7
	7/1KU3DTy/m02xZ2HtQ2PREBGO/ex1NJrUCDiz3ivl8gpT6wVzXKJWi4qePDmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754898512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nbhzm2pjgxTnUGsWXEMLCLIOKDMpK0vdgym9Uw6mltg=;
	b=0sfL3U6A5MNQLkk6Gt+s2p0/B8O/M46naTFVSZzV1WjZ3+4cDg+KzXS9KyID+yFZlnnlzI
	cWXE5KGjHgeIWfAA==
Date: Mon, 11 Aug 2025 09:48:30 +0200
Subject: [PATCH v2] soc: ti: pruss: don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-restricted-pointers-soc-v2-1-7af7ed993546@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAE6gmWgC/4WNQQqDMBBFryKz7hSTKmpX3qO4qMm0DpREZlKxi
 Hdv6gXKX70P//0NlIRJ4VpsILSwcgwZ7KkAN93Dk5B9ZrClrcvGtCikSdgl8jhHDolEUaPDquu
 aqvV17UYHeT0LPXg9zLch88SaonyOo8X82v/OxaBBV/qc0Vm6dP2LwztJDLyePcGw7/sXyHCBj
 sIAAAA=
X-Change-ID: 20250718-restricted-pointers-soc-499748d55cbc
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754898512; l=1643;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=M/jsQQIqEt8T29bnGJ7SJxDDqUjOBN3iPrs3SE5Ackk=;
 b=TkC64m652S4rlsEbg0SAFfjxGBK3ajQdP3Qz0/2IggfbxCOzGajhqBeeEalOBskujn1JGYDX6
 rau53iiaFvUBaU9l3LHEm57zhRM/JuvRYwxHJd4ku/nokcWBggnjLAt
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
Changes in v2:
- Rebase on v6.17-rc1
- Link to v1: https://lore.kernel.org/r/20250718-restricted-pointers-soc-v1-1-c0d0d0bc2e39@linutronix.de
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
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250718-restricted-pointers-soc-499748d55cbc

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


