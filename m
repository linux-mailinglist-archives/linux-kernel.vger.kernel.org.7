Return-Path: <linux-kernel+bounces-880003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3FC249E5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 526E44F2EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183EA341677;
	Fri, 31 Oct 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLF7zQCu"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463C341650
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907805; cv=none; b=C6oueJnosF1sGF+WPKyzVNh2I25yX7BlawuqevFcMaCJp8pGBbM4koxkCZJla8ppqHc3f3mWkhf4643Vtz8q0d/ksRTZppe6WDQLecqM7bnZKdl1el4PMwIH9kD7/CruoHp2ndjd2HBpCQ3a9BS1KYfXLuwMvFfkF+LZMFoYbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907805; c=relaxed/simple;
	bh=TcMYHxAFSNQU8rzO3HWwSoxbbFQbT4iycTi1gAH8IEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMj4rn0oyAi+DyCBXFu3I+zixW/ZOzMEoonbtfQANPzjYvbZneD5ZotuU9p7/0JW35pa7zgRyPL3JJ98fRE7VwSbLxrgVX9djGcewOEs5xGEdk7bWdtGzBHRIlTs4cpbvYJQFh/nDL1T0xOwpjWpgGN3uRueqCds5DBDcSAgppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLF7zQCu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477365fbdf9so1910355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761907801; x=1762512601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dA6vbryG5FJTzOnmpJ+a7K24uQqVYeU0GUEiTTytsg=;
        b=FLF7zQCur6/PsyFTIt5RRxj4D1mvXdGyXIYuuzkq//egpXbTefCh2y14xJTfxkG1bO
         9G2m06NWdGNykNp5SZEIA4gCmYrwgR6cpB9IIYeZuKrNb0yFbFNW0WAFaIwe1siZ3LU4
         SPYJclN4VoeqI8gwm2XEgq1XCtnAIwF9Kgn5XuhYXFdgiBmNIpw9JbTdX/kp32oy7MZ1
         API+GKi8fy24+qwniQlevnu/iVfQSL9vDsgt3mKewed+puNGwkrNX50UkvbbuW6SuwQa
         OvDz4RoRn5EVzwf5JaZq9GO4yug2UXvrKOQHcYMRmG/khjeU2Jg8SSaqifVixZot6goj
         MhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907801; x=1762512601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dA6vbryG5FJTzOnmpJ+a7K24uQqVYeU0GUEiTTytsg=;
        b=tBF7PjbaRn/mu+pGL4pNRAMa3jstgKmdRDIFidc1zC/HFxEV6vrhEXhF+YQpZHXXRm
         6qcetSyQ8F/g4vSxDqqUzVgtVgNgAOp3bxU13xliJheYk8mJEwyiEH91CEXfAvbK33jW
         rOPCZicm0y2nO20yCBq7WQdr4WuhCFeHcGjSdNCXyXWZ1rpt9h2UEOmHmAzxC6LbmmwI
         DjrwmFxAPneZr2JRngMMmcoDvNhvUVGXt4E/4m4QeVUKBVs/V1dj2FdjNipLszalVNd7
         8wVhBBDRx7t4kLqvdYriZd2HeXxWM/XV5/vp2Kz/cFQLNzDl/PoMCIUc3XO2RSbLs7CX
         d6tg==
X-Gm-Message-State: AOJu0YyW71Y6q/qxrzzC+AL7K8DmmFGGwA3XYfZIL/3xTsnoZMeBwTLx
	yNcKUBxXeS5IZVBPmTA6iG42Gu/N5pLAdUEPltQ1gsUSOpJtqpUdDjJWC4WKcC4+
X-Gm-Gg: ASbGnct4oGY+yuDTnltXwZx1INMHOjlJAlcoCAuJ+8nxU2CGPepZCSAQD1vZs/l8Olr
	J+v9x7CnP40RLk/qHTtU59WM2ipb2IuAGBIjqoh/ST7tb/wWgDL7rs9kB//bMjlh3FYnw3+QOYf
	0a1h9QA/m8sgIQvNebZr0HzmbOgcTftK131jRxyayFw/Ux1hM5Kh10sIx3gbGq456MdqfGOAhII
	ZfXnOKwnwwE90q4dJWPj5K3g5eBXX167enbpirqiQqHRNb3uEpWuukP5IRlgzexpnJJ7KxDogGJ
	0cHYdg48WTRmyYKIoM6xNxQpqc10BS24aeNGOyhj42F8mMac0ZKJSHbpQPEzbXmZDsw3lJ0IGjQ
	WLnYh6boKSD+9a4SkyvxeAQa6CXts4nxjvD1RvTWC9jW7mXhv0HMjPaUNNFivISuuW75RVa2aD7
	edoIu//J9s06k=
X-Google-Smtp-Source: AGHT+IH/r8r9Jm7r+3RjWu3MCytnOGOVgf0e0BCmGVPobUnq/iGDiuY9nhgRfW9d1lM1G2bqZQoWNQ==
X-Received: by 2002:a05:600c:4591:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-4773087b19bmr24942025e9.26.1761907800917;
        Fri, 31 Oct 2025 03:50:00 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcf7d07sm19498025e9.9.2025.10.31.03.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:50:00 -0700 (PDT)
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
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v4 5/5] drm/nouveau/drm: Bump the driver version to 1.4.1 to report new features
Date: Fri, 31 Oct 2025 12:49:24 +0200
Message-ID: <20251031104924.10631-6-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
References: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
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


