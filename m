Return-Path: <linux-kernel+bounces-738497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3114BB0B92D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7868A3B4D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 23:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7770922D7A1;
	Sun, 20 Jul 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBvQUalO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402EBA27;
	Sun, 20 Jul 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753053597; cv=none; b=dpqWNbSdR0yHcD0w6titvTtPiPaC+lU6lNI4YAVWD1RLBQBPvNfMT9qReGJYNj211mkcKxBHIkQ9ylUQ0LAKpyeQP6pweiSimt/mmVnwTirqI6Ek0KOnj4R62ScVnPnohyk8Blijj9IPXSNIVMoMFinY49l/KmJ8DwrSAAgY4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753053597; c=relaxed/simple;
	bh=wVP6Z5f3CrPZapJWrOI/gGK/1g0Dd6+93XEM5STFPvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsXvfwzJkv4QZ+8PqU2eWjy29QDURae9sq8WHIzWzG75YEyAielkRwbV9Y5zqLbdrqtyPJbHcgTplEraPrHamdFoZZyQELlDIh9HWZDm6uS+yqfMCeeJ57c+fEsoRsIrOr+TBgi05J3gi5rR1TdIclc9OKbDxi4FA6OyX74qXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBvQUalO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF8DC4CEE7;
	Sun, 20 Jul 2025 23:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753053597;
	bh=wVP6Z5f3CrPZapJWrOI/gGK/1g0Dd6+93XEM5STFPvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBvQUalOB1OsRlwAFKLx16AuV2nIykJ7sogpc3QGHUvaHinHxByeixDl9cMxQLMhw
	 q6NWYjlQDWM5Wy8l1QOLfVA3Icfqe1PpsQ6zjozz8iGk1m3PiktL9Imtmrn5F9xXm2
	 51JBEmP95tB13ZW/oxRyWlmtcnyNKlsBFDdCl3/aqPp6JQMYobVEjJ8qGVg4WGm78u
	 9aZkIScTC7ee6L5V4OX/6+DahsTXxyB0CYFMfZJ8HqDiw/jFWWxc7QZhFLQXf9MIvQ
	 ppe4ne0gwdnixA+Nyc4I+oSGF5J/jBwwFehkv9PSTTYsDQQY50/QZgE13sTNWrACDK
	 rUQan6BEuK0zg==
Date: Sun, 20 Jul 2025 18:19:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@cherry.de, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	damon.ding@rock-chips.com, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: add RK3588 DP carrier
 from Theobroma Systems
Message-ID: <175305359610.3055587.5271062385138916700.robh@kernel.org>
References: <20250716185027.2762175-1-heiko@sntech.de>
 <20250716185027.2762175-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716185027.2762175-2-heiko@sntech.de>


On Wed, 16 Jul 2025 20:50:26 +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The DisplayPort carrier is a very simple baseboard only providing serial,
> ethernet and a displayport output.
> 
> But its main functionality is that it routes the Analogix eDP controller
> to this DisplayPort output, which allows to test that controller simply
> by hooking it up to a suitable monitor.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


