Return-Path: <linux-kernel+bounces-807492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C324BB4A51C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B081618850FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD11257ACF;
	Tue,  9 Sep 2025 08:19:59 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D35253355
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405999; cv=none; b=GhSTxih0HOGM32IxGX9voBMWkaJXBPVt5sEr964hon8MVUdNdA85kzLE7rvxBgP8ROcp3bdzMQ6nd1QCCB3V3o6F6txROYBMsg6gUUV05eobaJhysmf4aW0GjZwY/B/KBZiaVyy3mO0+Tquh99LSRqDI4XwQ9oakMQ2NbnlYk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405999; c=relaxed/simple;
	bh=mM/ZjWAVbUUkql8H1oFghgabuM9jKXe/SwcEiQbRuBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGcFpFJcsMnnMjGtHCCZ6TGK6HpmNGBMmbEz7eiVATU6zYvIHJxaIojm7iP2NAqKX1cmQufL53Oa3VnIVi0EnuwsA8+viy4WWat0o4OOG6wf6VnWhYAowbqAMKFqfXnDHs20c+WFZC/eyxkDlvFbWn2jvj4htsyLSOuJNAKgJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c039b8f08d5511f0b29709d653e92f7d-20250909
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b1e419d6-c164-4e88-81de-838cb3fc5ba1,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:b1e419d6-c164-4e88-81de-838cb3fc5ba1,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:5b9a6df3204e70fc12a8c2585deda649,BulkI
	D:2509091619500BZNL3X6,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: c039b8f08d5511f0b29709d653e92f7d-20250909
X-User: cuitao@kylinos.cn
Received: from ctao-ubuntu.. [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1619689536; Tue, 09 Sep 2025 16:19:48 +0800
From: cuitao <cuitao@kylinos.cn>
To: chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	cuitao <cuitao@kylinos.cn>
Subject: [PATCH v3] LoongArch: Add a check for the return value when creating the kobj
Date: Tue,  9 Sep 2025 16:19:40 +0800
Message-ID: <20250909081940.1851044-1-cuitao@kylinos.cn>
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
v3: Removed the unnecessary debug prints.
https://lore.kernel.org/all/CAAhV-H5CjH8i81dGNxaVrzdVUiTwqMUYeuBifQ0wSW_Mw9wSTw@mail.gmail.com/
---
 arch/loongarch/kernel/env.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index c0a5dc9aeae2..e9a7ea3bc5c8 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -109,6 +109,9 @@ static int __init boardinfo_init(void)
 	struct kobject *loongson_kobj;
 
 	loongson_kobj = kobject_create_and_add("loongson", firmware_kobj);
+	if (!loongson_kobj) {
+		return -ENOMEM;
+	}
 
 	return sysfs_create_file(loongson_kobj, &boardinfo_attr.attr);
 }
-- 
2.48.1


