Return-Path: <linux-kernel+bounces-768916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB6B267F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6915E8257
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C3301497;
	Thu, 14 Aug 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2KZggfTd"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF2301023
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178458; cv=none; b=NCbipT+lPXNPT1fC4sm1uZZp/1pWDAAq1rypPZQmIYJDoBaOrmnTp/AcvBTB0mWLK+rx1Dk6ScZxl8K+nlLMDQ+N4YKS/w3ND7rSz0g19a8zqW1J3TPOl6rSnyLc0BPkPZLa02ERux05tatxccMrYMSuXLnqh0/Gsc0w8Ar9TXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178458; c=relaxed/simple;
	bh=d+Zq0KH9V9tpTZLWaI/Ubtudof8ymOMF5GgtpZJcnEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr+fwBo7Azry+FYAvjIVvjnr/85BoQBdi3KHk1EIbQTfSHmY/lkNZBPWJNygfrax1S0KC730l9Fa+lQXxePx5zy3iuArsF9haz0jNyHIc92F73jd/2XEPJFOQRQzElBhlJwnWTYt0g/fjYUc9TIjPw+CIdH5P8NANp+VnCMHS0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2KZggfTd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-242d1e947feso196865ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755178456; x=1755783256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVPZB7Z9YFYF+yeaPjpUiJMadHLWEgG0iAH/nCr4blI=;
        b=2KZggfTdoQFu/PjAURZDRMMPELA6wafH4uUgCSvzV9GYnMpgy3qBfvOrdRMxCpGBe2
         Rd98R+rkcj6MwG+nipdxqo2PxaARaF7PrOwdSOYVO1WZcAfS3ZAtJ3bT72ukNrarZHs5
         pw6ZhwtbmEEqVsSXA36Ih7ygKABfai/wRt7pH/KMrl65bCV3kO/Cpmk59H6R3GsHHozt
         K79bJCnTx745vt+QrqOIunh3KzYnimoFxHThyLVSFQTkxZdUyX4610ogAp62zmdFks3r
         psmCSuVheSUxgSb+jzTHoc9Y6v/WiZj1xsQ85U51DNLaEjPEv0TS434dTvKQ6J0oMGK/
         zV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178456; x=1755783256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVPZB7Z9YFYF+yeaPjpUiJMadHLWEgG0iAH/nCr4blI=;
        b=UxVi2sRI+qXssQhPWFaxGpNOxkbU0poTErCwDj+XD5o9jZzHOrkC9u55848SGxcLFa
         fI/yTx/DvDf9zJTX8SKzZ8AIdDFGVDeP0pOHCswSMa+SKmKkELy3cqbtsaIAXVXDsz+S
         6Wl3W76xPSCOuIwm4V6kHoHys00BEw66FLZDM1Da6r/uzxMWnDF+VwD/te2PgBDR2kE1
         Uza5cXefo2TLGpmc9OciXERo/iH5/U8xgfMlpe5BA8w6no9Ow8lPhoWRkp3S5XCRIlUk
         enFQrtk2BFQdmHcGDxWoNmM6Rn+g1cvQDLcInAEdnJ0S6aFIdZpB2hcpJeeh5nj5HoPo
         CXEA==
X-Forwarded-Encrypted: i=1; AJvYcCUuOgiWk8MHHoweOmSnZ3IPb/SDH6mXhbcLBL+mDYSWN4EiUIv+SWrjqoYwi8Uy3OjiZ89VRqEM8e85CbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTP9CPFnv4zgAmayy7CsgvHCwQKMuSlLxaAj0TUjsVg0/Ra3Ef
	nOdHuzQmgOSwaA7dlUIi3qJFk2QWNEYdmxLzQOXI2Yb+LebwmC+yw59kuZcZnHgiAw==
X-Gm-Gg: ASbGncuTGuBUPWt+JvKNOyQH7dYkO+yv+UpJfQzH76919Hkkvgr7fmhIxp/WYUCe8xf
	SQAtlkJKVAYy0Xiog8YIKAMssM5BY0PynugR0ursz9iChLkTJJP1tGNmSJshNJh0lp8LQGg2yjn
	IBOBOXzkUXve7UsQd1GBEYXsI7yig92lyu87JG37ACcmKJWg5vJZV4vkxqcSKWsKaxdIsgt/hBf
	P1B8TAqMYbkEy0/Ub2Tr7z9A2Jmfqbf0u+JHI3/wVjgl/XFWzaR8z3Hf/+N7ke5ra1bYU9b9Nok
	tpt3pyp/QnHUfl67ENNshoWyMH2KCp+wGRj4XcybVibQ+mfqkS7pj4cRjfIrV0pln3XiHGWZLrC
	qwl5P6xnXHQPEPKJXZvv2yHeUbK9NvZ8bvVERmtxBBQGWPq4YIaVwECHqQx23bnYei4GxkVvH+Q
	==
X-Google-Smtp-Source: AGHT+IGiurUt9ylpxFbjyO2OYiUuWjmwB4u7OQw4g4IWLeYevMmm62ZBdWTRpBtN2Em/+3rTdLUCyA==
X-Received: by 2002:a17:902:da83:b0:240:8f2:6442 with SMTP id d9443c01a7336-2445a7e8358mr3533555ad.15.1755178455620;
        Thu, 14 Aug 2025 06:34:15 -0700 (PDT)
Received: from google.com (208.131.87.34.bc.googleusercontent.com. [34.87.131.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd9b3b3d4sm32813235b3a.10.2025.08.14.06.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:34:14 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:34:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: kernel test robot <lkp@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: Re: drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <aJ3l0Te5Q1d4g3u-@google.com>
References: <202508142105.Jb5Smjsg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508142105.Jb5Smjsg-lkp@intel.com>

On Thu, Aug 14, 2025 at 09:21:50PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
> commit: 32b2d3a57e26804ca96d82a222667ac0fa226cb7 iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
> date:   5 weeks ago
> config: arm64-randconfig-r112-20250814 (https://download.01.org/0day-ci/archive/20250814/202508142105.Jb5Smjsg-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
> reproduce: (https://download.01.org/0day-ci/archive/20250814/202508142105.Jb5Smjsg-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508142105.Jb5Smjsg-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 @@     got unsigned long long @@
>    drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:     expected restricted __le64
>    drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:     got unsigned long long
> 
> vim +305 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> 
>    297	
>    298	static void tegra241_vintf_user_handle_error(struct tegra241_vintf *vintf)
>    299	{
>    300		struct iommufd_viommu *viommu = &vintf->vsmmu.core;
>    301		struct iommu_vevent_tegra241_cmdqv vevent_data;
>    302		int i;
>    303	
>    304		for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
>  > 305			vevent_data.lvcmdq_err_map[i] =
>    306				readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
>    307	
>    308		iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
>    309					    &vevent_data, sizeof(vevent_data));
>    310	}
>    311	
> 

I assume we'd need something like the following (untested) for this:

--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -303,8 +303,8 @@
 
 	for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
 		vevent_data.lvcmdq_err_map[i] =
-			readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
+			cpu_to_le64(readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i))));
 
 	iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
 				      &vevent_data, sizeof(vevent_data));

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

