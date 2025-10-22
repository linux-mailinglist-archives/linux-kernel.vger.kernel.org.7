Return-Path: <linux-kernel+bounces-864778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF8BFB860
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7A819A7125
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE63128D4;
	Wed, 22 Oct 2025 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMLxvlHs"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD292777FC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131011; cv=none; b=THFgXmQLRzrSf++o8UYAemqdOXvy0PjqySvS5ytF9p8PkxFILRJHfz7LNZ03c+8dGrLqSw+5TmQ037bv3VmuvM/ectGEWXAV4LPqllCx3sNO959xNnH6EYlcT3uqVbRchq2lWckheceVykzv5iW10RjQcUJqbOJ7TIjdLRC6f/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131011; c=relaxed/simple;
	bh=9Uy/GbSSbrHH+J1cYw/X1Mkj5ppEIj6A+wXow5MOoZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pPD4n6umA/mfYW8EC0qgEqEH1sIGHydLBEdtsmaJTHGiX18tVHSJf5vOdg3WIMuiUC8nXAMft+7LHjdoFKNLw5cFgr5G9/rQYgJlwLesn3exYFR4SfS+QIdUOzM2Je9P0YvMK18K5uzk/vmyumQQqo0rJSkurdQKSTap0ohV5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OMLxvlHs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4270a3464bcso3649115f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131008; x=1761735808; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXsoFSKSD+Jxnxd3GCdpg7hzwIK45uE+7Oq4mebbZTI=;
        b=OMLxvlHsHPYWxDDfKrfCcfJoehPNralEwh6Pw0I5Udm+OBYp3YvwNz04s/HAw6d26M
         PtYxBO0ypue+JIe1Tshop/EAGyR6zGUeG3eGGWO07Z6STRLfZhlcwZleohZ5jMJw9ID4
         C6ncMiS5+qhx54JPnCLfZq5nACHk9i7RYoVnsJrRAUw0Bi7S7glOKL3z+XgPhvp29wmM
         vb2e7XJTIfu5ttx+p0//sU2dtm0eghdiAZ/A32bUeuQ1fcoLqoqu3OKuFn35Z1wsJKAE
         jXa4w9aKyWXB2WUldrMVJBnoDZHdmfh80f0JAImWuZS0sW556kRNkjbohkA8Aln1vA1A
         PerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131008; x=1761735808;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXsoFSKSD+Jxnxd3GCdpg7hzwIK45uE+7Oq4mebbZTI=;
        b=D1hHIZ5LIA7QqqvYwxo2NhnTkxsWpcbYKAdb/i32P0IwL9Z9a8pLQmP+l+rd3UxQHf
         EWLV3ISKut5XJ+HMeV9UCgYABhUybd3S4vh4sG9m7WhOqVGGECkbtCGeJ3S3fA5O7eQT
         7tCISxgmRmg4ATgkJV2tuIevToLpm6V97zidVEV7VkCeVjY/BBr4MZMhPergOFxO9Vt3
         z8gJo2/nHD6IbqCAVBEVZb6FEK6NXRdjSO1S5vD/IMuQ3TuGRzBGzrWOiaYyp3GPFc25
         0ayyMIWwZ+QqTuanPopyjjradf3rEjvPZH1E11Hn+vs8GUVkJCvvoKCv49qNoIrfklO3
         kbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjaBoGlom1D+2ZlDaZs/jkAxWEyXWzgpNsOe4xHjmjJaOWUmez65tkBFL/Pc1qqy2oAXkPgvtp9V09ezU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jyaeSTmMbLAQBm9K300ll5cpEh5pA7byUcmrF7TW3nCV/1+7
	Qpm3l+P5bYs1hq8xQt7LLuDPolmBscpsPrvdGYqYV7t93OdqNLwZyj5hTYnUGcfMQCM=
X-Gm-Gg: ASbGncs4WyNY1McgLVdbMcmhgf4SxlZXR5/Q/ZY54WjV9OU8yNwGqGqRKCwUgEzXZ8Y
	6d2lb7o5EUolnOb5GjDxTxZ18R9f6TZWbPpZpxg39CDiOANL0/me+SQAff2NZDI80PmcRNqD0D7
	4njsb38RaEeQtfK/GlS7fnpEt2Fnurwaq7LBm9J1yMQ/+KYgwE5jwePugXyFgoUBhfBteqVssVi
	Eu6SHfp7CBQeMmUAYTB/nbrFbe6SjtKiu2wifclBxNdxomP/6plLwY63MmL26l7rSQLehScpfdF
	Pw4bdrk/OUq2o2WR/g8AuBPeCZTtxRfDyRVf+zc+6pRoIjbVGiUeaoidZDCmxT9yxSf2PFRX27V
	eaaQO8AsKBmf5pS7mgf57Xw8D22+l8ckYSu8mCpuH47Z/YyH63RtVn2gp60uPOskhS4qmOP4/7v
	nzGMX5qU9bN54lhG5o
X-Google-Smtp-Source: AGHT+IGqGsmmm51ejlY0k7sOzKGZrFx3JPVXLYQMM7eHv3uJuXOnG04Xu33Xnd/PMxPWMzgUajg6yQ==
X-Received: by 2002:a05:6000:470a:b0:427:491:e77d with SMTP id ffacd0b85a97d-42704da9e16mr13267011f8f.36.1761131007920;
        Wed, 22 Oct 2025 04:03:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3c65sm24546043f8f.15.2025.10.22.04.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:03:27 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:03:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu/userqueue: Fix use after free in
 amdgpu_userq_buffer_vas_list_cleanup()
Message-ID: <aPi5_CILMKn3ZrVd@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The amdgpu_userq_buffer_va_list_del() function frees "va_cursor" but it
is dereferenced on the next line when we print the debug message.  Print
the debug message first and then free it.

Fixes: 2a28f9665dca ("drm/amdgpu: track the userq bo va for its obj management")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9d4751a39c20..2200e0bbf040 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -159,9 +159,9 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
 			r = -EINVAL;
 			goto err;
 		}
-		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
 		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
 			queue, va_cursor->gpu_addr);
+		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
 	}
 err:
 	amdgpu_bo_unreserve(queue->vm->root.bo);
-- 
2.51.0


