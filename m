Return-Path: <linux-kernel+bounces-890777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AE9C40E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A1C44E217F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381EC3321B2;
	Fri,  7 Nov 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8W58LpT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1092D0C7F;
	Fri,  7 Nov 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533762; cv=none; b=GY67eeyAGb5kACEbGYrsgLMi7FRqNTDLLJEF9e+2svpIdb/7VE+Iiy/XVgNb300PF/bq2a0WZKaO4X+ASuAyBgTICJ2WudIp4kfSdeOUKiCiwGxQdFrLAbzoKTO4hUmPwdZpUlkD/Qd6YL0I6/IF88w6XBpBTrKAhiKTc5I1AEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533762; c=relaxed/simple;
	bh=cUNGqivWQZkeezm2wxrTNZybyEcGSRw87en+vjf1azg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SvRa6H9s4b1NZVO1sGe+n6i3G3lmDK/iiYgcBv4NQhuKq3bA2kNuTknYkpNsNYIBy/7rkkdtJLBi/3+MVbyw36Fd+nR+2fkAI1AH2AC0kDGKL0CbVBXg0DJUqpaBcJxwJ8i5W/NtOhWl6WM5X86Y+aKVcl2NuhmdYVmINYwfy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8W58LpT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762533760; x=1794069760;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cUNGqivWQZkeezm2wxrTNZybyEcGSRw87en+vjf1azg=;
  b=k8W58LpTN7lJ5co+ql1WAoLKZe+AJmNoEqkhvRkImofZTv8TbBjN4t+k
   E5QGp5MELPURqlWOr336U89+MngCCKfxFdHKjbPsKfaj+p/nxGlSFfEKG
   zbAnjfNSNjMM63WoyetmjSiBZyZv0dgwNaTW3zAvwEmLC9d0ur+/cAAWP
   ivy/C8CXQRDPis6B/q3idOUK1VYkr8ji07QZzO+AsQn2WVmisFo/uETnH
   b2Ag+ZC7haH6B0bjhCwInocbyDfqHnzlW+cMJwf24/FFBveU+GG2UMk5G
   j11KxEUppXSd0bVeMdvZCdBshfSj7jZerFONMd9vWC1DMncYYNaIin2oP
   Q==;
X-CSE-ConnectionGUID: E1aeLFxHTQqh4j4LzszCsg==
X-CSE-MsgGUID: 2rVIfk8yQfOMpwosT/bJ9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64780136"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64780136"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:42:40 -0800
X-CSE-ConnectionGUID: jBmRBQ2SQSWovgeyl3Y7PA==
X-CSE-MsgGUID: xTy6wZN1QIO2Rf+whl6mAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="188792328"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:42:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Nov 2025 18:42:34 +0200 (EET)
To: Marcos Vega <marcosmola2@gmail.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] platform/x86: hp-wmi: Moved Omen MAX 16-ah0xx board
 name
In-Reply-To: <20251107114853.80838-1-marcosmola2@gmail.com>
Message-ID: <63905a5b-1dc5-e0d1-6c8d-e590c7e7c7f5@linux.intel.com>
References: <f89e0a02-91a2-e98c-d06a-6b7060bb2848@linux.intel.com> <20251107114853.80838-1-marcosmola2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Nov 2025, Marcos Vega wrote:

> Fixed placement of board 8D41 so its categorized adequately in victus_s_thermal_profile_boards.
> Rebased to review-ilpo-fixes as pointed out by maintainer.

This part of the submission should contain the description of the change 
(basically, what you already had in v1).

> Signed-off-by: Marcos Vega <marcosmola2@gmail.com>
> ---

This part after the --- line should contain the things you changed between 
patch versions. E.g, like this:

v3:
- Rebased on top of review-ilpo-fixes
- Fixed placement of 8D41

>  drivers/platform/x86/hp/hp-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index e10c75d91f24..47989f6a1753 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -96,6 +96,7 @@ static const char * const victus_thermal_profile_boards[] = {
>  static const char * const victus_s_thermal_profile_boards[] = {
>  	"8BBE", "8BD4", "8BD5",
>  	"8C78", "8C99", "8C9C",
> +	"8D41"

Please add the trailing comma.

>  };


-- 
 i.


