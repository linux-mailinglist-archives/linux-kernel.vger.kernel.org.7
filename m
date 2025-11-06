Return-Path: <linux-kernel+bounces-888562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99793C3B298
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9179C1AA7D9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9708B32ABE0;
	Thu,  6 Nov 2025 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SajbPt0I"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113630CDB7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434615; cv=none; b=bm1bbiWUZFHsGGEw/MD9HThRcPal2fTldDNW5PzXqjlBbAo7AL20hRqvfKMVg8MrPveszAR9vZFNDUZ6ANqPjMUCPXLSShFMhkQ+n/3CPtjFe/1aH8Q5otRzOo0QxDujHNN430TaA7XDdg9MY2oVk9U/Kt7WDz90bGAMzsre/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434615; c=relaxed/simple;
	bh=QVY/AYM5oY5fMTDiOLcTDfmGhegxKbaFzRVX886wGAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SI/QIJDGU1xuDbY5vMWxf/CKnKQeGvzAiVTOb8oU6nWDp9IgjXDu6S5tF8DbvraXU57Jy5W/yV9FEwd0TilFoJcri0PKNjHOBUrF0v4Ta2ScBms7gjlbV9A/xEkkzbjoWF0EsOcEVU4u982oUcvWCru4lNTAuiW6o46BdkgNQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SajbPt0I; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b728a43e410so161393266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762434612; x=1763039412; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t28efrrGHhAa89xd4/lbe98NRmddX9nmQ/RG7kZgsm4=;
        b=SajbPt0I++aNLIgZEDhB23KDTS6VEaL5SFjTIQib4BwGFovWcrDgR7Hw/9Wbkjr21C
         hZe952hQJDbcldSaeOiJDbx7frhvtCUL3MhMBoYtRhbdcMGkvopfCkAqufLI5sXnDOmK
         7h7D0K2oGO4gcqKZWcTHQ9pUUl+b1YONZgnGYn8PM7d3F3oXbvQMc50miZHbY+0/WkE1
         rBhTzUe0i2N4tsBAxwCugGK5+i3TMRFYR8v5WFulLamW31LWqzItRSwD7Rm9NC3yj7Ww
         W/22DIqpTRfXNXHgCVPDM3648diQC7Xxx1C9eCNFQA1p/k0NHNWxxP4rBiuRXH4b6tOf
         HPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434612; x=1763039412;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t28efrrGHhAa89xd4/lbe98NRmddX9nmQ/RG7kZgsm4=;
        b=D6BrKjjOgvtRxAtgGNFEllO89/EGw71TYghBDIdVIKh9wXjJwUzN1YiyGoxG78UZmm
         8GTxvXS4IeuiIbbSSdIZimULT3xtoP0LTKF4Lrg6gi5pH2qOcF5SsVp88In19vvjjgJc
         i8noXHQRAVnun9aHMlcomj5CD+RMK+fl453OxGT2X8ylHH/QVga+rmJ58avrjIqGDLly
         cHpK89a5PHK4naj+yiAADQnMm/mRUa2ltBDASSzUyzu4sLCVvLaQY2AMgyXtX6qqfxOV
         Q2wwvorzB86we8SyA6de5ffperpM3M0a+LyVedeqmw7xOekavmPNdxngV20x4WEyctOb
         ViiA==
X-Forwarded-Encrypted: i=1; AJvYcCVl3wHslg5aGpmxAEU6kMPO1ls/v4unjD4eWWMe0zrl7SMA3RjjLCopKW/kVSiBvMe6x+O+4EBIQ394B3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJpeEGVyG99ECiSKLS33hrwLh2TfTM9XvUTRew++k2R5ER7wn
	k41TTUW1XZ0BrjXokZUE/+hhUQEBrrPjUEU1jbR51kpRBX6Sgc7al+Q6WuGuKLa7vA4=
X-Gm-Gg: ASbGncva2F/B2pHBjtedT6njnTFLHujmWzSvMwSE0bQprzZpt90yaWXF5BCH+NK2P3T
	wsF4uRZNqsmfIIP9uZcJn8eBQjPas+FjLaJAA201xo4BcYyxtYBXo+KV8ODHJOfTVtCkpyyLMDg
	BnLjLlMwuhz2FFBi70zyDzciiz8NYbftpyuZWdibsCIGSHzoabVi1ap1suyN9+GP1Drl20JJeaF
	d8MzG5mEWtyCZiP0hfZDRefMWGak98prz1SfFXNUdA/iUldGtvNXR+tEUAsgd4/ZORoQGmK9pjy
	BDquiT/0RvBL8mtTvenzBZ25q1ScGIbyXJwaaTX9+BqT/sQBsohrFYM/R68RHxe57Gw0Broupsv
	DP4zSnn7lmxCRwmJmgcLL+36+hb1eN6pXj6g998n9BEky67WWkEDZM8Nex33GqCOKS4kZALw0FQ
	8r0yWQPaTCOeYl
X-Google-Smtp-Source: AGHT+IGDC3NDQYPTkkfUUoVyM/sJxUdHO2Lpp1MzeugUZlOM8vLQhbQSiv+7msu1x/Jy2tsYDRamhg==
X-Received: by 2002:a17:906:c103:b0:b6d:50f7:a805 with SMTP id a640c23a62f3a-b7265607354mr700966366b.59.1762434612174;
        Thu, 06 Nov 2025 05:10:12 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896848a5sm207325966b.57.2025.11.06.05.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:10:11 -0800 (PST)
Date: Thu, 6 Nov 2025 16:10:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Dmitry Baryshkov <lumag@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: drivers/gpu/drm/msm/msm_kms.c:251 msm_drm_kms_uninit() warn:
 variable dereferenced before check 'kms' (see line 235)
Message-ID: <9412d8fc-7bb8-456f-9911-8443303497a5@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc77806cf3b4788d328fddf245e86c5b529f31a2
commit: a409b78fcdf724422fa030bd5ef177ebf3b7608a drm/msm: move wq handling to KMS code
config: powerpc64-randconfig-r073-20251106 (https://download.01.org/0day-ci/archive/20251106/202511061924.Y0EaYmPu-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511061924.Y0EaYmPu-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/msm/msm_kms.c:251 msm_drm_kms_uninit() warn: variable dereferenced before check 'kms' (see line 235)

vim +/kms +251 drivers/gpu/drm/msm/msm_kms.c

506efcba31296e Dmitry Baryshkov 2023-10-09  220  void msm_drm_kms_uninit(struct device *dev)
506efcba31296e Dmitry Baryshkov 2023-10-09  221  {
506efcba31296e Dmitry Baryshkov 2023-10-09  222  	struct platform_device *pdev = to_platform_device(dev);
506efcba31296e Dmitry Baryshkov 2023-10-09  223  	struct msm_drm_private *priv = platform_get_drvdata(pdev);
506efcba31296e Dmitry Baryshkov 2023-10-09  224  	struct drm_device *ddev = priv->dev;
506efcba31296e Dmitry Baryshkov 2023-10-09  225  	struct msm_kms *kms = priv->kms;
506efcba31296e Dmitry Baryshkov 2023-10-09  226  	int i;
506efcba31296e Dmitry Baryshkov 2023-10-09  227  
506efcba31296e Dmitry Baryshkov 2023-10-09  228  	BUG_ON(!kms);
506efcba31296e Dmitry Baryshkov 2023-10-09  229  
a409b78fcdf724 Dmitry Baryshkov 2025-07-05  230  	/* We must cancel and cleanup any pending vblank enable/disable
a409b78fcdf724 Dmitry Baryshkov 2025-07-05  231  	 * work before msm_irq_uninstall() to avoid work re-enabling an
a409b78fcdf724 Dmitry Baryshkov 2025-07-05  232  	 * irq after uninstall has disabled it.
a409b78fcdf724 Dmitry Baryshkov 2025-07-05  233  	 */
a409b78fcdf724 Dmitry Baryshkov 2025-07-05  234  
a409b78fcdf724 Dmitry Baryshkov 2025-07-05 @235  	flush_workqueue(kms->wq);
                                                                        ^^^^^^^
Dereferenced

a409b78fcdf724 Dmitry Baryshkov 2025-07-05  236  
506efcba31296e Dmitry Baryshkov 2023-10-09  237  	/* clean up event worker threads */
506efcba31296e Dmitry Baryshkov 2023-10-09  238  	for (i = 0; i < priv->num_crtcs; i++) {
506efcba31296e Dmitry Baryshkov 2023-10-09  239  		if (priv->event_thread[i].worker)
506efcba31296e Dmitry Baryshkov 2023-10-09  240  			kthread_destroy_worker(priv->event_thread[i].worker);
506efcba31296e Dmitry Baryshkov 2023-10-09  241  	}
506efcba31296e Dmitry Baryshkov 2023-10-09  242  
506efcba31296e Dmitry Baryshkov 2023-10-09  243  	drm_kms_helper_poll_fini(ddev);
506efcba31296e Dmitry Baryshkov 2023-10-09  244  
506efcba31296e Dmitry Baryshkov 2023-10-09  245  	msm_disp_snapshot_destroy(ddev);
506efcba31296e Dmitry Baryshkov 2023-10-09  246  
506efcba31296e Dmitry Baryshkov 2023-10-09  247  	pm_runtime_get_sync(dev);
506efcba31296e Dmitry Baryshkov 2023-10-09  248  	msm_irq_uninstall(ddev);
506efcba31296e Dmitry Baryshkov 2023-10-09  249  	pm_runtime_put_sync(dev);
506efcba31296e Dmitry Baryshkov 2023-10-09  250  
506efcba31296e Dmitry Baryshkov 2023-10-09 @251  	if (kms && kms->funcs)
                                                            ^^^
Checked too late.

506efcba31296e Dmitry Baryshkov 2023-10-09  252  		kms->funcs->destroy(kms);
506efcba31296e Dmitry Baryshkov 2023-10-09  253  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


