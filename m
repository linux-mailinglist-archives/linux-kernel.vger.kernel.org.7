Return-Path: <linux-kernel+bounces-819608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E55DB5A3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C177A527257
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856372EA74C;
	Tue, 16 Sep 2025 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0aS1tCn"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C12E0927
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056917; cv=none; b=akibfAqXwthVFepLJmf0koqQy4rzKlemBD2fl3PRYb4ofl1SWPFZWetGyuXGMCtLiFTmx30US0ZljCCoItjWsUmsFmKzb/PpZy/57GpvB2eTCUYgkGxhDpBUm17tMwJ9m74hvPNMM38vtJkqa5IILfCZxhTAfa4iKhX+7mztzCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056917; c=relaxed/simple;
	bh=keetleYLbtbVy91k6dr/luSH+DnOKYGG3IugmPX2Jx8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBX6vfAJuAzKheuF/IEKfTbbt0ARwC0RubGYudEdr8lFjOjlbw9Yr82W0ILRe60Yqtm3mruuBAGOZCW+4x0bVqrUuPlkb4prrR/ieUqiWewvR02th23ExJ6yUFGQpV6RLhlvBXNaXFfj/50Q2oDtxuNpslFZEbVXff77ZhlT/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0aS1tCn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so258540b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056916; x=1758661716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qBTryJ9bSqwjcArHStS8Ii28Lxu8QftxwwZnxNDyHM=;
        b=B0aS1tCn1rqgACU/NIHZHbSSX6QutXdFWxAoAE7qBWbHTNvEDZqBx5HK0BBKWfzNn9
         EIrVCBZCoPLs1t0OXTGiYfUOkILR5mzZIzphVMVyhc3mpy9BvfXafZ90V3kfSEgMHZAu
         xTkW4FHXGEqefu/pChI0UM0fy0XypY/uJT8mUrhpoZkGJEaOrU9gBwm7JlO+qsUh0/03
         v5EA2bPxz7frr614/w8V3xvfIyQhH0ro8UtarPaGp0oh12i4aTeQPHzvbGSnB3wfwXzC
         DVI73+f+p1v5umZ/+CIiTfyaPnpTKHrZMT3vv6MNrPIt5yu8os3PUhwsc0rk88GiQ/iH
         MPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056916; x=1758661716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qBTryJ9bSqwjcArHStS8Ii28Lxu8QftxwwZnxNDyHM=;
        b=GjQ9Gz4fpDT1RqtJq0zfYP2wwNy1zNnhsVs8Xui5ZK1zFC3nP7afHr6HIkAyjMInuS
         +ZTA66K0xPnVetPrH2EvAkxx7da9Geobz0pvXeoGNP5LXo5+nqVvJb0bcErZK3nqkOXl
         whYoknQhYaXkcdBCiCwGu5pLY+onzgVEw1kencBtZAG9xIUTi03plZVpbZ8P0RrJ0d6s
         FpDrU62qhJ1h9fPJw8f0SWGpyK1B/szYEI3NtlXZd/H/HJGfDPHbrnWmnVW5BODVbPK5
         qNyA4SBvsqdI6es0mS5aNUCUKnY1NxjQjOWhsGxXLjHsESqljMKIHqmRDCyZdVKrKUwE
         XfXg==
X-Forwarded-Encrypted: i=1; AJvYcCWT+4Tkzp92dxEyPFf4SY2XpFoDegXHK5T85puFPOW8YX/hKPDGogTLJTVqIXq+swmpctOIorxt7ujXq/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScxtEhtnA34biKdRZWFkoRkAqnuy7KrHOqoulfEkF1g+XSi4f
	jqahvNmnjv2D99093ZyTAQFcWldTk6Fkb1OjVICeFeVLFy0NnBzZvKvxJQEW+edn
X-Gm-Gg: ASbGncvXHdIiSfO/tPJT165yNG8bgExrCeEtASzZaseu/7HFthpTjDwuTUW9J3KV698
	W8QPsgG1/0LwUveg7RTlxfBizIpswJm8P4wPI7RNq9vxfyNGBNP/+p19V25IzzUJu559dSNQmYX
	aF7Qgr7SdisCTnioFUyhPTiDvVRKSb2BNoqpsC2QSazs2IhvctW9QBSbI7iZgy/WY2aPcckqIEd
	g2v2AkzbHtvq2P6OSTvjBy9GFnUTkWH2+2KYc1up5xJ0XHuV/S1gxQT2ywKgsnKS5LVahEGZk2a
	rpvf3nW9Owmlevs8c6VkpJKcPoNHSpInYNV30Z+fgDnHS1PvliJo4yUaFcqskl51eqteoGXaZAs
	wzMEgioI23ukj+5MrYj2SsGEEHstN9Hxwwzc3NpZMVlTAgL5NROgrKEQ+xnkr9azS/QkZWmVJ91
	76U8J7SbJEDSwSkuxzvkhM
X-Google-Smtp-Source: AGHT+IHWXv3+qPwh3jeyVqrxQ3AsWNAJSiHWtN1VPL8/0k/qsLEXEMTQqUrw+IdDG19B6HX27/F2QA==
X-Received: by 2002:a05:6a00:f06:b0:770:4753:b984 with SMTP id d2e1a72fcca58-77a85f9fb2cmr4577695b3a.16.1758056915586;
        Tue, 16 Sep 2025 14:08:35 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607b18371sm17263851b3a.49.2025.09.16.14.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:35 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] drm/panthor: add mmu_hw_cmd_update
Date: Tue, 16 Sep 2025 14:08:17 -0700
Message-ID: <20250916210823.4033529-5-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916210823.4033529-1-olvaffe@gmail.com>
References: <20250916210823.4033529-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple helper for the UPDATE command.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++--------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 953348f9afdb8..727339d80d37e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -545,6 +545,27 @@ static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
 	return status;
 }
 
+/**
+ * mmu_hw_cmd_update() - Issue an UPDATE command
+ * @ptdev: Device.
+ * @as_nr: AS to issue command to.
+ * @transtab: Addr of the translation table.
+ * @transcfg: Bitmask of AS_TRANSCFG_*.
+ * @memattr: Bitmask of AS_MEMATTR_*.
+ *
+ * Issue an UPDATE command to invalidate MMU caches and update the translation
+ * table.
+ */
+static int mmu_hw_cmd_update(struct panthor_device *ptdev, u32 as_nr, u64 transtab, u64 transcfg,
+			     u64 memattr)
+{
+	gpu_write64(ptdev, AS_TRANSTAB(as_nr), transtab);
+	gpu_write64(ptdev, AS_MEMATTR(as_nr), memattr);
+	gpu_write64(ptdev, AS_TRANSCFG(as_nr), transcfg);
+
+	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
+}
+
 /**
  * mmu_hw_cmd_lock() - Issue a LOCK command
  * @ptdev: Device.
@@ -674,11 +695,7 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 	if (ret)
 		return ret;
 
-	gpu_write64(ptdev, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(ptdev, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(ptdev, AS_TRANSCFG(as_nr), transcfg);
-
-	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
+	return mmu_hw_cmd_update(ptdev, as_nr, transtab, transcfg, memattr);
 }
 
 static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
@@ -689,11 +706,7 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
 	if (ret)
 		return ret;
 
-	gpu_write64(ptdev, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(ptdev, AS_MEMATTR(as_nr), 0);
-	gpu_write64(ptdev, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
-
-	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
+	return mmu_hw_cmd_update(ptdev, as_nr, 0, AS_TRANSCFG_ADRMODE_UNMAPPED, 0);
 }
 
 static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)
-- 
2.51.0.384.g4c02a37b29-goog


