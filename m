Return-Path: <linux-kernel+bounces-751630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C58B16BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2B21AA3D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B524336B;
	Thu, 31 Jul 2025 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miATHBLi"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89B2459D9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940214; cv=none; b=KTamwLTNL42LWVVeDS5Ov5FEAYouFLavLPW21mnc0dCpmFwbJ93zG5PzO1Cn+Y0sd7ImBnDoc9biU7n15dFEenYD5DCZpJRHO20licmJDWw+iDROlcgvf8KXt4EesyJEI6gK9/dv0AuqXN9tYPfAWwvL25jSxURYXZLPAFHSOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940214; c=relaxed/simple;
	bh=e9p8Vf3O57OZuGOWvZZZd2cfUDkdH21iEMUPIiiRtO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRT13RlXne8T1QJarYNqfmNbtmkC+KOkV8CHo8DaRfoEzIaL6geNiHhrAEAiVHgQ0Vb7EcVNiqOF+rXMkr8/oB5pmxlC0Uzd/yLlkWCoEXFLXF8wIT5jX9TKmSwIvtfGZAk54OkJ36CiN9AycpEV4ibS2ETLd70pbnOXmyWBrx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miATHBLi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b783ea5014so290608f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753940211; x=1754545011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5L5CPo11vx1WT5kIB7Vz4RYoRKGO5r44hwwfolXkFs4=;
        b=miATHBLi2cKR8Mc1Fd5x8z2wRaNtjljxw0xVRitwPqgP/fVgdL12S2ez0UkzR3qzQL
         BGZCAyWywZsSDv1WP+gwQFxKoWVB4PkenASDwBHVokFb90cMCu/pabH7JMHoEX8Q1Qnb
         flj00q2Gre9nKwb3Q1eqdZHnWQBXA8l+tBw9FXVe6AXiQwoyE6CQexrQlS1qWlqOIBXG
         FAeS0DQycx7iENozGK7/zvYlNgmE3QP+/3QZHtphby6+cMg6cjFeoXH4Z99GlkMRewEH
         PY8Q7pHm9oSwpF6KFPoUnIYzRNWpJztJsDehLjiDIbNfQdUqdphmRV2w7MAcB8jBwEk5
         slkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753940211; x=1754545011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L5CPo11vx1WT5kIB7Vz4RYoRKGO5r44hwwfolXkFs4=;
        b=GorvKH0p2vTu91vBOvHOMd5bKTfQUO7FMqICYr7sBdhaXEtQcRqD2x9GYdXSJdp/WM
         6HRMpx5Xf6sBnE+hJZ2TlTldkoDn/b/OH8OwqxsElYuuFlvKuJ3V8QPNaX48h6J51336
         EDlsd5HgaP1+1GWDxST2U27jSP1Sos+zqMYdd7rstPt4n/dtziODpdTsK5u6+/gPBz1O
         hgddMiEO68LTju/MXXlZcA0tqWjRP3WL8wFlKV/sc/09ji373SjLAhj/pjycyQ3znpYP
         mf81Z11rovxQ9dimF7K+V26yhPfGZVwxmvAnpXY6WU8QK6gB/q7QsWy45e6iVXvYJ2Zx
         UCng==
X-Forwarded-Encrypted: i=1; AJvYcCU6yBlqWgGVc1gV/3p2SNgMZb14ObupAE82UvsIo41VUfyIAD+9bhBpQWX9M4N+46nr2UO1WOw2pBYRKKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweA+B47At2bDT6LhGCsnrCPDw3zUqBUf8tgJn9afBogmFy2AIx
	hCkaEXz4M+5GAIi4M7C+7SdsT31jEoGwVxHukOMKy+G6f+7bkulKNdiX
X-Gm-Gg: ASbGncv+fIkt9JJMFXyff9seeZnx1LukOMu1AEJ2tNvcMnzoihlxuTzmP+tNJo0PwSv
	J54QWXl9qd4S+9HU/VpjhleQT06gcuEaRSE3U3JXISBTUp9vlRxVuNlOMZH3LrQdDgyduG4EuUc
	e1O72Wa1C2OLVeDXZL04YS8Se+zyln3dQqIY/N2A2D3Yy//DiJ76IOvWHhrfz203Yhuox/qkslA
	SYg/i+zbbunx8Bd/boIl1kZ6WUzWAuw7OKw5wt8KyRmLMJuu38NT0n92++afSodR4E8U4bB169B
	rU3O0HqvtI+Rui/TUtgjag7ViYwg/utsOWUf+HHs7Dwb8GPN+K2zOHFXZg7K7TYPVQBJQdA7N8Q
	No6z9MOVocNwqcuB2m7dikQYxp3hsqfV3ThJuh5Wgt++PXzdjHWnWIJJYZX0GY7KA6vQmJGs=
X-Google-Smtp-Source: AGHT+IEEFZqWGgNeRd5nb5UBRZkfnTiNiCgdeRhXusb9GlwFSioJhj2kNspsCCRhW9Y+Hhgyh9TqGA==
X-Received: by 2002:a05:6000:40c8:b0:3a4:f66a:9d31 with SMTP id ffacd0b85a97d-3b794fd59bbmr4759177f8f.16.1753940210946;
        Wed, 30 Jul 2025 22:36:50 -0700 (PDT)
Received: from [192.168.1.205] (dynamic-176-005-138-071.176.5.pool.telefonica.de. [176.5.138.71])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm1149137f8f.9.2025.07.30.22.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 22:36:50 -0700 (PDT)
From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Thu, 31 Jul 2025 07:36:38 +0200
Subject: [PATCH RFC 5/6] drm/amdgpu: don't wake up the GPU for
 mmGB_ADDR_CONFIG register read
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-b4-dont-wake-next-v1-5-e51bdc347fa3@gmail.com>
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
In-Reply-To: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Philipp Zabel <philipp.zabel@gmail.com>
X-Mailer: b4 0.15-dev-a9b2a

Don't wake the GPU if libdrm queries the mmGB_ADDR_CONFIG register
value during amdgpu_query_gpu_info_init(). Instead, return the already
cached value adev->gfx.config.gb_addr_config.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2295
Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fe1347a4075c4..ed4d7d72f2065 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -883,6 +883,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
 
+		if (info->read_mmr_reg.dword_offset == 0x263e &&
+		    info->read_mmr_reg.count == 1) {
+			/* Return cached value of mmGB_ADDR_CONFIG */
+			regs[0] = adev->gfx.config.gb_addr_config;
+
+			n = copy_to_user(out, regs, min(size, alloc_size));
+			kfree(regs);
+			return n ? -EFAULT : 0;
+		}
+
 		ret = pm_runtime_get_sync(dev->dev);
 		if (ret < 0) {
 			pm_runtime_put_autosuspend(dev->dev);

-- 
2.50.1


