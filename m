Return-Path: <linux-kernel+bounces-884428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F34DC3026F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C62188FFD6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F42C11C4;
	Tue,  4 Nov 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YOUU5Xq0"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F533D561
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246811; cv=none; b=Pb1BAudoXa6Nrm3vciYXi7ZfCAdWbfe4iOpphI0q5MhwwKgYeK3i1+OrS+mtsI9qXQuAJ2UJ8pt/7ox8FRLDEQ5n5vQly4MR8d8UabwBAVsboYand6qIyIe7ZruW3tkFR3wEpe3q7+wSy8xTk7wtv6u9dHtDlfaEReqmURIV7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246811; c=relaxed/simple;
	bh=MafG4x+hS//j+xbm2wp29pa1ORJntMLER3jmSWrbH0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HMYVNOnjWT9RMtm9I2daShFeRo7CgkWU5WngyxCAV2dnXxS0iFJKsGq55Ude0vAXWlr2UXVXm/6KkDPHFaEG1EpI1ZErmqSQ4zxYeCb+ejWaY1MaU7jz5Y8QQGBIahoVrGJnhmXdoXyFAMbfAXu6HAFhjif+N0lUqNm4VrcdwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YOUU5Xq0; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a5e43718b95c11f0b33aeb1e7f16c2b6-20251104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5V/Vz/H8HM7LchfMCgMJIzRqE49QYJch3AIZX3W5lns=;
	b=YOUU5Xq0LuMjGkUosfD+LrR/zgy9bAUAy8mkE6TOqZsjVk1ieVKYuCo1c6YYq0ir8+TbfDqZMHaTLCLiohJJIqYa+o1xwBsgi0p/HM4wYfG4UZBXuU3ciaO+mXqyMtY0cBbNN28QXagzJSJvU7B7ZVJxUb39OHvKFTlT9H07ytI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:446a5c81-18e9-4894-afdf-a74b4e83fa2a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:726e056b-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a5e43718b95c11f0b33aeb1e7f16c2b6-20251104
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1963540864; Tue, 04 Nov 2025 17:00:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 4 Nov 2025 17:00:00 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 4 Nov 2025 16:59:59 +0800
From: Liankun Yang <liankun.yang@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <mac.shen@mediatek.com>,
	<peng.liu@mediatek.com>, <liankun.yang@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/2] Adjust bandwidth limit for DP
Date: Tue, 4 Nov 2025 16:55:10 +0800
Message-ID: <20251104085957.1175-1-liankun.yang@mediatek.com>
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

DP link training checks the current PHY link signal quality.
After DP detects an HPD connection, it should first determine
the current link signal quality in order to select the resolution.

Since the EDP is already fixed to use the EDP panel,
the current training information and resolution are basically fixed.
EDP exists and its process differs from DP. Therefore,
it is necessary to isolate the parsing capability,
panel power, training state and enable state.

For example, the platform support DP 4lane 5.4G,
but panel A support DP 2lane 5.4G.

This is a time sequence:

1. Plug in panel A. According to the platform, it can output 4K 60Hz.
2. Timing mode set 4K 60Hz.
3. Atomic enable(Based on panel A ability, training pass 2lane 5.4G).
4. Finally, due to 2lane 5.4G bandwidth limitation, the platform cannot
output 4K 60Hz, resulting in a black sreen.

If apply this patch.

1. Plug in panel A.
2. Training pass 2lane 5.4G
3. Timing mode set 2K 60Hz(Based on the 2lane 5.4G bandwidth limit).
4. Atomic enable for output screen.

Liankun Yang (2):
  drm/mediatek: Adjust bandwidth limit for DP
  drm/mediatek: Add isolation to edp

 drivers/gpu/drm/mediatek/mtk_dp.c | 57 ++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 19 deletions(-)

-- 
2.45.2


