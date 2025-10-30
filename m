Return-Path: <linux-kernel+bounces-878322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F30AC20445
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 086AF4EC6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D76E2459FD;
	Thu, 30 Oct 2025 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cv7oinAD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A623D7C6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831308; cv=none; b=od7PFTO36LE6n6Kf8qiQJ0yt6v9T4aqDQ2IAEbAMJi/kNh4zo3YVumVjfkEBVaYcZMh7c1YP8kTZFHHnTY1s5cNusyay3FeEPoG+AGycZtTAWHRrLPf/sO1EAe3WvsG6Te0wLiyFHgZN0vo5luLeIZ8IJMsfJSo8NsSFCLw9gkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831308; c=relaxed/simple;
	bh=CUS6P0a7OXqnVNviu3Le+Ik0LGNcmg5z2orr5NFcB5Q=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pdyqO0AggLFng1Wuu82cM+GAjFx996RILRFTRlSnL/mI1p7UxK5N9ulFLhrPZ8s2YK0Nwb6P/04grc6H1qwoo5SGLE6BlG+eYenFobJQY4CbV6l5kiavxH7Bk1dNda6pOWnCSrV0Cox9GK/H2rnMiRf3h/wQaHCS3vNaL+tpUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cv7oinAD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761831306; x=1793367306;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=CUS6P0a7OXqnVNviu3Le+Ik0LGNcmg5z2orr5NFcB5Q=;
  b=cv7oinADWi3Sqj9cQs0BnmqzJwttFU8f+kHw6zWi0utCmWsAGU+wgZG4
   +EWV4hku6pLePa6fiSI8kRFTbJBHY4BIVzFfBWQr+VjiaN3MwifGZPrV/
   nS98uNWuMk7fOei00Plrs8tdcPQ6fyc3JvuO1W274sPKf6WAK9jMpLJXl
   MTt4NA1IZJPbulpE50m9qPmJU2I/uJFipzc+Go6sq+7pPRJ2Dewkbz4nb
   IfW8m3PSlAFuUtuKvWhIz7RAmKBo38QsosBm0fdbcoZAHI5odvTaXpzhz
   ckUguLDMD+z2K7PwLkIH2Fs6U3b67GMXKysdn2nc6dqG7bUFvWqOTX+VP
   Q==;
X-CSE-ConnectionGUID: Rc7/qgdsRXuGASZXkueiSQ==
X-CSE-MsgGUID: 8tY0/KLlT8Wf8ckaSkma4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67624973"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="67624973"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:35:06 -0700
X-CSE-ConnectionGUID: 5mX16E1tTk+Rb+BWaAghMw==
X-CSE-MsgGUID: erC500p0QECr1z4wbGOz0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="223177427"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 06:35:03 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: zhangzhijie <zhangzhijie@bosc.ac.cn>, zhangzhijie@bosc.ac.cn,
 wangran@bosc.ac.cn, zhangjian@bosc.ac.cn, daniel@ffwll.ch,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Support Intel Xe GPU dirver Porting on RISC-V
 Architecture
In-Reply-To: <20250715061837.2144388-1-zhangzhijie@bosc.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250715061837.2144388-1-zhangzhijie@bosc.ac.cn>
Date: Thu, 30 Oct 2025 15:34:59 +0200
Message-ID: <08cc7457a13e434832389d63d73f1df804ae1a2c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 15 Jul 2025, zhangzhijie <zhangzhijie@bosc.ac.cn> wrote:
>     inb/outb speccial wire not support on other ARCH.
> Should detect whether arch platform support or not.
>
> Signed-off-by: zhangzhijie <zhangzhijie@bosc.ac.cn>
> ---
>  drivers/gpu/drm/i915/display/intel_vga.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
> index 4b98833bfa8c..5e48e3282670 100644
> --- a/drivers/gpu/drm/i915/display/intel_vga.c
> +++ b/drivers/gpu/drm/i915/display/intel_vga.c
> @@ -33,6 +33,7 @@ void intel_vga_disable(struct drm_i915_private *dev_priv)
>  	if (intel_de_read(dev_priv, vga_reg) & VGA_DISP_DISABLE)
>  		return;
>  
> +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
>  	/* WaEnableVGAAccessThroughIOPort:ctg,elk,ilk,snb,ivb,vlv,hsw */
>  	vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>  	outb(0x01, VGA_SEQ_I);
> @@ -40,6 +41,7 @@ void intel_vga_disable(struct drm_i915_private *dev_priv)
>  	outb(sr1 | VGA_SR01_SCREEN_OFF, VGA_SEQ_D);
>  	vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  	udelay(300);
> +#endif

This should be abstracted to a separate function with the
#if/#else/#endif choosing a different implementation of the function
(empty stub in the else branch).

>  
>  	intel_de_write(dev_priv, vga_reg, VGA_DISP_DISABLE);
>  	intel_de_posting_read(dev_priv, vga_reg);
> @@ -80,6 +82,7 @@ void intel_vga_redisable(struct drm_i915_private *i915)
>  
>  void intel_vga_reset_io_mem(struct drm_i915_private *i915)
>  {
> +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
>  	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>  
>  	/*
> @@ -95,6 +98,7 @@ void intel_vga_reset_io_mem(struct drm_i915_private *i915)
>  	vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>  	outb(inb(VGA_MIS_R), VGA_MIS_W);
>  	vga_put(pdev, VGA_RSRC_LEGACY_IO);
> +#endif

Ditto, but you have the function already.

>  }
>  
>  int intel_vga_register(struct drm_i915_private *i915)

-- 
Jani Nikula, Intel

