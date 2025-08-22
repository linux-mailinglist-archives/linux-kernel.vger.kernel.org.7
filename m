Return-Path: <linux-kernel+bounces-782507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6EDB32163
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFFB687331
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D1275AFF;
	Fri, 22 Aug 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H58es/lH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FFC1D5CFB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883052; cv=none; b=nwKpnQZ+Cu2FkPOEBokQnECsP/RtTjt+LEeNLCGj4YTB55aXIS/f4J72nuP3L9BKGRRgs/R7hhUah5v4nz+Jn057apn4ED8Q6tRjOlKj/IjehtlEJ6eRZMKt57CtT6p7CXcqWBr6aM5z5jqffAYc+fpwykWQnfQep9ZVY3IH0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883052; c=relaxed/simple;
	bh=5Udo/f8ent/K3o9ISDeOwIWa6pto6XFRhDz1qdZBK/s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=teMX6xenwqJo6Cz5Y2lHnvHzE4YCrAD9ByVKm5M4RglBiEegyE9d5FenhGQBQu2WXIPvLb3quMtmMxGlyqovS+QCdHNOBqoK94fdbxLDIh413q6LBjXkr4YZNthXQmfurOrOC7ddOW9/BIS6ji+800ptoE1UIjV07snHUZHk+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H58es/lH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so14100805e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755883049; x=1756487849; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nG60mJTcfDhZrN0Chr9ou2fiLnhkow+tZ1jRLbxcJ6I=;
        b=H58es/lHKvLkGOUNkdCCn1kAqRZjWMIe6TnktkO+odkdjU7qbzNQSf/vBL2VT8R6HQ
         nRDNFwSImMkWdFvqsPIjVab2mN0RnBBYJQ/GUsCkcWl7hOCNWL2PVbsU/wSBpqY8b1+v
         lIme8MLwV4N/swwnOMA9/CBZ4emKSsBHZs6Bfy2YI7ao6r9vUBO1ckoucptoxz0NuHDK
         Ol2tyXpEmN7H6caLVaRxH5JXNm93WQx6lx1Fua63elHQLffffx/c2oc+K/AuEdSSrLqR
         pDPL336ffOHhTTuNzMKBL8Km6DoQp4Ozuqs4cNbdZ2Y2plyNSGjrFvk7L1Gli/80PKC/
         2Ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755883049; x=1756487849;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nG60mJTcfDhZrN0Chr9ou2fiLnhkow+tZ1jRLbxcJ6I=;
        b=AoAaT1GXjzmevRKrdkwd/xZhXsnh5PuUgArCzjjaYvyg6cDKx/CNPQ3iSNtiHkoV+R
         bNDP6x6x0tnAUppT2Pjoi52WkTjWifntTSVs7mICdd6XJitpIqFjrmPxVOv1lcIfJwsw
         OhSg/hXeKAZYjNBr3nvnXldYPjenxnUHJ8ZocryzU0/3Lpx9xR5LOslMeU78IGcyW6r9
         i8ignByWM3RmH0z0vEmdP5kW8QwHhEWMqOTdX6gWvJry7y60ahKMiRA5p8FAYHzXGO05
         FrUDkTxCHc/gBCuRFELUJl8058Fyr52hXMw2JVx2GBXRCv6rBM8px+sHJXvhlDT3BDy7
         JjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUABpr62z5ZDKerTJ4xD/vm79w6kQMB38+bjJH9wZHO/g642mVwyU+iq0RH73PQKlsYZa8KUZKVXrDixVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7UlDGEA16UYSq19dLzv3N2xiWQdKx8wyKfM/qxDkiz8KX2joq
	OtIQBv9r+sesP1ZhtAHkeVNYVlWPW6HFDzpVx4wDklBb0U8otmaY2b/++yUHPTfYdCM=
X-Gm-Gg: ASbGncsMWqYNz7k9u8196sp51YR67Kl9FkYpuKFQMxPyRcm0dOIjcxfKUcO3u3Kp5Ju
	4nfSHBh5R4he5vyre/XcUw/nACJEAXtC54VRTdkF4W2WE4Al4jnj7wGCRTvKR4YFcy6i+83GXQF
	JdULMeh1tZjylyEBM59P5Oc3/IonxgVxw/9OpCoX6cs1Wbkd6yfewtLfcWQiYnuTns/OqHIbS6g
	Mp10AevZBz3BU5LrL0xLC92HDyEJjY2oCAdygOyo8GWIjKSACh6NXmZuA52eaSiz0SNWCFwntlA
	Nm1AdKHzKRnyeWpZrpBk4H7ld7D738GENEl0BVbsa6B9qzI3HHWrwho+X4yYufjHMyp8mqH+gsh
	eHIXRFvFh2hx9YyoUBvr21iukVTM=
X-Google-Smtp-Source: AGHT+IE6I2k6xPHD429XkzRqTgiEYzD1yR/BB8fOScRUjLp3oce39ToFkb+CldfR2IO0M4Ry6HmIRg==
X-Received: by 2002:a05:600c:4fcb:b0:458:bc58:850c with SMTP id 5b1f17b1804b1-45b5179f436mr29795645e9.1.1755883049157;
        Fri, 22 Aug 2025 10:17:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c7117d5977sm207666f8f.51.2025.08.22.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:17:28 -0700 (PDT)
Date: Fri, 22 Aug 2025 20:17:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Rob Clark <robdclark@chromium.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Antonino Maniscalco <antomani103@gmail.com>
Subject: drivers/gpu/drm/msm/msm_iommu.c:778 msm_iommu_gpu_new() error: we
 previously assumed 'adreno_smmu' could be null (see line 767)
Message-ID: <202508230010.dMoERmOs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cf6fc5eefc5bbbbff92a085039ff74cdbd065c29
commit: e601ea31d66ba83d565cae9cfa45cbbcdd8286dd drm/msm: Support pgtable preallocation
config: arm64-randconfig-r071-20250822 (https://download.01.org/0day-ci/archive/20250823/202508230010.dMoERmOs-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508230010.dMoERmOs-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/msm/msm_iommu.c:778 msm_iommu_gpu_new() error: we previously assumed 'adreno_smmu' could be null (see line 767)

vim +/adreno_smmu +778 drivers/gpu/drm/msm/msm_iommu.c

8cceb773f565f3 Dmitry Baryshkov 2023-02-14  756  struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsigned long quirks)
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  757  {
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  758  	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(dev);
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  759  	struct msm_iommu *iommu;
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  760  	struct msm_mmu *mmu;
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  761  
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  762  	mmu = msm_iommu_new(dev, quirks);
db40d2928d245f Luca Weiss       2023-05-08  763  	if (IS_ERR_OR_NULL(mmu))
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  764  		return mmu;
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  765  
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  766  	iommu = to_msm_iommu(mmu);
e601ea31d66ba8 Rob Clark        2025-06-29 @767  	if (adreno_smmu && adreno_smmu->cookie) {
                                                            ^^^^^^^^^^^
Check for NULL.  Hopefully this can be removed.

e601ea31d66ba8 Rob Clark        2025-06-29  768  		const struct io_pgtable_cfg *cfg =
e601ea31d66ba8 Rob Clark        2025-06-29  769  			adreno_smmu->get_ttbr1_cfg(adreno_smmu->cookie);
e601ea31d66ba8 Rob Clark        2025-06-29  770  		size_t tblsz = get_tblsz(cfg);
e601ea31d66ba8 Rob Clark        2025-06-29  771  
e601ea31d66ba8 Rob Clark        2025-06-29  772  		iommu->pt_cache =
e601ea31d66ba8 Rob Clark        2025-06-29  773  			kmem_cache_create("msm-mmu-pt", tblsz, tblsz, 0, NULL);
e601ea31d66ba8 Rob Clark        2025-06-29  774  	}
f66f3cf6bc42ab Abhinav Kumar    2025-02-19  775  	iommu_set_fault_handler(iommu->domain, msm_gpu_fault_handler, iommu);
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  776  
8cceb773f565f3 Dmitry Baryshkov 2023-02-14  777  	/* Enable stall on iommu fault: */
8cceb773f565f3 Dmitry Baryshkov 2023-02-14 @778  	if (adreno_smmu->set_stall)
                                                            ^^^^^^^^^^^^^^^^^^^^^^
Because otherwise we are toasted.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


