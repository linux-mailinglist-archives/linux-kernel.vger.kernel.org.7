Return-Path: <linux-kernel+bounces-730669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31769B047E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690ED17C120
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BEB277CB0;
	Mon, 14 Jul 2025 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti8Dovvk"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379F2777E5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521401; cv=none; b=VtOP2WyNg6E/puyoaIuyfnFd2YVVRWBCScIyg91ZrgXEvWmopHea/iZ1dpGii4RMJNMuv2aBbJ5OMgCLMrWPN2maoCi1iatg3SjohA7MHkYiEbmCFGT2Y1YF6I+PAOZVR+mp3IJ0iRf7LfKiUhXgBtH4IEL1bBcRUSHU4H8wPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521401; c=relaxed/simple;
	bh=jRi6LsgXjfGrStwjvyAYC40sGkRXOQX53qEE8jtC5IY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JuSnezb2kPfnNY0lleRCY4rE+riBuStOhNPuRTwGkeV0+zc2W906pY+r1dm0UeRtf3rifATKmtVqp5tpfDYGYhxnWtWxLShWfaZ2HnwaWWw6Y2bT9kjc1yLC599aQ6v8tyL4jyeVgO46H/n6aho3veIAQfpz7cqge3M1iI+ElEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ti8Dovvk; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2da3c572a0bso4367391fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752521399; x=1753126199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q+m9wicpIeBCH++LBohVYCNSQtrcgHGVb/S1A0eRqg=;
        b=ti8DovvkAVWyrCQIfUHbXSVDBrSWqGWJuhp9ksVpMdEXYvd2X12bIh8VE0+hvrZBCx
         63Sw4FL0NTP3/2bsJ+AnHgW7iEEvwldvVSYo80VLWPN1MkBXMVHSLc8wS+PfhYrPfBZo
         CtjDaeWqgDNW60eAmaksb6Jy6YebuUgCqJ5dXPDzIBVy1UPKPNR1k2QY/E7hF3P0RzrT
         a9EedI76wB0F+B/n9Jav95uoyukBotxjScZEq3xIFzi1aNtUh0Cdm/7rmrWLD4LD6f2G
         V50ThCCb/P6NBcReC8iHhMd5fqmURfmbelyQYSZFLPLktpSZXX+JU4tpa1Xl8rrRruf2
         sd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521399; x=1753126199;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Q+m9wicpIeBCH++LBohVYCNSQtrcgHGVb/S1A0eRqg=;
        b=ZcsY1NnsaLCtqi/ZO+isUT7hEjRrm9HKWm3zBPK5/3/vvW5SsGYxmP2fMx+OGV2T7T
         mwZsdMUgdAnXuPk/4SFLz6Zl1bqdPXcxkoUSPmfNG9i4ZEckbdm4ivXUAFnxJp7Zbykx
         2VOv41CsK7GJgraTnRBGA0wIkg5mj8IzDahyhDs3mHNSFozQQQ6fmf/EMYM2Mpe8yyUD
         ZJm2pBpu2Gn1NDPG/0oxpdLoCUhye62FY1srNq/9bmp9thnmYh/h3f+EtgvAtc248pdg
         cgoWutVKsNa/bhY01ahs24Or5DGcaqTeBqeVAViNwXZ95EKDRAq+6jgs/DJlto5Ju38Q
         XR8A==
X-Forwarded-Encrypted: i=1; AJvYcCUCeewZRfl4CkbeJSOqlfLbvZ8EijuPTlrtW4FNPQrzngSpxgPNVc1NKmrULLq7UripyQRKpUJQMkesMgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYALPqfgpVwCD7jOk1MRiiiUf3iF6hPn5brBGIwW+r3U5IyCE
	HJF3HcpDOKv6SCFzOZe6BDvH00LOfzWNyGcvgLcoPvu1XJeinHNas6Gaos3fgTTPTJg=
X-Gm-Gg: ASbGnctIlbtnFSHahYenZMfLex9EgqEOgmcomX2nE6nMQcRQvWJqswbAl1bPE83ZacR
	1Uo+Fjuo5kIs4cMAP97qP7t7lILlzDZ1BUP3W4bg9KHrlyMGliGGQFNQmhY+EG5XegxRTAT6t2s
	4vUH7+f3hPSDhrlR/x5PCFkOmkwzkpyeUDLZ1tr0gOAKwZ9OEvNqGINAyYd2DMqFvetqYaQn+nM
	x43+AbaEM2wL+SuUszY+iOOgOQLKKFDZ6CI3gC0anlOku6EIg3GmI3niNcuK18ahZmK0/YSWsBh
	OIEwJ4cosy6fxTxK2jkROsm3wApQx66nLib1pZtiPdT8vbw7v+eWXvY57yG0Sb8lG1WczAvDtJ5
	IKjsGHUt91+b5HWJI3v/RphoAHrYdmVF77r/+xkLB
X-Google-Smtp-Source: AGHT+IGcqvFf04VyN5VwO5vDsILubomPqyNpRQlsi0uJ6i+fQzutbyHm2vZrUuvCt3pRKpj82Fk+9g==
X-Received: by 2002:a05:6871:d804:20b0:2ef:eddd:690d with SMTP id 586e51a60fabf-2ff26913aa7mr6688707fac.24.1752521398832;
        Mon, 14 Jul 2025 12:29:58 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff11686ad2sm1991198fac.28.2025.07.14.12.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:29:58 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:29:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, khairul.anuar.romli@altera.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
Message-ID: <2bf9baaa-e66a-40ba-96b3-44b2e5e78550@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli@altera.com>

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/khairul-anuar-romli-altera-com/mtd-spi-nor-core-Prevent-oops-during-driver-removal-with-active-read-or-write-operations/20250709-103107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
patch link:    https://lore.kernel.org/r/e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli%40altera.com
patch subject: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver removal with active read or write operations
config: i386-randconfig-141-20250711 (https://download.01.org/0day-ci/archive/20250711/202507110922.btkgvYrn-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507110922.btkgvYrn-lkp@intel.com/

smatch warnings:
drivers/mtd/spi-nor/core.c:3216 spi_nor_get_device() warn: variable dereferenced before check 'dev' (see line 3213)
drivers/mtd/spi-nor/core.c:3216 spi_nor_get_device() warn: variable dereferenced before check 'dev->driver' (see line 3213)

vim +/dev +3216 drivers/mtd/spi-nor/core.c

be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3202  static int spi_nor_get_device(struct mtd_info *mtd)
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3203  {
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3204  	struct mtd_info *master = mtd_get_master(mtd);
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3205  	struct spi_nor *nor = mtd_to_spi_nor(master);
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3206  	struct device *dev;
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3207  
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3208  	if (nor->spimem)
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3209  		dev = nor->spimem->spi->controller->dev.parent;
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3210  	else
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3211  		dev = nor->dev;
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3212  
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01 @3213  	if (!try_module_get(dev->driver->owner))
                                                                                                    ^^^^^^^^^^^^^^^^^^
Dereference

be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3214  		return -ENODEV;
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3215  
240522762fc4bc drivers/mtd/spi-nor/core.c    kromli     2025-07-09 @3216  	if (!dev && !dev->driver && !dev->driver->owner)
                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
These checks are done too late.  Also missing module put.


240522762fc4bc drivers/mtd/spi-nor/core.c    kromli     2025-07-09  3217  		return -EINVAL;
240522762fc4bc drivers/mtd/spi-nor/core.c    kromli     2025-07-09  3218  
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3219  	return 0;
be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3220  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


