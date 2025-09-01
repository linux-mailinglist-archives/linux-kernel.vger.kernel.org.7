Return-Path: <linux-kernel+bounces-794518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D1B3E2D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CB717B30E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313C3375B2;
	Mon,  1 Sep 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWemGQQz"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295AC3376BD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729576; cv=none; b=OmZ1ePnC4OLH5qSfrq5HHLuYXl1rDv4s5T8MkeFJp24sXaT7RVXnygKNDrnABbIZ0Fc9Z8FTx+VECPozV7LeY9oH+EiwPC5rtNJPDd8CG6bwqKd35sZy7dA/cpaQWhr4aQrAtF5X5/S+3PSvCfNr8g/SvB+drQMdxq7utrk3PAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729576; c=relaxed/simple;
	bh=5IILu3zWsdfUgG1YIPueRJpkjMyMCjWvR5rHrVXYamQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EInzuFa0TObfmjakLqkJFgPG1oWu6TaWbFMrVKb+0utfYgbcbXvpDnib3PyrQX3wHeJvDjxnGy4V4ZOpKqBtNkcoZM8Ctsa7SNRjBMqE3O8HaHhnJRQVs52yVdHyHwPMuEzmu2gpynPIJ3lGNVEMXb1fe3mZ6wzZ9iHCzaqMmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWemGQQz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso10538105e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729573; x=1757334373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5U/A7BZZhrW2dMx+uUsEDtN1NwfjrfXXCZhIh6W26o=;
        b=BWemGQQzV6rg9zDS9jHBiiPG81YeLFrbHMJFXhwuXTuFnaXq62tC0I37HhZ3+PlchE
         xwsbAJ6eAwMFdAv+47j45q9+rNOKaxa6WGNaRRlzd7MriNUoPO5okHoZt0Pwz5jbwTil
         nvYCwVvPPWPV6Kykv7t04cnyRpJ/qlX4O+5tGZxeorPbCCmKqhgaJ94fRed4FOamHF/P
         sJH6acevOQdbFnazNJ5dtf9FNArm3M5OKbFq5kRvFyLaV4spIuw1QVOn087gGDuqjL7K
         9xpAb+3hNiJsl2IzmaGOxIJDB32ecd2tryIrQHwrUY00ktkesB0zl8yqu96eATDg6ZE6
         yQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729573; x=1757334373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5U/A7BZZhrW2dMx+uUsEDtN1NwfjrfXXCZhIh6W26o=;
        b=ABIsopE449DeEXYbTxBdCp6UTmOFjlhh9ZFyHG/uluhnFWRgGxrIDC63+NnlbANj93
         DUzE2R8uypbyYYZyH4vHEvan5btm9fjxJb++3c3sF+HBCJkWVjYL8+qWAn1wDRhqwnaq
         MbaMzNQM59veaY2oDftfSqJmSfV6aYymvt7MZsEkU1YHZZPK59et+N3Y6mmjkG1sSlxh
         bIafiOTd6+fmo+I/0XrA7yz/+t8IAH/UNrPdv7TfFM0K30JDWnT9NKWsY9WspDD1TIkN
         +brV9g838htVx/zyIcR2SvjZL/OpCusFIHRzETMtdhYCeoO4dCecL6rjZbmcSWD5QZtB
         HObA==
X-Forwarded-Encrypted: i=1; AJvYcCWBuZVbNlIh/DW3x1mP2AtwgakIBPURR5q4Tf/lSldUbyLecNlLL6hNfk/alidcgcEeLYP8Ekv9doug8Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpAa4AIFJuOLDUCsakI1sANr+SCQDwuSL7FtYKRW9ppujgpae
	1oznM/+2VcynJM/xdLCpjDy1eIDrJ5Dugvf7ULuNecxcXSPHkdfGRffP
X-Gm-Gg: ASbGnctUWu4GvCn8W9caed4/rt1EP/K6j1oL6YfrEI5hEUAsyGM9d3KV9YUh//Vx+I2
	JgNmj34/Px/Ilj3bkSN5xE4ZRK31p6vE5orRH6hSmh5tWjMvukczXPiES5QdjLwwqgKHZzRQSr6
	tNsgAfeL6WwLUnowOmo0kKXdlgQfVGbYNwwvWP0p4Kemsfq0e1rVkKrsh+ud9Dp1xY+BE8W7e6s
	yhqT4ms7fBAL9Un01KMgfGV0sKf7AIUxfm2Vufcgv+fTnJdAStYDBKu80m+pvUdyo0k+Zl+mnlH
	JwZTE+7GkPDKx8ufhSeNQvAyVedcpfh/bRbfnbsA0kgm8th9HBiHQSgRY3nT6ESJfZB59gHvNF8
	YSQ+qG7XcVL2rYIupzQ==
X-Google-Smtp-Source: AGHT+IEcxSN6nj/+KGvmNX0gPoXphoDeantwG+/jUC0mrK5opKNCsUQjh1nTYxcaTAdOxCvFaO2PiA==
X-Received: by 2002:a05:600c:1d1c:b0:45b:8b3e:9f63 with SMTP id 5b1f17b1804b1-45b8b3ea13fmr37800695e9.18.1756729572505;
        Mon, 01 Sep 2025 05:26:12 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:11 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	sebastian.wick@redhat.com,
	xaver.hugl@kde.org,
	victoria@system76.com,
	a.hindborg@kernel.org,
	leitao@debian.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Mark Yacoub <markyacoub@google.com>
Subject: [PATCH v6 14/16] drm/vkms: Allow to configure connector status
Date: Mon,  1 Sep 2025 14:25:39 +0200
Message-ID: <20250901122541.9983-15-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901122541.9983-1-jose.exposito89@gmail.com>
References: <20250901122541.9983-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow to store the connector status in vkms_config_connector and add a
getter and a setter functions as well a KUnit test.

This change only adds the configuration, the connector status is not
used yet.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 24 +++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            |  8 ++++--
 drivers/gpu/drm/vkms/vkms_config.h            | 26 +++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index ff4566cf9925..3574a829a6ed 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -916,6 +916,29 @@ static void vkms_config_test_connector_get_possible_encoders(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_connector_status(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_connector *connector_cfg;
+	enum drm_connector_status status;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	connector_cfg = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg);
+
+	status = vkms_config_connector_get_status(connector_cfg);
+	KUNIT_EXPECT_EQ(test, status, connector_status_connected);
+
+	vkms_config_connector_set_status(connector_cfg,
+					 connector_status_disconnected);
+	status = vkms_config_connector_get_status(connector_cfg);
+	KUNIT_EXPECT_EQ(test, status, connector_status_disconnected);
+
+	vkms_config_destroy(config);
+}
+
 static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_empty_config),
 	KUNIT_CASE_PARAM(vkms_config_test_default_config,
@@ -937,6 +960,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_plane_get_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_encoder_get_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_connector_get_possible_encoders),
+	KUNIT_CASE(vkms_config_test_connector_status),
 	{}
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index a1df5659b0fb..f8394a063ecf 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -361,8 +361,11 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)
 		seq_puts(m, "encoder\n");
 
-	vkms_config_for_each_connector(vkmsdev->config, connector_cfg)
-		seq_puts(m, "connector\n");
+	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+		seq_puts(m, "connector:\n");
+		seq_printf(m, "\tstatus=%d\n",
+			   vkms_config_connector_get_status(connector_cfg));
+	}
 
 	return 0;
 }
@@ -588,6 +591,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 		return ERR_PTR(-ENOMEM);
 
 	connector_cfg->config = config;
+	connector_cfg->status = connector_status_connected;
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 
 	list_add_tail(&connector_cfg->link, &config->connectors);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 0118e3f99706..e202b5a84ddd 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 #include <linux/xarray.h>
 
+#include <drm/drm_connector.h>
+
 #include "vkms_drv.h"
 
 /**
@@ -99,6 +101,7 @@ struct vkms_config_encoder {
  *
  * @link: Link to the others connector in vkms_config
  * @config: The vkms_config this connector belongs to
+ * @status: Status (connected, disconnected...) of the connector
  * @possible_encoders: Array of encoders that can be used with this connector
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
@@ -109,6 +112,7 @@ struct vkms_config_connector {
 	struct list_head link;
 	struct vkms_config *config;
 
+	enum drm_connector_status status;
 	struct xarray possible_encoders;
 
 	/* Internal usage */
@@ -434,4 +438,26 @@ int __must_check vkms_config_connector_attach_encoder(struct vkms_config_connect
 void vkms_config_connector_detach_encoder(struct vkms_config_connector *connector_cfg,
 					  struct vkms_config_encoder *encoder_cfg);
 
+/**
+ * vkms_config_connector_get_status() - Return the status of the connector
+ * @connector_cfg: Connector to get the status from
+ */
+static inline enum drm_connector_status
+vkms_config_connector_get_status(struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->status;
+}
+
+/**
+ * vkms_config_crtc_set_writeback() - If a writeback connector will be created
+ * @crtc_cfg: Target CRTC
+ * @writeback: Enable or disable the writeback connector
+ */
+static inline void
+vkms_config_connector_set_status(struct vkms_config_connector *connector_cfg,
+				 enum drm_connector_status status)
+{
+	connector_cfg->status = status;
+}
+
 #endif /* _VKMS_CONFIG_H_ */
-- 
2.51.0


