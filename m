Return-Path: <linux-kernel+bounces-807046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55523B49F43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8C57A78ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F14124EAB1;
	Tue,  9 Sep 2025 02:35:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59624242D7B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385313; cv=none; b=oz9ruCO0ZMSjmmUz1Orm4kJUwULdfuO0Ap6phj90H9hGvgAkYgEIkbcz21xBKA+67ljlDumJ64Is7xv3i+m/851HmP7jAPxcsByXV5K20rpgb2m7gfjg+N6F2a7flVWPLJSxTqDka1MCPVxe6R5yOSC3xjcqYEDtcgwU23+gU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385313; c=relaxed/simple;
	bh=ZaMQMsmJx43/kuknqIfVkdoxZe/Z1yIISMyY1iHBu44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ro3lZ6kC6GXnqayE+rO0JfiLZFzm8TeXWRpn40txLWPKxhOAsXTEFN9aP9FFpZHPF5LE7flbTDePvpeIHQja+SO4KOho4hQowDkIuknnm9EdegiSS7z7VCUDKyg0PPynUssqPFSxwXBmqQ1CXb92ZgVMg7jDtwlujManEogc0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 953d603c8d2511f0b29709d653e92f7d-20250909
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e6a52cfc-1a57-4781-a0e4-7e2a0dc05774,IP:15,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.1.45,REQID:e6a52cfc-1a57-4781-a0e4-7e2a0dc05774,IP:15,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-15
X-CID-META: VersionHash:6493067,CLOUDID:0c5d66e56d80284f326809b8760d8e74,BulkI
	D:250909103503QB182ID1,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 953d603c8d2511f0b29709d653e92f7d-20250909
X-User: cuitao@kylinos.cn
Received: from ctao-ubuntu.. [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1783533472; Tue, 09 Sep 2025 10:35:00 +0800
From: cuitao <cuitao@kylinos.cn>
To: chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	cuitao <cuitao@kylinos.cn>
Subject: [PATCH] LoongArch: Added detection of return values of some steps in the system init process
Date: Tue,  9 Sep 2025 10:34:48 +0800
Message-ID: <20250909023448.1820120-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value after early_memremap_ro and kobject_create_and_add,
and check whether the memory allocation was successful after kstrdup

Signed-off-by: cuitao <cuitao@kylinos.cn>
---
 arch/loongarch/kernel/env.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index c0a5dc9aeae2..eaa9e054209c 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -23,7 +23,13 @@ EXPORT_SYMBOL(loongson_sysconf);
 void __init init_environ(void)
 {
 	int efi_boot = fw_arg0;
-	char *cmdline = early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE);
+	char *cmdline;
+
+	cmdline = early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE);
+	if (!cmdline) {
+		pr_err("Failed to map command line memory\n");
+		return;
+	}
 
 	if (efi_boot)
 		set_bit(EFI_BOOT, &efi.flags);
@@ -46,10 +52,18 @@ static int __init init_cpu_fullname(void)
 
 	/* Parsing cpuname from DTS model property */
 	root = of_find_node_by_path("/");
+	if (!root) {
+		pr_warn("Failed to find root device node\n");
+		return -ENODEV;
+	}
 	ret = of_property_read_string(root, "model", &model);
 	if (ret == 0) {
 		cpuname = kstrdup(model, GFP_KERNEL);
-		loongson_sysconf.cpuname = strsep(&cpuname, " ");
+		if (cpuname) {
+			loongson_sysconf.cpuname = strsep(&cpuname, " ");
+		} else {
+			pr_warn("Failed to allocate memory for cpuname\n");
+		}
 	}
 	of_node_put(root);
 
@@ -67,14 +81,18 @@ static int __init fdt_cpu_clk_init(void)
 	struct device_node *np;
 
 	np = of_get_cpu_node(0, NULL);
-	if (!np)
+	if (!np) {
+		pr_warn("Failed to get CPU node\n");
 		return -ENODEV;
+	}
 
 	clk = of_clk_get(np, 0);
 	of_node_put(np);
 
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		pr_warn("Failed to get CPU clock\n");
 		return -ENODEV;
+	}
 
 	cpu_clock_freq = clk_get_rate(clk);
 	clk_put(clk);
@@ -109,6 +127,10 @@ static int __init boardinfo_init(void)
 	struct kobject *loongson_kobj;
 
 	loongson_kobj = kobject_create_and_add("loongson", firmware_kobj);
+	if (!loongson_kobj) {
+		pr_warn("loongson: Firmware registration failed.\n");
+		return -ENOMEM;
+	}
 
 	return sysfs_create_file(loongson_kobj, &boardinfo_attr.attr);
 }
-- 
2.33.0


