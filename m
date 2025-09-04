Return-Path: <linux-kernel+bounces-801511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A52B445F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF3168467
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10D626B755;
	Thu,  4 Sep 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNSlqO71"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64253263C91
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012336; cv=none; b=OkcnpAYnb38o6KzNUH6bbhBye5bE6HHXaxq6dolWIThxsqTzPjc7GGF8BUiP81me083FhmahirDlHrjzFYOTK6ygHWZp9kFJiIj+CTacQXrqBU4uW/3qj4csEoCtsonG8640eIFQJIlPrzfEt82enG5aFTuwFy6nxxjTR+Eh4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012336; c=relaxed/simple;
	bh=Pb+xBGuXofkJWty7sR07UV3scv2U/dGsYvGE5Dxp4tU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jc/z8ok8f620tnixMVdkY5UjAUoCqM42xCNlKzg3GlHkAPJEmX5qahk/DhvTPttfyF1X/dNFa8Qp5lplPNwrPIWwqUpLm2R1U6+eyXbjGAPdHoAjBD9jyJhCPFXIeyv0UR38uJj7OAGhZ2QslEMbssA8+R4vZ6BW9X30u6Xxtno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LNSlqO71; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so10216445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757012333; x=1757617133; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THAARjTe9E517vMG9YGk7Zlz2cjrMzVkQSu/T28Yamo=;
        b=LNSlqO71VbU2FW0/k9JrBhxLdk9LMfrSs2IGADWBEYSYm6OFPGzDUG4wi0/kFgx2EU
         JjAAnit+foFy3L/baK3Bq4xFlkQlbdSv3g/8Ojgnk9u3TBq72dtbkpGdTCqLlVcaIm91
         t2m4eM1CxxtiaU2D7kVHWsnv7YB0Vfu4b6QOMmOjHGorG5P6gdkfNbNIi00iET75ad+0
         c1orivd4R9Ozk3EqpVcgmecsyinjICPMxASpNZXowooy0hbuov0lojpxS3UEX+ErQtWu
         86tFE8fzi5EiJEm58rlkNhYOgASBGr+9fCJf+Znq9BzKpHlkg3vDVTIihPUFOn5ujkK0
         /2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012333; x=1757617133;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THAARjTe9E517vMG9YGk7Zlz2cjrMzVkQSu/T28Yamo=;
        b=UWw1z9crlDgvSzbSXfyvNKMzzp+HnnpHNyAKzjNfLO9SJUfQrJwpsP0jLiqmyn4YsA
         IwuaDSNxatWl8K3QTtE8Vtlm+wiLVUTk0lctbITHvnGcfgmm+reNb6UiISlUYDiio2Dv
         OT8zKy9bb5ZY80XSvAhmVYGuQF08WkUSWSWjVvGu0NgZ6bBy7dLfHSzp9j/boLafljc1
         vrpZrVTzgexKGrhLLQb5mIB2oOsAoBCNRNOftkTZnbtSH6ED5soaxrTDlP8cFExPtD8/
         u0LoCU+D7iSDuejScB2JYQgxyXgiptS+I98aLEXi/qvHH02/3DX2sQn6BgcaDUGCJWTA
         Vhsw==
X-Forwarded-Encrypted: i=1; AJvYcCWKgZD5se5Qfn7Jn2ztnwv1jugO1PLH8j8CEYxCdB9zc8+Y7j1i2MY/J0xh+FB5rFQoatnErDJhqH1BjyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCodZ5thZLqZmBscbt8who7NIxpfDQ1+J2iTFR5a7dDgesVoNW
	QVvk+HW4sEopkpwhZuZPiztHwxX2FsWhIigw9O7kClGqmGL4efcqap8Y9ORZDfuKads=
X-Gm-Gg: ASbGncuTezeX7SyTUnaw/4NDOjveGKnOEG0+H/tY2kB4unSGQBGsyz+5vKxtLGL8aVA
	NJzcoKpNyY40VMGxrGhGu1gknBATHiYoA/RdL7R2GsFl+2xo59mUhG50xPbDh/YVsAnAckSkpGX
	7DArk80np3uyPc5W5zKFWYuTam28ZjU5oRfP6LNlSzhINnBn7X2NS0nubgh30AXJfo/eWm3ZuR0
	Kx+7bUtGrFdFrDZMLcSVr9NS6rOt7zHYizDo6i3jo3OciuOCMDt/5E8CPkH3o9aEXkJWr9dbkG4
	uVTsYodKdGFtfT5E1vE6QDnUR56EKL2WIR2+ljzoHg2s9S8hJPrerLA7LaMvFwhhNN3V0j5IMAn
	LGZbjJeEVUQgcAMDkSS8QWYWb6FhGLdDax1HVRA==
X-Google-Smtp-Source: AGHT+IGHjaQMqzH68th7G1hlLUvy5iZJ7Ftrhmy23VSwVbhKc0VKhfXm8Y3FkmDt97UXGlsf+UOBzQ==
X-Received: by 2002:a05:6000:2906:b0:3e2:4a3e:d3ee with SMTP id ffacd0b85a97d-3e24a3ef991mr1671892f8f.58.1757012332670;
        Thu, 04 Sep 2025 11:58:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3dbead0b247sm9395154f8f.6.2025.09.04.11.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:58:52 -0700 (PDT)
Date: Thu, 4 Sep 2025 21:58:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Francis <David.Francis@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Arvind Yadav <Arvind.Yadav@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: Fix error codes if copy_to_user() fails
Message-ID: <aLnhaU9cLeAdim7J@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The copy_to_user() function returns the number of bytes that it wasn't
able to copy, but we should return -EFAULT to the user.

Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioctl")
Fixes: f9db1fc52ceb ("drm/amdgpu: Add ioctl to get all gem handles for a process")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 63eb75a579ce..2b58bc805374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1067,7 +1067,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		drm_exec_fini(&exec);
 
 		if (num_mappings > 0 && num_mappings <= args->num_entries)
-			r = copy_to_user(u64_to_user_ptr(args->value), vm_entries, num_mappings * sizeof(*vm_entries));
+			if (copy_to_user(u64_to_user_ptr(args->value), vm_entries, num_mappings * sizeof(*vm_entries)))
+				r = -EFAULT;
 
 		args->num_entries = num_mappings;
 
@@ -1159,7 +1160,8 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 	args->num_entries = bo_index;
 
 	if (!ret)
-		ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
+		if (copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries)))
+			ret = -EFAULT;
 
 	kvfree(bo_entries);
 
-- 
2.47.2


