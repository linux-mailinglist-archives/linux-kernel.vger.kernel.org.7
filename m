Return-Path: <linux-kernel+bounces-891695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1BBC43452
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B930188D734
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FBC28C5AA;
	Sat,  8 Nov 2025 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1PmW/JV"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230928489E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631421; cv=none; b=FcBvDdkbvnbG8FzhgZAcEvo2JrbUzAYTI6EtyG/62hi0XutCMcr78x6kj1aMwiE2JXaArg6YHTqutsdxbC8yvT9d9q+GA3YQryb5qYIOivF/cJ3X54v8x8VmwqD+ONkG3Yknm8g7QAfjfG3ehFsOCIcSH46mG0IGv4dwtvML2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631421; c=relaxed/simple;
	bh=2StCs3EURjKPyD1NJdn+eRFh+P0L0raQMR+9SDN0Mf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZlHJCcIkHG/cp3TWWeuHdKCluL7V7ufI70wksyZCuGp6NtW1Fuv+y3FK9vj0wJJDkjElxd6SecjCPWwYOOMTvjaNKeaDv7G3wslJfEISDvQaYbQ0ETSDx9xS4Du/wpxTCLP3n/qoVpIgDN4qMrJDAGHMVsTkERM7wXLYYL8m/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1PmW/JV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso9004965e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762631418; x=1763236218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTErcnYX+Ce1Mb0cQ/tmSFUfGgG0iezGcfWDSHlRH28=;
        b=X1PmW/JV4eHOp1om6OpEYUkIqia9ca1fIeulPqR3idqtH0KYcsWcE/ho2YxXeMTHCK
         /JKpj+pgguHj17oV7wyCToQBC/Vu5a+1SgiXrSb3HrwAXAT/I+LnxVyNVDz8l5fjsKJw
         51gOgHH+8ZQ4unBcvxM0jfziMkQm8/cPZ24FBwiyfGhtGpAXWFl8sK99kqHS4b9392eI
         C8caNk15Xg98ndeLQkGfZsS7ev7IYIUARz33ZgOPxPjadFUY0Rt9FghzVGAiwtdHz+W1
         16RdB23pLso9SClZDc/5jW4zCBmk+uSwwhwiwyx6yzklC9r56BKTOXloRNX6YJ2nFzsD
         WRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762631418; x=1763236218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wTErcnYX+Ce1Mb0cQ/tmSFUfGgG0iezGcfWDSHlRH28=;
        b=el+esPbbmR0itoYv9NdJXLgu+Zgu6+c5jN0dPfJgcJgxC2rz2Wz3cHrGvYPQue7YKF
         g5cvYnx+IDXNCpJ0xATUOb5odXWKdi1tsji8SEv11LFLRRNG+A/HPQLKc9MfXh+mM6Ax
         DkSyjtu+BvkRw6ee/jesiNNtwF2f5IFghK4/ysvlUsgXSGABAGahS6q/APiN+xIty6qw
         3fosTfxb2QLg/Y/QbBVclqKKId2hqMcclY4riWlkwNxVUmIx0+xyX+cIO+U2E/9W5z5/
         uzhm//5juPyBgD0Y1g5cwM4e4us1RIyw+L5hxQop7j1LYwsGktXHr5QMBy4qsQasXZ9n
         1vug==
X-Gm-Message-State: AOJu0Yzt1c9j5U7Qq19gyRwMy/GS7S02pD8tiVorTlXz+JU/31o2rTWR
	tblB76PmESLjEnNUrLdl2vC51KkoiMZEgHPDfVHfxPWQJ2Yx5zBelz2O2T614A==
X-Gm-Gg: ASbGncshirmCqn8qEWXSUinLrZxqbHaCUNZrmvUZOaLaXMaGYDqZG3dZkdptRZdZTtO
	99Iedo78pogXnylgGQQovYfe1so/zjhhgIazLWpZGSHfxnWaITNLezNwGmW2e2cgh/WojSjn6Ob
	50b3rr1srK3SZsaBURbiMMRtNy6IYPnVvX23W9yoGprmDTRP1vA+33ZBs+IGQZAOvnYTgEUhJXW
	Dv/rbqyTKxT3IousXYR8HEKSIUJztD9ZWRYz3/ZzV7fOlZ/oKoM27c+GHulFY0niLG08TCnQGXN
	7+gqx7yQ0G71PM8pZgMfV1TAv9DIvL6V/01BP1MPXqta3s/G7b/VIhIYd0kWegFqo1Md9oxZJrT
	vYjGlF1RDb37of7lMc2EV+dzhqP3baZ3E6+e9B2kEmjbKhcCdOQ/9BuKHfX2TrwBVHSPNfTh2GI
	6pt1vKy8cJwBc6lbgCm7U7
X-Google-Smtp-Source: AGHT+IEH/b7pHKnY1anHYgYBmHLRygxIbG7U8tQjG1nHRxCMqpqETqU/RlUFAKuvVjweQbQ7cR35GQ==
X-Received: by 2002:a05:600c:1912:b0:477:7946:dcf4 with SMTP id 5b1f17b1804b1-4777946df44mr499715e9.24.1762631417554;
        Sat, 08 Nov 2025 11:50:17 -0800 (PST)
Received: from fedora ([156.208.73.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33bdsm233461435e9.1.2025.11.08.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:50:17 -0800 (PST)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	James Jones <jajones@nvidia.com>
Subject: [PATCH v5 5/5] drm/nouveau/drm: Bump the driver version to 1.4.1 to report new features
Date: Sat,  8 Nov 2025 21:49:19 +0200
Message-ID: <20251108194919.68754-6-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251108194919.68754-1-mohamedahmedegypt2001@gmail.com>
References: <20251108194919.68754-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW can only do compression on large and huge pages, and enabling it on
4K pages leads to a MMU fault. Compression also needs kernel support for
handling the compressed kinds and managing the compression tags.

This increments the nouveau version number which allows NVK to enable it
only when the kernel actually supports both features and avoid breaking
the system if a newer mesa version is paired with an older kernel version.

For the associated userspace MR, please see !36450:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: James Jones <jajones@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 55abc510067b..e5de4367e2cc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -10,7 +10,7 @@
 
 #define DRIVER_MAJOR		1
 #define DRIVER_MINOR		4
-#define DRIVER_PATCHLEVEL	0
+#define DRIVER_PATCHLEVEL	1
 
 /*
  * 1.1.1:
@@ -35,6 +35,8 @@
  *        programs that get directly linked with NVKM.
  * 1.3.1:
  *      - implemented limited ABI16/NVIF interop
+ * 1.4.1:
+ *      - add variable page sizes and compression for Turing+
  */
 
 #include <linux/notifier.h>
-- 
2.51.1


