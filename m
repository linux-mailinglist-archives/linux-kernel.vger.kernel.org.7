Return-Path: <linux-kernel+bounces-751632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72966B16BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA50A5825D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C724BC09;
	Thu, 31 Jul 2025 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9MzeDCS"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E4246787
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940215; cv=none; b=fI1rTfjzdhK69WkLDzPPy1cRqq1RApnNfl0dceydpW9xUfHqV1O5GDej5CJamdQxDpyXzyhNtGSJJ8e4/np7vV7nfz9LcxNKZew0i80KT/+GBVl+eksJcCGvWWSJ+hmm/yMmCIB+OvJp7WbHeLHYVd8y9tYlfddRawALophzer4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940215; c=relaxed/simple;
	bh=RR7lB52vap1BfZ4IteGmLPGPdbg07bAO0tj3IxKpSQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVDZzI+Awfzq9dP8ntYGPxz7CDd1MBh/tS/NMCsxBE7n57xOSryoe7n9tnVXaEBEymRgeNZpwktK4m8s/UpLCQ1jIwzETXP/LpR/944QhoE4x98YEFA9+I0sJ5Klw2M2sa3u6shaVfHMLFuGMA0qPxozv7KTtRmVl/yvtgIQwaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9MzeDCS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b794a013bcso621452f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753940212; x=1754545012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMZpWfQTqvxub6EnV2WBq7DOhIOcnfoMYMkFRXtjCnQ=;
        b=K9MzeDCSbrknGWirOru3QfzIv59BSZySgayeyQy9+pivUeY0LBge1BfQkFH+7hmoe9
         17hXQgGInFPoCSlyLZgpcOgwXf+e/C/8qcgqg8lIHYFY+75PPgCAhFGaW4e2aWxSymsQ
         wuz0As517oIW2DdX0Sgmc90XXdI0ZHVegYpCyAbzRXoi1laju/ETpgxVlh0pG1EZzVAb
         +YQsXGyzRoFU/6VG7pZQEvxynp/ttwvfuJZMw0vVxvaMOJLUu+PPfziTVgBUKJojmf9V
         IJ9yuEc9Jld4IRpFectdxR3jZQivSioeKt2Q9I/GfWBFEVwr59UOksN1LxkM2twJPLGS
         rscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753940212; x=1754545012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMZpWfQTqvxub6EnV2WBq7DOhIOcnfoMYMkFRXtjCnQ=;
        b=MrGKrsBccRmYadZi3mnnGknZiGDD1tBLgxFDjkRPgJB2ikdSDDIvP6TUh9tsP6+Ty2
         YKf/WY41ebTVMNiuwHBf/mTYIBRWUyOqP/QKNnyZ3HPvSn5HrJeatCkBcPC2oKx6GMek
         jEVvjF+F6PF7j7wJ96d/ZfaJ2dezPZrRIcZP8cLAKVUKOmxAf5EFsDNWU5DiQFoYbCM5
         7JhWK6SDwkWIeAyekmA/0fi74dZQJYER/eKURwx2jOoDTkc/FCNRQ6Rx9GqPVFViq0XX
         Q2JyCnr9G8E5IYDQK89vfbc3mTMpSxubkTVN36nS2d3Y6c98rzvlVRysw492O3SDf2Pc
         VfsA==
X-Forwarded-Encrypted: i=1; AJvYcCXcaxWyeqTvLFSDyjV/lnia/PTx/bqh0PlGIKeWSki2lQf3HORnAl7sralSGW2KNZvZMYE8HChUwfIfbj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRainFpoFy9DOJZVXn2DpLL3tl123rtB1wkwWO+fAlECCMTvGJ
	mb7TvmCH+opGapRKoQjx/ki7yIu9pRuk8Op5TDA/p09phycJSLuUcTol
X-Gm-Gg: ASbGncuubI7OeZ8lhMRygEYGPQvaSvdElZq4oZ+KfvZVL7m/ZoX5b7230qlk4AR71s3
	StQvAbWrXYQgU3j52Um7jIDYx7hvGtY1XBTusqPGk26cO5/kjScoJH0eclui/R9rGhBPYxfMMK9
	iAJ7g/f36lTLGI3oCXA3r4KvLwVJpkmJfLJ5CTfH/HR9rUmDO1sQbgHZnDx7bbyWBq64uMYxi3D
	v42z4LGolHygwV9T417u16UGRNdlsvVEAdYkJuTthqz83zDYPq/nOP/0OXbfeh7XfEta/2lroMn
	vaC8w/MBbhPEguTLBE4V4/f/BDeY9Ktt2HdvC1u6DCaFp3QLQFU51kl/Y62N/LJPUvL56Yg4I/s
	aF5Ds3kPgtRFrs6XbtJoED3VnUwgd1pQip/s3MPaKsLDePpoRNPfH65vRt21Saxe2fVVCMuY=
X-Google-Smtp-Source: AGHT+IHdfzXx9K06cb/UnitGjPmvC7D+NZDjqSkxgc5T7oHEjmuUebpFeyLmNYxu/axLoj3DiwsXzg==
X-Received: by 2002:a05:6000:200e:b0:3b4:9721:2b31 with SMTP id ffacd0b85a97d-3b794fc2684mr4609111f8f.5.1753940212394;
        Wed, 30 Jul 2025 22:36:52 -0700 (PDT)
Received: from [192.168.1.205] (dynamic-176-005-138-071.176.5.pool.telefonica.de. [176.5.138.71])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm1149137f8f.9.2025.07.30.22.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 22:36:51 -0700 (PDT)
From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Thu, 31 Jul 2025 07:36:39 +0200
Subject: [PATCH RFC 6/6] drm/amdgpu: don't wake up the GPU for syncobj
 feature detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-b4-dont-wake-next-v1-6-e51bdc347fa3@gmail.com>
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
In-Reply-To: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Philipp Zabel <philipp.zabel@gmail.com>
X-Mailer: b4 0.15-dev-a9b2a

Don't wake the GPU if the SYNCOBJ_CREATE/DESTROY/WAIT ioctls are used
to detect syncobj features before the GPU is powered up.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2295
Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 79d31ac6a7b37..b12342e917193 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2981,6 +2981,14 @@ long amdgpu_drm_ioctl(struct file *filp,
 		}
 	}
 
+	if (wake && unlikely(!fpriv->initialized)) {
+		/* Allow syncobj feature detection before GPU wakeup */
+		if (cmd == DRM_IOCTL_SYNCOBJ_CREATE ||
+		    cmd == DRM_IOCTL_SYNCOBJ_DESTROY ||
+		    cmd == DRM_IOCTL_SYNCOBJ_WAIT)
+			wake = false;
+	}
+
 	dev = file_priv->minor->dev;
 	if (wake) {
 		ret = pm_runtime_get_sync(dev->dev);

-- 
2.50.1


