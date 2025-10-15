Return-Path: <linux-kernel+bounces-855226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ADCBE08F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A786935395C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B61305E1D;
	Wed, 15 Oct 2025 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="dDIadWK1";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="dDIadWK1"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA6272E4E;
	Wed, 15 Oct 2025 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558210; cv=none; b=XaB4rbrf7WSPSrRXlQp30mfMw18VVn6EG4KMh+MMD+Hq1X18XVyoDtQPRAQdVFEan0ICfZwOWHjZ141v9vGiCEx5PTHVxscXH2HXG6DjCEr7jg/V0vDo1DPGNi/PiJCQAsstlP3MEw9jO8JwWrSUS8exwj0++sAaeavsRw+u1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558210; c=relaxed/simple;
	bh=tJUGuCu7ggRIyopQyMCtc58g1/733SmlpECwCzvrvNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQt4iVhfhnkXkArrzNdmWA9kIPuMihnJTx5QmSeB3JvMTvuCjUCeCTT4wErnQLwppxLVlqach8bqHDJFspJ0fnvFpzudib+Il2RiNnDNGRgnUf4dhgwowtLQv/VzcbKkllLPQ4Wtzv2pspPMwZfaUbhhBkgqhrfpK11L6LAsdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=dDIadWK1; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=dDIadWK1; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1760557729; bh=tJUGuCu7ggRIyopQyMCtc58g1/733SmlpECwCzvrvNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dDIadWK1+hrZWjIOZwX6YBWXbF3dy2MJkZbjcv0SEfiyzid4Z4drBshnL3owHmAb4
	 OYNrwKEYm6QFDI7sfEHeHVu8gUlvnnw+vLJwgme1ImlrmQhyaO5Yk7XvtjfK/rky4+
	 2rUKQYGThZdddTPAG9vpv8xip4tiXsnzh6u0NtyyDBTD+DtjNrfpLzifcjyB3G1Fil
	 BK+/S8Y8c0nem7m6bs2VJyJ5AgvXk2uD+LGKWRknkaymjy/P0ER7N+jIbH6MBPfGL2
	 S+qAPxq7AREcNEobzh7O/fAbnBJH9KV+3jGSCyv8XNJJzMwAZQyy1M9/7gGPSv/4n/
	 PwbLkc2mGuAOw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 3C6383DA3EC;
	Wed, 15 Oct 2025 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1760557729; bh=tJUGuCu7ggRIyopQyMCtc58g1/733SmlpECwCzvrvNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dDIadWK1+hrZWjIOZwX6YBWXbF3dy2MJkZbjcv0SEfiyzid4Z4drBshnL3owHmAb4
	 OYNrwKEYm6QFDI7sfEHeHVu8gUlvnnw+vLJwgme1ImlrmQhyaO5Yk7XvtjfK/rky4+
	 2rUKQYGThZdddTPAG9vpv8xip4tiXsnzh6u0NtyyDBTD+DtjNrfpLzifcjyB3G1Fil
	 BK+/S8Y8c0nem7m6bs2VJyJ5AgvXk2uD+LGKWRknkaymjy/P0ER7N+jIbH6MBPfGL2
	 S+qAPxq7AREcNEobzh7O/fAbnBJH9KV+3jGSCyv8XNJJzMwAZQyy1M9/7gGPSv/4n/
	 PwbLkc2mGuAOw==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id A97703DA36F;
	Wed, 15 Oct 2025 19:48:48 +0000 (UTC)
Message-ID: <b75b30d4-e33e-4620-bc37-56b36612364c@mleia.com>
Date: Wed, 15 Oct 2025 22:48:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2 1/1] dt-bindings: arm: lpc: add missed lpc43xx board
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/LPC32XX SOC SUPPORT"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20251015184846.2509016-1-Frank.Li@nxp.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251015184846.2509016-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251015_194849_266330_AB8984CD 
X-CRM114-Status: GOOD (  11.34  )

Hi Frank,

On 10/15/25 21:48, Frank Li wrote:
> Add missed legancy lpc43xx board compatible string to fix below CHECK_DTB
> warnings:
> arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dtb: /: failed to match any schema with compatible: ['ciaa,lpc4337', 'nxp,lpc4337', 'nxp,lpc4350']
> 
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I'll take it for v6.19, thank you.

If you have any other changes in the queue, please feel free to send them also.

> ---
> Resend
> - colloect R-b tags.
> 
> change in v2
> - move to nxp lpc32xx.yaml
> - fix ea,lpc4357-developers-kit include lpc4337
> ---
>   .../devicetree/bindings/arm/nxp/lpc32xx.yaml  | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml b/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml
> index 6b7f5e6f99cfb..1e290f16a7a50 100644
> --- a/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml
> +++ b/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml
> @@ -22,5 +22,27 @@ properties:
>                 - phytec,phy3250
>             - const: nxp,lpc3250
>   
> +      - items:
> +          - enum:
> +              - ea,lpc4357-developers-kit
> +          - const: nxp,lpc4357
> +          - const: nxp,lpc4350
> +
> +      - items:
> +          - enum:
> +              - ciaa,lpc4337
> +          - const: nxp,lpc4337
> +          - const: nxp,lpc4350
> +
> +      - items:
> +          - enum:
> +              - hitex,lpc4350-eval-board
> +          - const: nxp,lpc4350
> +
> +      - items:
> +          - enum:
> +              - myir,myd-lpc4357
> +          - const: nxp,lpc4357
> +
>   additionalProperties: true
>   ...

-- 
Best wishes,
Vladimir

