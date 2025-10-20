Return-Path: <linux-kernel+bounces-860234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F35BEFA00
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB313189CC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783D2DF71E;
	Mon, 20 Oct 2025 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dr4M8hUh"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A52DECB0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944410; cv=none; b=jxmAPbPE8bqK4OyF2ao7G65dQmRBmROTNi0KqbuChQOgC3IPceOPHknBwRgTSjFf2qey0xe5abitbQJi5tptOUSWpdHY5hP7cC6O0tLhYdpc382k9pa3+cJqn81KT1BoWZopCOE0b1hxjdrXAvFKtyJ6QCPOAykK04uOCPhFsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944410; c=relaxed/simple;
	bh=PeGTn3iFxDHG7Zzquzk+8Eb8iZsO1eg0YMwOWsI8x/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RijNPfjJ/y1Z1irtP9Zls1StBL8+uaYVc0WdZvPPy1pve33J4/guX5jNLsPUQ1jo+0NMlvZ8hleWLhecmtuPeLB5w7tTy4SBAmXG17Bomxg649kF59jL+W3lURfrYs+VjH4jujdXexQ+O1UFNOHOCtzmhgJeZBx+K2G6Zxbfpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dr4M8hUh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso3807647f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760944406; x=1761549206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v29GrQR+ncc3DZUAcuhlbn2tQqEiegD397LZB82cRuo=;
        b=Dr4M8hUhE+/cBGZLTsBkQyyIzNFDW+rmb/Dxy7sgROQE8OhRNw5grubqMfjp+Ex6v/
         Ll6ADkHS2z/2ZvABzPxP7kb4Hm9NRwrPZayLIfFAYRsXkejSVtZl5vmuK1jOi88O/yuI
         4/4sZrjNVOo5KxgCD2Rf3Psqy2KjHYvivDDIFStEF8gzVFXnif/eSTQQMe/lOMq10f2j
         odhRfjzS6LqWs2fD2h/x55gLv80Wp7cjIKzQA0qAXz2bTP/PBaxZCAz5sE7BfITdKCV8
         WxnBhMY0vTgtQmPGav8ySENXn0MGBjvvpIaEBJi83FtymZUEx16IJnBSQ4D2auG9DSlM
         Nm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944406; x=1761549206;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v29GrQR+ncc3DZUAcuhlbn2tQqEiegD397LZB82cRuo=;
        b=MaJfKxfRKjzyHLqIdX9sdx76dO2t5mqf6+aVvuDhIrpXU1lBA4hu9GQdkvJ1DkpstZ
         5wx+9KU6y/zt8FHK5XfE0BGE389NKPxzfA9S+eTEnSRTuxCh+oC/dPYgL/ObhBRAOgp1
         fi9uXIHrtZ7jQGs/Ge5KiRkLMmFPl42i8QWdlBOJTMylpK3ymvMSWww8R4GWGZ/ssnbk
         AkfW18TB7qmtAdWH6UHS6V/Ka2WcZCbCXAf4juZZxsJMZqh42r0FhIkORHy1MyXPwXER
         Zs7KMpz1DjaLPTJA77dfke4J3bNkhCiim9nyimxduiqak8DZ8ujsbA28+R03Zmwgp+mM
         TxXA==
X-Forwarded-Encrypted: i=1; AJvYcCXgnFzVojauCEb2pR9mF7YXruHwjM47K/Rdkzn8/s4ESKtZJDIkDgjtmWVhixmWH8nRoq8s6j85NW+VjwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJjSIa/5MpK24H5xYRqRMi/ZRQt7g70Q5IGuLx/2ivLVQwFhT2
	jAXQRm6htK+NC0JtcRINmXXVcg0r+0J3YnKJmsWMzLmue7Lx4XjfVSRLX4fXe5MjEi8=
X-Gm-Gg: ASbGncuvC+vPFui1T607QKDQfC3qMKS16Ut0bcEpICAITt6kmTx7HTN3oEKfjJ3UcdJ
	6rFqCT+1n+8PfWI6FMnrSfiX87uZnvmqVNhXFpR25TGBguDhxnJouuC1Baby8SJRyntwmemVJNJ
	FbC3kH8OiociMK3AE5SGWSOHGOv1vt1opPn5qO60Pq6MqbnpLZFdWa78BZC6Glr+F9VjkgXqOF7
	nrbbrjFoWbKSdB70K+awd/ZdUk7SOWA2qlr+TOVo9JItgtkDxUFWqHrBed5x2ueaaZYOGnvw+mI
	9ldv+9o5CFGwlqio97ihetJWKgTF5T5/HUDBmk5ddN2rzslHvZ3K/5sOVMv35Ni1vuTJLPsgF1w
	vwwi/eBGLzIiaIZzGZiCoeKbwZuPKiC2NQR3+cEvgvioO5YFeQepfanI1aMnPJTSQRjUCUOxJa0
	fNdqys8eZ87RMJwxkq
X-Google-Smtp-Source: AGHT+IGCWcj+ZeSsBGtAZjJoabbi0svPUJxfv7bQF2wz0Kk+abDltn5J9+7dAFKFJ6moPAKqLR/Rtg==
X-Received: by 2002:a05:6000:25fd:b0:427:587:d9ae with SMTP id ffacd0b85a97d-4270587d9c1mr6413104f8f.9.1760944406004;
        Mon, 20 Oct 2025 00:13:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00b9f71sm13715262f8f.37.2025.10.20.00.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:13:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:13:22 +0300
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
Subject: Re: [PATCH v3 4/4] leds: Add virtualcolor LED group driver
Message-ID: <202510201457.uOrhkKly-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019092331.49531-5-professorjonny98@gmail.com>

Hi Jonathan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Brophy/dt-bindings-Add-virtualcolor-class-dt-bindings-documentation/20251019-172647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20251019092331.49531-5-professorjonny98%40gmail.com
patch subject: [PATCH v3 4/4] leds: Add virtualcolor LED group driver
config: parisc-randconfig-r072-20251020 (https://download.01.org/0day-ci/archive/20251020/202510201457.uOrhkKly-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510201457.uOrhkKly-lkp@intel.com/

smatch warnings:
drivers/leds/rgb/leds-group-virtualcolor.c:303 parse_monochromatic_leds() warn: 'mono_count' unsigned <= 0
drivers/leds/rgb/leds-group-virtualcolor.c:303 parse_monochromatic_leds() warn: error code type promoted to positive: 'mono_count'

vim +/mono_count +303 drivers/leds/rgb/leds-group-virtualcolor.c

bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  296  static int parse_monochromatic_leds(struct device *dev, struct device_node *child,
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  297  				    struct virtual_led *vled)
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  298  {
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  299  	u32 mono_count;

This needs to be an int.

bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  300  	int ret, i;
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  301  
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  302  	mono_count = of_property_count_elems_of_size(child, "leds", sizeof(u32));
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19 @303  	if (mono_count <= 0) {
                                                            ^^^^^^^^^^^^^^^

bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  304  		vled->num_monochromatics = 0;
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  305  		return 0;
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  306  	}
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  307  
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  308  	vled->num_monochromatics = mono_count;
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  309  	vled->monochromatics = devm_kcalloc(dev, vled->num_monochromatics,
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  310  					    sizeof(*vled->monochromatics), GFP_KERNEL);
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  311  	if (!vled->monochromatics)
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  312  		return -ENOMEM;
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  313  
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  314  	for (i = 0; i < vled->num_monochromatics; i++) {
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  315  		struct led_classdev *led_cdev;
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  316  
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  317  		led_cdev = devm_of_led_get(dev, i);
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  318  		if (IS_ERR(led_cdev)) {
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  319  			ret = PTR_ERR(led_cdev);
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  320  			return dev_err_probe(dev, ret,
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  321  					     "Failed to get monochromatic LED %d\n", i);
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  322  		}
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  323  
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  324  		vled->monochromatics[i] = led_cdev;
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  325  	}
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  326  
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  327  	return 0;
bc8d39d8adf81b2 Jonathan Brophy 2025-10-19  328  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


