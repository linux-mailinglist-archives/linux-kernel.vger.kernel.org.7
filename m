Return-Path: <linux-kernel+bounces-807354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8569B4A358
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCD51BC3595
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B848256C76;
	Tue,  9 Sep 2025 07:20:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C10302CC0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402403; cv=none; b=pMFFbWHiW7thA8dYkuiFzBr9XvyUkFyq2XBBz6Gwb6kgjfYGewHGxfv2Ru8EPx48sC5Y/oYVW9LHarHd/A5NkVRLK9PzAdk4X9AUrMxzD/3DZihqiXXtebql9TQ/bNfhnKyjdgns3pDg6Wwci7M3slpi45tvuWRsgwgA89t5kMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402403; c=relaxed/simple;
	bh=S/5Rvz7e8FRVyPmtxt5eOlYi3u9O3wh6EDo/i6igZ8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THkohRivMYlI79uqoC74lr9jj2sPVOFZJFHthuZ5uL2wx1nyhJ8XdccOM0CIt+sMpQ5Js1QHUElS19sP0yAJ2EJfKfhg3uDIcjfjcBJM09nAtjUmwGFNNHw4SUyjXfD+5SBGG4Ul8KjqwrSzmtcp2AtXfgHIIVo13MD7kmggDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6295c25a8d4d11f0b29709d653e92f7d-20250909
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_COMM, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:407287ae-b91a-4e22-a617-5a1fc46c2fef,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:407287ae-b91a-4e22-a617-5a1fc46c2fef,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:6a574abd7be5b7c4ad38620fadfd79b1,BulkI
	D:250909151958BHQ3YCED,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 6295c25a8d4d11f0b29709d653e92f7d-20250909
X-User: cuitao@kylinos.cn
Received: from ctao-ubuntu.. [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1595949212; Tue, 09 Sep 2025 15:19:55 +0800
From: cuitao <cuitao@kylinos.cn>
To: chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	cuitao <cuitao@kylinos.cn>
Subject: [PATCH v2] LoongArch: Add a check for the return value when creating the kobj
Date: Tue,  9 Sep 2025 15:19:42 +0800
Message-ID: <20250909071942.1846204-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for the return value of kobject_create_and_add to ensure
that the kobj allocation succeeds.

Signed-off-by: cuitao <cuitao@kylinos.cn>
---
v2: Removed the unnecessary modifications.
https://lore.kernel.org/all/CAAhV-H7ECnVeOgf93SEXLHLc4wvhQMjQXDbGKCR-KXKWf8Vgtg@mail.gmail.com/
---
 arch/loongarch/kernel/env.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index c0a5dc9aeae2..f4ae894f4219 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -109,6 +109,10 @@ static int __init boardinfo_init(void)
 	struct kobject *loongson_kobj;
 
 	loongson_kobj = kobject_create_and_add("loongson", firmware_kobj);
+	if (!loongson_kobj) {
+		pr_warn("loongson: Firmware registration failed.\n");
+		return -ENOMEM;
+	}
 
 	return sysfs_create_file(loongson_kobj, &boardinfo_attr.attr);
 }
-- 
2.48.1


