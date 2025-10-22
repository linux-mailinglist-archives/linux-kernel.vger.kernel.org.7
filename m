Return-Path: <linux-kernel+bounces-865754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD6BFDEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46F204E8754
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55C534EF15;
	Wed, 22 Oct 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zha1nbOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70F2E283A;
	Wed, 22 Oct 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158724; cv=none; b=XnZw06FeVmEGSl6+IX7GdUQbAHLpDYXLe9Gh8oa6/fC5ejW6nnZEED1Dlk4khE/sAj/qDgC7hRGL3jv6rB8viAT4X+6hKKzyxPJrrNsY6iLB4LUa7zkJ+vFpqkxmMsMcJLE+2O/+2RyArTNXn530s/i2jEjl3OdvPqIpoNGPkDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158724; c=relaxed/simple;
	bh=39cjh1liJkM4XAwglbYzn74U9iL/cnSgjYFahV3APM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buDbjInzzaD+rIfGNx61rJiv/gxN25YFx/7SwmHqi5bKGS7OvAL5DscpCsVfdeRoQNvi5H2tClQ1rjZ0LXyChY2JxYK9JBmO/GR1PbfG7QpEtq43TemCKis7iBEJ7AXWtGGfblxpZHvPq3Y8ARtvSMl7vnkgnBVNUGF3RlQXoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zha1nbOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884BAC4CEE7;
	Wed, 22 Oct 2025 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761158723;
	bh=39cjh1liJkM4XAwglbYzn74U9iL/cnSgjYFahV3APM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zha1nbOwNZJ82TPRZxj6V1v6bP+TLpTuQKu9G+YDzjcSn052cnZk87ir61cZYbXn+
	 JBntub4GY/1Ojr9+i4L0GkX8sS+FDYYPGx71WoyP/GnNxy/vfGWCKSgeyOox5SRFHX
	 z3Mflz2QWCBz6LrIuYO2x/Z1nibkTn1ky5EPuNxC+X1hcj8HPG8fXC2qnqFPjlfewF
	 fCvRobZyTX9gXGejeSQLUVruMG1KcuAyxoEcFO33yh1QamfHjf8cMjxBhScbI1iRYT
	 PHEm1GjXDb724gFk+c0Wh3/uVlRJHfvbptfVygnLH+PKZy2x/IG9LUxofGhyq/q99h
	 gw1M8QUcRz4lA==
Received: by pali.im (Postfix)
	id B85467F2; Wed, 22 Oct 2025 20:45:18 +0200 (CEST)
Date: Wed, 22 Oct 2025 20:45:18 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: migrate i8k procfs interface to sysfs
Message-ID: <20251022184518.53tqi33jgustwvf5@pali>
References: <20251022183746.66481-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183746.66481-1-biancaa2210329@ssn.edu.in>
User-Agent: NeoMutt/20180716

Sorry, but I do not understand this patch. dell-smm-hwmon driver is
already using the sysfs interface provided by hwmon subsystem.

On Thursday 23 October 2025 00:07:46 Biancaa Ramesh wrote:
> The i8k driver currently exposes Dell laptop hardware monitoring
> information via a deprecated /proc/i8k interface.
> 
> This patch removes the procfs file creation and replaces it with
> standard sysfs attributes under the hwmon subsystem.
> 
> - Removes i8k procfs registration and operations.
> - Creates sysfs attributes for temperature, fan speeds, and power status.
> - Registers these attributes via devm_hwmon_device_register_with_groups().
> - Cleans up legacy procfs code for a cleaner, modern, and supported interface.
> 
> This migration aligns with Linux kernel best practices to phase out
> deprecated and legacy procfs files in favor of a structured sysfs approach.
> 
> Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index oldhash..newhash 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -XXX,40 +XXX,80 @@
> -// Remove procfs interface
> -static int i8k_proc_show(struct seq_file *seq, void *offset)
> -{
> -    struct dell_smm_data *data = seq->private;
> -    // ...
> -}
> -
> -static const struct proc_ops i8k_proc_ops = {
> -    .proc_open = i8k_open_fs,
> -    .proc_read = seq_read,
> -    .proc_lseek = seq_lseek,
> -    .proc_release = single_release,
> -    .proc_ioctl = i8k_ioctl,
> -};
> -
> -static void i8k_exit_procfs(void *param)
> -{
> -    remove_proc_entry("i8k", NULL);
> -}
> -
> -static void __init i8k_init_procfs(struct device *dev)
> -{
> -    struct dell_smm_data *data = dev_get_drvdata(dev);
> -    // ...
> -    if (proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data))
> -        devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
> -}
> +// Define sysfs attributes for temps and fans
> +static ssize_t temp1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +    struct dell_smm_data *data = dev_get_drvdata(dev);
> +    int temp = i8k_get_temp(data, 0);
> +    if (temp < 0)
> +        return temp;
> +    return sprintf(buf, "%d\n", temp * 1000);
> +}
> +
> +static DEVICE_ATTR_RO(temp1_input);
> +
> +static ssize_t fan1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +    struct dell_smm_data *data = dev_get_drvdata(dev);
> +    int speed = i8k_get_fan_speed(data, 0);
> +    if (speed < 0)
> +        return speed;
> +    return sprintf(buf, "%d\n", speed);
> +}
> +
> +static DEVICE_ATTR_RO(fan1_input);
> +
> +static struct attribute *dell_smm_attrs[] = {
> +    &dev_attr_temp1_input.attr,
> +    &dev_attr_fan1_input.attr,
> +    NULL,
> +};
> +
> +static const struct attribute_group dell_smm_group = {
> +    .attrs = dell_smm_attrs,
> +};
> +
> +static const struct attribute_group *dell_smm_groups[] = {
> +    &dell_smm_group,
> +    NULL,
> +};
> +
> +static int dell_smm_init_cdev(struct device *dev)
> +{
> +    struct dell_smm_data *data = dev_get_drvdata(dev);
> +    struct device *hwmon_dev;
> +
> +    hwmon_dev = devm_hwmon_device_register_with_groups(dev, "dell_smm", data, dell_smm_groups);
> +    return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static int __init dell_smm_probe(struct platform_device *pdev)
> +{
> +    int ret;
> +
> +    ret = dell_smm_init_data(&pdev->dev, &i8k_smm_ops);
> +    if (ret < 0)
> +        return ret;
> +
> +    ret = dell_smm_init_hwmon(&pdev->dev);
> +    if (ret)
> +        return ret;
> +
> +    ret = dell_smm_init_cdev(&pdev->dev);
> +    if (ret)
> +        return ret;
> +
> +    return 0;
> +}
> 
> -- 
> ::DISCLAIMER::
> 
> ---------------------------------------------------------------------
> The 
> contents of this e-mail and any attachment(s) are confidential and
> intended 
> for the named recipient(s) only. Views or opinions, if any,
> presented in 
> this email are solely those of the author and may not
> necessarily reflect 
> the views or opinions of SSN Institutions (SSN) or its
> affiliates. Any form 
> of reproduction, dissemination, copying, disclosure,
> modification, 
> distribution and / or publication of this message without the
> prior written 
> consent of authorized representative of SSN is strictly
> prohibited. If you 
> have received this email in error please delete it and
> notify the sender 
> immediately.
> ---------------------------------------------------------------------
> Header of this mail should have a valid DKIM signature for the domain 
> ssn.edu.in <http://www.ssn.edu.in/>

