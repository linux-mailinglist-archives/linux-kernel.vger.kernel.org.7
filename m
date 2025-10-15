Return-Path: <linux-kernel+bounces-854497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811EABDE845
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A1C401749
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94891CAA6C;
	Wed, 15 Oct 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhn948jh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119EDEEDE;
	Wed, 15 Oct 2025 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532162; cv=none; b=Ys49HZ+eJGEq255SQRruWIyEHLRKULbVxBHgEkB6UYTK6pjXTdobWs689Ebg5Cbu1Z+cSffZYkS4+0En9DF1Fz10PKP8yxd9fDMdug9cfmV98m+vKBc1w60vQvC/hjV1GbjzOyh+KVSCWuV+2q4KYmTsDenI0T+RvLLeuEHxzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532162; c=relaxed/simple;
	bh=vPfvpriXfBpWr4RM30z71/TyfE3xH4ICNaEpoI7JHrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrN2kiSwNyG1tunbgLqbu8zpfoytiCoIl23wWvGx2TuDBVb05q7XcENRbf/ncci+3ZR1ztTwcWQfZfCHgV+kLw4evdJSh2agZjJS6mUtbUWnoAbrey5aqzxPnpEN97FLiw9pWa0SdmRN9vOZB13GhqG7p47Ly5WbBLP8krsSAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhn948jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5820EC4CEF8;
	Wed, 15 Oct 2025 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760532161;
	bh=vPfvpriXfBpWr4RM30z71/TyfE3xH4ICNaEpoI7JHrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xhn948jhvcjX5NZghm7TBKTXDTmnMXoR1Z/yDfXLhq5hqtIBAWNtnh6D45NYIvXDq
	 VpG0cizwvt4XahXnYzcu3yoiAd6mHXIqVHLfQwOouOwcPgfIPeJo6c7vcL9nPG6tRq
	 YoNjvoQELppFjLusq5yk2PyRjoAIr+Towua9Sld3DWSG9V30hG8R++vUrPZxpAdGz3
	 kJvWyBtXjEpI0aSNQYn0ErOcI1g5vNoYlrrSeVmjFi0x+IDJyHJ0Dys+pMsDeWVTMi
	 4sm/Ek5Jl5FLLcH15n2VKCU36h0RU7OhywrpFUio5ljGqZU11UVK1S9gxIk4adjm7g
	 Jg3jSEOkxePeA==
Date: Wed, 15 Oct 2025 07:42:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: Add compatible string
 fsl,imx-audio-tlv320
Message-ID: <176053215879.3201098.9562070210286205315.robh@kernel.org>
References: <20251010160321.2130093-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010160321.2130093-1-Frank.Li@nxp.com>


On Fri, 10 Oct 2025 12:03:20 -0400, Frank Li wrote:
> Add compatible string fsl,imx-audio-tlv320 to fix below CHECK_DTBS warning:
>   arch/arm/boot/dts/nxp/imx/imx6dl-gw5903.dtb: /sound: failed to match any schema with compatible: ['fsl,imx-audio-tlv320']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


