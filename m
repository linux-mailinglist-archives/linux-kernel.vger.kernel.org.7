Return-Path: <linux-kernel+bounces-775149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507AB2BBF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAED5671D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFA3115A9;
	Tue, 19 Aug 2025 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWY/tLmV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5E26C393;
	Tue, 19 Aug 2025 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592318; cv=none; b=CaDMP649jIL5rbVUploU01eWSrsfWFjA73JqW+dZjN3Gq5aIO150O8MdOLD6CYNZfl8xisWMySRsU6Zs6RuMf2n6Rd0uU5/VECWqcATO1kjTj9pdaT2UjSOYVTWbpeVV1c14xBWBpCb3AbdxVD0EhAab4/4eKVnWi6NqX2rMSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592318; c=relaxed/simple;
	bh=/TBDlG5bpgeOXcz9erypKFJjVXh1iHpqW//P2dM/OFY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ymjl4vwzmbXtct34x20hWj7gi082vSX7MjAHUthYkonV5ZmI3Cv1x1j2zm9cnaQFC/FgBPe4uBvoE1L7lDz5GHqHjVxlKC+HrQBFZZM1bKSM2ePi6ljSFCAM20cPLTM07pVVuym8+POPPqbNgtFG0mU4mG6/O2VKLExjz/Ymikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWY/tLmV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755592317; x=1787128317;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/TBDlG5bpgeOXcz9erypKFJjVXh1iHpqW//P2dM/OFY=;
  b=WWY/tLmVhkenFPYSTI0FBMBPTsH02SX/w/ZTnNUygSrDcUHqFBfX83hw
   c0+FEPmw5VMNTxgnIO5e1D3vJecZDLVvSj28oSYUdKX1dvgdv6uMbFCDB
   eg/uWeTuSqRO0N9a0N4FOxugQgDUUdxNBEveqcIyJUFAMOpH8pNM+DTBd
   42xmrF+s07/mNfHrUEowJnfpynx3WXRp+4jIyApa+3HdTeeKk0SboYKQz
   NTBcGj9KKri2hZ+RMVBK37odOPRi+43JSPlXQvh+TE2fbSgPaUscWoEuF
   wQVGDmMi/ufCun6HTlueqG5BIWzDpfTciVKdjirlyEK672DyNQR6AUAJR
   w==;
X-CSE-ConnectionGUID: 380xHIfXTkmcI+1S8b8hsA==
X-CSE-MsgGUID: DKFBIsctTxquh1VSb+YIyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="68925866"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="68925866"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 01:31:57 -0700
X-CSE-ConnectionGUID: oqNomq+pT2WwVfgNF2icog==
X-CSE-MsgGUID: wGtij9/OQbamS//FQxFMQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167026957"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.120])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 01:31:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Aug 2025 11:31:48 +0300 (EEST)
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
cc: mario.limonciello@amd.com, perry.yuan@amd.com, hansg@kernel.org, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] platform/x86: hfi: Remove unnecessary .owner for
 amd_hfi_driver
In-Reply-To: <20250725082735.2005040-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <8a52ee4f-ab2a-f9c3-9f35-d878ac3c4b70@linux.intel.com>
References: <20250725082735.2005040-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Jul 2025, Jiapeng Chong wrote:

> Remove .owner field if calls are used which set it automatically.

This changelog is too confusing, please improve. You state "if calls are 
used which set it automatically", are they used or not? Preferrably name 
the call. Please don't leave things like that hanging into air.

> ./drivers/platform/x86/amd/hfi/hfi.c:512:3-8: No need to set .owner here. The core will do it.

This looks like an error/warning message from something? Please explain 
before the quote what outputted it.

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22940
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 4f56149b3774..b633363ebf70 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -509,7 +509,6 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  static struct platform_driver amd_hfi_driver = {
>  	.driver = {
>  		.name = AMD_HFI_DRIVER,
> -		.owner = THIS_MODULE,
>  		.pm = &amd_hfi_pm_ops,
>  		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>  	},
> 

-- 
 i.


