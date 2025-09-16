Return-Path: <linux-kernel+bounces-818191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B059B58E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BAD3BD74B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC9D2BE051;
	Tue, 16 Sep 2025 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bs8qj7Q+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95AA25332E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001592; cv=none; b=CJKr9SQYGnLNZpJEdH/LmPNnNFP5dUZO2Hr7Kngeg12qZzCR5C/EZ0ntWU8wRdDS6MqoCbORdIexaqKDUHAFSsBB4evbWIqGi0tqeYRx+GNCMhMsXNd6hpxbweAlZbzvcWUj0YgKajJM7UvwxVbejX3aDB7sRrkemkCnWz/5JN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001592; c=relaxed/simple;
	bh=FywVTW+NkJBScWUwmd15Woqfq8DE1jZ960vJHnXScr0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ilQh+twk+3VN50R5fGzDDdM0A4lfBVf7wXOrQ2L/7RLHefFPDlQiK+FF2GCpxHdcLK7gwFinTkvnLIM7ABvbQRipwsv+G9YgTs8vWC9eEFnLVM4RyNYZ/ziEoJUUk+S3Gs2wD7A0/oBZ7Omp2sv+/feP8qJb7g+AxFKi7ZH92v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bs8qj7Q+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45de56a042dso32746635e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758001588; x=1758606388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRpDCRaw7BEKyikqEm/KEgdpxjmtpKt/Hv/Bxs3qVwM=;
        b=Bs8qj7Q+iivL2e2nLY45i1BDffFVMDFPVBZTMUk/2MrskVSIoi6rq+FCu83F1Mfqb6
         SyCC6paARPt9rNrfrH1bg9batBbvwPrm6q+AAEOSbqhVa3ra5ihtrWTKKr8Yk+2xF6ML
         inxGlzrrVc6fwNUdgo4N9TsaatkwUqsx0TnuBzsnp94B0qo8PNuukGB4OHyXRghToLeW
         Or+3GeJWUwCbsuSf2oqC4WiJTjQWB/6Ud6lG5D+OJ4lIl6iRA1j2lzxSfFhqeNw+LLU8
         otC2uywdE4wW32bPR9/FZy3tW6SJlIW91enMgCex5VTfsBjr0I6iW84gUj57QeXEo8HW
         gV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001588; x=1758606388;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRpDCRaw7BEKyikqEm/KEgdpxjmtpKt/Hv/Bxs3qVwM=;
        b=Y4Tu/BRNM40829iQOwVdGNYmgLb9ms2jOTs/ty4FPPrZ3eFXpJthjQ2Ii9Y0HAxlVq
         uwtHkhg6LcPQ2hHE5jRY6anFKURr1igufd32JUxUABf5ivz0fhTko7MS/BT64M3jJHiM
         nvpmQD0FRtKyHi80gRkLGov+gESvlY9VFml1vSMrnWnJKBLcshDKIN5j4nkWBixbxJHK
         Jl5NwZPSpqFVg+PLJfwgHDVZkjF9qjNPAgMe5RmtuLiCUHo+kagDKEMl40gkOswzMxv9
         IOf9IGKOi+ARjPpwJtpMcTBDJpN6M9+n7A1ClEH4iNFIYzw63t4g3lsBw6w9CZpqDUhv
         6hjA==
X-Forwarded-Encrypted: i=1; AJvYcCUFInIAm0g1NGroMD3HZvX3NSXxKsUb6ip2L7udkgG99VDyhB6za3iB3K3l6t6oiisC19Wzb0C4k9E17w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQ85uBggQibFf9/edFc2lvWScP93ls4j6hgiGibeMViSfl4+j
	COfBCeEs0W5BTy6+qgdYjk0NCucSwiaLmznwJ1cIyCHr1sNtbylHfp8TI0ex8M+8DQo=
X-Gm-Gg: ASbGncvzIjyWL9YpWozVYukUmk4Z1X0sxCdAWUrYrYMhfx/djIZF4+ix6FTER3kjy9Q
	BVOCLEugHTg9NCD6qrII0Q1EzEYEcXDd63/fLQD6cvzubeZ8mmZkWsEYThH0aF/2siAXbSLGu5O
	fp0R9Nr7eq087MxlhUCs7d+I6z5pXhz3BQMlboBEXlPhA5gFUnw1R0/o35orRQ/D5PIcXj+z7Yr
	bO+zOolhrwnOEPnQA1bv0sxPgqk3qfxqeBg+5/6bDStIEdnW8Xawhg7GyCtaTc7/djrwoegsfDh
	uHPjoUOtGvDrkMsZ5F4G4vNyZKQBK9FR0Gn1kz3y3NQAPIq5VQvjomjXQ2BdOADctMeaglNbAxM
	wNZwn24N5kuog67bPaDcK6HQXxf5IKHijYCPWqg==
X-Google-Smtp-Source: AGHT+IEJMjy+qyIk5xqFocYpNMUmqI1onZLmshq/sOyCOw+IB161XWLjgacwRGHQYXdmBTmZ8cwD6Q==
X-Received: by 2002:a05:600c:58d8:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-45f211f856fmr120265875e9.17.1758001588267;
        Mon, 15 Sep 2025 22:46:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e95b111b68sm10476481f8f.32.2025.09.15.22.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:46:27 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:46:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, John Ripple <john.ripple@keysight.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
	andrzej.hajda@intel.com, blake.vermeer@keysight.com,
	dianders@chromium.org, dri-devel@lists.freedesktop.org,
	jernej.skrabec@gmail.com, jonas@kwiboo.se,
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
	matt_laubhan@keysight.com, mripard@kernel.org,
	neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re: [PATCH V3] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
Message-ID: <202509161344.FPfsjq01-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910183353.2045339-1-john.ripple@keysight.com>

Hi John,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20250911-023707/John-Ripple/drm-bridge-ti-sn65dsi86-break-probe-dependency-loop/20250820-235209
base:   linus/master
patch link:    https://lore.kernel.org/r/20250910183353.2045339-1-john.ripple%40keysight.com
patch subject: [PATCH V3] drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD
config: x86_64-randconfig-161-20250916 (https://download.01.org/0day-ci/archive/20250916/202509161344.FPfsjq01-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509161344.FPfsjq01-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/bridge/ti-sn65dsi86.c:1385 ti_sn_bridge_interrupt() error: uninitialized symbol 'status'.

vim +/status +1385 drivers/gpu/drm/bridge/ti-sn65dsi86.c

b8670cf7e6a41b John Ripple  2025-09-10  1365  static irqreturn_t ti_sn_bridge_interrupt(int irq, void *private)
b8670cf7e6a41b John Ripple  2025-09-10  1366  {
b8670cf7e6a41b John Ripple  2025-09-10  1367  	struct ti_sn65dsi86 *pdata = private;
b8670cf7e6a41b John Ripple  2025-09-10  1368  	struct drm_device *dev = pdata->bridge.dev;
b8670cf7e6a41b John Ripple  2025-09-10  1369  	u8 status;
b8670cf7e6a41b John Ripple  2025-09-10  1370  	int ret;
b8670cf7e6a41b John Ripple  2025-09-10  1371  	bool hpd_event = false;
b8670cf7e6a41b John Ripple  2025-09-10  1372  
b8670cf7e6a41b John Ripple  2025-09-10  1373  	mutex_lock(&pdata->hpd_mutex);
b8670cf7e6a41b John Ripple  2025-09-10  1374  	if (!pdata->hpd_enabled) {
b8670cf7e6a41b John Ripple  2025-09-10  1375  		mutex_unlock(&pdata->hpd_mutex);
b8670cf7e6a41b John Ripple  2025-09-10  1376  		return IRQ_HANDLED;
b8670cf7e6a41b John Ripple  2025-09-10  1377  	}
b8670cf7e6a41b John Ripple  2025-09-10  1378  
b8670cf7e6a41b John Ripple  2025-09-10  1379  	ret = ti_sn65dsi86_read_u8(pdata, SN_IRQ_STATUS_REG, &status);
b8670cf7e6a41b John Ripple  2025-09-10  1380  	if (ret)
b8670cf7e6a41b John Ripple  2025-09-10  1381  		pr_err("Failed to read IRQ status: %d\n", ret);

status isn't initialized on error.

b8670cf7e6a41b John Ripple  2025-09-10  1382  	else
b8670cf7e6a41b John Ripple  2025-09-10  1383  		hpd_event = status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS);
b8670cf7e6a41b John Ripple  2025-09-10  1384  
b8670cf7e6a41b John Ripple  2025-09-10 @1385  	if (status) {
                                                    ^^^^^^
warning

b8670cf7e6a41b John Ripple  2025-09-10  1386  		drm_dbg(dev, "(SN_IRQ_STATUS_REG = %#x)\n", status);
b8670cf7e6a41b John Ripple  2025-09-10  1387  		ret = regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, status);
b8670cf7e6a41b John Ripple  2025-09-10  1388  		if (ret)
b8670cf7e6a41b John Ripple  2025-09-10  1389  			pr_err("Failed to clear IRQ status: %d\n", ret);
b8670cf7e6a41b John Ripple  2025-09-10  1390  	} else {
b8670cf7e6a41b John Ripple  2025-09-10  1391  		mutex_unlock(&pdata->hpd_mutex);
b8670cf7e6a41b John Ripple  2025-09-10  1392  		return IRQ_NONE;
b8670cf7e6a41b John Ripple  2025-09-10  1393  	}
b8670cf7e6a41b John Ripple  2025-09-10  1394  
b8670cf7e6a41b John Ripple  2025-09-10  1395  	/* Only send the HPD event if we are bound with a device. */
b8670cf7e6a41b John Ripple  2025-09-10  1396  	if (dev && hpd_event)
b8670cf7e6a41b John Ripple  2025-09-10  1397  		drm_kms_helper_hotplug_event(dev);
b8670cf7e6a41b John Ripple  2025-09-10  1398  	mutex_unlock(&pdata->hpd_mutex);
b8670cf7e6a41b John Ripple  2025-09-10  1399  
b8670cf7e6a41b John Ripple  2025-09-10  1400  	return IRQ_HANDLED;
b8670cf7e6a41b John Ripple  2025-09-10  1401  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


