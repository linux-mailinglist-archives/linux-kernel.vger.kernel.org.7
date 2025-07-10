Return-Path: <linux-kernel+bounces-726528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4243B00E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278EA16FF31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD2428D83B;
	Thu, 10 Jul 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4mnkz3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD34A0C;
	Thu, 10 Jul 2025 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184177; cv=none; b=S46knnJZ/LcPQYpgbj0Sk1a5n4hVCLKDqksT+7W55pHC5CPxwA2m18vW8XK/Vb1Edj+sjf8a7Bj8VwzPqnwYcjjLIduntL4s7ss+/yuJSnVYD1PAXpsHe+E/ISD9ZZInjx5tlppMXXs5kcPuZMBmuBjqMGgo1RauzA8oMqGjR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184177; c=relaxed/simple;
	bh=i7uDeYqB8J+IBN9WbbkwDIQoPV/QKIMwdaEFBWDKKGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ0Vfy8VPqMY+rUeaD9gCn//YaOK5gWMI3RvM7C6X/9+fnpB9wQvE3zZXOnPa9/73mjWFVhdsNTenBUH95M+QcdJk3icq1SOqwZKN0dwtMR3xFJGYJ5TsbXSmTjyFGZ+1BKYb2u1t8mLD5XnQwlTnP/1Bri8jgQOHvzNFw1C2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4mnkz3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5952C4CEE3;
	Thu, 10 Jul 2025 21:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752184177;
	bh=i7uDeYqB8J+IBN9WbbkwDIQoPV/QKIMwdaEFBWDKKGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4mnkz3AuKZrmf2j7taZqDg+ATYT4csviTFCfsFeizb0Woofr/tJI7CK6pE2RHy2O
	 HxE2Y0PiwZEoldp7d6/oE3GXrAUCCLVLMMAAOrjCVZscbME8c8TB2ApKAVVzkYm30y
	 D/I1bn8xL+INTC8ZiPHcEjwu5QpCGccB/kn0g7sdtniip8TD97fkSeb0G/pOqvU2Ur
	 mLxX36LoG5d1xwN1gdivVUMHVgJEbCLFu5W6cIeJu07Xdvk2Dco4tHdXItEHIR5nCg
	 HkymRxS8Gh+Hknk75PA+vnzWtDJH82NYyFVJE59U+zUQS2FH1Fmr4vxTeMFCZgaerG
	 nDXInNUnqMbbw==
Date: Thu, 10 Jul 2025 16:49:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Cc: krzk+dt@kernel.org, praneeth@ti.com, khilman@baylibre.com,
	devicetree@vger.kernel.org, rklein@nvidia.com,
	kory.maincent@bootlin.com, thomas.petazzoni@bootlin.com,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, m-leonard@ti.com,
	jm@ti.com, lee@kernel.org
Subject: Re: [PATCH v2] mfd: dt-bindings: Convert TPS65910 to DT schema
Message-ID: <175218417236.4027646.15030277007655273276.robh@kernel.org>
References: <20250708210448.56384-1-s-ramamoorthy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708210448.56384-1-s-ramamoorthy@ti.com>


On Tue, 08 Jul 2025 16:04:48 -0500, Shree Ramamoorthy wrote:
> Convert the TI TPS65910 documentation to DT schema format.
> 
> Fix incorrect I2C address in example: should be 0x2d.
> 
> TPS65910 datasheet: https://www.ti.com/lit/gpn/tps65910
> 
> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> ---
> v1 -> v2:
> - Remove references to old docs
> - Change ti,vmbch-threshold & ti,vmbch2-threshold to uint32
> - Remove constraints from description text
> - Change all unevaluatedProperties instances to false
> - additionalProperties set to false & moved to 'regulators' property
> - Shorten regex to ^vcc(io|[1-7])-supply$
> - Add blank line between vcc(io|[1-7])-supply description paragraphs
> - Change DTS example indentation to use 4 spaces
> - Drop unused labels (vrtc_reg node) from DTS example
> ---
>  .../devicetree/bindings/mfd/ti,tps65910.yaml  | 318 ++++++++++++++++++
>  .../devicetree/bindings/mfd/tps65910.txt      | 205 -----------
>  2 files changed, 318 insertions(+), 205 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/tps65910.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


