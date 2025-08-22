Return-Path: <linux-kernel+bounces-782210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9871B31C89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4CABA186C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C134230F54F;
	Fri, 22 Aug 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgQ4QtKN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D641A5BA0;
	Fri, 22 Aug 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874098; cv=none; b=tZ9V3BtYGiaxeCfTwFALhH6daMEVDWFWCc3nrSi1MlyH8FC0KiGsH+Xv3i9qgbFCZLTZQArhBkZVICxZeLWcyAXdASX7oMf2Q1hPq6BshypKfd6sYabAGAQwMyIHaEaG7OBZ1pXUpFBXDEPQOhIDORbc4X20R0h+QMmP9kHPa2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874098; c=relaxed/simple;
	bh=n4JvEFi7K9Gnd4LcwTA0bUtIPMP+X5TsCejUHnwhR34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bkch+66Kcxp1iiHiRgzpbce281uUqAIl/rqsFLfp3TByFCECAWsaHTadHg3MouqfRB3oyfhW5sz7LO4U8VGY/ZaXTjDoCsgb4B3CwhuKgyUTaLb3sBes+XfrdDGZak5yd9KNO2g/G9I0JqAZEqbAx3ksXoRclhLuyNdMQsjU7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgQ4QtKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87789C4CEED;
	Fri, 22 Aug 2025 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755874097;
	bh=n4JvEFi7K9Gnd4LcwTA0bUtIPMP+X5TsCejUHnwhR34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgQ4QtKN0Hrlp+tukqXWm1mhlAR7cmdX5V73Oyrmx/LUNmbGl7mcWKEc8K0JS3PnU
	 cZsf1QxRdJYiqT/ljbvr2pdN3lqlaBFwrmaXY9/OTYKDRaFBEdkm4ee6gxhixeeX3Y
	 SbwaSRu6YR6PW3QOwwIcYj+KxYEYIRorQUlLaTQ6f7ycze9l1TJ9fTVgauCJF6SrLR
	 0kpHfu5WZqx4qRoy2M7MnF6/fC8KBVd7adWJ05/3hqBP4BhXQBTsHdseuAcO8dbQhs
	 F5aNMKlX91su9yhj4W+inDZWQhuaIbLsWKeu6rBkRVK3GFyFhOzoxotW3hqt0BRZcM
	 hud/qTNt6vaEQ==
Date: Fri, 22 Aug 2025 09:48:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Simona Vetter <simona@ffwll.ch>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>, devicetree@vger.kernel.org,
	Arnaud Vrac <avrac@freebox.fr>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, Robert Foss <rfoss@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor+dt@kernel.org>,
	Pierre-Hugues Husson <phhusson@freebox.fr>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: ingenic,jz4780-hdmi: Add
 missing clock-names
Message-ID: <175587409204.3789906.17191769934979803832.robh@kernel.org>
References: <20250820-dt-bindings-display-v2-0-91e2ccba3d4e@linaro.org>
 <20250820-dt-bindings-display-v2-1-91e2ccba3d4e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-dt-bindings-display-v2-1-91e2ccba3d4e@linaro.org>


On Wed, 20 Aug 2025 16:17:36 +0200, Krzysztof Kozlowski wrote:
> The binding references synopsys,dw-hdmi.yaml schema which defines both
> 'clocks' and 'clock-names' with variable length, therefore we need here
> also same constraint for 'clock-names' as for 'clocks'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!


