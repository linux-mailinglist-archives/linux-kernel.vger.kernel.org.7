Return-Path: <linux-kernel+bounces-855654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0316BBE1E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E7D03523B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8B82F83CC;
	Thu, 16 Oct 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="svRVqibj"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7A19D093
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598659; cv=none; b=cusPaFUAWSC38Ent3qtDEGHpgzEv+ev+8iM8M68Svhl4VI7XEKxI43hh654SOhz/tM3I+fRqwQ9WzGM5RWxXDm36cmYePLQ5nU0CDsoA3zrnzBb86RWwFnOIcH2zSVtf/JQyCj4jB5fmptK3iM8cSsH7RmD/SJVzl2AMiglmwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598659; c=relaxed/simple;
	bh=YVg0FctC7GJZlWGeL0XSTTrNvmW+FDG9DYzoUUw+j0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl4KOzKGqAETDSkFAIcky9HyPcInmLSkYn0uTJnnoqSlZxt84JX5WKSbEw8GILEf3UHiJjadE7AydtFeP0uRUv4ufX4RbiQSND3NNakGoqsP2RxE7WspBZZ5x7qWjgWXQNQTZnAKRixpi3GXuBVMKvcHR8HSppGVOL3vfQPaUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=svRVqibj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3A7AA1A1410;
	Thu, 16 Oct 2025 07:10:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 085CC6062C;
	Thu, 16 Oct 2025 07:10:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8770102F22EB;
	Thu, 16 Oct 2025 09:10:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760598653; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XG9EgxM+HphpELFgN1h9FglcNCf2fgMbdPSVwpOCK8c=;
	b=svRVqibjs4Jrtm4XqszFroWHazhCE17eXHtNNaw/tDM/u5ihlBxPqJ1SmYi+VmtccpNy21
	3Ryxle0A+wl55usjYV0yylxMOWh8lkeTpEt7S3oI/qIsfjgTti313Ik/4NxUfb48W/JVNQ
	cxB/rSF2xrqn1X3xSxiS2qNY966VEZMp/dR6gRVNEBNwprlKtpAPKvDJ2ZLrai7ZtHnjWN
	o7tybwOxDo5zibB/irKu+SBDcNQ49C5iNlE0Odhb+NDZqWcdTaVegFkjTeK2ATka9wy1gv
	m03Y6NlQBKzGL7//UIlWHflFkDlSCWzK6p+IL+YXIkqDfipTI/izjQL12HijjQ==
Date: Thu, 16 Oct 2025 09:10:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: adrianhoyin.ng@altera.com
Cc: dinguyen@kernel.org, Frank.Li@nxp.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] i3c: dw: add option to disable runtime PM for
 DesignWare I3C controller
Message-ID: <20251016071051c3f647ce@mail.local>
References: <22286d459959f2a153ac59d7da46794c0f495c77.1760579799.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22286d459959f2a153ac59d7da46794c0f495c77.1760579799.git.adrianhoyin.ng@altera.com>
X-Last-TLS-Session-Version: TLSv1.3

On 16/10/2025 10:03:39+0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> Add a new Kconfig option, DW_I3C_DISABLE_RUNTIME_PM, that allows
> disabling all runtime power management (PM) operations for the
> Synopsys DesignWare I3C controller. When this option is selected,
> the driver skips all runtime PM calls such as pm_runtime_enable(),
> pm_runtime_get(), and pm_runtime_put(), keeping the controller
> permanently active.

While the quirk may make sense, it definitively can't be activated by a
Kconfig option. This should rather be tied to a new compatible string or
a property.

> 
> This change addresses a reliability issue observed on some systems
> where the controller enters a suspended state while a slave device
> issues an In-Band Interrupt (IBI). Because the suspended controller
> no longer drives the SCL line, the IBI transfer cannot complete,
> causing the SDA line to remain stuck low and leaving the bus in a
> hung state. Disabling runtime PM prevents the controller from
> entering this suspended state, ensuring that clock signals remain
> active and IBI transactions complete successfully.
> 
> A new quirk flag (DW_I3C_DISABLE_RUNTIME_PM_QUIRK) is introduced to
> control this behavior dynamically at probe time, and the option is
> propagated through the device match data.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>  drivers/i3c/master/Kconfig         |  23 ++++
>  drivers/i3c/master/dw-i3c-master.c | 176 +++++++++++++++++------------
>  2 files changed, 129 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index 82cf330778d5..d6159ec94c85 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -31,6 +31,29 @@ config DW_I3C_MASTER
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called dw-i3c-master.
>  
> +config DW_I3C_DISABLE_RUNTIME_PM
> +	bool "Disable runtime PM support for DesignWare I3C controller"
> +	depends on DW_I3C_MASTER
> +	default n
> +	help
> +	  If selected, disables all runtime power management (PM)
> +	  operations for the Synopsys DesignWare I3C controller.
> +
> +	  When enabled, the driver skips all runtime PM calls such as
> +	  pm_runtime_enable(), pm_runtime_get(), and pm_runtime_put(),
> +	  keeping the controller permanently active during operation.
> +
> +	  This option is useful on systems where runtime PM causes bus
> +	  reliability issues. In particular, if the controller is placed
> +	  into a suspended state while a slave device attempts to issue an
> +	  In-Band Interrupt (IBI), the controller may stop driving the
> +	  SCL line, preventing the IBI from completing. This condition can
> +	  result in the SDA line remaining stuck low, leaving the bus in a
> +	  hung state until a full hardware reset is performed. Disabling
> +	  runtime PM prevents the controller from entering this suspended
> +	  state, ensuring that clock signals remain active for IBI
> +	  handling.
> +
>  config AST2600_I3C_MASTER
>  	tristate "ASPEED AST2600 I3C master driver"
>  	depends on DW_I3C_MASTER
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 9ceedf09c3b6..4f4ef4672255 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -227,7 +227,8 @@
>  #define AMD_I3C_PP_TIMING          0x8001A
>  
>  /* List of quirks */
> -#define AMD_I3C_OD_PP_TIMING		BIT(1)
> +#define AMD_I3C_OD_PP_TIMING			BIT(1)
> +#define DW_I3C_DISABLE_RUNTIME_PM_QUIRK	BIT(2)
>  
>  struct dw_i3c_cmd {
>  	u32 cmd_lo;
> @@ -635,12 +636,14 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
>  	struct i3c_device_info info = { };
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>  
>  	ret = master->platform_ops->init(master);
> @@ -682,7 +685,8 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
>  	dw_i3c_master_enable(master);
>  
>  rpm_out:
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>  
> @@ -798,12 +802,14 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
>  		writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
>  	}
>  
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>  
>  	if (ccc->rnw)
> @@ -811,7 +817,8 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
>  	else
>  		ret = dw_i3c_ccc_set(master, ccc);
>  
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>  
> @@ -824,12 +831,14 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
>  	u8 last_addr = 0;
>  	int ret, pos;
>  
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>  
>  	olddevs = ~(master->free_pos);
> @@ -893,7 +902,8 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
>  	dw_i3c_master_free_xfer(xfer);
>  
>  rpm_out:
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>  
> @@ -929,12 +939,14 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
>  	if (!xfer)
>  		return -ENOMEM;
>  
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>  
>  	for (i = 0; i < i3c_nxfers; i++) {
> @@ -978,7 +990,8 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
>  	ret = xfer->ret;
>  	dw_i3c_master_free_xfer(xfer);
>  
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>  
> @@ -1089,12 +1102,14 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
>  	if (!xfer)
>  		return -ENOMEM;
>  
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>  
>  	for (i = 0; i < i2c_nxfers; i++) {
> @@ -1127,7 +1142,8 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
>  	ret = xfer->ret;
>  	dw_i3c_master_free_xfer(xfer);
>  
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>  
> @@ -1272,12 +1288,14 @@ static int dw_i3c_master_enable_hotjoin(struct i3c_master_controller *m)
>  	struct dw_i3c_master *master = to_dw_i3c_master(m);
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>  
>  	dw_i3c_master_enable_sir_signal(master, true);
> @@ -1294,7 +1312,8 @@ static int dw_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
>  	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
>  	       master->regs + DEVICE_CTRL);
>  
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return 0;
>  }
>  
> @@ -1305,12 +1324,14 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
>  	struct dw_i3c_master *master = to_dw_i3c_master(m);
>  	int rc;
>  
> -	rc = pm_runtime_resume_and_get(master->dev);
> -	if (rc < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, rc);
> -		return rc;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		rc = pm_runtime_resume_and_get(master->dev);
> +		if (rc < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, rc);
> +			return rc;
> +		}
>  	}
>  
>  	dw_i3c_master_set_sir_enabled(master, dev, data->index, true);
> @@ -1319,7 +1340,8 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
>  
>  	if (rc) {
>  		dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
> -		pm_runtime_put_autosuspend(master->dev);
> +		if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +			pm_runtime_put_autosuspend(master->dev);
>  	}
>  
>  	return rc;
> @@ -1338,7 +1360,8 @@ static int dw_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
>  
>  	dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
>  
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return 0;
>  }
>  
> @@ -1573,11 +1596,6 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  
>  	platform_set_drvdata(pdev, master);
>  
> -	pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
> -	pm_runtime_use_autosuspend(&pdev->dev);
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> -
>  	/* Information regarding the FIFOs/QUEUEs depth */
>  	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
>  	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
> @@ -1592,6 +1610,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  
>  	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
>  
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
> +		pm_runtime_use_autosuspend(&pdev->dev);
> +		pm_runtime_set_active(&pdev->dev);
> +		pm_runtime_enable(&pdev->dev);
> +	}
> +
>  	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
>  	ret = i3c_master_register(&master->base, &pdev->dev,
>  				  &dw_mipi_i3c_ops, false);
> @@ -1601,9 +1626,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  	return 0;
>  
>  err_disable_pm:
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
> -	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		pm_runtime_disable(&pdev->dev);
> +		pm_runtime_set_suspended(&pdev->dev);
> +		pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	}
>  
>  err_assert_rst:
>  	reset_control_assert(master->core_rst);
> @@ -1617,9 +1644,11 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
>  	cancel_work_sync(&master->hj_work);
>  	i3c_master_unregister(&master->base);
>  
> -	pm_runtime_disable(master->dev);
> -	pm_runtime_set_suspended(master->dev);
> -	pm_runtime_dont_use_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		pm_runtime_disable(master->dev);
> +		pm_runtime_set_suspended(master->dev);
> +		pm_runtime_dont_use_autosuspend(master->dev);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
>  
> @@ -1742,12 +1771,14 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
>  	struct dw_i3c_master *master = platform_get_drvdata(pdev);
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return;
> +		}
>  	}
>  
>  	cancel_work_sync(&master->hj_work);
> @@ -1756,11 +1787,16 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
>  	writel((u32)~INTR_ALL, master->regs + INTR_STATUS_EN);
>  	writel((u32)~INTR_ALL, master->regs + INTR_SIGNAL_EN);
>  
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  }
>  
>  static const struct of_device_id dw_i3c_master_of_match[] = {
> -	{ .compatible = "snps,dw-i3c-master-1.00a", },
> +	{ .compatible = "snps,dw-i3c-master-1.00a",
> +#ifdef CONFIG_DW_I3C_DISABLE_RUNTIME_PM
> +	  .data = (void *)DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
> +#endif
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
> -- 
> 2.49.GIT
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

