Return-Path: <linux-kernel+bounces-827877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CF0B9353D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294422A8554
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C731354B;
	Mon, 22 Sep 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZdxwylqD"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649482F7AC2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575144; cv=none; b=mC9HmwSbfshrwbCgniWaIJPTeFta50oElDyWNeK/8z7YPjXY8h+dJvOfXZOKkIR57haB+1TT9eZavf+ij8xUtDE6sVKh9Ch3RswmfEhG4OV37h4QTpSHt5GiWJoUooCjQxFolVw0GytSCYfol6LPqYKZi4buQGzyHOhsvdAMJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575144; c=relaxed/simple;
	bh=WAl5OuqroQdkdQI4Wd3qHEcTe93M5exvNPWBFvPsfw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqvfJmuZ3tt6EcMHiPAarPx5hvdlzAUx+q/BH9FAVDz+RL7LPD3lfSxqc2IUJ7zmucMkOXmbW453hTtq5bh9driPbdZXIZC2qDQ8tnNVsuCDBGmDiKwW1pF+zAbheRC3gygr9Irpic33A8DJkkaU4y+7DauwDJBj33xXxyxVSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZdxwylqD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wz2Qh6CCUAyXy2y7KZplScVX0TJVeLEXcg6HqXMpxrE=;
	b=ZdxwylqDL5SfLBTOIJTaseeeDKrVEUiJsZ7gFQ4VmBzQEEYewVGzQ0ZNiyDCrYMO5jKYBf
	MmnqqQMPNM5G54o3nFWZDMFEFkm1eyGMDZ1pQPVyO2cZYNryl5RSsKBLWWEO/IoGWIUQLJ
	0n2DXm/aHRIbJVJcUUUBRhveODw32bQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] sparc: PCI: Replace deprecated strcpy with strscpy
Date: Mon, 22 Sep 2025 23:03:50 +0200
Message-ID: <20250922210408.1723452-1-thorsten.blum@linux.dev>
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
2.51.0


