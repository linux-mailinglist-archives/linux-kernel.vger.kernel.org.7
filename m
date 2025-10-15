Return-Path: <linux-kernel+bounces-854263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478CBBDDF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BE33A6A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D89231A80E;
	Wed, 15 Oct 2025 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dM6tyRHf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D92EB879;
	Wed, 15 Oct 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523585; cv=none; b=VLkLdBgcscrDfst95LgDC68+63sOLtc5+JyrPhbpvZdpp66/A2lVa3e26E4H3orSO8hznJP99dzfaBorZV6kfhXCC1agq+sQI7jH7fpIfSt13jxBOgW/rv+7uXDx2c8q0BLAWE8WqsIu97M3mAL4I5cuGoaR9VVtQu5Rp9tT6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523585; c=relaxed/simple;
	bh=3ijCw4WQSSlLmFcVcT01fqT0RZGZh+yx2Dhcx5XK/DI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iR18NnyIx1Jo4tScEj3a+5b6LmvgLD+UdxkQbF+874SDJJIXzV85+2ZwU174bF7vz6MnWGSMJJ/Xig/WdTvs2dpgIrUR8NMZn5xEAG+OYgUkThZLSHSC50zIQj9AR/ThLHwqULAFI1rHzkMdy5nBrYC2truO6cVg+f3ukC4HaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dM6tyRHf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760523583; x=1792059583;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=3ijCw4WQSSlLmFcVcT01fqT0RZGZh+yx2Dhcx5XK/DI=;
  b=dM6tyRHf/uDcmc5pxru9jMtv4netOd/oXfWrct8f8jF2l+HEoFnwGBpo
   TjFSOWt7uZoa/xtahedki6GMx38qR5ObArhUdvcut6NTarfT+DdzDeCvO
   CtncW8suxrRTlqBx8B1W11+U5OSfAbYl75mJu1a2oWQVcRz5MtHnCmNFA
   pMq56mRCcTOuy3te1NIZZ6iQqDwivbIqBbsksdXSTBcYMyj1001+GH7vq
   9TQtg9ZhxE2ZrBIGlrZ1S8aafYKFjnOsWtEn36ortHd2rP9q5g1PUQk2i
   2i4t9KOwxornwcD6Jp2atWrTocr3U0bxlIs2hRWIlVEJj5BQVJwZCQSeg
   A==;
X-CSE-ConnectionGUID: JuwVBoKCT1mcHeNtusHyRw==
X-CSE-MsgGUID: eILa+XMQTsK/FZVtR0qPaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73373139"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="73373139"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 03:19:42 -0700
X-CSE-ConnectionGUID: 8nScVxRaTLeRptnvVwLIaw==
X-CSE-MsgGUID: PzUvp9I7REanSWGIka85YQ==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 03:19:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: matan@svgalib.org, peter@chubb.wattle.id.au, 
 Armin Wolf <W_Armin@gmx.de>
Cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251008064112.5981-1-W_Armin@gmx.de>
References: <20251008064112.5981-1-W_Armin@gmx.de>
Subject: Re: [PATCH] platform/x86: lg-laptop: Add support for the HDAP
 opregion field
Message-Id: <176052357497.21241.12485547111265092417.b4-ty@linux.intel.com>
Date: Wed, 15 Oct 2025 13:19:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 08 Oct 2025 08:41:12 +0200, Armin Wolf wrote:

> Various LG notebooks have a special field called "HDAP" inside
> the ACPI operation region handled by the lg-laptop driver:
> 
> 	Field (XIN1, AnyAcc, Lock, Preserve)
> 	{
> 		DMSG,   8,
> 		HDAP,   8,
> 		Offset (0x10),
> 		P80B,   8,
> 		P81B,   8,
> 		P82B,   8,
> 		P83B,   8,
> 		P84B,   8,
> 		P85B,   8,
> 		P86B,   8,
> 		P87B,   8,
> 		Offset (0x3E8),
> 		PMSG,   1600
> 	}
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: lg-laptop: Add support for the HDAP opregion field
      commit: 644004565d4cda479995fa9e72c00d62ca084e08

--
 i.


