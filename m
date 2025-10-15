Return-Path: <linux-kernel+bounces-854535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282CBDEA39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AF23B325F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADC331DD86;
	Wed, 15 Oct 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j78GEepZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32B213E6D;
	Wed, 15 Oct 2025 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533419; cv=none; b=dLVyPyxJ9j4AWp6WAhGQ1aZSzlyXwYl4JNq37m/gmzE7yUy53mTXD2RNBw2sSAPFBD1ckNRni8OqiiIoPUHZDB9WQdj/iwFReUyQgttiFkweFgJNBIOYAgqkjPP8k2Ub1Xa6v+Y6pL/r+arbOiDGV0zSdqIVv86lIdi9uqIczCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533419; c=relaxed/simple;
	bh=HhtINpPIPLb/glwrYf7B5rzF/7mG8Y33z4HikwXoA54=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KyJRojtnPWu8MPHRnZHmdNi1HDl+K9+J2FUA53RivnD0xF6P+nm3ng8sRlQF3xv6R9RMM+IHLaHpnNLdwP5do1e1mzAgqvvi6McFRY82POLsuWojJVCFmRo1NvAmc1WGCVm1GvsXQUs+TqG7uIV0fwMSMZfBX9DlKWY9csojK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j78GEepZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760533417; x=1792069417;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HhtINpPIPLb/glwrYf7B5rzF/7mG8Y33z4HikwXoA54=;
  b=j78GEepZiumCR6wvW//yUz2NXAB/MXqekrVt6TtRP9zY3J14bfj7Hf+/
   HMJEoxPsl1O6CZBTpllROR7qWfexjhFTNmSSYQhY3m1pcSSPpIwtK+Fle
   u3fSSVWltjnX+adpFcaLWupiCy/PrPJ+hjOwIIFUZN4YTXr6RDwQ9IBm7
   QvIcQ1kSINEevdB6fwuJNmVPKk8ESGjG8P1sv2D7j9TpQYTLt34LTvD9a
   CjIMhHrJ/ZFDFV5hFSdkeqbgeSTlRcLbTcz9rDDdgqsjl+/tQHz8FkC3B
   9eEKvxMoKdpUp89sRir5FH1FTEkYp00yfHT4k9iw9r/ir93d9SR34/Cbd
   w==;
X-CSE-ConnectionGUID: UWyUj9Q3RfaIMFjjb6qX5Q==
X-CSE-MsgGUID: 59SAuU4vRImAVsvC6ioAEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74047237"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="74047237"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 06:03:37 -0700
X-CSE-ConnectionGUID: r5GEHzXHRBy6V1yPhzIOkw==
X-CSE-MsgGUID: a+3Owq7+SMK0HuKTErxwpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="186181634"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 06:03:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 16:03:28 +0300 (EEST)
To: Denis Benato <benato.denis96@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
Subject: Re: [PATCH v14 1/9] platform/x86: asus-wmi: export symbols used for
 read/write WMI
In-Reply-To: <20251015014736.1402045-2-benato.denis96@gmail.com>
Message-ID: <84616b3a-0ef1-f7df-378d-834075608b86@linux.intel.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com> <20251015014736.1402045-2-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Oct 2025, Denis Benato wrote:

> From: "Luke D. Jones" <luke@ljones.dev>
> 
> Export symbols for reading/writing WMI symbols using a namespace.
> Existing functions:
> - asus_wmi_evaluate_method
> - asus_wmi_set_devstate
> New function:
> - asus_wmi_get_devstate_dsts
> 
> The new function is intended for use with DSTS WMI method only and
> avoids requiring the asus_wmi driver data to select the WMI method.
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/asus-wmi.c            | 40 ++++++++++++++++++++--
>  include/linux/platform_data/x86/asus-wmi.h |  5 +++
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index e72a2b5d158e..38ab5306e05a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -390,7 +390,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
>  {
>  	return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
>  }
> -EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
> +EXPORT_SYMBOL_NS_GPL(asus_wmi_evaluate_method, "ASUS_WMI");
>  
>  static int asus_wmi_evaluate_method5(u32 method_id,
>  		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
> @@ -554,12 +554,46 @@ static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
>  	return 0;
>  }
>  
> -int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
> -				 u32 *retval)
> +/**
> + * asus_wmi_get_devstate_dsts() - Get the WMI function state.
> + * @dev_id: The WMI method ID to call.
> + * @retval: A pointer to where to store the value returned from WMI.

Please add empty line here (or just * to be precise).

> + * @return: 0 on success and retval is filled.
> + * @return: -ENODEV if the method ID is unsupported.

%0
%-ENODEV

Return:

I've never seen it used for more than one line. It's possible (I think) to 
get the multi-line formatting with * *, please see 
Documentation/doc-guide/kernel-doc.rst

> + * @return: everything else is an error from WMI call.
> + */
> +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> +{
> +	int err;
> +
> +	err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, retval);
> +	if (err)
> +		return err;
> +
> +	if (*retval == ASUS_WMI_UNSUPPORTED_METHOD)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(asus_wmi_get_devstate_dsts, "ASUS_WMI");
> +
> +/**
> + * asus_wmi_set_devstate() - Set the WMI function state.
> + * @dev_id: The WMI function to call.
> + * @ctrl_param: The argument to be used for this WMI function.
> + * @retval: A pointer to where to store the value returned from WMI.
> + * @return: 0 on success and retval is filled.
> + * @return: everything else is an error from WMI call.
> + *
> + * A asus_wmi_set_devstate() call must be paired with a
> + * asus_wmi_get_devstate_dsts() to check if the WMI function is supported.

Please put Return: as last (again, separating with an empty line from 
the description).

> + */
> +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
>  {
>  	return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
>  					ctrl_param, retval);
>  }
> +EXPORT_SYMBOL_NS_GPL(asus_wmi_set_devstate, "ASUS_WMI");
>  
>  /* Helper for special devices with magic return codes */
>  static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 8a515179113d..dbd44d9fbb6f 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -166,6 +166,7 @@ enum asus_ally_mcu_hack {
>  #if IS_REACHABLE(CONFIG_ASUS_WMI)
>  void set_ally_mcu_hack(enum asus_ally_mcu_hack status);
>  void set_ally_mcu_powersave(bool enabled);
> +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
>  int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
>  int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
>  #else
> @@ -179,6 +180,10 @@ static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
>  {
>  	return -ENODEV;
>  }
> +static inline int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> +{
> +	return -ENODEV;
> +}
>  static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
>  					   u32 *retval)
>  {
> 

-- 
 i.


