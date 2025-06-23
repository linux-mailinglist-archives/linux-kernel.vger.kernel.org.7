Return-Path: <linux-kernel+bounces-698037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD1AE3C37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 12:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F38175151
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE9C23BF8F;
	Mon, 23 Jun 2025 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VA2aWiyK"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1523BF9C;
	Mon, 23 Jun 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674323; cv=none; b=trEMIR+i5q5HgpRE9Vcau0E5HerKhiVS4LoJXccVwHluR2Gia/O3vqgLxD2j2q7GjSKmLBHgeco21PAIP4gNs8/hL5Vm4ZYukBWc1KGQkxrCq+w0nutMZxfDizAkaCRkLzbEzFa6amsSDmf8jMSpO7GJlKgmp/1BkPHsA3WMI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674323; c=relaxed/simple;
	bh=MtyUi5inSJocAHd2EKxS3QCRGXlAJoY/HwfY58ekLEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXFl+TIUKlPD9Q2WmMBkN0JLhCFoyiSmGEal94xnoTOxBnWnfQnzfPCpge6Z2oLmd3Zw1cKRRNa8B9kIyiz9cDZ0U5niQ2VwtsOj31KpXo8DjKOQ9DtLDgHDCij6+Q3tcLLupYgKlZB8l/Xpj4evrKJbZ/rafW/P5f733qcF6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VA2aWiyK; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5a740348501c11f0b33aeb1e7f16c2b6-20250623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qvX/P/SG/SFzHP1pyPRjGEyMLB0uWfnXE56q6Nx+TqM=;
	b=VA2aWiyK/SwUO50OV1CLAbjG5wFwHSFDcoYRBF5REuMFM/zmC5QjLa4LOqxSiYER1q5/lLoh4oWldP19nHi9Xduv3P8y7IXs3EreyW63IrDwVCWHJdop3O/U6IB2nfkz02U8HkowplGSxcnK+d/QyTCnKgBJfD6Bh2JMNUenvTw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:4638f6c7-591e-4cee-997e-2f23ac2a0030,IP:0,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:9eb4ff7,CLOUDID:35f14777-7521-4364-b0ef-cd7d9c0ecbde,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5a740348501c11f0b33aeb1e7f16c2b6-20250623
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 225289146; Mon, 23 Jun 2025 18:25:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 23 Jun 2025 18:25:12 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 23 Jun 2025 18:25:12 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, Hao Qin <Hao.qin@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v4 1/1] Bluetooth: mediatek: add gpio pin to reset bt
Date: Mon, 23 Jun 2025 18:23:59 +0800
Message-ID: <20250623102359.2684-2-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250623102359.2684-1-ot_zhangchao.zhang@mediatek.com>
References: <20250623102359.2684-1-ot_zhangchao.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Makes the platform Bluetooth to be reset by hardware pin,
it provides two methods to do it for mediatek controller,
and it has been tested locally many times and can reset normally.

When an exception occurs, resetting Bluetooth by hardware pin
is more stable than resetting Bluetooth by software.
If the corresponding pin is not found in dts,
bluetooth can also be reset successfully.

Co-developed: Hao Qin <hao.qin@mediatek.com>
Co-developed: Chris Lu <chris.lu@mediatek.com>
Co-developed: Jiande Lu <jiande.lu@mediatek.com>
Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 69 +++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  5 +++
 2 files changed, 74 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 4390fd571dbd..3e5f3ca6f0d5 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -6,6 +6,8 @@
 #include <linux/firmware.h>
 #include <linux/usb.h>
 #include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -109,6 +111,65 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
 	}
 }
 
+static void btmtk_reset_by_gpio_work(struct work_struct *work)
+{
+	struct btmtk_reset_gpio *reset_gpio_data =
+			container_of(work, struct btmtk_reset_gpio, reset_work.work);
+
+	gpio_direction_output(reset_gpio_data->gpio_number, 1);
+	kfree(reset_gpio_data);
+}
+
+static int btmtk_reset_by_gpio(struct hci_dev *hdev)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	struct btmtk_reset_gpio *reset_gpio_data;
+	struct device_node *node;
+	int reset_gpio_number;
+
+	node = of_find_compatible_node(NULL, NULL, "mediatek,usb-bluetooth");
+	if (node) {
+		reset_gpio_number = of_get_named_gpio(node, "reset-gpios", 0);
+		if (!gpio_is_valid(reset_gpio_number)) {
+			bt_dev_warn(hdev, "invalid reset GPIO, use software reset");
+			return -EINVAL;
+		}
+	} else {
+		bt_dev_warn(hdev, "no reset GPIO, use software reset");
+		return -ENODEV;
+	}
+
+	/* Toggle the hard reset line. The Mediatek device is going to
+	 * yank itself off the USB and then replug. The cleanup is handled
+	 * correctly on the way out (standard USB disconnect), and the new
+	 * device is detected cleanly and bound to the driver again like
+	 * it should be.
+	 */
+
+	if (test_and_set_bit(BTMTK_HW_RESET_ACTIVE, &data->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		return 0;
+	}
+
+	reset_gpio_data = kzalloc(sizeof(*reset_gpio_data), GFP_KERNEL);
+	if (!reset_gpio_data)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&reset_gpio_data->reset_work, btmtk_reset_by_gpio_work);
+	reset_gpio_data->gpio_number = reset_gpio_number;
+
+	gpio_direction_output(reset_gpio_number, 0);
+
+	/* It requires 200ms for mtk bt chip to do reset,
+	 * although Schedule_delayed_work is asynchronous,
+	 * it is risk-free. If it is not completed in 200ms,
+	 * it will only postpone the next probe, which will
+	 * only make the probe run later. There is no other risk.
+	 */
+	schedule_delayed_work(&reset_gpio_data->reset_work, msecs_to_jiffies(200));
+	return 0;
+}
+
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor)
 {
@@ -364,6 +425,14 @@ void btmtk_reset_sync(struct hci_dev *hdev)
 	struct btmtk_data *reset_work = hci_get_priv(hdev);
 	int err;
 
+	/* Toggle reset gpio if the platform provieds one,
+	 * if the compatibility field or pin cannot be found
+	 * in the dts files, it can still reset bluetooth using
+	 * software reset.
+	 */
+	err = btmtk_reset_by_gpio(hdev);
+	if (!err)
+		return;
 	hci_dev_lock(hdev);
 
 	err = hci_cmd_sync_queue(hdev, reset_work->reset_sync, NULL, NULL);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 5df7c3296624..8a265ce367d1 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -179,6 +179,11 @@ struct btmtk_data {
 	spinlock_t isorxlock;
 };
 
+struct btmtk_reset_gpio {
+	struct delayed_work reset_work;
+	int gpio_number;
+};
+
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
 				   struct btmtk_hci_wmt_params *);
 
-- 
2.46.0


