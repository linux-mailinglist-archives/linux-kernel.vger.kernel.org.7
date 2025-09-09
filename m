Return-Path: <linux-kernel+bounces-808157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710EB4FAE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE575E1C51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F33633EB04;
	Tue,  9 Sep 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O2bJOfDx"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96133CEBC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421057; cv=none; b=YOSuglZL7e1EQ0IMbZ+bS0jM4kq3Y2+pOWnv5+3OCngZDZCHTjJo0BarhyNegtkMtjrT8bLnv/R43bt4wyDiIJiTGa237sB2zqIQ9VWCqtoRwWsWRSfuDPBvp2s1YXA4WxPhCWpLCE005QauwB2SVOpAfJxX/VY9R0xHXCEMMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421057; c=relaxed/simple;
	bh=gg5T3nQ5VEwTdUPyYWVvxapRzmVgBSdtJ8K+4Q49glA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/A9rJSWeFKtsKzpWrUE+xuC0Nv7r0hOZxyTu+6fWX9iy7nuvNEOPARbNP9XV3Ita1cd3wApDvwVzZE5OLXpszhLo61S1sNN60MlCJ0gifa0KAKl3EjFkoNz5yk5tanAelCKULx7TRlEgjFpd+QyyqXsS5gcnv4zwT2w9RZLSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O2bJOfDx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b04b869abb9so445193566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757421054; x=1758025854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNT/Kw+T/4QMdMG2OTf9bXi1NzKMHFpMs7iCOhh/C34=;
        b=O2bJOfDx7p2FU0M224/tMkwabpPtl7eI92bdAVAwgGeup2SFh5ciDsMvdN5TXhBarv
         QWCDtWPsB8KtauymC7CUjbPKFg9AXaGbloXaL+R+lC94DiEwDcS5XOxZ7+B96HDHi3IG
         pDEqZ0+GkamvSooB31wWM6V54KmySo5mTnqlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421054; x=1758025854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNT/Kw+T/4QMdMG2OTf9bXi1NzKMHFpMs7iCOhh/C34=;
        b=Xktl2HhZlxdm6g0yr0aNu2KgcIKhXJRFbBtmp7l2zzVdnBd+iBcWcz7r7Kgik27V/z
         xyaiCy2XDzNvCG2STC1dK10Q0kjFOiaSIPvAh35VDKIjm4wL9h4WwSo9qD8ZIkg1tg5i
         V4h3OAM1H2iILGKZj10k0o18FIw8+Rq4p08dplRbMOXsjSbNKpceayjiGVSMvXWI7McQ
         BZ76iyhZy9SqGUpCzaZ2NxqjhfQ7f8VfgZ4JhQMa1tPkJ49VK/R1VNrnrWMXnMJtQZZ0
         h4iT0ESEQEr/ZMuAIogoj11p2lvY9JWFSHpEHogizgo/XXpCBPnHAPLH/8eAHp7klell
         93Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ru6Yyx7khaFsgewSO4h4df9KRdqwSrenPBZaoTVzS0KwDVJMHr7gdAA5+ndjkl3iqPIQ2JsWihE0fD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbfh4rO8Hozzy0aA5Qm+leXnyDKwffdeVEEkYCD+pgNQ506NI/
	kE5LBc6DesYCRUzm9uHAOx1BWOstey3D+JAcFLWfm2CmSZzz3KEgL2nGnhhtfVRJ8w==
X-Gm-Gg: ASbGncvyx6U6KRbJb34zVY3+W1UWBnYmHaErroT3D4jUclFx93t7XaqOg2nRLTvES9s
	K7YHlaVvsA5UpuWNZ7XGPITLu3dfSm2bzWh+yrUEzv70Rla27poq94s4z9t/EwPHzIw2sQd9T3+
	2OWJaIqtu2FJmr2t5vPaczsK+vhvVVKoQ/5SSEkwl38/LPwUxC7AxENoWtoaYfBF+xkrN9OWLHT
	91MvMrEY5WhpcuGIBuAcH/Nca+1AMWhwI4CsiW7BGpUmMJkF91vRFsWC7ZzGfYIRgJbiGq4+F8u
	EUN94XBJ26cxtjhJEYNT2RMLd2wrMyzB3bVccvScKqoOAgvv3ybOWHLOMWoQGgXBYgzizsDl2+d
	JT5umbsGk7GCpvaJor2JS4C0z1YDFae53B4zCDDwhzLRcl6DkqonzTHOd7jZHpSNPWt6APHVTPk
	3y1FGDF+/0CfKhLghMQpW0MBr/tg==
X-Google-Smtp-Source: AGHT+IFl1zU3QtNbYbaVd7tuOLAD+b+6Y5jT0xWKmoM/3PaJcYRD7JjPcvpNTsrUunsVw5t/BWWYbA==
X-Received: by 2002:a17:907:6d0d:b0:ae3:8c9b:bd61 with SMTP id a640c23a62f3a-b04b13fb3d7mr1122786466b.12.1757421053733;
        Tue, 09 Sep 2025 05:30:53 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm2409702166b.12.2025.09.09.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:30:53 -0700 (PDT)
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
Subject: [PATCH RFC 5/5] platform/chrome: cros_ec_typec: Propagate altmode entry result
Date: Tue,  9 Sep 2025 12:30:28 +0000
Message-ID: <20250909123028.2127449-6-akuchynski@chromium.org>
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

In the `cros_typec_configure_mux` function, which concludes the DP/TBT
alternate mode entry, the error code should be reported back to the Type-C
mode selection logic. This ensures a detailed result is conveyed to user
space. To inform partner drivers about the result, the VDM mechanism is
used: DP_CMD_STATUS_UPDATE for DP altmode and TBT_CMD_STATUS_UPDATE for
TBT altmode.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c      |  9 ++++++
 drivers/platform/chrome/cros_typec_altmode.c | 32 ++++++++++++++++++--
 drivers/platform/chrome/cros_typec_altmode.h |  6 ++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index c0806c562bb9..18e627c9fc22 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -693,6 +693,7 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	if (!ret)
 		ret = typec_mux_set(port->mux, &port->state);
 
+	dp_data.error = 0;
 	if (!ret)
 		ret = cros_typec_displayport_status_update(port->state.alt,
 							   port->state.data);
@@ -782,8 +783,16 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 		ret = cros_typec_enable_usb4(typec, port_num, pd_ctrl);
 	} else if (port->mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
 		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
+		cros_typec_tbt_status_update(
+			port->port_altmode[CROS_EC_ALTMODE_TBT], ret);
 	} else if (port->mux_flags & USB_PD_MUX_DP_ENABLED) {
 		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
+		if (ret) {
+			struct typec_displayport_data dp_data = {.error = ret};
+
+			cros_typec_displayport_status_update(
+				port->port_altmode[CROS_EC_ALTMODE_DP], &dp_data);
+		}
 	} else if (port->mux_flags & USB_PD_MUX_SAFE_MODE) {
 		ret = cros_typec_usb_safe_state(port);
 	} else if (port->mux_flags & USB_PD_MUX_USB_ENABLED) {
diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
index 557340b53af0..75c7e6af1320 100644
--- a/drivers/platform/chrome/cros_typec_altmode.c
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -28,6 +28,7 @@ struct cros_typec_altmode_data {
 
 	u16 sid;
 	u8 mode;
+	int error;
 };
 
 struct cros_typec_dp_data {
@@ -295,9 +296,16 @@ int cros_typec_displayport_status_update(struct typec_altmode *altmode,
 
 	dp_data->data = *data;
 	dp_data->pending_status_update = false;
-	adata->header |= VDO_CMDT(CMDT_RSP_ACK);
-	adata->vdo_data = &dp_data->data.status;
-	adata->vdo_size = 2;
+	if (data->error) {
+		adata->header |= VDO_CMDT(CMDT_RSP_NAK);
+		adata->error = dp_data->data.error;
+		adata->vdo_data = &adata->error;
+		adata->vdo_size = 2;
+	} else {
+		adata->header |= VDO_CMDT(CMDT_RSP_ACK);
+		adata->vdo_data = &dp_data->data.status;
+		adata->vdo_size = 2;
+	}
 	schedule_work(&adata->work);
 
 	mutex_unlock(&adata->lock);
@@ -370,4 +378,22 @@ cros_typec_register_thunderbolt(struct cros_typec_port *port,
 
 	return alt;
 }
+
+int cros_typec_tbt_status_update(struct typec_altmode *alt, int error)
+{
+	struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
+
+	mutex_lock(&adata->lock);
+
+	adata->header = VDO(adata->sid, 1, SVDM_VER_2_0, TBT_CMD_STATUS_UPDATE);
+	adata->header |= VDO_CMDT(error ? CMDT_RSP_NAK : CMDT_RSP_ACK);
+	adata->error = error;
+	adata->vdo_data = &adata->error;
+	adata->vdo_size = 2;
+	schedule_work(&adata->work);
+
+	mutex_unlock(&adata->lock);
+
+	return 0;
+}
 #endif
diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
index 3f2aa95d065a..848a2b194b34 100644
--- a/drivers/platform/chrome/cros_typec_altmode.h
+++ b/drivers/platform/chrome/cros_typec_altmode.h
@@ -39,6 +39,7 @@ static inline int cros_typec_displayport_status_update(struct typec_altmode *alt
 struct typec_altmode *
 cros_typec_register_thunderbolt(struct cros_typec_port *port,
 				struct typec_altmode_desc *desc);
+int cros_typec_tbt_status_update(struct typec_altmode *alt, int error);
 #else
 static inline struct typec_altmode *
 cros_typec_register_thunderbolt(struct cros_typec_port *port,
@@ -46,6 +47,11 @@ cros_typec_register_thunderbolt(struct cros_typec_port *port,
 {
 	return typec_port_register_altmode(port->port, desc);
 }
+static inline int cros_typec_tbt_status_update(struct typec_altmode *alt,
+					int error)
+{
+	return 0;
+}
 #endif
 
 #endif /* __CROS_TYPEC_ALTMODE_H__ */
-- 
2.51.0.384.g4c02a37b29-goog


