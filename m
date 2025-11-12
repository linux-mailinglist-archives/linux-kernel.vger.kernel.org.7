Return-Path: <linux-kernel+bounces-897208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C57AC52476
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64A954F258B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B34332EDA;
	Wed, 12 Nov 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ybk00gx5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275AB31A7EF;
	Wed, 12 Nov 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950753; cv=none; b=aeSbxbaANdNEHEce8a8Nre0cZOBHxbSSM1J7hCV/5P5vCgbWCBU4BZocU6J21yO7OrKv6pYkszf9cqt3Rb8kUqelywHJ9H//bVOWkL/j4BAZPA1/Rpv+kQwqH4wpPCloEdccWPqYPi49v7JvgLZUVdYjJnKIrHHHGc/niGB6kXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950753; c=relaxed/simple;
	bh=NCzqZWCk0yEyq1hkf1ySho141jZpTXPjv/dbqkj15qY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=giwnhSVu650bPVT8fWyyI7KwQ84jemqgsd3hD1/9fMiSG0PJPnqu7B1yIXlloob8NOCm3b+je2RYDm+4/ypVZeZFgaDp5j35lrxyqtsZHf3YzBXI2PTOMQgEmvIXF7/ryepJsfuHq+tLRy2dVzBDCDWXC6cHsa8FmL4C+GqD6Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ybk00gx5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762950752; x=1794486752;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NCzqZWCk0yEyq1hkf1ySho141jZpTXPjv/dbqkj15qY=;
  b=Ybk00gx5rZOQSUGXWDD19OP//BUtmOvCrYukqt/0HfOHmjHyIO35mZKn
   lmPSqGzUNoXFXpjgryw1bE7r4J1mzmNv1xUF7KkekXLKTN/XKv3i/3xML
   4K9tzAHJ04X+cvNZoARyysgwghSumvmLVQXlZG68O1DowTeD2TY7qrz6g
   cgDcTIDdGK2B9NMPD6xt21zRY2iEtdrwAIXtoex898mx6HJoVZwaqdvmC
   xNXcmlnAYLEotrymFnLQmHatwnymRPAp6MjcC//nui+60oX7mDlqfbI+t
   CCMaXx2UlGNMgQ4BiDgK0MZ38u374W9mKnHg3Q4tH6IpotDpiDpVmAxnu
   w==;
X-CSE-ConnectionGUID: 5SkU8W2ORx2XYDc/2qHREw==
X-CSE-MsgGUID: pZ4HN6gtSXSe+SfzOKDw0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64937627"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64937627"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 04:32:31 -0800
X-CSE-ConnectionGUID: Ryin6FFnToq3HVrNrRmCRQ==
X-CSE-MsgGUID: c7cPIlz1Sqm4uqKNnXFAaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="194403759"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 04:32:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 12 Nov 2025 14:32:22 +0200 (EET)
To: Denis Benato <denis.benato@linux.dev>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hansg@kernel.org>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com, 
    Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: asus-armoury: remove unused macro
 parameter
In-Reply-To: <20251111191104.1401105-1-denis.benato@linux.dev>
Message-ID: <a488f1e9-11f2-d6ca-49a6-91eac3c3a053@linux.intel.com>
References: <20251111191104.1401105-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 11 Nov 2025, Denis Benato wrote:

> Increase consistency of macros used to get/set uint attributes: remove the unused _fmt macro parameter.
> 
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/platform/x86/asus-armoury.c | 4 ++--
>  drivers/platform/x86/asus-armoury.h | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index d57fbb5dc3d3..9f67218ecd14 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -527,7 +527,7 @@ static ssize_t gpu_mux_mode_current_value_store(struct kobject *kobj,
>  
>  	return count;
>  }
> -ASUS_WMI_SHOW_INT(gpu_mux_mode_current_value, "%u\n", asus_armoury.gpu_mux_dev_id);
> +ASUS_WMI_SHOW_INT(gpu_mux_mode_current_value, asus_armoury.gpu_mux_dev_id);
>  ASUS_ATTR_GROUP_BOOL(gpu_mux_mode, "gpu_mux_mode", "Set the GPU display MUX mode");
>  
>  static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
> @@ -561,7 +561,7 @@ static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
>  
>  	return count;
>  }
> -ASUS_WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGPU);
> +ASUS_WMI_SHOW_INT(dgpu_disable_current_value, ASUS_WMI_DEVID_DGPU);
>  ASUS_ATTR_GROUP_BOOL(dgpu_disable, "dgpu_disable", "Disable the dGPU");
>  
>  /* Values map for eGPU activation requests. */
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
> index 5e1ab729277a..8f7e5da087a6 100644
> --- a/drivers/platform/x86/asus-armoury.h
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -81,7 +81,7 @@ ssize_t armoury_attr_uint_show(struct kobject *kobj, struct kobj_attribute *attr
>  					_max, NULL, _wmi);			\
>  	}
>  
> -#define ASUS_WMI_SHOW_INT(_attr, _fmt, _wmi)					\
> +#define ASUS_WMI_SHOW_INT(_attr, _wmi)						\
>  	static ssize_t _attr##_show(struct kobject *kobj,			\
>  				    struct kobj_attribute *attr, char *buf)	\
>  	{									\
> @@ -101,7 +101,7 @@ ssize_t armoury_attr_uint_show(struct kobject *kobj, struct kobj_attribute *attr
>  		__ASUS_ATTR_RO(_attrname, _prop)
>  
>  #define __ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)\
> -	ASUS_WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);		\
> +	ASUS_WMI_SHOW_INT(_attrname##_current_value, _wmi);		\
>  	static struct kobj_attribute attr_##_attrname##_current_value =		\
>  		__ASUS_ATTR_RO(_attrname, current_value);			\
>  	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
> @@ -122,7 +122,7 @@ ssize_t armoury_attr_uint_show(struct kobject *kobj, struct kobj_attribute *attr
>  #define __ATTR_RW_INT_GROUP_ENUM(_attrname, _minv, _maxv, _wmi, _fsname,\
>  				 _possible, _dispname)			\
>  	__WMI_STORE_INT(_attrname##_current_value, _minv, _maxv, _wmi);	\
> -	ASUS_WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);	\
> +	ASUS_WMI_SHOW_INT(_attrname##_current_value, _wmi);	\
>  	static struct kobj_attribute attr_##_attrname##_current_value =	\
>  		__ASUS_ATTR_RW(_attrname, current_value);		\
>  	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
> @@ -227,7 +227,7 @@ ssize_t armoury_attr_uint_show(struct kobject *kobj, struct kobj_attribute *attr
>  	}
>  
>  #define ASUS_ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname)	\
> -	ASUS_WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);		\
> +	ASUS_WMI_SHOW_INT(_attrname##_current_value, _wmi);		\
>  	static struct kobj_attribute attr_##_attrname##_current_value =		\
>  		__ASUS_ATTR_RO(_attrname, current_value);			\
>  	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
> 

I've folded these into the the original commits (to the 2nd & 9th change).

-- 
 i.


