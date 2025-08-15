Return-Path: <linux-kernel+bounces-770270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7EB2792C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855FCAA3614
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6F2BD593;
	Fri, 15 Aug 2025 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7vsWi/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A9287268;
	Fri, 15 Aug 2025 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755239330; cv=none; b=PAhpvOVo/o2BmitxoQXlZqXz90Lrc9pEjZP271JwWuppNr36hH8d8k2OWjyTgUAGwKSK/rDFNBQPWd9DHHpis5IedyNLqJLTD3O882eYVJaz1nWhDvM3kDjNlmzKKNJ9xd5DDQMCo+2FVmRg/7QR1RHVyCpeTDxlkzy1vrVAauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755239330; c=relaxed/simple;
	bh=yKdH7Z9mYp9349ekyyGJWE0NQ8UBnE41L7EHWM+Ek4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyLtB3BNb7hW5DZ9z/GcpZocM8fPiP6UckApmekMbeRtEwUXBD2XSCROJRvMkdafY7MJQtlFLhM4DHEifgdeK7Bf1wFveMEs4MgmlHSFxLBnFulA8KNG34n3J//uOxwrDSv2PElUeai1Gx6cfPbz/IlKfGKx2KFTddZn85rAvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7vsWi/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBEDC4CEEB;
	Fri, 15 Aug 2025 06:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755239329;
	bh=yKdH7Z9mYp9349ekyyGJWE0NQ8UBnE41L7EHWM+Ek4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7vsWi/BXk//+Pjnr9JDZdR0HIPG2NYFOihtA77ypfoS55mcrb4ozma1lsZEyZoVk
	 m+FYAHOG3jF1ZPXvAfl8bIAMzsC2Tqg6OgqkfQRnRPXo1gniB49cNcY+EUexxtGe3a
	 RpCy+0o0/Raz0YwrudQGXyX2yEwXjfeGTasxx8W4CLaFUhDAwT5nzY9ltBOkt1SA2Z
	 Ey/MbjOPMAsosrwbYb6j3toEkjm4zuY1L8jZtHmUJW3whHri/XTos+gT5HuAZkRNqb
	 0WWUhekbWH/zwuUpvT08oUTY05vmjF4w0aTeclQ1C82wC77PbGOA2Nzgn1SjCKbT0q
	 9k4tN3DihrAXw==
Date: Fri, 15 Aug 2025 08:28:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arseniy Velikanov <me@adomerle.pw>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: mtk-tphy: add property for
 software role switch
Message-ID: <20250815-important-warm-dove-03dde5@kuoka>
References: <20250814234825.810-1-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814234825.810-1-me@adomerle.pw>

On Fri, Aug 15, 2025 at 03:48:24AM +0400, Arseniy Velikanov wrote:
> Add a boolean property to enable software control of the PHY mode
> switching.
> 
> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index b2218c151939..a90890d4a86f 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -255,6 +255,12 @@ patternProperties:
>            use the property "mediatek,syscon-type" for newer SoCs that support it.
>          type: boolean
>  
> +      mediatek,software-role-switch:

No, bindings do not describe software.

Also, never tested.

Best regards,
Krzysztof


