Return-Path: <linux-kernel+bounces-887479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30D4C3855C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562C13A92DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B12E8B73;
	Wed,  5 Nov 2025 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="K8ObsJP9"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351922D9ED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384905; cv=none; b=bKyfNvFMFjq4ofl78dxQVfhyVrpgDF5s1+bvyoDnY3g0DF3zM7BhSqqnVr3T+i45+4ZVbzuz6bJdIKS5ruGMbA/IWyuE3F/+IEcodlykFHKDChHnINdSOMDkmJ6Hs7UY2Zt9qeVr1tRBGWjanbybBiKfdYg3WbRTjpRzJsxD67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384905; c=relaxed/simple;
	bh=UZxrjOxSWC5klJ5vcY72FvBvUQSgzLX0a+XyTFjXAvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1CE1SctSCFwttzEhxPvtcQYGajm3MY330iJ4LFDG/2+pi0f7nUJiWehdVp6JVQRySGXX6Hj705lq8zolUfXJIWnZdixYKrmPO8rZSWwYwc5PRIOAd0u/piFn09WEKhfvcEeGB+fEs83WNq7wWWYQWopPaimK6Ca7dvOnQB5Pv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=K8ObsJP9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b95cdcacd95so207233a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762384903; x=1762989703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJiprROu63G1frHmGSO+l8oyb9oBLslAg4j/kLd4BHY=;
        b=K8ObsJP9DgIk7E37wAMPUqtuaZmbRSUEYb4pVjvSf5hRMEUp7Wr5YB/4YeFgCAR7gD
         vQVdAJdtJ380GD6XVkOFV21rFmhXgcltpJTZgauspNOJPb7gemQS7S7WertLy/Z+g2C8
         SlHTChBqEVQmiF0mDwhX/NYVw3aSwTuN+KSsmBeSIXI9xIgMkhuv7KKkXHdswDhxiLQx
         zvTHRIxDgChfq3vuK8XGQ9L6qBPx+xBE1oPiSLlULkHaj34UULQbmJpy7TlfwhVCw/Yt
         aa0lqZR1uWh/WdQkxENnMNVfSjGsF3v+9TnpDuNhfBL3cOxKn8QDWZHHA/4+dkkCqQD3
         x8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762384903; x=1762989703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJiprROu63G1frHmGSO+l8oyb9oBLslAg4j/kLd4BHY=;
        b=LQ+MdMRyPICkOFrGn84rTfrjV0X3/zqQCw4M4NpRC0plbVi7fKcmHtVIq+mM7c4R9E
         Y62ck+bEcncrZgH3FUBqh44u5r9STfZeYgdE7pCYL922loFL5Uy7J5oZqJAiB096mn/l
         5iNNGZ4O0ax7WMyI9NR0VCF3/ffaSx1FUBNzVm2xa/6X8LLwzDUrMDwMkvVmQIqIIeaZ
         to91wVsx87Lm2sHVEgSwUPuK12zIFLWU13SkzgIepzBQL50seAIfAZn2qCGDp8DdxuXx
         ZynzPCrIvuPJtw6ekYnmnw/fnH/0O8S0WdKhfltH93V85m83J99BCQXxWHFp5mmYfJb0
         YQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWEban/Dbia91Pd5hJ0iAxOPL0jsz94UTNv/A1GllnY9Lo6ycRkYBHobOuP3Q/O+act6l1ZS5ly6j/ODpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aThiAkJxxehs/wJj7WYeGel7xeIYE2vnukvxixmyqh/Y83fy
	clrZxO8W6gvBDfzkl0PPbViJ2qR0mylEt80tm3VkSFuCsI0AK12pmUGBuG2d5gKYejNU
X-Gm-Gg: ASbGncvxjIgDccOw0SDP77gAQZbvThBLEDM7cZzoMiUV+7kSHYAKSE685ySO5XCMHNB
	PzUEt17ufSS4Gda4y1pxLeq9tMOl6XYD1NaNHKgpO1GdpgGns+bW9olnOHyBVDL/LNZKDWWQt1U
	4/5J08yM2evqn+WmsNjDmN3BGA9qaxYw/a+y3BGrG+6Z7S9ONpZjKpz4grpThJYdgDjhyoyF4K5
	Ar7wkfe/ilRA6iO4wwJwZsAsuavIwA3PDzYf+dfP1Wa6oKbwbxYUyb+rOlALb1PS2pDsU3ivikl
	dpm9aUafxH5AFa132CbJ4iAb5+7yufW+zelFiNkLzUh5P+6q5QypqYee0QFbpfje38T8ItH8S5I
	mc3+hNNtO8fP653nK3CRU8Y5WY36FtJBxcAB2nxPg9O5HtXhQIg==
X-Google-Smtp-Source: AGHT+IE091+lzdrv+Nj+YfcdrpAjegKIiESDWT7sHR4JWv61MvJE6IaL9ddG35gHuIh3zRLs14+FRg==
X-Received: by 2002:a17:902:d2c6:b0:295:7453:b58b with SMTP id d9443c01a7336-2962adb29cdmr52328925ad.4.1762384902532;
        Wed, 05 Nov 2025 15:21:42 -0800 (PST)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968298sm6719765ad.6.2025.11.05.15.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:21:42 -0800 (PST)
From: Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
To: bin.du@amd.com,
	pratap.nirujogi@amd.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com,
	benjamin.chan@amd.com,
	christian.koenig@amd.com,
	dantony@amd.com,
	gjorgji.rosikopulos@amd.com,
	king.li@amd.com,
	phil.jawich@amd.com
Subject: [PATCH] drm/amd/amdgpu: Ensure isp_kernel_buffer_alloc() creates a new BO
Date: Wed,  5 Nov 2025 15:21:08 -0800
Message-ID: <20251105232108.107765-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sultan Alsawaf <sultan@kerneltoast.com>

When the BO pointer provided to amdgpu_bo_create_kernel() points to
non-NULL, amdgpu_bo_create_kernel() takes it as a hint to pin that address
rather than allocate a new BO.

This functionality is never desired for allocating ISP buffers. A new BO
should always be created when isp_kernel_buffer_alloc() is called, per the
description for isp_kernel_buffer_alloc().

Ensure this by zeroing *bo right before the amdgpu_bo_create_kernel() call.

Fixes: 55d42f616976 ("drm/amd/amdgpu: Add helper functions for isp buffers")
Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 9cddbf50442a..37270c4dab8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -280,6 +280,8 @@ int isp_kernel_buffer_alloc(struct device *dev, u64 size,
 	if (ret)
 		return ret;
 
+	/* Ensure *bo is NULL so a new BO will be created */
+	*bo = NULL;
 	ret = amdgpu_bo_create_kernel(adev,
 				      size,
 				      ISP_MC_ADDR_ALIGN,
-- 
2.51.2


