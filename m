Return-Path: <linux-kernel+bounces-838418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7AEBAF242
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 07:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065244A6428
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 05:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837E259CA4;
	Wed,  1 Oct 2025 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee3OlZCd"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F123F40D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759295916; cv=none; b=RF4CRkEaX5eciZXAAgIy5+yr1XUnzMJV4Eqc//q+p1gXIkjFCKnxHVy0/UEqKHsoQgaK/pt4w3yAj74nydjUzBB8bM/Lxc1wXYtPUaSmMr7HVuYMRz3Rj2seXAcTYWTU1y1k2/lAF9kacmvOMukh/ltpBqZUdnXG3TRoLYADLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759295916; c=relaxed/simple;
	bh=Z5ZQYd6GVkR4OwJjMc93z1Xfqu6I0u+EXdRlrpQ7L2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rey+bhgr9+CPxYA/gLiDfxAVrjRA18SOh6ZHNvSOmb6yL8twHC5bO3GZg/ChNXE5E7+CR5dz02/X2EUoiAht7dgFWaobZlUe51KhIfNJ6MQ79VBxK11lOJbHkGXGQxKHeFv6jlwT4KAk37/Um2f0vLghTOXJuAz+A7wI4N/rqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee3OlZCd; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e0302e2b69so36574101cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 22:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759295914; x=1759900714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyH0cxEfHqAGwWc5MmC0doS1vzzMXmfsMfTZQpGGZfw=;
        b=ee3OlZCdRi5X874YnHyxyV+866V35k7L3/7xvKuA7wyBXaAEFDoJMFNhbVsegkLTsM
         vq2oMsWP7pog5xx/T8YirYYvITdVwQBLz6IcmAgQ2ea5hxtZoy6XoOxrx2GFLcH8MO9H
         7ybGN5Rs5n0RVvzJOf3POqWUqjhA6sKLy5O91u4Rk9XxzLwnezad6y49bm3fEp47Aq/p
         8R04gKxA/MMzOM+I+OCNMfYxYjGcD/A+teMNwrAUXTPkg7Z8whSGb1dIinNOkR1Gp0W4
         JhLbXjsUI/vfByu0jAxZRIBAZW90suR4D9Uqtxs2KALc0onOmG58PUY1zq+PQ7aq4cPZ
         tPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759295914; x=1759900714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyH0cxEfHqAGwWc5MmC0doS1vzzMXmfsMfTZQpGGZfw=;
        b=uuj2YRUHw1d9jJw/rRBMz3JfNEAoxilOcsfl24W2c1Vf+BM3321zFJNpMm5x6HVWz+
         bleXwtORxyRkH/bL55omppciR+Ds73fp8z8/3p6UbBbm9yBaigtfNZOYxFbaMEe+nS5U
         7lNRXrWwwd/oOKBMWqgUxMbHWxwc6cn3EW3xj4Bh04IqF12jbBISSO/QnHQ+4Q36jLQg
         U97W+FgyHIEwJa7KRhpPZypgaUJ01yveX00g1pR2Do3hspCiWour+Xc/Pmxj6TGYRCAk
         NaUJVgjkPtnQvPiecXIZyM77eBV/L5nKhs3g47uxdulghCkQH55gNy9T5SqVpZPU2EMD
         N2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUy7yXeBl7YCG06cvilgJ+LOwWAFwfCNQHxhFvTbZ5Rno8e+CQISEBpVIKAfRckmqgcpL2ntbULN7aqRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PjbRrNUcfua4dn45TRtKWwn8ae8/uIC9NOU9qIyPGK+KmYtg
	wkgoS4mA9WRp1NV7S0LsSMTo6hJNh5CCjCdlM/wtVlNrIJmgLYlq8BSk
X-Gm-Gg: ASbGncsgiJL4hPZrgmsrn3dYLdnr8iY9YqToj1mdLedMTEnP3yuCHyNftflcltbQtdj
	UpYg4vavfg+y/RneG3xfP6yPz6RAQkjSoaduR6wk6z1y7mdsY7Pz2HU6JgsMiAuK7dTg2OdNTps
	ek4TT+B2yf+o4AhpNL1M7jG5SKSUtJRRwyLypMzSDIqD017998TaQ1MJUAEDEJ6kH9sJi0Oa9lh
	sPhgCgZ5DfITaN41fusutt4XZsvFOhJhe+idEB7aO8PxlmIlls51v4e5tg1Co3bunKuNlw5rfXd
	FOgtqmtdKJH6jcha0QoFWbCeFpRcUH6MAJAK85Y0F20xlmMna/6NgFiq8EN/xt+Sv9pQoyG+2sg
	R4yau0T2YmtMZ4uKSQSIJRsycWC3GaC6kfemay6nL7ztEoJHzSaVgeJo=
X-Google-Smtp-Source: AGHT+IFlu2k8qEgC0F5ohClgUTfaMX14MZO+MMM6172ptThpaujXr7OTB1iPUFDxEomZGGzfxLze0w==
X-Received: by 2002:a05:622a:4acc:b0:4d9:a5aa:93c7 with SMTP id d75a77b69052e-4e41c35329fmr30681021cf.12.1759295914030;
        Tue, 30 Sep 2025 22:18:34 -0700 (PDT)
Received: from localhost.localdomain ([23.162.8.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b56fe22sm107656811cf.20.2025.09.30.22.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 22:18:33 -0700 (PDT)
From: Forest Crossman <cyrozap@gmail.com>
To: mchehab@kernel.org,
	linux-media@vger.kernel.org
Cc: Forest Crossman <cyrozap@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] media: dvb-usb-v2: Add support for Geniatech/MyGica A681B and PT682C
Date: Wed,  1 Oct 2025 00:15:27 -0500
Message-ID: <20251001051534.925714-3-cyrozap@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001051534.925714-1-cyrozap@gmail.com>
References: <20251001051534.925714-1-cyrozap@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These devices appear to be approximately the same hardware in different
packages. They both use the MxL692 combination tuner and demodulator,
and take roughly the same configuration parameters.

I say "roughly the same" because while the PT682C needs to have its
MxL692's MPEG clock polatity set to "negative" in order to show a
picture, the Windows driver for the A681B sets the clock polarity to
"positive", and the A681B seems to work regardless of what polarity it's
set to. So since setting the clock polarity to "negative" is necessary
for the PT682C, works for both the PT682C and the A681B, and appears to
be the "popular" configuration used by devices that use this chip, I've
left it set to "negative" for all devices.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/Kconfig  |  1 +
 drivers/media/usb/dvb-usb-v2/dvbsky.c | 69 +++++++++++++++++++++++++++
 include/media/dvb-usb-ids.h           |  2 +
 3 files changed, 72 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/Kconfig b/drivers/media/usb/dvb-usb-v2/Kconfig
index 4eadc9539b4c..02f8d5e2cf11 100644
--- a/drivers/media/usb/dvb-usb-v2/Kconfig
+++ b/drivers/media/usb/dvb-usb-v2/Kconfig
@@ -93,6 +93,7 @@ config DVB_USB_DVBSKY
 	tristate "DVBSky USB support"
 	depends on DVB_USB_V2
 	select DVB_M88DS3103 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_MXL692 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_SI2168 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_TS2020 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_SI2157 if MEDIA_SUBDRV_AUTOSELECT
diff --git a/drivers/media/usb/dvb-usb-v2/dvbsky.c b/drivers/media/usb/dvb-usb-v2/dvbsky.c
index ceac0ea21dab..4281b0f74736 100644
--- a/drivers/media/usb/dvb-usb-v2/dvbsky.c
+++ b/drivers/media/usb/dvb-usb-v2/dvbsky.c
@@ -7,6 +7,7 @@
 
 #include "dvb_usb.h"
 #include "m88ds3103.h"
+#include "mxl692.h"
 #include "ts2020.h"
 #include "sp2.h"
 #include "si2168.h"
@@ -576,6 +577,37 @@ static int dvbsky_mygica_t230c_attach(struct dvb_usb_adapter *adap)
 	return 0;
 }
 
+static int dvbsky_mygica_mxl692_attach(struct dvb_usb_adapter *adap)
+{
+	struct dvbsky_state *state = adap_to_priv(adap);
+	struct dvb_usb_device *d = adap_to_d(adap);
+	struct mxl692_config mxl692_config = {};
+
+	/* attach demod/tuner combo */
+	mxl692_config.id = 0;
+	mxl692_config.fe = &adap->fe[0];
+
+	mxl692_config.xtal_calibration_enable = 1;
+	mxl692_config.xtal_sharing_enable = 0;
+
+	mxl692_config.mpeg_parallel = 1;
+	mxl692_config.mpeg_sync_pulse_width = 1; /* BYTE */
+	mxl692_config.mpeg3wire_mode_enable = 1;
+	mxl692_config.mpeg_clk_freq = 3; /* 13_5MHZ */
+	mxl692_config.mpeg_pad_drv.pad_drv_mpeg_syn = 3; /* 4X */
+	mxl692_config.mpeg_pad_drv.pad_drv_mpeg_dat = 3;
+	mxl692_config.mpeg_pad_drv.pad_drv_mpeg_val = 3;
+	mxl692_config.mpeg_pad_drv.pad_drv_mpeg_clk = 3;
+
+	state->i2c_client_demod = dvb_module_probe("mxl692", NULL,
+						   &d->i2c_adap,
+						   0x60, &mxl692_config);
+	if (!state->i2c_client_demod)
+		return -ENODEV;
+
+	return 0;
+}
+
 
 static int dvbsky_identify_state(struct dvb_usb_device *d, const char **name)
 {
@@ -587,6 +619,11 @@ static int dvbsky_identify_state(struct dvb_usb_device *d, const char **name)
 		msleep(100);
 		dvbsky_gpio_ctrl(d, 0x80, 1);
 		msleep(50);
+	} else if (le16_to_cpu(d->udev->descriptor.idProduct) == USB_PID_MYGICA_A681B) {
+		dvbsky_gpio_ctrl(d, 0x80, 0);
+		msleep(100);
+		dvbsky_gpio_ctrl(d, 0x80, 1);
+		msleep(100);
 	} else {
 		dvbsky_gpio_ctrl(d, 0x04, 1);
 		msleep(20);
@@ -756,6 +793,32 @@ static struct dvb_usb_device_properties mygica_t230c_props = {
 	}
 };
 
+static struct dvb_usb_device_properties mygica_mxl692_props = {
+	.driver_name = KBUILD_MODNAME,
+	.owner = THIS_MODULE,
+	.adapter_nr = adapter_nr,
+	.size_of_priv = sizeof(struct dvbsky_state),
+
+	.generic_bulk_ctrl_endpoint = 0x01,
+	.generic_bulk_ctrl_endpoint_response = 0x81,
+	.generic_bulk_ctrl_delay = DVBSKY_MSG_DELAY,
+
+	.i2c_algo         = &dvbsky_i2c_algo,
+	.frontend_attach  = dvbsky_mygica_mxl692_attach,
+	.frontend_detach  = dvbsky_frontend_detach,
+	.init             = dvbsky_init,
+	.get_rc_config    = dvbsky_get_rc_config,
+	.streaming_ctrl   = dvbsky_streaming_ctrl,
+	.identify_state	  = dvbsky_identify_state,
+
+	.num_adapters = 1,
+	.adapter = {
+		{
+			.stream = DVB_USB_STREAM_BULK(0x82, 8, 4096),
+		}
+	}
+};
+
 static const struct usb_device_id dvbsky_id_table[] = {
 	{ DVB_USB_DEVICE(0x0572, 0x6831,
 		&dvbsky_s960_props, "DVBSky S960/S860", RC_MAP_DVBSKY) },
@@ -806,6 +869,12 @@ static const struct usb_device_id dvbsky_id_table[] = {
 	{ DVB_USB_DEVICE(USB_VID_CONEXANT, USB_PID_MYGICA_T230A,
 		 &mygica_t230c_props, "MyGica Mini DVB-(T/T2/C) USB Stick T230A",
 		 NULL) },
+	{ DVB_USB_DEVICE(USB_VID_GTEK, USB_PID_MYGICA_A681B,
+		 &mygica_mxl692_props, "MyGica ATSC/QAM HDTV USB Stick A681B",
+		 NULL) },
+	{ DVB_USB_DEVICE(USB_VID_GTEK, USB_PID_MYGICA_PT682C,
+		 &mygica_mxl692_props, "MyGica ATSC/QAM HDTV USB Stick PT682C",
+		 NULL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, dvbsky_id_table);
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 1b7d10f3d4aa..0ce78daa3ef9 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -301,7 +301,9 @@
 #define USB_PID_MSI_DIGI_VOX_MINI_III			0x8807
 #define USB_PID_MSI_MEGASKY580				0x5580
 #define USB_PID_MSI_MEGASKY580_55801			0x5581
+#define USB_PID_MYGICA_A681B				0x692f
 #define USB_PID_MYGICA_D689				0xd811
+#define USB_PID_MYGICA_PT682C				0xe691
 #define USB_PID_MYGICA_T230				0xc688
 #define USB_PID_MYGICA_T230A				0x689a
 #define USB_PID_MYGICA_T230C				0xc689
-- 
2.51.0


