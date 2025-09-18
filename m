Return-Path: <linux-kernel+bounces-822200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD2B83472
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0164B1C21C58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3332E974E;
	Thu, 18 Sep 2025 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9fzhRBa"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53720482F2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179554; cv=none; b=mSCOd8SmmexXfwxgEOHjUlQJiIVA5UXxegYdZyQ7fQiHLyOzE+VDZeXKyGZQxl/4SX/FVmISCL8uK3tW1IXCW84MsQV/K1OuI2m0b6OaFII/3UkIe+m27SyJcOTyuzDm0AusX9o3zmPtNtuj44mTdCrp0Ob9lLKaf/NrDr4re7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179554; c=relaxed/simple;
	bh=ud1Tmg51SfzqY6HtE7aDmCcSXYCOdVA2UHkFLQUePVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnIICzTF9PIHJf9ZGboGSGeEmTjl1YH8SzRzWMuoUdOrHjYJxuqnyJd2DKSmQMKX6qKcgFoDuBi8oatoSEBATKT5yOMt499F928oITTovtaPVh7drOnoN4iGLiOQwEQWBAgAlTVLvikYG7rK31nGiBxqCMHJ5pHbRANJTho08k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9fzhRBa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77256e75eacso601615b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758179553; x=1758784353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkm5768qLYG/7lMt2aDpCtrK/g19VAgQZBHIXA7VzC8=;
        b=E9fzhRBaEoY+/VPgju3mCUe7rnGP9acLTL/1U2lqio5TLdB5SRg3uamixWvy9kJAI8
         P38weZt3QVNfsvCVZRg5nxj9AzyX+GyxJBwYrdcBWWS/zN6KXgD8+iWAd9fljpqwxcjD
         22BnV0dqo4h8Ra4tpI4DVQbVHpbY14pXNJ9GoQ3hZh51zhpL7kb8f03uLP7FXYpVKIFx
         xfDlew7pS4yPoWYdFbOCCsqFZR+lGwr8sr4upHlyNhx1KYew239dgOviXSycu4hFkZrB
         JpYtLuKtLququggwy/BUVx8MIa8NSE2ZRxue4Z7ucYZxYYw2iy6b0eHiywRF9BZojbDU
         JC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758179553; x=1758784353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkm5768qLYG/7lMt2aDpCtrK/g19VAgQZBHIXA7VzC8=;
        b=ny5OzRnl70LGGPlcev+SBI1yOTw319RggwkUum/vf6/n9sb01MJ3b+Ws6A+Fbkr98t
         /jS0vdLD1gsnFEibV5EOTQ6KGj2wj6YH2er/hxREAw25LQgs/H/FHdWNj99EgTzO0OXh
         RCWWmcAG3rnDbcQJDdrUwM/VtxJXDfZ+L/CYoTVcU2diaTFCjQXe7CYjr7Vw5opHFXOn
         o6X6YjYaloyf3vc5YP53VI4jfr4/hc6Y8RK75Ce5KayoLWarIMee9+F5WuRr4S3Wy80I
         Rmv/34Krfz9rylNBeDKWx+9ZQiuAwrA1dabgLicVS/1yHnnhWZ9nT5vnhHeRqPQK7gVr
         D7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWsUdX87SUI+Dldu1qEhNCWq6wTEzRUEq68xdvdZcI4YVDh/IohfMfXNkh94ZrjUkHd/dgOcfg6Q1XckHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRijtoeI+3X6CBgshU2R9QoGyLNPQ5HqQv5qlQhAwPBtGHac5
	J8TSyDsUX3bCIQ9WhyR6doLhgx9nQRpK6AbAMN87S61boysVA9+X5uQ4
X-Gm-Gg: ASbGncvEtsnRHzitKAJEIp904ByXTlAc4v/eANBWbnOcIfpDU6KVWCIxf5/oqQjZm2B
	vnT8eRj3IF2eKrV2vCZUBTJH5vh0Cw1BhlkMbSss41+fATNTnKTGH4lZ2s17pqCNJ4q0gjFIlba
	1CBB3KYYETyQanRD23A0oBQAlTdyyCidFoZRSatioCwI4/arrHx2mxk1HtAevuWkdLZ98whuf8L
	rqBNMCnEY8rh9ub1V/WRSChgbU9Pty28RmhD/0ac/JEomj0weyljPHNXaTw8wim8p830dTU9e/E
	dGo1oq2xu3fZSVMtqtYWXdMBjDP2OI+lYQZIqk0t/+FVQQvp0uQGzlM+Djefk+D5EUjeh3GAk2X
	50HlCioWliBYQNZLEr1c3jyAFB4J16ws8tpyuuy1GakB5ESnAkJErcAs=
X-Google-Smtp-Source: AGHT+IGdU2UHmJHhU9RR2jUy+RtSKtOMtaGZXLns5gxJCl2FXNsuL8oTowVvbbfw7QvNTE+aUNdCBQ==
X-Received: by 2002:a05:6a20:6a10:b0:23d:ab68:1b7c with SMTP id adf61e73a8af0-27aa99bdb9emr7214606637.46.1758179552545;
        Thu, 18 Sep 2025 00:12:32 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff3743bcsm1435597a12.20.2025.09.18.00.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:12:32 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: Felix.Kuehling@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2] drm/amdgpu: Use kmalloc_array() instead of kmalloc()
Date: Thu, 18 Sep 2025 12:42:00 +0530
Message-ID: <20250918071201.350162-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/deprecated.rst recommends against the use of
kmalloc with dynamic size calculations due to the risk of overflow and
smaller allocation being made than the caller was expecting.

Replace kmalloc() with kmalloc_array() in amdgpu_amdkfd_gfx_v10.c,
amdgpu_amdkfd_gfx_v10_3.c, amdgpu_amdkfd_gfx_v11.c and
amdgpu_amdkfd_gfx_v12.c to make the intended allocation size clearer
and avoid potential overflow issues.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
Changes since v1:
- Extend fix to amdgpu_amdkfd_gfx_v10_3.c, amdgpu_amdkfd_gfx_v11.c and
  amdgpu_amdkfd_gfx_v12.c as suggested.
- Added Suggested-by tag.
Link to v1:
https://lore.kernel.org/all/f782159b-ad3f-4d0c-8476-50a701bf29e6@amd.com/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 04ef0ca10541..0239114fb6c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -352,7 +352,7 @@ static int kgd_hqd_dump(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32_SOC15_IP(GC, addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -449,7 +449,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (19+6+7+10)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 6d08bc2781a3..f2278a0937ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -338,7 +338,7 @@ static int hqd_dump_v10_3(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32_SOC15_IP(GC, addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -435,7 +435,7 @@ static int hqd_sdma_dump_v10_3(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (19+6+7+12)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index e0e6a6a49d90..aaccf0b9947d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -323,7 +323,7 @@ static int hqd_dump_v11(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32(addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -420,7 +420,7 @@ static int hqd_sdma_dump_v11(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (7+11+1+12+12)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
index 6f0dc23c901b..e0ceab400b2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -115,7 +115,7 @@ static int hqd_dump_v12(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32(addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -146,7 +146,7 @@ static int hqd_sdma_dump_v12(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (last_reg - first_reg + 1)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
-- 
2.43.0


