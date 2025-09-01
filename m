Return-Path: <linux-kernel+bounces-794519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718FB3E2D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7099D1A834DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB30A33EB02;
	Mon,  1 Sep 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLnwY8dW"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C833A03F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729579; cv=none; b=ZNB8u4lDPj8Q07MRC+yRxWxnTmEEByooQ11Iip9Yz+hxMzcC2NUH/Tkx1Ym8NRbJAR59xc/XOkqTbwA5MHNMlquVEcQFI4W0Fo2o1NcpGXNsVslKJJBUU+inAN7tUtSVbqEk7aL56noPq0LdU+Kbd1EMh1meRDj4fuwwJfnEm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729579; c=relaxed/simple;
	bh=BeHJI+BW2HtFHEgog4vZOgsELSDN5o8UjTy51Us74+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsBoHP68KsXTa4r3K/I9jg5iqATZZaarJLj5FGYTJXibHgsHtmuQjeXVPPC6dK2xA0R1o1n4v3YweM5baCnQP2iWyDcoGT/GRyLxrWlcULDm99YHDXbprCFaxhWTxOOmKMjyhsWu7oBjDyoY2xI+ZP1/7kL1b8hiiasAe+gCKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLnwY8dW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d3f46e231fso921068f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729574; x=1757334374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcY27BYD5SEbH9egkOiTtO1uLUZ1+Eh26ylvssFUQyw=;
        b=iLnwY8dWBxdUriGB+z9BaRokbtSOOChHt6MFWm4awCxidmVn4Tk1lTPhLOMY+ZXJhr
         PWJmt5anpLp4ll5WN+3xBy3plbvB+cZvJh9XYBcodtU8s+u0SylkDOaARIuhN4bk30Z8
         asvYCe/omKjkuAO120CKGMlldDubJr7MmXDmYZ/XhMFGCGhP5K1Jeu/afTkMJjw/q9/4
         r71VzhY3uBKJa+Yvnk1a3+3f9GY7xkx2pdcheW8Rwqbl6nJzDfj8lkEULNE17uKvaB3D
         KTsBlMZIp9LHhNFyovbt75ZkmZDvT6YfADIGRMomSUYV3YIOzQJ8a9UAuKpJi1tSVzJx
         oKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729574; x=1757334374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcY27BYD5SEbH9egkOiTtO1uLUZ1+Eh26ylvssFUQyw=;
        b=kjZVGIRpII1nfdP/W7y2K6WzjrY3XW4Tj4AFOTxRU7oneIAKJUQ/k27rDIqhlvt8Yo
         jtQcZUViH0i30dwAAYPVh16sv2klj+Ou5OmUgUo89Gizk9I16PiPA2ErBgf6qJjkpm/E
         IkQgTgWwOi+Ojd4kY47mZZxl+iEhpwsibBZM1l1MsDTxrARQDnyUBvrz5gr6rHgPdtFV
         /uLiX5K3QQ42kJi7aXjR6s63N4KI6/1Gzb9CyI1PJqW4b6/DjEc5QH5v5aP8THCEtZ8W
         KQdhmUR1oVexwWyz8zc/VCD+lLVCK5kELkgPGTQF7iV0lT9JMIlNqh8IBaTwZ84TRL+S
         X3uA==
X-Forwarded-Encrypted: i=1; AJvYcCWXFwN1WsZL9VStR9RN6n73eG9GD9qpjPDv9eGxzWck9JTwJ7DXjrVsxO17OpKD/vVBeVnspPugFeVg0Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTYjaDW/IpR72E6DMqrb862DxAfkERKrSD7WkjeTlFeyrXxma
	Z/XGvIaj3J54Rj1VOxZx+REYTSSBHPuLhRsVlhS+s438SYlbwGONwDzb
X-Gm-Gg: ASbGncugZZXTtb+5ELIsYW3vlXYHi5jgPqV1OLnTNJSgJfENurqWhMb0KOwEjkS7KvT
	Kn2mSsNMuykzRPt54exh7QFbSo6y9dIw77rwxqyuFv9pFarYUnC7P7R147v6kh29TUwM4z4EYrc
	o6xPbCdlKC6/2nvz84Cux3B8vqBuk2w3W7AqsH0fvGFKK1meiFWYUlP4V6TK9ZJTxgodupyAXMR
	DJbW/lIO5U10C8k6OKEQzzYnB/ghOwNbrMmF+qZaOr3qTWZR6JuW9Ak4IIeSkHSxGsKIREsoWEe
	fuqXM+5/uMQBofAxKjfCqzjRqE45KGjURdajXkRzX0FyQH8WRgqkAdwLs9oJQrMjM9q6sMymY3s
	vvpwOUsXn6RHk8/6rgtHm5WA5UM4h
X-Google-Smtp-Source: AGHT+IFWulHN5lakrvfB1yKPVtAR0ebBNhrheh2w9WyUFz7tvjAD0QDG5YOMbXfP9MF4shPuaprcoQ==
X-Received: by 2002:a05:6000:400d:b0:3d6:1610:1b6a with SMTP id ffacd0b85a97d-3d616101e3dmr2729303f8f.22.1756729573969;
        Mon, 01 Sep 2025 05:26:13 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:13 -0700 (PDT)
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
Subject: [PATCH v6 15/16] drm/vkms: Allow to update the connector status
Date: Mon,  1 Sep 2025 14:25:40 +0200
Message-ID: <20250901122541.9983-16-jose.exposito89@gmail.com>
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

Implement the drm_connector_funcs.detect() callback to update the
connector status by returning the status stored in the configuration.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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


