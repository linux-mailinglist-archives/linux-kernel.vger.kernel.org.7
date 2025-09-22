Return-Path: <linux-kernel+bounces-827835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C8B933AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3878B16B600
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AF31770B;
	Mon, 22 Sep 2025 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBSC9QF6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628D2AE68;
	Mon, 22 Sep 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572904; cv=none; b=WqCXvpt3Ay7Vb9HDI3/BfGhV2j9X/iYa3Q1iBq7/JBaEL/Jnjjtij214L//ekWDs7fYw4f/SuXJ2f6j8rJTAPiblaUHfk/pvOJFsCrQs/vHDpbzx6Qm/jT2k6vNd5Bmt23yqf8vCRyJ1WUzPyDOeI3f4eBhJuNYGF/mkBdw27do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572904; c=relaxed/simple;
	bh=Aa9Zejc4i8sog0iYwcjJT4xP56rN2qZlLPTRblqZAaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4XDNkYrACPOh/r6Wbifr2fVi6Ca/cfmvzE+VZtsZFPxAQQ0YcUUOxQj2Ps4O9Uxk9VEklo1I/+4TVMP4SkHKyMJPBlTs02FQNLnWljC4kCGgm2cgT95fvio6XNgvDXk/fvL6UxCvMwENkQQCewGAWsiHv/CY4VLe1aE2UpYmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBSC9QF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE159C4CEF0;
	Mon, 22 Sep 2025 20:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758572903;
	bh=Aa9Zejc4i8sog0iYwcjJT4xP56rN2qZlLPTRblqZAaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBSC9QF6pqsF2+zLfwkVCsjWpG9lrQ+2r7K9dhgeW/Oz+a66ouHDvYJQYo9UbYFNi
	 iC8Qr7RqS/KWNqi/S/JTu+eSHT4+jxF2wOnUlKKEeLt8LJ6TEH1URHf9aA9P/QDoMR
	 YQICxbkZtfWfFN1oLx4lvP7y6WJL5eqc+k50FcM/qYfhuizowaos2Tde2vS4CyVgCS
	 UDYY3HK2tC2lGyzBvaOSpXTn0IJ6wJtw/wapQUQ57f8fo9rln2M9AM/78zuWfTbEMT
	 /Td5RZCgDGe80DoZSETUywfRnsoPNnzMsk12XPPCmaEFHzo3ZD1cN55be1seiNTR1L
	 zwf4fNDHbF68Q==
Date: Mon, 22 Sep 2025 15:28:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cristian Cozzolino <cristian_ci@protonmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH 09/10] dt-bindings: arm: mediatek: Add MT6582 yarisxl
Message-ID: <175857289696.1276760.5254518096401967149.robh@kernel.org>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
 <20250920-mt6582-v1-9-b887720f577d@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920-mt6582-v1-9-b887720f577d@protonmail.com>


On Sat, 20 Sep 2025 20:23:34 +0200, Cristian Cozzolino wrote:
> Add an entry for Alcatel Pop C7 (OT-7041D) smartphone board, named
> yarisxl, based on MT6582 SoC.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


