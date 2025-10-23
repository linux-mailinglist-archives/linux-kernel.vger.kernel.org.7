Return-Path: <linux-kernel+bounces-867215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA3C01E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2177D3AB255
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0D032E752;
	Thu, 23 Oct 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjumFBZy"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66F3314A1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230894; cv=none; b=PILN/p782xUkPm8GF8XQ37WkDwg3ObxN1vktpRhFRpIHrSQKV+tBG51MLcZqxxJbdPOOdUCjghkeYh3hnoFE8vPKtuz7+aTBoUGj50duyO3BJkIq39T6jocqIyfVw3aJO8cj1NHCo9Ze/hvNtpfzqGYTALVLGy/OrPAhMZGmlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230894; c=relaxed/simple;
	bh=MgOdUmhxFApDz4sRw7UlK/dEuErVOukFGzY2IjjkGxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=olbjqWJcdtrHUPmStSrlzgths/fLxSlths5c4YfknSNCfX2/Jti9W/LpShQDiGpEKZiLY9cXsDQkEjDSFcouDwpq3WEh8+NxiLAJgnDdKNuI+2BDElnmbO4I6zHSlaAI/GjlxCkJ7EMw8lPtDUUu1ymUKrakiHSuMQzXyO6DyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EjumFBZy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so9257515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761230889; x=1761835689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOu4NGMCUBSkrR2LXCmniFlUsFFrudDXlxk8VUy4Cb0=;
        b=EjumFBZy07vLjQopGqIfS0VTXSaIHQB4XIi+q0zRDye4Br3CaeB5Y3NewkQzHfrO2Q
         udBu6lU/t7hzbmFkIZmaIWs70QOgIMA3bsy7Mx2uAF/zgklrJqtNDZtKcDBUrtXby1YP
         I32M6K2WqEB8SCZ3nJgOZ6Ube5/PB6/djCZb/ARjpOr2wGx8SwlWTzWw0KKLpmzgs0VN
         I2zQ3rYFDyPsKql2wzsi+wYadfUFOdVo9wchaFJG9doB8gNly5gFEkfKdTEz6u9c0MM9
         w2Y5N6UYin2y1f2c5xBjwoQVWVLlsyjQgjbs1AwoVhj6CArQTSPj4+Ww4l/7wYJTzOo2
         1mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230889; x=1761835689;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOu4NGMCUBSkrR2LXCmniFlUsFFrudDXlxk8VUy4Cb0=;
        b=A06gcWCHzQjgqY/9KZTJ3o8drTssbdWaaRFBcZf8VhLt9afCClf4CpX8E37tFxRDU4
         6Scbpf/2ckvinvxyUt18Ep1pB1Qzo18dcoihU1MWuXmO+MCrXjTntGcFhrUKlTcNBuMn
         y4kZqNH9RiOBPb/O/PvmMXrx/iZsDWt7dghzWLhKlmX0TwVS2Aov/TgN7UnjynsQd2dy
         x/QjYN9nH0B79yXKEeRDmRzI04E4VoivgQcO0Fqzs6S/K/kBbK33q4OSsBvpfWyD93lv
         i7qZ/UAcCuPmfHQJioz6KM7JKyPcpDx5w1ScoVwWLCJ6OUsUjBhb+wcNKJLgzgl4glM7
         qtaw==
X-Forwarded-Encrypted: i=1; AJvYcCWasG/ZzmBRCFlAJ7G3+Ok6QZSvR1rHNqce1aXszO+fs7QjYx8Szt4Dn6bwYmpNhocNbnc3PQIry2Bpklk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBvSjFDZ2kcYR6uWR/ojXIQHMUJS3vLX5gkZSBxv6qVIBu/XW6
	ZNJvXJFy6PTfbSBevC5+jo5NX+pI6oTmIzhUe4eXlrnm8jpACGKyXwze2XgtxHKOhro=
X-Gm-Gg: ASbGncvwL9J7PGb8MvnxQmIXZW20c+bugssf+QGYwO3pDy0rxJZfIxlXnP7g2aQFh6Y
	/YgJgy+Gao1aZ7qonL5xMaOs2n25MIwnUO9rH/oYrn0v3AfNb/QQowWv8UmXis1zMwp9IYjAU3G
	Zb3H5n80rKx6HlMK5fhrnpkdGTDLEIcTfhqXTV1h9DPr41NV6oB2lF98AHpVQ0pouc34OO4hYIh
	DVB9ZzL+pTtKDCignVRdQpZZkJcYrUWYWu/V2Cjy7vhqm7Stu2cdfLWjfPuxwwpwwS9VJpWzDZZ
	W2tcupLt+WMAFeU2a+UayAZISA0b2giY6q4nEvnOqqCPdLujuKsgz1VQRJ9yVpWbT7yGeQgaHFy
	f5tAfgtiyHFT/jH4vwwAh45F85tJidiOQFT4dPh04fpoMzK9H2m9vpxI07im1Cmr+BhLLuekGn6
	pAaadaDQ7sV9LngsjH
X-Google-Smtp-Source: AGHT+IHPh2MT5lwbkEnF6WyBRT0yvdgZZWzMZDal2Q67sdKk48DCYJobcUZUTlENYCgL3UDZOXyWQA==
X-Received: by 2002:a05:600c:37c7:b0:46e:477a:16cc with SMTP id 5b1f17b1804b1-47117902f6cmr144699475e9.24.1761230889325;
        Thu, 23 Oct 2025 07:48:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-474949df22csm64839095e9.0.2025.10.23.07.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:48:09 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:48:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jonathan Brophy <professorjonny98@gmail.com>,
	lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Jonathan Brophy <professor_jonny@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 4/4] leds: Add Virtual Color LED Group driver
Message-ID: <202510231653.3V9E5oxE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013120955.227572-5-professorjonny98@gmail.com>

Hi Jonathan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Brophy/dt-bindings-leds-Add-YAML-bindings-for-Virtual-Color-LED-Group-driver/20251013-201353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20251013120955.227572-5-professorjonny98%40gmail.com
patch subject: [PATCH v2 4/4] leds: Add Virtual Color LED Group driver
config: loongarch-randconfig-r072-20251019 (https://download.01.org/0day-ci/archive/20251023/202510231653.3V9E5oxE-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510231653.3V9E5oxE-lkp@intel.com/

smatch warnings:
drivers/leds/rgb/leds-group-virtualcolor.c:239 leds_virtualcolor_init_vled() warn: 'phandle_count' unsigned <= 0

vim +/phandle_count +239 drivers/leds/rgb/leds-group-virtualcolor.c

793ec9b4ba92eea Jonathan Brophy 2025-10-14  218  static int leds_virtualcolor_init_vled(struct device *dev, struct device_node *child,
793ec9b4ba92eea Jonathan Brophy 2025-10-14  219  				       struct virtual_led *vled, struct leds_virtualcolor *vc_data)
793ec9b4ba92eea Jonathan Brophy 2025-10-14  220  {
793ec9b4ba92eea Jonathan Brophy 2025-10-14  221  	struct led_init_data init_data = {};
793ec9b4ba92eea Jonathan Brophy 2025-10-14  222  	u32 blink_interval;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  223  	u32 phandle_count;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  224  	u32 max_brightness;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  225  	int ret;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  226  	int i;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  227  
793ec9b4ba92eea Jonathan Brophy 2025-10-14  228  	ret = of_property_read_u32(child, "priority", &vled->priority);
793ec9b4ba92eea Jonathan Brophy 2025-10-14  229  	if (ret)
793ec9b4ba92eea Jonathan Brophy 2025-10-14  230  		vled->priority = 0;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  231  
793ec9b4ba92eea Jonathan Brophy 2025-10-14  232  	ret = of_property_read_u32(child, "blink", &blink_interval);
793ec9b4ba92eea Jonathan Brophy 2025-10-14  233  	if (!ret) {
793ec9b4ba92eea Jonathan Brophy 2025-10-14  234  		vled->blink_delay_on = blink_interval;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  235  		vled->blink_delay_off = blink_interval;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  236  	}
793ec9b4ba92eea Jonathan Brophy 2025-10-14  237  
793ec9b4ba92eea Jonathan Brophy 2025-10-14  238  	phandle_count = of_property_count_elems_of_size(child, "leds", sizeof(u32));
793ec9b4ba92eea Jonathan Brophy 2025-10-14 @239  	if (phandle_count <= 0) {
                                                            ^^^^^^^^^^^^^^^^^^
u32 can't be < 0.

793ec9b4ba92eea Jonathan Brophy 2025-10-14  240  		dev_err(dev, "No monochromatic LEDs specified for virtual LED %s\n",
793ec9b4ba92eea Jonathan Brophy 2025-10-14  241  			vled->cdev.name);
793ec9b4ba92eea Jonathan Brophy 2025-10-14  242  		return -EINVAL;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  243  	}
793ec9b4ba92eea Jonathan Brophy 2025-10-14  244  
793ec9b4ba92eea Jonathan Brophy 2025-10-14  245  	vled->num_monochromatics = phandle_count;
793ec9b4ba92eea Jonathan Brophy 2025-10-14  246  	vled->monochromatics = devm_kcalloc(dev, vled->num_monochromatics,
793ec9b4ba92eea Jonathan Brophy 2025-10-14  247  					    sizeof(*vled->monochromatics), GFP_KERNEL);
793ec9b4ba92eea Jonathan Brophy 2025-10-14  248  	if (!vled->monochromatics)
793ec9b4ba92eea Jonathan Brophy 2025-10-14  249  		return -ENOMEM;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


