Return-Path: <linux-kernel+bounces-863097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798C2BF7011
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121351897629
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DA133B964;
	Tue, 21 Oct 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+8ojhL1"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319653396F0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056110; cv=none; b=F+2whgc5Da6udDSbg2VMb63Vojd7/dyW6R8txauVZ35/GtyLfPlTBaoTeVV2vgFUtLdCLj1zLl/2oc/OuC55Dw9s8qFN89EFvlVuWQXJfJn3c27kOsBoy6oLUJ+14/8H+JWEi3YpJvk2OP2knpEyrwgmdkXXZgYvJdLGI6UpR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056110; c=relaxed/simple;
	bh=wnd5bfNfiizPv1q7k3Gi47EIxiAqC/A19yc9U4Hg/CI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BjSKDIpNSyMe5Yo5g0lGmIWJGWmrlw56MDwAAPjYpBqCLxN/v7yzN4rvkzNmzwNxI15914vclPAReoC43gYLPxALeaBLKqcpkQCociQKFDfbbJG3Fcw2Xp0SDBhTewELgqUXtIgPBZKcarHnw8N7S5q68HroMNS5YxheMA5E5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+8ojhL1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so4185871f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761056106; x=1761660906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/dqpTPnvV8iWWmqMGgRLH33p/ANKaib0nnfEtLriAI=;
        b=o+8ojhL15amvPq0PTyzYGZWwACYTxOdJPPNgf6YF8t19PwCHPj7nhkIXbVgCI84aM5
         8hChJOTexK6Cl3AnniE9j4tzDP6m1zlyV3ujVXv4p9J2lXhQ/Kb8SVZg0YWLHgvwNoRO
         yX/KM9Gx/c5rXXMwSWgys3Fn8U9s1kqGpo4HEoDmcnAn22LQ/Pvh2kgbag8XbwOGLIHR
         HpHO4ouYdnzOf20ilIn5+hrJsgyLNRSniUsyBXUtJgZaeiZgor/ufAbDqvAbpk6XELG/
         GgYLPSSefZzpdNotGB6Sdwt6Rn4VzOgr1gmEQy+zg84487nrD5WvbHmhzd0SiUj+7Xb6
         pKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056106; x=1761660906;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/dqpTPnvV8iWWmqMGgRLH33p/ANKaib0nnfEtLriAI=;
        b=Y9RrhZppP0/R3d84wdPRH/HC0aqx2GziMvpQ3lXnXrOU+B+rqeU/EiAE467n38g39x
         9mPSzs/1odnMOPmLgg2Yf6a9Mlp5ysLxb+6hqje0Ug7ajjx0zP5yPZ648Yj9ont62wyZ
         IGZvUK4wlnHlEuOA3OFbM4EKt1Hx8x2RYS6nHEujdSpr0/nYTUkbTvmTDWPqM3vw0MPz
         klmlNO4bQrswVC91ot07lR/LPmPihLuuUHhqaONzwkcyb/PgsEzsP/esw2m6fljo9s85
         hdxoZE9fKORMIhXJFtsbXvc1jnk/3nTPVfqOCBvWVYPCA5IipLP4Cd96mWqvUd+PuXS9
         DAfg==
X-Forwarded-Encrypted: i=1; AJvYcCWEZkY5oNHcHilA4UFXp8PtxzfkYH1symt+UiUe5/PXpGOwVjSTK/fAZ6W9Lhq9Z/bKRJEsvFhztdgEIbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpL78Dw2dTGiqQA+9Do4mYtyrWpty0rjizOCAKEopxcussglmC
	756zRpwLYbTV6l7sXt9GpLvR9lyRhgDpMDqWaXlNXOQt+KdEiHd3RsxtvmyjmvEjCGY=
X-Gm-Gg: ASbGncuESz3UvAfx165buRCHjofPH0GYddDZXnDbozUzd76AK1KWgCSgmoiziTstjfS
	/e/J8OLbA7KC/D0x7OdBfpbvnMccNeqKN70m8s+IwVEpqIGoG2INjpzdQs1Wa1IIy1q+nBX+PoT
	NGrL6o9dvUsaPzSqvqVcFAnrMiomiJ/qkyX1g/JgKpcybbmB0usILLpZH4s8WV2IVXBDBxaDgVa
	Lok17mSJkty7KBVkRuhovUo6pT+pC3nXs0wkVodklgXVG7icSHymBpqXJPkiePC3LkRxZ2/pI8Q
	E6NpDxBN9jW3Tsv7tuh+xh5iRmMjAKwhclUEIV4LMx7tUiRAMHlRwvQmhJ6EjooY88lEGWegFpm
	8EnKvM+rR/GZE0ihZdCwoImgp5bVLs8Zi0WHsrObh4kGOstYeaza9dw0CIRW2S9z6q0GN5OWwTY
	5RTuGqBGtMzYInbF3J
X-Google-Smtp-Source: AGHT+IHCNZ/tdeM6x90rsmi2VCTmRefM5mCM/ZgV62wABJXCvN9MGq3+VgVSrxQSIurd14j6LlHgGg==
X-Received: by 2002:a5d:5f82:0:b0:3fa:5925:4b07 with SMTP id ffacd0b85a97d-42704d74f9fmr10437179f8f.18.1761056106262;
        Tue, 21 Oct 2025 07:15:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce3e2sm20554878f8f.47.2025.10.21.07.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:15:05 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:15:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Jie Zhang <quic_jiezh@quicinc.com>
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Add support for Adreno 612
Message-ID: <202510212140.4YWihsB7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-qcs615-spin-2-v1-1-0baa44f80905@oss.qualcomm.com>

Hi Akhil,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Akhil-P-Oommen/drm-msm-a6xx-Add-support-for-Adreno-612/20251018-011020
base:   cb6649f6217c0331b885cf787f1d175963e2a1d2
patch link:    https://lore.kernel.org/r/20251017-qcs615-spin-2-v1-1-0baa44f80905%40oss.qualcomm.com
patch subject: [PATCH 1/6] drm/msm/a6xx: Add support for Adreno 612
config: powerpc-randconfig-r073-20251021 (https://download.01.org/0day-ci/archive/20251021/202510212140.4YWihsB7-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510212140.4YWihsB7-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/msm/adreno/a6xx_gpu.c:641 a6xx_set_hwcg() error: uninitialized symbol 'cgc_hyst'.

vim +/cgc_hyst +641 drivers/gpu/drm/msm/adreno/a6xx_gpu.c

4b565ca5a2cbbbb Jordan Crouse  2018-08-06  600  static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  601  {
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  602  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  603  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  604  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
b1c53a2a2d395d4 Jonathan Marek 2020-07-10  605  	const struct adreno_reglist *reg;
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  606  	unsigned int i;
40c297eb245b1c9 Konrad Dybcio  2024-08-28  607  	u32 cgc_delay, cgc_hyst;
51682bc4abf4b55 Konrad Dybcio  2024-08-28  608  	u32 val, clock_cntl_on;
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  609  
dff2f69f3e8a6ea Rob Clark      2024-06-18  610  	if (!(adreno_gpu->info->a6xx->hwcg || adreno_is_a7xx(adreno_gpu)))
b1c53a2a2d395d4 Jonathan Marek 2020-07-10  611  		return;
b1c53a2a2d395d4 Jonathan Marek 2020-07-10  612  
66ffb9150b00f3f Jonathan Marek 2020-07-10  613  	if (adreno_is_a630(adreno_gpu))
66ffb9150b00f3f Jonathan Marek 2020-07-10  614  		clock_cntl_on = 0x8aa8aa02;
5cb9695ccef2305 Jie Zhang      2025-10-17  615  	else if (adreno_is_a610(adreno_gpu) || adreno_is_a612(adreno_gpu))
e7fc9398e608a7b Konrad Dybcio  2023-06-16  616  		clock_cntl_on = 0xaaa8aa82;
18397519cb62248 Konrad Dybcio  2024-02-23  617  	else if (adreno_is_a702(adreno_gpu))
18397519cb62248 Konrad Dybcio  2024-02-23  618  		clock_cntl_on = 0xaaaaaa82;
66ffb9150b00f3f Jonathan Marek 2020-07-10  619  	else
66ffb9150b00f3f Jonathan Marek 2020-07-10  620  		clock_cntl_on = 0x8aa8aa82;
66ffb9150b00f3f Jonathan Marek 2020-07-10  621  
5cb9695ccef2305 Jie Zhang      2025-10-17  622  	if (adreno_is_a612(adreno_gpu))
5cb9695ccef2305 Jie Zhang      2025-10-17  623  		cgc_delay = 0x11;
5cb9695ccef2305 Jie Zhang      2025-10-17  624  	else if (adreno_is_a615_family(adreno_gpu))
5cb9695ccef2305 Jie Zhang      2025-10-17  625  		cgc_delay = 0x111;
5cb9695ccef2305 Jie Zhang      2025-10-17  626  	else
5cb9695ccef2305 Jie Zhang      2025-10-17  627  		cgc_delay = 0x10111;
5cb9695ccef2305 Jie Zhang      2025-10-17  628  
5cb9695ccef2305 Jie Zhang      2025-10-17  629  	if (adreno_is_a612(adreno_gpu))
5cb9695ccef2305 Jie Zhang      2025-10-17  630  		cgc_hyst = 0x55;

Only initialized here and not on other paths.

5cb9695ccef2305 Jie Zhang      2025-10-17  631  	else if (adreno_is_a615_family(adreno_gpu))
5cb9695ccef2305 Jie Zhang      2025-10-17  632  		cgc_delay = 0x555;
5cb9695ccef2305 Jie Zhang      2025-10-17  633  	else
5cb9695ccef2305 Jie Zhang      2025-10-17  634  		cgc_delay = 0x5555;
40c297eb245b1c9 Konrad Dybcio  2024-08-28  635  
af66706accdf5af Konrad Dybcio  2023-09-25  636  	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL,
51682bc4abf4b55 Konrad Dybcio  2024-08-28  637  			state ? adreno_gpu->info->a6xx->gmu_cgc_mode : 0);
af66706accdf5af Konrad Dybcio  2023-09-25  638  	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL,
40c297eb245b1c9 Konrad Dybcio  2024-08-28  639  			state ? cgc_delay : 0);
af66706accdf5af Konrad Dybcio  2023-09-25  640  	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL,
40c297eb245b1c9 Konrad Dybcio  2024-08-28 @641  			state ? cgc_hyst : 0);
                                                                                ^^^^^^^^
Uninitialized

af66706accdf5af Konrad Dybcio  2023-09-25  642  
dff2f69f3e8a6ea Rob Clark      2024-06-18  643  	if (!adreno_gpu->info->a6xx->hwcg) {
d2bcca0ccccfa5e Neil Armstrong 2024-02-16  644  		gpu_write(gpu, REG_A7XX_RBBM_CLOCK_CNTL_GLOBAL, 1);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


