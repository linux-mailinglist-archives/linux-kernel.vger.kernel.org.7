Return-Path: <linux-kernel+bounces-739822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2108B0CB84
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DA61AA2791
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A661E23816D;
	Mon, 21 Jul 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzunUEsq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9E218E97;
	Mon, 21 Jul 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128973; cv=none; b=S99GQZf5UxZ7UBh6m8l2NOmlGKHwycCNTWfCqHCcfxu+PVpruLI2nCLnbmIxo/GwE1gMk3g3gUQDbI6clYIGOKCD/DaMcjT7OezO2lQptva4UJl1+E36eepwUG9fTVo/+n1VAvoJyP8/BCNrJJi6HnoYm4SFM57BTBsUfQ9kgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128973; c=relaxed/simple;
	bh=fTSn/Sv4qArtz++sMbcoZ8ek+PmQQYja+lqgn+b/W4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/oM0uaZLjPrEHjxhQom7rR8lfYQvPsGwYn2t5/3mc8XYWn0s3FnyiClTIrktsvobDGuRGshpruvsUdlQhKvXJUu5jppBGjamckKtSKmd6rV40+E6/OPNk2WpWrzniEYmA1/FNBH5c2ATF1IzN2HtAL3LfpmQhUK1/q3zmq+I6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzunUEsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8A7C4CEED;
	Mon, 21 Jul 2025 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753128972;
	bh=fTSn/Sv4qArtz++sMbcoZ8ek+PmQQYja+lqgn+b/W4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzunUEsqwxpuwQgEca4OI+FIlVz5ORZ2sBMXjovqNc0/b19F1pVZ2cgX3kE7XURrZ
	 5AP+C4XZSST0Xim/UkxZ+3IaaYiCyvnapDw+BembHZF7uJEC0tXlPdIPR7DDuK4qeW
	 eWSQk06E+OjEWEVrb2CI88Ibo4I5HXozwiiPU51rTEik+TKb34xgGHLcI1zVsxsI1y
	 SEShEW1+BVMHxpu3crNvuSSDLIlKM2BnZNisff7UTRg3tKlh9XnHwJkXFKJOGZ86bA
	 yec+bO3HQ0+S7sKAxdk8+m6P9X8mQwIQvmEtqV6ZmXLk2ME9vosumlNDzjFwNb77IK
	 XcpKFw5DLUGOA==
Date: Mon, 21 Jul 2025 15:16:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: display: sitronix,st7571: add
 optional inverted property
Message-ID: <175312897159.1251067.10084528761404344067.robh@kernel.org>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
 <20250721-st7571-format-v2-2-159f4134098c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-st7571-format-v2-2-159f4134098c@gmail.com>


On Mon, 21 Jul 2025 12:43:32 +0200, Marcus Folkesson wrote:
> Depending on which display that is connected to the controller, an "1"
> means either a black or a white pixel.
> 
> The supported formats (R1/R2/XRGB8888) expects the pixels
> to map against (4bit):
> 00 => Black
> 01 => Dark Gray
> 10 => Light Gray
> 11 => White
> 
> If this is not what the display map against, the controller has support
> to invert these values.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/sitronix,st7571.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


