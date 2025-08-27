Return-Path: <linux-kernel+bounces-787575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB9B37833
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8841BA53BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40B729BDBA;
	Wed, 27 Aug 2025 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hadQIWNA"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943B27B327
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262252; cv=none; b=LZ2vHEuXGKURz0xS2MlDcxBmt7nXarF/Q34zxtMnOUKvBNBkgClZKRT2yiLMTP5mgLE73DG4oBHcAnWPNlU0t7fc6p59nyEkquMwEmZZkVthMo1N/MebdWWxiuDu993rNOSZaYUzv/I7OkbHsvN4TSP1LJdCZTQS+kgTXRlTnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262252; c=relaxed/simple;
	bh=v+6Y93V/8GeVTITKuOJLV8Qr5uMR5ojv3Ee1lixItsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sHhlUivqrUuxznBLK4qCQrn4HlDr4YDs/y5KUG8dNllD35XKwPM4k3vfaVxByg9qzULwY+bVmyr5niqbyhzu3r2PGKhNh+7PfVRsgvIum2QP75VoyQjCEbpYzvCli1xhZb4vN9YtscL3d2IixPI4Xqx5J8yhiMGAWF367+/DBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hadQIWNA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c3a2867882ee11f0b2125946c7b33498-20250827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Stl5UPAf2smb4LSnxAfCM/t0N65XawN8s3YPJSRxSig=;
	b=hadQIWNAZoXrJGc3m7yfk5SAihZT04I3SsH+TsoUgDEP7F7i+ndnno0d40OW+QT8+sRM+WcAsP/x1BaYQ+e9jbiNp+UQ4KRxD6172kbbl+JN4b16uEieiQmoaa7rtkW8toLpz2sCLNO3WeMwkio37+yK/uFzY9A1BkrAj8rzfF4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:39138ba2-c485-431b-a4be-ae44558c220b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:928ae744-18c5-4075-a135-4c0afe29f9d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 3,DMD|SSN|SDN
X-CID-BAS: 3,DMD|SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c3a2867882ee11f0b2125946c7b33498-20250827
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1334334178; Wed, 27 Aug 2025 10:37:24 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 27 Aug 2025 10:37:22 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 27 Aug 2025 10:37:22 +0800
From: <xion.wang@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <huadian.liu@mediatek.com>, Xion Wang
	<xion.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/1] misc: remove ineffective WARN_ON() check from misc_deregister()
Date: Wed, 27 Aug 2025 10:40:59 +0800
Message-ID: <20250827024201.21407-1-xion.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Xion Wang <xion.wang@mediatek.com>

Hi All,

This patch removes the ineffective WARN_ON(list_empty(&misc->list)) 
check from misc_deregister(). Please see the commit message for details.

Xion Wang (1):
  misc: remove ineffective WARN_ON() check from misc_deregister()

 drivers/char/misc.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.45.2


