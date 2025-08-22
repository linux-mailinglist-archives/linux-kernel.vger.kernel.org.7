Return-Path: <linux-kernel+bounces-782448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79B8B32085
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CC0586257
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F12882DE;
	Fri, 22 Aug 2025 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEDfaPC5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C442874F0;
	Fri, 22 Aug 2025 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879938; cv=none; b=BMFdug/DlLajVl5Wm7+3pakSjbls8cNVXsAb14TkMhgN/TqaAomP5z/grPbSmgT7ozBDQjtFooJI4DH7P6OuVh77de31Uhj40L0cuSckHekSGRRCfoqIcFUi+xU4oR4Cn/IvkCG1ennVDNqmqu7sRtKgM4bUtJbaiigBB7DcS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879938; c=relaxed/simple;
	bh=Nex48aIDk1j8bD/co9kBtGCIGQ1+WTl9k9p2q0c2jXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFqdNGbBKWQ7jjhKF+XIWICYoDbsrLooX5RLufyc719gQZX7tl447w8+w9sZ3vtwSXhrBlOvi2r93QyPzaIoVoBj8oLJFoRSpN6BrgcAtGCNBrNBqsCM0nwEuWjgeS/7JSjLK/8sE7mJnfLyvT2lsv6F30ll6ZYsUgfjEg9aQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEDfaPC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498F6C4CEED;
	Fri, 22 Aug 2025 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755879938;
	bh=Nex48aIDk1j8bD/co9kBtGCIGQ1+WTl9k9p2q0c2jXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEDfaPC5yXFWTh03301m707/qLr5PrBs3mpPy0RS4TM4y4CFH+V4fYu4e+7Z1TvNx
	 WCS8+P8GrxHh4WR8Ftm3DYSMOR5li62ObmFyVMU0aVFW6mFkq5CkmkqgmvC3pHKu9D
	 E/bK0yWf/MQNBGgfR/nU8LZw4DOzkXd/955YD8JcZCGDPr9EVdhKKgnO3t9ntziIxZ
	 2828Uh9FCa5JK6GdMHVJHAHSptW/qSEp7ZkNq0+CHhi/i1VEn0jyTyRFKaNWpxAMtq
	 navhaS5gSBpkDTokJDoUfkvPblq7IChIjEgRDsUTP3OLSgimvmNKhPUgLO/he7DKKb
	 bIpp63ueq6/iw==
Date: Fri, 22 Aug 2025 11:25:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, imx@lists.linux.dev,
	Maxime Ripard <mripard@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] dt-bindings: display: simple: Add JuTouch JT101TM023
 panel
Message-ID: <175587993686.3971718.4392476548821514847.robh@kernel.org>
References: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de>
 <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-2-b492ef807d12@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-2-b492ef807d12@pengutronix.de>


On Thu, 21 Aug 2025 09:55:29 +0200, Steffen Trumtrar wrote:
> Add the JuTouch Technology Co. 10" JT101TM023 LVDS panel.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


