Return-Path: <linux-kernel+bounces-893154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5047C46A85
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF111888534
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019EB30E0F6;
	Mon, 10 Nov 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1h2Bser"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413E30BF77;
	Mon, 10 Nov 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778343; cv=none; b=uxJCD8sdkVQOHj348DRmUzWmX2SAvz6FAagTvxQXsTYbFlowoNzt1Nc1eZ874wvEjWA25WcbzJQ8QnRqeA9d7QPPsbSKh9eLl/6A5PLZYVb6MISavLLcvS7VKOcwFGMfLUSMCxpVHpwbgNXsqx+IAgz1lSc2s/RWRvKlnqv0mVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778343; c=relaxed/simple;
	bh=cyd/HokQ3LboIHX5k9KD1bhTFpADMt86OvrjFVV8VbM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QXqR4WFbJi0MP9l+TDIwlAwCo4qLka1VZ45zisZkW6xaV0S1ZAwSW+wt3TAhpz1NWDGNKzLmc6wbdbCRrlXp7njq4CYXHKuV0sMkTKsDlY6H7vDhX0hLacWLpMKF77Alh3YYAODHqssNIPLWsM/yBruwlqtu06hgq5239dwRTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1h2Bser; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762778341; x=1794314341;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cyd/HokQ3LboIHX5k9KD1bhTFpADMt86OvrjFVV8VbM=;
  b=F1h2BseroUk1D/hATb53ertBrSDcr6NCye8aeVEtnH5j4HHWPySTbBxP
   Pu+oQOikgZX2nHSbab1zPNapc6NWJDQzzacleGOaPwR6l5Tc9uDVu3vZx
   RK3/ISNimdEMytD4AKqNrJ5OiNnlAMs2OSMsO8GKOAvw+RlcGxcYB4V7g
   XSfH6rMGm7/snJPR3LqidwksrwRYu612ijDMgzO2cCCDgq0bBgwLJ4JSY
   otDG+64ytd7U4/3zQawrrRrnkWiDX1YVgpV0nUCdaRrMNr5UZlKSaSRlY
   fTsBNG04xYKoKFtKF1dWyddrK8b9icNlAVefAANP/RA4DFmCSdA/uEGZq
   A==;
X-CSE-ConnectionGUID: xyg8dhEQRiG8BomBZCgI4Q==
X-CSE-MsgGUID: vgtzyRgvS6C+UqKe/EJwrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64866678"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64866678"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:39:01 -0800
X-CSE-ConnectionGUID: kHUwkUgaRROLAKTSMeX+FQ==
X-CSE-MsgGUID: 9p4oXBtYRHKqpaXzuY5T/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193846944"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:38:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 14:38:55 +0200 (EET)
To: Marcos Vega <marcosmola2@gmail.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] platform/x86: hp-wmi: Moved Omen MAX 16-ah0xx board
 name
In-Reply-To: <20251108114739.9255-3-marcosmola2@gmail.com>
Message-ID: <28e9526a-9f3d-7d25-4263-4da1f8933904@linux.intel.com>
References: <63905a5b-1dc5-e0d1-6c8d-e590c7e7c7f5@linux.intel.com> <20251108114739.9255-3-marcosmola2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 8 Nov 2025, Marcos Vega wrote:

> Fixed placement of board 8D41 so its categorized adequately in victus_s_thermal_profile_boards.

Thanks. I've applied this now to the review-ilpo-fixes branch.

I ended up fixing this changelog text myself by taking part of the text 
you had in v1.

--
 i.

> Signed-off-by: Marcos Vega <marcosmola2@gmail.com>
> ---
> Thank you for all the tips on proper kernel writing, I'll try to do it properly and learn for my next patch.
> 
> v4:
> - Added trailing comma

>  drivers/platform/x86/hp/hp-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index e10c75d91f24..ad9d9f97960f 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -96,6 +96,7 @@ static const char * const victus_thermal_profile_boards[] = {
>  static const char * const victus_s_thermal_profile_boards[] = {
>  	"8BBE", "8BD4", "8BD5",
>  	"8C78", "8C99", "8C9C",
> +	"8D41",
>  };
>  
>  enum hp_wmi_radio {
> 

-- 
 i.


