Return-Path: <linux-kernel+bounces-827862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1AB934C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E001908313
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0F2FD1DA;
	Mon, 22 Sep 2025 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le7ez/gb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142932EA75C;
	Mon, 22 Sep 2025 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574569; cv=none; b=Q5xRsTWyPB4pEoMg4CcUN3EhFUxQDq02PEOYZYO3PccSCcWcQVzediSEMtfcDV6FH7Ifsfo2aV0WM4mrdOdl4V3PXvT4MpP43Gb98QuZnDonAdsVdV4VV+rNxZeZ/o7SZRSHbF6LKxDgGk7soiCDKDj96AYj0MZmroxXw44lYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574569; c=relaxed/simple;
	bh=lA0I4opGxZhQyjvHJkWoV1rrN874cWsCfYAyg+K+GmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn07jK7+dJzUtbQ30kYF/DwjsqGbPwitK/sMJorVkRWMLTgUbnNBjHfgFXmjK28D5l7tVfdghj65Njsm9ahCTq+qf0Hmi85bkJamYb015otHo/s+jl7752XSUH6816815ReSNRIhVOdpG58IaBciZ9FA9lm3DaaHsRqY6iGc/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le7ez/gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B59EC116C6;
	Mon, 22 Sep 2025 20:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758574568;
	bh=lA0I4opGxZhQyjvHJkWoV1rrN874cWsCfYAyg+K+GmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Le7ez/gbtNl0rwXZOciHgorHo1T/mjXDa7Sqb5DGeFMvXPlU1fXY7fFL2EXP4MATJ
	 k4JMAcimAtW56q5h4mEmqv+lZ7CZZgAfTMJPq4aENh/BvRSFtwSmovxi4P8pPlTQuk
	 Uo39ZFhQv7ro1ce9AbxBovRAWMH/wfbZOoqsUozJgkGTwVCv7uasDxxOF/3mzKnTjb
	 wdaO43fS/kAsageKBUaOl9+vxC7Xby2vxT+TqWKiWvTqSfmMTlG1g2BPm4KSMUpM9y
	 dU2JSUWyjRb/o8hIhp8fsaBlxgADVXWQyHTpLwAEe9WsK0J2CKHrbLhz3fVHIF7Hm4
	 P8tbpW1uO6SuQ==
Date: Mon, 22 Sep 2025 15:56:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tianling Shen <cnsztl@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, linux-arm-kernel@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi
 R76S
Message-ID: <175857456614.1309030.10386435757239530357.robh@kernel.org>
References: <20250922091509.2695565-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922091509.2695565-1-cnsztl@gmail.com>


On Mon, 22 Sep 2025 17:15:08 +0800, Tianling Shen wrote:
> The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
> device with two 2.5G, designed and developed by FriendlyElec.
> 
> Add devicetree binding documentation for the FriendlyElec NanoPi R76S
> board.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


