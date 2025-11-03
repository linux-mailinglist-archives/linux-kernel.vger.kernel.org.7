Return-Path: <linux-kernel+bounces-883000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261DAC2C40E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95C53BBEFC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8D307ACF;
	Mon,  3 Nov 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mnDc2Mrx"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE173090D9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177373; cv=none; b=qLK6wBlYyCw0gvhaQhir98RB3cd/+xX95iXiO9HENguaW1L9P5eQkrkp+M+K3y17/ZkIHMzHNeTUKzVd37KHsjGjJwBq5joCTKURPfYIm/5p108xRyGiFApxrUtD8FsTr4gnV22yqMIqE0WjQykLHo+qX3A8qEWvrVEaeSVF7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177373; c=relaxed/simple;
	bh=ygkTUIYhYvsii4jwgl4K8VPHschG23wPZBOMcUoA0ms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uV+pQYWoN5OMyyoImmeXTyfyekrpdnjmD5B7gpglZbaRUHyxhJDkH3WkkRIZGhfEDUH7o9hHLr1swavud/MJBmHcFDMiA7vJ+g525fMLDnojWJZHNgKqu3Div6RV8WwrKB2z5ieN8HoZ3sChxefGYZnWMjbrTkSO7RFHP8RNZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mnDc2Mrx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fa7604e8b8ba11f0ae1e63ff8927bad3-20251103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4zpUXsTaas0d04qVuUufLjAsxPeCu/19RhV4iRVm7B4=;
	b=mnDc2Mrxr42eL/djfy4FDMBzWDzRicKIC8Shx9UWUfDmmWufX0EzxSlQiTy7lNFXU7iioOXpR+5pwlClQ4aEvm5spTllvqegP5Kp1TvYni5xS3HHRhzAuIZjG9I82eqwXuQ4T9NhEtrGnpk+rq3sVARGg3fNsrj6SGodN+akT+Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2f65eabe-5f59-418f-b9f4-eb5840b7bfd8,IP:0,UR
	L:0,TC:0,Content:54,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:54
X-CID-META: VersionHash:a9d874c,CLOUDID:270114e0-3890-4bb9-a90e-2a6a4ecf6c66,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:-7|-6|
	3|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fa7604e8b8ba11f0ae1e63ff8927bad3-20251103
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1141474228; Mon, 03 Nov 2025 21:42:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 3 Nov 2025 21:42:46 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 3 Nov 2025 21:42:45 +0800
From: niklaus.liu <Niklaus.Liu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <sirius.wang@mediatek.com>,
	<vince-wl.liu@mediatek.com>, <jh.hsu@mediatek.com>,
	<zhigang.qin@mediatek.com>, <sen.chu@mediatek.com>, Niklaus Liu
	<niklaus.liu@mediatek.com>, niklaus.liu <Niklaus.Liu@mediatek.com>
Subject:
Date: Mon, 3 Nov 2025 21:42:25 +0800
Message-ID: <20251103134241.3773-1-Niklaus.Liu@mediatek.com>
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
Subject: [PATCH 0/1] soc: mediatek regulator: Add Support for mt8189

changes in V1:
 - mediatek-regulator-coupler mechanism for platform MT8189 

Niklaus Liu (1):
  soc: mediatek regulator: Add Support for mt8189

 drivers/soc/mediatek/mtk-regulator-coupler.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.46.0


