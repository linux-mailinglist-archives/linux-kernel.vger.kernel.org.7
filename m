Return-Path: <linux-kernel+bounces-854047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7FFBDD6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8392C4FF276
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34A5304BBA;
	Wed, 15 Oct 2025 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cB1j6glI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4822BDC35;
	Wed, 15 Oct 2025 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517053; cv=none; b=cbKIfZ041y5wewX+WLVFKVxjd6aqGx209lyzAJ0vp10bgAjeql5Xr31wvM5BG4LR05OoGs3eL5T/yE5YZBXcCersTpVzjcZc7N+wzJNN60+oaMg5BhuAt7WWltALxG1ny8dV50QiqiL9fhgVf4LCxcFyPfbjNH7faDSHSYBxL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517053; c=relaxed/simple;
	bh=EjMEQAUGkeV9NsapertYUP+tYeH+p+7ZUUvIyIsr/i8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bBbCOW4iXQiisE87p4UGbo98yFlTBzqvlJdv6B9di8gJ3cgwxzYTd/6uTHtwfErF3yNBEtDjlMoeM2AWqzsUI2FS4F96hz13B9kLOzQvqKSCyxyTGDKp0pvpEPbUZJxSvWOHxI5VHrh4XqFQd+4sFjo6C0qviG28kUhAnpFn5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cB1j6glI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760517051; x=1792053051;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EjMEQAUGkeV9NsapertYUP+tYeH+p+7ZUUvIyIsr/i8=;
  b=cB1j6glIIqqX83Xdjd1jRrJDXjW9wgixQLmlI/KXIDZU/dT9uCOpNDcR
   SvIzj2qtBDVBVGduYGjh8jFfWDNeKfuZ/2ZEb/pMt2LSGD3gVB0U51sXc
   mJ9V4K3Ipx2RV9Buc3jI3SiUf3u/xSM6/f9cCQmhrnPjavOjTieIW7CVV
   Vh4r2d9tH5aILgcO760jWtnfZfGnmQ/gRuMxzNj0owusECWi0nR1VHXZf
   L9YWcOSKdwwyqbIbc6bpCL2+CakPXDxERMj4WzATbGDI2n8qkpYL8tEMm
   /F7Bmboc9YoLqL9k6+UH78FuoDy0jgEyznhotgxQ5GmFSmABSfKYrA/xa
   A==;
X-CSE-ConnectionGUID: WtAfYT1DSk6L4SF3OUTufw==
X-CSE-MsgGUID: TzA+zhkOQnOOCkwpuIjBlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="65306422"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="65306422"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:30:50 -0700
X-CSE-ConnectionGUID: 1XMAdwpbQA+D3ZICjtKeKw==
X-CSE-MsgGUID: c4dxnFMmSEqNGyo7Q0wfbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="186525457"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:30:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 11:30:44 +0300 (EEST)
To: ston <ston.jia@outlook.com>
cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: huawei-wmi: add keys for HONOR models
In-Reply-To: <OSRPR01MB11808FC73C557CED90DDD839996EBA@OSRPR01MB11808.jpnprd01.prod.outlook.com>
Message-ID: <f609dd82-2cd5-cef4-746b-10dfd59380fc@linux.intel.com>
References: <OSRPR01MB11808FC73C557CED90DDD839996EBA@OSRPR01MB11808.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Oct 2025, ston wrote:

> HONOR MagicBook X16/X14 models-

That dash seems misplaced in middle of a sentence.

> produced in 2025 cannot use the print key properly.
>   (input input25: Unknown key pressed, code: 0x028b)
> 
> This patch fixes this function.

Please use more precise wording and avoid starting with "This patch" (or 
similar phrases such as "This change").

> 
> Signed-off-by: ston <ston.jia@outlook.com>

Please use full name in sign off.

> ---
>  drivers/platform/x86/huawei-wmi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index c3772df34..d3b7b673d 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -81,6 +81,9 @@ static const struct key_entry huawei_wmi_keymap[] = {
>         { KE_KEY,    0x289, { KEY_WLAN } },
>         // Huawei |M| key
>         { KE_KEY,    0x28a, { KEY_CONFIG } },
> +       // HONOR keys
> +       { KE_KEY,    0x28b, { KEY_NOTIFICATION_CENTER } },
> +       { KE_KEY,    0x28e, { KEY_PRINT } },

You only mentioned single key in the changelog but are adding two here?
Please amend the changelog to cover the changes fully.

>         // Keyboard backlit
>         { KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
>         { KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
> 

-- 
 i.


