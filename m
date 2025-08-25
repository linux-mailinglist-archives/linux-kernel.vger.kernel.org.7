Return-Path: <linux-kernel+bounces-784194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5DAB337E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FBB178C22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC027FD5A;
	Mon, 25 Aug 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqRGqxB9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E55296BD0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107326; cv=none; b=rzFET2wCQSBpS2HuoVQ0kRW/yRXh9L/3uMZxgzXTlCKUJx+YRbsDDwaLe9EiGXULIDleg32g6yfKj3iKw0St8OxYB6nMFKgC8ibuOTmrwxltpc6zeVPYaRuVzI3f79Bp8By+ou1+ePyeryBxf8wey8EV+bEFbYdi3W/I9olYS+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107326; c=relaxed/simple;
	bh=MpXpYDmIRJcPM8ARHtXC4DLTjSZC1KnXl1kvzblT2DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hu1CSYDsXE7YwXsrNYuis4tVqTugXniqyl3TvulGdbHXrxwUPcYZP0ztAlc2gYlnRNKFHY89gwsPTSEKSHPrOe6aTxhHx4+z3sdGJ3ElO93R+/UGy0TxA1ibek5QvxeeDBVoqmontjBEhdqcO3XfHl6dwvP3GxoRhqpmN3GNbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqRGqxB9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso20400935e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756107322; x=1756712122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLqDCAEeqZueR/V1nZAa0eICESVjVswaFOTFOoFfvYo=;
        b=LqRGqxB9S0pA5gc77/A5hlrqh6OnDv5q/C2IWSyJR4J2MieDlx/XGzQBnI3jJuTGVq
         x7tWu1fQpzwYg0N+8V0EIMszdg20NpGp0Zl+uuCg4FjH4RtGsIGav/fLk+lpqV9oD3mS
         ihPtDvDtL2mjuFAdxd2N4Pfjw0KHMOvRusZ1Z9pqaN+dpsx3lp0ovN3mgNmVozRbqr6f
         UaTDxM1fWJLjroXSqqRxQMQNOMHRsZNCtdkBiE0nW1jLHCs3v5aIRzj7YRp1IipeD6PF
         mUIdNbElgFWY0AhFW79mHR1J6efDgPRpsAYT+nFt++eqXZg4FktyyFcnEaR14pxsDiYD
         4S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756107322; x=1756712122;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLqDCAEeqZueR/V1nZAa0eICESVjVswaFOTFOoFfvYo=;
        b=HTSsAB3BoIX7VLkC5Xyz4eydhNLBPMGSbzTEXHcVgMhRnfoqcbTXcwHb5tEehMlp39
         uKDnB3oFc30okEgdBiNoiVVzxrpSvQNA3zUBFiTtEMsRLK1ral/PdI0bblhWds5TB59r
         3se0yZT+Yosd8BaiWGF+xmJ2/tCNyTayGWKLJ1O/uUKkAddlkS0uiR5Nyu8Ky+mvNee4
         JVrf426hgqCwHNT3CGMPYcyrA+K+Pja1SgW3W7pxaI5sLWuBeIMEJ1P9Xu0fKV0JM7Mf
         u6GpEQOxiNu1v+t7PTt2c1FobgBTwhRuyN8lNTvHJ2igdzWoKwBejqpsREzNrjNn/4g0
         mE9g==
X-Forwarded-Encrypted: i=1; AJvYcCVdv3Za//kpiKAgXmrx1DK/S+TDAKApg8dzLQnJMwmklD9+owdOTv7vc1AB50XN+bEQriy+9FhbLYxQkAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAl4RuB5P2XtgCC8v2M9LJweCzgvXwZ/lW0IcQm3/Tabaux76
	Eg5U/j9AAvzf6o3PB3kjB1i8kkKreJN2Hc4+Z323lh2+ifWdPDeKAGcSZ2ZK4FpgE6c=
X-Gm-Gg: ASbGncuoYjDuhCc+ius24RRFW5tv7SyWJup81+drbM3TmcMR4gaBfLVObQRtuftWEKH
	9AJwL+FgvpmKRQg/kHR4pv9JKMZzhhWeLJXBOJa/N8Sc/dpm6GDGHYBWx+R4CsQhAQlK1EFpZn5
	XSGSOxHvHtU4vAU+DZMT9HKmDYz6V/jBf2ZeVjTfYFV4gQE7TfzMhpuYFzUJ4b2C8YPKqk6Vp0E
	uzKx3E+KCPJ+C8FN+bTpsQg/SXjSnj1/x7HTvRioTYuMDyqpwp4EnZyEfg9N5MEkyajQCpXGyhV
	TlNez29ubmH6SJWb32NwtZrRixRXVX04hqKp/POdaf0tTJytcMjqUSZwp0I+Cp3o9/gYm4Ui1I4
	5CM435j3jBjGhElGEcLncBGv6dCE=
X-Google-Smtp-Source: AGHT+IErURa0Xlnp2EqAvu9MT0KYK+YicwHUY5MOLIbTG3b7xCaO3SGy7MLRfklR+AK/4jewEFfrgw==
X-Received: by 2002:a05:600c:3155:b0:456:21d2:c6f7 with SMTP id 5b1f17b1804b1-45b517b99ecmr101326305e9.23.1756107321591;
        Mon, 25 Aug 2025 00:35:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b5748e743sm99362065e9.17.2025.08.25.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 00:35:21 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:35:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/stm: ltdc: unify log system
Message-ID: <202508250637.nLxtkS26-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821130356.883553-1-raphael.gallais-pou@foss.st.com>

Hi Raphael,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Raphael-Gallais-Pou/drm-stm-ltdc-unify-log-system/20250821-210930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20250821130356.883553-1-raphael.gallais-pou%40foss.st.com
patch subject: [PATCH] drm/stm: ltdc: unify log system
config: arm-randconfig-r072-20250824 (https://download.01.org/0day-ci/archive/20250825/202508250637.nLxtkS26-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508250637.nLxtkS26-lkp@intel.com/

New smatch warnings:
drivers/gpu/drm/stm/ltdc.c:1150 ltdc_crtc_set_crc_source() warn: variable dereferenced before check 'crtc' (see line 1148)
drivers/gpu/drm/stm/ltdc.c:1174 ltdc_crtc_verify_crc_source() warn: variable dereferenced before check 'crtc' (see line 1172)

vim +/crtc +1150 drivers/gpu/drm/stm/ltdc.c

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1143  static int ltdc_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1144  {
898a9e3f56db98 Raphael Gallais-Pou 2023-05-15  1145  	struct ltdc_device *ldev;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1146  	int ret;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1147  
fa2b2390600532 Raphael Gallais-Pou 2025-08-21 @1148  	drm_dbg_driver(crtc->dev, "\n");
                                                                       ^^^^^^^^^
Dereference.  A lot of the time people would suggest to delete these
types of printks and use ftrace instead.

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1149  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11 @1150  	if (!crtc)
                                                            ^^^^^
Checked too late.

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1151  		return -ENODEV;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1152  
898a9e3f56db98 Raphael Gallais-Pou 2023-05-15  1153  	ldev = crtc_to_ltdc(crtc);
898a9e3f56db98 Raphael Gallais-Pou 2023-05-15  1154  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1155  	if (source && strcmp(source, "auto") == 0) {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1156  		ldev->crc_active = true;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1157  		ret = regmap_set_bits(ldev->regmap, LTDC_GCR, GCR_CRCEN);
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1158  	} else if (!source) {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1159  		ldev->crc_active = false;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1160  		ret = regmap_clear_bits(ldev->regmap, LTDC_GCR, GCR_CRCEN);
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1161  	} else {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1162  		ret = -EINVAL;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1163  	}
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1164  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1165  	ldev->crc_skip_count = 0;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1166  	return ret;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1167  }
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1168  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1169  static int ltdc_crtc_verify_crc_source(struct drm_crtc *crtc,
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1170  				       const char *source, size_t *values_cnt)
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1171  {
fa2b2390600532 Raphael Gallais-Pou 2025-08-21 @1172  	drm_dbg_driver(crtc->dev, "\n");
                                                                        ^^^^^^^^
Dereference

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1173  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11 @1174  	if (!crtc)
                                                            ^^^^^
Too late.

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1175  		return -ENODEV;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1176  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1177  	if (source && strcmp(source, "auto") != 0) {
fa2b2390600532 Raphael Gallais-Pou 2025-08-21  1178  		drm_dbg_driver(crtc->dev, "Unknown CRC source %s for %s\n",
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1179  			       source, crtc->name);
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1180  		return -EINVAL;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1181  	}
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1182  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1183  	*values_cnt = 1;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1184  	return 0;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1185  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


