Return-Path: <linux-kernel+bounces-708520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9AEAED16C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 23:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD87E1746D5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BBA239591;
	Sun, 29 Jun 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=snekbyte.com header.i=@snekbyte.com header.b="lPEdf6fh"
Received: from mail-108-mta248.mxroute.com (mail-108-mta248.mxroute.com [136.175.108.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD329A1
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751234042; cv=none; b=d2DeFYDWlwoUCVkfU4OWOSmOkOLcP7CMIXiAzivT1cGiwFz+pjhahc92OuCuTZtdSD8K6SWdmq8OlCI0zwMYs9mvxn4IPpr7bXvnZ5saHs1p9ZUerUWI101Xy8/ogCrnI1FuD2MWdOLzbR8dJp395sdWREN5zVh2uCb5y2TDSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751234042; c=relaxed/simple;
	bh=csx2nFLsTuv9cXPbKcrSJ/S9zFSXq8N9su7jnd6UD3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hCAjRTfw1YbQiSc9dfU+ns9Cu6dnnzdYEXsbTtOFFCf/7sSFfWYMqALq+OFi1juPc9nAIoAvitKgMHM67yA4imHh8OTh00MWjRdAAmip6+XO+AjsgEgqeR4K4mNNZth8XDgLAOiQQ2ORkG6u8KNQiuP+FMihrb8W6bs1aBccYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snekbyte.com; spf=pass smtp.mailfrom=snekbyte.com; dkim=pass (2048-bit key) header.d=snekbyte.com header.i=@snekbyte.com header.b=lPEdf6fh; arc=none smtp.client-ip=136.175.108.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snekbyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snekbyte.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta248.mxroute.com (ZoneMTA) with ESMTPSA id 197bdaa04110008631.004
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 29 Jun 2025 21:48:45 +0000
X-Zone-Loop: 8f4eb850fee12a3a1be4f8745d2a80c97a2c50b5f5ac
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=snekbyte.com; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e3yCd8QB9L4sn/uY1ZILguL8ZWYji4UNd3j9gxk018Q=; b=lPEdf6fhXeyDSkb1L9Fa3YnYCM
	6yHxORL08Mf84XGgzDajvw48mkZHFtfyCXmm3p9nZm+wtl1RrRoD2oUyQCgPvnBmGXUmbmoC29Yla
	2wKCWoc/dzygmZdZnCPdaOkiqFLk4Upe7rftz082jItns9w6TZ/oPhkj3iPOK+VjpTJgnGaheu24X
	DAH0OXUUkFY08d27qNqaMOofxyNVJbrjDqt9kk0it3KT2VjZCYxOeu/1XJTX7kjB7R8M/cCDQvGd4
	YvqDuQlr0GB9TDUJB0De+Ws2IxnFAhBK3u95uwC/+w096QlXTJkDUAHrbYhg1ggjO3+Z2zJea6CFw
	1XUlqmqQ==;
From: Leonard Dizon <leonard@snekbyte.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leonard Dizon <leonard@snekbyte.com>
Subject: [PATCH] HID: elecom: add support for ELECOM HUGE 019B variant
Date: Mon, 30 Jun 2025 05:48:30 +0800
Message-ID: <20250629214830.30220-1-leonard@snekbyte.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: leonard@snekbyte.com

The ELECOM M-HT1DRBK trackball has an additional device ID (056E:019B)
not yet recognized by the driver, despite using the same report
descriptor as earlier variants. This patch adds the new ID and applies
the same fixups, enabling all 8 buttons to function properly.

Signed-off-by: Leonard Dizon <leonard@snekbyte.com>
---
 drivers/hid/hid-elecom.c | 6 ++++--
 drivers/hid/hid-ids.h    | 3 ++-
 drivers/hid/hid-quirks.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index defcf91fdd14..0ad7d25d9864 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -89,7 +89,8 @@ static const __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		break;
 	case USB_DEVICE_ID_ELECOM_M_DT1URBK:
 	case USB_DEVICE_ID_ELECOM_M_DT1DRBK:
-	case USB_DEVICE_ID_ELECOM_M_HT1URBK:
+	case USB_DEVICE_ID_ELECOM_M_HT1URBK_010C:
+	case USB_DEVICE_ID_ELECOM_M_HT1URBK_019B:
 	case USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D:
 		/*
 		 * Report descriptor format:
@@ -122,7 +123,8 @@ static const struct hid_device_id elecom_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_010C) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_019B) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C) },
 	{ }
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c6468568aea1..33cc5820f2be 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -448,7 +448,8 @@
 #define USB_DEVICE_ID_ELECOM_M_XT4DRBK	0x00fd
 #define USB_DEVICE_ID_ELECOM_M_DT1URBK	0x00fe
 #define USB_DEVICE_ID_ELECOM_M_DT1DRBK	0x00ff
-#define USB_DEVICE_ID_ELECOM_M_HT1URBK	0x010c
+#define USB_DEVICE_ID_ELECOM_M_HT1URBK_010C	0x010c
+#define USB_DEVICE_ID_ELECOM_M_HT1URBK_019B	0x019b
 #define USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D	0x010d
 #define USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C	0x011c
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 31508da93ba2..9bf9ce8dc803 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -410,7 +410,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_010C) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_019B) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C) },
 #endif
-- 
2.50.0


