Return-Path: <linux-kernel+bounces-831076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55EB9B74A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A799018881DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416D4319855;
	Wed, 24 Sep 2025 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U143hdzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1968834;
	Wed, 24 Sep 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738169; cv=none; b=R4fmMntKcL18yRdtcEw+gXIsUVlOI8neGOlEt8Phi27V8nyX0uHkCTCptDqgbnTmbR3zvjttePBqg6D5etDlZN7VUr6B/z2n/iWLSXxs+6Cl0SUQJ2uFCqHgg5oPSa/plUaY5PQGBcY94zqnAtkiHdjD08kJygqP1FG0ZjeDpI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738169; c=relaxed/simple;
	bh=/dizJ5Yx9RjejGKb4zmO9A3cx6kee5ApzkrMTFA0MNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixobPqYuoroWv+vpAGmspAEYeza5F+XWs7TnEsnU+G8IteqDkmoczD3DxfGgQ32Zb4AcS8az+TEPSmB9YXxgmtjiiQLWGHW/Nr2jl6sLxarluc08o6Vh2F7f1R/BIlXX7OdtgYtBfeX/8koACvZITRWxAmlBWlme+tSbziritn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U143hdzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164ABC4CEE7;
	Wed, 24 Sep 2025 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758738168;
	bh=/dizJ5Yx9RjejGKb4zmO9A3cx6kee5ApzkrMTFA0MNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U143hdzXG4BM2U4/RGhbJLZkf0oHaWc6kUm4O7eVMoW3LZC3znzGv+cmvpHeLKlOK
	 eIM+3C2AOcCqDVAo9QWSnqGGFiOcyT51ZM3FpMgvvexB9rwL6LQuczEdEgNIUXUuka
	 3r8PfGWoeUBEFrGmbWqDO6TbNH/+zlOoI7O/RNoUwA1mIoReOZaLe/6bPqtrDXCGn7
	 04MhO7ShJEt+ZvQyYxRo+f+9YXoqAt0Zh9DZhnI9jjahdcvVzgwsX8OxfzNTqDzREk
	 2RAdPp0WK43KkCtYdJmnwliRuoDAnbnvDeM3y7XTxlb4lcz5x3531NjZZbdMgeI4ru
	 oZC/vxeZyzxfQ==
Date: Wed, 24 Sep 2025 13:22:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: airoha: Add AN7583
 compatible
Message-ID: <175873812927.2390194.2900839145520003196.robh@kernel.org>
References: <20250923185340.21526-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923185340.21526-1-ansuelsmth@gmail.com>


On Tue, 23 Sep 2025 20:53:34 +0200, Christian Marangi wrote:
> Add Airoha AN7583 compatible to the list of enum for Airoha Supported
> SoCs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Follow alphabetical order
> 
>  Documentation/devicetree/bindings/arm/airoha.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


