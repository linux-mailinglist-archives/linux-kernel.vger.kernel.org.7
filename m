Return-Path: <linux-kernel+bounces-821915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B7B829C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C42721A71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B538235345;
	Thu, 18 Sep 2025 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD3ETIam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0DA25634;
	Thu, 18 Sep 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161040; cv=none; b=MpuNuLn4FJ28ctmH1t0q8khC6wYl8QBYXOOirhOgRD+cSsDP/LU1u5eg8vm9vRcnYWyqGcEBdhYzV3wj77dymkMbNT0eLcsxMI4NWBjoPKED0d7se9D8oftccwDmDGzpSpsMPtBpXuNieuYBLOvQD0R2izLKDt8ouCGAWd7/Onw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161040; c=relaxed/simple;
	bh=Md6qh2nqi/4xcplkMFHDeoYCFB2mEKvEGQNLijUPMgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrmsC5pg7bXBZ8Ryy0AvEEsBuDBrnGYlCrxvkM9u/KLL2K6LpNGvmcW/DTahMO7todbZG/ARw9G62CG+thJdZzbu1FyFl6nlyRpKmn7n+SbpDr1rm1Hfxg11T0laX2rNmiopjls7u55VwGlJadIQACNwuEpUGbPbJy8xIXGW4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD3ETIam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BD1C4CEE7;
	Thu, 18 Sep 2025 02:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758161039;
	bh=Md6qh2nqi/4xcplkMFHDeoYCFB2mEKvEGQNLijUPMgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gD3ETIamPrh9zylPheNls1RjkqPZ4+7DNC2J2HaQ68DLlMyRcA+5cYhDWb+EY4z/f
	 pHs1D4SjYtV/tKOMqKWx0UIPFS62ojngO6y0Z/VJyecIPHmc62MisF+1WEtplE1nNu
	 iFckiwBTcAhBnSrMSgQpEdkA4jZOFwsBhrhQxZ5WGU03b9cVjKHJHG1jWmXMNTJRWW
	 TGuZlnSlsnm+xCI1IQpDMvgEeFdswgoah2NvNyFovesAWmOeU3qX/997Ug1V5PCSzG
	 yiXU3fbf9k2EV00lwY3P/zjqjnc/W7YBMXTyoi298VNymDDPD3uiJAPnSdVZCwvNr0
	 jMzZt7RnAmj8w==
Date: Thu, 18 Sep 2025 11:03:57 +0900
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: qcom,spmi-pmic: add
 qcom,pm4125-codec compatible
Message-ID: <20250918-wonderful-deft-jackal-7d3bbc@kuoka>
References: <20250915-pm4125_audio_codec_v1-v4-0-b247b64eec52@linaro.org>
 <20250915-pm4125_audio_codec_v1-v4-2-b247b64eec52@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915-pm4125_audio_codec_v1-v4-2-b247b64eec52@linaro.org>

On Mon, Sep 15, 2025 at 05:27:49PM +0100, Alexey Klimov wrote:
> Add qcom,pm4125-codec compatible to pattern properties in mfd
> qcom,spmi-pmic schema so the devicetree for this audio block of PMIC
> can be validated properly.
> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 078a6886f8b1e9ceb2187e988ce7c9514ff6dc2c..776c51a66f6e7260b7e3e183d693e3508cbc531e 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -137,6 +137,12 @@ patternProperties:
>  
>    "^audio-codec@[0-9a-f]+$":
>      type: object
> +    oneOf:
> +      - $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
> +      - properties:
> +          compatible:
> +            const: qcom,pm4125-codec


Not much improved. Same feedback applies.

Best regards,
Krzysztof


