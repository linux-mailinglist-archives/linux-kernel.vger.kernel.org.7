Return-Path: <linux-kernel+bounces-856745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C99ABE4F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DE1D500460
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898EE2253E4;
	Thu, 16 Oct 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4QN78xt"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAE32B996
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637422; cv=none; b=FYu/LnZnFMjOb7LVqMjLHgdQesnCGReykC6noxmmd5qkIKqWVJ7B1Njwg3MAnFikltB9MjFmpvvWoOR6uaxkj2/KVME0GnhjTERIp5jNhZ4HXEjZpcXI8HuDxPWmbTyZhE8H2gvdcFwDnJZsl1W4k8zLvpN05sXFaFKpwir9/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637422; c=relaxed/simple;
	bh=aNI34D7IzdDMv1hfmc7OAhIqs1d7kOK6kNBLx43tTc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dvv9z4Oqx1VpY2YWh0TtMmZXcDGSOacerFwZvxckcQt9zIrRCFLhaJHCXqYAnj0Oe4DSP9Ob5mKnU8nRhsAV3306l35XYoVLOA51vUupj7EH0IUivvTmxmw8/2IKBl6XGsnjRPRkyKhMPb5e98y9KQjzxKhSaL/yKcq4ZJ5D4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4QN78xt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so715551f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637419; x=1761242219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClISOZHaKXG20S3XQ48lNEKMp2kHMPI3fsgz+dyjsPU=;
        b=k4QN78xtl9yF6SxtFaQW372A0ZvId7PVjy4dY0zeqaSZW3nJnQMKPOFaZ0NK/Im5Nj
         GWpa9E5smQq830yuIUfOPs/XxDBAD0hsXmIYaPDSx7C7LlOJTedmqJj6SDHOPFhqon4x
         8jlvfjgPCK2QQbYnA+mTILLVlJ+DYyoc8P5QOezweoK10wMxz2EBoPq0LKsStcGsEXOa
         VUppBaoknc5aMD3BtG2/fmVjEEUvwqeRiB/urnX5hUSBjhytXnso5a/fviy/4pmaNk3T
         ovvpquAXq9wtYQIYjQu5vLVh2hbN05KTWjLXJzZDpAMpaltXaLRSuREinrmpumyEyj0e
         jGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637419; x=1761242219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClISOZHaKXG20S3XQ48lNEKMp2kHMPI3fsgz+dyjsPU=;
        b=k2FIuCw/AEPIoYFb+XmbLYuavLS+e4etarEIcL5FfQnc2ZCEaK+Uz3p55PYDDqKaT8
         ZzjMzMZWdiDgT91YKoIXQgRtoahci7EnZoCvVC1pFaO7XpirYqRwHbJQEZw1LVmheZgJ
         HOAYJo1HcOFRpz3bQyvjzJJQbRjNmzdWVLE6s+s1fIVmtDY+ck+xNXYuaWQa1VI+j1hH
         THKW2QMvHBe5lsBVWbAL3s2V0W71jBh/wR2NajySbKr14VuNotf1xl6aVirko+QP36tc
         6OJ1zKFCQnKuzHRAO8BiNKjW1qnNLAipuS1w2cVOs+AVZsCzpeRvAZGuz/AesFJ8VcTv
         scAw==
X-Forwarded-Encrypted: i=1; AJvYcCUExm+IURj8iSfkzcTTDfz/mKttH1+jdr7zValzsZww68MXjTsgw9Xgb1KcrJHcvsuPbdiD8uoAFxcR5Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/kwpz6c1y9sZmzs+Wh/BkC6/l26EWKom4+dS/nxbsGHUGsA+
	C3QBwmPPKK/d6rqWZa6bH8MktKVhmxOegW+xwWdqzYssKAZSLFDD9g1O
X-Gm-Gg: ASbGnctrVLfDLVeQlVorP7DmM4FjY1jRTghAlLDwheDz1gj7XyUC9LGW/Zq04SYU7tP
	COUgWWXEDGWrAc6+F/opKtGDvhW12zeBYZWa5LiHqlamSWgBThOvKcAZtqkZH2EdDmWxU4kSJk6
	cTC1Svw6Obkexi4ebsbC+78eMFHhoCdq19cRRBr7A27erHH1+so2oFsxb0de6ogKpNkCuDi0dVF
	gjwd5zxfEP+/pqditaqs7mQKp+XuiihZk08/pc8RreyHr2QL/80fsWoh9eWhXdqx/WowzGLn+QY
	ygawCrSyI/UhFIaZVEaIcGvvhsnUVaJrdtbiY6XXVlvOmEwKHItduomFLc8hHuQy45jYReVKwS+
	LQS4S2dDLkHuIn1u6qUKr0o8vfGO2ePVm1rTJCxsC8AdAVH0J0chQF71NgE0/J/r7iIcCt19P2I
	MEM66Aj4fc+w==
X-Google-Smtp-Source: AGHT+IFen0kzNqyzefDYwpOk5DC9D2JhqSgSxdWoj1UT+cqm+5u8q+EaJUCE0KOXFwJqtoXtLkEsyw==
X-Received: by 2002:a05:6000:22c6:b0:426:d734:1378 with SMTP id ffacd0b85a97d-42704d7eb18mr712377f8f.4.1760637418603;
        Thu, 16 Oct 2025 10:56:58 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:58 -0700 (PDT)
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
	Mark Yacoub <markyacoub@google.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v7 14/16] drm/vkms: Allow to configure connector status
Date: Thu, 16 Oct 2025 19:56:16 +0200
Message-ID: <20251016175618.10051-15-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016175618.10051-1-jose.exposito89@gmail.com>
References: <20251016175618.10051-1-jose.exposito89@gmail.com>
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 24 +++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            |  8 ++++--
 drivers/gpu/drm/vkms/vkms_config.h            | 26 +++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index b0d78a81d2df..d75a6252e4d2 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -957,6 +957,29 @@ static void vkms_config_test_connector_get_possible_encoders(struct kunit *test)
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
@@ -978,6 +1001,7 @@ static struct kunit_case vkms_config_test_cases[] = {
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
index 0118e3f99706..4c8d668e7ef8 100644
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
+ * vkms_config_connector_set_status() - Set the status of the connector
+ * @connector_cfg: Connector to set the status to
+ * @status: New connector status
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


