Return-Path: <linux-kernel+bounces-884891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7196C316B2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77A7A4E54DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F8332D438;
	Tue,  4 Nov 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssAiLQj4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968F32C938;
	Tue,  4 Nov 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265297; cv=none; b=O9El+pWltpHI0AplEX/n1hYaorWPfaho7wDNooZXiZxsCfMAekQGzHpAdGG0T8hFPaoBXiHnDmM+lRLW7/y0MVj1E3DulxSgPxFmi7JMrw7mMfdADbXDOvruRZYO1/IWbLDEGUBqt9akjDK+6nPNy7EVXEy+5O+XRlSRVA8AhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265297; c=relaxed/simple;
	bh=km5HhGYSo6FRkzKszxfXFnfrq6gipQ7IS2uIeGouPDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R25P+EZo7nuFNLdHiW9kPG3o9e+grRx1JovbTU8RyFtNs5C+07qon3VpJgDa6J1jQr6w2TD9wu5voUacOo4dPgJQD1XCn0ZR0XlRSaCghw4feLGhMvhsA7EIBnM2B5750Us77nJJCX7UJtHPRS4XjRx0i0gVpIZ3x32JviFDKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssAiLQj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E2FC16AAE;
	Tue,  4 Nov 2025 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265296;
	bh=km5HhGYSo6FRkzKszxfXFnfrq6gipQ7IS2uIeGouPDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssAiLQj4E8QKaQZ+fRzYuAxvL0qUwOfvgGTr4jZv4eRdP+ck7R3GhmSYOWKdkp/Td
	 FrFUUVtcoViSgkIt7iRQ6TxHPzQvI0i7Es/LZB9SnXNn0kDY04s30N3J2YZlXEy08Y
	 uj89UTsw3yUyylTZtsyGYst7PctiVk85m4Fgbmj/DR/3/gWGRSLHoG8dlJqQfXVIyA
	 eifWuIEeyoEqv2D6JWW2Vg6Lzg5x66Y6KmJFlxd62+i20MPPGlqwyDHRFEJWQtChnJ
	 WyXqWnBwdh7TBmhu9WMRyagDwIHXkWFVe2XRtS0QAPTR4SAsD4B+oDtSPcFL3aWL+X
	 L9jZ02B4OLEJQ==
Date: Tue, 4 Nov 2025 15:08:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, andriy.shevchenko@linux.intel.com, 
	13916275206@139.com, shenghao-ding@ti.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, k-yi@ti.com, henry.lo@ti.com, 
	robinchen@ti.com, jesse-ji@ti.com, will-wang@ti.com, jim.shil@goertek.com, 
	toastcheng@google.com, chinkaiting@google.com
Subject: Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add TAS5822 support
Message-ID: <20251104-gay-skilled-giraffe-dacafa@kuoka>
References: <20251104041314.792-1-baojun.xu@ti.com>
 <20251104041314.792-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104041314.792-2-baojun.xu@ti.com>

On Tue, Nov 04, 2025 at 12:13:13PM +0800, Baojun Xu wrote:
> TAS5822 is in same family with TAS58XX.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 27 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


