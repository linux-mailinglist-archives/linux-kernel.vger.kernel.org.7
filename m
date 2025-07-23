Return-Path: <linux-kernel+bounces-742032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B53DDB0EC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF631886FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B99277038;
	Wed, 23 Jul 2025 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv4l+vVx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BB221C174;
	Wed, 23 Jul 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256646; cv=none; b=cXsEOcDXBZUuO11L6173Ntg7pheIZxpXiqei3yEBRQclw+EkmKgyjYJ3jS9buqy/gsU0xAB4goGdDfvOjmUeUBKO2QZsJMhP6yiKYLtQgSPdNDVR2UiW6sPiYQVumLb2W57sSGvNADWddllFveW8L7C8VIVE1mAG1XGeQ38FVO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256646; c=relaxed/simple;
	bh=Ac7MqmvxZYLH/0zq09mvIBTiUSZ6NHJ4LWStoolGqkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWGBeSFpue36vBnXj8EkMRSucpGJ+Rrva2ZeWrJWBFumEOUvOPPUtBSKrBCDM0sYh1fU9azZAOa+yQB/ylmsHtwdegM4MSbdj1NugzNjAOTk7ZKBSNrJyNe29GOd1WbsZwQwvQw6Q1Z7XiwlHXOgIxfsnkVazK/Bwmx0pPNTOoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv4l+vVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF27C4CEE7;
	Wed, 23 Jul 2025 07:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753256646;
	bh=Ac7MqmvxZYLH/0zq09mvIBTiUSZ6NHJ4LWStoolGqkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mv4l+vVxHvh6MbEBikyP+nWZshJPaKipljRjLeil11Jrx2QyqSDjD4ozOMYAxVoE2
	 gDIgKydcR1OM7E7Vbue/0Won/TJndwSYXW5cQyBFUgBPiLoU3bOWicZfWTr4X4wnqW
	 AVEs2UotWsXo2297444Fl6klcFAinHZgcYxAedvbMsAb5iJA3DYy71ob+/y0EIHxAM
	 giFmnsCmCgbN+mmUD4TMZl3D0HDDL9LVn7PytwrL1CD1UdJfp/6iZAZ10LPRYq7OBM
	 8ixX5cBX/sYykzw8966T+1g2psTqI2WqqFq5W8NoJxUnut2xNsbZHEMCPTOMRRsfs8
	 JbIeEHncMe2KA==
Date: Wed, 23 Jul 2025 09:44:03 +0200
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
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: mt8395-genio-1200-evk: Move
 common parts to dtsi
Message-ID: <20250723-nimble-crystal-cassowary-229ee0@kuoka>
References: <20250722085811.2062790-1-macpaul.lin@mediatek.com>
 <20250722085811.2062790-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722085811.2062790-2-macpaul.lin@mediatek.com>

On Tue, Jul 22, 2025 at 04:58:09PM +0800, Macpaul Lin wrote:
> In preparation for introducing the Genio 1200 EVK UFS board support, split
> mt8395-genio-1200-evk.dts file in two to create mt8395-genio-common.dtsi
> file, containing common definitions for both boards.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../dts/mediatek/mt8395-genio-1200-evk.dts    | 1189 +----------------
>  ...-1200-evk.dts => mt8395-genio-common.dtsi} |    4 -
>  2 files changed, 1 insertion(+), 1192 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


