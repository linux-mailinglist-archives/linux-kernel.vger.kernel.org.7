Return-Path: <linux-kernel+bounces-856746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9688BE4F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8588D4FF6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A893321B3;
	Thu, 16 Oct 2025 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIeQBPhQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E78328B48
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637423; cv=none; b=CMN9aR4Edvd9BaIg9EFq3pJsQMwBUTtLP4sFHPx7G59JlFXpcWt6FPoaC3rgZGgRL1vBBO4z0+0sdpkFfkwFx97VCJi+rWNx5RqYN+JY6+KwWEFYV/9FqhjN7PTjvm35USMjpzUyCcwB6Tj5QgcFCPa2EsxG6U14yLiuw4DDVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637423; c=relaxed/simple;
	bh=ONvd2tAkw5VGV2s5p+03PoGz3Ss16BKDxJJJA8FMbf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLARjbZTEpcd+WYLcI7gD80+aUCulylKRvdsJXRa/ltrHZeXmJQVXncho+HwOZUqPYbblYLFettFC8t3sHZnjUuZXiBVGJFIgDEJzP/6FyGSttIBSERAuNRvZgEHWnzeF91fmV+ZkJdQQGSzik3gnZexKOIrW0jluCdkSFKGfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIeQBPhQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42701b29a7eso465042f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637420; x=1761242220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOeIZT+0nowAboOM15YWTpcZn2OOxWAKh4lx00a3ZV8=;
        b=jIeQBPhQiA2qjnBZy7t3ZeCdGJi7RNYnYNXl2ebEaWK4yMrMzDoXpF+fCjIqn2U/qz
         379YR/h6+YpDtWWYFsQ8A1z8XBtj1e9Q44biHzsA9L9sRJTHrp1DjdHKoPHAeLaVEDve
         ixDwJVaiEOfecJhZCdCDby1DEe8ZzvOqHtoNuybyRG7II885HYnH7CwYTV2jJn8T2PJw
         oPYSX8JKlBTPnZZNSnYLfEzfHUrl+W1lhrNZMts4djNtEv2N9h7/jwiPUdobyyDDb7sa
         TjcwFVaLekWDm1aX+DSPEpm6P3RfiPb5irucRk9CbKISjyNYNFkyyYE9+Kl/xO0KsK42
         SBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637420; x=1761242220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOeIZT+0nowAboOM15YWTpcZn2OOxWAKh4lx00a3ZV8=;
        b=wsGUzYTmtelZe0beKQSB3l6daBpWmGsH2cX0nO/U5DmCJ3dSMUruCOQfAFUPxlcfwW
         P/SxMdGLvdlEc+HiMz0YVZw7JBQcnQNwSsy1XyHDwlaP510+UZHomeWNLbkHfXZVpLVY
         iT2yBpQ+7lmV8clFulXjsQxC9te9vuql6RU4w0lpTyjfVqewyMLf43jyZ/3WkqEy99g2
         UDragbpwqGSNXM42mKI+cDBrZEmLCiUE8xBpazj21x3p6FivqEm6vCMk9feV6PBvSqSI
         fw1SNwhfzU5kXQNdYTWd5Hm/iwIjFoMLVL31pTyjmy1t8Mh18EjA4x4E8j/9JjDn/VFp
         nq8g==
X-Forwarded-Encrypted: i=1; AJvYcCWaXICO73zRRGk0A4Y4maT8ASKEla9b3TQVAu7NywquneFlIWucxQX9iF1T7pIbkJBH/9wljthDo04EwJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPaGAzwIoOQWVEgWe8teG2XuuztdymNd6AiM4Iu8VogIPUu3Cn
	xKy9MecQDEcktm2/VZgcVQlpbI/yk/qok9c9QWLSmsXCIWi6zMZGlHNG
X-Gm-Gg: ASbGncvEEjhfYzRIhHOU2ViUQDxd4kUFNOxIEgDbp8RRAIZqj7V8TvA3+Un9hcEXKbG
	2YkuQXTowKdHw08Iri+hQGI84cDpUF0AkgrABfo6f3ZPQaKND8QCKVDKe18FgjRg5eKiGnuCIh9
	0AjU/1/O1fBRagEZevHHDyaePw/jx3+2ZR2pdN3JQpg2FXk8QSlraYJlh1S6Ulzf0jYYFJFKocU
	1OspmU74lv7ZwqHLvkp1ZzWi8vpZQUTqzl1cYU+TbdjDvtnAo8J+c2P2v5zCGLCK4qxXJINnZYO
	9wSQlNCkH0U3m4VoAbG4NOemOW+4e/iKEV4JlnKxJV0X6m44Dks0Vp7cIhxLKWoN8SnnGv5j7KE
	MPDAsPCYMGdHY78RhzwuLQgIMyqS9AMSsoCaEJz6OJbo4RAy6ia9o45B+ULoHVgXQuRv+7T0VV1
	c=
X-Google-Smtp-Source: AGHT+IHe1OLOXOadpXnjRw98pZ3luRk/lvOuNRj9YhMuqiInrVYkMFOqFCyNrXu08kVK/1fJT5i00w==
X-Received: by 2002:a05:6000:144e:b0:426:fb63:c01f with SMTP id ffacd0b85a97d-42704bf71ecmr887370f8f.29.1760637419784;
        Thu, 16 Oct 2025 10:56:59 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:59 -0700 (PDT)
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
Subject: [PATCH v7 15/16] drm/vkms: Allow to update the connector status
Date: Thu, 16 Oct 2025 19:56:17 +0200
Message-ID: <20251016175618.10051-16-jose.exposito89@gmail.com>
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

Implement the drm_connector_funcs.detect() callback to update the
connector status by returning the status stored in the configuration.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 28 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 48b10cba322a..89fa8d9d739b 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -5,9 +5,37 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 
+#include "vkms_config.h"
 #include "vkms_connector.h"
 
+static enum drm_connector_status vkms_connector_detect(struct drm_connector *connector,
+						       bool force)
+{
+	struct drm_device *dev = connector->dev;
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
+	struct vkms_connector *vkms_connector;
+	enum drm_connector_status status;
+	struct vkms_config_connector *connector_cfg;
+
+	vkms_connector = drm_connector_to_vkms_connector(connector);
+
+	/*
+	 * The connector configuration might not exist if its configfs directory
+	 * was deleted. Therefore, use the configuration if present or keep the
+	 * current status if we can not access it anymore.
+	 */
+	status = connector->status;
+
+	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+		if (connector_cfg->connector == vkms_connector)
+			status = vkms_config_connector_get_status(connector_cfg);
+	}
+
+	return status;
+}
+
 static const struct drm_connector_funcs vkms_connector_funcs = {
+	.detect = vkms_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index c9149c1b7af0..90f835f70b3b 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -5,6 +5,9 @@
 
 #include "vkms_drv.h"
 
+#define drm_connector_to_vkms_connector(target) \
+	container_of(target, struct vkms_connector, base)
+
 /**
  * struct vkms_connector - VKMS custom type wrapping around the DRM connector
  *
-- 
2.51.0


