Return-Path: <linux-kernel+bounces-898922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA5C56536
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 173224E7CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1C331A79;
	Thu, 13 Nov 2025 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE2Te3G3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6B2857FC;
	Thu, 13 Nov 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022922; cv=none; b=tMz0Y3bt2TH5XGMsX410owPswwdxP5KFzfPbYKRzK0IwdmEf08D//PW16acaeJBII/ixIuAq2G3AW0DbPWS9JbHXmxdF631rugzLS6NYbEIe7vhxxm5XQ/t8c7rqtiJ2xEx/9pxUX2EAGmWG6RRerVXZk4ElkgRRXuCSI5oE+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022922; c=relaxed/simple;
	bh=ICI1faY+jwQWDxMwXi+RLB99AqgqE2PSln2lQy4kxmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2yxN40aAx4L41DzGmT56QNbN+km0zAWSUyaUSk1C0+2Ig7to0nTy/IFi5etJeUeWvqp17skqpU+A2jZk2n0385onKsGyLiBbazjncP60URs8XzVAcmfV9qARlhzKv6mrnCV3q7yLXEXn9zABLWPrdA7rEmKIxox3ruLuM1aH8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE2Te3G3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36FFC113D0;
	Thu, 13 Nov 2025 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763022922;
	bh=ICI1faY+jwQWDxMwXi+RLB99AqgqE2PSln2lQy4kxmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UE2Te3G36qEKDHoZD9k/3f1GwsAneXvrd/vZ7jp6Hk+W+UTNbdlVTpDANB0UwVUa7
	 qSNDHq6qruzuGFHctcMAdxWR3Xm4bMv13mDY/L/yVHr/ivMTz7loRfwQIczCgiIURi
	 LEs4odmj7tfK2KTicIz2bjIJmcADvAl5WZHr8MeSoatlIP0u3keA075nMC1Qu1NyE9
	 ilSPNYfEZvZcinP8nGpHfz25QI0UDXi5wuUpn6ce7eR8Vp75bayV29CX2vflCOHdaV
	 rbBofld0KMJuLwJX37sjaWVFH03PNQJuwpnKyphhedQh25a0urRmXLz0GHuSp/si3j
	 COkgRBzNdKsiQ==
Date: Thu, 13 Nov 2025 09:35:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Asus Tinkerboard 3 and 3S
Message-ID: <20251113-berserk-hairy-alligator-2eee0c@kuoka>
References: <20251111172003.2324525-1-michael.opdenacker@rootcommit.com>
 <20251111172003.2324525-2-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111172003.2324525-2-michael.opdenacker@rootcommit.com>

On Tue, Nov 11, 2025 at 05:20:22PM +0000, michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> Document the compatible strings for Asus Tinkerboard 3 [1] and 3S [2],
> which are SBCs based on the Rockchip 3566 SoC.
> 
> The "3S" version ("S" for "storage") just adds a 16 GB eMMC
> and a "mask ROM" DIP switch to the "3" version.
> 
> Link: https://tinker-board.asus.com/series/tinker-board-3.html [1]
> Link: https://tinker-board.asus.com/series/tinker-board-3s.html [2]
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


