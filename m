Return-Path: <linux-kernel+bounces-738366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6BB0B791
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1583AA860
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282022256C;
	Sun, 20 Jul 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrWJ1Itq"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBA21E0B7
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753034964; cv=none; b=pKE8lpHNbBw8kTECED4C6gENpxDmhG4+KpMLZM3AM92Ug6mwbc4MQZWh5RFTen62JAs2ZuaWjpnOIuk8dix+Q971KeHaxWe2FuNaQUrCj2FLIQ7ryvGWh4tRCeTyMzvE8+Zg4/JND9MhaHOue1SkulFmpbcYMjV4Sn0Gwbyq9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753034964; c=relaxed/simple;
	bh=UgZW6E0tLXAqWBAe6bcg+nwvBZBAbFq/jebf70i9ZUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e86EZJCdYK1mMqdnA2AFkYtQiB7vIA2E1BgMFfGXU9Wy5xw9du0QLpKbBtBuuQhZpNeG9K+mChmlF0gPkBVYNhsvF1urzINHKZ1libQp8QLg+MAn6QZcx3jxMI9CW/yJ/bqUQidCFiqSjWj63CIftig19VzcBg8XiTlV88ZAKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XrWJ1Itq; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73e82d2ec9eso1388774a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753034962; x=1753639762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3oeyMWOovcd12lQ3ZXa1ZAZl9gHnEtbWVtsJw7zMa0=;
        b=XrWJ1ItqRDAVZXozldppZcJEQbYDZaf4S4Jx6fiwd5aE04VePcCW8bPyDtoqFXzA98
         FbA2YhMEK/ep/Yr8sb34V+F855RJrZwu1UZ58Z/nWpmp6i9gIeTjTSGW/xTo4OlJhN1V
         on8yhKoDzrHvAG+o7E8aEBSoCsOGlWKOFDL5aSZHG/zTEgPhBV2jZv/oykcwta+gdai1
         r20fSu0GZOjZJELB6qgomR3tOnld6GvIGSe4KVggSEDtA/3vORCKlvSJNGQbxkBY/KLI
         ArmPxgnXs5eom/CcnVceTC5i3NRB/3zeBvpYlfno5l9gDUIy+ExNzF91vBSISfV/UdcU
         rQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753034962; x=1753639762;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3oeyMWOovcd12lQ3ZXa1ZAZl9gHnEtbWVtsJw7zMa0=;
        b=v1AWAruDj5KXEbTKrjrvAVEpXwq+aLJCENRavba0JH4ABF9wGpDBL5PmtwZB/AXCIl
         3fyXw3w2/lENlcMOF1iXKQJqJmA8A7qzghsSZ6j4TOnPQZ3qFpz9TXDkhSypLf1zOfCu
         996AEEmJ+t2yPwPKv9ASxObR8fQ85kg86hvjllnTUQ7v9fLGVaJSWKKEYMeKr6Od8jL/
         +4dCkif/Wb29KlWfRLhNIuON0uA2rmO8anmfjvDyDcTzBbxOJt7C5/nrR73arf85sJlR
         qANc8OUKHuPKEQwfclmt+9XOFDVPaqt1CpVRazBXOUJfh+6NUWVo/HdqWjinMCwSI/9Z
         iS8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCGD3Yt2HLUFSuCbrwRrbu+kfsTIEFWhd1ikev+iLJMAme+uCb4wikoOn2xrD7Xxhrzh/Upbo6MXO91DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Cyw0tdTfiK30vX1gNOgTEe3u5lOvcYKLBjWt6itvcj1jrSjW
	SovoSjt944uFklNESvCCtPGRHOmisD3dT7ZU/DJr2M5hW3ZmESwPFgYRkvyx6VGLDG0=
X-Gm-Gg: ASbGncsnBkxjarb0CyEBFVE4GUlEX9VD8nk8A26fvAiVUtaFgcATVV0k9j/2jSp904b
	LHvbXp+PyOQh0+SD3P36B+ZB/yPeUCwEU/rEQIx7bY9ypOHREZHZh4e4KC4ZM9ORHFLxQIu6lm2
	YXEmBcXjCUWcdEYzBqnb9kg+Gjo1yfffgkll1DVKfr8PN0md6jHTGLq8D7EQSvQ7eOLZVTS8fKp
	tDtpLIEP49BTQP0Pkgo4qh5vL4Y9CkiG1M4wnBiVyb5Opi1gK44aRvfplm8ZYR0JWCmeK8/qcIs
	XBtUIddNeeHGC55Pk6L3TRHDuGIuAfloShzD/+7fahL7136jYIY0koF3KeuzfBzWggORhncWie+
	Ax5ZNf1ylNmo=
X-Google-Smtp-Source: AGHT+IHHMh2QyThIYM4S4Cqp/W3F21cycCG2+rVI38EbTeuflkBmq2oUSER3ansMmmQBq36/pIa9XQ==
X-Received: by 2002:a05:6830:6484:b0:73e:9ee1:3d63 with SMTP id 46e09a7af769-73e9ee144b3mr2213384a34.9.1753034962320;
        Sun, 20 Jul 2025 11:09:22 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8a7edab2sm1927659a34.40.2025.07.20.11.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 11:09:21 -0700 (PDT)
Date: Sun, 20 Jul 2025 21:09:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Abid Ali <dev.nuvorolabs@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abid Ali <dev.nuvorolabs@gmail.com>
Subject: Re: [PATCH] net: phy: Fix premature resume by a PHY driver
Message-ID: <47495a5b-a3e5-44da-993d-5a7d3c19bd5c@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-phy_resume-v1-1-9c6b59580bee@gmail.com>

Hi Abid,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Abid-Ali/net-phy-Fix-premature-resume-by-a-PHY-driver/20250718-234858
base:   347e9f5043c89695b01e66b3ed111755afcf1911
patch link:    https://lore.kernel.org/r/20250718-phy_resume-v1-1-9c6b59580bee%40gmail.com
patch subject: [PATCH] net: phy: Fix premature resume by a PHY driver
config: sparc-randconfig-r071-20250719 (https://download.01.org/0day-ci/archive/20250720/202507200229.iOChX4Rp-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507200229.iOChX4Rp-lkp@intel.com/

smatch warnings:
drivers/net/phy/phy_device.c:1852 __phy_resume() error: we previously assumed 'phydrv->resume' could be null (see line 1849)

vim +1852 drivers/net/phy/phy_device.c

9c2c2e62df3fa3 Andrew Lunn           2018-02-27  1842  int __phy_resume(struct phy_device *phydev)
481b5d938b4a60 Sebastian Hesselbarth 2013-12-13  1843  {
0bd199fd9c19aa Russell King (Oracle  2024-02-02  1844) 	const struct phy_driver *phydrv = phydev->drv;
8a8f8281e7e7a8 Heiner Kallweit       2020-03-26  1845  	int ret;
481b5d938b4a60 Sebastian Hesselbarth 2013-12-13  1846  
e6e918d4eb93f4 Heiner Kallweit       2021-01-06  1847  	lockdep_assert_held(&phydev->lock);
f5e64032a799d4 Russell King          2017-12-12  1848  
9421d84b1b3e16 Abid Ali              2025-07-18 @1849  	if (!phydrv || !phydrv->resume && phydev->suspended)
                                                                       ^^^^^^^^^^^^^^^
This checks for if the resume pointer is NULL, but if the resume is
NULL but suspend is also NULL.  I'm surprised that the compiler allows
us to write that comparison without adding parenthesis.  I thought that
it would complain about && having higher precedence.

8a8f8281e7e7a8 Heiner Kallweit       2020-03-26  1850  		return 0;
8a477a6fb6a336 Florian Fainelli      2015-01-26  1851  
8a8f8281e7e7a8 Heiner Kallweit       2020-03-26 @1852  	ret = phydrv->resume(phydev);
                                                              ^^^^^^^^^^^^^^
Then this will crash.

8a8f8281e7e7a8 Heiner Kallweit       2020-03-26  1853  	if (!ret)
8a477a6fb6a336 Florian Fainelli      2015-01-26  1854  		phydev->suspended = false;
8a477a6fb6a336 Florian Fainelli      2015-01-26  1855  
8a477a6fb6a336 Florian Fainelli      2015-01-26  1856  	return ret;
481b5d938b4a60 Sebastian Hesselbarth 2013-12-13  1857  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


