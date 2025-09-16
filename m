Return-Path: <linux-kernel+bounces-819610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 389ECB5A3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DC91BC7C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716B2F9D8E;
	Tue, 16 Sep 2025 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY+WTfQT"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4242EA49E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056919; cv=none; b=VKZC7sF8yo5j6OLW/9uOD2x9oGuccQuvCFs/dmB1RfAuyzg7UnDbQW/np+fwoNOy3AJ25tSsbU84yp2d+DXk4auWMBsU9hHvhdHM5KKTCrfYgpmpBK+JCJ5vaQ5y7cHMYrh2xiVeOuFxu4xVoRi8cBXUNE6/FfqblYHx6V8sN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056919; c=relaxed/simple;
	bh=lRiTjxprqSJ8kiHLjob7HydP68eV7ZSfYw02NKw6B50=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIGxBcdLB0sX6QIuv7CpplbQXONKoEvA3n/cOWWvRw2UNkZdREf/LS9AYDTQfy/wPsyhH78FP7hkbUOxzhd4XwDy25+zt0Doo29zo0Uo+9+yWKIM4H3zsCVb4OiWjoHUhQ2Ho8nHvMqhZVb4NcEFSVCXVGuAO1efDN04ixtPiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY+WTfQT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7742adc1f25so4129416b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056918; x=1758661718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDRqddRbWnSp212adkMMsF7xlrSYegdf6W4aAStaDzw=;
        b=OY+WTfQTOsuDDbkbXV7xWutSPH5YRAak6Za4w3x2HUYInc+KdnorAEMGV2DrmrxKbE
         LFbacEn6ZJXS+6613qiKYIbj3cgK5vWVNxdikxzDD7qUnbwFIO9asaY69SC4HNl2zXsy
         OVszLyUR57+DwznuHaIwtRG8+hpgnKqYncdJMgCrMJc0cuFhdHnrR8Zdo1szXSuM2Cst
         PLTqxVrDKznWawc2yTGwOImIaV/iaAGVOxjnGxoy2/w5YH+2uxARLtq68eLU8OlvhLm3
         GeJDvxK3rsx5X5Cq8OCRMiphdkqH2SYQDghkAkcCXcddGqGEmNcLFD/nprNkIIO4liaF
         FYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056918; x=1758661718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDRqddRbWnSp212adkMMsF7xlrSYegdf6W4aAStaDzw=;
        b=X8vT/CO/YEQaz/lBRn1jx3QgdFDM6RIHngBhyGxWZZWrCuUEkoMjfGJHHlZui2NF2h
         6hKeXewYUE/n+1LJOVn1NTflY+lW8rZVnC9EydWr8PV5E8FGoJhnuGCjDwn+ATe5z7Mg
         GNQbjkcoyV9qu5yfUMjYube4gdotERlrdSDyL+xnmNFIB278XC8CA0GNDrMhUbdriRRS
         dAlrNqVF9b5jBsKdB/BZ9IEsWcT+UVoueS59QN0G5o4dKSYay3c/h+DeQ0j0NLrh8fQU
         HZE2hQtSDNv8/1G1bnEbhktS1vWOYVaB2OWu0pV02PmNnwfn5aGn1OlV+j7Fl9Z5x/ME
         eUtA==
X-Forwarded-Encrypted: i=1; AJvYcCWOwuBiGXZfad4sDJxXc4cIvS/PPeGivk8cYZvvFNkPfs1mIJvqCdY0D5IfPXfmaY/0Ym8udapmsb3dqUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVHnRtsFyfkJGz8iC9a0teYgQRwwGEYlwovbyvQb3NE5iltLr
	xYItp+hDXTqbuhtCZckhP7B+5MZ2pyPVln4/dQjFgOA0I6X0bS8ia4NO
X-Gm-Gg: ASbGncuHi99AsEaV9qZmE+6RBNQKEXE6sgKVQ5nNsP1Ds7CPTYKuoUGlDZpO9pgvc8Q
	Xxh9qgbhjMteZvEWaPhRw0ShSf+AFmZ9LhHwAkeJJa7CMpC7UewfuwGs+zHMgH6BIZVI+tBqJy4
	ye54DPQhhNuRL/KqCFtRwb20iTZy72XV7O0AFRlvNKkJgiBQ6I37djWbEAbN7YzbTOBhJT+4Geg
	9RB864MpptPb8IROf947wMBoa5b48ccqiX/y+Kx+zQjjQj6BMA86aiMv1bhazRcZu87YUW+5oAG
	4DUyE7xXxPKD4OFLyBb+j0OAV6nL6Sz/7g2qVl+8rvo6lkbHYq//Z4O4QKyWv04+vkKAniqcnEB
	uDv5X0NN09fPDVo9zs4sXffCw7Jg0IYAKcS9btOptCwkW5lkAOE3wN9buuETponI4rvg3TXobTE
	3QelrI+Wt68Q==
X-Google-Smtp-Source: AGHT+IFqIksmyW/Ei+gsNzE/y26dEL610pe2Xvan+bTy3nUCeeTaK31LsY9L5E5gLin/D821NBOB7w==
X-Received: by 2002:a05:6a00:806:b0:771:edda:1b9c with SMTP id d2e1a72fcca58-77612093489mr21540222b3a.14.1758056917576;
        Tue, 16 Sep 2025 14:08:37 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607b18400sm16984805b3a.59.2025.09.16.14.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:37 -0700 (PDT)
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
Subject: [PATCH 06/10] drm/panthor: remove write_cmd
Date: Tue, 16 Sep 2025 14:08:19 -0700
Message-ID: <20250916210823.4033529-7-olvaffe@gmail.com>
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

Call mmu_hw_wait_ready explicitly instead.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 46 +++++++++++++++------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 7d1645a24129d..373871aeea9f4 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -533,18 +533,6 @@ static int mmu_hw_wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	return ret;
 }
 
-static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
-{
-	int status;
-
-	/* write AS_COMMAND when MMU is ready to accept another command */
-	status = mmu_hw_wait_ready(ptdev, as_nr);
-	if (!status)
-		gpu_write(ptdev, AS_COMMAND(as_nr), cmd);
-
-	return status;
-}
-
 /**
  * mmu_hw_cmd_update() - Issue an UPDATE command
  * @ptdev: Device.
@@ -556,14 +544,14 @@ static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
  * Issue an UPDATE command to invalidate MMU caches and update the translation
  * table.
  */
-static int mmu_hw_cmd_update(struct panthor_device *ptdev, u32 as_nr, u64 transtab, u64 transcfg,
-			     u64 memattr)
+static void mmu_hw_cmd_update(struct panthor_device *ptdev, u32 as_nr, u64 transtab, u64 transcfg,
+			      u64 memattr)
 {
 	gpu_write64(ptdev, AS_TRANSTAB(as_nr), transtab);
 	gpu_write64(ptdev, AS_MEMATTR(as_nr), memattr);
 	gpu_write64(ptdev, AS_TRANSCFG(as_nr), transcfg);
 
-	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
+	gpu_write(ptdev, AS_COMMAND(as_nr), AS_COMMAND_UPDATE);
 }
 
 /**
@@ -606,7 +594,7 @@ static void mmu_hw_cmd_lock(struct panthor_device *ptdev, u32 as_nr, u64 region_
 
 	/* Lock the region that needs to be updated */
 	gpu_write64(ptdev, AS_LOCKADDR(as_nr), region);
-	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
+	gpu_write(ptdev, AS_COMMAND(as_nr), AS_COMMAND_LOCK);
 }
 
 /**
@@ -619,7 +607,7 @@ static void mmu_hw_cmd_lock(struct panthor_device *ptdev, u32 as_nr, u64 region_
  */
 static void mmu_hw_cmd_unlock(struct panthor_device *ptdev, u32 as_nr)
 {
-	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
+	gpu_write(ptdev, AS_COMMAND(as_nr), AS_COMMAND_UNLOCK);
 }
 
 /**
@@ -664,7 +652,9 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
 	 * power it up
 	 */
 
-	mmu_hw_cmd_lock(ptdev, as_nr, iova, size);
+	ret = mmu_hw_wait_ready(ptdev, as_nr);
+	if (!ret)
+		mmu_hw_cmd_lock(ptdev, as_nr, iova, size);
 
 	ret = mmu_hw_wait_ready(ptdev, as_nr);
 	if (ret)
@@ -679,7 +669,9 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
 	 * at the end of the GPU_CONTROL cache flush command, unlike
 	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
 	 */
-	mmu_hw_cmd_unlock(ptdev, as_nr);
+	ret = mmu_hw_wait_ready(ptdev, as_nr);
+	if (!ret)
+		mmu_hw_cmd_unlock(ptdev, as_nr);
 
 	/* Wait for the unlock command to complete */
 	return mmu_hw_wait_ready(ptdev, as_nr);
@@ -707,7 +699,13 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 	if (ret)
 		return ret;
 
-	return mmu_hw_cmd_update(ptdev, as_nr, transtab, transcfg, memattr);
+	ret = mmu_hw_wait_ready(ptdev, as_nr);
+	if (ret)
+		return ret;
+
+	mmu_hw_cmd_update(ptdev, as_nr, transtab, transcfg, memattr);
+
+	return 0;
 }
 
 static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
@@ -718,7 +716,13 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
 	if (ret)
 		return ret;
 
-	return mmu_hw_cmd_update(ptdev, as_nr, 0, AS_TRANSCFG_ADRMODE_UNMAPPED, 0);
+	ret = mmu_hw_wait_ready(ptdev, as_nr);
+	if (ret)
+		return ret;
+
+	mmu_hw_cmd_update(ptdev, as_nr, 0, AS_TRANSCFG_ADRMODE_UNMAPPED, 0);
+
+	return 0;
 }
 
 static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)
-- 
2.51.0.384.g4c02a37b29-goog


