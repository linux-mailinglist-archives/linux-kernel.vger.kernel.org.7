Return-Path: <linux-kernel+bounces-727776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D29B9B01F88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781A21CC1373
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B32E9EB7;
	Fri, 11 Jul 2025 14:51:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51A2D0C69;
	Fri, 11 Jul 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245501; cv=none; b=N307sEkuNiefPy7XtsowOR+fS/TnfB0mFJKwF30IywIZ4ZXPTKFJZKAO63hg/9z8FRpCqm+ssfac8+FnfFwiG3Aov5aazpOzhHF3Rm/m2TDGVX1RayF29CW69frB++mIHdgpbyKUzTqD87BXzdnGNTgjMIK68++8ZZ8jdTt4KZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245501; c=relaxed/simple;
	bh=r2IwT981Qdm+8/Cp4CluyfQZdBbxKCFeENM7renLigE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qrw/DE6J638qqDz16PzIX4jm9+2hJKGktcZA3PixxcrKhIobO93cmiIFQvaelCjm3H0OIEAbntC4CRCA4QbJLL6eoB+6m7SIG0mMPNR2Xgm8Rz5hAVpr/ZrkFV/2EyeNnM7nd0TuLtQkftP1qmcnyhPDgcYxFJ/Ih+SZZxUKBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdvhz6gzzz6L55l;
	Fri, 11 Jul 2025 22:48:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 43D00140279;
	Fri, 11 Jul 2025 22:51:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 16:51:37 +0200
Date: Fri, 11 Jul 2025 15:51:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Cristian Marussi <cristian.marussi@arm.com>,
	<arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: convert to SYSTEM_SLEEP_PM_OPS
Message-ID: <20250711155136.00000fdf@huawei.com>
In-Reply-To: <20250709070107.1388512-1-arnd@kernel.org>
References: <20250709070107.1388512-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  9 Jul 2025 09:01:01 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The old SET_SYSTEM_SLEEP_PM_OPS() macro leads to a warning about an
> unused function:
> 
> drivers/firmware/arm_scmi/scmi_power_control.c:363:12: error: 'scmi_system_power_resume' defined but not used [-Werror=unused-function]
>   363 | static int scmi_system_power_resume(struct device *dev)
> 
> The proper way to do this these days is to use SYSTEM_SLEEP_PM_OPS()
> and pm_sleep_ptr().
> 
> Fixes: 9a0658d3991e ("firmware: arm_scmi: power_control: Ensure SCMI_SYSPOWER_IDLE is set early during resume")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firmware/arm_scmi/scmi_power_control.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
> index ab0cee0d4bec..955736336061 100644
> --- a/drivers/firmware/arm_scmi/scmi_power_control.c
> +++ b/drivers/firmware/arm_scmi/scmi_power_control.c
> @@ -369,7 +369,7 @@ static int scmi_system_power_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops scmi_system_power_pmops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(NULL, scmi_system_power_resume)
> +	SYSTEM_SLEEP_PM_OPS(NULL, scmi_system_power_resume)
>  };

As a possible followup IIRC we have a macro for this

static DEFINE_SIMPLE_DEV_PM_OPS(scmi_system_power_pmops,
				NULL, scmi_system_power_resume);



>  
>  static const struct scmi_device_id scmi_id_table[] = {
> @@ -380,7 +380,7 @@ MODULE_DEVICE_TABLE(scmi, scmi_id_table);
>  
>  static struct scmi_driver scmi_system_power_driver = {
>  	.driver	= {
> -		.pm = &scmi_system_power_pmops,
> +		.pm = pm_sleep_ptr(&scmi_system_power_pmops),
>  	},
>  	.name = "scmi-system-power",
>  	.probe = scmi_syspower_probe,


