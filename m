Return-Path: <linux-kernel+bounces-770019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CF3B275E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA02172138
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739462C0F99;
	Fri, 15 Aug 2025 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="HOe0CbO+"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D402C0F8C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224988; cv=none; b=XOe93Pg8U4R8ZzNb9oK0sxuozPsCkhMmvq5qY44wLmM0MeKSUJ/YeIMF9kegLNPYyy0ne6ujkVm5kRwp2GLj2VDpUKtbXvuR8J0sNw/l2b+W3+4hxLQlPt1eVYnChAWvy1vMnPNWqHqKwzbQKeKCdM6YMOA5z9YJZbOnaa6TYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224988; c=relaxed/simple;
	bh=gmXz+McnzyPjXPi6OUhiohI/xUC56gZuLS5gnq0kbxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVwB1Z5hpqwgkbC8N7CcU8rmI9ljCSitPFjign+dLHWXkXRhDRVv5QHsXQ1DtKIy849CNj0s4RMrPEuQ/t1zun1PrRYUgHBKSxZqfXY9Ir0cbu/CF9rXSnybI8Bq0FRCxkoyqldCurYgxb36wnLkx6zYUzNXjb2W7glX5xq6s60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=HOe0CbO+; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755224899;
	bh=C8FPcDjjyvmDVFKC1++BAFYe4RVNG4mt5PvVSNaRksk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=HOe0CbO+LZG6t4y334G8qCSM3inAg4YhXLR9rsnUy/QLqIi4FVdO53QstWJs6UviN
	 xlxgBxCy+vX/yBlR7wrK3DDiXrn1CnrzNba8EWWXATEffaxra8oKZm7GDD9zNRpRyH
	 poewJfOU47UA42CAofmBOyUwYVRu4zspMxw6fcac=
X-QQ-mid: zesmtpgz5t1755224896tbd303590
X-QQ-Originating-IP: jlBHOZ+VAUej3deF8SZeiYt46tnagK7aAe41l0Xfo84=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 10:28:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14352481301099076382
EX-QQ-RecipientCnt: 23
Date: Fri, 15 Aug 2025 10:28:14 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Alex Elder <elder@riscstar.com>, lee@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, alexandre.belloni@bootlin.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl, dlan@gentoo.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux.amoon@gmail.com, troymitchell988@gmail.com,
	guodong@riscstar.com, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v12 2/7] mfd: simple-mfd-i2c: add SpacemiT P1 support
Message-ID: <089D29348F246F2C+aJ6bPgJsp5GjhDs5@LT-Guozexi>
References: <20250813024509.2325988-1-elder@riscstar.com>
 <20250813024509.2325988-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813024509.2325988-3-elder@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Mf2c2cXG8XEigeMabfrexd3atm3LDqd8aPerlQlM8uLUza62iBGGLc4v
	/0jZ/BWS5I0Fgz6qXXfqJTYUXVkEf8s20Pp6EmQW21uADfWO495LO3t4MWS1bMfFAGB3ipQ
	MPQRQ9TfDZ1PfkDFE+7zjkVIif42vMdNcvGgxSi2B9VX7KXU0sAaBD0Fr/gMMZfqwCk/IMj
	YNksP2p1okPa/z9Fhwq4ahXN/PJp1zFLxegoHOYC2gSMxlzIE4F35VRyfxh+xkDG4VWlV7W
	baimqtBCoJLhfB1Kf+RJ4dkWkDVkEWe3og7DxlTRTIRJ41V9wwzHF+dYjQl5mVJFk58uBsy
	fsag0bu6YqbGBeQKu8WYwkcoBNyLSuNivIoBbpaz9HYTtvN/52uAenksFHqlFv+VTJyK//a
	IHtcjvno41ESQam+he6EwD5foVE3SbrLOO+zIwjIURw8D3sJe61jbzLgUAdAOfY4oUbP+5I
	uv1Y8JoNslwnOfG5XaNuRmyT52Bxh7+QQwMF7TUWWFtFX3PCB6mk5TmsLQtEdfk7M56Z++9
	O+1elUpo5LavdhxOiA9ED9kwczvVImjPn7anVdmX0a4Hnnrgeihx7lbZg4H/zYGvkmw74tB
	nbTwtX4taPhfRxZaYi0Kxt4Cy1gyNC5AIDbXbvlttDLlxiU4CCPkpSIUej4b0x4acon3I6b
	OrkJFmHw+3WreoCfAYoNXW5ueLeHPMIfq24lFB2tsm7hb8J7LMD1VZlLAyTD3AJdIpP0akK
	1GzzDEXJq9VzXYsRfDvmca1+QubIIIQtWbdB+U6JpH9aqXLdJZWm5pzciCCquPB19JaBgyI
	1IQR0Wc3xgQ7F+G6PhOJA6EUN7VuG6ADo/+TQLlzzqldKIyJxpW4mfi3S+wgX3rs3mTYK7g
	bTKiD+eqi0oXLZbQQlh4HJn3AmOQOVvqtlLn3pzlZ0R6e87d/65T8/9ibqPU8I15fRh8O12
	5uLUd0copEgK0S3nxDBtU0bI2cvsIRDOvg9cM7eIgzfO1WQN10sYsntv8BLi35sXYt2MFe4
	1T/rNsOp8jFwN3kr5pXp6q94CTvxqi/iON4a3RWrnJGIJhXGWK8KuD89Ud9SPJ9mEYf/e/H
	y0m0UcvBnLq
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Hi, Alex,

I did not find any accesses to the P1 shutdown or reboot registers here.
Does this mean that the current series does not support reboot or shutdown?
If so, do you have any plans to support this functionality?
If I have misunderstood, please correct me.

Best regards,
Troy


On Tue, Aug 12, 2025 at 09:45:03PM -0500, Alex Elder wrote:
> Enable support for the RTC and regulators found in the SpacemiT P1
> PMIC.  Support is implemented by the simple I2C MFD driver.
> 
> The P1 PMIC is normally implemented with the SpacemiT K1 SoC.  This
> PMIC provides 6 buck converters and 12 LDO regulators.  It also
> implements a switch, watchdog timer, real-time clock, and more.
> Initially its RTC and regulators are supported.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/mfd/Kconfig          | 11 +++++++++++
>  drivers/mfd/simple-mfd-i2c.c | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 425c5fba6cb1e..4d6a5a3a27220 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1238,6 +1238,17 @@ config MFD_QCOM_RPM
>  	  Say M here if you want to include support for the Qualcomm RPM as a
>  	  module. This will build a module called "qcom_rpm".
>  
> +config MFD_SPACEMIT_P1
> +	tristate "SpacemiT P1 PMIC"
> +	depends on I2C
> +	select MFD_SIMPLE_MFD_I2C
> +	help
> +	  This option supports the I2C-based SpacemiT P1 PMIC, which
> +	  contains regulators, a power switch, GPIOs, an RTC, and more.
> +	  This option is selected when any of the supported sub-devices
> +	  is configured.  The basic functionality is implemented by the
> +	  simple MFD I2C driver.
> +
>  config MFD_SPMI_PMIC
>  	tristate "Qualcomm SPMI PMICs"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 22159913bea03..47ffaac035cae 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -93,12 +93,30 @@ static const struct simple_mfd_data maxim_mon_max77705 = {
>  	.mfd_cell_size = ARRAY_SIZE(max77705_sensor_cells),
>  };
>  
> +
> +static const struct regmap_config spacemit_p1_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static const struct mfd_cell spacemit_p1_cells[] = {
> +	{ .name = "spacemit-p1-regulator", },
> +	{ .name = "spacemit-p1-rtc", },
> +};
> +
> +static const struct simple_mfd_data spacemit_p1 = {
> +	.regmap_config = &spacemit_p1_regmap_config,
> +	.mfd_cell = spacemit_p1_cells,
> +	.mfd_cell_size = ARRAY_SIZE(spacemit_p1_cells),
> +};
> +
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "kontron,sl28cpld" },
>  	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
>  	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
>  	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
>  	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},
> +	{ .compatible = "spacemit,p1", .data = &spacemit_p1, },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> -- 
> 2.48.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

