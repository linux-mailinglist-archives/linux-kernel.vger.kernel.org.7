Return-Path: <linux-kernel+bounces-817115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C984B57E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F941887186
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6D301006;
	Mon, 15 Sep 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB4AXQGE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0582F618F;
	Mon, 15 Sep 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944481; cv=none; b=OqE0whzb0h6NkQ7Czt/zTxx5OMgMoUjI/LE5Ii1tpqn0NWdcfnoVC0AUPIEAp7hNdw7x7e1drZB5uNWovntIociXLhKQtSazz36mG+NxcPS998JmXH2wJOoN54dbv0ETm+3zw1e6W9V3WcbdTke163eF7EXckSGQx4WpUc/+NaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944481; c=relaxed/simple;
	bh=XQja+r9pWH1pmAvJ3yoJnUXUELpdjU5crLCGTl4MGZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNGjlRWo6xDx/Xqxl6CgbkevC6FZVGP3KL5pk29RkMeSoTHIf3Ob+3daPubwAw1wY3MG2uqHs/e/sgLSXDnSyLMftitAHj3kSPT9wc4Nlh3BTC2vLP+exzHvyZusCwCVFzF3daYFbyHyk4CHlw+hOgkt3MEohRfukQychQqfwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB4AXQGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299A5C4CEF1;
	Mon, 15 Sep 2025 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944481;
	bh=XQja+r9pWH1pmAvJ3yoJnUXUELpdjU5crLCGTl4MGZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DB4AXQGESnInq9+Li1c4fKtX0IIAElBJuqjrRMEytH635Ne1ZA2UwbpExDWwjdZLW
	 ksjeLGhYYo0gVn+laB8i4CPnTBnMIzb8KDq+JEjAL82YYD/R731cDOSVnQXuF7bhIa
	 mDvse77MvpW6648ht5DwHLPmIqY5eWnm7MVFNOrnzbaHQ2ZSDPEz9mt/L07TzrxlHH
	 ijvCl6LRLjOICQ1v1Q0dYat2HGWFuchgQGKArmPp5SV/GH3WWhztQFSXEutK3oBOq0
	 T63Qaj2LMtoWifXQ/zKOieeohG0tMP+ijPcBxB6xDIFXcD8Ov/1wKKifqgBqdulYL/
	 e4+FlaylOs4Ig==
Date: Mon, 15 Sep 2025 08:54:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kaison Deng <dkx@t-chip.com.cn>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Jimmy Hon <honyuenkwun@gmail.com>, linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org,
	Andrew Lunn <andrew@lunn.ch>, Dragan Simic <dsimic@manjaro.org>,
	Wayne Chou <zxf@t-chip.com.cn>, FUKAUMI Naoki <naoki@radxa.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add Firefly
 ROC-RK3588-RT
Message-ID: <175794446144.2732898.9504412064423841025.robh@kernel.org>
References: <cover.1757902513.git.dkx@t-chip.com.cn>
 <27b2ce7950fdbf28c6c8404c3f8be3c1c35d6b3c.1757902513.git.dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b2ce7950fdbf28c6c8404c3f8be3c1c35d6b3c.1757902513.git.dkx@t-chip.com.cn>


On Mon, 15 Sep 2025 10:22:04 +0800, Kaison Deng wrote:
> This documents Firefly ROC-RK3588-RT which is a SBC based on RK3588 SoC.
> 
> Link: https://en.t-firefly.com/product/industry/rocrk3588rt
> 
> Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>




