Return-Path: <linux-kernel+bounces-886666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F3C36356
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BC7C4FBB6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D5F32E739;
	Wed,  5 Nov 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2cX7zSI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13932E73E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354759; cv=none; b=famjJ4GC9GeOZDs9KmG2AZZ/q0YU7ahtgQ9lBqUHNzlu70GvpY4fIbPx7DZ3FFjRMoiHIE+cXc9JQ601ZCUXASvCIxqymFsfNoqkT1NGEsqyPaooFK8I1J79+FBFvooxQfDJqe48B/ul66I9NibzbJTCzIFTweXrDl999i9himY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354759; c=relaxed/simple;
	bh=en7TeJlKBrx/C+nM4gOVy8baN0W/O3amap3OUmtB08E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pExw04uHewiH2JechGrj/+MZxpgjiahUde2gWOfReZE7J4Bds0Fg2KMG+NQ5pm0omPGfbKYKr9lFfA7isIBdVSfcQZrq93ANU8RnRM9g/+csp/ZHs5W/aCPa7co06GR5xNpRI2lkkfryvMdYK+50rgOQ1uamLRBuoQhnX8ZmKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2cX7zSI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b70bee93dc4so484062466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762354750; x=1762959550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1Ufgq26KO/UiFTVQ2dwsBFNMe828bkTGONCB7/Nzc8=;
        b=y2cX7zSIQz5TjG0rj42gLg8M/a9GkqTUspz0zk1eyQGukMl4eWcpbOH+fFVOFa7y+2
         jC1E4mBN/6dn8774N66U+UaxPaIpOHjjtMNfKLpXbOjQWdtMHx4lZB56+Y4q+3qZYUWu
         rU6YQAN/Auzgm0xlZzBCOclFm92eWW66voPZcEWaKlrJQ7N8RK47zB/ltEk1bupvIK6A
         VvBNlW/sEfB1pcZWRdcYR32GSnOPuyQq+2h/dFAuKXzeDYV8iOzyU5+8R4V0lGIWs7+g
         mj2mxeXFN88v6leMY/kxgUmnaocf10mr7BCcvlQewBRandKM8SnrbXe7pko1Q1pD4U4W
         M3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354750; x=1762959550;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1Ufgq26KO/UiFTVQ2dwsBFNMe828bkTGONCB7/Nzc8=;
        b=KfG/CiZpCigXUTq4CSRHpufEoH8Rom/+H7vjTn0rxim9bzAp+sqFyTXmXk0/qkVd/O
         7lGxXnkhNgirVzMWqEMncb1mNRMWumKoif1CiE/mY5go6A6uqhcJbB/R0/sNB+sidmBd
         Ip0bjIfkO2NVFvRBbu2YKXNOSahlrYsvv03U1qS5aH6pTb83H+bPhYgCLmP+ztX7Fwr4
         j8zwnYR0e9Ke/kUSb5o3JOxuKja/SVvDdwp3J3yo16e89mtJjsmr/9UxgbAFzZaRGVYE
         75NYcf6BfkEvEEqnxrBShKS4Y6c5sLz4UyXcN+jWpv8+AFdeo7iVPPNqhH2J2C7Y6zFP
         tSgg==
X-Forwarded-Encrypted: i=1; AJvYcCXE1XqbVwe5CKAF/C5UfZ/yPVaGDjto79vW/5IagBFeLyqVhyPYXjmU8ZY8oIhBZkC3v86j302mb2UBSJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCaInygdP1zV6RBpWVHXtPYrrkuKxz76K2vTcUSjQPbH8O/YZ
	cU9jcnHqjGUqL3LS9LF9/XaPmlD8DCcQ2qys6IcssdysWw1TKfcxn6m6lWp2gg2ENWc=
X-Gm-Gg: ASbGnctYEFRkk9Fg+ERXwpx+TwQuOhO9ryQL7fRA80d21P1dcik0YzQHmGVLMGC/19b
	tP2JS2c+jAjR3PLuu7F1M6pyVZHySjjl4rk+ABz+SRYoGvYtJxYC00aFxDKNyWYWyBN5M/6ifnF
	DdBL91VAnuAbpM/teREXB34IlDKjwXTONsphi6FatoV7/DZGOTnNVyrvPQ9ciYm0SrV7JqComjf
	1oEG1BryHMpf0wrqpIx2xJ7FmHCimRgb5ZKofYDfMYe0fjnw02EJ4R8swWKRvnsb9tWtndhwNXC
	MF5W8rYs1FE/Hd1ZMymgWvaZa91Qw0NTty5KT/vmhLNwbEm8ANm7EePwfZyaRwRftRnrx+aQCd0
	hWD6Cs7YTwXbbO5uZqCdOu7UGSE+QKFT20zkzrF3BeyIB7YYeWdVyPxiiu8mg7jNz1cYVj8oEQ2
	/V/GdxCtgRPThs
X-Google-Smtp-Source: AGHT+IGEbVOfoRG0NwUxUVx0a5u94ZVJ5b6JB4ndJ053yQljV9xOuZD9inglS4LiJinn4sWEM84qBw==
X-Received: by 2002:a17:906:6a1a:b0:b6d:55ee:506d with SMTP id a640c23a62f3a-b72656bf24bmr350804766b.65.1762354750093;
        Wed, 05 Nov 2025 06:59:10 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72676121b1sm207002366b.75.2025.11.05.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:59:09 -0800 (PST)
Date: Wed, 5 Nov 2025 17:59:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH v6] memory: tegra210: Support interconnect framework
Message-ID: <246ce503-015e-4c2a-b979-24086df2646c@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-t210-actmon-p2-v6-1-1c4bd227d676@gmail.com>

Hi Aaron,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Kling-via-B4-Relay/memory-tegra210-Support-interconnect-framework/20251028-015017
base:   211ddde0823f1442e4ad052a2f30f050145ccada
patch link:    https://lore.kernel.org/r/20251027-t210-actmon-p2-v6-1-1c4bd227d676%40gmail.com
patch subject: [PATCH v6] memory: tegra210: Support interconnect framework
config: arm-randconfig-r071-20251102 (https://download.01.org/0day-ci/archive/20251103/202511030812.rbcbrDyU-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511030812.rbcbrDyU-lkp@intel.com/

New smatch warnings:
drivers/memory/tegra/tegra210-emc-core.c:1984 tegra210_emc_opp_table_init() warn: passing zero to 'dev_err_probe'
drivers/memory/tegra/tegra210-emc-core.c:1985 tegra210_emc_opp_table_init() warn: missing error code 'err'

Old smatch warnings:
drivers/memory/tegra/tegra210-emc-core.c:1989 tegra210_emc_opp_table_init() warn: passing zero to 'dev_err_probe'
drivers/memory/tegra/tegra210-emc-core.c:1997 tegra210_emc_opp_table_init() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +1984 drivers/memory/tegra/tegra210-emc-core.c

7b344327c279ff Aaron Kling 2025-10-27  1958  static int tegra210_emc_opp_table_init(struct tegra210_emc *emc)
7b344327c279ff Aaron Kling 2025-10-27  1959  {
7b344327c279ff Aaron Kling 2025-10-27  1960  	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
7b344327c279ff Aaron Kling 2025-10-27  1961  	struct dev_pm_opp *opp;
7b344327c279ff Aaron Kling 2025-10-27  1962  	unsigned long rate;
7b344327c279ff Aaron Kling 2025-10-27  1963  	int opp_token, err, max_opps, i;
7b344327c279ff Aaron Kling 2025-10-27  1964  
7b344327c279ff Aaron Kling 2025-10-27  1965  	err = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
7b344327c279ff Aaron Kling 2025-10-27  1966  	if (err < 0)
7b344327c279ff Aaron Kling 2025-10-27  1967  		return dev_err_probe(emc->dev, err, "failed to set OPP supported HW\n");
7b344327c279ff Aaron Kling 2025-10-27  1968  
7b344327c279ff Aaron Kling 2025-10-27  1969  	opp_token = err;
7b344327c279ff Aaron Kling 2025-10-27  1970  
7b344327c279ff Aaron Kling 2025-10-27  1971  	err = dev_pm_opp_of_add_table(emc->dev);
7b344327c279ff Aaron Kling 2025-10-27  1972  	if (err) {
7b344327c279ff Aaron Kling 2025-10-27  1973  		if (err == -ENODEV)
7b344327c279ff Aaron Kling 2025-10-27  1974  			dev_err_probe(emc->dev, err,
7b344327c279ff Aaron Kling 2025-10-27  1975  				      "OPP table not found, please update your device tree\n");
7b344327c279ff Aaron Kling 2025-10-27  1976  		else
7b344327c279ff Aaron Kling 2025-10-27  1977  			dev_err_probe(emc->dev, err, "failed to add OPP table\n");
7b344327c279ff Aaron Kling 2025-10-27  1978  
7b344327c279ff Aaron Kling 2025-10-27  1979  		goto put_hw_table;
7b344327c279ff Aaron Kling 2025-10-27  1980  	}
7b344327c279ff Aaron Kling 2025-10-27  1981  
7b344327c279ff Aaron Kling 2025-10-27  1982  	max_opps = dev_pm_opp_get_opp_count(emc->dev);
7b344327c279ff Aaron Kling 2025-10-27  1983  	if (max_opps <= 0) {
7b344327c279ff Aaron Kling 2025-10-27 @1984  		dev_err_probe(emc->dev, err, "Failed to add OPPs\n");

If max_opps being zero is an error then we need to set the error
then we need to set the error code.  If it's not an error, then
we shouldn't print an error code.

7b344327c279ff Aaron Kling 2025-10-27 @1985  		goto remove_table;
7b344327c279ff Aaron Kling 2025-10-27  1986  	}
7b344327c279ff Aaron Kling 2025-10-27  1987  
7b344327c279ff Aaron Kling 2025-10-27  1988  	if (emc->num_timings != max_opps) {
7b344327c279ff Aaron Kling 2025-10-27  1989  		dev_err_probe(emc->dev, err, "OPP table does not match emc table\n");
7b344327c279ff Aaron Kling 2025-10-27  1990  		goto remove_table;
7b344327c279ff Aaron Kling 2025-10-27  1991  	}
7b344327c279ff Aaron Kling 2025-10-27  1992  
7b344327c279ff Aaron Kling 2025-10-27  1993  	for (i = 0; i < emc->num_timings; i++) {
7b344327c279ff Aaron Kling 2025-10-27  1994  		rate = emc->timings[i].rate * 1000;
7b344327c279ff Aaron Kling 2025-10-27  1995  		opp = dev_pm_opp_find_freq_exact(emc->dev, rate, true);
7b344327c279ff Aaron Kling 2025-10-27  1996  		if (IS_ERR(opp)) {
7b344327c279ff Aaron Kling 2025-10-27  1997  			dev_err_probe(emc->dev, err, "Rate %lu not found in OPP table\n", rate);
7b344327c279ff Aaron Kling 2025-10-27  1998  			goto remove_table;
7b344327c279ff Aaron Kling 2025-10-27  1999  		}
7b344327c279ff Aaron Kling 2025-10-27  2000  
7b344327c279ff Aaron Kling 2025-10-27  2001  		dev_pm_opp_put(opp);
7b344327c279ff Aaron Kling 2025-10-27  2002  	}
7b344327c279ff Aaron Kling 2025-10-27  2003  
7b344327c279ff Aaron Kling 2025-10-27  2004  	dev_info_once(emc->dev, "OPP HW ver. 0x%x, current clock rate %lu MHz\n",
7b344327c279ff Aaron Kling 2025-10-27  2005  		      hw_version, clk_get_rate(emc->clk) / 1000000);
7b344327c279ff Aaron Kling 2025-10-27  2006  
7b344327c279ff Aaron Kling 2025-10-27  2007  	return 0;
7b344327c279ff Aaron Kling 2025-10-27  2008  
7b344327c279ff Aaron Kling 2025-10-27  2009  remove_table:
7b344327c279ff Aaron Kling 2025-10-27  2010  	dev_pm_opp_of_remove_table(emc->dev);
7b344327c279ff Aaron Kling 2025-10-27  2011  put_hw_table:
7b344327c279ff Aaron Kling 2025-10-27  2012  	dev_pm_opp_put_supported_hw(opp_token);
7b344327c279ff Aaron Kling 2025-10-27  2013  
7b344327c279ff Aaron Kling 2025-10-27  2014  	return err;
7b344327c279ff Aaron Kling 2025-10-27  2015  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


