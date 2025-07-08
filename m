Return-Path: <linux-kernel+bounces-722096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1544AFD554
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8EB7A88D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE202E62B2;
	Tue,  8 Jul 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INUm7LGp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6312E03E0;
	Tue,  8 Jul 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995664; cv=none; b=pSD4GzwD8DK1rGbIuwQ+al1YyP646T5P4MoY90IlYUhWZVmbRsuK/2xkdTGwDLsk1KgjqijvhvTOufHJKiOkSt7uB/QjXgmXa3unMMKedAufmBoro0Sr7DydALg7IAFjivZpgP32lxSxdr6scYw2i5Ii08Qg2NgAt1C59ajA2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995664; c=relaxed/simple;
	bh=2PPLZF1vIu61bjLIvYM4klKdTPjPcQbIlt7z+3nvkRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2qJcfg3BhQ+VYJZikEjwPTMkFhUuebahKes1zcSXnOL153xVuwDZICn7UJKUWwX4yzelC+CkL/LT2Fs3+zzQRQ4Q6is8nP35cOqxKE0701mkImKfdWHap7L1pOqdXM+tV+GvA2Mb/tZxatOFwWhAUkBsoHL+RlmkHlTcY5AGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INUm7LGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B147C4CEED;
	Tue,  8 Jul 2025 17:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751995664;
	bh=2PPLZF1vIu61bjLIvYM4klKdTPjPcQbIlt7z+3nvkRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INUm7LGp2bP7LFIVurndLzqoCbHgqnRSIHm4/uDGQURojmyBzbBcpWcjZqkmKWA9n
	 ZoQki1QYM5Sru5U1CQS8NL1Vlx99GLtjItzykZ/4+BqNHekDD3vqqFvlu10Vs4dEK9
	 txzU3ymi+wBbbWHcfnsiFUC29M581RYj+vFWgliresmLMUibB0eGLflbEdKPRP95MH
	 zr+VT1NOEijzKtFhoxhdYPrKagCgFBUgYXMEkoTDxsj8DkswsQsfEtcKOg7T01LwPE
	 qxmgGZzvFRA5nNY2OmJePuG5+q6Dh1EFxWUV41F8HJ+PBBe4NT/ukI245dWel9AqzR
	 59QWVAEWX5iqQ==
Date: Tue, 8 Jul 2025 12:27:42 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, ghennadi.procopciuc@oss.nxp.com, S32@nxp.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 20/20] dt: bindings: fsl,vf610-pit: Add compatible for
 s32g2 and s32g3
Message-ID: <20250708172742.GA661203-robh@kernel.org>
References: <20250705160129.3688026-1-daniel.lezcano@linaro.org>
 <20250705160129.3688026-20-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705160129.3688026-20-daniel.lezcano@linaro.org>

On Sat, Jul 05, 2025 at 06:01:26PM +0200, Daniel Lezcano wrote:
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Missing commit message. Why are we adding these? They are in use, but 
undocumented?

> ---
>  .../devicetree/bindings/timer/fsl,vf610-pit.yaml          | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
> index bee2c35bd0e2..2aac63a58bfd 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
> @@ -15,8 +15,12 @@ description:
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,vf610-pit
> +    oneOf:
> +      - const: fsl,vf610-pit
> +      - const: nxp,s32g2-pit
> +      - items:
> +          - const: nxp,s32g3-pit
> +          - const: nxp,s32g2-pit
>  
>    reg:
>      maxItems: 1
> -- 
> 2.43.0
> 

