Return-Path: <linux-kernel+bounces-736481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215AB09D66
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC4C5A0387
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D6246BD5;
	Fri, 18 Jul 2025 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhKKMwFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFE6AD21;
	Fri, 18 Jul 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826212; cv=none; b=CkMhM1hqIUUhqgjTQcOPG4CLDFNCLt9TqVCduSWazVW+YYX3p+K0ZcqE2E5LyROutcH0CZinTfkSYT6501mo3oSHtucS32EPCNHZA95Objco5K3So45mFPFpCbbsSezLmvB82bif45oDAmTmxZ5lrlU+Xr+ssbRAy3bJwUOM67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826212; c=relaxed/simple;
	bh=pYKJJ2hQUpdG2dVQ13Xx5f+NtvuXuDTByPwbcBUy+ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPYiC6XfwoVChu21FzmeMIVwwuvA0MLPX4yiXQcq+zJUK86li/MH4F3I2R10sh1B94xY0pwqwMywM7wKeMMwffTSEz9Er55j8OTAz4XsQsQs5bv4QlZL3pd4AOGDjsvQvZrFKC+18KSpULSwG8kZsFtNh8Ts+B6z0Bn+JBDap8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhKKMwFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719E1C4CEEB;
	Fri, 18 Jul 2025 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752826212;
	bh=pYKJJ2hQUpdG2dVQ13Xx5f+NtvuXuDTByPwbcBUy+ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhKKMwFU7zuaBUi4JjVCyKOTLven1T/f3a8B6gZ+ti4Ac0/5uaHiXKYRdjUuz5R8q
	 FVep+nERjFceG9fK8v6gAZYFXdfix9YEmlIlfo1+3Sk9Ivro9aDG/boJh6UbFBr+mV
	 f01GQ8YGzYPvh7ZP2c6mx+CzPlqCrRq1m3fmBV5qzHoMoJY3scMszEhYD2RQzzK+NE
	 xeitHBg5OWV5ZXrYnEGIkqZlvxHBL9CQoNJp9fvaozaZN4zW1tdNynssq9DUuIGXn8
	 oxDiTm1Id5woKqn8v1cT1OLl45daF+yZXV5Bz1goNQyl1rJvNHV/MJY6gRmAhhKRzV
	 yhsxyywjg6bFg==
Date: Fri, 18 Jul 2025 10:10:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Yubing Zhang <yubing.zhang@rock-chips.com>, 
	Frank Wang <frank.wang@rock-chips.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Amit Sunil Dhamne <amitsd@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
	Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: rockchip: rk3399-typec-phy:
 Support mode-switch
Message-ID: <20250718-psychedelic-panda-of-defiance-ef6aac@kuoka>
References: <20250718062619.99-1-kernel@airkyi.com>
 <20250718062619.99-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250718062619.99-2-kernel@airkyi.com>

On Fri, Jul 18, 2025 at 02:26:15PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The RK3399 has two USB/DP combo PHY. With the help of external Type-C
> controller, the PHY can switch altmode between USB and DP.
> 
> Their connection diagram is shown below:
> 
> external Type-C Chip0 ---> USB/DP PHY0 ---+
>                                           | <----> CDN-DP controller
> external Type-C Chip1 ---> USB/DP PHY1 ---+

It looks like your "external" controller is not described. Look at your
port property - "Connection to USB Type-C connector". Lack of proper
hardware description leads you to claim that the PHY is the mode switch.
I have doubts on that.

You already received the comments that you need to come with rationale
why making PHY a USB switch is correct. I don't see the arguments for
that.

Best regards,
Krzysztof


