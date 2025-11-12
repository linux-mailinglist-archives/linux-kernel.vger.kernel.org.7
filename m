Return-Path: <linux-kernel+bounces-896594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B16C50BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4436E342A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6ED2DECBA;
	Wed, 12 Nov 2025 06:37:18 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5592D94B7;
	Wed, 12 Nov 2025 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929438; cv=none; b=myKfVMxFXqFnS43ynp4V6mJ09YY0NnoOlTmvZaymMUQTCT8MtEUgVCNE2ORBNFL8xNFxDyKmWoNzu096l5NjcW3zUfDIwD8A89Lz/DRyfsgfSNP/J53lIehzrfd0qYd1oi0P6y/YTCOg7K9L/+4Wvb9LeeM0koGIOFLMJ8cbVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929438; c=relaxed/simple;
	bh=JnovqX2d8PjMw7/74aR9yABXeIKXajAr1ScoI7eKji8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVkLZ+AP0Tf6G066fEI1xf6d3whb17AYxcB7QsmwoBl6ySqcFqvXhSb/uE1/rO7NIUqYwm+Bmfm7Faxjm3FLWNPOSOv6Bng/hEW3UYp1n/wWnsDyWRzpWSPnMmSFdPQnuH1xtfTeAU95yqInI4A2qlx8AjtRDwHLLhG0Za/PGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8D31B340F28;
	Wed, 12 Nov 2025 06:37:14 +0000 (UTC)
Date: Wed, 12 Nov 2025 14:37:10 +0800
From: Yixun Lan <dlan@gentoo.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
Message-ID: <20251112063710-GYD1677982@gentoo.org>
References: <20251112044426.2351999-1-michael.opdenacker@rootcommit.com>
 <20251112044426.2351999-2-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112044426.2351999-2-michael.opdenacker@rootcommit.com>

Hi Michael,
  Thanks for the new iteration

Hi Krzysztof,
  Is this version addressed your concern? I would like to queue it for
v6.19, but let me know in case you still have objection..

On 04:44 Wed 12 Nov     , michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> Document the compatible string for the OrangePi R2S board [1], which
> is marketed as using the Ky X1 SoC but is in fact identical in die
> and package to the SpacemiT K1 SoC [2].
> 
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-R2S.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
>  Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> index 52fe39296031..9c49482002f7 100644
> --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> @@ -23,6 +23,7 @@ properties:
>                - bananapi,bpi-f3
>                - milkv,jupiter
>                - spacemit,musepi-pro
> +              - xunlong,orangepi-r2s
>                - xunlong,orangepi-rv2
>            - const: spacemit,k1
>  
> 

-- 
Yixun Lan (dlan)

