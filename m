Return-Path: <linux-kernel+bounces-761969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2411B2008D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9851817BB38
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46312D9EE7;
	Mon, 11 Aug 2025 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glhsZMzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6DAD23;
	Mon, 11 Aug 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898266; cv=none; b=CaPyYTtsl1vWmNaJQKD72uulNAQZl8cyvAtKe6HCJyNB6Bea/PQzQLFF+0mzMzTfgVpHBmqG2S2M2pHeoBfjWVVapSkaYQUIWuMQ0cg/JNzqPi7snbj/bD5JO2Qsmf3ntigpFpYHSct8wlkrxezYB7TXTTh2rEfIlHrEmkEsng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898266; c=relaxed/simple;
	bh=gfxNTN685mDi2kS31qcp81cAvf66p8KcAsFt99S7YAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTyjK3fBoMwYrS/Cy1Zeqfkw5GsccNAf6/UJZ46BLZQdjj+DUvfTgRNbrhQiDwN0c9tLyIwbUZsTXXzFqHxqc1fy2uYSWrdSk5Ibg26rr8i9HZ/MKRZ4DNX/Il6j39f7CzjXYghTnTAOvuiE2lCWwgqLwMMUTusULk2MI7mAXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glhsZMzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ABAC4CEED;
	Mon, 11 Aug 2025 07:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754898265;
	bh=gfxNTN685mDi2kS31qcp81cAvf66p8KcAsFt99S7YAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glhsZMzRM0mRhlXWyHTY463D1vG2pVTvnPMfSrbdZmemA8F5pVQzkUkCk42Kt4/ys
	 xUxBIIQWArKgv5jr19tIxFRYE62hYPIE4AXXwu2CCy3oLLx2xTW06YF5Tuv1iIp+xV
	 PXF3yfdYkdSJ/pcgA7e3MXeoTmLHByOx6i2flInEVJ7fUVoAqF0YGTWhwpntUYhF07
	 z4bEKwiCSZkgpTAwi2dqbXHPxIx09jTZXTUkGDu2QgqbfcfRig9FOAPdk9Ozk7PMX+
	 FI1XSc25OSofcuLmqZb05yQiqmBYw9aZ43hQWp533akpUxYy4VvR5gROChitoZ6PSI
	 NoFxOe+WY35nQ==
Date: Mon, 11 Aug 2025 09:44:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, herbert@gondor.apana.org.au, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ruud.Derwig@synopsys.com, manjunath.hadli@vayavyalabs.com, 
	adityak@vayavyalabs.com, Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: crypto: Document support for SPAcc
Message-ID: <20250811-overjoyed-prompt-sparrow-c0b1d0@kuoka>
References: <20250808122631.697421-1-pavitrakumarm@vayavyalabs.com>
 <20250808122631.697421-2-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808122631.697421-2-pavitrakumarm@vayavyalabs.com>

On Fri, Aug 08, 2025 at 05:56:26PM +0530, Pavitrakumar Managutte wrote:
> Add DT bindings related to the SPAcc driver for Documentation.
> DWC Synopsys Security Protocol Accelerator(SPAcc) Hardware Crypto
> Engine is a crypto IP designed by Synopsys.
> 
> Co-developed-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
> Signed-off-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
> Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
> Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
> ---
>  .../bindings/crypto/snps,dwc-spacc.yaml       | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


