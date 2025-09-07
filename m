Return-Path: <linux-kernel+bounces-804594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8506DB47A3D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67EA07A8C41
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975E222586;
	Sun,  7 Sep 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3AL4c9P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EA1C7013;
	Sun,  7 Sep 2025 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757238326; cv=none; b=VOoCun4Uv92z+7PUbRtgUfcrnerSIaSKeWq14iG323ZS7jIjriSTyNo56OMbTRRX2HLakJw7G/KWwS1nXLAAN26dIzxK4QfiUC6wd/oaTSzw7A09pk2pDrVcCgjAHcclDgCAdAtyl7r+/xkvdYAE6iE91EW0kWryIqzwrY/xJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757238326; c=relaxed/simple;
	bh=Wj1dGLxR4qgsTZ0aZBldBZFaPGiNLGjozuSVRrz3bP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAB39w2CqFXpFtezkvq9tmayW6Vrc2xkPaOJfLQBNn6fiHa8Z4MIZ56ccqXCzvV8QgpJgkL+s1sRLNwQNbDxi6ml9qtuiGLJRG39EwyfPpJu54XpbTR79vcyey21X1yH5lXApauAoKa5VVVZw4XiTtpZjf0vJ9d57eQgmYKf/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3AL4c9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE08C4CEF0;
	Sun,  7 Sep 2025 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757238326;
	bh=Wj1dGLxR4qgsTZ0aZBldBZFaPGiNLGjozuSVRrz3bP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3AL4c9PHdg6Qii9YNc10lqtSsTHGRv9Qh51rLh2bXdntVpsumkK0cF/JYkj9SGSW
	 rnb9xA4t2Sf9NolQlYvbOBhfl8HHB2m+N73yWXxmXbvOTsOIJXE2dDfgv94YkLP9bx
	 naah1RuzOQEK6cpwV13Bt6yUG3ru8LiIDXKAHf50TgJ2MDwZ3lfu7SFXhapgvvIuEs
	 Qo6nfN4Et7v5XXcAqT7+vCTx/RBqd8IbBHzs6uDHRvzdIfjw7yLYOibnV/D26ue1ku
	 qU+6H1crWor1wPug98flICsKczSjibNsPBAKBiUpNDnvOz3RsGKKjY+WqARkmhAnFi
	 9dpx61eOemTRQ==
Date: Sun, 7 Sep 2025 11:45:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 01/22] dt-bindings: usb: Add Apple dwc3
Message-ID: <20250907-benevolent-dogfish-from-wonderland-be2eac@kuoka>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-1-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-1-52c348623ef6@kernel.org>

On Sat, Sep 06, 2025 at 03:43:14PM +0000, Sven Peter wrote:
> Apple Silicon uses Synopsys DesignWare dwc3 based USB controllers for
> their Type-C ports.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


