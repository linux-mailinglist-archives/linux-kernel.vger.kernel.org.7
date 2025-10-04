Return-Path: <linux-kernel+bounces-842022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADA6BB8CB9
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05A184E1D32
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CF626F28D;
	Sat,  4 Oct 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SH7ibMEc"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8691DA0E1
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759577208; cv=none; b=nETm1bjexymW1M10zC+20/a0Tlz3UyCKgs/vHOBWj0zdmCglDqqgwwz5QtaalSkT8wXcmOFGbz7/Gva7C8JKgLcLu16Xsv+yJpRhUqCXOUj4U5xTosRzvKUPph9Dao80FGch8ZRlP2AhD4lJZPwK6Pf7UPKsFm+pNen/dEVCTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759577208; c=relaxed/simple;
	bh=EwdxHnfhKvEZ7NIeysHGXpupI7BqORS8CfSma73coo8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g4KAyVvDGPT7+hTwghterz0BDnuFosbgNSGrJTOwyNTTVPBxILNO8M1CHBGpNAc5zegRVUoGfysTzkeKEVakhA3CXSLh+fnl9AYMRccHopBuwFxUZOtM/kZP15Gpw2h1RtIy6iep/xDaskYBXejE9Mj/53gVGUSGkkhbkpxh0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SH7ibMEc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so2873842f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759577205; x=1760182005; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DzFK8rYziPUGpkl2sqEnCqePPRcI+6U2kgUcBhHTzw=;
        b=SH7ibMEcPCv5Bytbz7/pk2jpVzpNUKVBSFGBx9KDXUWMG+3G+HmWkH+lZJXT3dSc/b
         IqEYeaXv1yaP25qZFG1eNOAgL0LboouYxxAUllnL9w/toRHFsQcuLRwLKdEuvck2SKUT
         1ptQ2LIZOhQkzEDFAXk2497LbAnXzZ0Nsh654mAbwI19e+CT4stfQIueYdVhg0miik5O
         dl0Kidb14EH8eKbBqkoyYqwXWvp2trVFcJDwQMsSafoIxRdiCCzkGfsKVEP3AwGf5I16
         4OF9FhzwlXJONpCQjHWQG/kUx6paXQgwKqWNhILyxFFKc9MpNTBzKIIM7WYNgeEu/dV9
         OIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759577205; x=1760182005;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DzFK8rYziPUGpkl2sqEnCqePPRcI+6U2kgUcBhHTzw=;
        b=qHc0I3nuZB/is0/J9bAeV6WLlE5oNGPPncuCFKlzynUkGssbFicm2bA/lmt6Fy+Ok2
         ssVcjXBnIBZA+K+ziy/7pV/6NfFuSlioA4q9uNom7PpdqQbRQsaHLf0VX/Dezkxj+d3D
         UB3qe+fhDYDD4KpkddncDRwODcKCBfLYyQh/2JCqMuts7FgVjZs+hTrX5P0TFDYjb3Wn
         K08SvLPmODGcWHTnW4QktplZLjiTywHYY45B0YPEwHjvf8dBBaHO53Hv+VEvhafldzOu
         KK/d6lLaKwtJmWKuV1YIDKuRZQBxmyCmRHre3wDo+0YNZlrrD6pi8KTuQTNIDHUjiE7b
         t7gg==
X-Forwarded-Encrypted: i=1; AJvYcCWLWSDVCn5XF6IkIvzWfwZRelDUuLFuf6Q7RfVleGpSwD529078EFtunupjtHPeAg7lC+T522iDxBt3Dmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT12yllJ+lfabV/lQe8m9y+B6Wwo5e5btEVu6Mwvtj25EvK2Cs
	DQb2ZHtrVajzo9/uEwG7PeweDMKvkYcOv2alMyh1WJo+GdJeApjTPT8gp8IvIPLGqzU=
X-Gm-Gg: ASbGnctZlevhN6Ht+Y14O7spC7psaVHVGYRiS1d1zZhxbewZEuf4UM1BGy/NxqdzKYY
	2f/t61uEZPQMbN4wjCawUyaAdLbYXYaZtMqBcGzTnm0a0zjTNHBhxKmgErY9/7cZMvAJ0Sj+lo6
	4e0vmh+5KkKWDHgFcf2JF8qAv9Y3n+xVIIDqF4+LrALyKtCPe5eb6DwSFl9xtfuuJVl9mKq3/Bf
	HmjEjYKA89hWFpKM7NSM/1WlU5iIEithqshEqW9jaWxuT2fq2U87PAPv7qVpEv938zcDbYidc9g
	YS4b81EP4nkXKuLWeGMn6SS4GzozGol/H+FA3nkorJ87QH1tCemzFO9SPl1ke4c8v82H/2Abwd8
	ZRQRkkZN5mZFDfofvVamrlxezfP2ed+iWlMDQ3fmbX9je65b2e8ji+QKY
X-Google-Smtp-Source: AGHT+IFacHTO+wNvyUaeloL1KpMs5qoUG4HNzAfByt4v809NdPdXJT/60CWPcoxKWKlPtIpF5bc3GQ==
X-Received: by 2002:a05:6000:43d6:20b0:425:6866:6a9e with SMTP id ffacd0b85a97d-425686679fbmr3061385f8f.0.1759577204664;
        Sat, 04 Oct 2025 04:26:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8a6b5csm11924920f8f.5.2025.10.04.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 04:26:44 -0700 (PDT)
Date: Sat, 4 Oct 2025 14:26:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to
 'PTR_ERR'
Message-ID: <202510041841.pRlunIfl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cbf33b8e0b360f667b17106c15d9e2aac77a76a1
commit: 7cd8db0fb0b2bf309163d56fec585c0f9e0964d1 mmc: add COMPILE_TEST to multiple drivers
config: s390-randconfig-r071-20251004 (https://download.01.org/0day-ci/archive/20251004/202510041841.pRlunIfl-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/

smatch warnings:
drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +709 drivers/mmc/host/pxamci.c

^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  690  	/*
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  691  	 * Ensure that the host controller is shut down, and setup
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  692  	 * with our defaults.
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  693  	 */
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  694  	pxamci_stop_clock(host);
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  695  	writel(0, host->base + MMC_SPI);
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  696  	writel(64, host->base + MMC_RESTO);
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  697  	writel(host->imask, host->base + MMC_I_MASK);
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  698  
23f3ff72bc6f05 drivers/mmc/host/pxamci.c Daniel Mack        2018-07-03  699  	ret = devm_request_irq(dev, irq, pxamci_irq, 0,
07e7716c746dd4 drivers/mmc/host/pxamci.c Robert Jarzmik     2016-02-08  700  			       DRIVER_NAME, host);
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  701  	if (ret)
58c40f3faf742c drivers/mmc/host/pxamci.c Binbin Zhou        2025-06-03  702  		return ret;
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  703  
3ae5eaec1d2d9c drivers/mmc/pxamci.c      Russell King       2005-11-09  704  	platform_set_drvdata(pdev, mmc);
^1da177e4c3f41 drivers/mmc/pxamci.c      Linus Torvalds     2005-04-16  705  
e1ebb456ae4cd8 drivers/mmc/host/pxamci.c Peter Ujfalusi     2019-12-17  706  	host->dma_chan_rx = dma_request_chan(dev, "rx");
e1ebb456ae4cd8 drivers/mmc/host/pxamci.c Peter Ujfalusi     2019-12-17  707  	if (IS_ERR(host->dma_chan_rx)) {
e1ebb456ae4cd8 drivers/mmc/host/pxamci.c Peter Ujfalusi     2019-12-17  708  		host->dma_chan_rx = NULL;
                                                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^

58c40f3faf742c drivers/mmc/host/pxamci.c Binbin Zhou        2025-06-03 @709  		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),

PTR_ERR(NULL) is success.

58c40f3faf742c drivers/mmc/host/pxamci.c Binbin Zhou        2025-06-03  710  				     "unable to request rx dma channel\n");
6464b714095119 drivers/mmc/host/pxamci.c Daniel Mack        2015-06-06  711  	}
6464b714095119 drivers/mmc/host/pxamci.c Daniel Mack        2015-06-06  712  
e1ebb456ae4cd8 drivers/mmc/host/pxamci.c Peter Ujfalusi     2019-12-17  713  	host->dma_chan_tx = dma_request_chan(dev, "tx");
e1ebb456ae4cd8 drivers/mmc/host/pxamci.c Peter Ujfalusi     2019-12-17  714  	if (IS_ERR(host->dma_chan_tx)) {
23f3ff72bc6f05 drivers/mmc/host/pxamci.c Daniel Mack        2018-07-03  715  		dev_err(dev, "unable to request tx dma channel\n");

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


