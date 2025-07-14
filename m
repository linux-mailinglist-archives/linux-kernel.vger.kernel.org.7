Return-Path: <linux-kernel+bounces-730760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE75B04975
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568FE4A7385
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F82798E8;
	Mon, 14 Jul 2025 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEegMO8l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E75258CCC;
	Mon, 14 Jul 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528166; cv=none; b=VB9+CGib+Ll2d7i8OKd6YXPiX7Pnc+OZoOX+FwBp6Iz4d/oFlLrpIQI++51Afz/iAvFoeCXiOLMgi3TYfNxohwzzP+E5NRKCiko1ZAD5dz0WqXE89CBfs79N0KKhEUY0KJFcS6cGZP9J3CmH4qsDKm/HwQe7F+Hl2AmC6JpoYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528166; c=relaxed/simple;
	bh=tcTOJJbpBgE6AYVDpOIVdXnksO9QHTx1ZGZLFRHyA0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIsGBuctujX8iL3QcOzwodN5bJH6KuILSPRFsqfQxIQec6hXJcPFGuuaohaKcM/HGwk/Lf8DOFGlBmOmBvwGEY3na898KfmQFeWR3tAckAMFrmdinBK4k5maxx/yT4RaZaJXkx6bQdI8I1EYOrcSgWVyQ+3HMkigdA5Y+Do0Kyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEegMO8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4467EC4CEED;
	Mon, 14 Jul 2025 21:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752528166;
	bh=tcTOJJbpBgE6AYVDpOIVdXnksO9QHTx1ZGZLFRHyA0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEegMO8lU6cQsqTFsEHwNgihKcAnmAaxZRwiS9MWKtRi2B/suvmiXR61KFkGQjj6D
	 sgF64LJVY585BELHGS7QMY7rYRqFa3fnvkJlfSSao01/TeDAzvdWrJCRrpZMYu2oYu
	 DsF+CECQp4xuxqdn9y+XuZbJ8zF30ZqF6a3+jyNjLgHlXhVVvIZHXVNWozyW1TvFWz
	 H73OZqQsPHORyKG5+mdrKX+Fb0SXFgjHi+MIgeoZiu28CgPrQ8XUUJaRQP2vqivpTL
	 dWUJagambloA7iX3EdWOofyJGiVGLBZbbcbJ6cXUzC5KW2DYxm+ie4gWsNId391J7o
	 oScMKm/IVzrrw==
Date: Mon, 14 Jul 2025 16:22:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/4] docs: dt: writing-bindings: Document compatible
 and filename naming
Message-ID: <175252815430.3190487.8753988814119846022.robh@kernel.org>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
 <20250713-dt-bindings-docs-v2-2-672c898054ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-dt-bindings-docs-v2-2-672c898054ae@linaro.org>


On Sun, 13 Jul 2025 14:46:37 +0200, Krzysztof Kozlowski wrote:
> Document established Devicetree bindings maintainers review practices:
> 
> 1. Compatibles should not use bus suffixes to encode the type of
>    interface, because the parent bus node defines that interface, e.g.
>    "vendor,device" instead of "vendor,device-i2c" + "vendor,device-spi".
> 
> 2. If the compatible represents the device as a whole, it should not
>    contain the type of device in the name.
> 
> 3. Filenames should match compatible.  The best if match is 100%, but if
>    binding has multiple compatibles, then one of the fallbacks should be
>    used.  Alternatively a genericish name is allowed if it follows
>    "vendor,device" style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/writing-bindings.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Applied, thanks!


