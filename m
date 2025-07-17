Return-Path: <linux-kernel+bounces-735647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6ECB09211
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174FE584937
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841F12FCFC5;
	Thu, 17 Jul 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="AV7FLX7y"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A682FCE02
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770501; cv=none; b=nv2AsNH+lT+TPNnvcSgL+UZdomEflc3ifp11j4cMFK1vFIveEOIMAgPIWhE/V8Byw6YBPLGNROWNchlfV97mz29UqzrhCrnXPl0OFNfPinsaDQlj+rnscPri7nKjWJC/uoLErCrHf/nwPQ6kCgtma2THs1DALGqpChN/LXWE/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770501; c=relaxed/simple;
	bh=YLKILSjo4gQh4BZ0qx0l+2zG73ZqW4nHbnOsQdg4SY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy/tX6o26GzYCjUipbQOUbhmIJCMrzSVYWLYTkP9lb1X7FwJ/Zpk9f+JBGA8vcE8lKgxqs7contFesb8nlBAsUMQC3KEYy9kM6yDwXcr272zBnqMxSiPZq5on4peG7XVtiZUa4b1cA5noMjEfIsVSyTP1ZtiJBChB0rWbCOx5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=AV7FLX7y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b9dfb842so10414395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752770500; x=1753375300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXRb/auSmvjfek8uJ1YIyvtZo0QCAaoEdhxcCrHaPWM=;
        b=AV7FLX7y+fV6nsu41mI21vh4QDqu723UcrRMzIKKYlDUGQxehIvaBqy6hxU3tmFrow
         WX+G939JthcDk6VDs4y+nwcBtmF3WUZzwEI2WFSslzcuTvYH7k4WkXagoGXcgGXU218R
         /zyGQva1033IZ4U2Lu87eVbEKUeDIPQ6eDaJ+foLcGtQDjZmar10g4m0ZU6LmK0lbkns
         6qbo/ujOVu1juWUCnZu9eVR8qL3hHlpAL2YSTL/8xVjWdQbHL333AI4VkO3tAD34Mj7L
         OnbB43Z6Dz56/uccHtcaGAXqvju/JjBUdrPiQ5AHy6uyNm3Z4cTIaXddDg3jeL9NE9AO
         wMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770500; x=1753375300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXRb/auSmvjfek8uJ1YIyvtZo0QCAaoEdhxcCrHaPWM=;
        b=F+VVz5VtPVmMpV90Egpooc4GBggfPiknbwV9DHnmyCnaM1OyQC8YDI/bH3c2ACBKYn
         fqL6SGvbPjIGWEIu7TmOECfs0Y1iecangPI99vgSFhYcgS0gjdhjIVtfwOiliFJAbzQ8
         DO57B5orJ7/rDOGxNw9e1IpEh8pS05LS+5t2x9E3WMH4zoVyOC6wORjy7K/q1exMP8Fz
         0/opwNBlc8tq/EE0tYz5oHkRzGW1yOnsymcLV/HsAUAzv5wC7jRoU2ELnfC81GDsGPy2
         lamME7WsN333zlVC8c5TjMeTHct5DbhANqR5L1Eppg5vMIBHZGclj7AFDmOK38HP26B7
         s6kw==
X-Forwarded-Encrypted: i=1; AJvYcCUNxGgQxMXT2iKsVQG44vgjekOIefmd/K7bybqmRqLjShUZXyUxCjl50emW8TzUh6GfKUQDP0tp3szp5r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/lTDy0Iw7qsZib5tU489eFTpAgx/J6QcyQ0hIiRmmXihbJqy
	/KTZ2QczI6DBY52GEhJep21jEiSIRZsdBWUDN66KMTYaTZq4GdCVDWMEcACRobDaHug=
X-Gm-Gg: ASbGncsALZuOmWCaV8bEuFOxQotjc4f1fnTVkmBjN5TCKwUVFUPZvnI4+zvVFN/Wr9k
	yfVBQfPTklP5NBRRZmBbOYAehAhOLO7MZnAnBQ+93DxHWuONajtCfHiMvC+7GfevDyoYmQ5CxSL
	SKfyDFmk2x91njEykPRY4eAm1Gh8vWSsO4j1YZAhWgalhDv8bslFZKCUQ1K8sDfmpQzXg46+L1+
	Lzd+gwmC8lW4N6EDKgObNweeBpRQITFcAUKCJRsWf6zdKhUqb1V9nX+rgEIM1HfDJYqtYO5wyIQ
	w9uSjxym+lwSqKo11FgbW+DFW5hbq+oxjFucBQtRZK9eKMBraAtjCoTXcu+7bREutC+XTiU2Rd7
	6EFbYIIYSHsvx9iE7e1vM6PrWX0pH0kNdVVEX8cOw6NPRg4bUqFOYnoNu1k+e
X-Google-Smtp-Source: AGHT+IHQUhEP8RVdomUjbzwvcSpmkLRrN2k+b3W2P/yZEwrE1afYAZj5NI3TgnCfzxILvDYUugHslQ==
X-Received: by 2002:a17:90b:4e:b0:31c:15da:2175 with SMTP id 98e67ed59e1d1-31c9f47c6e9mr10439506a91.9.1752770499083;
        Thu, 17 Jul 2025 09:41:39 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7e8ae4sm1821750a91.24.2025.07.17.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:41:38 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	diogo.ivo@tecnico.ulisboa.pt,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v4 1/4] drm: Create mipi_dsi_dual macro
Date: Thu, 17 Jul 2025 10:40:49 -0600
Message-ID: <20250717164053.284969-2-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717164053.284969-1-me@brighamcampbell.com>
References: <20250717164053.284969-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create mipi_dsi_dual macro for panels which are driven by two parallel
serial interfaces. This allows for the reduction of code duplication in
drivers for these panels.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 include/drm/drm_mipi_dsi.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 369b0d8830c3..03199c966ea5 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -431,6 +431,30 @@ void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx);
 		mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d)); \
 	} while (0)
 
+/**
+ * mipi_dsi_dual - send the same MIPI DSI command to two interfaces
+ *
+ * This macro will send the specified MIPI DSI command twice, once per each of
+ * the two interfaces supplied. This is useful for reducing duplication of code
+ * in panel drivers which use two parallel serial interfaces.
+ *
+ * @_func: MIPI DSI function or macro to pass context and arguments into
+ * @_dsi1: First DSI interface to act as recipient of the MIPI DSI command
+ * @_dsi2: Second DSI interface to act as recipient of the MIPI DSI command
+ * @_ctx: Context for multiple DSI transactions
+ * @...: Arguments to pass to MIPI DSI function or macro
+ */
+#define mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...)		 \
+	_mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ##__VA_ARGS__)
+
+#define _mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...) \
+	do {					       \
+		(_ctx)->dsi = (_dsi1);		       \
+		_func((_ctx), ##__VA_ARGS__);	       \
+		(_ctx)->dsi = (_dsi2);		       \
+		_func((_ctx), ##__VA_ARGS__);	       \
+	} while (0)
+
 /**
  * struct mipi_dsi_driver - DSI driver
  * @driver: device driver model driver
-- 
2.50.1


