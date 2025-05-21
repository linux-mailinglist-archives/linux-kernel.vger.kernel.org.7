Return-Path: <linux-kernel+bounces-657444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C02ABF42A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44BDF7AE631
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C807267B83;
	Wed, 21 May 2025 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xm/O/hNk"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA4269B03
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829850; cv=none; b=PPTxWjyl8Fzlxx2GrIBPjxtnwzXq/isik1s99jz9UoPaDcozHr1JJcjcAzVZQYVtU0ljm8ozMZKSRAxf5MAnWq3EwVORzqhRRVHSxTZpf5HwzlWVkX66LjhGy4eYRdSIyKSnl3XVm0zfpuPIWV5dlccCXWmpSJjzL7mmf1rePoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829850; c=relaxed/simple;
	bh=YkGL8DsA1sOR2uIr+Dhsuj8rwLU0qGRjJAr3IIhfRlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDktmH/i3enmSbpP9grbzhXJ6wUxtkn2kXXeJFoiW2sqY/e/59EUgQaBv4m5l5vf6thxAqS/EoRfgkqI0vXt5pPXbKNqpXW0xqHCcxeOHmoXZGwjTpEURlKVCBnSOhGOChg8fp0SCE/BhIw20uauepTqPYFNhTY+/qMyVizg6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xm/O/hNk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747829846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rZm4o3wTzUbKY53ioox6vPFM6N9QJNOwOvoP0fVMxig=;
	b=Xm/O/hNkJTqnwDAnuAhaYXhOBXqQjkKLzhIEXVR7lQ7t9LQ5SRiDvH4EvsT7AAYL59v4Bq
	1F3R3lwJEE1iVmpF7nquejLM+ncJqJcePtWOuoukKsgioHUD2eRw8kGM4Crx32q04BoYcT
	/KCCT1rfcrSJc/A1cKyhRc+rzZy7ZA8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sparc: PCI: Replace deprecated strcpy() with strscpy()
Date: Wed, 21 May 2025 14:17:13 +0200
Message-ID: <20250521121716.5446-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/kernel/pcic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 25fe0a061732..f894ae79e78a 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/jiffies.h>
 
 #include <asm/swift.h> /* for cache flushing. */
@@ -352,7 +353,7 @@ int __init pcic_probe(void)
 	pbm = &pcic->pbm;
 	pbm->prom_node = node;
 	prom_getstring(node, "name", namebuf, 63);  namebuf[63] = 0;
-	strcpy(pbm->prom_name, namebuf);
+	strscpy(pbm->prom_name, namebuf);
 
 	{
 		extern int pcic_nmi_trap_patch[4];
@@ -477,7 +478,7 @@ static void pcic_map_pci_device(struct linux_pcic *pcic,
 	int j;
 
 	if (node == 0 || node == -1) {
-		strcpy(namebuf, "???");
+		strscpy(namebuf, "???");
 	} else {
 		prom_getstring(node, "name", namebuf, 63); namebuf[63] = 0;
 	}
@@ -536,7 +537,7 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 	char namebuf[64];
 
 	if (node == 0 || node == -1) {
-		strcpy(namebuf, "???");
+		strscpy(namebuf, "???");
 	} else {
 		prom_getstring(node, "name", namebuf, sizeof(namebuf));
 	}
-- 
2.49.0


