Return-Path: <linux-kernel+bounces-731428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBEBB0541B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F4D17CBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA7273D9E;
	Tue, 15 Jul 2025 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htZRJLiv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06492260580;
	Tue, 15 Jul 2025 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566858; cv=none; b=SBd+1b1qJWL9Q2viRQYqA0tCy4KHFYxBRZ2f76hfXOKZ2ehBsNUIxzHcLcf5766WoUGaY6WXOnc1Rxk6Ybsn/AaOZTqEJoZJm2KYwMCPkpk+yicqrC+M+el1mua6nsiE8xRjWOP4Ila31UtBTOGeIBVBdSV978auphkMYVVIOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566858; c=relaxed/simple;
	bh=IJ4vJVHoZ+A6xVMcRw0Zf4dAFdsqiBrU3kVHgWvPuYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpca8sfhdAF4gD2tNOb/IymkLbwk2PwlPsL9hkS2sbDUJJIoh56ZMLTpyX70s2toQ4xTHAasEWh4h84BPQ8rTMzhGKhWe0U71ytxk9yHyGI+1z83vfmRcSB7o41SlM382/U4IqzLlBNUX6S6vtDGJKRT8EUM4Jpk3MLv6OoYPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htZRJLiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023EEC4CEE3;
	Tue, 15 Jul 2025 08:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752566857;
	bh=IJ4vJVHoZ+A6xVMcRw0Zf4dAFdsqiBrU3kVHgWvPuYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htZRJLivaxtpPEH4d94f9u9mOUMp/HiK891ycTswqvGWFZoetaf+9+L1onVGxwbEC
	 Y3u561Mb0XK3qHcPTIeEmS3s27DRIVFqxB+635zY5bRrm4eHP3L9lsy5G44eoxyO0i
	 5PVi96HGTi1axxBpFgA4Y2vdz3Yjb0WVIekTM2WNWNfSJ7Z/LefxI8xK5gzl4NzPPJ
	 lacs4rGYCs3dozWT8GOUvwvYzCX04y/xKDtEn2IYghC4CKMayct73zxQAVOObTYCZk
	 GihvAZpaGuCuSyhF/7ebPBly70AdBc5taq4Vse/inCEyMbOAxwHXyx4o9aVRZmg/G+
	 SlmqwoJfIpeFA==
Date: Tue, 15 Jul 2025 10:07:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Yao <richard@scandent.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Akshay Athalye <akshay@scandent.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 3/3] drm/panel: ilitek-ili9881c: Add Tianxianwei
 TWX700100S0 support
Message-ID: <20250715-tasteful-thoughtful-aardwark-1c2550@krzk-bin>
References: <20250714221804.25691-1-richard@scandent.com>
 <20250714221804.25691-4-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714221804.25691-4-richard@scandent.com>

On Mon, Jul 14, 2025 at 06:18:01PM -0400, Richard Yao wrote:
> +static const struct ili9881c_desc txw700100s0_desc = {
> +	.init = txw700100s0_init,
> +	.init_length = ARRAY_SIZE(txw700100s0_init),
> +	.mode = &txw700100s0_default_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_VIDEO,
> +	.lanes = 4,

So you did not resolve build failure report? You need to address it,
one way or another. Not just ignore.

Best regards,
Krzysztof


