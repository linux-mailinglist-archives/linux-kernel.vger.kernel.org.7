Return-Path: <linux-kernel+bounces-772656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C282B295AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061851756BD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 23:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27C7223DC0;
	Sun, 17 Aug 2025 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cXid9uT1"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB421FF5D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755473038; cv=none; b=kZND13L44Ks5YNCKzB+Hpfy4gZvfM/TNLr8Wc/7ScRCoGP9YXNB2VepuLFV1IEgsMziqQCX/MoMCYINhfcxyAe2bJu1UTtT3v58o8uyFr36Jc4iY3yGKzJ3dxLeHfCDVm14+IM97PJCq6MwQ5dsndefi0mJUTBZdCYPfp5Zb+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755473038; c=relaxed/simple;
	bh=+syUSoXzn8pOd0qDh0tgVdOLd8Wu+Lh0DW1WupAKD20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/fAshWjC/At9Qdo0c4deUYQq+XVKd30ft4MeGcxksac6leiVjecz71Cch8PqXqTaU42UY6836vxzgPXiZ/W3tJ3YkV9h9KvFg7DJwIbOm6fUgcTOw7LlLJ5ZoZL/sc0zmQFYMrW9B2vv/OIE9OegIvAJ4f0FHhhbxFy8ThaGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cXid9uT1; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755473034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wCMJPrdDQgHXKou2tP07iAww9tGuU+kjFqrxVf//los=;
	b=cXid9uT1mhOnVX47/C7ggGLW6s3aekxJunBt0vEOOeEYtdWe9R8cNpQ96JdvdoEuNZXrpP
	ubBM6f9le/z72+XlVSvMqES7PHdxQ7nexb5XX/vlH2GVQ3skFjArioRfREgVmKFvuywxCP
	AlstRDzVMfPIZH5zogkgOAO9En0Pjh0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sparc: PCI: Replace deprecated strcpy() with strscpy()
Date: Mon, 18 Aug 2025 01:23:36 +0200
Message-ID: <20250817232339.634641-1-thorsten.blum@linux.dev>
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
2.50.1


