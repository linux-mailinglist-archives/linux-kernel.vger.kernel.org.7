Return-Path: <linux-kernel+bounces-807359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC9B4A367
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DE017649A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4D306B17;
	Tue,  9 Sep 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EakU8L/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB8301020;
	Tue,  9 Sep 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402570; cv=none; b=jg1aOtgkjg0o17xLTF16XQdMvxcmJNnLGNSC6QOHLLXx49jBhT5kznRCbbpTsgari3GKhzMp53FBDQiDNfZBQ3N852okbTvVCzZox2YuS1vsyEGGb3jCF729K2ILWpGWLldsgONwD9SQoiEWpWvosDfum6+BCR7BvLcB4HruVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402570; c=relaxed/simple;
	bh=o7ugIVkJo/aKAs4gBVOk2r95UE0mR+SIVxJvnGxthO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX4dBdhNC5/5+TaEDKINok0GTjI701YaYioI/8R7lfKFL5RcNqgaGhViEBNrKDIoFfjQb0vayZfn/F7H3RXLb7hvSaGe+HS4m3kwo0JvbpDVBeAGqSwn2qUwmrVnOJxIHp2Yok6zrMsXhVxe4penRHYLfOXG09lpkWsPrb89ScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EakU8L/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3070AC4CEF8;
	Tue,  9 Sep 2025 07:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757402569;
	bh=o7ugIVkJo/aKAs4gBVOk2r95UE0mR+SIVxJvnGxthO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EakU8L/Jq5POaXQsD0wfdo4YzZ/8nBG24jChwZwnvvp15g3V2xXZrgpmN0WZMiX6c
	 f5aXmEFo0VuZTs0dWH6UNww6ZlkDAX+Uwk+60HlOpjrKNKU9u/MK5nViQevDf3wctO
	 rQl+GLQ4QtgPokRfpsPy6y6EL+XvCk/PsSTUaema8dOt8oDZqyfVRC25TE79sS8yaj
	 3h9gq/Au7kJy2UitiT/RLUBchO6Vl+u5a0+i/uZsjBL4d4INVTPAmbXUsMu4erAWGN
	 encq7Xd3HnkYMYeUCgIw6gwaoxdXCOTJkaUgfXU6orTCe7i2Snb9woryfoqkWNUbAJ
	 Q3MxysQNGf/7w==
Date: Tue, 9 Sep 2025 09:22:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaison Deng <dkx@t-chip.com.cn>
Cc: Rob Herring <robh@kernel.org>, Jimmy Hon <honyuenkwun@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Wayne Chou <zxf@t-chip.com.cn>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki <naoki@radxa.com>, 
	Peter Robinson <pbrobinson@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add Firefly
 ROC-RK3588-RT
Message-ID: <20250909-romantic-efficient-sambar-4fc38f@kuoka>
References: <cover.1757322046.git.dkx@t-chip.com.cn>
 <27b2ce7950fdbf28c6c8404c3f8be3c1c35d6b3c.1757322046.git.dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27b2ce7950fdbf28c6c8404c3f8be3c1c35d6b3c.1757322046.git.dkx@t-chip.com.cn>

On Tue, Sep 09, 2025 at 09:31:47AM +0800, Kaison Deng wrote:
> This documents Firefly ROC-RK3588-RT which is a SBC based on RK3588 SoC.
> 
> Link: https://en.t-firefly.com/product/industry/rocrk3588rt
> 
> Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index f9ee77f17ad7..6aceaa8acbb2 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -258,6 +258,11 @@ properties:
>            - const: firefly,roc-rk3576-pc
>            - const: rockchip,rk3576
>  
> +      - description: Firefly ROC-RK3588-RT
> +        items:
> +          - const: firefly,roc-rk3588-rt

That's just enum with ROC-RK3576-PC. BTW, all these descriptionis are
completely redundant. Actually getting harmful, because copy+paste of
the same is only obfuscating code.

Best regards,
Krzysztof


