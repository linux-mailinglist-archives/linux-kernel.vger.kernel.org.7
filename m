Return-Path: <linux-kernel+bounces-782212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A8B31CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E31A2295D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84FD3126C7;
	Fri, 22 Aug 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEyjKluO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235A30EF99;
	Fri, 22 Aug 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874106; cv=none; b=jRcE2EfCaSLXUVbrsYG1hqnB6JdF+VcC81HODd5lDekH+kG/Ad0qjGn66NXfYTFn9dyFFbzNxsrNU3Sn7YdloZ/E/ItfT9pFiLaAte0Ktxa2OdxBzEYeCuwl9YqI1kq8lFIFVOg0oqnTtrZZVc3amvzauhzBEzVHpcl2NlSKfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874106; c=relaxed/simple;
	bh=LkKrp7CULRzpmB7Oo+nw2+h0gNYKA+9aLRXVU8vBOEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXJYAGt3SQTR8SfqFTRQL5eJMaEWz8q3WFBnuGPl+XkVyBvffPLvAe59Rm6WoP27OHPcT1tHn9mu9bX0ali0DC3VvOw5PMrUxkD2s2R662zhVQStyvsM1qpRe+NUg6ZCiyDFb2eR9+CEQ7pyQX/isV4bOSdGnBzhZRhkM1+TDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEyjKluO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DFBC4CEED;
	Fri, 22 Aug 2025 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755874105;
	bh=LkKrp7CULRzpmB7Oo+nw2+h0gNYKA+9aLRXVU8vBOEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEyjKluOkgPROp9org1bWv32L7DJPVEJYdQ6Ysbpp2Eby0GVIzUqNasQ2XqCHzxgP
	 EqDJ3F2OSNWoxEeRrOKHK46REihwzbojKN6bQlhw3hJYmP6Jyi+j4ATwzTQl5dM5yx
	 Kh3lkC9RI1LKITFhDQIGsapQ8X5xe30RxswppV6d9FtDF3bZ/4KaM6r7ISJCiW99Ij
	 OOGgqdJnpwnvu1wHE9feHPL7Nm5qRwACsW33jbcNjGWNC3neAZFsCJyThMq2pDb03g
	 7h4sqO7ipnzbPCAW9OWM5+uxpWG/Lwhbg2EcT0zFErkzhXfgo8YtLuvN1JTWjLjB+h
	 PfM+3grNyiFqw==
Date: Fri, 22 Aug 2025 09:48:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Robert Foss <rfoss@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Simona Vetter <simona@ffwll.ch>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	Arnaud Vrac <avrac@freebox.fr>, devicetree@vger.kernel.org,
	Pierre-Hugues Husson <phhusson@freebox.fr>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Maxime Ripard <mripard@kernel.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: ti,tdp158: Add missing reg
 constraint
Message-ID: <175587410389.3790335.14225691250888377466.robh@kernel.org>
References: <20250820-dt-bindings-display-v2-0-91e2ccba3d4e@linaro.org>
 <20250820-dt-bindings-display-v2-2-91e2ccba3d4e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-dt-bindings-display-v2-2-91e2ccba3d4e@linaro.org>


On Wed, 20 Aug 2025 16:17:37 +0200, Krzysztof Kozlowski wrote:
> Device can be used over I2C bus, so it documents 'reg' property, however
> it misses to constrain it to actual I2C address.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/bridge/ti,tdp158.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


