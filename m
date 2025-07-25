Return-Path: <linux-kernel+bounces-746471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE78B1270F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB5D3A8DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3CB2561AF;
	Fri, 25 Jul 2025 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKK8R2+A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDF258CE8;
	Fri, 25 Jul 2025 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753484669; cv=none; b=DzaGNtPdMlmWM1ADfq9CRMbriZ6QoRXrW1UnVfwWYnuCWVcUV0vZHUXFMVlVu1aA2uXB16ztMUR2PgfQSDcXQfwvDe76oKxhqsJtxYQHL+twJslRvHolkApz3Au14TkG9XuBNtGYM4F9ujAQsB0oQMW6akTt2MI05lUKIM8sqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753484669; c=relaxed/simple;
	bh=rv/KgJ71TJlmcVVZvmym0sY0RHiUoLRxlEzbvqHPDzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyP1aSgOlQDuWWuXEF2fCWAz7GMsjvt7xHm2npgtji3JQaHc0F3flXwLD0K17TlLxy7IsbZ9S1X5Lf2RTHIx5Hkz+oCmRPrG1KLL8s7RWi6MvHB+3xCIChHm36s74+kq7lvWtEdbpYVrxhljqNHC/QzEpitiv/DlyAxCOqCtAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKK8R2+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B9AC4CEE7;
	Fri, 25 Jul 2025 23:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753484668;
	bh=rv/KgJ71TJlmcVVZvmym0sY0RHiUoLRxlEzbvqHPDzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKK8R2+AK6f9Y0S/zn5et8FKdDTW9z3REceWUn7v3RynP03t6TI55PPkjxBQJ/tXN
	 REhiNH333o/cGCi8/Hej65aWWULcZl/u0NhRx/hI0XYVrj9uKhKrf/FoOv2sTcxGUS
	 K4q1MQAZJ9OuH5CyQlEaaDgmje0Qfc2XczLRc397vBzXFKdY2RxK2z+jVUuMrIMy05
	 5BOoY15ETn2UlO1B8PwGh9q6DKOYACOqNl1dPy1TQ/gaSestfQv/woqON2QUYEK0nS
	 ODD34BiNpcqrxJRd71tIebYHtjlLaEE5gvafAleNw3KbirckCggEB+sVdcbeX4Giu4
	 jej/+NXgXlftw==
Date: Fri, 25 Jul 2025 18:04:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Vinod Koul <vkoul@kernel.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-phy@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 03/11] dt-bindings: phy: rockchip,inno-usb2phy: Add
 compatible for RK3528
Message-ID: <20250725230428.GC1993803-robh@kernel.org>
References: <20250723122323.2344916-1-jonas@kwiboo.se>
 <20250723122323.2344916-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723122323.2344916-4-jonas@kwiboo.se>


On Wed, 23 Jul 2025 12:23:01 +0000, Jonas Karlman wrote:
> The embedded USB2 PHY on RK3528 is very similar to the one in RK3568,
> the main difference being that it only uses two clocks instead of three.
> 
> Add compatible to support the USB2 PHY in RK3528.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  .../bindings/phy/rockchip,inno-usb2phy.yaml   | 30 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


