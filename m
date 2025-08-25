Return-Path: <linux-kernel+bounces-784304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F1B339C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E367F16C85E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FB62BEC3D;
	Mon, 25 Aug 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MDXCrUx4"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F302BDC2B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111295; cv=none; b=h+47PuV7glsglYZ1VblIcKVgUUrZfzh6tLtjVrapVIi/jeUYMBLfUsSRVLklhmEeuQNdQWRYB2GHVeDEY2bn7EypdQE+zYabiAWG0YSG9bIc/WndkQgn6y6G4arPZQos0D4z9DMDvw+Rzsno/2mNdypuASBO99Bh18E24cJmQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111295; c=relaxed/simple;
	bh=Bzubn98W0uGmhmf6l1F3ZlqEzHmryNM+GOaqRgVWsm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ouTrmKooLEtzlOZzsjB2GSsUjH7UJ9bJA4eBtwtKCRG9LVqpqPjgom9VhZO2tB3K4e0Phi0Cd00kwpS4ma/0Z0QyP/nIa3O7b2HwErQQNhnEox268oJ30BSE2Vijb7sFrLCCNzKUDMOJ2zPPbZmE+dkqGhZVCr/6fmiL2sf8H+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MDXCrUx4; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 465028ca818f11f0b33aeb1e7f16c2b6-20250825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=X4DPtLl5IrIynjpjGtlWEHRVfkwFu8gJ5N5pGgPIdqQ=;
	b=MDXCrUx41MXHgzMvY4CbAR6cCE8c4wDxG9JzlpwBRAQOJAGd5bzdijbW8FvqXRRsf0iQ1lwAt/Vmalrn6AeV52X0iqtVLrbvleBvReVN1MEQjAT4wcZKWQjnmCH2ICygc6rmo/oToocWFMFXbbfpDWFFtQMQbu59QRb3Rnvmk28=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:5a903731-484a-4a04-b0db-df836df9dbd4,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:3dfd946d-c2f4-47a6-876f-59a53e9ecc6e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 3,DMD|SSN|SDN
X-CID-BAS: 3,DMD|SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 465028ca818f11f0b33aeb1e7f16c2b6-20250825
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1173303413; Mon, 25 Aug 2025 16:41:20 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 25 Aug 2025 16:41:19 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 25 Aug 2025 16:41:18 +0800
From: <xion.wang@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <huadian.liu@mediatek.com>, Xion Wang
	<xion.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/1] misc: Prevent double registration and deregistration of miscdevice
Date: Mon, 25 Aug 2025 16:45:46 +0800
Message-ID: <20250825084556.10358-1-xion.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Xion Wang <xion.wang@mediatek.com>

Dear maintainers,

I am submitting a patch to improve the robustness of the misc device subsystem in the Linux kernel.

In the current implementation, repeated calls to misc_register() or misc_deregister() on the same miscdevice instance may result in corruption of the misc_list or kernel crash due to multiple INIT_LIST_HEAD or list_del operations on the same list node.

This patch introduces additional checks in both misc_register() and misc_deregister() to prevent double registration and double deregistration. By using misc->this_device as a status flag, the driver can safely determine whether the device has already been registered or deregistered, and avoid performing dangerous operations on the misc_list.

With these changes, the misc device subsystem becomes more stable and reliable, reducing the risks of list corruption and improving overall system safety.

Feedback and suggestions are welcome.

Thank you for your time and consideration.

Best regards,
Xion Wang

Xion Wang (1):
  misc: Prevent double registration and deregistration of miscdevice

 drivers/char/misc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.45.2


