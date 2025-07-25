Return-Path: <linux-kernel+bounces-746290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC1B124F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E5F5A4C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9F82505A5;
	Fri, 25 Jul 2025 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frOkazwW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774831FC3;
	Fri, 25 Jul 2025 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473389; cv=none; b=RlMIiSi9EwdO3ojN85kTHy67ol5xgoIoleA4NEXsG11IdWhpYrftgeWiwHkMfoPo4JlNcAnkki2o/yEL/jYLrV5V3mEfL7p5v2UweUNdmRfrRU2c9ItLOloP3GnI07PhfBJ9rhTu2XQPQptsALo7LoOrUIt9MJNnm3qeEkc+jPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473389; c=relaxed/simple;
	bh=DTyhXDpELPxUegquRGP0YjMOW25NNz7AxUozPicBFOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK5RZYUKsYq8F+US/1pzeBb9dG7TWN+6CClmWMRdGiktNXxt5CNK1BFWJ+X3/MPvQY9wS+1uzR6E/x07EuDNtTKAgvqsvGgW+vHbxsDeqbJQsMDrWOrQugI/mNB8ir6V76udmR0yv02BS88D9czmYc554uI+jhmvn5JWsiI91oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frOkazwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8D6C4CEE7;
	Fri, 25 Jul 2025 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753473388;
	bh=DTyhXDpELPxUegquRGP0YjMOW25NNz7AxUozPicBFOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frOkazwWgScxWj9Ie1H1vZoYNmsQNr7dVhn2BbXTTxPSWpKrvU/+y6O5X2wNDNWt4
	 HEPwNTXUslgORw25Yq54t31DH2cIZoLD5jMTB4h9J0wyXOAKSZ+75gSBjY7xqtjrbM
	 RnGiKmGjdjVb1gneLqyooYmr4G6dbx0MXZ7ArwpHI90VRqDQ/wP1CHa58laC3NtSPt
	 licddS8nwRgwU/LmjH+ynwbYagi4Q2fdWiugV0OgCmJwUp5ksOJ3XwhiegE7wpEQZ1
	 JFASNVwmPJCltQ61dJcQ9R+X7JjiJov9W3LdYi8UYoa9JHIm9lXa8i4hAlxIfmFtko
	 SLYYm4CMU0FwQ==
Date: Fri, 25 Jul 2025 14:56:28 -0500
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: add TQMLS1012AL
Message-ID: <20250725195628.GA1747130-robh@kernel.org>
References: <20250725062454.271191-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725062454.271191-1-alexander.stein@ew.tq-group.com>

On Fri, Jul 25, 2025 at 08:24:50AM +0200, Alexander Stein wrote:
> From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> 

The subject could use a 'fsl: '.

> TQMLS1012AL is a SOM using NXP LS1012A CPU. MBLS1012AL is a carrier
> reference design.
> 
> [1] https://www.tq-group.com/en/products/tq-embedded/qoriq-layerscape/tqmls1012al
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v3:
> * Fixed commit message subject
> 
> Changes in v3:
> * None
> 
> Changes in v2:
> * Collected Conor's A-b
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index f494ada0c1966..0beb0040a7d34 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1571,6 +1571,12 @@ properties:
>                - fsl,ls1012a-qds
>            - const: fsl,ls1012a
>  
> +      - description: TQ Systems TQMLS12AL SoM on MBLS1012AL board
> +        items:
> +          - const: tq,ls1012a-tqmls1012al-mbls1012al
> +          - const: tq,ls1012a-tqmls1012al
> +          - const: fsl,ls1012a
> +
>        - description: LS1021A based Boards
>          items:
>            - enum:
> -- 
> 2.43.0
> 

