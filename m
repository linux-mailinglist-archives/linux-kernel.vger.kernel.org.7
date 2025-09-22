Return-Path: <linux-kernel+bounces-826649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23744B8F0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFCE189892A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E64622DA1F;
	Mon, 22 Sep 2025 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7pADz7z"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDC17A2F6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520070; cv=none; b=WDPt+Mw4/g7+PiMw8w9AkaemeiA8dB25DZZjdy3A1j+Ogbz+ObF/ENqi7Gp3TQd9UsKvSOu6ZX9Y7o+LUvFtTqY3e87tXrmrxKVJ10y2W0Sh11jeEd2C8k3D6+rV/7/VjrL+eb6+tF1tXbADGmOmgtqB/FTnEDfj+tC1QuivYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520070; c=relaxed/simple;
	bh=66NXpnJdGMWhtkztKfRacnh5qc3BolZxDdP0TvJRir8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KAMLvqR/7BwHSJWqOydAEYWDjvnVPV8V7Kwubcb3WR7CzZeUX2ewghm68A8i6XghhhCMq5IUMJWIRgJA+jy2Noy3B17LufzVH/GaDL9mKlkDiCsfITP4HNstP+ZObAKR+sYpn5JS0MOGbByMNBAWYChkNdn2k4dOThzUiDRwxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V7pADz7z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f31adf368so27350215e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758520067; x=1759124867; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PgF8X/QknqlL8yTU3Gny95ANJR22ql/Nmd198jD0198=;
        b=V7pADz7zBpVJakyBZ61GlUnytMrLJ3XZzhYlcuR1ymeA/4Q9w015aRtEwUiIfVVJpH
         QZIycmSTvLwOdJmPFcuMG+sx+FP5fC6/gRbPROuWMe6qbl8I0Z3FaASNwDP3SmKEmjkY
         9LrTzJoK5CtD/txt3EBUJs0Ns9LUPLZEpD5suQNI2tUP/yf4N6WMxYg7cOQh9QoRXy1R
         2xMDvhp90zPye+xtnKb1ogBPoSF9dPcxQ4UIEAFFUIAtMaUdSISXKTCsqT3nIMGAm6j6
         yurplSI02RgL6WzGi96DZGoJNw7avwog5l0nBN1xWE4HHXzCee1wjwmgFQiZIu4IfmRc
         LtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758520067; x=1759124867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PgF8X/QknqlL8yTU3Gny95ANJR22ql/Nmd198jD0198=;
        b=mkjTkRU1fdV/9cDkkDwn3fNAa/1pRX+yBZHm6kD2xkbtmQ5mbZjrS+lwecEOVpOhBS
         XTNqZ+HqWywI+/WtnMC3rIxyZniZr7bbpqjsJrh9dglX89mzPUeNKJzoB6thOcvQWCCy
         nbFMSzVTZ3zvR/VCeVFNA+yfp+sTRnk0po2htf/qZoTpy1wj1g338S57MaSpi8ikAI4z
         y2vWex8x2xP4eNfOxjCdresSJWAfCekeUD9JLEgym69vkC5O31qm3xK4tIjrY0oknHYZ
         rAMePQy3YE2Jdkn6TU0RuR13U5Wl2zOpi9oR5WucaPqGNvW1n07xTZmegde7VVHzeHYB
         +oGw==
X-Forwarded-Encrypted: i=1; AJvYcCXOmJF2YbW2n5ktV4KVFWW/bH3jyelfK+i23J0ziRZUc5iNeyeTIw6oC34ULb2BE0q2+0xsN14cpXbbvFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWmtBYR4vliQKvIUbwAEvY9Do3tgy9Tz1K18IrJ+u7qbcZWq5
	k3Em8177Zu3HGUPXrjp7gEUlJp41QuHo7yzXwOsGIhRas36iiK8CUgmY0rw27FfFUZ8=
X-Gm-Gg: ASbGncuzZ5uNruZ0HmToEEEp2ojdtgfTaSI4LTI9nZdrR3NbQrgF+PBuQDmRps1amKb
	vI107rCy8tXtBHQnOtderInFiTECNhF0PoC0EhrvLkY4/miIbBePHloVJ6A/Kuudq8uDE1L4kst
	7l5p1PSlmbg7n86yM+uXb58TuhGhPbJGppCfMWbdkP6Ng3Xyyurj5aZ5z24XZOCaukaDx+Y5DSo
	Sp2oJwCVlCDHv33dLAJnkScpaLOMOv+hT3kWVEwmPyvBIUGIwJdWU4hxyfH1zWiAjjFa1r7/3WA
	Z2eO/mQE0gis6Q520TqWv8vcJddhAt+UfaiEf5lGn2iBk8+f1kUcnq4h6VaPFn2pDApA/A/b6+v
	3tV2LpaVnjDwhsZK4dCqd/C0P6aD+/UOsDUn/BxU=
X-Google-Smtp-Source: AGHT+IGLJaZqA8B6N5lCxrnKQqccvunxcRo/0Al2H98KlFFEySPCueUYtQV4CEaHF676873fabSWPQ==
X-Received: by 2002:a05:600c:1f85:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-467ec45ff4amr92308585e9.36.1758520067060;
        Sun, 21 Sep 2025 22:47:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46d1f3e1b03sm32067045e9.23.2025.09.21.22.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 22:47:46 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:47:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ruben Wauters <rubenru09@aol.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Ruben Wauters <rubenru09@aol.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: gud: replace WARN_ON/WARN_ON_ONCE with drm versions
Message-ID: <202509212215.c8v3RKmL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250914155308.2144-1-rubenru09@aol.com>

Hi Ruben,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ruben-Wauters/drm-gud-replace-WARN_ON-WARN_ON_ONCE-with-drm-versions/20250914-235627
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20250914155308.2144-1-rubenru09%40aol.com
patch subject: [PATCH] drm: gud: replace WARN_ON/WARN_ON_ONCE with drm versions
config: x86_64-randconfig-161-20250921 (https://download.01.org/0day-ci/archive/20250921/202509212215.c8v3RKmL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509212215.c8v3RKmL-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/gud/gud_connector.c:597 gud_connector_fill_properties() warn: passing a valid pointer to 'PTR_ERR'

vim +/PTR_ERR +597 drivers/gpu/drm/gud/gud_connector.c

40e1a70b4aedf2 Noralf Trønnes 2021-03-13  580  int gud_connector_fill_properties(struct drm_connector_state *connector_state,
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  581  				  struct gud_property_req *properties)
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  582  {
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  583  	struct gud_connector *gconn = to_gud_connector(connector_state->connector);
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  584  	unsigned int i;
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  585  
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  586  	for (i = 0; i < gconn->num_properties; i++) {
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  587  		u16 prop = gconn->properties[i];
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  588  		u64 val;
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  589  
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  590  		if (prop == GUD_PROPERTY_BACKLIGHT_BRIGHTNESS) {
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  591  			val = connector_state->tv.brightness;
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  592  		} else {
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  593  			unsigned int *state_val;
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  594  
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  595  			state_val = gud_connector_tv_state_val(prop, &connector_state->tv);
d00e57106c0d0c Ruben Wauters  2025-09-14  596  			if (drm_WARN_ON_ONCE(connector_state->connector->dev, state_val))

You accidentally deleted the IS_ERR() check so now this function is
badly broken.

	if (drm_WARN_ON_ONCE(connector_state->connector->dev, IS_ERR(state_val)))

40e1a70b4aedf2 Noralf Trønnes 2021-03-13 @597  				return PTR_ERR(state_val);
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  598  
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  599  			val = *state_val;
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  600  		}
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  601  
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  602  		properties[i].prop = cpu_to_le16(prop);
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  603  		properties[i].val = cpu_to_le64(val);
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  604  	}
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  605  
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  606  	return gconn->num_properties;
40e1a70b4aedf2 Noralf Trønnes 2021-03-13  607  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


