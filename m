Return-Path: <linux-kernel+bounces-727157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B1B015C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E601C85B78
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6561D5ADC;
	Fri, 11 Jul 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWfNc/3I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B61FBE8A;
	Fri, 11 Jul 2025 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222135; cv=none; b=bDTmggZd7/vIcaslMSoWLsKfq1x3s+K2UOcVKeCZJnnbwyeN3KjxqJ9tpmdU9NytY6wc+qOOOqQjYRp5TlApPbxziXvw5v8ZsBiTWp9gfFYyKBrLi5Y28gQdAZhF2m0Uyvx2tZN8xwX89UB9ukY0Z1kvj0Dp2RUSbP2RvKSeNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222135; c=relaxed/simple;
	bh=V0vPUEIisTa6mtflTRv2e4S7Ta+SaccNSSFcmicIeeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcKNeGF0dI+ALfI8HDfHBSnG9/zAcgxTvoig0bHH2ri3OZELBkqr6zByA9+FbiMK0mz7qzxF7XfmMCbEvFH/1eA3IXbElkxBDf5nSPkspCBhgagh4Bsb/lPLydZ2MWX/jFBZM3Z5/iPYfpAyQCgtSS5FipGZzgq7K9IZtpY3Vcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWfNc/3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92992C4CEED;
	Fri, 11 Jul 2025 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222135;
	bh=V0vPUEIisTa6mtflTRv2e4S7Ta+SaccNSSFcmicIeeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWfNc/3IX9QBE778jmKcZgu3d3usjMtmaD3yQMlf24TBG+b7vQZw0rRe98p3QHFDX
	 lVvJdsicnnB+XJZSW7mSRjZaM26uF9Pv473eZ3sJaDx5oLYZNXj9EYByBeeRut6zdc
	 2uC3sIeXIKPrk5ixEnX90A0Ethia6GFJfqDGWvLKQJXR3csoTbnaOrCNYmBRFARR6J
	 Wu8FW1o8qbpjJXoO03NY+I/rq4GVR37Lx02kGdu/YrLBuv4PwFMppxlVJWOFW0d5jY
	 L9Hx7ru7hgoG+VR5fOjupa13qEN0Y7V7w1B75Q6vXcmPVsRMhcVXE0kx8JXCWqyRRt
	 iJBMR60kbLZyA==
Date: Fri, 11 Jul 2025 10:22:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: rockchip: Add FriendlyElec
 NanoPi Zero2
Message-ID: <20250711-jumping-macho-pillbug-43fcd1@krzk-bin>
References: <20250710202958.3717181-1-jonas@kwiboo.se>
 <20250710202958.3717181-6-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710202958.3717181-6-jonas@kwiboo.se>

On Thu, Jul 10, 2025 at 08:29:44PM +0000, Jonas Karlman wrote:
> The NanoPi Zero2 is small single board computer developed by
> FriendlyElec, based on the Rockchip RK3528A SoC.
> 
> Add devicetree binding documentation for the FriendlyElec NanoPi Zero2
> board.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


