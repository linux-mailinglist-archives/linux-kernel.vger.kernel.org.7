Return-Path: <linux-kernel+bounces-893208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF30FC46CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D63B3103
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB6309EE5;
	Mon, 10 Nov 2025 13:10:09 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AB31DF759;
	Mon, 10 Nov 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780209; cv=none; b=UD+mrKASrxRiVHNyTQXCt0YfIsGl7WOwSwNRR3hasNQrZJ/tc/5iAO98MuIMN+ZS20y3uAYBT/ANt7v5qmC/PUi1XgoIi0hjunpN9VatNWyo7XdsKsZmC4qKtumglgXzljV/XpZ7AjFqcKksYYhfnoQPMUuBEE8NvPOESmi1fvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780209; c=relaxed/simple;
	bh=tNXjfnpRZ/iYm4udCeZvjepqnWRdflkL1gvUCRboRdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAAb4fZuCVPFxYvmf0ydMqEblAzZjOECH/Kv+ivOOdJj+IVMlz6KplVPxxcNSdWUBHD4XzY0ZZn9nVIQycBCVY23qeknqOf8yofHxViVXfpDxoGaz2Q7muwKDme8LkwDOuR0eOl+7jAz7FOrwgfFqVrb7TzfTwOta1D1NxaRDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8221C340DB0;
	Mon, 10 Nov 2025 13:10:06 +0000 (UTC)
Date: Mon, 10 Nov 2025 21:10:01 +0800
From: Yixun Lan <dlan@gentoo.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
Message-ID: <20251110131001-GYB1651402@gentoo.org>
References: <20251110101110.948198-1-michael.opdenacker@rootcommit.com>
 <20251110101110.948198-2-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110101110.948198-2-michael.opdenacker@rootcommit.com>

Hi Michael,

On 10:11 Mon 10 Nov     , michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> Document the compatible string for the OrangePi R2S board [1], which
> is marketed as using the Ky X1 SoC but is in fact identical to
> the SpacemiT K1 SoC [2].
> 
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-R2S.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
>  Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> index 52fe39296031..1b2f279d31f9 100644
> --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> @@ -24,6 +24,7 @@ properties:
>                - milkv,jupiter
>                - spacemit,musepi-pro
>                - xunlong,orangepi-rv2
> +              - xunlong,orangepi-r2s
with Krzysztof's comment, you should put this new compatile before
 xunlong,orangepi-rv2, see

https://lore.kernel.org/all/20251110-impressive-dalmatian-of-luck-4d1441@kuoka/

>            - const: spacemit,k1
>  
>  additionalProperties: true

-- 
Yixun Lan (dlan)

