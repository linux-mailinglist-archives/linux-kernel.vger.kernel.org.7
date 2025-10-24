Return-Path: <linux-kernel+bounces-868125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47EFC046C4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CD31A65D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AB726CE37;
	Fri, 24 Oct 2025 05:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Y8PACNRJ"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F30266B6C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285032; cv=none; b=eJ+eXI+DRBn7KTU2FAUCOvOFocd7EFVS5KEwY6JkXd5oGZWBMj1IhYX1uS+ZerINswpb4u9pi2KVAj/QuST1iZvefJ8ZRts6Dv+ouKcWw+DALwguVFxIY1ceVtSXlyE4wFI/iBOmq4fmNL/pEL/ikIIHCuNs9/E5R8NZoYpesbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285032; c=relaxed/simple;
	bh=pvO6cAzDobyHHYElEJvRgb2+nkGqLSVOCoVvMs5K/ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=te3G4Sel8rFfpxwZ/Wpon09AkEfaFPMD9zR0qWPTmXP30zf7M+a95kaoflNM0asOQNxEUmTzzSqe0ML3WliVNpqwBI42Rte72JMKxYEQidyHb8iWbsbbsFESxSrty/q5+CcwrxxfQArZGA2NxYUk3N3NEzyypXn4E6q2CNRVJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Y8PACNRJ; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761284956;
	bh=CKr69NwSch7EejM4+TKS99Z/6JCUgbQXeXZdjI/YeeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Y8PACNRJQOCGAwuoF1Hu/zRaWpYuETNqJMnE9sL+mFQ9NclB35k5Ki7GxmBwzBFWq
	 WKYmKTJYP+aGFLmESdstMgy7r6cdMx5GNr6J9yBJk940tkD6/oN2vW2cyWBfajoHDQ
	 B2fqQZ0D5bZB/dI1t30LVGr1dNS2NjNvhqYrwNvo=
X-QQ-mid: esmtpsz21t1761284950t0b48dc42
X-QQ-Originating-IP: +Z7A6gAdtvFocZptcF+nQb/m/NHxsP2Va8AEQIO4Qaw=
Received: from [192.168.15.210] ( [223.76.134.64])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Oct 2025 13:49:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5066917882460850049
Message-ID: <265B8FE9306198E5+0131c750-3995-4158-84e7-ad73792e6934@uniontech.com>
Date: Fri, 24 Oct 2025 13:49:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/hwmon/gpd-fan.c:231:9: error: implicit declaration of
 function 'outb'
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
References: <202510240817.vt3eQ3qL-lkp@intel.com>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <202510240817.vt3eQ3qL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OKhYnE1LzMsBKXC/ZkCGuN+ag2RhsefVQamYUzmV1S9qmB90MCg9DMWL
	mDwwS5YjesH24XFm0utaPlbczTLgBjLf2hzykABgkBzz944Ct1TUM/a03XxsdznXOcP9ee4
	PlD26jtWx5Lm2SIujqodEuDbY36+MVWG8tSBM4U9PKrhhnxN7NJvxXFMg2+kOekw5mmSu0J
	A5EVBmWbXhi2cpxtLiT2K4MYlmyjsEzgtxIhvyTsWlzbWQdUQvzUecJaZKdJeiqi8UUyWlY
	KscAcCJ5HX5Z5EUgOOhilZVm7uLLd1YF8GtTgxDTBy1jFQtKqi4v3YE4d9yx8HpOUrCGBp4
	KWzk1R+uRuyniXb5WN3EfpTvkoNt82TWUFYqfDtkKkIB62YysG1tiENLJZwA61qeZn2fXsI
	EkRvHlPXhW+dtoMw2wmYhBy1hOmWokiJcJS6kyIUL62cTWyHinqxhnUzmbn0N7vlERuRsRN
	+Qg8V+GbsIgAKbjoRw6zFQ+DNfklurcc8bkZaKtvqbjPMhdvGfEdSHryLfNDv7LrIJbhx+j
	+OhDT2utwFVcuFHVGaFrGu6pHWiuYNlc5/jxvpRtgsDPghqkAWQcUEDwrX4MTa1UY+qbfwi
	QPyhii20uWyW8VCLxQ2U/cdtMmBGMSHS2RSFkdPJcyVHoAgh7do8FJPdD9vE0p1F6eYWJ43
	PBcDTULTMsYz3+Zh9qqy+yyiq7yz9Rny7PThxZhtBSebFMYaEke2tlO7a11ILtTxq528ut7
	7eqRakT2YbHuiKgPEi1nA6uxAKa2DWX1pdoC25uWOz+uKI4oXQPNsnGvzpzQr4St5+KO8IJ
	A7g+y4zeu2nkB6bC4xgprUxYtNpNUgwe+jYjX8I0kvY+m1N81YK23bRccJHV2EkJP7nWiVV
	3LHtMAYCEDEvhNw1pUSGwZZu7mnHc5jWytdnKsppCiozawRW7s0T79risOiCGKQYSYp2qE6
	CKmaT8LXV0wtWt+WRxGGbe8IIPzX8MSz6fqPsV4OvX+MrHKNNqam9PhW4pGTpqN/lCHMo+H
	ReKomqQ9/ssbdbNFjc
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0


> Hi Cryolitia,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   266ee584e55eed108583ab4f45b5de734522502d
> commit: 0ab88e2394392f475b8857ac82c0c987841217f8 hwmon: add GPD devices sensor driver
> date:   6 weeks ago
> config: i386-buildonly-randconfig-002-20251024 (https://download.01.org/0day-ci/archive/20251024/202510240817.vt3eQ3qL-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510240817.vt3eQ3qL-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510240817.vt3eQ3qL-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/hwmon/gpd-fan.c: In function 'gpd_ecram_read':
>>> drivers/hwmon/gpd-fan.c:231:9: error: implicit declaration of function 'outb' [-Wimplicit-function-declaration]
>      231 |         outb(0x2E, addr_port);
>          |         ^~~~
>>> drivers/hwmon/gpd-fan.c:244:16: error: implicit declaration of function 'inb' [-Wimplicit-function-declaration]
>      244 |         *val = inb(data_port);
>          |                ^~~
> 

I don't understand...... I have already added CONFIG_HAS_IOPORT to depends. If this is not enough, what else should I do?

> 
> vim +/outb +231 drivers/hwmon/gpd-fan.c
> 
>    224	
>    225	// Helper functions to handle EC read/write
>    226	static void gpd_ecram_read(u16 offset, u8 *val)
>    227	{
>    228		u16 addr_port = gpd_driver_priv.drvdata->addr_port;
>    229		u16 data_port = gpd_driver_priv.drvdata->data_port;
>    230	
>  > 231		outb(0x2E, addr_port);
>    232		outb(0x11, data_port);
>    233		outb(0x2F, addr_port);
>    234		outb((u8)((offset >> 8) & 0xFF), data_port);
>    235	
>    236		outb(0x2E, addr_port);
>    237		outb(0x10, data_port);
>    238		outb(0x2F, addr_port);
>    239		outb((u8)(offset & 0xFF), data_port);
>    240	
>    241		outb(0x2E, addr_port);
>    242		outb(0x12, data_port);
>    243		outb(0x2F, addr_port);
>  > 244		*val = inb(data_port);
>    245	}
>    246	
> 



