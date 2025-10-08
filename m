Return-Path: <linux-kernel+bounces-844971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 573C8BC32C1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 04:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 327204E45A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 02:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C895129B796;
	Wed,  8 Oct 2025 02:51:51 +0000 (UTC)
Received: from mail.fintek.com.tw (mail.fintek.com.tw [59.120.186.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581741A9F8D;
	Wed,  8 Oct 2025 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.186.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759891911; cv=none; b=mSIPlYOrhBlncgzsmA4R8SrNYJDpHNBQOOsX72KV8V+bh3eP+n4duZ+Y5Ob9Yod4nDEvyQpFxyc9BUPhOUW/x7dSjnmg17AMTrbWhNE+I/n6bINqi/H3yyxmNYDy75zFA1V9F8X8bh2CeRB417Hy/eqefjK+7D9DwekD5iyCUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759891911; c=relaxed/simple;
	bh=5xNX8lduj2pfCAw0k8kYDQbH1hEsT66A6hi7Tit+vbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kd21MBtoghFjnOd10dXv2ckcCE7GKNcbD9/7Jq83LRZMcz/y1G8B3J1VwBlaSWXx1JKeavjO74JPSAqFtLU1UZBXJcIA/i0lMzz3nnOo/s0TyrcY2WjGBD2U1mYYig08Vnwb5poAZ3kqFs2re693ghyYw+SdhwxXWwtKN88Obxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw; spf=pass smtp.mailfrom=fintek.com.tw; arc=none smtp.client-ip=59.120.186.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintek.com.tw
Received: from mail.fintek.com.tw (localhost [127.0.0.2] (may be forged))
	by mail.fintek.com.tw with ESMTP id 5982e5WF089523;
	Wed, 8 Oct 2025 10:40:05 +0800 (+08)
	(envelope-from peter_hong@fintek.com.tw)
Received: from vmMailSRV.fintek.com.tw ([192.168.1.1])
	by mail.fintek.com.tw with ESMTP id 5982dY49089306;
	Wed, 8 Oct 2025 10:39:34 +0800 (+08)
	(envelope-from peter_hong@fintek.com.tw)
Received: from localhost (192.168.1.128) by vmMailSRV.fintek.com.tw
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 8 Oct 2025
 10:39:34 +0800
From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
To: <johan@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tom_tsai@fintek.com.tw>,
        <yu_chen@fintek.com.tw>, <hpeter+linux_kernel@gmail.com>,
        "Ji-Ze Hong (Peter
 Hong)" <peter_hong@fintek.com.tw>
Subject: [PATCH V1 1/1] USB: serial: f81232: fix incomplete serial port generation
Date: Wed, 8 Oct 2025 10:38:58 +0800
Message-ID: <20251008023858.227740-1-peter_hong@fintek.com.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.2055-9.0.1002-27556.001
X-TM-AS-Result: No-5.890900-8.000000-10
X-TMASE-MatchedRID: t8RJVGV/sdu+0r2Yw7MQTi9iVDu7EPf8TFQnI+epPIZ3de2OoBqgwubd
	9j4+b6jIFNeXAh2Nr3WwS7/aOrnZQgV2NKF6aideEXjPIvKd74BMkOX0UoduuUekR3VSvOYVN1N
	eJEsbqQ5dKjFjTrBoAP7tX3FmyDXohXSYrS9SPAesxn4GpC3Y2jzLhqT0KeNid/WCzGSrZcmeAi
	CmPx4NwBnUJ0Ek6yhjxEHRux+uk8hfNjF5BHUO+9mrFmOnHZVH3QI5wn3CsvwScphR2QHLY5I5G
	u0/OJv1nZi3Rf8Un1s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.890900-8.000000
X-TMASE-Version: SMEX-12.5.0.2055-9.0.1002-27556.001
X-TM-SNTS-SMTP:
 43E67E7AFC1CD97760D04F0B7F1DC8CF9C521462129809717BDD8A55DD6330102000:8
X-DKIM-Results: [192.168.1.1]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:mail.fintek.com.tw 5982e5WF089523

The Fintek F81532A/534A/535/536 family relies on the
F81534A_CTRL_CMD_ENABLE_PORT (116h) register during initialization to
both determine serial port status and control port creation. If the
driver experiences fast load/unload cycles, the device state may becomes
unstable, resulting in the incomplete generation of serial ports.

Performing a dummy read operation on the register prior to the initial
write command resolves the issue. This clears the device's stale internal
state. Subsequent write operations will correctly generate all serial
ports.

Tested on: HygonDM1SLT(Hygon C86 3250 8-core Processor)

Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
---
 drivers/usb/serial/f81232.c | 58 +++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 530b77fc2f78..84a9e3e43b5b 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -856,6 +856,41 @@ static int f81534a_ctrl_set_register(struct usb_interface *intf, u16 reg,
 	return status;
 }
 
+static int f81534a_ctrl_get_register(struct usb_interface *intf, u16 reg,
+					u16 size, void *val)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int retry = F81534A_ACCESS_REG_RETRY;
+	int status;
+
+	while (retry--) {
+		status = usb_control_msg_recv(dev,
+					      0,
+					      F81232_REGISTER_REQUEST,
+					      F81232_GET_REGISTER,
+					      reg,
+					      0,
+					      val,
+					      size,
+					      USB_CTRL_GET_TIMEOUT,
+					      GFP_KERNEL);
+		if (status) {
+			status = usb_translate_errors(status);
+			if (status == -EIO)
+				continue;
+		}
+
+		break;
+	}
+
+	if (status) {
+		dev_err(&intf->dev, "failed to get register 0x%x: %d\n",
+				reg, status);
+	}
+
+	return status;
+}
+
 static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf, bool en)
 {
 	unsigned char enable[2] = {0};
@@ -869,6 +904,29 @@ static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf, bool en)
 	 * bit 0~11	: Serial port enable bit.
 	 */
 	if (en) {
+		/*
+		 * The Fintek F81532A/534A/535/536 family relies on the
+		 * F81534A_CTRL_CMD_ENABLE_PORT (116h) register during
+		 * initialization to both determine serial port status and
+		 * control port creation.
+		 *
+		 * If the driver experiences fast load/unload cycles, the
+		 * device state may becomes unstable, resulting in the
+		 * incomplete generation of serial ports.
+		 *
+		 * Performing a dummy read operation on the register prior
+		 * to the initial write command resolves the issue.
+		 *
+		 * This clears the device's stale internal state. Subsequent
+		 * write operations will correctly generate all serial ports.
+		 */
+		status = f81534a_ctrl_get_register(intf,
+						F81534A_CTRL_CMD_ENABLE_PORT,
+						sizeof(enable),
+						enable);
+		if (status)
+			return status;
+
 		enable[0] = 0xff;
 		enable[1] = 0x8f;
 	}
-- 
2.34.1


