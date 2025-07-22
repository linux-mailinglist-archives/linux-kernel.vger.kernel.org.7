Return-Path: <linux-kernel+bounces-740879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72906B0DA92
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A352545B91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967852E9EDF;
	Tue, 22 Jul 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEePorsw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CEE23ED5E;
	Tue, 22 Jul 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190071; cv=none; b=PviEWI//dG3ZqAIXqCp1Y9V8+kpaKHWWKCU9HmBT5WUN4wfdEL8BkI46hHjtbQaUdb6UTj/+rM2/4kYp/ijyRVQGP2BwuwU/xZgokE9ckAuSPZ5dG2VHmy3AvcQRJif2vgxGKJOraQ3jHLBBI3u3SA9mR7eHPATGSKGohoiBnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190071; c=relaxed/simple;
	bh=4+hMLNITvQjzznkS5VvX+swrR5myW5iOTWCPjGwMvLY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QG70LnqqAFPtHPISB3KkE8rjpAL6Ri3YHNhSaAFhC8kZd5YxjfeLgIgEly4xkAr5+sIkpG0Q5Bob0yohb80cUEf3JpByw8MU2AwhCsVzKh2iXKznstADT8bFsMWg7Nc6kCN4ZYg9803sOgt8A0klcLDblwGOfUQQXVqDavSIqcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEePorsw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753190069; x=1784726069;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4+hMLNITvQjzznkS5VvX+swrR5myW5iOTWCPjGwMvLY=;
  b=LEePorswWw/YLUG7Xs/qzCgZTVYoTcPi9iI3bpMHgzn/e5m22kdkiRvN
   oyEo7bUs1d2EcENT1zxtoTq5/xSQnai++6+pTtLq5C/62nTvB+4XEpCV1
   jcFgRKS1/+E6QYDMQnkRGGDawwbHjy4olNTFogrLe5QqeWi+xt7ObASm+
   ihzt2JJpXXK8m2lfWyt9bcnibMNfBMsk3m/Sxql91oXH2czRtX3vpYyE5
   hhDQoX5UP8XU8Nahdz5rNgFmGcXqhZ+790dFcqVqSPIElgycN+RktpU2P
   M0rdevdruuMNZ6V+eATLO5Z2B2wnyqVxQmrwiMjuiWmLw65OC2+lZp1sB
   Q==;
X-CSE-ConnectionGUID: L45AMUxQRe+V2LVDVAZ9zg==
X-CSE-MsgGUID: rgyqAkBjSKqb6P4OGxRJkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54539222"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="54539222"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:14:28 -0700
X-CSE-ConnectionGUID: Ad9XyAr5TD+u+vv4WC9qlQ==
X-CSE-MsgGUID: rBFSLfkvTqu6ZOD+IbEJrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="182839005"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:14:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Jul 2025 16:14:22 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: hansg@kernel.org, Dell.Client.Kernel@dell.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: dell-smbios-wmi: Stop touching WMI device
 ID
In-Reply-To: <20250712140222.347638-1-W_Armin@gmx.de>
Message-ID: <2897df20-cb7f-41c6-e72f-91f1696556a0@linux.intel.com>
References: <20250712140222.347638-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 12 Jul 2025, Armin Wolf wrote:

> The WMI core itself uses wdev->dev.id internally to track device IDs,
> so modifying this value will result in a resource leak.
> 
> Fix this by not using the device ID for SMBIOS prioritization.

Please describe the solution properly. The patch deals with what is called 
"priority" which is not covered by the changelog text at all.

> Tested on a Dell Inspiron 3505.
> 
> Fixes: 73f0f2b52c5e ("platform/x86: wmi: Fix WMI device naming issue")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 19 +++++++++----------
>  drivers/platform/x86/dell/dell-smbios-smm.c  |  3 +--
>  drivers/platform/x86/dell/dell-smbios-wmi.c  |  4 +---
>  drivers/platform/x86/dell/dell-smbios.h      |  2 +-
>  4 files changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index 01c72b91a50d..444786102f02 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -39,6 +39,7 @@ struct token_sysfs_data {
>  struct smbios_device {
>  	struct list_head list;
>  	struct device *device;
> +	int priority;
>  	int (*call_fn)(struct calling_interface_buffer *arg);
>  };
>  
> @@ -145,7 +146,7 @@ int dell_smbios_error(int value)
>  }
>  EXPORT_SYMBOL_GPL(dell_smbios_error);
>  
> -int dell_smbios_register_device(struct device *d, void *call_fn)
> +int dell_smbios_register_device(struct device *d, int priority, void *call_fn)
>  {
>  	struct smbios_device *priv;
>  
> @@ -154,6 +155,7 @@ int dell_smbios_register_device(struct device *d, void *call_fn)
>  		return -ENOMEM;
>  	get_device(d);
>  	priv->device = d;
> +	priv->priority = priority;
>  	priv->call_fn = call_fn;
>  	mutex_lock(&smbios_mutex);
>  	list_add_tail(&priv->list, &smbios_device_list);
> @@ -292,28 +294,25 @@ EXPORT_SYMBOL_GPL(dell_smbios_call_filter);
>  
>  int dell_smbios_call(struct calling_interface_buffer *buffer)
>  {
> -	int (*call_fn)(struct calling_interface_buffer *) = NULL;
> -	struct device *selected_dev = NULL;
> +	struct smbios_device *selected = NULL;
>  	struct smbios_device *priv;
>  	int ret;
>  
>  	mutex_lock(&smbios_mutex);
>  	list_for_each_entry(priv, &smbios_device_list, list) {
> -		if (!selected_dev || priv->device->id >= selected_dev->id) {
> -			dev_dbg(priv->device, "Trying device ID: %d\n",
> -				priv->device->id);
> -			call_fn = priv->call_fn;
> -			selected_dev = priv->device;
> +		if (!selected || priv->priority >= selected->priority) {
> +			dev_dbg(priv->device, "Trying device ID: %d\n", priv->priority);
> +			selected = priv;
>  		}
>  	}
>  
> -	if (!selected_dev) {
> +	if (!selected) {
>  		ret = -ENODEV;
>  		pr_err("No dell-smbios drivers are loaded\n");
>  		goto out_smbios_call;
>  	}
>  
> -	ret = call_fn(buffer);
> +	ret = selected->call_fn(buffer);
>  
>  out_smbios_call:
>  	mutex_unlock(&smbios_mutex);
> diff --git a/drivers/platform/x86/dell/dell-smbios-smm.c b/drivers/platform/x86/dell/dell-smbios-smm.c
> index 4d375985c85f..7055e2c40f34 100644
> --- a/drivers/platform/x86/dell/dell-smbios-smm.c
> +++ b/drivers/platform/x86/dell/dell-smbios-smm.c
> @@ -125,8 +125,7 @@ int init_dell_smbios_smm(void)
>  	if (ret)
>  		goto fail_platform_device_add;
>  
> -	ret = dell_smbios_register_device(&platform_device->dev,
> -					  &dell_smbios_smm_call);
> +	ret = dell_smbios_register_device(&platform_device->dev, 0, &dell_smbios_smm_call);
>  	if (ret)
>  		goto fail_register;
>  
> diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/platform/x86/dell/dell-smbios-wmi.c
> index ae9012549560..a7dca8c59d60 100644
> --- a/drivers/platform/x86/dell/dell-smbios-wmi.c
> +++ b/drivers/platform/x86/dell/dell-smbios-wmi.c
> @@ -264,9 +264,7 @@ static int dell_smbios_wmi_probe(struct wmi_device *wdev, const void *context)
>  	if (ret)
>  		return ret;
>  
> -	/* ID is used by dell-smbios to set priority of drivers */
> -	wdev->dev.id = 1;
> -	ret = dell_smbios_register_device(&wdev->dev, &dell_smbios_wmi_call);
> +	ret = dell_smbios_register_device(&wdev->dev, 1, &dell_smbios_wmi_call);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index 77baa15eb523..f421b8533a9e 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -64,7 +64,7 @@ struct calling_interface_structure {
>  	struct calling_interface_token tokens[];
>  } __packed;
>  
> -int dell_smbios_register_device(struct device *d, void *call_fn);
> +int dell_smbios_register_device(struct device *d, int priority, void *call_fn);
>  void dell_smbios_unregister_device(struct device *d);
>  
>  int dell_smbios_error(int value);
> 

-- 
 i.


