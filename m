Return-Path: <linux-kernel+bounces-864122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51264BF9F61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107B33B040A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E472C21D8;
	Wed, 22 Oct 2025 04:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="SPurPWPG"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31B19DFA2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107988; cv=none; b=tRyOPqBVXPepMZ/qLysFUkh6koCZHUOl5hooN/L6nejMsE72NrXKCW4Hs1O4OQS3uKMMFzr6QID1qNdWzQGRQyYovwJtX8Nvj8Gu5JI95ZTCxKw9lW5FaHUSaDJ5y5+R7Zu9eT2fyTYx1jkNSuGJsTA/zg/mXRxfS7Seg31aEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107988; c=relaxed/simple;
	bh=Vaa8WDqiUIJ0pCd0KwULYla2oJbe1U4MWEx0if5guLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK6/BQYrcfuAZN7r69oAoKd+YxSY2S97BWBwGR/s1+uVuF2a6Mov8JlzoH1bSiwEGot0megW8Fey9awuhwqw3N/bM9YR+5WfIR46I8RDPnT9iyJblbVtkcK9QYuDBJ0hbgpwnn/gDrkFlz5K0gYQQKVbJQoArqn79s6Bu6K4GGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=SPurPWPG; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761107882;
	bh=z3D6oLpRpC3uTJLuNajnamGCVKNxJO388PHfD5+0ZWM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=SPurPWPGk0RtUOk2yMXEJwXdtgahg869pn5+zOQQk81B9TJCwUqZ7PsvPJD2tDyE0
	 zHANUqYljEgiojmDjDgD5GsntIb83bV9mvRhZrKnptn82xeIhrw8sFXQ6Mdbylyga8
	 Zq/zQc5S5YZOV5YcDof/CKinaCYJ618huTgJS+dk=
X-QQ-mid: zesmtpgz5t1761107875tc65f3677
X-QQ-Originating-IP: zdumyoB0a58EQZUjbozu0JEFOJ2+w+6ADKhX/NG8DRQ=
Received: from = ( [14.123.255.147])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Oct 2025 12:37:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8598891312569528437
EX-QQ-RecipientCnt: 8
Date: Wed, 22 Oct 2025 12:37:53 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Alex Elder <elder@riscstar.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Lee Jones <lee@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: remove select I2C_K1
Message-ID: <6DB8C5F20B3FAC2E+aPhfoRXlJtJymlB5@kernel.org>
References: <20251022-p1-kconfig-fix-v1-1-c142d51e1b08@linux.spacemit.com>
 <965a6f1f-37de-4029-ba16-cfd2de7895ed@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965a6f1f-37de-4029-ba16-cfd2de7895ed@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MxRSPV+z0HAoL+RR1zvyJJ8B6cAaVV32hiYxdg+wKFb5tUhs1E/P49S0
	bYt3vMXTh06xtXYdbLBBQ4Oq0hJulFhTMBW+OwvDFJycTredzhlKuC4uYEZK5HCWva0e8Q2
	KmL4kNN0SDolZMlfJelJLjr0QqUbGdi0OYUuJhuaIyoaJR143YJG2FuQrWgoYd2CCH51XfA
	LxeXky2IUoREeGoWgh66n9PvOeTkXfRWcy5373HpRtbwpnFngabDJfYi4ad4Qs0pFoopKtD
	pT8G3c9mW3Ms0a5Z4bCmiXNiwR6Psr1MbsNf/aYac2peW1hxmEOuBvysCncJAhzVtyj3I5l
	CbnIvvIXNootxREB/9Pyka5N8b1a9NRPrzokzvnx6SdOsu42hJeIjCl0ZwvJqbeOcZz/faG
	pjDkw9vXMm48wvTm/wqKFpwT35N0P7G2X6rfcCa0UaA8FdtTDZQ4WhAKbotvyywaACLu6nJ
	0xmvk8mmX6/2C7p9aJlD7+z4j1WYufqy/rtbBgVbS45CFe+cgImvmMywqENjEflsiJbQVOh
	REYJEEadMoPJrF09KZYu8eSUCL+kL0RWsDi7AJk12gcabwHQsTtW805pNqxIYyj1SYjFa2x
	F63/vTCWfNsJrtR6va8SMgmR07bf+AZXStmhKRRGX7IpUxib+iogLbqGLFFzDrFQj2ISQ0g
	QDyXmqOIH4i79sd+yjoFjGBN4fuAqdZlxVh/Vut1Gt+ExXysUMru6J6tLXwkrk+yF50ZP5W
	sOQphClz42QCG3LI2faoCVufGhYamVWd/bAV3FVKShQdsepm71YcaR2inzr8+0JSarStVri
	blu4Mpfna+SiPNCPaThSeOBWBeBvqDy65CcTK9pE5JmSpoycQRi+JlFL+gBFDm4uA3w+xO3
	tx8hV580ZLCdix0Rk00zOOPDvdPiiuTaIc3VSOz89k8Hkam9YjbFJXhoRDUXj1bcGedt+6j
	0+Y4e8ptJRDZUAoGEllltqDoIbxyDZrh1UX85TLtNWRWGSjX3HclQq85kJr4ZdtqiypWyqo
	Z7gciWsvYzB/OQPN+AW0pstK/ssNs+FTESK4kFGaBc/qQvNUTx1+msaOazkxavmhCp28wpi
	Jkvp3IPG7k67sQ7oS+OuNR2KVWx7UXgxhnOA3yONPRgXTvjNk/ZRIeFwkC7Hh5UCCqi6gq5
	VCkcCzKl6DmFamA=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Tue, Oct 21, 2025 at 11:30:37PM -0500, Alex Elder wrote:
> On 10/21/25 8:58 PM, Troy Mitchell wrote:
> > select will force a symbol to a specific value without considering
> > its dependencies. As a result, the i2c-k1 driver will fail to build
> > when OF or COMMON_CLK are disabled.
> 
> Should config I2C_K1 depend on COMMON_CLK then?
Yes, this patch [1] registers the ILCR as a clock.

> 
> But you're right, the selecting config should ensure the
> dependencies of the selected one are satisfied.
And the config REGULATOR_SPACEMIT_P1 select MFD_SPACEMIT_P1(RTC same).
Should we change it to depends on?
> 
> > The reason for removing I2C_K1 instead of adding a depends on condition
> > is to keep the possibility for other SoCs to use this PMIC.
> 
> Acked-by: Alex Elder <elder@riscstar.com>
Thanks.

                - Troy
Link:
https://lore.kernel.org/all/20251017-k1-i2c-ilcr-v4-1-eed4903ecdb9@linux.spacemit.com/ [1]
> 
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202510211523.sSEVqPUQ-lkp@intel.com/
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >   drivers/mfd/Kconfig | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 6cec1858947bf7ab5ee78beb730c95dabcb43a98..ea367c7e97f116d7585411fff5ba6bcd36882524 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1258,7 +1258,6 @@ config MFD_SPACEMIT_P1
> >   	tristate "SpacemiT P1 PMIC"
> >   	depends on ARCH_SPACEMIT || COMPILE_TEST
> >   	depends on I2C
> > -	select I2C_K1
> >   	select MFD_SIMPLE_MFD_I2C
> >   	help
> >   	  This option supports the I2C-based SpacemiT P1 PMIC, which
> > 
> > ---
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > change-id: 20251021-p1-kconfig-fix-6d2b59d03b8f
> > 
> > Best regards,
> 
> 

