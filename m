Return-Path: <linux-kernel+bounces-877765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F38C1EF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 165AC4E7184
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4843733436F;
	Thu, 30 Oct 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7zxrP78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00330BB9E;
	Thu, 30 Oct 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812594; cv=none; b=WJHTS4UAbFxXf36sND3Qx9EZ+FjlEV7bz4gk7zW4VzNXzwQEck0Qap4qePKVXrpV/inqEWuZFSKeR9N1GmK7HwYmctbjnDGuoQE08peQdzlVpxCu0XU+GrXbCuY4ua4TI9Ru3puDOpQGkhbZMVsWzpN6xhKSkdHB9UBA4OjBFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812594; c=relaxed/simple;
	bh=cRGe7WHHw1LCeccNstuWW+P/ZSv12NIwuoWjOgarCIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXkbb2rKdsOTJn0jEsynMl6LPAl9yZ7b6xTT3ASwnvzWj1l9arEo/5twd/hysLnLQDY8P6aV3d9LmO0yJ1rRzDWsDY0oOuCbEpofKldx1bvKwr0v0K4wXaBDznfaa3xe73TFuvTKZumGn3SbwRnEagDrDkHEadfN0D7ZLBbFoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7zxrP78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98014C4CEF1;
	Thu, 30 Oct 2025 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761812594;
	bh=cRGe7WHHw1LCeccNstuWW+P/ZSv12NIwuoWjOgarCIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7zxrP78KLIn7rJa+lpFRnHDGsei5y5pkM56Ke9U5jrC2ifsXej5C5GllJs8a9tQu
	 J/ZDekzbyKARQF/w4JRHaKsjFAzcrmPcaD/YOKGsCyUFktU/LqyBTScliEuD2P8DzS
	 naF/jtNiTJVRaDbLahNkneYi3smJnP/bHSz02jBCCg0V6pVIm04Je5SWBfoSLTOO0k
	 Qxhmr2+tBtjM4LqPLRSHsS8JpBizv/VMqwiqgEc05WGmgRIMO5MvDqtay/0zgkyIH7
	 ehD3qGVX1rsaNeoBVrUGCoho3p6ATff8xItvaCzSkHRsSMgQIgwk41l+CqbUMPIuTp
	 5S4Ok1oBSd1VQ==
Date: Thu, 30 Oct 2025 09:23:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Convert aspeed,ast2400-pwm-tacho to
 DT schema
Message-ID: <20251030-zealous-amiable-gorilla-b64ffc@kuoka>
References: <20251029185448.2121857-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029185448.2121857-1-robh@kernel.org>

On Wed, Oct 29, 2025 at 01:54:47PM -0500, Rob Herring (Arm) wrote:
> Convert the ASpeed fan controller binding to DT schema format.
> 
> The '#cooling-cells' value used is 1 rather than 2. '#size-cells' is 0
> rather 1.
> 
> Some users define more that 8 fan nodes where 2 fans share a PWM. The
> driver seems to let the 2nd fan just overwrite the 1st one. That also
> creates some addressing errors in the DT (duplicate addresses and wrong
> unit-addresses).
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../hwmon/aspeed,ast2400-pwm-tacho.yaml       | 105 ++++++++++++++++++
>  .../bindings/hwmon/aspeed-pwm-tacho.txt       |  73 ------------
>  2 files changed, 105 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
> new file mode 100644
> index 000000000000..018249f97a5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
> @@ -0,0 +1,105 @@

Missing SPDX. Few other checkpatch warnings like typos. I guess you will
see it in the Patchwork, so just writing here that it should not be
picked up by PWM folks.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2400-pwm-tacho.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2400/AST2500 PWM and Fan Tacho controller

Best regards,
Krzysztof


