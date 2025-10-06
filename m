Return-Path: <linux-kernel+bounces-843486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D669BBF924
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943784F274C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD306262FC1;
	Mon,  6 Oct 2025 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjpuRupZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81592638AF;
	Mon,  6 Oct 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785832; cv=none; b=d85HWFrZZW5d3G7BPQS9uv5ubijl96YUCHLw+v4ipX5wFyxkN2azJANl6qbtpDPKCJxXhAo3RUr3a3Bl/zRLrOdqERcVLXH+OVd7meuXKnoUmGlsA+SMvIjb5boPdxXs4dgZaaVICzwp4TmlXVWxxuK5h+giV4y2WZjZyVSC3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785832; c=relaxed/simple;
	bh=BfJQAZxDC6dKFjbtAynN+TxQko/NOFIg89M8FdIAZpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJS0tfdXm2Uwn8VlW/9uOnHhTX5kYIOk9XwfUy/GzAt1oSje7Fb2eGxGNxnTyZsE/eOXrZSlsHWQ8lzvzg92Vg5s/zt+EinmMBSx6qnVSrjAJC1hF5Rc2SNkKqNNWMkz6611lQZ4lZUEiHJIFYPXEGCgMwSzBJ8Qbw6heUpaVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjpuRupZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AE3C4CEF5;
	Mon,  6 Oct 2025 21:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785832;
	bh=BfJQAZxDC6dKFjbtAynN+TxQko/NOFIg89M8FdIAZpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjpuRupZ3zN34y6/OYwNhS1O9Dw50ZqiyPavqMrOM+b9uz+uyDJnzK6W/HjKeoqYQ
	 m2S6nC265NePs7ejkKjeT8bclxj5aO+TR/WElnoJAspKIEhWePz/GaNpIS5SQiZF1f
	 OVjx0HXuYk1Kw3HA/mINKbZQnWgitadxsEU7qaIE/+yLGpACFyHlXP5++QRVYHck4p
	 2aKLoab02vayooCpsZb422i24XGuYB8NMXnIuUXSiqRDs0hKRrz+HqEh78V/qS52pU
	 El8mN4SNFvDxiBP5xS4OzsZyWNK4ckr+k2gMzLWQGso7hv4g7BdVrAuRkW38urNjzq
	 o3kIwmdg8lFdA==
Date: Mon, 6 Oct 2025 16:23:51 -0500
From: Rob Herring <robh@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, andriy.shevchenko@linux.intel.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	shenghao-ding@ti.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com,
	will-wang@ti.com, jim.shil@goertek.com, toastcheng@google.com,
	chinkaiting@google.com
Subject: Re: [PATCH v3 2/2] ASoC: tas2781: Update ti,tas2781.yaml for adding
 tas5815 and tas5828
Message-ID: <20251006212351.GA602416-robh@kernel.org>
References: <20250928091514.12349-1-baojun.xu@ti.com>
 <20250928091514.12349-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928091514.12349-2-baojun.xu@ti.com>

On Sun, Sep 28, 2025 at 05:15:14PM +0800, Baojun Xu wrote:
> Update ti,tas2781.yaml for adding TAS5815/TAS5828.

That is clear from the diff. Say something about how these chips compare 
to the existing ones.

> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> ---
> v3:
>  - Rewrite the patch title

'git log --oneline' on the file or subsystem is a hint of what the 
subject should look like. In this case, something like:

ASoC: dt-bindings: ti,tas2781: Add TAS5815 and TAS5828

>  - Add TAS5815 support in yaml file
> v2:
>  - Update description for TAS5828
>  - Change commit tree to .../tiwai/sound.git
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> index bd00afa47..192d8c560 100644
> --- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> @@ -24,7 +24,7 @@ description: |
>    Instruments Smart Amp speaker protection algorithm. The
>    integrated speaker voltage and current sense provides for real time
>    monitoring of loudspeaker behavior.
> -  The TAS5825/TAS5827 is a stereo, digital input Class-D audio
> +  The TAS5825/TAS5827/TAS5828 is a stereo, digital input Class-D audio
>    amplifier optimized for efficiently driving high peak power into
>    small loudspeakers. An integrated on-chip DSP supports Texas
>    Instruments Smart Amp speaker protection algorithm.
> @@ -35,8 +35,10 @@ description: |
>      https://www.ti.com/lit/gpn/tas2563
>      https://www.ti.com/lit/gpn/tas2572
>      https://www.ti.com/lit/gpn/tas2781
> +    https://www.ti.com/lit/gpn/tas5815
>      https://www.ti.com/lit/gpn/tas5825m
>      https://www.ti.com/lit/gpn/tas5827
> +    https://www.ti.com/lit/gpn/tas5828m
>  
>  properties:
>    compatible:
> @@ -65,11 +67,17 @@ properties:
>        Protection and Audio Processing, 16/20/24/32bit stereo I2S or
>        multichannel TDM.
>  
> +      ti,tas5815: 30-W, Digital Input, Stereo, Closed-loop Class-D Audio
> +      Amplifier with 96 kHz Enhanced Processing
> +
>        ti,tas5825: 38-W Stereo, Inductor-Less, Digital Input, Closed-Loop 4.5V
>        to 26.4V Class-D Audio Amplifier with 192-kHz Extended Audio Processing.
>  
>        ti,tas5827: 47-W Stereo, Digital Input, High Efficiency Closed-Loop Class-D
>        Amplifier with Class-H Algorithm
> +
> +      ti,tas5828: 50-W Stereo, Digital Input, High Efficiency Closed-Loop Class-D
> +      Amplifier with Hybrid-Pro Algorithm
>      oneOf:
>        - items:
>            - enum:
> @@ -80,8 +88,10 @@ properties:
>                - ti,tas2563
>                - ti,tas2570
>                - ti,tas2572
> +              - ti,tas5815
>                - ti,tas5825
>                - ti,tas5827
> +              - ti,tas5828
>            - const: ti,tas2781
>        - enum:
>            - ti,tas2781
> @@ -177,12 +187,27 @@ allOf:
>              minimum: 0x38
>              maximum: 0x3f
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tas5815
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 4
> +          items:
> +            minimum: 0x54
> +            maximum: 0x57
> +
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
>                - ti,tas5827
> +              - ti,tas5828
>      then:
>        properties:
>          reg:
> -- 
> 2.25.1
> 

