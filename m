Return-Path: <linux-kernel+bounces-738830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C9B0BDD5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86983AC7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2748D284693;
	Mon, 21 Jul 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzhaY/YI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F7283FE8;
	Mon, 21 Jul 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083462; cv=none; b=LLXiOjKfLinXZ6wLPcEu0ETrIZB3FUgem++9fj9sirR5oOBtQFQRMrXunI5CcgBX/ovYFy9XrPhnppJePEmQp5lOO3d7MfeQCJHOSYo60J3Z8HNzDxZv0fN7vStWa5sv+z03jVMSEZ4MWWIecTDNPA/Grh4uYTImdoTcgl2Y2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083462; c=relaxed/simple;
	bh=gX1shcXkNq8kGP80WbZWZhNw8XOGe5hjaiGjaxBIe8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USrLOw7QpWy1YTqNk95Rr93kQ8oGEaFT3r4XYpuHcgWxwhaGV+eosuDOQ5Uu923OksgXfMWsXuLRKQTqopi1Zr/5e5DyyAPIg4fM/5M/AuXwxs+77u4MCJ+7mJ8WuGmwuQIUGahB/f3h+P7DB/PzYdsrm19hEzvs8Kmo0dnqDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzhaY/YI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61DDC4CEED;
	Mon, 21 Jul 2025 07:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753083462;
	bh=gX1shcXkNq8kGP80WbZWZhNw8XOGe5hjaiGjaxBIe8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzhaY/YI+eCsiSfFYzJm8buehbzWYHGIXYnYXgb4lf1dQrFqS+h45vTifmAUkYPGw
	 aYxn8U9Y/NBXFxevEhnjarI0hetPPfpgp5aQ7qiN3/sOFtoJLLtudv49hxJojd2Z43
	 fK0NQxk9/oJnfuA11stiV6dez/R3ngVp3MZOQ176Dr5gz/uJE7qfFASffvAlfDVkJU
	 F12lNJ5pEW8sVytZBNEwIMk8IPJaBna02sRuvF41IN0Xl9V8iiGY0BhIpQ6PSofg/s
	 EIHw5kXmqkeSq39gBFqj2KtYoO2s6drkLTC9tO4a4AqgMkZTFO3DRJdYbFOyul1ItO
	 k+ikcX/R0SoSA==
Date: Mon, 21 Jul 2025 09:37:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gastmaier@gmail.com
Subject: Re: [PATCH v6 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <20250721-large-daffy-vole-d2d25d@kuoka>
References: <20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com>
 <20250717-adi-i3c-master-v6-1-6c687ed71bed@analog.com>
 <20250720232726.GA3055763-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250720232726.GA3055763-robh@kernel.org>

On Sun, Jul 20, 2025 at 06:27:26PM -0500, Rob Herring wrote:
> > +description: |
> > +  FPGA-based I3C controller designed to interface with I3C and I2C peripherals,
> > +  implementing a subset of the I3C-basic specification. The IP core is tested
> > +  on arm, microblaze, and arm64 architectures.
> > +
> > +  https://analogdevicesinc.github.io/hdl/library/i3c_controller
> > +
> > +maintainers:
> > +  - Jorge Marques <jorge.marques@analog.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,i3c-master-v1
> 
> If you want to use version numbers, they need to correlate to something 
> and you need to document what that is. I don't see anything in the above 
> link about a version 1. Kind of feels like you just made it up.

I asked already at v4 to document the naming/versioning, which was a
result of one of previous discussions, in the binding description. :/

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    items:
> > +      - description: The AXI interconnect clock, drives the register map.
> > +      - description: The I3C controller clock. AXI clock drives all logic if not provided.
> 
> Is that a description of how the h/w works? The controller clock input 
> can literally be left disconnected? If 1 clock source drives both 
> inputs, then the binding should reflect that.

This was explained in reply, but never made as proper explanation to the binding.

Jorge,
When you answer to a review about uncertain pieces like that, usually
outcome of the discussion must end up also in new patch - either in
commit msg or better in the binding itself. I also asked about this -
documenting the outcode - in v4.

Best regards,
Krzysztof


