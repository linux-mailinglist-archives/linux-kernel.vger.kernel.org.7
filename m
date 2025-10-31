Return-Path: <linux-kernel+bounces-880113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA611C24E86
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A03C94E1F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD976325717;
	Fri, 31 Oct 2025 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1HwQinU"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447230DD2A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912184; cv=none; b=Pj6gyyRcsBYc5LYA76+7eR1j/et3++JIpuArCd9o8LmvMuVmY9N0LrF3QivWDnaAHaXdbuzF6jU0UGC8rKotjzPEYL2kle1V226JtBkT0F/lxrZHRj2SuU5V4MltSodywYGvZgQ9+R0pvoJesNzr2b/c1VM6RLbnp6bwyJDQGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912184; c=relaxed/simple;
	bh=PWXFch9iWj81Y7YHdqTHQ6N0zNVZ/XvzRAsEPDxK8VM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dnolwDoJO666OBiWDfGEtpx47lUWWL/c38LucRIA8UjT4xyzqN/Qd3Ca80Jzmdh1keqD+4dY/HFdpOgP48pzHDQ7juGilnmFWsaJITv4e7UQgK3iL4XC4z9r+Ai3IpppdpSeJayqKkAycIVx8MjOujLCUIpoS+CmaBqqzOZVRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j1HwQinU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47721293fd3so12639585e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761912180; x=1762516980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=058fYBzD0VVjBO/KTYudqsVUdV6ZykNzK8sE3/f02dI=;
        b=j1HwQinUziJVtcI/GB8GViHWmVdPmHZCoPL4ZUGsUF54g/hKmhQcfd2+8HSGFF/jmD
         7e58F/zJOLKppNtqemjw5HCnb4iTBZyA1mJpwhJYPjM27FPj4P0tVD6om328bIjt8o2n
         Sdh35WQ673Z3dgDGBwRG1agEat/Vy22c+c0Ydd0QPf+zadvMt+RfRNHaiLordJ5jyjkL
         X7liOe60iY9DHNODRv65bQwvO/5mvyyhkcfQDzpmAwzHECLpglMQ3KoQa6EA5ByIBBNW
         mvUmvLSZMkojcFjV1jp+pLbs9hGBS8NArR10GdF7hJMRR8MvQnJRKbUMb61RrHrMgKa6
         +0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761912180; x=1762516980;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=058fYBzD0VVjBO/KTYudqsVUdV6ZykNzK8sE3/f02dI=;
        b=wuYs5ZTwnV1CY+uPww+jJQOxbmP29C57M4pZU92hj3Z1Xx2m9N7qWPYXZF3zreKyHo
         vSt3Z+DoFc7hfJN95lq5uwVmWWIxjfYD9t7rnuJ/TQkTxhtUCbndrjGvqwr5WxYtHKeV
         kF10NIUpl12lRRNyNwKm2vGyoINDMJ7vCG+msY+wPx2Ei/dMeKCn4EguWECaY3ItKsgO
         zGwISZCXljoVBgIKL+WDb9IYu18QPQz5UDfSpnY6mdN7urxfWSra6uiOJxXImQ9MkJjP
         zsgrx5oAX5wHXlxIwJMd3CCHLgRARVQ/7GZHFxIvKCnfQ8iCk8DTXruh6HlyxmWF6GqE
         GzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAsoJAAgK6cqj1xONy3IGGX5SZWfCWsl59lQkUQ4RieNx7BINNBMLahAcOyudN2moq9pz59NgGaFEdf/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLiFc2jclaHUsqrhOPOiksYFzU9JwZqHFGObDl+XcGEii+WOo
	X42b2etOukGs0/wBLN/Yp4OaNO0B5Urr2hnJZ0EbBAFX4Co+5kWbj8rM3SUpV1WIH/c=
X-Gm-Gg: ASbGncsfKTlQvyKbv74CS6OUq1w26xK77snB/ur5o/f+DLZ+swmn2UgcBsUv6UzGGmj
	SBddPRfNc4kbKbD1XDOpHT8bt/BSYNcqnvy92vk+ZbPXiIemvYo6b6ER7GYda4/SoWQ7k/B7abJ
	O8Pq5FqNIEGOXXbdIwCOVCRzp/zzqtGiTh+g/lSophyMw1aEioxtfQjMe/5TOnm6pyVhVDESy8W
	0IDTUzl0ETX4vcFHSkZepsJWmA/ZMcn53zX5UWjftmXhvDYJPkpLIHcQHDPUf1tQkfzPDROpXgO
	BTuzpMpgKzPMaXK8rl8ys+H1IC6sQ1gCxbt85OxVFr2tMzGfkvJoK53hb7ZdgLbVEzvj6qRiWny
	Aw7ugUhqbT/OAM2YUbqYXmpyGbFBKHKVmS6lfaznHsmXqFuQt/+GmIHdIZx7d1fWehwIStRnpu4
	c6AffMHVkzGSUbwHEj
X-Google-Smtp-Source: AGHT+IGiTJcnt0HcZ0d4L1SWtBD0hivewbU8sluORT4uOAu6UpEXdmhrV2CyPnyHPmTG6FA6oJz1Bw==
X-Received: by 2002:a05:600c:8288:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-477300ca65amr36001285e9.8.1761912180000;
        Fri, 31 Oct 2025 05:03:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c13e16f4sm3348435f8f.27.2025.10.31.05.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:02:59 -0700 (PDT)
Date: Fri, 31 Oct 2025 15:02:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: Re: [PATCH 09/14] spi: rzv2h-rspi: add support for variable transfer
 clock
Message-ID: <202510311957.SRNglGAw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028133151.1487327-10-cosmin-gabriel.tanislav.xa@renesas.com>

Hi Cosmin,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cosmin-Tanislav/clk-renesas-r9a09g077-add-SPI-module-clocks/20251028-213853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git renesas-clk
patch link:    https://lore.kernel.org/r/20251028133151.1487327-10-cosmin-gabriel.tanislav.xa%40renesas.com
patch subject: [PATCH 09/14] spi: rzv2h-rspi: add support for variable transfer clock
config: hexagon-randconfig-r071-20251031 (https://download.01.org/0day-ci/archive/20251031/202510311957.SRNglGAw-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510311957.SRNglGAw-lkp@intel.com/

smatch warnings:
drivers/spi/spi-rzv2h-rspi.c:510 rzv2h_rspi_probe() warn: missing unwind goto?

vim +510 drivers/spi/spi-rzv2h-rspi.c

8b61c8919dff08 Fabrizio Castro 2025-07-04  428  static int rzv2h_rspi_probe(struct platform_device *pdev)
8b61c8919dff08 Fabrizio Castro 2025-07-04  429  {
8b61c8919dff08 Fabrizio Castro 2025-07-04  430  	struct spi_controller *controller;
8b61c8919dff08 Fabrizio Castro 2025-07-04  431  	struct device *dev = &pdev->dev;
8b61c8919dff08 Fabrizio Castro 2025-07-04  432  	struct rzv2h_rspi_priv *rspi;
8b61c8919dff08 Fabrizio Castro 2025-07-04  433  	struct clk_bulk_data *clks;
8b61c8919dff08 Fabrizio Castro 2025-07-04  434  	int irq_rx, ret, i;
c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  435  	long tclk_rate;
8b61c8919dff08 Fabrizio Castro 2025-07-04  436  
8b61c8919dff08 Fabrizio Castro 2025-07-04  437  	controller = devm_spi_alloc_host(dev, sizeof(*rspi));
8b61c8919dff08 Fabrizio Castro 2025-07-04  438  	if (!controller)
8b61c8919dff08 Fabrizio Castro 2025-07-04  439  		return -ENOMEM;
8b61c8919dff08 Fabrizio Castro 2025-07-04  440  
8b61c8919dff08 Fabrizio Castro 2025-07-04  441  	rspi = spi_controller_get_devdata(controller);
8b61c8919dff08 Fabrizio Castro 2025-07-04  442  	platform_set_drvdata(pdev, rspi);
8b61c8919dff08 Fabrizio Castro 2025-07-04  443  
8b61c8919dff08 Fabrizio Castro 2025-07-04  444  	rspi->controller = controller;
8b61c8919dff08 Fabrizio Castro 2025-07-04  445  
a1ddc1bd04968e Cosmin Tanislav 2025-10-28  446  	rspi->info = device_get_match_data(dev);
a1ddc1bd04968e Cosmin Tanislav 2025-10-28  447  
8b61c8919dff08 Fabrizio Castro 2025-07-04  448  	rspi->base = devm_platform_ioremap_resource(pdev, 0);
8b61c8919dff08 Fabrizio Castro 2025-07-04  449  	if (IS_ERR(rspi->base))
8b61c8919dff08 Fabrizio Castro 2025-07-04  450  		return PTR_ERR(rspi->base);
8b61c8919dff08 Fabrizio Castro 2025-07-04  451  
8b61c8919dff08 Fabrizio Castro 2025-07-04  452  	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
2cfbd980e14a68 Cosmin Tanislav 2025-10-28  453  	if (ret != rspi->info->num_clks)
8b61c8919dff08 Fabrizio Castro 2025-07-04  454  		return dev_err_probe(dev, ret >= 0 ? -EINVAL : ret,
8b61c8919dff08 Fabrizio Castro 2025-07-04  455  				     "cannot get clocks\n");
2cfbd980e14a68 Cosmin Tanislav 2025-10-28  456  	for (i = 0; i < rspi->info->num_clks; i++) {
2cfbd980e14a68 Cosmin Tanislav 2025-10-28  457  		if (!strcmp(clks[i].id, rspi->info->tclk_name)) {
8b61c8919dff08 Fabrizio Castro 2025-07-04  458  			rspi->tclk = clks[i].clk;
92eb6cc239b9d2 Cosmin Tanislav 2025-10-28  459  		} else if (rspi->info->find_pclk_rate &&
92eb6cc239b9d2 Cosmin Tanislav 2025-10-28  460  			   !strcmp(clks[i].id, "pclk")) {
92eb6cc239b9d2 Cosmin Tanislav 2025-10-28  461  			rspi->pclk = clks[i].clk;
8b61c8919dff08 Fabrizio Castro 2025-07-04  462  		}
8b61c8919dff08 Fabrizio Castro 2025-07-04  463  	}
8b61c8919dff08 Fabrizio Castro 2025-07-04  464  
8b61c8919dff08 Fabrizio Castro 2025-07-04  465  	if (!rspi->tclk)
8b61c8919dff08 Fabrizio Castro 2025-07-04  466  		return dev_err_probe(dev, -EINVAL, "Failed to get tclk\n");
8b61c8919dff08 Fabrizio Castro 2025-07-04  467  
8b61c8919dff08 Fabrizio Castro 2025-07-04  468  	rspi->resets[0].id = "presetn";
8b61c8919dff08 Fabrizio Castro 2025-07-04  469  	rspi->resets[1].id = "tresetn";
c10c8eb75d9db8 Cosmin Tanislav 2025-10-28  470  	ret = devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NUM,
8b61c8919dff08 Fabrizio Castro 2025-07-04  471  							     rspi->resets);
8b61c8919dff08 Fabrizio Castro 2025-07-04  472  	if (ret)
8b61c8919dff08 Fabrizio Castro 2025-07-04  473  		return dev_err_probe(dev, ret, "cannot get resets\n");
8b61c8919dff08 Fabrizio Castro 2025-07-04  474  
8b61c8919dff08 Fabrizio Castro 2025-07-04  475  	irq_rx = platform_get_irq_byname(pdev, "rx");
8b61c8919dff08 Fabrizio Castro 2025-07-04  476  	if (irq_rx < 0)
8b61c8919dff08 Fabrizio Castro 2025-07-04  477  		return dev_err_probe(dev, irq_rx, "cannot get IRQ 'rx'\n");
8b61c8919dff08 Fabrizio Castro 2025-07-04  478  
8b61c8919dff08 Fabrizio Castro 2025-07-04  479  	ret = reset_control_bulk_deassert(RSPI_RESET_NUM, rspi->resets);

deasserted here.

8b61c8919dff08 Fabrizio Castro 2025-07-04  480  	if (ret)
8b61c8919dff08 Fabrizio Castro 2025-07-04  481  		return dev_err_probe(dev, ret, "failed to deassert resets\n");
8b61c8919dff08 Fabrizio Castro 2025-07-04  482  
8b61c8919dff08 Fabrizio Castro 2025-07-04  483  	init_waitqueue_head(&rspi->wait);
8b61c8919dff08 Fabrizio Castro 2025-07-04  484  
8b61c8919dff08 Fabrizio Castro 2025-07-04  485  	ret = devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
8b61c8919dff08 Fabrizio Castro 2025-07-04  486  			       dev_name(dev), rspi);
8b61c8919dff08 Fabrizio Castro 2025-07-04  487  	if (ret) {
8b61c8919dff08 Fabrizio Castro 2025-07-04  488  		dev_err(dev, "cannot request `rx` IRQ\n");
8b61c8919dff08 Fabrizio Castro 2025-07-04  489  		goto quit_resets;
8b61c8919dff08 Fabrizio Castro 2025-07-04  490  	}
8b61c8919dff08 Fabrizio Castro 2025-07-04  491  
8b61c8919dff08 Fabrizio Castro 2025-07-04  492  	controller->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
8b61c8919dff08 Fabrizio Castro 2025-07-04  493  				SPI_LSB_FIRST;
8b61c8919dff08 Fabrizio Castro 2025-07-04  494  	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
8b61c8919dff08 Fabrizio Castro 2025-07-04  495  	controller->prepare_message = rzv2h_rspi_prepare_message;
8b61c8919dff08 Fabrizio Castro 2025-07-04  496  	controller->unprepare_message = rzv2h_rspi_unprepare_message;
8b61c8919dff08 Fabrizio Castro 2025-07-04  497  	controller->num_chipselect = 4;
8b61c8919dff08 Fabrizio Castro 2025-07-04  498  	controller->transfer_one = rzv2h_rspi_transfer_one;
c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  499  
c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  500  	tclk_rate = clk_round_rate(rspi->tclk, 0);
c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  501  	if (tclk_rate < 0)
c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  502  		return tclk_rate;

goto quit_resets;

c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  503  
8b61c8919dff08 Fabrizio Castro 2025-07-04  504  	controller->min_speed_hz = rzv2h_rspi_calc_bitrate(tclk_rate,
8b61c8919dff08 Fabrizio Castro 2025-07-04  505  							   RSPI_SPBR_SPR_MAX,
8b61c8919dff08 Fabrizio Castro 2025-07-04  506  							   RSPI_SPCMD_BRDV_MAX);
c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  507  
c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  508  	tclk_rate = clk_round_rate(rspi->tclk, ULONG_MAX);
c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  509  	if (tclk_rate < 0)
c4e1a7fda7e52d Cosmin Tanislav 2025-10-28 @510  		return tclk_rate;

goto quit_resets;

c4e1a7fda7e52d Cosmin Tanislav 2025-10-28  511  
8b61c8919dff08 Fabrizio Castro 2025-07-04  512  	controller->max_speed_hz = rzv2h_rspi_calc_bitrate(tclk_rate,
8b61c8919dff08 Fabrizio Castro 2025-07-04  513  							   RSPI_SPBR_SPR_MIN,
8b61c8919dff08 Fabrizio Castro 2025-07-04  514  							   RSPI_SPCMD_BRDV_MIN);
8b61c8919dff08 Fabrizio Castro 2025-07-04  515  
8b61c8919dff08 Fabrizio Castro 2025-07-04  516  	device_set_node(&controller->dev, dev_fwnode(dev));
8b61c8919dff08 Fabrizio Castro 2025-07-04  517  
8b61c8919dff08 Fabrizio Castro 2025-07-04  518  	ret = spi_register_controller(controller);
8b61c8919dff08 Fabrizio Castro 2025-07-04  519  	if (ret) {
8b61c8919dff08 Fabrizio Castro 2025-07-04  520  		dev_err(dev, "register controller failed\n");
8b61c8919dff08 Fabrizio Castro 2025-07-04  521  		goto quit_resets;
8b61c8919dff08 Fabrizio Castro 2025-07-04  522  	}
8b61c8919dff08 Fabrizio Castro 2025-07-04  523  
8b61c8919dff08 Fabrizio Castro 2025-07-04  524  	return 0;
8b61c8919dff08 Fabrizio Castro 2025-07-04  525  
8b61c8919dff08 Fabrizio Castro 2025-07-04  526  quit_resets:
8b61c8919dff08 Fabrizio Castro 2025-07-04  527  	reset_control_bulk_assert(RSPI_RESET_NUM, rspi->resets);
8b61c8919dff08 Fabrizio Castro 2025-07-04  528  
8b61c8919dff08 Fabrizio Castro 2025-07-04  529  	return ret;
8b61c8919dff08 Fabrizio Castro 2025-07-04  530  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


