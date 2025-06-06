Return-Path: <linux-kernel+bounces-675852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DFDAD03CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD0E1894294
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE828936C;
	Fri,  6 Jun 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaKortSk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F222874F9;
	Fri,  6 Jun 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219285; cv=none; b=vC59m1P0JswO0g02WF+FeWhRu0eNgnp7BRoSPZyMxZ55s7GagPOr3X438kMXT0fKz2xGgllZJAmTTaXtlyS+O3qESrhmDLOIyJXOgnFVSpczmbNejI91k84IdAXnHrSf60zYMwcAaRi2sXPeOYSXjWllT8ez329cTLKie6mD0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219285; c=relaxed/simple;
	bh=39pmQdxSkt0c2D+ArHLlW6gILLh7CUV7D7iGTD7hAkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvFIlSXDq6FTcBeoNl+YaxJVpkY+hqYikgzITZKHmdiIITG4cCJI+tyAfiHrFfCehC69L/s7ptddJOwZ9iyV6yzOLPoMqe5JpMElkcerSUne8a0fVSi+UL1TRFRWrGa7UMcqaDyefPUE1kAZeR298eo5P26xa9D6nqHUxxtF/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaKortSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB6CC4CEEB;
	Fri,  6 Jun 2025 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749219283;
	bh=39pmQdxSkt0c2D+ArHLlW6gILLh7CUV7D7iGTD7hAkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CaKortSkRTmhC6Us6hrpg+/9Ya1IpbUoxPtBDSVvmcitOIycuJoYEjZwyPadzcYmp
	 pOhAbADR15yqqgoqDo3BerzMZcTmCRuhTo0NARtpqaMfcr8pQakUIU7q/6A5NOFIjk
	 OZNbnkiEpjqaosVv66OY3u3vhoK18Pw/gr2dnLc7VDCMJD4Sr7IbDBJVdPm9J+W9my
	 wICy1VF+4Z2YfELiOMb1mMsUpQjkIkDj0evCrpVrn2sQsq5UX6E+jps0Yn/BKwtFee
	 q+uyJ+32pN6Ly8b7D25o9ugXc6dz7YffZ0si3eiNrvG75RWaumNJ0/wkbJphaVgms+
	 DlIiNdeuW83Xw==
Date: Fri, 6 Jun 2025 09:14:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Marek Vasut <marex@denx.de>, imx@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: dt-bindings: mxs-spi: allow clocks properpty
Message-ID: <174921927901.1475063.16362852854822063618.robh@kernel.org>
References: <20250528222821.728544-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528222821.728544-1-Frank.Li@nxp.com>


On Wed, 28 May 2025 18:28:20 -0400, Frank Li wrote:
> Allow clocks property to fix below CHECK_DTB warnings:
> arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80014000 (fsl,imx28-spi): Unevaluated properties are not allowed ('clocks' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/mxs-spi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


