Return-Path: <linux-kernel+bounces-612289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F5A94D21
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 09:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DF63B083A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 07:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5246620E01F;
	Mon, 21 Apr 2025 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b6fWAwLO"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134618641;
	Mon, 21 Apr 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220567; cv=none; b=IY9IrjfTwfcCjWRlR2BPqevnu2V0GZhhlxZ1FIn8Sj0RlLYAP8YGnPq8aRcTbyXEVZxVWTcvzzlPdk/Q/rW6kuoBiJjUpOHCYK8l43nBge8yeBbOQjo5wH6EEhNiDQiAUu27kCwJ+uOGxbnABZ72JeSmkNWEr+JLvkTm2wRnFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220567; c=relaxed/simple;
	bh=d39wYXddYwuaCFz9yYCpeGTvr6DSC4adeaQeJ3iQTNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jmXY3jIdwJmyzff2j4lVtuE4tSILP9RT57l6i6Xh+HK9PcF2XdLuYczgxqdUCqjZrz46FRglcqIo43Um3ubam34CBjAgC5DKvGWBrnJvvx/hV4KI4X7NMBeO0Ge9GD6tRUX3Pjf0pgNKbjjfDCGjOWo34uHMedieCGI0E+3Oxh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=b6fWAwLO; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 55f17c901e8211f09b6713c7f6bde12e-20250421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bxJ9xVr+bWsUPq5pZ49UQFeAPTX6wfXQHs3mOpxc1y0=;
	b=b6fWAwLOV+GsHGqjL165kFyc9OCbiK+RNIsDwWoQh1Pddc1B6Kq1B2idzYUotxBCVXSeQ9AjNppjuDMPiKTiOo9oo9+8/3r8dAYkCuse3cw29aLx/yCWkCaIAHN2Cefpw0d6ZHGizjt7e9vnbCeCLO5/Nc4pe/m57mHcxGLp5c8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0ed75501-4364-4d3b-943c-87b8c70d74b0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:8d2a51a6-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 55f17c901e8211f09b6713c7f6bde12e-20250421
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1877950885; Mon, 21 Apr 2025 15:29:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 21 Apr 2025 15:29:17 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 21 Apr 2025 15:29:17 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Will Lee <will-cy.lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, Steve Lee
	<steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1 0/2] Bluetooth: btmtksdio: ensure btmtksdio_close is executed before btmtksdio_remove
Date: Mon, 21 Apr 2025 15:29:12 +0800
Message-ID: <20250421072914.466092-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

If Bluetooth SDIO card is unexpectedly removed due to hardware removal
or SDIO issue, it is possible for remove to be called before close.
If an interrupt occurs during this process, it may cause kernel panic.
Therefore, it is necessary to ensure that close is executed before
remove to stop interrupts and cancel txrx workqueue.

Chris Lu (2):
  Bluetooth: btmtksdio: Check function enabled before doing close
  Bluetooth: btmtksdio: Do close if SDIO card removed without close

 drivers/bluetooth/btmtksdio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.45.2


