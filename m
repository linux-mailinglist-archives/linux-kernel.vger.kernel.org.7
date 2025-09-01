Return-Path: <linux-kernel+bounces-794454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1160BB3E200
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C699617F4E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBD831DD94;
	Mon,  1 Sep 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ia3UKCUv"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E631CA67
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727261; cv=none; b=UIr77IDa5HFhEdgPXE09eSP0B+xExuAvn/QT6M5aE6/hUO+SGfd/SOtd/E3FFYbp8jhAD/xlitHNvYP2/LzpCKfQ5vx3Fo28QdmBPk9JrIpqtP4AXIVmqJq+HafnavkWj6lxQWcCT+pJYGUxix0UY7a2AkAthzdiYysXu6bgGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727261; c=relaxed/simple;
	bh=wU+YtIjUdHrTJHGH2u24IDhC568tsl9YMJ7XuPW7+Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lv6l3ZF/tUU9U3N1hNRnQuEYvkgT6LuHWwhukfEsAviVaXa53W6geJOGh0it+RtLJ/a+KQHLG8p32I5TkjrdpfgT89CfrbogK7riXejE9RRm+YEdq5z0vBhIMpqZWcYASNRqOpCDzbOIjwMaT80nrAq1x71fDiqhs6v+ph20F9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ia3UKCUv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b87a13242so14214615e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756727257; x=1757332057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzQCI9Zj8RikZvzuhO8bePIhY5c3MO1QFwxFZbxrm1Q=;
        b=ia3UKCUvOMrobZNV0skq3huITz12ts7nKuDfFYFNzVNemgaambr+IywLSB9rcE0p7w
         OQA3oZTjmsmPH6NYaZ+IGgawt4HJsYNIWzlLQa/njwccuTwULqYTC3Xs9P9cm7xNz6cM
         /sNERI+y2ospYl1fI5Rw3KjbvgZlWTENsASjgm7H5DSYSxWgm6/Ch3Z2+82+hwxtKhrk
         f6ZKqv97hOwB57rbWEofL9yvwLPnRdjX22CUKeZYjkn5MIMHioANu7qbK/mRCDb2E+x3
         A+7uyVHR/p0MStV5WIPYiIHulHo0r/3S9afHKOVQa9wj92dnt432cmhIBan9s8ekL32T
         Gmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756727257; x=1757332057;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzQCI9Zj8RikZvzuhO8bePIhY5c3MO1QFwxFZbxrm1Q=;
        b=ack5klgW7OWehBOCL4rhU/gk/1hLumjzVMaUx3+scOcOXfYamDbRAZZx081C4C0KFh
         cihepT3/v3ZM8aXhAFSLKw89trDv646isKZzJuWUjfCxglPqlT2iQ5z+GbGxlEtdc+ZN
         zBVbTyenNa2dGINtrJEV2bi+jV1i4GHBG+MsX6KPOUbMlZlHTzaPot8VZ0HzKnSOILBP
         CK+AhZ03JPjL1Dc6AVYH+5GvkwRQRw3LvqNmm92TvESIMf2pPir7gRPjt0pu9JiDAtKU
         xpR15H/f6eDmwfULgaTaz+OIlECcYdffE+lCbDDqD6/iq2MuGikSrzHL9k/Px8imR4nK
         RXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPduSuTnyRRbU5++WPuvTaupblzRNraGJsbp4IVXo2hDrZQTZw6Kb4BBtxbV0CUykJCUXtKfbaXctFvWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fyTCBUznWBFxF06sxx7977H1uDeF6zo+mNF6zxblCnqz6ump
	d+JCPqaFBKfosLAz/IeYeI5XTZupFRpQ9SfdiXGwARXjyGM5CXroPB4iOLEdHVyRg8o=
X-Gm-Gg: ASbGncuCDTsAzKTxOf/wugxtkW9MUcEYA2m16aKAEpUocbj8H8aq4uLGk9k7aMBKALG
	NR9sLl2imfiy205HBlycWSEDYvYZmR+7aPKAIhFB4QnvuVQb0hh7a2T4sIZhb8bTZLZyQ0v1bbw
	cijLjpFC9FD6TewkFQBzLvTOpNDpMK8wWFujBFBNtYv6a3qzXwWLaxScNIX43SI+3xjncirYCEc
	PyxFUNo4sFNhT38eS9oAbz8f7GqzlRb2OEKxuCjmUn+RR8rpE1vSHWniCKK8DonSchLLx+4chRD
	V7WLH/WtMwloT3zV4KUB4F/Byb9pl2Q+vj7vGkVPkz8lrldfMLaFuwKmD7H2tRebGkOyiNoKYlR
	kkIGFvkAXx1wmsOeHivMvmzt/VTbB1lWkmT1fWw==
X-Google-Smtp-Source: AGHT+IH0O4ZkQ2YHVX46lUYZ8xCc2gxCMjSWxlXrU84lXHEdxwk9FtWekPg/E84Nq3t3E+yY+gv8GQ==
X-Received: by 2002:a05:600c:1385:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-45b855c489fmr56725645e9.36.1756727256836;
        Mon, 01 Sep 2025 04:47:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf33adf170sm15932215f8f.33.2025.09.01.04.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:47:36 -0700 (PDT)
Date: Mon, 1 Sep 2025 14:47:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, broonie@kernel.org,
	Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
	ahaslam@baylibre.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH 15/15] iio: adc: ad4030: Add support for ADAQ4216 and
 ADAQ4224
Message-ID: <202508310754.Y4V0Iq26-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006ac88a667ce0d2c751946b562af83d0f27a44f.1756511030.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/iio-adc-ad4030-Fix-_scale-for-when-oversampling-is-enabled/20250830-084901
base:   91812d3843409c235f336f32f1c37ddc790f1e03
patch link:    https://lore.kernel.org/r/006ac88a667ce0d2c751946b562af83d0f27a44f.1756511030.git.marcelo.schmitt%40analog.com
patch subject: [PATCH 15/15] iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
config: x86_64-randconfig-161-20250831 (https://download.01.org/0day-ci/archive/20250831/202508310754.Y4V0Iq26-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508310754.Y4V0Iq26-lkp@intel.com/

smatch warnings:
drivers/iio/adc/ad4030.c:515 ad4030_set_pga() error: 'scan_type' dereferencing possible ERR_PTR()

vim +/scan_type +515 drivers/iio/adc/ad4030.c

8017880dd8ca3e Marcelo Schmitt 2025-08-29  502  static int ad4030_set_pga(struct iio_dev *indio_dev,
8017880dd8ca3e Marcelo Schmitt 2025-08-29  503  			  struct iio_chan_spec const *chan, int gain_int,
8017880dd8ca3e Marcelo Schmitt 2025-08-29  504  			  int gain_fract)
8017880dd8ca3e Marcelo Schmitt 2025-08-29  505  {
8017880dd8ca3e Marcelo Schmitt 2025-08-29  506  	struct ad4030_state *st = iio_priv(indio_dev);
8017880dd8ca3e Marcelo Schmitt 2025-08-29  507  	const struct iio_scan_type *scan_type;
8017880dd8ca3e Marcelo Schmitt 2025-08-29  508  	unsigned int mag_bits;
8017880dd8ca3e Marcelo Schmitt 2025-08-29  509  	u64 gain_nano, tmp;
8017880dd8ca3e Marcelo Schmitt 2025-08-29  510  
8017880dd8ca3e Marcelo Schmitt 2025-08-29  511  	if (!st->pga_gpios)
8017880dd8ca3e Marcelo Schmitt 2025-08-29  512  		return -EINVAL;
8017880dd8ca3e Marcelo Schmitt 2025-08-29  513  
8017880dd8ca3e Marcelo Schmitt 2025-08-29  514  	scan_type = iio_get_current_scan_type(indio_dev, chan);

	if (IS_ERR(scan_type))
		return PTR_ERR(scan_type);

8017880dd8ca3e Marcelo Schmitt 2025-08-29 @515  	if (scan_type->sign == 's')
8017880dd8ca3e Marcelo Schmitt 2025-08-29  516  		mag_bits = st->chip->precision_bits - 1;
8017880dd8ca3e Marcelo Schmitt 2025-08-29  517  	else
8017880dd8ca3e Marcelo Schmitt 2025-08-29  518  		mag_bits = st->chip->precision_bits;
8017880dd8ca3e Marcelo Schmitt 2025-08-29  519  
8017880dd8ca3e Marcelo Schmitt 2025-08-29  520  	gain_nano = gain_int * NANO + gain_fract;
8017880dd8ca3e Marcelo Schmitt 2025-08-29  521  
8017880dd8ca3e Marcelo Schmitt 2025-08-29  522  	if (!in_range(gain_nano, 0, ADAQ4616_GAIN_MAX_NANO))
8017880dd8ca3e Marcelo Schmitt 2025-08-29  523  		return -EINVAL;
8017880dd8ca3e Marcelo Schmitt 2025-08-29  524  
8017880dd8ca3e Marcelo Schmitt 2025-08-29  525  	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << mag_bits, NANO);
8017880dd8ca3e Marcelo Schmitt 2025-08-29  526  	gain_nano = DIV_ROUND_CLOSEST_ULL(st->vref_uv, tmp);
8017880dd8ca3e Marcelo Schmitt 2025-08-29  527  	st->pga_index = find_closest(gain_nano, ad4030_hw_gains,
8017880dd8ca3e Marcelo Schmitt 2025-08-29  528  				     ARRAY_SIZE(ad4030_hw_gains));
8017880dd8ca3e Marcelo Schmitt 2025-08-29  529  
8017880dd8ca3e Marcelo Schmitt 2025-08-29  530  	return ad4030_set_pga_gain(st);
8017880dd8ca3e Marcelo Schmitt 2025-08-29  531  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


