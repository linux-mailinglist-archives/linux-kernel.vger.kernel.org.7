Return-Path: <linux-kernel+bounces-794514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A104DB3E2D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA2C1A833A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC333768C;
	Mon,  1 Sep 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtQDZP+H"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BD4334739
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729572; cv=none; b=DtAQTpVLwHEnNI0F8L6TZJs5pg3HmHk9lVahOB8SqHI/0SZpSdrT+9/Y3WOOeJkXT7h9KyHLDhhCEiYG9KhICLMQduhX9yHvJ7yoBGnrfQA6yVS5i2JflOTvexRQS+MVDdOpGa80zcEAx1JMXksX+DYUKvRm9czdhKlGDHnxMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729572; c=relaxed/simple;
	bh=L3CvRJBuK1LdZ9J63Lfc5mQwo4dFXabMVCmqzMhviO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4UYYTiO15p15gNtNE5LC5684yFEeEMk+QqYUlEqOnmfHsvZNajGWQOZiM9w2kX/cNIU1vzcTCPpzpmXREhZb434P8fQFkfxiB4XEGSaTXpcqwh2bf8kCnnkXSfMEqhpqKG04Z6DunitrAhnf/CCE7CGY+E/NiDVMI3jhv0Wal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtQDZP+H; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b82a21eeeso24936045e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729569; x=1757334369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whOVHJAOahoMLucD4mGkfc/iuTQbzIwEjfulDz04PLY=;
        b=HtQDZP+HA7ClnyGgPt+lL4saSGO7ubtcT3V0DAVEtiJqGbQ8skta2BbFHLIYh8fMmc
         sR/HcZ6LlXBAS1lBq6ejrnCbCy4+CkaBy80P+fwNh7YAxgKNIqAJ0CuuFbEqYyUS9rTp
         gvcrP3R8ItpCv4sBgx5oq6TjwlvnvN3BsGyc20qNnoM4yszDJqbKUU9CacyOMitpO99H
         OluQPjRJBMc7/9VH4lBjXFK+D7Xw3zQ3MaHKWHouOS+xhEk3073uCXMlElvHV3TQWrXc
         i9L3ny6EBQmwB9byU5mtlDbiSN8atv2hlr3DMU68omCDyFZxpdtdEiZ4pm/DroybU75d
         Coig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729569; x=1757334369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whOVHJAOahoMLucD4mGkfc/iuTQbzIwEjfulDz04PLY=;
        b=JkaE1C42VF8Ylz5WYR0xvYIj3IEh9Q/E71IsyIt9Esv7e1PK18me9iYi3rq5xbJVg+
         tn1Tc1KpJ/+UV2gx3Vm8E/Z9XBLcV54Za2rYcHDC/mLZ65/T3cb98NSU4XqUDraBX744
         3ZsbXn55QoZG37zbYVaZLr75uycxEQQ25NTmW6zHFOnv5iG1rumGZDEq7vNV/CAmU4nF
         0yhJcsCXbsntrP85x5H3kZp5R4n0aZqR+CRaAfQkO5ZMSbCr3iP04POgdh4iBAcq0OFl
         H/FJyjq68QfvxOwHKmfE9wBuRyop1zsnJzXmvQKYpiAXQhzwILgyIKTit+yXtkJjdHH3
         EfWA==
X-Forwarded-Encrypted: i=1; AJvYcCXTVtJLO2lpyQLh5AbBbknhDMX7IM//IjGFnrc8tzoFjqY1mL3qVyRA/kgkNc2txAU5y9Uk4Q+PapTbljk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6zahFqw8YaAap3v8wtReN4xd21VnUYP4+pw6iVUlg/9r+nhC
	1GeUs0wF+kD1C1WmK+GPE8pomy9O8qESH3qsOay2DoJz478w86rDOh3t
X-Gm-Gg: ASbGncsM6ZkviRYfcEHpFdUkz5RubrvNueGXzcOkUHrdSUEwcx6iJT+i5Fzkv6YfM7+
	rIpq41aLA0QCKOS9Lfo9FAyCq9TnC8UBoMewetjl3U0TQVjppwNP6F06OMsCSuGS+92EqAPmy3E
	tfgr4rrB6Nb/nx1LOGLi3y7R0oN9pmQM02LcbteSnLIuhEO672gC2tss0YVbiv/HHtjD7mXaNkZ
	p1049cdM/WcqC7X1ggStvHV8+IrXV1mtnY1H51DJ/9HDsaYLNtQW3kPScL2YVIoBjVHMzEoRLAO
	EXYl6eBLmijKV8yt1itSVTRnNrHsSuChxqP36c/KudG//YUa2s4sDF+3PPnAjZLtx/GaK76WP2L
	IX2aiS+yzpJm4A4WG18bS2N6woEnA
X-Google-Smtp-Source: AGHT+IFEqVYalH4LP7GApA+3RHzluMAgFEDYygQcy3rt/FHlPm0MC8iYalSmAfccw0g2lQYKSvVGPg==
X-Received: by 2002:a05:600c:1e87:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45b855bec6emr60723135e9.35.1756729568494;
        Mon, 01 Sep 2025 05:26:08 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:07 -0700 (PDT)
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
	Mark Yacoub <markyacoub@google.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v6 11/16] drm/vkms: Allow to attach connectors and encoders via configfs
Date: Mon,  1 Sep 2025 14:25:36 +0200
Message-ID: <20250901122541.9983-12-jose.exposito89@gmail.com>
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

From: Louis Chauvet <louis.chauvet@bootlin.com>

Create a default subgroup at
/config/vkms/connectors/connector/possible_encoders that will contain
symbolic links to the possible encoders for the connector.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  2 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 62 ++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index b799102d54ac..31a3880ad83c 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -112,6 +112,7 @@ To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/encoders/encoder0/possible_crtcs
+  sudo ln -s /config/vkms/my-vkms/encoders/encoder0 /config/vkms/my-vkms/connectors/connector0/possible_encoders
 
 Since at least one primary plane is required, make sure to set the right type::
 
@@ -129,6 +130,7 @@ And removing the top level directory and its subdirectories::
 
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
+  sudo rm /config/vkms/my-vkms/connectors/*/possible_encoders/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 692e1b708012..8e90acbebd6a 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -88,11 +88,14 @@ struct vkms_configfs_encoder {
  *
  * @group: Top level configuration group that represents a connector.
  * Initialized when a new directory is created under "/config/vkms/connectors"
+ * @possible_encoders_group: Default subgroup of @group at
+ * "connector/possible_encoders"
  * @dev: The vkms_configfs_device this connector belongs to
  * @config: Configuration of the VKMS connector
  */
 struct vkms_configfs_connector {
 	struct config_group group;
+	struct config_group possible_encoders_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_connector *config;
 };
@@ -126,6 +129,10 @@ struct vkms_configfs_connector {
 	container_of(to_config_group((item)), struct vkms_configfs_connector, \
 		     group)
 
+#define connector_possible_encoders_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     possible_encoders_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -528,6 +535,55 @@ static const struct config_item_type connector_item_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int connector_possible_encoders_allow_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_configfs_encoder *encoder;
+	int ret;
+
+	if (target->ci_type != &encoder_item_type)
+		return -EINVAL;
+
+	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	encoder = encoder_item_to_vkms_configfs_encoder(target);
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		if (connector->dev->enabled)
+			return -EBUSY;
+
+		ret = vkms_config_connector_attach_encoder(connector->config,
+							   encoder->config);
+	}
+
+	return ret;
+}
+
+static void connector_possible_encoders_drop_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_configfs_encoder *encoder;
+
+	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	encoder = encoder_item_to_vkms_configfs_encoder(target);
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		vkms_config_connector_detach_encoder(connector->config,
+						     encoder->config);
+	}
+}
+
+static struct configfs_item_operations connector_possible_encoders_item_operations = {
+	.allow_link	= connector_possible_encoders_allow_link,
+	.drop_link	= connector_possible_encoders_drop_link,
+};
+
+static const struct config_item_type connector_possible_encoders_group_type = {
+	.ct_item_ops	= &connector_possible_encoders_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static struct config_group *make_connector_group(struct config_group *group,
 						 const char *name)
 {
@@ -554,6 +610,12 @@ static struct config_group *make_connector_group(struct config_group *group,
 
 		config_group_init_type_name(&connector->group, name,
 					    &connector_item_type);
+
+		config_group_init_type_name(&connector->possible_encoders_group,
+					    "possible_encoders",
+					    &connector_possible_encoders_group_type);
+		configfs_add_default_group(&connector->possible_encoders_group,
+					   &connector->group);
 	}
 
 	return &connector->group;
-- 
2.51.0


