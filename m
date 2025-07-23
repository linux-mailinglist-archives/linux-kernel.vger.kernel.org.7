Return-Path: <linux-kernel+bounces-742031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B28B0EC27
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BC116927D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E127703A;
	Wed, 23 Jul 2025 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqhPa9Tl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB127702B;
	Wed, 23 Jul 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256602; cv=none; b=Krkr4DjQ3jcjk6LJkc+q9HF4Gvx93+W08slqvVEDYV/VznanWk4/94uUpqB4pkCZcCYalDsdVWTLXbnbuBmrPt08ZVpihvrQQjP6vg1zsdz9ejKm7sGg5nl02NMe67MUhTkVvgal/E0mNbrlokNbzCTU/CWc+eUoOROi9KFyqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256602; c=relaxed/simple;
	bh=PDQlgTK2hEukkn2nVLrwDLz5l5fS7ZJLaim0Bz1akh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAAItfa6iHZ2lsjpv/su2bG5Nkmd6iSivRypBOz8wNlOg755YJbWTBZPM/ElAP3sBvdU8Eo1k9FTnpqr/EYH5N4Y/XfIorXulKMgf+HNxsBOvSxAN+CUDETh4Q93bjNG5mDWOKNZIDojMEN3osaigV3qSrP7JzZDenHBzBZ/YI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqhPa9Tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C630C4CEF4;
	Wed, 23 Jul 2025 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753256602;
	bh=PDQlgTK2hEukkn2nVLrwDLz5l5fS7ZJLaim0Bz1akh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqhPa9TlVJ7mzGdkyU5ifzQFCfywY/+v5unKHua3ht6MFkPDOuFVtS3H00jZtbdm7
	 UATjZK2F3vsjF82M1KudsAlNU8TIlbWsPxPizMu6xdurZWcbqTqUA4YJXOGTdzD2iZ
	 k1qAxcG+oti3ucJlL5J44zwAuvf+ls/kqGEd87OX8oD6JS+tluTpr5Bl9sD02wOMwr
	 mZHX7fQZ5mSqzk6mmn3qCRLqTSBE6akWkmz0mPYJYOQUxNjtxknpkjhYTxWwOP8Q29
	 xPDzajThmQFW+Ocw+jmG9tTyzv4GALQtDvVe3g6FvSd7K7qYY5wOHYOSS7sJpOBfMX
	 t299niR2HzypA==
Date: Wed, 23 Jul 2025 09:43:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Ramax Lo <ramax.lo@mediatek.com>, 
	Macpaul Lin <macpaul@gmail.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm64: mediatek: add mt8395-evk-ufs
 board
Message-ID: <20250723-fancy-elegant-mastiff-1c65cc@kuoka>
References: <20250722085811.2062790-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722085811.2062790-1-macpaul.lin@mediatek.com>

On Tue, Jul 22, 2025 at 04:58:08PM +0800, Macpaul Lin wrote:
> Add a compatible string for the MediaTek mt8395-evk-ufs board.
> This board is the origin Genio 1200 EVK already mounted two main storages,
> one is eMMC, and the other is UFS. The system automatically prioritizes
> between eMMC and UFS via BROM detection, so user could not use both storage
> types simultaneously. As a result, mt8395-evk-ufs must be treated as a
> separate board.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> Changes for v2:
>  - No change.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


