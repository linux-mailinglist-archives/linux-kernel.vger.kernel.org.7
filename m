Return-Path: <linux-kernel+bounces-894830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DDBC4C2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FFEA4F3EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140628935A;
	Tue, 11 Nov 2025 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyFb65Jy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68876248893;
	Tue, 11 Nov 2025 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847482; cv=none; b=snlAQ1IpnGbUNPJfr0D92wkOqKyDAnMR0tnsK0oYK/VA3+oBSGz9Dx71az7yPHTI7/vy0/HdykMaT+KRWuiah1qZ2SdDCjTfOU2srZ+X3sg6GR8m3QTPiGPGVc/rcbuhrs7uONiVv370zz9DMWMbHQNqIkn1v7dPDfOPdS3aJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847482; c=relaxed/simple;
	bh=cQMoCRRu91uB1TW/d75oVipllY0caWy7T9xqrj3rlJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqMrMy47kjAhLpJTWROkKCAEX36Sg8M+ycFN05OvCQZcBk48sdRXih+r2a+JG08iuarT62GtYgkkjecVGgfp2OQ5ZMK0Gyn9DvNvLQRPrCVK8y7Lrwl/2XlNs5OXas1eItmkQvDsUqxW1qguunDwbQWCEyF6i03OJ+9+LtDmY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyFb65Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6FBC116B1;
	Tue, 11 Nov 2025 07:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762847480;
	bh=cQMoCRRu91uB1TW/d75oVipllY0caWy7T9xqrj3rlJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NyFb65Jy9mZqJiIv+1uA2074NBoxmzTKLynqekmbV1ZiYgzKgV+pJb4qoOKv5RguH
	 II1qrFGZrh0/8YnsPt5sykZmrDPJeyyUKZEx9vECAohx+k+QVIrND7liTHNmi/N67w
	 /TsrBtIaYwSF2J/hfbzTuQV4MHcpmem4nY7H42oFXSVuFPNPNbftQBr8GiKtTDmwFd
	 6PumM42hls4kICqwfWJpKVcesJ4XIe8YVo9omglwlfxdMiC36AqE5HhqAtS0TD9ecE
	 qjF+dr+n8zG0p0RuB7mt57gbQvhLyhBkjGqKhemIZWkp1npCaGaIAruZAkzx/LzpcN
	 9dPwIGGR2+7Sw==
Date: Tue, 11 Nov 2025 08:51:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: niravkumarlaxmidas.rabara@altera.com
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: intel: Add Agilex3 SoCFPGA board
Message-ID: <20251111-nuthatch-of-amusing-attraction-06ea70@kuoka>
References: <cover.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
 <e9d398bacb299c996f14c9993bf041a9a6740cbf.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9d398bacb299c996f14c9993bf041a9a6740cbf.1762840092.git.niravkumarlaxmidas.rabara@altera.com>

On Tue, Nov 11, 2025 at 02:17:38PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> Add compatible string for Agilex3 SoCFPGA board, which shares the same
> architecture as Agilex5 but with two fewer CPU cores.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
> 
> v2 changes:
>  - Add separate agilex3 compatible instead of using agilex5 context.
> 
> v1 link:
> https://lore.kernel.org/all/51ecc7f4eb7e419c00ee51fc26156e25686dfece.1762756191.git.niravkumarlaxmidas.rabara@altera.com/
> 
>  Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> index cf7a91dfec8a..e5a8141dc6cb 100644
> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> @@ -21,6 +21,11 @@ properties:
>                - intel,socfpga-agilex-n6000
>                - intel,socfpga-agilex-socdk
>            - const: intel,socfpga-agilex
> +      - description: Agilex3 boards
> +        items:
> +          - enum:
> +              - intel,socfpga-agilex3-socdk
> +          - const: intel,socfpga-agilex3

This is confusing, where is the fallback? You said this is fully
compatible with Agilex5, no?

Best regards,
Krzysztof


