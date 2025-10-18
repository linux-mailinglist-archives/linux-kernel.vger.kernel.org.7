Return-Path: <linux-kernel+bounces-859033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3EBEC84D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7D819A86A3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E99E284669;
	Sat, 18 Oct 2025 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="nhDhGd09"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C17B283124
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760766309; cv=none; b=tTFgrBsovMkJnHOVtIsq6wXWJH+q2ZWqu7JBGcK7Wex/UdoCcbuLPP8e9kUoRdKaUSw/AO4wNCh02mXWqSf+HuQKqwraQpgjyGfcswlWviPLcgovMUF6OJlYZQEDzBC5C9Whfwn1D92uEeISnzz/ZlScMtsM+cIp6dVJ79TfX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760766309; c=relaxed/simple;
	bh=iwfUgV2B9myGMPJUG6AdS/9k9YhfWcC7PvRS3rewzMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj+b7UmGaZYbsrH0BaRjV/RYQMh3tqUc7olb5z6LlduSX8LNJ/sD+hHvMNuvKaj5n1iXjUGNdyJA/MgyOVRt9J//kf0qM29Cfz9JOsDnbpqswPV32PsvRshgKmLAMWVH7Fg5CHrvcpUmAdO6bLgP8yV8cGlbKKF6e1YUpIHf6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=nhDhGd09; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f343231fcso1794701b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1760766305; x=1761371105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQOTysCBScI2CzYaQCtToYUiGDVsPF1DI/yzJf9rUmc=;
        b=nhDhGd09lCfgA4L/z/DqOa4yeR2X2JQr0dgxFyDVcoUcI/s/sjPElYz/rH9GfHk4vU
         dxCgnJv1YV4GvomkZIf+Bn/dFeUMRH7km8jJ14h5NnAkY7LHhWYNMGDJQVPklUFVUQxo
         vi3xLDAwzuqsvFlMkxBM79AsP18XS2KnK4qDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760766305; x=1761371105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQOTysCBScI2CzYaQCtToYUiGDVsPF1DI/yzJf9rUmc=;
        b=ruLIuGU8QlbQombF04HHmGAvqUd7pv4btLecWxZgJ2Eiozgw1foai0GWDKE9o2unNk
         aFklI7WxWavHeAQOBuiRr96yVln2Z21S0ClPTTZXUWIs2hvrqF20yCHToWhyx0+6hGGK
         xABZ9okkmTe2GU/VcYatCKaGrXKv+o7TRx4mhfkkaKumu82tieoNoDODswt3skDNbEyp
         VRKAF3/U1l5t+hhnEBY4+3Jn+qg2apxB2plreR+BngtLGxU14Yxee5CdCZJA+VPexwxF
         1nPXGCe+tkNvhat9llhXT7zqxl9Q5Y85xJ1RgWkgnsavzlfJAobH/CgSyPx1Mm5LPb+s
         rndQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRjgz48AXe83nWOIdjXCMsNV4LQN6QJrizR5Ow9HrXY8ZOhu1oUDrV8Ura0e1QnyTz28RrFVvq2VjWlMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRd9ZCVdWMDXECXRzrYh4kFAN+kSWqhqTs+WQbC/PCVYNgBkG
	8/3ul3Dtd0yivvuXzCQiC+uMGxUQa+2jf46lGPMzz9XyrqVIL0wHvwp5sgiuz3xyCrM=
X-Gm-Gg: ASbGncv7gb3ZU/TxlKeRtoI8bw3iQQkj5J6/ZbZrdLtqbC/EPwAC97oMgz4/ocli9Rw
	DDWd3SEnkVQSJBqSEpiRkR/s3TfbJKbauWWycF1xF9D9Z6ltZ1pLsJxKG34ewAH01u4yusUBG29
	Atxh587BE/D8vr/bBQWa0gYMJVGxfK32hxnoeEHrsjJn6w2SYleDARooVhMKl40TId8KvmFvzDz
	zykMVZ/6uwlQ/7Rj3roHUP4rdkr9nDnx2+oqpIOrHm7SMuryrFgtr+hYQft7BJRmi82WA/MmoIs
	DWUEpBu1I30SLgJcL6/hwRvpHgis543vQFcEbTGaSGsi0ISbCR2zoo+SEBoa9ByOD2vxezQplPS
	dEbYAUjw2nPmlQpWJDtss+DGB/WKB5lcSiYkCCCgFzD8JykRcSWuX8JtR0uIfYgT14bBpwaozxe
	2skYdyXvL5+QUfSJYWHSFliJi2A6LuisNdmfyY1kr8aF7RM7/PjSo=
X-Google-Smtp-Source: AGHT+IGy3J41ApbLMLRcrOO9pkHemkNxPjtpkJmBEBFlBmY9XVIw/TLuT/llEZB3A4RXYe9syKnQyg==
X-Received: by 2002:a05:6a20:b38a:b0:334:aa54:bb2c with SMTP id adf61e73a8af0-334aa54bbd2mr5825208637.8.1760766305361;
        Fri, 17 Oct 2025 22:45:05 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.222.3.188])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b6a76645c61sm1657222a12.3.2025.10.17.22.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:45:04 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wuhoipok@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/3] drm/radeon: Remove calls to drm_put_dev()
Date: Sat, 18 Oct 2025 14:44:51 +0900
Message-ID: <20251018054451.259432-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018054451.259432-1-daniel@0x0f.com>
References: <20251018054451.259432-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the allocation of the drivers main structure was changed to
devm_drm_dev_alloc() drm_put_dev()'ing to trigger it to be free'd
should be done by devres.

However, drm_put_dev() is still in the probe error and device remove
paths. When the driver fails to probe warnings like the following are
shown because devres is trying to drm_put_dev() after the driver
already did it.

[    5.642230] radeon 0000:01:05.0: probe with driver radeon failed with error -22
[    5.649605] ------------[ cut here ]------------
[    5.649607] refcount_t: underflow; use-after-free.
[    5.649620] WARNING: CPU: 0 PID: 357 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110

Fixes: a9ed2f052c5c ("drm/radeon: change drm_dev_alloc to devm_drm_dev_alloc")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index eb5138da8d5b..350f88af888d 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -315,17 +315,17 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_enable_device(pdev);
 	if (ret)
-		goto err_free;
+		return ret;
 
 	pci_set_drvdata(pdev, ddev);
 
 	ret = radeon_driver_load_kms(ddev, flags);
 	if (ret)
-		goto err_agp;
+		goto err;
 
 	ret = drm_dev_register(ddev, flags);
 	if (ret)
-		goto err_agp;
+		goto err;
 
 	if (rdev->mc.real_vram_size <= (8 * 1024 * 1024))
 		format = drm_format_info(DRM_FORMAT_C8);
@@ -338,30 +338,14 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 
 	return 0;
 
-err_agp:
+err:
 	pci_disable_device(pdev);
-err_free:
-	drm_dev_put(ddev);
 	return ret;
 }
 
-static void
-radeon_pci_remove(struct pci_dev *pdev)
-{
-	struct drm_device *dev = pci_get_drvdata(pdev);
-
-	drm_put_dev(dev);
-}
-
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
-	/* if we are running in a VM, make sure the device
-	 * torn down properly on reboot/shutdown
-	 */
-	if (radeon_device_is_virtual())
-		radeon_pci_remove(pdev);
-
 #if defined(CONFIG_PPC64) || defined(CONFIG_MACH_LOONGSON64)
 	/*
 	 * Some adapters need to be suspended before a
@@ -614,7 +598,6 @@ static struct pci_driver radeon_kms_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pciidlist,
 	.probe = radeon_pci_probe,
-	.remove = radeon_pci_remove,
 	.shutdown = radeon_pci_shutdown,
 	.driver.pm = &radeon_pm_ops,
 };
-- 
2.51.0


