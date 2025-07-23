Return-Path: <linux-kernel+bounces-742040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16885B0EC43
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB4B3B0971
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D1D278156;
	Wed, 23 Jul 2025 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab3jZzZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563C248867;
	Wed, 23 Jul 2025 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256800; cv=none; b=NyDE3lZ2GmGDm/QUdI4+l+AXBpnb1y4fYWFhSGwubh2nLc4lkPIYlCCfVHeyDse1I6OJZOR155RpjEsu0Y3UgSv9DHj9KpDWSFZHbwLdaVIy+PFtj/VJRDfVFANlW5CjmMCbTTj5rH5T3Wbs8kcNhfvSuHc+twprkLhHsQUl/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256800; c=relaxed/simple;
	bh=LP5FBzh1zsHXLLxQPPXTOQl5iCOBwGRUaADi3MQxQGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ8OeqdqG99mCKyvvtyoUxgLuthJmqQNUAsJxkCon3wHQbYcGvsRMAt9R4TeaYH1vUKLCupkIj0nPsV8m4PwtuuhOrWPeiDxP+z+Bpb7UOrT3Sp8qLEPzCZqz1jCxaJMZt5oW2rQOj4c1FavKEB9xIesA9/jhr7Q8b9DtOX4Aug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab3jZzZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494B6C4CEE7;
	Wed, 23 Jul 2025 07:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753256799;
	bh=LP5FBzh1zsHXLLxQPPXTOQl5iCOBwGRUaADi3MQxQGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ab3jZzZVJdtEWMpCDrKwNfxkq7ZqlEImWWlKllK/RsP2knhmTsb7vTvJcmrL4/W7h
	 X9OPO/Q4dgR6Qo/r3RssC3vkuZSmyN1Z7NW3Z71ru7AIgPGNJQKTwvd3WQqiT63oMp
	 1A/3SC1eXsNyJ5AtYnrBKNPP7liUqAp5etIRDYIl9qWJrpqL13kPH5blNheRSXE87z
	 7MbPw9RaduJ8HI6wlsjkOwyMdPsFkYqcHe11mgOEz7zxE0c36vZ/rsmKwFSUjKG+EY
	 oQXPvQd6dW4/+ytwXGReWwZEXwbbRy7ThAnWCNsJ10GYjjZgS3qz7Gqc0dfhu3qj65
	 7UOR/fLLdTxQQ==
Date: Wed, 23 Jul 2025 09:46:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: muhammed.efecetin.67@gmail.com
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de, neil.armstrong@linaro.org, lee@kernel.org, 
	rafael@kernel.org, efectn@protonmail.com, daniel.lezcano@linaro.org
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: khadas-mcu: add new compatible
 for Khadas Edge 2
Message-ID: <20250723-skinny-spectral-zebu-eeaad1@kuoka>
References: <cover.1753179491.git.efectn@protonmail.com>
 <385b22d3f1d30e559cfdc08616812de0f958e5af.1753179491.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <385b22d3f1d30e559cfdc08616812de0f958e5af.1753179491.git.efectn@protonmail.com>

On Tue, Jul 22, 2025 at 03:38:11PM +0300, muhammed.efecetin.67@gmail.com wrote:
> From: Muhammed Efe Cetin <efectn@protonmail.com>
> 
> Add new khadas,mcu-v2 compatible which is going to be used with Khadas
> Edge 2 and potantially new Khadas boards like Vim4, using the same fan
> control register.
> 
> Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> index 084960fd5..fd57ed92c 100644
> --- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> +++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> @@ -11,13 +11,14 @@ maintainers:
>  
>  description: |
>    Khadas embeds a microcontroller on their VIM and Edge boards adding some
> -  system feature as PWM Fan control (for VIM2 rev14 or VIM3), User memory
> +  system feature as PWM Fan control (for VIM2 rev14, VIM3, Edge2), User memory
>    storage, IR/Key resume control, system power LED control and more.
>  
>  properties:
>    compatible:
>      enum:
> -      - khadas,mcu # MCU revision is discoverable
> +      - khadas,mcu    # Used by VIM2 rev14, VIM3
> +      - khadas,mcu-v2 # Used by Edge2

You need documented versioning (provide a link/datasheet). Otherwise you
should use compatibles specific to the hardware, e.g. edge2

Best regards,
Krzysztof


