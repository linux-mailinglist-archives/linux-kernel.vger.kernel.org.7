Return-Path: <linux-kernel+bounces-725085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F55AFFAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF70D1C47990
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEE2288C87;
	Thu, 10 Jul 2025 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0tstffn"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA578F5E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131911; cv=none; b=N5KDD3pyrMJ5SZbh7pYBZJDBuJKZ3eUcoJUwt0Hx5dFNDkIk3QJRKOrtWqpToXsJWeJl+vxbGKc09oWafa2wY/Rsxpi0byIWSUgv6wLYzjrmaiYFgjdUESOvNZdf+mjixNDMH06QECfGR9yFS/SSCgJVu25R7UJh2cPwrb2/R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131911; c=relaxed/simple;
	bh=TRZdjQIEUOS3SpuoLhTp2zvd4lsO3xOK8lhQ5tTxyfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibC7KatpvKna6HdzGWv64H3j9zp7g/bjf1FJWZ2L/JgZM34am8nOUXSpfmUal1KYDeaGhGSeQsSxr4Rxc5xlqKZ9O1eeku+QT0VrYoJnNyRHtU6JT79jR8dsopIlqViW0kmhdCl++6Ub28tRUk9020MXeC4ulEp/X4pFMW/v6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0tstffn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234f17910d8so7186565ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752131909; x=1752736709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6g1IiPrFyHwJRTaDBspibWxL1+SD9wnK3iKsVFGEiqY=;
        b=g0tstffnS9x2sxLYFVmBAle6gI8hLoAFUXEGer+NH+Hf4waejOFaGxtnO9qyMrOoeM
         YrKp9TrxjbNniyeRKWGUVxtwqyX0SM8Tvk+nlHFN1dN/YCEF7jqPlaQ4+sM8SLArghLj
         +Di7067Rco/e621FprYZpvm0ai2w7OFH1yza4c4tglBc5seyaVhEOSaobOfwWKMqFMw7
         3phqrYf5raxOIM/eaYZQBhSPjIaLBXZ3F6dZN3ktkLi3negCJG634vUFBdIB2d1e2ABM
         S9hLtbrhjLLzf595m+QHjIncVlneHuaEzsGiJoqsPA+OhLVYG/CMAKeiGUaIBkFbS6Ak
         1w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752131909; x=1752736709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6g1IiPrFyHwJRTaDBspibWxL1+SD9wnK3iKsVFGEiqY=;
        b=v/ZXJKbhfsrFKYAmOXqk5iNB/iqUyBmR5CteffyxgEe/ICPiCzLmnhOvKx8CvUs/hd
         vebetT6V+wl/haZxui8OOJnKKdPvx9rb3F3TX4gIJ8KiDccB8wjuUv1rdAsYtTXSb3v8
         mlSfD2GW2Ltpcv9KjyVBd0K+BcGK6CkG62+fKMmcnxENzoaNIgQ2P1cwSKElCE69JT4/
         gNgrxLwydMC9scXwofdDQpvLJ694R7DhlWYssaGeo3/g+SOBKFgwZOnq+PGXMMV9MUzK
         JeTFNaOgq+wjjl9VgqnT4VIzeDUiVOAXHVuqHuIL8qhCDzvqoC7s2i0ievmYMtAjzmwz
         XZZA==
X-Forwarded-Encrypted: i=1; AJvYcCXwhDvetgtgzhAESPwLRx3H8jzDUQbMU7yvi6ohY009d1+svzzuTjGYzYaGRukNvtjoKcuaun+M4xVSWUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+tvR/eQIIsQCVH+YeaPIEUeSUyvwkZ4Jh2LLzk3gZpfV2V5c
	UQnNZBSNs8VITZ8FByv/Q6qDZhhfCE9UA/93LDTGol54CmKpGYMyy/tbBci0OY6L
X-Gm-Gg: ASbGnctHgwRp+14zaTtLPbJs80rbjasXTeICzPmVNblo5L9Uu07kM/I/YbWL73ckj41
	wEm90ELq3MF/tnZe1LDErBsTUC6ABTdKUeBBF06ZhW3vzTfOg3YRZXKG/NDrhXlvtJWBc/xVraA
	jbuFiNO2qTEdlA9Dy17AWPzsC6UK5LizUVJgat8zSU4o0/9ofNC7lEMNDZ4lJCvzG8SX9thPkuB
	T8pukUYdSkqWTW3z19vA99mA6bUv6yOsbkpya0cl6fcSccZPsk5elIPz4fujdZ8VuGH5rZMpQ8Z
	6vM2EHqZ4sDrePJdTJfok3g7GMpLppfhDzdWnFNtuMGuC4MDqMJgUjD9APzddi6QbONJDDWiizr
	dRJw2zufB
X-Google-Smtp-Source: AGHT+IFVGyOnm1nwsQ+ze1erHvM2Rxv0pNSLgjOlw0v0EXpaUJJf5eUudFsAasW06wcKg1niVA8W2A==
X-Received: by 2002:a17:902:ef07:b0:235:ef79:2997 with SMTP id d9443c01a7336-23de2510c87mr46529115ad.47.1752131908813;
        Thu, 10 Jul 2025 00:18:28 -0700 (PDT)
Received: from localhost.localdomain ([115.137.3.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb45c7csm1331530a91.25.2025.07.10.00.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 00:18:28 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: fbarrat@linux.ibm.com,
	ajd@linux.ibm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: [PATCH] ocxl: sysfs.c: Replace scnprintf() with sysfs_emit()
Date: Thu, 10 Jul 2025 16:18:15 +0900
Message-ID: <20250710071815.351069-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change uses sysfs_emit() API usage for sysfs 'show'
functions as recommended from Documentation/filesystems/sysfs.rst.
Intended for safety and consistency.

No functional change intended.

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 drivers/misc/ocxl/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
index e849641687a0..f194c159a778 100644
--- a/drivers/misc/ocxl/sysfs.c
+++ b/drivers/misc/ocxl/sysfs.c
@@ -16,7 +16,7 @@ static ssize_t global_mmio_size_show(struct device *device,
 {
 	struct ocxl_afu *afu = to_afu(device);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			afu->config.global_mmio_size);
 }
 
@@ -26,7 +26,7 @@ static ssize_t pp_mmio_size_show(struct device *device,
 {
 	struct ocxl_afu *afu = to_afu(device);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			afu->config.pp_mmio_stride);
 }
 
@@ -36,7 +36,7 @@ static ssize_t afu_version_show(struct device *device,
 {
 	struct ocxl_afu *afu = to_afu(device);
 
-	return scnprintf(buf, PAGE_SIZE, "%hhu:%hhu\n",
+	return sysfs_emit(buf, "%hhu:%hhu\n",
 			afu->config.version_major,
 			afu->config.version_minor);
 }
@@ -47,7 +47,7 @@ static ssize_t contexts_show(struct device *device,
 {
 	struct ocxl_afu *afu = to_afu(device);
 
-	return scnprintf(buf, PAGE_SIZE, "%d/%d\n",
+	return sysfs_emit(buf, "%d/%d\n",
 			afu->pasid_count, afu->pasid_max);
 }
 
@@ -61,9 +61,9 @@ static ssize_t reload_on_reset_show(struct device *device,
 	int val;
 
 	if (ocxl_config_get_reset_reload(pci_dev, &val))
-		return scnprintf(buf, PAGE_SIZE, "unavailable\n");
+		return sysfs_emit(buf, "unavailable\n");
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t reload_on_reset_store(struct device *device,
-- 
2.43.0


