Return-Path: <linux-kernel+bounces-819609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419DFB5A3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0A41BC7F00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527C2F7459;
	Tue, 16 Sep 2025 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDWR8QtP"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6E2E611B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056919; cv=none; b=XDoijXzEmmEcKqvgZnqwROvmQGY9/OqwR66fFYAeTOCw6sdleMXvpoX2wceP47ZkU7U9cdbB8dkP6YrY1MvyuSFLWj3iuYfe6FhZDnWvDuNVUwX3xS17i2q3chqq+hHOkIZDQNjWFVIHDSGyKzsvpXtr6wjZuaLNe5B20JKHxvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056919; c=relaxed/simple;
	bh=rUOe8IkoOXsmgpjJgtwR9upz3gOCN2NNsz7526Ug3YA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCleB1ngHjplIFe74KluV3wXMlRiKSynu6Ez1b0cdvkTMtNXlKbdNc21nLrVxj5ytscPHIlzxRMlrrcMt/t8JKMCoa39stfZPz4p1Jwg6eIPBMAlZXnWKgcI2Prx0tpMPLdg+x2QlIeKX4gZoQtBF033XB0lYEFCJaONvVySuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDWR8QtP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7723f0924a3so7286883b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056916; x=1758661716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHrHFP5MPt+x13uBQjsAS3MLabqAvc4S+eyVJ4ZEW6M=;
        b=eDWR8QtPp11t504GNUeKFrLH8Oqhpopx/aNn7g7BLXuh4gthw9MsINROZBvjWMiRiB
         KUEpp9J3mRLDfVY9H+tRtvYQ7Z1E0vAqxCmke5MDpALiPlwpf/mIU87dGB6cSnvyISow
         jOsG6ejVXTAZLSaPskEPgQMMlXGC5CV5dsOyxdY77t8/ef9KjDcv27n3/h/UEqzUa+8N
         exYX1Er8OYp0n7lTkvrTNSPDyBtt9NFG0Yi9Zg2gOg4hdDezwGWFlVhn7d9hKUCokz5c
         Dja8Z2lEzuWrMKv4X6DmwrQlliptQ53MDTRnBzhiWNBqKgmA1mocx4BvbFhD2rEJC5pv
         RK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056916; x=1758661716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHrHFP5MPt+x13uBQjsAS3MLabqAvc4S+eyVJ4ZEW6M=;
        b=UKBlsE0tTjmASRNJCFKhfcrAGIcY3/IjcUlXlXwxQVrnjjIrglBAr4Sz5qDefryesH
         SjXoRhBZmLopKKblshqFVxLWzDuynmjJR2Ahdr12qBkMfh9uiX85LxpmTaWjKeocceC5
         rCi85dx7TMRWpcS+v20aQkiFliz8INbp3Z1OX9uvdiAMsOxNvBU/z3WBzOx408QrmGxy
         o7Tdk70rJaNrSKzRS9in+Y3tzj9LmrQNH5F+LZ3d+VJ9r3w+ddkbYzP7uAVSOEFBjvfi
         9xlaYv7fyIxi/wQ+6JACkCB2TiDMApVw2azOlrQzErEbNH/uYatPGl0voWp4Ev53ln+K
         S7sw==
X-Forwarded-Encrypted: i=1; AJvYcCXxNu0dmi6AdNd1e33IajTlhaxkdmeXljl6oFAhue/hlm4Jwj5PnM2iECx+mRvVcnVmwt5VOVIDmW1m1oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgQDSSDeXr3r1OtjQSWBACbBCNXHjOgyNfoSpnPCXa4506zKT
	kkGSzl8JanAqvtBNi6fyAtr8AHWSzCQd+7hPZqi52+dN+Opa+yjtKprR
X-Gm-Gg: ASbGncupsvKA28LreJTnZv7EmnHEeIxBYenb+SSTXbzos1k8QB/JBNtPnl/czUNs/Be
	ifI8PetkOYWeuLz17/kfjdKXEX0u473xV/84JMr9WUjLwdkXf9iKm0Cut7UF5wk0iv78Ltjd1cg
	kt6HYevnw6Z8vDRTW+bS22vCjKj778C0W24POCu2PwaX26TBg6MxZuI49jGy5SWFhEjGjHGema1
	Jf0HhgJdlD5btrgGAScdgC3xhTJ9diwnxZe0x+DPHWgRB7OfFeBFLQYrrw9ok3KX6RefnHf1a/l
	AWxj4ug7RrJrwQXa1bl8DmN7NK/2NfHK5KhGZj76n5k9btAgOzAhzrDqek9FEM3kfzM/IprT4Gi
	lRD/J31LWxvRw8LTfuM3+0nVgIgRJaQaH9S9MwvDSMBghrM5rdD882fZ7UCAmbbMO0QN1XhTnls
	NvA8SJYZwbig==
X-Google-Smtp-Source: AGHT+IEqBZc84JrKRfpK2hpWsRx1JO903hwP4K4WPYBZZa4WtL5bz4O/AOfS0bSJOZU43B5FoEPqfg==
X-Received: by 2002:a05:6a00:23d3:b0:772:40ba:61c0 with SMTP id d2e1a72fcca58-776120790b5mr17649741b3a.5.1758056916607;
        Tue, 16 Sep 2025 14:08:36 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7761f8b1bdasm11537334b3a.60.2025.09.16.14.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:36 -0700 (PDT)
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
Subject: [PATCH 05/10] drm/panthor: rename and document mmu_hw_do_operation_locked
Date: Tue, 16 Sep 2025 14:08:18 -0700
Message-ID: <20250916210823.4033529-6-olvaffe@gmail.com>
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

Rename mmu_hw_do_operation_locked to mmu_hw_flush_caches.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 727339d80d37e..7d1645a24129d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -622,8 +622,20 @@ static void mmu_hw_cmd_unlock(struct panthor_device *ptdev, u32 as_nr)
 	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
 }
 
-static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
-				      u64 iova, u64 size, u32 op)
+/**
+ * mmu_hw_cmd_flush_caches() - Flush and invalidate L2/MMU/LSC caches
+ * @ptdev: Device.
+ * @as_nr: AS to issue command to.
+ * @iova: Start of the region.
+ * @size: Size of the region.
+ * @op: AS_COMMAND_FLUSH_*
+ *
+ * Issue LOCK/GPU_FLUSH_CACHES/UNLOCK commands in order to flush and
+ * invalidate L2/MMU/LSC caches for a region.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova, u64 size, u32 op)
 {
 	const u32 l2_flush_op = CACHE_CLEAN | CACHE_INV;
 	u32 lsc_flush_op;
@@ -680,7 +692,7 @@ static int mmu_hw_do_operation(struct panthor_vm *vm,
 	int ret;
 
 	mutex_lock(&ptdev->mmu->as.slots_lock);
-	ret = mmu_hw_do_operation_locked(ptdev, vm->as.id, iova, size, op);
+	ret = mmu_hw_flush_caches(ptdev, vm->as.id, iova, size, op);
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
 
 	return ret;
@@ -691,7 +703,7 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 {
 	int ret;
 
-	ret = mmu_hw_do_operation_locked(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
+	ret = mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
 	if (ret)
 		return ret;
 
@@ -702,7 +714,7 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
 {
 	int ret;
 
-	ret = mmu_hw_do_operation_locked(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
+	ret = mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
 	if (ret)
 		return ret;
 
-- 
2.51.0.384.g4c02a37b29-goog


