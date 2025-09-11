Return-Path: <linux-kernel+bounces-812419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DC4B537EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328071C23B77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F03112D9;
	Thu, 11 Sep 2025 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="YzSMYxPh"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2D19D88F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604909; cv=none; b=cBLB16n3xaqVO6Fe1SkApuz+CrTIhyUsZ2S40UuFMlGJnknbio6kILrsdK31++qJpmAEOaQJPooTO9E9CSETUQ1/73bZnQfrC1MN6QX2OfklUmwrdUvPZKSKL1oklCAZPkME9OBwmxvg2YGmtqoUI0Nq3xdAvPVsXQW+AewDBKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604909; c=relaxed/simple;
	bh=sXFJupmW/sF4XBrgROax4T1of8Kr/L9ImCzyVwe9Uwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCXSV6DOzUONxZmfXt02tCPTJzHDq9TlvIVFjuoc+MIfiS/nW7lX2yPi/Zm1onqG08nBcHPXl35ab3uFnIK3u9mizHIddg325Yxo/DRdJUh5pfKBG4kPxVnrT6vqu8Un292WDJv3s6xLor+bVj2cTGn1UmkxGNYYa+DmvECfM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=YzSMYxPh; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7D2D81FE01;
	Thu, 11 Sep 2025 17:34:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1757604898;
	bh=UyweX7SE8c9CfDGXhCto/AhrdcqS5N0Mx0GHOkPY9yE=; h=From:To:Subject;
	b=YzSMYxPh8M1tJOBzz9j3MD96AcqlXsqfmaOSV3v1qUZCRub1QcVBfYLiFKjxVFpSK
	 Pvm4QXfrS8OkYYV0Ihi0lZPmowutCCzCt9lDazrvhjtrU7HRlLFw6QTbakTzpO8MxP
	 cZskO0tenr8Z4Qg65SlUg7eBAWO4cPJUh3qePcDDyJ4NAlTSvV7zhAEhlwUihtiD8D
	 3niw+e9WGsntqBGH++t/HEh6OOybQEyFVjElNj9B9d86uYuzAPe14Pld2rlRlfrUG/
	 bCkkuYP28vv7MDNwToBhF8/JK5L5UwYfLCpTkAqwr88O1ugWPNfD+xB6i99jaH2tLw
	 5jZzjnu0J8I8A==
Date: Thu, 11 Sep 2025 17:34:53 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: max.oss.09@gmail.com
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
	Adrien Grassein <adrien.grassein@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: lontium-lt8912b: Do not generate HFP
Message-ID: <20250911153453.GA80715@francesco-nb>
References: <20250728150059.2642055-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728150059.2642055-1-max.oss.09@gmail.com>

Hello all,

On Mon, Jul 28, 2025 at 05:00:50PM +0200, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The datasheet of lontium-lt8912b doesn't require blanking during
> the HFP period. Thus use LP during HFP.
> 
> Tested with a samsung-dsim (i.MX8 MM) and a tc358768 DPI to DSI bridge
> as the DSI host.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Just a gently ping on this

Francesco

