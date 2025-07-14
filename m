Return-Path: <linux-kernel+bounces-730657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0AB047C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA68A1A67B88
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB4277023;
	Mon, 14 Jul 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCrCnwWI"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EF27701E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520109; cv=none; b=GQbMYGCcExyjck8gSimJ8i7oOe4wGPI91mNRe42gzOrKnS4f0A7ZRpARCvmzwSEyOQatINCouPAKbBTHT9iYsWNBxDx0lnDYRv/LlVA9mUnTGQEZdJWowJKB9xPtM5ABxuaq68XflZcfIceHNQY1I9yP3Jmx48+xfqrD3bFOGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520109; c=relaxed/simple;
	bh=VRc50o1TNkXkiKCdb7sYh/BGwOy7+sjpbKW7SRTKiiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NXsOLFYwgU3F4swXLDgLZ0CbSmroyWEuqrShhAsUwe32D+zygrfB58AcHwSrff7SBODasUQQ/TRJmrTPxLTGAvDsmzyv6bKKQmw7qEgHyLCfWQ/wsIKaSJYXLpmZTqJCsuDnFZR7MxrBmD3NxcBYwNLY1YcUdPumsTBkayj4oBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LCrCnwWI; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso3108776fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752520106; x=1753124906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FY8oP8TntW4ytWNHBRG2ykUEsygpkJOVRPFVHGGy1iw=;
        b=LCrCnwWIBTL78Q2Hg9KyuWXNOxsqgoqSLfm/Wy7IPqNc1FixPumgDNLOziNyWcZO6V
         rWAQYgYaiVc9Ffd3e9829lHMzdnSf9neapsXgmg3GvR6IPwHC+wnF/U0mSZ7FrLFjlCx
         TsRX9Prc+ffbpKAIBTizdJ2KroDQZnbZ7i9J0luGrfkAv9PeZnm5dx5tVFUW7bymPkDx
         5DlDGAV6GZIBo1ZHL7y1HxygyknEyWpclkEB2kerzCpXEV5gUp9xehmrXm+b4Gz84hSF
         MlFM9UoVx+5HYKIync+IfP9Gx1+ty9rJ5X4UbQSSEojnFR6g42VuXXbRQbBDKZLtTFl5
         p8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752520106; x=1753124906;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FY8oP8TntW4ytWNHBRG2ykUEsygpkJOVRPFVHGGy1iw=;
        b=uIL0P3NJJtuTDIhTVmnn4IIOlyG7NptSrha+Get31yb2oneqvP+J2fhpk8ffot/DuA
         NZDlspRhgzRC9CXQdLTJsSrKx4MMaPS8wQ0QEBVFkUJ2Jvfu4dnslcCZBeYr3PcbqsfE
         3bml5DaFmu8oZLCbRIm+rsg/SUJF0aUxA6PZKnxtbcU1syby3gD4/C+8zDkcI2t/PRzs
         HoNw2n0GXPtju8By2kshM/k2hkID3eLtNjy3U03g/n9xKSLCcDvkgo+hKkdQ4+L2RgAY
         KuEwC5wNgJn5hkheC2PgunE8pJj6DRBtguDmg2A4qnWPSpgFnV8J0HwXop1sBVhVUodC
         gPow==
X-Forwarded-Encrypted: i=1; AJvYcCUc0EFgpXTkbU5/ds8PWTfYq8A0ZLrW89nylQdyZQHkGbxlcWHY5sT4G/HhMOVysLMFN/xHAE5x2UJ7Nlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7zSaCBELIxyq1gJyrHi7+JQ4bmrsLn7jYYg+A6Tzfbz6+htWc
	5+gqjTFzxxbbkOxo96lS+qh7nqC0xOBlCt3ontj/XMgYwwsHYYvj8cMfxf9x5fzrqFI=
X-Gm-Gg: ASbGncu1qgKWJZXwrLF7/SCqwGFSUCgRRLGq+IYQEj2xOvyq2AdOkkLnaOM9iorra6/
	pOonKlOSxbyK+D+C8hP3kq2JUF4yP5+yYrp2Fgo9j7nYP4yAZgQg2Xqb/q2G6cnyzTY2GjLxFaZ
	Al1gqgRXrRD6ub/BmomYLMrmWlSixu6RL9rMBKo+Hm0tihkUJAIkF0aAb6mjCz8n0nj0U0y8PGW
	wNfUafCOGvev8k3I8dAl2FWXAitEZA5Az7dtHC7Y5g0gulMUQBe9gw6dXAiIqfScGdTAvbclFA5
	EVn6VUkZPFSKsc2zJwSvcAO89ds756HhPhkAiVo8Aq4wvlHA/TEBRseRozAOc2YxRmdiM+zMeG7
	mftCsTPaRcLKco0nCoH7axjdv4eXj5w==
X-Google-Smtp-Source: AGHT+IEzO8bUgBmoo1uzE8f4f/z4iMC9jmOc9/Xzy7X6HZpF2LbcgnghTbE4rOCIVgXQl6Q0I/xJmw==
X-Received: by 2002:a05:6871:5d06:b0:2d5:b914:fe2d with SMTP id 586e51a60fabf-2ff270892c7mr10030939fac.33.1752520106283;
        Mon, 14 Jul 2025 12:08:26 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116dd664sm2036650fac.42.2025.07.14.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:08:25 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:08:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	davem@davemloft.net
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v7 04/15] net: phy: Introduce PHY ports
 representation
Message-ID: <13e48447-37fb-49d8-8c6a-ce5d198506ae@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630143315.250879-5-maxime.chevallier@bootlin.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/dt-bindings-net-Introduce-the-ethernet-connector-description/20250630-224035
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250630143315.250879-5-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next v7 04/15] net: phy: Introduce PHY ports representation
config: x86_64-randconfig-r071-20250706 (https://download.01.org/0day-ci/archive/20250706/202507061812.0aBYBa9l-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507061812.0aBYBa9l-lkp@intel.com/

smatch warnings:
drivers/net/phy/phy_port.c:130 phy_port_get_type() warn: bitwise AND condition is false here

vim +130 drivers/net/phy/phy_port.c

055cbf51317b1e Maxime Chevallier 2025-06-30  122  /**
055cbf51317b1e Maxime Chevallier 2025-06-30  123   * phy_port_get_type() - get the PORT_* attribut for that port.
055cbf51317b1e Maxime Chevallier 2025-06-30  124   * @port: The port we want the information from
055cbf51317b1e Maxime Chevallier 2025-06-30  125   *
055cbf51317b1e Maxime Chevallier 2025-06-30  126   * Returns: A PORT_XXX value.
055cbf51317b1e Maxime Chevallier 2025-06-30  127   */
055cbf51317b1e Maxime Chevallier 2025-06-30  128  int phy_port_get_type(struct phy_port *port)
055cbf51317b1e Maxime Chevallier 2025-06-30  129  {
055cbf51317b1e Maxime Chevallier 2025-06-30 @130  	if (port->mediums & ETHTOOL_LINK_MEDIUM_BASET)
                                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^
I think BIT(ETHTOOL_LINK_MEDIUM_BASET) was intended.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


