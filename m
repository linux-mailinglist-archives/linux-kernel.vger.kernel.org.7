Return-Path: <linux-kernel+bounces-754907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47524B19E43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251123BAE12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F80252917;
	Mon,  4 Aug 2025 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cVXw6GRm"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAD24E4A1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298286; cv=none; b=HLDKk8ImpROq1ZcR1PCYVWYqNBlFD8djoDznO4rtACHDfTbsLxCdrnLuBO4NKMyGwbJR4DjbLUdr/Fb9TEXCgPXYFrP+leWAWXeEBMhB7pmcJnFweb4aa/pm+Pzerc35SfPKspg6+fV3XJsCo3AeGjae4CwXCIjQydPcTSQivNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298286; c=relaxed/simple;
	bh=tkjolWLEFTX+OjQUDiavG2ySNkEp4jtu1RA/RK1P54M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpkRKG1lwKaSnm+L4AKSHsU15ItM4nqd4KmzhNcOr5QSMbwuiPrJBgxJGPuxgtaoAssIxfMSWD0iNURf6IoUPW3WsQwIEz9Iu1TyZnQDcxUgMVEdTpfr5h2gtrHuNFLedyDXHBnisbHRp+ZXMApDXCewjgTR4LZE+3KYhhyKB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cVXw6GRm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so9165479a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298282; x=1754903082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acPLPksJ6hNGFtXGEUrlTi9y16bOXH39niwzv4irAiQ=;
        b=cVXw6GRm8CIVPqAwBt4RJ+5UM+x+AxW8KoZr1sgaNvMbDjyJwa6V2xDSKuxil8FTo0
         XGZ9jifotqoX57oU9SiWUEkls2ck6EEvjgHb/1hsUmZp0fZiTgDdVHjW0ElkxKI9DH4Y
         9aX6JAXxpamoZWif39O/K9qZP6ufQmdfm82W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298282; x=1754903082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acPLPksJ6hNGFtXGEUrlTi9y16bOXH39niwzv4irAiQ=;
        b=lcehp4+r9cZBxeE4qx30kiNo87nkgbolKe4mMMxDMBugz6IXFh45XoXtrdsliCq3SS
         I/X34cdV8mLr11KAfP1FjIoRAy4Cmun26K3TGjJvN1dASEBkQFvDJjb/BTsAIlX7nC8a
         FzJ8gxfbcelXDD5EnHf6yCVvDRrurgcbwtxkYXY/BvfMi8/3TJR+v3kROTz8N2bRLk7w
         8FV8u1yMqr6/ZWvYFZlbTA8z8LGKrIvUqHUnz2m7YikJaRU5hChHmLU6UAK6ZY1r3keA
         LX4o3Rkx0aZ26bOt9+3PxXMj/8ntPghhDZY+HWpigMYO0J2dqJ+49DH9ahZda+DFChcR
         6tzA==
X-Forwarded-Encrypted: i=1; AJvYcCUl8Wv/9g/t2mnHAtJTN8yMnFqytw/ymGZqziMWJrc1Ok2OjeWH/pqZEd9eiHK+ajLBqmofWwlfvjICjgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxeQUrgzd1cvRd0r3r73RjBgKZcrLLsw4BHT4oEWGlRxB4/HXk
	9UzUTjuZPSFP8p90LXE6WNYSO3EwbYjVBAS3uWUzvc9neyV0Gtw4lo27ZexejgdvWcYau449grn
	O7FM=
X-Gm-Gg: ASbGncuR45hQ4bIFizutNONNXtqFP93M31nJ3UL0SeaOHjxF2oL5jIYIjPlhAZWEG/H
	Ing2diG164NysKFWOuWKwmpT7xu4YHUV0cupCj2togcTpi462MlWptu1iUO2zuzgmuTzQvqXcNZ
	FvJHMm+aqaC7Xz6hQ0Gp0Pak2VTCu80/kuR+HtTFv+V4c3OfcYbDomnOeXcBfmh4Xd/wMAtD+oY
	rfkS/6hxfl5cmuUXXlnq5i2tR/Ia67tL5w/Bbcg7/ZRYhZjwp/jQsxpLLmkw0qPt39HH+MiL1pH
	dvgrrzcpb5W7lPIDzttKYHm2F7aXZJDx9+S0Ue9qWh3jdjQuButo4bljBtmYrz5fRM3V0MgrKtr
	bZggMwT9IDqkeIGJYjQnP5uH9oFPYVPwwDtysl6+setgqwEaeo65pFX/xfEgJheLKLfYpyH8BlE
	8L/h2rt7JQBqJ6rJ8=
X-Google-Smtp-Source: AGHT+IGBrFrtKrp8IAVwQW4QJ7evIiRgZVahLOGnZ/LOmxojYWUqcdIWg8WDD4PI3iYTDOroj7yh0g==
X-Received: by 2002:a05:6402:381b:b0:615:9247:e2fa with SMTP id 4fb4d7f45d1cf-615ae1c4112mr14025240a12.8.1754298281722;
        Mon, 04 Aug 2025 02:04:41 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:04:41 -0700 (PDT)
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v3 08/10] platform/chrome: cros_ec_typec: Propagate altmode entry result
Date: Mon,  4 Aug 2025 09:03:37 +0000
Message-ID: <20250804090340.3062182-9-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804090340.3062182-1-akuchynski@chromium.org>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
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
 include/linux/usb/typec_dp.h                 |  2 ++
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 99f549263c37..73aa25433a50 100644
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
index 557340b53af0..7ee295cf0c02 100644
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
+		adata->vdo_size = 1;
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
+	adata->vdo_size = 1;
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
-- 
2.50.1.565.gc32cd1483b-goog


