Return-Path: <linux-kernel+bounces-742034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE6B0EC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364DF3BDCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D52777F7;
	Wed, 23 Jul 2025 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0gBpv9q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69C5223;
	Wed, 23 Jul 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256726; cv=none; b=I1t/X3mxpJOmjG9X/Pa/6h1dlZU5Lxfu4VD3KwqwbE8r645cW11G8fe/c8vqlRhmi8SOMZnULjLuBytC2B1lRUPKNkExcTZRCwvcH42UCxwxcj59HvAUAUAe19V5NV5Gsj2mXXC+WkBIqqkmdNpDPjV2iPWmf8d1kceQOh9xHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256726; c=relaxed/simple;
	bh=vYVvt8tih2kLkLnclEc/g8hovZ8gLvWrK/QtqjMeRvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbcoKcOjcUiBOOphLA2PISB/w6YyZ8Gj2hJJciuDcXKBrnk7WbByHaL0qqP1M/6RIoAvIvSobqrw++uGstNms+Fg8WnYJd8wGTsFzXJILF8uiEEfJ8VV4IqTfSZW0PxkSR+1jvQ3FxpANGO0qwSS4Um5Dt8m9Lamh8uv8cWU4Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0gBpv9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B0EC4CEE7;
	Wed, 23 Jul 2025 07:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753256725;
	bh=vYVvt8tih2kLkLnclEc/g8hovZ8gLvWrK/QtqjMeRvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0gBpv9qz8jdRgwh2fedm5fs8AwMdzMxSXJFNBMhV75LHGS26aWcL/dA7waDsV6kQ
	 1/KPChHrjCkb7nvthlqmG0wS3vBPY6Bp7RbpFJlg1w2EseV3+cc8Q1l5Rkk3deOoxZ
	 6PBohu0rH4JZrEHJEimOlam2NMafaZ0O5eZRLGYtlhwETXB0qRXDYVsR2pN1+nW7Wc
	 lEgQJ/Gef+a2zBEFeZcodwvK9PkviMf1ntjmeuxAiGyyWqHbRTrhSsMTjMWJnmkC20
	 0ksNMLdZ71jvSgg27IE4ULdCaoThVuI503TA11KcP9wVsYKa7YYO0/3K3mlF6RqZYu
	 pCGs8darkjHuQ==
Date: Wed, 23 Jul 2025 09:45:23 +0200
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
Subject: Re: [PATCH v2 4/4] arm64: defconfig: Enable UFS support for MediaTek
 Genio 1200 EVK UFS board
Message-ID: <20250723-vagabond-unselfish-bat-c7ed9d@kuoka>
References: <20250722085811.2062790-1-macpaul.lin@mediatek.com>
 <20250722085811.2062790-4-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722085811.2062790-4-macpaul.lin@mediatek.com>

On Tue, Jul 22, 2025 at 04:58:11PM +0800, Macpaul Lin wrote:
> Enable the UFS related settings to support Genio 1200 EVK UFS board.
> This board uses UFS as the boot device and also the main storage.
> This includes support for:
>  - CONFIG_PHY_MTK_UFS
>  - CONFIG_SCSI_UFS_MEDIATEK
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Changes for v2:
>  - No changes.
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index cc82faf1371c..b3c6728ed5dc 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1216,6 +1216,7 @@ CONFIG_SCSI_UFS_BSG=y
>  CONFIG_SCSI_UFSHCD_PLATFORM=y
>  CONFIG_SCSI_UFS_CDNS_PLATFORM=m
>  CONFIG_SCSI_UFS_QCOM=m
> +CONFIG_SCSI_UFS_MEDIATEK=m
>  CONFIG_SCSI_UFS_HISI=y
>  CONFIG_SCSI_UFS_RENESAS=m
>  CONFIG_SCSI_UFS_TI_J721E=m
> @@ -1616,6 +1617,7 @@ CONFIG_PHY_HISI_INNO_USB2=y
>  CONFIG_PHY_MVEBU_CP110_COMPHY=y
>  CONFIG_PHY_MTK_PCIE=m
>  CONFIG_PHY_MTK_TPHY=y
> +CONFIG_PHY_MTK_UFS=m

This is redundant. I don't think you actually generated it from
savedefconfig.

Best regards,
Krzysztof


