Return-Path: <linux-kernel+bounces-819606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D91BEB5A3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CD23A43E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694F22E11C5;
	Tue, 16 Sep 2025 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9N0xzyf"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7A285406
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056915; cv=none; b=LbdUdhys+Y7oRR7oPyDDQLpLAsqJExzz5yDyO+PKGJ2uTeDPpSegNkYRxJSvSzH8WVGVqXdWYZ+ndDtjFKepvvyqKGoJo/sjhshxpuJ6Yta+nr47lmKLsK1iAkth+/D/XM2bVZ2Yz/vbhFoGWNvAbr/RcZSO7l11puOjNFzFpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056915; c=relaxed/simple;
	bh=DlLhTKO7E6kipPFiDWDrXkdNVJqENLuVKM7fTBvX0cw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtStLlH/NL6+UI4Ov/weiV+wwQTA0qcyVLB0KgW36MAa9eHN/V+RF81xJpqxi1ZqtudfL1htaKroL7WcDqouM6pvP5/jECn8wms83WvLfyzaBT2LsdxXF/Qxndn66jDpmrWQSaOivnGJut2MxbW4hjmP39U/sCoKw/rWxnKSkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9N0xzyf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77287fb79d3so4555466b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056913; x=1758661713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aO3jHV+TCdh3X4sNWUTMqSI+YaJsDjuOHp0znGhivY=;
        b=U9N0xzyfEQUBL8PK1losqd20q4K2VTGX7CBUYDv9hJu7fUwk9ecySeZl6FekaKeBnV
         xMeQJkMS+TF6874Bbjt0iTUl0yYkEsaX9tZWwiHjyOtCcUlfAVQFpxa2NN9FTm8OjsYz
         C1MYcfG+GlK0IZNGWHOQOQx+H4CunbkIEAvvWPUkrqXuJHZKCHciBgKVilg23o12G31M
         pD071wBahvmnJAk5a3Mi189akA/CCorbjIeFXLFk+r2PRVnryyiWIf42tCvC3Gpa3Kbf
         hDRYS9oPaznL9zaeGH8XwtPL2SjcfCVw2/bzvSbmg9Wmk3RbrVFwFatWuk8btQpHaMMI
         rBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056913; x=1758661713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aO3jHV+TCdh3X4sNWUTMqSI+YaJsDjuOHp0znGhivY=;
        b=XI8TXgmIxsTn3yQm7dMphM/Hok/OdHhaNE4iPlIoKyCijU7HWoTiem6cfajM0cZyo3
         moG4oRzD7a2XeU0//UklL7HemmPpihlMfgL5QDuXC18ZZqTyiuGjcZJcNRLUrbJAy85l
         RUW77qkz7kHM5tmAru9yUzdUQ1Wo/einrtjuGK6CSv32eTa576Q3ytUPNDPN8yTzBIzJ
         bYmlcfWziHdk0jFS5UOVbF7gaeiPpLGoouGNSvL93TZzYDdKu7UVES0UWheUWBj9LW5h
         5IicSwgHNlcLNCYfUSkJoOFCBMMseZGqLRKrow4MvPsl+xYOh5YfmMqSPd6Pd6yN6RJ/
         /t4w==
X-Forwarded-Encrypted: i=1; AJvYcCUHgcjiBuXpBVVC417gFlFuzQuIFoudkKfG0yuZ9ZWUo8wjMgst5uZmDsR3nYCyObARMRqHWinxKMKs8K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZcf/2jF+tkeqDPQsnBBEXUn7nWnz9WbdCCLPzaBb8jBy7M4/
	0dI55/JXXX92wteRxy3jCo9mUVsISelka1XyEpVoWUX2d2ZBF7ziAYlvpkp8/iiE
X-Gm-Gg: ASbGncvRiiyLAP/7SOwx2ncq1sa+NSMfxWFs56yhvk9FVB3Osc56OXn7oJhvORAlTVx
	iNTIDt7z0xwedYI6fjf72R9DTSi1cXA4NEU1y2bunkJi9LcGQt5YmShyZAon1WGFmQWzecs2vlj
	JgX/qXdfs9htPu4vucM4IAf3HT9qUpAAdeSeRpGxWZksVulXyX+CqCkCjBNwpOOjKt9arMLDEOA
	WZqbAuLQieEqL8xFLLCShZ8X03ezLXn+6dk44h4DZo/WK0eL5kKXqbxC3LzhR/+b0sw1aYE01ps
	197uWOdJp2V7HJ/xOkONi6raYWJGPEekBQz/JR65NnQ6D58PDWUzOTknX5jQProrfDu+nCl1xgI
	rIXmkKlVu88AjGT3FAObh0avETs5TJ4z/s+VD4dPzwZIFE7vmWdBbIVERWessTAo7m9ppYiZ6cB
	xGQEuVUd9+ieI0xfoAwapu
X-Google-Smtp-Source: AGHT+IErllrXZhiuO08ZvjuaFN67hMPleqZ0DLgAdBUq+kGFJqCmxYGCY5kLycBvM6DB//Dz8cM39w==
X-Received: by 2002:a05:6a00:1415:b0:776:1dbf:375b with SMTP id d2e1a72fcca58-7761dbf39f0mr18060001b3a.6.1758056913491;
        Tue, 16 Sep 2025 14:08:33 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607b392fcsm16649240b3a.87.2025.09.16.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:33 -0700 (PDT)
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
Subject: [PATCH 02/10] drm/panthor: rename and document lock_region
Date: Tue, 16 Sep 2025 14:08:15 -0700
Message-ID: <20250916210823.4033529-3-olvaffe@gmail.com>
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

Rename lock_region to mmu_hw_cmd_lock.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d3af4f79012b4..8600d98842345 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -545,8 +545,17 @@ static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
 	return status;
 }
 
-static void lock_region(struct panthor_device *ptdev, u32 as_nr,
-			u64 region_start, u64 size)
+/**
+ * mmu_hw_cmd_lock() - Issue a LOCK command
+ * @ptdev: Device.
+ * @as_nr: AS to issue command to.
+ * @region_start: Start of the region.
+ * @size: Size of the region.
+ *
+ * Issue a LOCK command to invalidate MMU caches and block future transactions
+ * for a region.
+ */
+static void mmu_hw_cmd_lock(struct panthor_device *ptdev, u32 as_nr, u64 region_start, u64 size)
 {
 	u8 region_width;
 	u64 region;
@@ -609,7 +618,7 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 	 * power it up
 	 */
 
-	lock_region(ptdev, as_nr, iova, size);
+	mmu_hw_cmd_lock(ptdev, as_nr, iova, size);
 
 	ret = mmu_hw_wait_ready(ptdev, as_nr);
 	if (ret)
-- 
2.51.0.384.g4c02a37b29-goog


