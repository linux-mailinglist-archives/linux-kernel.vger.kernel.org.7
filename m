Return-Path: <linux-kernel+bounces-727174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9EAB01600
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECCE1C86AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACC20E702;
	Fri, 11 Jul 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN0B6ROM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55AD20D4E1;
	Fri, 11 Jul 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222448; cv=none; b=Gn/X/HnqO5UTI5lsZUeU9xW6e32QDvk9dv7uLDxGhQ2zWoRqBIuhRurxof60WhdBdZP84uWCW8UCz8Ao/q37oeGIg6kRNdRpe+o5LZEyBwlZu0XoH3qNkEEYiB9yvyTXbUpvbYg6D1ttDr1IrhZbBi1uAc8SI7hS532dvbjpZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222448; c=relaxed/simple;
	bh=6NbTCylW/Y/DUu/iQp96wAyOt/AMrQ2gJj6Sr/SI/Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiYszeSQj5uaqU8ZmOB65pnYgspYEJJ7Z4apmiMp2FWiSbpfl+eCC5nGhF8vEAgFaVxV/PU7l/hOsaAu0myQr4VUJxs5VkIoev8R1AqcGF8YYWCQmMb+GQcHvpu4b+Gx4U2VQc38gQYiTPaIYtmLAGamMLISXHki6LbzxqXrozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN0B6ROM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E7CC4CEED;
	Fri, 11 Jul 2025 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222448;
	bh=6NbTCylW/Y/DUu/iQp96wAyOt/AMrQ2gJj6Sr/SI/Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GN0B6ROM8SDKGlryvs9BtzpmthA+5wv3Eb2c5yZhZ5E+bVxrnRNRquLos1oMg+WpH
	 A3Mm+JYHb/Zl+002toOGEfgHno6HUQWk2PkvArIm5cThwIldPSBfg/CgARZoeGOGS2
	 c67OqggXgBvmbrEwg2MMVKApCS6XJ2noe0qEBj0ySvQt6fDbWJUPFiJt1397RqGuvF
	 H1GE53E2gXOygIhaT/vyux3cKMBhsD+c8eFR3vcy5YcIPaRP7YKHDydXuG8KoxBwYN
	 BFNTlnU83uWoP4PNFbVqJ7uIAAxW9NJa91hyay20B4BL7RXBV1RffjxCfwGEU29Svp
	 rnsUVsmNO0z+Q==
Date: Fri, 11 Jul 2025 10:27:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: add bindings for pm4125 audio
 codec
Message-ID: <20250711-cuddly-cassowary-of-poetry-58b102@krzk-bin>
References: <20250711-pm4125_audio_codec_v1-v2-0-13e6f835677a@linaro.org>
 <20250711-pm4125_audio_codec_v1-v2-1-13e6f835677a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711-pm4125_audio_codec_v1-v2-1-13e6f835677a@linaro.org>

On Fri, Jul 11, 2025 at 04:00:10AM +0100, Alexey Klimov wrote:
> The audio codec IC is found on Qualcomm PM4125/PM2250 PMIC.
> It has TX and RX soundwire slave devices hence two files are added.
> 
> While at this, also add pattern for respecive node in mfd
> qcom,spmi-pmic schema so the devicetree for this audio block of
> PMIC can be validated properly.
> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +-
>  .../bindings/sound/qcom,pm4125-codec.yaml          | 134 +++++++++++++++++++++
>  .../devicetree/bindings/sound/qcom,pm4125-sdw.yaml |  79 ++++++++++++
>  3 files changed, 216 insertions(+), 1 deletion(-)

Incorrect subject prefix.
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
(or git log...)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


