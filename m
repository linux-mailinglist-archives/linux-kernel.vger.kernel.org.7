Return-Path: <linux-kernel+bounces-738482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE773B0B8FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FD316C20C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF2D22D790;
	Sun, 20 Jul 2025 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDsGwMVL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3D1F4177;
	Sun, 20 Jul 2025 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051999; cv=none; b=DrBOrxLEoRhAT9lAd3Mp0gjzQyXhhHdqpmEFUCcFamQ3cFWPluX11KP02QII56DRNY9G4ns740D00whkwYi5WpEXiSMtvZWB9BLK+gxPjZhkN0iKXBsGD0uJf7tXDjAIN4aijJ8BxnBQ7txFJ2gXMYrGEQRXVQ9MzErE/fZ+/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051999; c=relaxed/simple;
	bh=gu826IvHRyAEWn/2JNRgozBZ7hiQUBpc3/l9ysf5qJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5dbVhyl045r6sKMtoh4fmllyyb6S47xh4vRpbAjrSjHfC8jiiC9Zff52G8+YMMImqjWUUb69+7u/m3byjcvyKCrOy8uarzifQ2kPypKIHmc4yBOXk505W2jhNOOhKtJC+I33uoymYo7jm9shVT6KNz/hdjZ93NZYntNnc9Iqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDsGwMVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0F5C4CEED;
	Sun, 20 Jul 2025 22:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753051999;
	bh=gu826IvHRyAEWn/2JNRgozBZ7hiQUBpc3/l9ysf5qJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDsGwMVLiI/LTDwH9ycnBG01VZ4rAmsujISgGH9RmHDDA9qmo8RMftEgKdWNT67L2
	 eFI/lNigL9sGmVdBpkyDoTTGju7E6s7voB6+dJW0JhAEzrocdxKVh01D+m2yEgNAxy
	 kL5ndJMIs4Jfznltnkv8ohMxjWnGfDqxihlR4U3QU91YOKf3IttWj7kUSt+nuiZa2W
	 Fr5XpRpxfQUUW6F4yLT4qHopDHxLmIWOLStanqssPXmi89Bu2OJze8is4mirxd1l0m
	 gCNn3Bv45fKjjqGxkOYBmA9e5DZFWflvdlerbtgEtr36UqCCKyGxtTiIvCK7szh8CF
	 kVHaNNgUVLqLw==
Date: Sun, 20 Jul 2025 17:53:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joseph Guo <qijian.guo@nxp.com>
Cc: Robert Foss <rfoss@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>, David Airlie <airlied@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-kernel@vger.kernel.org, victor.liu@nxp.com,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: Add waveshare DPI panel
 support
Message-ID: <175305199815.3017932.12028214384187991932.robh@kernel.org>
References: <20250716-waveshare-v1-0-81cb03fb25a3@nxp.com>
 <20250716-waveshare-v1-2-81cb03fb25a3@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-waveshare-v1-2-81cb03fb25a3@nxp.com>


On Wed, 16 Jul 2025 16:08:30 +0900, Joseph Guo wrote:
> Add dt-binding documentation for waveshare DPI panel
> 
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


