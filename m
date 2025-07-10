Return-Path: <linux-kernel+bounces-726555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1246AB00EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DF618887B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE902980D6;
	Thu, 10 Jul 2025 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSEkg1r5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9414884C;
	Thu, 10 Jul 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185978; cv=none; b=kRFaTGHpbOK3iV6kHgDMfS+0Tu0itsOy1/wIz1uJVo1BJZCnMP5oYtdNjXEey+247YWA6wpAS9f6y7FdVvCjCHdp+f0x1H+YpPicqlWi0vzfiDUPhzxzH9TkWXrNengAaL3O+mjq5wNS1o6crWYKusgaFgwk2WRAWdVUmczP/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185978; c=relaxed/simple;
	bh=qWJ9OuQImauUF3Zjux87h1FusUr34Lwz8v8vuFD8Z9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk9W+5j5+tFpersmdwUUtF+bd0liZNxwyDqc7wa1wTJTIpJxx3aCD21aJz9swqDM7CgkKgos2WfbjnU3OiUcZPVuxh+6/S8h09meBwt0d3ymZLQg0HkR5fc/j3H3JY2xL63Yw9YpkOek/6EWXGn8q55LlVUJzPOKLTRQbaV8HMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSEkg1r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A0FC4CEE3;
	Thu, 10 Jul 2025 22:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752185978;
	bh=qWJ9OuQImauUF3Zjux87h1FusUr34Lwz8v8vuFD8Z9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSEkg1r5k9u8Rf86Fq+1vnxiZw+blZLEXki4fYuI3RS566yZT0ufwm0d0dpuhAoro
	 fWOGdRFPA77cKUV6mh/hRDw2xSvXAaqoDXF4pGkEEDxYFVtJ12f/uAcDSiAw+KIx36
	 jmAS4UlN9Td6wVH1XwEr9g5bgxQR0qCxkCnn4SQIxJasEQyk/sZvCALU/uD7hWCXpi
	 uOEmoF9QIrewUGnT3IpBRkzKE0g3W7r+xUeHeca7wcDxIUJCpYq9oxFmzlDkjy2uYG
	 6TDoRUSAKCizYzzSDS7KktmfGOztHwjF54DFqCQ9l93ZDZtVYC2RDuWqPmnyaiYcqP
	 XWdcgv7D+RQRA==
Date: Thu, 10 Jul 2025 17:19:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Johan Jonker <jbx6244@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v4 03/10] dt-bindings: display: rockchip,dw-mipi-dsi:
 Drop address/size cells
Message-ID: <175218597662.4163951.14813766986445272508.robh@kernel.org>
References: <20250709132323.128757-1-didi.debian@cknow.org>
 <20250709132323.128757-4-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709132323.128757-4-didi.debian@cknow.org>


On Wed, 09 Jul 2025 15:15:16 +0200, Diederik de Haas wrote:
> The "rockchip,dw-mipi-dsi" binding has allOf "snps,dw-mipi-dsi.yaml"
> which has allOf "dsi-controller.yaml", which already has #address-cells
> and #size-cells defined as '1' and '0' respectively.
> So drop this re-definition.
> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  .../bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml     | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


