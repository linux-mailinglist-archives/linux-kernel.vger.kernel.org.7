Return-Path: <linux-kernel+bounces-751998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9CB17026
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315631703A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61922F74B;
	Thu, 31 Jul 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq7cm8ed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955E2248AC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960154; cv=none; b=ibvS8H22uON/ogUOUg7vpX7gNah/wDJiVkAIddtIUdkUqaTqMV01QXeNhcNAQGcvlJ44wNDzTQfAyv8bo8G/munp/RTcotpF/D0bcti+9TkmMZxBmSHCfMdFu5lBxYu1ESClGQ1IiMZFmi/EYOrUdgxxNSPOhXWwrqfwrMYZTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960154; c=relaxed/simple;
	bh=A1QiLFsWkLOne69flYjxRji6b6Am/6hybG4NGr+X1Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toI8zfZNx5wXusl4WVQb2Xr5MaUPo2/0p0Yr7coF9xD1f7yFOz1J4jgYUR6VxsoOZ1TmoW7Bs/HHjtKgi2DeCG8CUOOMuFr7xWCbLtF1U6j3qzqsvvfZEE63lbkfkGWGNongY3RkEwcQmXohJflvHErYDc4GcaqixpqtG4gCNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq7cm8ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B74C4CEEF;
	Thu, 31 Jul 2025 11:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753960153;
	bh=A1QiLFsWkLOne69flYjxRji6b6Am/6hybG4NGr+X1Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eq7cm8edGkoGi5Z4FYjfHo2kfBz7kdjZ8gZnbMlHsFJZ9GpJ160ANP36pAiPhDGgx
	 iSBRb9D8F7+YbYqseUEpRsE63h0uqHBH01Uq2J1uPpafcHOZhF4KTe2YNGlJtUzKHL
	 iB5+szXDjW87D6zwKwO3ejN4+vhRb6yJj+sGXe6+xpj52OdlEzIwBprztPVvRNP9c2
	 PLPwNZp6qxfLgeMYhH+UA1pDV+wfT2P9utoPe0+jzebjPRub1Yghs+ZdE4iF1UUXCB
	 amjkeVJfPiPJDx5TmmyaUmFj+PBG+X127oT0+Vmh7jkNVD3e0eJBq5CW7ekvCaZorT
	 g9j8GQxvmThvA==
Date: Thu, 31 Jul 2025 12:09:09 +0100
From: Lee Jones <lee@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] mfd: stmpe: Allow building as module
Message-ID: <20250731110909.GE1049189@google.com>
References: <20250725071153.338912-1-alexander.stein@ew.tq-group.com>
 <20250725071153.338912-4-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725071153.338912-4-alexander.stein@ew.tq-group.com>

On Fri, 25 Jul 2025, Alexander Stein wrote:

> Export the core probe and remove function to be used by modules. Add
> necessary module information so the driver can be built as a module.

because ...

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/mfd/Kconfig | 10 +++++-----
>  drivers/mfd/stmpe.c |  6 ++++++
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8f11b2df14704..a58c95e5b8072 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1539,8 +1539,8 @@ config MFD_DB8500_PRCMU
>  	  through a register map.
>  
>  config MFD_STMPE
> -	bool "STMicroelectronics STMPE"
> -	depends on I2C=y || SPI_MASTER=y
> +	tristate "STMicroelectronics STMPE"
> +	depends on I2C || SPI_MASTER
>  	depends on OF
>  	select MFD_CORE
>  	help
> @@ -1568,14 +1568,14 @@ menu "STMicroelectronics STMPE Interface Drivers"
>  depends on MFD_STMPE
>  
>  config STMPE_I2C
> -	bool "STMicroelectronics STMPE I2C Interface"
> -	depends on I2C=y
> +	tristate "STMicroelectronics STMPE I2C Interface"
> +	depends on I2C
>  	default y
>  	help
>  	  This is used to enable I2C interface of STMPE
>  
>  config STMPE_SPI
> -	bool "STMicroelectronics STMPE SPI Interface"
> +	tristate "STMicroelectronics STMPE SPI Interface"
>  	depends on SPI_MASTER
>  	help
>  	  This is used to enable SPI interface of STMPE
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index e1165f63aedae..5faf13fd6cf83 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -1482,6 +1482,7 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(stmpe_probe);
>  
>  void stmpe_remove(struct stmpe *stmpe)
>  {
> @@ -1497,6 +1498,7 @@ void stmpe_remove(struct stmpe *stmpe)
>  
>  	mfd_remove_devices(stmpe->dev);
>  }
> +EXPORT_SYMBOL_GPL(stmpe_remove);
>  
>  static int stmpe_suspend(struct device *dev)
>  {
> @@ -1520,3 +1522,7 @@ static int stmpe_resume(struct device *dev)
>  
>  EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmpe_dev_pm_ops,
>  			     stmpe_suspend, stmpe_resume);
> +
> +MODULE_DESCRIPTION("STMPE MFD Core driver");

Drop the MFD part.

> +MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

