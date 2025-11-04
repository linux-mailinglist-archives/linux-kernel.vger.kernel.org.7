Return-Path: <linux-kernel+bounces-884188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C25C2F90A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BB93B07DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12C3019B3;
	Tue,  4 Nov 2025 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="axxMKNQu"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F253C18024
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240387; cv=none; b=mIq/xFsUwPA6XZbhG224L+RCzbM106IC704O9+CvYxMIhio0P50bhIx7m68RcUHcxyhu3yGQS/H1bqfqG/Gr6IV4TKfbi9aB4EZY0wtFaP2Rs+Z26ryE3tK6nUWo0njDzc3GfFpitsJzYFYeM+v8J1TPPacbyazFJH1skddGRMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240387; c=relaxed/simple;
	bh=qR5b0ue/3SmLOf/UnStZiKIEyhmj9HtyQ2fwNFRA32s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rlh4E7wSMEdJPFTl6Hqmi9PGgRJhr72pArN5iogQRBIQzIWAo8S0VYwwq82FUj3UEoCTQS+wbYT4UusUN8RMuV73agGuu76QqdyQ99DBUqtAdymPbnhmqC7LyYK4KJFclFpBOYJ0v1Q6Fnae+VYpZp0chW57t6uUNvozCtdKyvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=axxMKNQu; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: afb9dcb6b94d11f0b33aeb1e7f16c2b6-20251104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CARmva9EM2/RMKOsxbDAEvge892qd5JXDQ4LT1FhjCs=;
	b=axxMKNQu3l7Ce6g/0ZArfQRghUWnKn2fZ0VLtlseDczxqkxKTIOPcUSqHnUpgh1NjtmG1zoSZCLnRUwNRqyFWMjgzqFUUaIipawJ6VhW7HNnDtvsze9YICgc7BfuuyBcLCv6QYRBYGQPxozVew7yplFBcJ6G56ZG0RAR6Tc5AUU=;
X-CID-CACHE: Type:Local,Time:202511041421+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ad6ff8db-23d5-4c6b-9553-d5ae7023f224,IP:0,UR
	L:0,TC:0,Content:35,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:a9d874c,CLOUDID:2d211be0-3890-4bb9-a90e-2a6a4ecf6c66,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|110|836|888|898,TC:0,Content:-7|
	-6|4|14|50,EDM:-3,IP:nil,URL:0,File:6,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-VIRUS: cid:0,bav:0
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: afb9dcb6b94d11f0b33aeb1e7f16c2b6-20251104
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1091434974; Tue, 04 Nov 2025 15:12:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 4 Nov 2025 15:12:54 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 4 Nov 2025 15:12:54 +0800
From: niklaus.liu <Niklaus.Liu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <zhigang.qin@mediatek.com>, <sen.chu@mediatek.com>,
	Niklaus Liu <niklaus.liu@mediatek.com>, niklaus.liu
	<Niklaus.Liu@mediatek.com>
Subject:
Date: Tue, 4 Nov 2025 15:12:40 +0800
Message-ID: <20251104071252.12539-1-Niklaus.Liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series is based on linux-next, tag: next-20251103
V1 patch link:https://lore.kernel.org/linux-mediatek/20251103134241.3773-2-Niklaus.Liu@mediatek.com/

Subject: [V3 PATCH 0/1] soc: mediatek: mtk-regulator-coupler: Add support for MT8189

changes in V3:
 - modify for comment[add the new entry by alphabetical order] 

changes in V2:
 - change title for patch
 - reply comment: This is a software regulator coupler mechanism, and the regulator-coupled-with
configuration has been added in the MT8189 device tree. This patchaddresses an issue reported by a 
Chromebook customer. When the GPU regulator is turned on, mediatek_regulator_balance_voltage already
sets both the GPU and GPU_SRAM voltages at the same time, so there is no need to adjust the GPU_SRAM 
voltage again in a second round. Therefore, a return is set for MT8189.
If the user calls mediatek_regulator_balance_voltage again for GPU_SRAM, it may cause abnormal behavior of GPU_SRAM. 


changes in V1:
 - mediatek-regulator-coupler mechanism for platform MT8189 

Niklaus Liu (1):
  soc: mediatek regulator: Add Support for mt8189

 drivers/soc/mediatek/mtk-regulator-coupler.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.46.0


