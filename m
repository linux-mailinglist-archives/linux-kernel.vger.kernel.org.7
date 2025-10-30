Return-Path: <linux-kernel+bounces-878905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC8C21B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3953B293D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10B2EB87E;
	Thu, 30 Oct 2025 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alXeYIsV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F271A9FB4;
	Thu, 30 Oct 2025 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848206; cv=none; b=OP44Dm10X9SjzSBK94PGmjqhZsO/J2MnERUVlLZF1kVC3PBuW9cfIZ24BmyRUZuxy1/YxLrVouVo1xpDUZl0wUhdEIok06a0AupAim8hvdGIumVdzGa79YezwJr5gNsu9rJwmv9dwgyYF7eIOMh+ycLgwgU1v5PQrSaw8c4gXR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848206; c=relaxed/simple;
	bh=nIQ2Ev++z+xo9XHpOFS+fOtVxZnODT3sXLS2ZI0U6bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLnAKycebVDw9Bf2+KpC1hdfv3x66tmmzyq4WQ+5oxVJLkmzXAJ2oyaYSORXxehG9d5BVDrbN/+4qjTPAgvw4QO4YX6GOja9iyMqlE+mIuXdCIotMb4K73uMpLqrFSXG3xO0KPtnApU2+6Wq/DOJOHLem+PoA71QZEIWlXmxR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alXeYIsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870C9C4CEF8;
	Thu, 30 Oct 2025 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761848205;
	bh=nIQ2Ev++z+xo9XHpOFS+fOtVxZnODT3sXLS2ZI0U6bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alXeYIsVtmHMuUR0wO+aWyeprQe79H2MyQEd3fMLOVKmTLy5LPenlweu98eESrMgO
	 po7GP1htEVaUdUaCpxfk+y22Kc8QfQxolDVAV5NYfXsF1loF5sww+rPtU21yLtm1z5
	 eZk1C525y2UCXsl0n/LN+RbM3u/IUuuJzrnwFGiUEkBHQoPUUlNQppfPE8LoWqK3Vw
	 L2oZEsvjlCTZXLyWXar8KXI0ALUFPpmPvq0us2CkbSMc+uGcOQxqOr4sZkSjfVUh4n
	 HQjHcpSqEdlDfutZPohmnOOwUmTZqAIbIFYVUawE9GP+xuQ4JyOe+0C2efcfrbjq0i
	 TyjoB+7NN7EfA==
Date: Thu, 30 Oct 2025 13:16:43 -0500
From: Rob Herring <robh@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: introduce no-auto-mmio
 property for syscons
Message-ID: <20251030181643.GA130921-robh@kernel.org>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>

On Wed, Oct 29, 2025 at 08:27:05PM +0300, Dan Carpenter wrote:
> Generally, syscons are created automatically and accessed direclty via
> MMIO however sometimes syscons might only be accessible from the secure
> partition or through SCMI etc.  Introduce the no-auto-mmio property to
> tell the operating system that the syscon needs to be handled manually.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 657c38175fba..a0ad12ae0bee 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -245,6 +245,10 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  no-auto-mmio:
> +    type: boolean
> +    description: Prevents the syscon from being created automatically

"syscon" literally means "have Linux create a regmap for me". If you 
don't want that, don't use the "syscon" compatible. Really, I wish we'd 
never added it in the first place.

Rob

