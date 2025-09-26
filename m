Return-Path: <linux-kernel+bounces-833982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A1BA37D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB736280C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107312DC77A;
	Fri, 26 Sep 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9f7GT05"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7496288C8B;
	Fri, 26 Sep 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758886147; cv=none; b=SSYeE7aCasp/gTRTNexRn8GVGXhfUwnyjBitWCXnHIbs4IuIMEFEi5HHuLQegzaJyI8N+3sUDqR0IWV6hQWji+PoP4OAcBua2koUp/UyJTyTtp2oe3rUth8LnAh5HxSQNM4J+ayP4KS8exxigmwc0uEA80AJQPLSLncVhJzoSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758886147; c=relaxed/simple;
	bh=stTEul6UHVCiJ8ZlGVsirQ38l3hkR1WGDcoE710mSGU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mt76iEi6Tb7mAaeVpVlu8DDMsde9PUAtBBkDt8pY0jjzKoAURcdlbdx+n+7wzkAzrKDvKYyXtQdcspYa6y/D8BvhJIqLBjWjA0idJT4zOghwK3P0+AkgKLc+rQx5hvEoQPsQ4UJ1IYoSWA+rauNB0okxFOHHgCQUOE0KkadfVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9f7GT05; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758886146; x=1790422146;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=stTEul6UHVCiJ8ZlGVsirQ38l3hkR1WGDcoE710mSGU=;
  b=J9f7GT05qr3BMvkzxEkfTk8aUE6EGHCxmHfcvqQFb1K4LFHo0rvS4tSC
   0UFF7enm8u2+ariwEmeO3Z7MhPKU3sVTYIvXBybtvGMR4WWvWy+KfM7Qz
   mHjKcsyPOAgmqyOUHSKqlPqsOm4pLQ6KKBBjVxDpZoML0ND2ycQM1LLE/
   hzoWMLkBfdluFKwayicX2bxoIAYWsshGFtT6LViZM6LJAkU6xFmfgCn/V
   vyJXMlM6drWj5EgZsjCRK/YTywCVUSfg8lAUmV0zcZ099cC8UO01Bgg3q
   6XwrQrtWyzntnGW2YRGIP/5HddxlsZ2MiDZeDNfNrzZP3kd4N6FoX/HIP
   w==;
X-CSE-ConnectionGUID: CYmNw12ySyGYwhNWgeZ8nA==
X-CSE-MsgGUID: wZ1hjEEgT3eVlcgcdMSH8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71465969"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="71465969"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:29:05 -0700
X-CSE-ConnectionGUID: H/yFh2ptQqesnMgl/rwidw==
X-CSE-MsgGUID: 6L0YMAZKRImr5x+RMHSWbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177522372"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.23])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:29:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Sep 2025 14:28:59 +0300 (EEST)
To: Chen Ni <nichen@iscas.ac.cn>
cc: sre@kernel.org, Hans de Goede <hansg@kernel.org>, 
    bryan.odonoghue@linaro.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform: arm64: thinkpad-t14s-ec: Convert comma to
 semicolon
In-Reply-To: <20250926091302.817919-1-nichen@iscas.ac.cn>
Message-ID: <e690729d-bc5b-3f9a-bfff-100545d8db89@linux.intel.com>
References: <20250926091302.817919-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Sep 2025, Chen Ni wrote:

> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Fixes: 27221f91b83f ("platform: arm64: thinkpad-t14s-ec: new driver")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Add Fixes tag.
> ---
>  drivers/platform/arm64/lenovo-thinkpad-t14s.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> index f721763e13cc..1d5d11adaf32 100644
> --- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> +++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> @@ -401,14 +401,14 @@ static int t14s_kbd_audio_led_probe(struct t14s_ec *ec)
>  	int ret;
>  
>  	ec->led_mic_mute.name = "platform::micmute";
> -	ec->led_mic_mute.max_brightness = 1,
> -	ec->led_mic_mute.default_trigger = "audio-micmute",
> +	ec->led_mic_mute.max_brightness = 1;
> +	ec->led_mic_mute.default_trigger = "audio-micmute";
>  	ec->led_mic_mute.brightness_set_blocking = t14s_mic_mute_led_set;
>  	ec->led_mic_mute.brightness_get = t14s_mic_mute_led_get;
>  
>  	ec->led_spk_mute.name = "platform::mute";
> -	ec->led_spk_mute.max_brightness = 1,
> -	ec->led_spk_mute.default_trigger = "audio-mute",
> +	ec->led_spk_mute.max_brightness = 1;
> +	ec->led_spk_mute.default_trigger = "audio-mute";
>  	ec->led_spk_mute.brightness_set_blocking = t14s_spk_mute_led_set;
>  	ec->led_spk_mute.brightness_get = t14s_spk_mute_led_get;

Thanks a lot, I've folded this into the original commit. 


-- 
 i.


