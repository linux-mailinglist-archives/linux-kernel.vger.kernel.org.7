Return-Path: <linux-kernel+bounces-795930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC3B3F99C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F164E11E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E4E2EAB80;
	Tue,  2 Sep 2025 09:04:03 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF32EA47C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803843; cv=none; b=ZbiUvJnNgHr3HazD4QB7RegxRr3o4G9V+EeEDzOsCsX24gyvwbsZqqKGe+ynZDLPtlnICQVoCkOvL0VjdWa5NoN0obIP/6FH2ja6OEtr2ySXed3MDbL2oo75XgNnreFru3SaNM5LXIDFnwEPfMc5YkxE0jfHVIQalDE6xvY+cY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803843; c=relaxed/simple;
	bh=5y2U/uD+Ei+lf/6FUUMzsoRu+GouXWZFl07iKRtVGPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X68DIZjn7aFmTNPJre4xn+x6NaiCL4vZpiNB8ScXhCkOojHHCWZuMqHSsi7OLtymmIte9BlsWuaohMdUY2gT+ZaTCLwzpQebyC0+t66i3uyDWgI+PMUZh7AwQs0S9gLKbEmDZeH2RhZGZpKovw59Hceq1rMLA3roFqExbpx4H+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bf37d25487db11f0b29709d653e92f7d-20250902
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9d4767fb-f45a-419d-a707-da34d1ea53d0,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:18
X-CID-INFO: VERSION:1.1.45,REQID:9d4767fb-f45a-419d-a707-da34d1ea53d0,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:18
X-CID-META: VersionHash:6493067,CLOUDID:cfcfa361926ed5ea4edc87512b1cd4d0,BulkI
	D:250902170354E04K2BJK,BulkQuantity:0,Recheck:0,SF:16|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: bf37d25487db11f0b29709d653e92f7d-20250902
X-User: cuitao@kylinos.cn
Received: from ctao-ubuntu.. [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1989404922; Tue, 02 Sep 2025 17:03:52 +0800
From: cuitao <cuitao@kylinos.cn>
To: chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	jiaxun.yang@flygoat.com,
	linmq006@gmail.com,
	ziyao@disroot.org,
	linux-kernel@vger.kernel.org,
	cuitao <cuitao@kylinos.cn>
Subject: [PATCH] LoongArch: replace sprintf() with sysfs_emit()
Date: Tue,  2 Sep 2025 17:02:58 +0800
Message-ID: <20250902090258.1170896-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Documentation/filesystems/sysfs.rst suggested, show() should only use
sysfs_emit() or sysfs_emit_at() when formatting the value to be returned
to user space.

No functional change intended.

Signed-off-by: cuitao <cuitao@kylinos.cn>
---
 arch/loongarch/kernel/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index c0a5dc9aeae2..19e30206b6e7 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -86,7 +86,7 @@ late_initcall(fdt_cpu_clk_init);
 static ssize_t boardinfo_show(struct kobject *kobj,
 			      struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf,
+	return sysfs_emit(buf,
 		"BIOS Information\n"
 		"Vendor\t\t\t: %s\n"
 		"Version\t\t\t: %s\n"
-- 
2.33.0


