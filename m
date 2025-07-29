Return-Path: <linux-kernel+bounces-748866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F33B146EF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D484E396F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DD22154B;
	Tue, 29 Jul 2025 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EeUtus7E"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA6DDAD;
	Tue, 29 Jul 2025 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753760360; cv=none; b=HvMiC7vvVt5u2FQHE+Md0rhe8BVB0irIo2z4VTqC1A2fWNtKopDTnru2H0gLX1S0oQoCn8jd8h5c09xZVY21CgNiZ5OPA3nFl+wQd5r1B3ZeOxalsQg5TamiQM3ELnHR1OYXUa7oCryKu4Gow0AqQ7CemIzlcH/XmDWHKgEPYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753760360; c=relaxed/simple;
	bh=+fRZzJ1pu67g9KHLNxQ3jpr84tD0RNMl/F+xLKkO6oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZRTjJJUWttNenf3RG12/CtNtYpWSSo25OvO9uzq3DtkfHkkxPN2LK9psuveYBHbNh/i2dY8JjgtZcm2dsAOIyv/JNmyAezOkM168a+grqq7mpJBmx0BZfGW/UDe85dE2kULKaRr34nX90Pz2l2Ps5s1oyT3zCb8fO6YXMLv3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EeUtus7E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=t/XS/3PTCMm0S3QcbaBTHk9W6SFZ4M0isoxxK1P40rA=; b=EeUtus7EGzqjVhpchsIz5g/lVn
	hSDLcMZq2mUG5bd2T8NU7Hc7HoguICNtiqLEdjNncZ/39JqzWst5IM/VpbC7Tm+mXsBMmYTw3a0MM
	uqhI16JQVuEpO3FrEFQVozugNc6FulORAy4MwjVr9oMcBZLPLbrnq/8eJK/pQU4Xb0JM9TWvBpqs6
	2sQq0aZBMQaMWqX3S+qAdxwt/tNiZuKB1m7E1uWMmcad425qJoOQunlETXb59v2qAXqAA9+AE6D7Y
	WTnaS3hVtGesd3b+I1Rj2P0dsnnyt7GBmSgBfMFLU3cHpZBmP+TXX95RNWPdqhcKeUgn7TqRbvEL0
	UR1QHcQA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugbBM-0000000Fr49-3FRo;
	Tue, 29 Jul 2025 03:39:16 +0000
Message-ID: <cbe025e7-a769-4132-98c4-167d95c95139@infradead.org>
Date: Mon, 28 Jul 2025 20:39:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
To: kernel test robot <lkp@intel.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Alok Tiwari <alok.a.tiwari@oracle.com>,
 David Box <david.e.box@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250726204041.516440-2-derekjohn.clark@gmail.com>
 <202507290022.MIp5QCIp-lkp@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202507290022.MIp5QCIp-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/25 9:31 AM, kernel test robot wrote:
> Hi Derek,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on groeck-staging/hwmon-next]
> [also build test ERROR on linus/master v6.16 next-20250728]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-ayn-ec-Add-PWM-Fan-HWMON-Interface/20250727-044332
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
> patch link:    https://lore.kernel.org/r/20250726204041.516440-2-derekjohn.clark%40gmail.com
> patch subject: [PATCH v3 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
> config: i386-randconfig-004-20250728 (https://download.01.org/0day-ci/archive/20250729/202507290022.MIp5QCIp-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290022.MIp5QCIp-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507290022.MIp5QCIp-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "ec_read" [drivers/platform/x86/ayn-ec.ko] undefined!
>>> ERROR: modpost: "ec_write" [drivers/platform/x86/ayn-ec.ko] undefined!
> 

	depends on ACPI_EC
instead of
	depends on ACPI


-- 
~Randy


