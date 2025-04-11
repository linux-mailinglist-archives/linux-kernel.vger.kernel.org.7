Return-Path: <linux-kernel+bounces-600386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359FEA85F43
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 15:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636BF8C1952
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA201F30AD;
	Fri, 11 Apr 2025 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKzqLkNH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A41F180E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378425; cv=none; b=WUL+oOv95LQPsfJHBcpNrNVpRHj9J94b1OnUyi0uhTJ84lUY4rW+79Gex75/HwzbD0jiJUy7DhOIaMkUd7NzWLu9YAfELLWSmBFvw+XFuLCf8RZT10Td40Tx1Bif6yVsT7ianykIOUvl5LoUkjgJwbhmERzUK+I1jcngGrHGQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378425; c=relaxed/simple;
	bh=ImVraYJoSpGjrPdo+CgWPlhNhED0L8tXQpbDhIoHXIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o3FmPeJ+qSknbftvo1fhSMWlRRxRLNI6JUOOc+IJCdgoptynEpZ6YRITmeCGHpx40eQ2jz8A5NL7Qshc/HQ1uX45xCCMIUwJv4GXxrD10yZ41se5mILcsbv5uqt0lbguJO4uqkixGaBI4cHEBQEEn3sOJKGSv7a2syE0RN7+s/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKzqLkNH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227e2faab6dso17842405ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744378423; x=1744983223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdfVUVFRQYjBK/01xLDQ9Mx3Y9OX91FGkhTOpiGrnEQ=;
        b=MKzqLkNH1pwo+MFDrYmR8kc0fHij9ivb8EdOcHOenH9wGtVRy2UwqpIGtwPWlkvbPh
         axuf0x3GCIqgepdBQLYvcRebixzrSaNXcxyCOpMxQ6xHpneLzxNLoYfRNH0d+kSUK/2/
         eYeaVak9C16cjeiyC6TVggx+lEC9ACooBr1RwnSHjqkhHVp/tgAvmb9cNJdmHLxyPVYT
         tvgos/nKDWpn+JIJ0vf4S8CdibSHCtTcOgZ5FI0wxMy5hhOEf/MObauqEtmn7yt2eEHF
         KotVzl6WFcGKerbvfO+xn/j2KCa3RBymjWN6wxY7vN6ErSCH/4IdZQOrBb3093KTgI2C
         Ou1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744378423; x=1744983223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdfVUVFRQYjBK/01xLDQ9Mx3Y9OX91FGkhTOpiGrnEQ=;
        b=fC4HJtb4ieYSg2eKSqw8knRy1Lc0Qkfy9G2BNLKlt1euL7z7KWqAr6OF9LflEuiIqO
         aiRqkQYWk8/4436MEiNuHkKKHBnxdRtNq5jzMT6hzl3EyuG7eKdcF/4D/X/TWF4g+PIB
         YmnaT5VpWhUSjaBfsKsGXYjcnsAq4HFBHyTet8Dbi3DolGzMptFK9LD51akciHpJRRbH
         ZDHJenKX+zn4WIraqod0Kvz8Q66zgxE4brtb2Yu49hQAiGt6ylV/dprbZ1/zcaQYOXDy
         3LK5Vif4KOBNMFLK/Bnd7C2WbMt2gCkwJK1YU5HsgkUF+zmXeIELGHu/j6wBhZqafk/R
         X+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzC3ne6Bd+Y/LtY/fk1BgZIIcmUUtToATtE+u+Vfi+Hr4CbaR+RVOHK5ayk1yYWdEg2JHm7UM42z1XP1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBp/3xhNW4LGZbmDlxAguOOj3PRCNpqxn1czgJn4l3HeJPkZ5b
	RyZTT5tvJV8esHNe3ff/sPebL24JH/hwi7ZsoYB6Npet/Lzr30KOguItWQccnrBHh2mCiNP7RY5
	+1KIBxQ==
X-Google-Smtp-Source: AGHT+IEF+fSOwHK7wU6yaH32x4GQLhOShNCqgwQ08U7Quc4eDFxVeskDxy5SHjTxtCmFn6TSr+Bm8LLVuUgI
X-Received: from plhn6.prod.google.com ([2002:a17:903:1106:b0:216:32ca:3f1f])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68a:b0:216:53fa:634f
 with SMTP id d9443c01a7336-22bea4fdf49mr40684125ad.48.1744378423021; Fri, 11
 Apr 2025 06:33:43 -0700 (PDT)
Date: Fri, 11 Apr 2025 21:33:06 +0800
In-Reply-To: <20250411133330.171563-1-chharry@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250411133330.171563-1-chharry@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411133330.171563-2-chharry@google.com>
Subject: [PATCH 2/4] Bluetooth: btusb: Add HCI Drv commands for configuring altsetting
From: Hsin-chen Chuang <chharry@google.com>
To: luiz.dentz@gmail.com
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send out
SCO data through USB Bluetooth chips, it's observed that with the patch
HFP is flaky on most of the existing USB Bluetooth controllers: Intel
chips sometimes send out no packet for Transparent codec; MTK chips may
generate SCO data with a wrong handle for CVSD codec; RTK could split
the data with a wrong packet size for Transparent codec; ... etc.

To address the issue above one needs to reset the altsetting back to
zero when there is no active SCO connection, which is the same as the
BlueZ behavior, and another benefit is the bus doesn't need to reserve
bandwidth when no SCO connection.

This patch adds "Supported Altsettings" and "Switch Altsetting" commands
that allow the user space program to configure the altsetting freely.

This patch is tested on ChromeOS devices. The USB Bluetooth models
(CVSD, TRANS alt3, and TRANS alt6) could pass the stress HFP test narrow
band speech and wide band speech.

Cc: chromeos-bluetooth-upstreaming@chromium.org
Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 drivers/bluetooth/btusb.c | 70 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a33c6b9f8433..fcaee5cd728b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3755,12 +3755,29 @@ static ssize_t isoc_alt_store(struct device *dev,
 
 static DEVICE_ATTR_RW(isoc_alt);
 
+#define BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS   HCI_DRV_OP_DRIVER_SPECIFIC_BASE
+#define BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE 0
+struct btusb_hci_drv_rp_supported_altsettings {
+	__u8	num_supported_altsettings;
+	__u8	supported_altsettings[];
+} __packed;
+
+#define BTUSB_HCI_DRV_OP_SWITCH_ALTSETTING   (HCI_DRV_OP_DRIVER_SPECIFIC_BASE+1)
+#define BTUSB_HCI_DRV_SWITCH_ALTSETTING_SIZE 1
+struct btusb_hci_drv_cmd_switch_altsetting {
+	__u8	new_altsetting;
+} __packed;
+
 static const struct {
 	u16 opcode;
 	const char *desc;
 } btusb_hci_drv_supported_commands[] = {
 	/* Common commands */
 	{ HCI_DRV_OP_READ_INFO, "Read Info" },
+
+	/* Driver specific commands */
+	{ BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS, "Supported Altsettings" },
+	{ BTUSB_HCI_DRV_OP_SWITCH_ALTSETTING,     "Switch Altsetting" },
 };
 static int btusb_hci_drv_read_info(struct hci_dev *hdev, void *data,
 				   u16 data_len)
@@ -3793,11 +3810,62 @@ static int btusb_hci_drv_read_info(struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int btusb_hci_drv_supported_altsettings(struct hci_dev *hdev, void *data,
+					       u16 data_len)
+{
+	struct btusb_data *drvdata = hci_get_drvdata(hdev);
+	struct btusb_hci_drv_rp_supported_altsettings *rp;
+	size_t rp_size;
+	int err;
+	u8 i;
+
+	/* There are at most 7 alt (0 - 6) */
+	rp = kmalloc(sizeof(*rp) + 7, GFP_KERNEL);
+
+	rp->num_supported_altsettings = 0;
+	if (drvdata->isoc)
+		for (i = 0; i <= 6; i++)
+			if (btusb_find_altsetting(drvdata, i))
+				rp->supported_altsettings[
+					rp->num_supported_altsettings++] = i;
+
+	rp_size = sizeof(*rp) + rp->num_supported_altsettings;
+
+	err = hci_drv_cmd_complete(hdev, BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS,
+				   HCI_DRV_STATUS_SUCCESS, rp, rp_size);
+	kfree(rp);
+	return err;
+}
+
+static int btusb_hci_drv_switch_altsetting(struct hci_dev *hdev, void *data,
+					   u16 data_len)
+{
+	struct btusb_hci_drv_cmd_switch_altsetting *cmd = data;
+	u8 status;
+
+	if (cmd->new_altsetting > 6) {
+		status = HCI_DRV_STATUS_INVALID_PARAMETERS;
+	} else {
+		if (btusb_switch_alt_setting(hdev, cmd->new_altsetting))
+			status = HCI_DRV_STATUS_UNSPECIFIED_ERROR;
+		else
+			status = HCI_DRV_STATUS_SUCCESS;
+	}
+
+	return hci_drv_cmd_status(hdev, BTUSB_HCI_DRV_OP_SWITCH_ALTSETTING,
+				  status);
+}
+
 static const struct hci_drv_handler btusb_hci_drv_common_handlers[] = {
 	{ btusb_hci_drv_read_info,	HCI_DRV_READ_INFO_SIZE },
 };
 
-static const struct hci_drv_handler btusb_hci_drv_specific_handlers[] = {};
+static const struct hci_drv_handler btusb_hci_drv_specific_handlers[] = {
+	{ btusb_hci_drv_supported_altsettings,
+				BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE },
+	{ btusb_hci_drv_switch_altsetting,
+				BTUSB_HCI_DRV_SWITCH_ALTSETTING_SIZE },
+};
 
 static struct hci_drv btusb_hci_drv = {
 	.common_handler_count	= ARRAY_SIZE(btusb_hci_drv_common_handlers),
-- 
2.49.0.604.gff1f9ca942-goog


