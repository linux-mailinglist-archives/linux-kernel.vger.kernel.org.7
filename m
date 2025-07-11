Return-Path: <linux-kernel+bounces-727155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445AB015AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B46D3AF933
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9B23ABA8;
	Fri, 11 Jul 2025 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZM3fiGY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1A239E97;
	Fri, 11 Jul 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222048; cv=none; b=dM8ww7CdzXEDt7ZVfJHkIEWL/bfA5gKIiZ43WxifA00GUfmikCwCHihKWmv5vFjaxVqjuwPKa2zeZZoMtsuWZ0Vcvbhdn1BVyHfmTX/lRayhe4wEbHjUy8Bs30/PbVCeFcncAK9mArU8+Fxl5bBt2YusHaZ94ou6FONWLtD8ThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222048; c=relaxed/simple;
	bh=cdaXOqQf+RYrHBXTumCBfxof5X07gqf2jbXZEIVlCdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAySE3fycwxgsxdFVxAYwJ/+r0tV7DdiQfdANnTsg7ZRX8QPfWigBlOQ2cV00TmP6IdLf4dpEbOwnwzLo4rheQfafRS10VBT0wlMaxxXnYJOTndMITQdJ98GSgvTnNBxV2GYsSLzWATNVxrXay9IEOGEjzMxUTjEzgRaowWT6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZM3fiGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C62DC4CEED;
	Fri, 11 Jul 2025 08:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222048;
	bh=cdaXOqQf+RYrHBXTumCBfxof5X07gqf2jbXZEIVlCdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZM3fiGYXWni54KQ5OCCvYNGt5xxzaXnGNjgO/eA3ULRjRL0AJfxXC/hxGkVbQVfV
	 2HlidtjWETQTIjAt0hcvZ5BtWMBGIB01CELX927KIG4qoPtHEarSY+ntWXiPkzXVQo
	 JRc/FuSpCCnAxPn4976pplrbh5jHepPpo8msgMXjEEBz4jhmlH/PEQ6JOzsHOPLBwW
	 d9a4QW1M2n7ptYWow83lNcn1AmUi73lPgE8bwOm7/MnsWG9m2FfJn2dODzNYaN6GJT
	 lruUGlt9PJqOXRdFneM9I7csSRf6IaH/S8ShT1/Xp8Ou5ZC0lMQirskrFcTYmyM1nP
	 OMmoldGVY6c3A==
Date: Fri, 11 Jul 2025 10:20:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
Message-ID: <20250711-polite-seagull-of-expertise-7acdbd@krzk-bin>
References: <20250710202958.3717181-1-jonas@kwiboo.se>
 <20250710202958.3717181-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710202958.3717181-2-jonas@kwiboo.se>

On Thu, Jul 10, 2025 at 08:29:40PM +0000, Jonas Karlman wrote:
> The ROCK 2A and ROCK 2F is a high-performance single board computer
> developed by Radxa, based on the Rockchip RK3528A SoC.
> 
> Add devicetree binding documentation for the Radxa ROCK 2A and ROCK 2F
> boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


