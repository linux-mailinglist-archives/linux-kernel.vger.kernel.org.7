Return-Path: <linux-kernel+bounces-754152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B059B18EC4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 15:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4447E7B36A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0D4239E96;
	Sat,  2 Aug 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="WKfG7p86"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951D1E519
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754142366; cv=none; b=GtImoxrB9H7UJBpiiBoIYKHkTJKkgLMMbzujcvqTbUDLWBivA7cqhj20s+2wFwAkCpaUSKJ/JcG3BR1WtlKrFxQB/xPllWG9n2F+0nfSDIja45cDk958OoHBM4m7axn6Kerj8wY4HfuXQ95UVYkvqZcUei7hIOafNgiQnzOuMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754142366; c=relaxed/simple;
	bh=NXGZV+eWjal/j8I5d/z3GchjI6sUsX4UHc+bLHtVPe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3tznuT7e1Bq2gFbQtjMZQX0+aqosazcVYZXcuzHs/TDRLScaSaPRzMlIVup2cgy8c0Jeoa64+tmmU7G2oOZ2b6KdpZLIkB+tybTCTeP9i8mc/cPt6sFHY+GmA1aH0z3z/d59Oep+zumVcDdySX1IaXTUizYRslp+G17AqmLCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=WKfG7p86; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 522D2240101
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 15:45:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1754142355; bh=MdHIJppBkLN8gYJiKRNyD2UBKFvXcGrHkaAKVD9Vc+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=WKfG7p86K1Ebl2u1rwApLsmoBBfwcu3DOm41fScX1fXYB/bxVECY1ZzP7RFWfCScb
	 QdaEy6a4kj+nTAM80EErePJL/0wQTPb6PsryNfdNgJnTlCeGB1K5mgEmvhTthGfjDq
	 Tub2Av4qofrDMx2+x4yhSp223BlTwN6NUxOm1vRcD+N3lmIJmQA7EoXn7E36r4w7WZ
	 9vkWbRU43KComZZ8izEzJnMx/UB26mof5HZ+uztjvycxQ9CxJEZatu1MadShFBeGxj
	 0XUaEYFPU+4dsFC6bAwCjrdHpOeVXCN000aPMoVNvziSeSTx+65KCZ67DqxCVSIyQt
	 JcTewo3J9c1Qg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bvPGp4m0Rz6tlh;
	Sat,  2 Aug 2025 15:45:54 +0200 (CEST)
From: Martin Hilgendorf <martin.hilgendorf@posteo.de>
To: Jiri Kosina <jikos@kernel.org>
Cc: Martin Hilgendorf <martin.hilgendorf@posteo.de>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: elecom: add support for ELECOM M-DT2DRBK
Date: Sat, 02 Aug 2025 13:45:55 +0000
Message-ID: <20250802134542.21692-1-martin.hilgendorf@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DT2DRBK trackball has 8 buttons, but the report descriptor only
specifies 5. This patch adds the device ID and performs a similar fixup as
for other ELECOM devices to enable the remaining 3 buttons.

Signed-off-by: Martin Hilgendorf <martin.hilgendorf@posteo.de>
---
 drivers/hid/hid-elecom.c | 2 ++
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 0ad7d25d9864..69771fd35006 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -101,6 +101,7 @@ static const __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		 */
 		mouse_button_fixup(hdev, rdesc, *rsize, 12, 30, 14, 20, 8);
 		break;
+	case USB_DEVICE_ID_ELECOM_M_DT2DRBK:
 	case USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C:
 		/*
 		 * Report descriptor format:
@@ -123,6 +124,7 @@ static const struct hid_device_id elecom_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT2DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_010C) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_019B) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5a1096283855..6dc797de3117 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -451,6 +451,7 @@
 #define USB_DEVICE_ID_ELECOM_M_XT4DRBK	0x00fd
 #define USB_DEVICE_ID_ELECOM_M_DT1URBK	0x00fe
 #define USB_DEVICE_ID_ELECOM_M_DT1DRBK	0x00ff
+#define USB_DEVICE_ID_ELECOM_M_DT2DRBK	0x018d
 #define USB_DEVICE_ID_ELECOM_M_HT1URBK_010C	0x010c
 #define USB_DEVICE_ID_ELECOM_M_HT1URBK_019B	0x019b
 #define USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D	0x010d
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index ff11f1ad344d..5c15af9afa98 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -411,6 +411,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT2DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_010C) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_019B) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D) },
-- 
2.50.1


