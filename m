Return-Path: <linux-kernel+bounces-800014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD1B4326B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AAA1C21B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D632750E6;
	Thu,  4 Sep 2025 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vC9OUcFI"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FF274FDE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967577; cv=none; b=aFArL2CaL2HIbmdfRoe79NOOhbFv4XJaZdqROHkrCFE61AQ0MZtFlEliIZm8gGwrTnf7lUmVs31HHrypIZ03GYxz58U4upXOKSdbRNsCZRJtJAoWgS+GEPvYhrWUn7nUzquDCoZBaLU35Qdek4/H3Yt7SssStyAAGWVMKWQley0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967577; c=relaxed/simple;
	bh=XTPMjwPDF2AZ+57/aHZmP02iLqyHKlLYVEOILKdXFDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AMTlJw/g7DwQmD1WDw3+56sove4QOWCWfizQfwNch4qiDm54ehOuaXzQKyWIk8ZtHwItDV5xbM4mLFzIi6EJXbZsVNbc3arxj5//RlIcIwrXg7ExFJhMCN6xWTfvcdAH7J+dCmlWN1ChJ7/NqgndRQkrAwTUJXvY8nNQNOmby5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=vC9OUcFI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f9b35858895811f0b33aeb1e7f16c2b6-20250904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=scGC82lmtFfVt/+rH55JPxyeN4hMWcRWm/ClysXmIqg=;
	b=vC9OUcFIELgZmfP35+gD+sc0hXPuAf0l1q5sd/cW7qA2GJ3uArlO7bNHdI85TGcuAFIzFKPxg3eGKVF+mDUJ7ql5Dl1H4MeH6naWNIHxujQ/LkIPZylUpfqygmqYnJOuGkHkCA8XVaIqfupAI/gQCHdq8LGZtAQk5Awna6cMfXA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:0ec38f95-293f-406f-b381-05c3a4f92e08,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:17eeeef7-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 3,DMD|SSN|SDN
X-CID-BAS: 3,DMD|SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f9b35858895811f0b33aeb1e7f16c2b6-20250904
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1963622347; Thu, 04 Sep 2025 14:32:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 4 Sep 2025 14:32:45 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 4 Sep 2025 14:32:42 +0800
From: <xion.wang@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Akinobu
 Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <wsd_upstream@mediatek.com>, <huadian.liu@mediatek.com>, Xion Wang
	<xion.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/1] char: Use list_del_init() in misc_deregister()
Date: Thu, 4 Sep 2025 14:37:03 +0800
Message-ID: <20250904063714.28925-1-xion.wang@mediatek.com>
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

Hi all,

This patch updates the misc_deregister() function to use list_del_init()
instead of list_del() when removing the device from the list.
While list_del() poisons the list pointers to catch invalid usage,
it does not reset the list head. 
If misc_deregister() is called more than once on the same device, 
list_empty() will not return true and list_del() may be called again,
leading to undefined behavior.

By switching to list_del_init(), we ensure the list head is reinitialized,
making the code more robust against double deregistration and
allowing safe usage of list_empty() after deregistration.

Fixes: b329becfc78b1 ("char: add WARN_ON() in misc_deregister()")

Let me know if you have any questions or suggestions.

Thanks,
Xion Wang

Xion Wang (1):
  char: Use list_del_init() in misc_deregister() to reinitialize list
    pointer

 drivers/char/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2


