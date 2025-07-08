Return-Path: <linux-kernel+bounces-722253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC987AFD6F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41484E04E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FDD221FC4;
	Tue,  8 Jul 2025 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxGJDdRt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188D87464;
	Tue,  8 Jul 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002137; cv=none; b=kcFcepTw6QrBYqbSDe7kg1jIFH1coy6rIy3xq6T5Xvr7QCioVD+voZIsBxUxl4ssrx6nwvYON0CCuFJPgn9WivN9m/03o44eHFShItGnPrys1IrFQFqjCzf8p51anFlqEdCzcl9cE5uSzFWJeULC5iSTWIripp1HiDRikyDPyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002137; c=relaxed/simple;
	bh=A6+O+gvln2Yrol59tTQtT+QZC9VvWRabJ+YozCHb+TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNcbSDPbhcc7ftdBjsLOdFs9M7lb+Pgh7phiRB+gEnhqEWVZMBS/mo3DTes2GYbjV3meQguLYC++WucZ71nWeWC81i8tiA7x0LfnuRDte4BxKzf3iGcpUvtV/kL2eCDvucLhp0sI1uAs0dvveH/hxRNpMCNAnfSO/yA+O7mOkZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxGJDdRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CA2C4CEED;
	Tue,  8 Jul 2025 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752002136;
	bh=A6+O+gvln2Yrol59tTQtT+QZC9VvWRabJ+YozCHb+TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxGJDdRtw3SthyZ35k4iEifShgaodxeQxzAJCC3uDweRovV/WE8eEhSr0YSRrZpka
	 dD9ALOZg4kaidgSgBS2kiN7T3bx+GAZRxbmW++xRNv57zbJRKR5np1MEDy6pDErpuT
	 XX9D96q/4qjzEt603eeUp1xYVsmHQdnE2xshPAFgtuvl/2IeS/9xgeTj4X18wdHiug
	 SMg4Ejwc1bUgg0v70MYh9jM8Zk0H6YDVilQDHnetq+iBMXOKLBY1BuEDwt8790suU6
	 XgRHgt24YIrZXVl7D8pntbRddj/cXIphQUs+PRdTs7GuUEpS+26jSLs+knxrOKxRLn
	 HH6gio/J3ZMTg==
Date: Tue, 8 Jul 2025 14:15:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, imx@lists.linux.dev,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH] dt-bindings: phy: mixel, mipi-dsi-phy: Allow
 assigned-clock* properties
Message-ID: <175200213291.769997.6552133008506087167.robh@kernel.org>
References: <20250707-dt-bindings-phy-mixel-mipi-dsi-phy-allow-assign-clock-properties-v1-1-5e34b257e1ef@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-dt-bindings-phy-mixel-mipi-dsi-phy-allow-assign-clock-properties-v1-1-5e34b257e1ef@nxp.com>


On Mon, 07 Jul 2025 10:47:00 +0800, Liu Ying wrote:
> assigned-clock* properties can be used by default now, so allow them.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


