Return-Path: <linux-kernel+bounces-781270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92192B31039
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40DD5E62F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FD2E9EA9;
	Fri, 22 Aug 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utA5OxOB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABDB2E7BCA;
	Fri, 22 Aug 2025 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847324; cv=none; b=jhUSGB2kkYg9N+4Q8nH/2PqF5tzvGnyOgYTbGlTZM9KxXWZdZK6nLEQZtyY7FsPkYiOrTuZHx/r8BWAWR9II1n937ViMLitYeAQN6HzkEzEqH+XwuLvct5/wQQCdg5cHJM1cz2bJdt1OjTiLgB82WXOuonbeuYosqevSQcEqOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847324; c=relaxed/simple;
	bh=9FEAxH3+AuZBvYVKXXR2QRHxEq4KpWqmux1TYKe6B8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/E2b/g3w47PywummgzMNHUEvJZwJRE0CplrgYZChzNN/PaqObB5hdASU4bQA1AgLFJXLJgB5qnUUdZhuTxG3dS8sY5uHG4XBs/JeULJ4yocJb6CNOCcgDCdn9JZKTBkhvD4laGzLWGCITqncO1OYfl4qrF223r7nAuuQGIlxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utA5OxOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F136FC113D0;
	Fri, 22 Aug 2025 07:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755847323;
	bh=9FEAxH3+AuZBvYVKXXR2QRHxEq4KpWqmux1TYKe6B8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utA5OxOBW3wrcfUPDWJiVKWH7kUQEfDzLbyiCVlbCix33FrRPrMxlMzVoPR6S8Urn
	 pqFFq4qNFXiw1XXRFXDPrx1MXlW3npksb6kFkmRjtDMwLKaa1038S0g6N8PSlpmLta
	 Y8y7Gkbtxp6S0/0rcI4QFwHmsTeTwAcxOPTobpAEFRVWtg4pVaDqNYbixEPhPZBpIh
	 OoGUkFBvk/q2Bu6j24BBeQp8vMoqYbFdEM528eeseV5vSkzjR9wjjGyUtx53gR9jj9
	 hkpDBeK7kkjaQk8CMpO/PJ0AxdM8Z/iASISn0X4l0bw+ltsNZ1Z+g+mGuOMSpgj7m6
	 ACKNdRw7Vw8jg==
Date: Fri, 22 Aug 2025 09:22:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC 01/22] dt-bindings: usb: snps,dwc3: Allow multiple
 iommus
Message-ID: <20250822-skinny-clay-harrier-64dc58@kuoka>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-1-172beda182b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-atcphy-6-17-v1-1-172beda182b8@kernel.org>

On Thu, Aug 21, 2025 at 03:38:53PM +0000, Sven Peter wrote:
> Apple's dwc3 variant requires two iommus.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 4380bb6fa2f08a475b557e80467abc2861f622e2..6d35dcc605c01977f4fc6fdb6f12976f1cef2b9e 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -60,7 +60,7 @@ properties:
>    dma-coherent: true
>  
>    iommus:
> -    maxItems: 1
> +    maxItems: 2

Never tested. You anyway need specific constraints.

>  
>    power-domains:
>      description:
> 
> -- 
> 2.34.1
> 
> 

