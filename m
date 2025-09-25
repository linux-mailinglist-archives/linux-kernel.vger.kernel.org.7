Return-Path: <linux-kernel+bounces-832073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4BFB9E46B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871171BC3084
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0982E8B94;
	Thu, 25 Sep 2025 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gM2tBBXc"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9481552FD;
	Thu, 25 Sep 2025 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792070; cv=none; b=rXb5oqgJ3uAdqJbQS2+POeLEpIxhhGtGCofRYyymlPDoBwAsAhqzkbi3Rvi3s6B+LsjDxsP5nNKc446ikUaTflDCtChqwrU6A6xMhkU8HzmSDAarZkDZLFSc49R6MQ9IGezD2o2fDIynUJULHUon1o8vzkNYGQMUT8Q6Tfei6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792070; c=relaxed/simple;
	bh=lAbfl7+UbM9HlefeX5KUTqP4T+8HBqdnQz9rGseRamM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aq3VS5l8VfcpyIuHvwPrsGjkRHyZWU2lIlgJLDzfkhieyRNf6JIFGM8cA/5I/+Lzc/9dp/CZ6bEyumXCXUhoI4ZA8O2M3fsEIr+JuPiwBX8ZMbnDv37y6/hpbCxBgpFEe/qi6hWUlP6nTTHbiotHJ0UzImQ0XyldYpQnRiUjuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gM2tBBXc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f5ac9ed899f011f08d9e1119e76e3a28-20250925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FgEHFJuF/mtaLrGbvxhy8JWKLeF9SIUBYeavxyw4rFQ=;
	b=gM2tBBXcDFLBigD8IsMeGBlT1AW8XhlrUStF5RIRc28zrhJrz9GE9r4S8PQJwJ/WjxRHEeMIJ9Kci7giKume8MYdjjLL40KAjwUFL1FcPbG7SXqH/0A8cbVJXpvjSrLdxz5t29AU6LlKg6RdAq9uO0AcrLksA1fjwKA1qYw1Lpg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5fa55448-817f-42db-8c7f-7617cc395867,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:3259ef6c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f5ac9ed899f011f08d9e1119e76e3a28-20250925
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 985007173; Thu, 25 Sep 2025 17:21:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 25 Sep 2025 17:21:02 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 25 Sep 2025 17:21:01 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v8] Bluetooth: mediatek: add gpio pin to reset bt
Date: Thu, 25 Sep 2025 17:20:58 +0800
Message-ID: <20250925092058.16648-1-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Support the platform Bluetooth to be reset by hardware pin,
when a Bluetooth exception occurs, attempt to reset the
Bluetooth module using the hardware reset pin, as this
method is generally more stable and reliable than a
software reset. If the hardware reset pin is not specified
in the device tree, fall back to the existing software
reset mechanism to ensure backward compatibility.

Co-developed: Sean Wang <Sean.Wang@mediatek.com>
Co-developed: Hao Qin <hao.qin@mediatek.com>
Co-developed: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>

V7-->V8 modifications:
-Currently, the universal reset GPIO can be found by configuring DTS.
   USB bus can get the device node and reset GPIO in the probe phase.
   It is fully compatible with other vendors' methods of getting reset
   GPIO. Therefore, the previous complex methods of adding the compatible
   string in btmtk.c to get GPIO is discarded. Abi files and yaml files
   are no longer needed. When a Bluetooth exception occurs, the existence
   of GPIO will be determined first. This change improves the robustness
   of Bluetooth recovery on platforms that support hardware reset, while
   maintaining support for platforms that do not.

V6-->V7 modifications:
-Change the gpio_direction_output interface to the gpiod_set_value_cansleep
   and gpiod_put interface.
-Remove the schedule_delayed_work asynchronous operation.
-Delete the #gpio-cell attribute in the yaml file, remove the #gpio-cell
   in the required field, and simplify the contents of the descriptions.

V5-->V6 modifications:
-Add specific revisions in the changes from v4 to v5.
-Add hardware pin title and descriptions to dt-binding submission
   information.
-Modify the title descriptions in the dt-binding file.
-Add 7925 what is it.
-Wrap the descriptions of MT7925 chip uses the USB bus appropriately.
-Change the compatible string to mediatek,mt7925-bluetooth in
   the dt-binding file and driver code.
-Drop gpio-controlelr properties in the dt-binding file.
-Modify the descriptions of the reset-gpios
   properties in the dt-binding file.
-Change the node information of reset-gpios in bluetooth
   from high level valid to low level valid.

V4-->V5 modifications:
-Correct the spelling error of word provides mentioned in V1.
-Drop the xhci0 node and status property in the dt-binding file.
-Modify the bt_reset tag node to bluetooth in the dt-binding file.
-Add #gpio-cell descriptions to properties, nodes and requests.
-Make a separate patch for the changes to dt-binding.

V3-->V4 modifications:
-Modify submission information why use hardware pin to reset Bluetooth.
-Write historical commit information into the cover letter.
-Modify dt binding format information and
   the explanation text in the dt-binding file.

V2-->V3 modifications:
-Changed the capitalization of co-developer names,
   using the correct capitalization of abbreviations and full
   name, and corrected obvious spelling errors.
-Add a revision history.
-Remove the "BT Driver" in the prefix.
-Add the bt-binding document, include inforamtion related to reset
   pin and compatibility matching.
-Add a comment before the schedule_delayed_work function call,
   although schedule_delayed_work is asynchronous, there is no risk.
   Even if it is not completed within 200ms, it will only postpone
   the subsequent probe and will not have any impact.
-Add a comment before the btmtk_reset_by_gpio function call,
   if the compatibility filed or pin cannot be found in the dts
   files, it can still reset bluetooth using software reset.

V2 modifications:
-Modify gpio to GPIO, SW to software,
   and fix other obvious spelling errors.
---
 drivers/bluetooth/btusb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ef44817cad34..fcf90442a2fd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2745,6 +2745,19 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
 
+	/* Toggle the hard reset line. The MediaTek device is going to
+	 * yank itself off the USB and then replug. The cleanup is handled
+	 * correctly on the way out (standard USB disconnect), and the new
+	 * device is detected cleanly and bound to the driver again like
+	 * it should be.
+	 */
+	if (data->rest_gpio) {
+		gpiod_set_value_cansleep(data->reset_gpio, 1);
+		msleep(200);
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
+		return 0;
+	}
+
 	err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
 
 	usb_queue_reset_device(data->intf);
-- 
2.45.2


