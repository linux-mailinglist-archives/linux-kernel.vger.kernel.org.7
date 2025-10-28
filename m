Return-Path: <linux-kernel+bounces-873785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE3EC14B70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AE13BF66A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F165D32ED52;
	Tue, 28 Oct 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5lmB8IL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8E31770F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655941; cv=none; b=EJwZPGRKvudbsVx1PTVgXWVDKpCF+8/gNPNqCxNFihV1/ttNTK6Pf2418Cy318ocPXLhRMXfmEbjaPspfxjPbyEjJ/bXykMobGR4WJEh1+mmcuCPsro9860lpfVELgDtQW7enT+EtaRPgBuZme1TOKzP70iAd7CU4SCQ3xWVJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655941; c=relaxed/simple;
	bh=19Aw2e3syKvL7oQUEOvzHNrGapjCIBdFH4EzxMLy+/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UbLJfzIsa+c/A+HbS99uLy87aWWqMCKJ4DI7N7f4sHYSyONrDEDRnCkdjqTGdz3xIto66u1XcVjBGXmdcGdJ1y2RkqBaiaM+BQCTS0SGIyKT90uPM3tm6GysFePtU+9DU8gL8I8KJAOg1s9uQu03ehv4XjRuAuSuuH2koHWITR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t5lmB8IL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4710665e7deso31212545e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761655937; x=1762260737; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uiFbGd4UbNp+KeVPTy2XKkvgsMstWdXWxCkfgt0Ii14=;
        b=t5lmB8ILCzcCo0kZkm/Rpy4ganugVM9zz1PxtEAQjtll187v0KRCpTJAjfQLqfVLP/
         aMEW/QftyP3ypGLTt+2QcWKU8E2o8kpGk7B0k03zF+fWgcQJbCCgd3vZBT/s8+fCv3ZD
         ExruTv6usUZJpSp0D9V9xRuyD+TVjVAAYKpAnVFvFMhtLrfNUYlCrq/T/DHy8YaGu70T
         U+/rFkHXVkxNn49TZIwkQu7H9c1yqIxgXTP6R5x4NnWhmcoZxL5piwLOQe0iNC2OxaDB
         yucy4XE1LqGtKLgpk17pLJfYfZQTgyiQ4jvRkUkDlKtulx9PkX29A1z7bMjyMc51dCql
         wYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761655937; x=1762260737;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiFbGd4UbNp+KeVPTy2XKkvgsMstWdXWxCkfgt0Ii14=;
        b=A+x4k8bhNMa+2chlxW/kGGIEACq3y8uQpvAuPzqzsVgo3XSq8fZiDAF9nl1o3DjQf5
         Te0yzDfLi7flrBfR0VJkxA5Q6zapl8f6k+7xee3uvzi+izQCsMSRMdiXXCkewHBYuZUW
         pGHnlnNe+Nz5KvNjLi8ProdhIMk85V/K6lBEAEF5DmzYZMuGGP+X8vazxcsnJwRhqn5f
         XLowuZ7KcekMrDwzjSskAXwnxeqN2GNA2tv88RuqMWf5CDGf3AdOenu0Dx+RJazG1xwo
         R9GfCphoTVZCSKvO+2hh7xQeKktlLF71Zz7BiTbLSb3oLmqvoRGqHaqpc1O635Rfu61s
         DvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNAe3/wzhYcFd12GxP5tktwDMat1/aDR9hgnVNtVa918mXAkFdxeCVUnvOYbkvvAu5eZBy32he8YZiozY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPSw3MqlfXDTxTYUNiRrvLI2Ez8yFdtgyXaa8sGMOIzmfUVCO
	1cwGTIjSH/bFQ1XmSAEUrF+HOVWbh+w2yL3j3L1aH8OkFQ9UUHWOL3CHULWt9jwrQifblHB4VQy
	a2rdW
X-Gm-Gg: ASbGnctyuevhaNA3QKM0LnKiwNqT99G6fRXM7lDyZvzIef4CEW1XbFlEZlXHrpGgWII
	pg7Nl9CLCRkGluO8u2rWz55APo2ZaovFFjgx7Vq8D3pbNiLluaaRDKFcw+qheey5tXb83lgSs4Z
	cAD0nCpHbB06sK+Fh3EdgH3V9dXsJhqSNDKtpMxa0tYaab7WLmdKSyYdzsDDnFXkEy8fFFI5DUR
	AVE2dxw+JsqxMzq2HLOwfbQNKLj7VSL4hBCzZaRDn2uNNzWRhjtPgKCVoSwvTThpwT1IYLPMOvW
	Fw12sxqTYpF+ZzBpVovDQAJoVDQZJB9ubp10ys/VlgjfhWJzdgh8p7SEHoeLwi/nRQ6tCYWrxRV
	0mcjEBPznjS+tTbDV1ZLhiaqDqxXrylpNj6ihXvqJCctnp0/YuwnFPZXHK5Y/uJpuxEUDxarcfQ
	==
X-Google-Smtp-Source: AGHT+IHegn1qI4Kn9PvxJhv6Hp8XHuri1BwXoTpbjFFuvvKl85oIEEM0HrKmuYa1l6KMovMnyZOCYQ==
X-Received: by 2002:a05:600c:3b14:b0:475:dd9a:f786 with SMTP id 5b1f17b1804b1-47717e7ab64mr27833225e9.40.1761655937047;
        Tue, 28 Oct 2025 05:52:17 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd478202sm193697355e9.14.2025.10.28.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 05:52:16 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 28 Oct 2025 14:52:12 +0200
Subject: [PATCH v2] usb: typec: ucsi: Add support for orientation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-usb-typec-ucsi-orientation-v2-1-9330478bb6c1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHu8AGkC/42NQQqDMBBFryKz7pQkRaxd9R7FRYwTHSiJJFEq4
 t079QTlr96H//4OmRJThke1Q6KVM8cgYC4VuMmGkZAHYTDK1FrpGpfcY9lmcri4zBhlHYotMsO
 mpkFZ41rvbyCCOZHnzyl/dcIT5xLTdn6t+tf+pV01Su5u0Kr1veqb55uDTfEa0wjdcRxfnmk4X
 cUAAAA=
X-Change-ID: 20251015-usb-typec-ucsi-orientation-75ed0a2c9ff3
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=19Aw2e3syKvL7oQUEOvzHNrGapjCIBdFH4EzxMLy+/c=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpALx+5NxQ8m+JVMkVpgW22EAhwxn4LDIWRCrrN
 5eYiQGLQaKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQC8fgAKCRAbX0TJAJUV
 VmzQEADNH1s3sHmGwJIeFwm7fYJvYFBI1tWsjCUM2E84uqXBeW0hxNNyZGX6Cb+P9FdlVjHHOPJ
 JW8R+s/pZ2u/UXP2CipODaSKs2HuOolsSbn11X1TXhYIyDAHBMLbWkqp+1IsmTOkP+O1sk1Z12q
 Ifdt18jBElyKMEbgqiMlbrSxc0sAx68oBlSqiB8ifIoBbv7zr6+Hny8T12CRilDJGqv3WTmwid4
 oGh2esBl+B42NS4KD0Dd3PXC1YbJS6dUNqmW6HtqQ5Ml9l4UkiEqFzvPtek0g3Tx9BxHk4CcZhJ
 dWzq4Ka8X609tudquzkTj8tsvfRVtzP9ie6HWh59CzJ5YgBAY5yyuql594X+6+x2T60kGJlCzpI
 dw5CCLAnamfyljdTGyVZMUckf06HObHKVgsr6gBNII2awQ0INY/GoIA2azP2zrHG1B2LrnCFPhs
 mN1UgZIQx1qcKfOFmp+OGhkCJwBylVCyco1pCETsKr7/uf1kRbjFkfw99eFixj3qI6fJjMM5Zi3
 74drFg9Ov2iBzeyUnnbVeXrJJ7w6Jk+ZMv9n9k1tkB3VVMuBDYDz72ASCFyt5kzMT7u25i8djaH
 MPspvInBJrYFfluMep98jE8Hyd11vdfjCHsHaeKsIDmYkcv2gy/AsERsALP7ejJqudybFSK6CPX
 gP1ibgMicArOwjw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

According to UCSI 2.0 specification, the orientation is
part of the connector status payload. So tie up the port
orientation.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Respinning as proper patch.

Changes since RFC:
- Picked-up Hiekki's R-b tag
- Link to v1: https://lore.kernel.org/r/20251015-usb-typec-ucsi-orientation-v1-1-18cd109fb0b7@linaro.org
---
 drivers/usb/typec/ucsi/ucsi.c | 24 ++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 3995483a0aa097b822046e819f994164d6183b0d..17439ec434d41d24e8e4c7a97d7e6117fd07d950 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1008,6 +1008,28 @@ static int ucsi_check_connector_capability(struct ucsi_connector *con)
 	return ret;
 }
 
+static void ucsi_orientation(struct ucsi_connector *con)
+{
+	if (con->ucsi->version < UCSI_VERSION_2_0)
+		return;
+
+	if (!UCSI_CONSTAT(con, CONNECTED)) {
+		typec_set_orientation(con->port, TYPEC_ORIENTATION_NONE);
+		return;
+	}
+
+	switch (UCSI_CONSTAT(con, ORIENTATION)) {
+	case UCSI_CONSTAT_ORIENTATION_NORMAL:
+		typec_set_orientation(con->port, TYPEC_ORIENTATION_NORMAL);
+		break;
+	case UCSI_CONSTAT_ORIENTATION_REVERSE:
+		typec_set_orientation(con->port, TYPEC_ORIENTATION_REVERSE);
+		break;
+	default:
+		break;
+	}
+}
+
 static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 {
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
@@ -1258,6 +1280,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		typec_set_pwr_role(con->port, role);
 		ucsi_port_psy_changed(con);
 		ucsi_partner_change(con);
+		ucsi_orientation(con);
 
 		if (UCSI_CONSTAT(con, CONNECTED)) {
 			ucsi_register_partner(con);
@@ -1690,6 +1713,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		typec_set_pwr_role(con->port, UCSI_CONSTAT(con, PWR_DIR));
 		ucsi_register_partner(con);
 		ucsi_pwr_opmode_change(con);
+		ucsi_orientation(con);
 		ucsi_port_psy_changed(con);
 		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
 			ucsi_get_partner_identity(con);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index e301d9012936fb85eaff7f260a862ff099eb77c5..c85175cd001487fa9d66076e608e098d236f5275 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -360,6 +360,9 @@ struct ucsi_cable_property {
 #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
 #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
 #define UCSI_CONSTAT_PD_VERSION_V1_2		UCSI_DECLARE_BITFIELD_V1_2(70, 16)
+#define UCSI_CONSTAT_ORIENTATION		UCSI_DECLARE_BITFIELD_V2_0(86, 1)
+#define   UCSI_CONSTAT_ORIENTATION_NORMAL	0
+#define   UCSI_CONSTAT_ORIENTATION_REVERSE	1
 #define UCSI_CONSTAT_PWR_READING_READY_V2_1	UCSI_DECLARE_BITFIELD_V2_1(89, 1)
 #define UCSI_CONSTAT_CURRENT_SCALE_V2_1		UCSI_DECLARE_BITFIELD_V2_1(90, 3)
 #define UCSI_CONSTAT_PEAK_CURRENT_V2_1		UCSI_DECLARE_BITFIELD_V2_1(93, 16)

---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251015-usb-typec-ucsi-orientation-75ed0a2c9ff3

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


