Return-Path: <linux-kernel+bounces-808155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AAEB4FAE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5517B5E21D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3F33A03E;
	Tue,  9 Sep 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O4ZSzGJG"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4D338F58
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421050; cv=none; b=fYQycFPBNB9B9ci31dJq5qB4iyfX7gFbSBIyLzXzO2O8Xk0GRcMb/tTA92SoSNRTSy67m4G7vRNnEeQxYbtc5H6dKK+Cjwh6S/o1DBTzjkDI+nvJ/ghaq1YSaq1fySuODf17Zb1U0sy4O8RpCoE1BR26aDDliDegaozYnKgTwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421050; c=relaxed/simple;
	bh=nvs2gDcjL6C8NXVm+Q+MwxkLZX3yRe9EVozIv1TgODA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMTcQPSvnjqjjXzUMcrwkDsZutqeuQmlHFGrPOH/aPbO9akDiCqqjBomMxz2hL/2THm1JYarl35nyOLYHzEWn3P1qoSqcyOCWJwDBsu/wdCDq8N2IGs0bW2x2lFvsi4YtXPWhrPDX+9mY6a/YWkigPrAsi9zzdAcMhEstydYaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O4ZSzGJG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b00a9989633so168600266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757421047; x=1758025847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WMeag17a1l945PqdAkCvwljw0rC07igvRdu/jbhGyo=;
        b=O4ZSzGJGE+qIUVIKHbi9EKJMkHR4OcfJyj1dStQ6Cish+IHffHfxdLh7GSfs2QJf3Y
         f51jcXko35kbky9zXTCXkly7VGpWNTK4DPsuVUWZQ+klOesbEEOr3jmyyRtaF7KA9HYW
         RJIVrwkvlRWzqABNiw90W6e+Onhuc2kYNlEDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421047; x=1758025847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WMeag17a1l945PqdAkCvwljw0rC07igvRdu/jbhGyo=;
        b=ZcefTx8ZNR8QlANXxoRCVdLzW0I40QNP9AyH63cUkwquOzN+olpAi1OPbsuarmZGAS
         sFmb7ZuzcU5rlP5GvpFf36Ue9ZU0MWqc/qYPn48X7Tx0tnpSNrURkuR+gXtiPwqdBTtW
         KClmj902v6qmoK+YJTSllYs96Qnxa2dVc5lZIVbPl3PSJgMELPor9SotpiPNPztUupwz
         Jq6gDxPH/gtYTKJFWMQAlRmwUSd8BkE7a64e59dAgw7KHEKz1Ba87+OlRhk9F5NtnEnq
         G7iPHAsAQ93WRJDScDI/82k1Ffhmio8S/+EXO15w092LcZGGT0uTUkg0v99Jq4VggWjx
         8k8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWl9rZRAyf34Su6LyjAwaTNANn6qCsx//LilLGOEJ8W0NQovhdcg4WAuUFrIYXwDnUj0uiN1qSwpTcgt4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZsYfqTtIHrnxMRQR60D2Bau/r9S5PpPbKwrEIT95aXlPQOq/
	ThdVcO3G0qWByINOPim/JmghMWY+YnhAhFZjx8etjQ5qvXEO1L1vHYHrcWeZhb2cBw==
X-Gm-Gg: ASbGnctUirFkXbDWUMwD9W0Kl7j1B74Sw/rDBdLVruvcr8cU3M/yitlkiDZ6f5zyT3C
	KkvzvJstG9SiiHZKc4RaJQatZ9SpWdlu7qT6twyrbhHn/2ZxPQXD+WmSB8g5KGxGRIL+fiy/YKA
	dkoaVtuks3RPau3hKL8G1PirXXV7XtFvMCBw58g+XNAPv6CoNUZROrn2o9eu1GP8TgXwQw61/X6
	VEkKfzbz3m033m3Wbsi5XJ5wHe+y3gc7hdXUTekwq6Q4Wq/vtUdCmIUQNdix0SiVomMVQL6pm/6
	Ergne4w8CJ07Cj9ftK6uQmIaaFNHdkx//QCWkVOl66Cg2J4isJtkT62uD5ngPdAGHpnmJPqmvlf
	YgGzhmNvv2HeQw4g7S+pOsDHrgrC7U5XdDP4zT1dIO/LqJSZUQbJ26InKAq3tcpEgVMih0oB3C8
	LptIOSMnZPSdv33itUHC2pzFHqrw==
X-Google-Smtp-Source: AGHT+IFhBrHiIKFQDuEGLUi8nmmT8pVqq//MniH5jqrxhg+sNjRz6k9qHyzIb5oAJzhfDrVeqxv60A==
X-Received: by 2002:a17:907:c2a:b0:b04:2c2e:50a5 with SMTP id a640c23a62f3a-b04b1f0d207mr1522958966b.16.1757421046612;
        Tue, 09 Sep 2025 05:30:46 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm2409702166b.12.2025.09.09.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:30:46 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH RFC 3/5] usb: typec: Report altmode entry status via callback
Date: Tue,  9 Sep 2025 12:30:26 +0000
Message-ID: <20250909123028.2127449-4-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250909123028.2127449-1-akuchynski@chromium.org>
References: <20250909123028.2127449-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Type-C mode selection logic requires feedback on the result of an
alternate mode entry attempt.
Call the `typec_mode_selection_altmode_complete()` callback to provide
this final success or failure status.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/altmodes/displayport.c | 19 +++++++++++++++++--
 drivers/usb/typec/altmodes/thunderbolt.c | 10 ++++++++++
 include/linux/usb/typec_dp.h             |  2 ++
 include/linux/usb/typec_tbt.h            |  3 +++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 1dcb77faf85d..052d18b54f0a 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -293,16 +293,20 @@ static void dp_altmode_work(struct work_struct *work)
 		header = DP_HEADER(dp, svdm_version, DP_CMD_STATUS_UPDATE);
 		vdo = 1;
 		ret = typec_altmode_vdm(dp->alt, header, &vdo, 2);
-		if (ret)
+		if (ret) {
 			dev_err(&dp->alt->dev,
 				"unable to send Status Update command (%d)\n",
 				ret);
+			typec_altmode_entry_complete(dp->alt, ret);
+		}
 		break;
 	case DP_STATE_CONFIGURE:
 		ret = dp_altmode_configure_vdm(dp, dp->data.conf);
-		if (ret)
+		if (ret) {
 			dev_err(&dp->alt->dev,
 				"unable to send Configure command (%d)\n", ret);
+			typec_altmode_entry_complete(dp->alt, ret);
+		}
 		break;
 	case DP_STATE_CONFIGURE_PRIME:
 		ret = dp_altmode_configure_vdm_cable(dp, dp->data_prime.conf);
@@ -371,6 +375,7 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 	int cmd_type = PD_VDO_CMDT(hdr);
 	int cmd = PD_VDO_CMD(hdr);
 	int ret = 0;
+	int entry_result = 0;
 
 	mutex_lock(&dp->lock);
 
@@ -414,10 +419,14 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 		switch (cmd) {
 		case DP_CMD_STATUS_UPDATE:
 			dp->state = DP_STATE_EXIT;
+			if (vdo)
+				entry_result = *(int *)vdo;
 			break;
 		case DP_CMD_CONFIGURE:
 			dp->data.conf = 0;
 			ret = dp_altmode_configured(dp);
+			if (vdo)
+				entry_result = *(int *)vdo;
 			break;
 		default:
 			break;
@@ -432,6 +441,12 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 
 err_unlock:
 	mutex_unlock(&dp->lock);
+
+	if (!entry_result)
+		entry_result = ret;
+	if (entry_result || cmd == DP_CMD_CONFIGURE)
+		typec_altmode_entry_complete(dp->alt, entry_result);
+
 	return ret;
 }
 
diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
index 6eadf7835f8f..765ba7348ac4 100644
--- a/drivers/usb/typec/altmodes/thunderbolt.c
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -214,6 +214,7 @@ static int tbt_altmode_vdm(struct typec_altmode *alt,
 	struct typec_thunderbolt_data data;
 	int cmd_type = PD_VDO_CMDT(hdr);
 	int cmd = PD_VDO_CMD(hdr);
+	int entry_result = 0;
 
 	mutex_lock(&tbt->lock);
 
@@ -248,6 +249,12 @@ static int tbt_altmode_vdm(struct typec_altmode *alt,
 		switch (cmd) {
 		case CMD_ENTER_MODE:
 			dev_warn(&alt->dev, "Enter Mode refused\n");
+			if (vdo)
+				entry_result = *(int *)vdo;
+			break;
+		case TBT_CMD_STATUS_UPDATE:
+			if (vdo)
+				entry_result = *(int *)vdo;
 			break;
 		default:
 			break;
@@ -262,6 +269,9 @@ static int tbt_altmode_vdm(struct typec_altmode *alt,
 
 	mutex_unlock(&tbt->lock);
 
+	if (entry_result || cmd == TBT_CMD_STATUS_UPDATE)
+		typec_altmode_entry_complete(alt, entry_result);
+
 	return 0;
 }
 
diff --git a/include/linux/usb/typec_dp.h b/include/linux/usb/typec_dp.h
index acb0ad03bdac..c9fa68cd1265 100644
--- a/include/linux/usb/typec_dp.h
+++ b/include/linux/usb/typec_dp.h
@@ -44,10 +44,12 @@ enum {
  * commands: Status Update and Configure.
  *
  * @status will show for example the status of the HPD signal.
+ * @error will contain the error code, if applicable.
  */
 struct typec_displayport_data {
 	u32 status;
 	u32 conf;
+	int error;
 };
 
 enum {
diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
index 55dcea12082c..57cbda5292bb 100644
--- a/include/linux/usb/typec_tbt.h
+++ b/include/linux/usb/typec_tbt.h
@@ -24,6 +24,9 @@ struct typec_thunderbolt_data {
 	u32 enter_vdo;
 };
 
+/* TBT3 alt mode specific commands */
+#define TBT_CMD_STATUS_UPDATE		VDO_CMD_VENDOR(0)
+
 /* TBT3 Device Discover Mode VDO bits */
 #define TBT_MODE			BIT(0)
 #define TBT_ADAPTER(_vdo_)		FIELD_GET(BIT(16), _vdo_)
-- 
2.51.0.384.g4c02a37b29-goog


