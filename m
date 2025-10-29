Return-Path: <linux-kernel+bounces-875532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EBBC1936A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76AB3B97AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8310530CD8D;
	Wed, 29 Oct 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlta9mXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7EA313531
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727482; cv=none; b=DnXLclBSww66fVjn2m7uc8XXqytDVu6AmsVts7eUebggF2F5fpV/i5VM3HcUojLflQzTAhw+yagL2K/b56irnbUb9M/p7G3xCJLgyEkpS5RB39hXyPA4M+bVjPyM7vwbWpKsm1IqWEeNaGRX8YiegOJzXeW8xnxcBZg5v/Q4lqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727482; c=relaxed/simple;
	bh=f8nmQetPnoSxxV2FJKbUwk3Vl0dg0098TrP6IqOmLHg=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=ShDyz6Rzy+kSdV9mgBpSx7zP82zsWKWB5Xuiq7XKkx3h7M1RKmY3RvZB0/pHI023jh2Bs5mAdUhUVYK9zmvZ946cxojADDFA55hvGovis+JukxYUxiwmE8mzgqzamSDPJUUaMJWuBSUzZ17jImj4k6fItr7Kc+1cHsr9PdFGNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlta9mXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6829C4CEF7;
	Wed, 29 Oct 2025 08:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727482;
	bh=f8nmQetPnoSxxV2FJKbUwk3Vl0dg0098TrP6IqOmLHg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Dlta9mXpOnVGsG1fG+WZA7ex+8f2C3KCP6IbGG/lVamWQn9+BXQM4hbamIpZcdZyr
	 c2DM0Gx3YZWU1vs2+wGx0HMOQBHem6VYyJKzxdq1LDBaOHxELtwVtwN5xKIJAGmdbZ
	 IZZSSqOaeoARp6snvAnEi+zDdg509hhUeYlGmqGLC4rYbleb9XbED4Tv7EjVkg2aY8
	 vvYy26jiWaCQ9kcubKJ+Wy8IxTYthNqLJZQXgNu99DJBuLcKIWXeoown65nwvWSnLq
	 h8ll3GjqgZTrZQgRaxvlAiBv2DWvJMbvC9m73pZQSjw63MiV11XH3fKxBUo9IGEMH7
	 KInmereHO9/3Q==
Message-ID: <034612117f0147b0b8594d2e2e27a940@kernel.org>
Date: Wed, 29 Oct 2025 08:44:38 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 5/6] drm/bridge: add warning for bridges using
 neither devm_drm_bridge_alloc() nor drm_bridge_add()
In-Reply-To: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-5-bb8611acbbfb@bootlin.com>
References: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-5-bb8611acbbfb@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Alain
 Volmat" <alain.volmat@foss.st.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Andy
 Yan" <andy.yan@rock-chips.com>, "David Airlie" <airlied@gmail.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Raphael
 Gallais-Pou" <rgallaispou@gmail.com>, "Robert Foss" <rfoss@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 28 Oct 2025 11:15:46 +0100, Luca Ceresoli wrote:
> The correct sequence for bridge initialization is:
> 
>  1. devm_drm_bridge_alloc()
>  2. drm_bridge_add()
>  3. drm_bridge_attach()
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

