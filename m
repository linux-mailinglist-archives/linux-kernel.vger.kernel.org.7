Return-Path: <linux-kernel+bounces-787397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7090B375B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F22A681ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB33093C1;
	Tue, 26 Aug 2025 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxCfiVR1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E05305E3B;
	Tue, 26 Aug 2025 23:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252324; cv=none; b=NvXZSQ5aQZx7DqexAQs3i+7Y0vgoLGh6PNNwMaETwGU19arWmRjsC2Q/PxBmgyQTMss6ZJ+3rM2+HVEDFxLHwew+YBxv9ub2S4BKuWhfaThwsZ5ZfiOD54iBnhGHWd1gZe7ZCuMYjzkNE3lqghJLaetvzZmUDsrNDTbf3P2j4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252324; c=relaxed/simple;
	bh=lVF3oe6hfnLXUWCGgNvf1380gyvgvWKOVjeJWpA6FCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+aY3An1w+6/SCjFXIj50PktBikyN+rH+Ngh5SHLmsvru6kxoNUwEd9if7jaOzxJxwMV335Fp+6sF5SOQBF5aseZZxSXJuWYe+rbLJDnh+rOwiM0Q1qVmLZtb0UlRgh0ogQxAkzuTKQd8rrWVrA73dMTk/ML3uriddTIYgD39L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxCfiVR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F26C4CEF1;
	Tue, 26 Aug 2025 23:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756252324;
	bh=lVF3oe6hfnLXUWCGgNvf1380gyvgvWKOVjeJWpA6FCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxCfiVR1xlb68BMDKtdAa/3d02OXyzdOhfRjhVL89+1lAO8MF1wy22xdeOMK3ZKUd
	 WtKyxjOe8682l4DVnDHdbenpNelYNRggzxEJNZQQfyOWyjA3l44LjL3JiQTV7dtjx1
	 u4yEDirO9N/DfZpoLIctty/9UC/bi5TT4XPoCJeQMEf/CLaFPuvBNzacO9pvXpltmj
	 8V55kSjnQTdx8IM0A9CKir/ilWsHtyRishbqedjrUv9zeAidgoG35stISdKXSnp22E
	 b2KXrU5G5xTjPLdgADzw0ok3uHqp9HhfQf440zpmVagwHmhodTn/wK+YHmegEjpG+V
	 KIyV2sURbLjBQ==
Date: Tue, 26 Aug 2025 18:52:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: marvell,cp110-icu:
 Document address-cells
Message-ID: <175625232259.766288.637157886922346793.robh@kernel.org>
References: <20250823163258.49648-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823163258.49648-2-krzysztof.kozlowski@linaro.org>


On Sat, 23 Aug 2025 18:32:59 +0200, Krzysztof Kozlowski wrote:
> The CP110 ICU children are interrupt controllers and can be referenced
> in interrupt-map properties (e.g. in
> arch/arm64/boot/dts/marvell/armada-cp11x.dtsi), thus the nodes should
> have address-cells property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> See
> https://lore.kernel.org/linux-devicetree/175589786306.518460.17450425303264875357.robh@kernel.org/
> for reference.
> ---
>  .../bindings/interrupt-controller/marvell,cp110-icu.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!


