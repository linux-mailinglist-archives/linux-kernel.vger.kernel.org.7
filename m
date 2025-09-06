Return-Path: <linux-kernel+bounces-804211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1070B46CE6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE02E5825A3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63396299954;
	Sat,  6 Sep 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLnCaif8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CCE2765C1;
	Sat,  6 Sep 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757161935; cv=none; b=a1H5T4z991R3uiG6pvR97Y3MEcDdzfoUwct9EtP92Ph1A02OC0g42nPL26IC8OG5jJWaa14nO8VaCaYz06wmyEIcPqNC5gKmrx+qZEdMwXhMvtjFMwbufHhOy3fxWe5TfncpGeWwYKteYD9xu89hHnVJe1VMpY2Gpf+YWu1QhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757161935; c=relaxed/simple;
	bh=KFxl/SW/M+WGGzdG/Yu92PCr3g8suGzkoWLWk+39N60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+ogTGpPsH9CIUFqYRi4iI4nlMAyQssb23WKtHFVKLE2aD2ArQmfZUQWNKMk7wiD1L1IjKD6O4DxRHpHn+cgbDMmbKE2dpHL32Ofz9qgcOVZTOa7Lmm7zHIsNxPknsRVtHNDNhQOv8xnlfLXWTRlQ7dtAVsxQVz4ECni7V8PyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLnCaif8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A5AC4CEE7;
	Sat,  6 Sep 2025 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757161935;
	bh=KFxl/SW/M+WGGzdG/Yu92PCr3g8suGzkoWLWk+39N60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kLnCaif8MFH8LRn4ZO/tWabY8+E4/gPnbMVJ4cvDnZxo+jIQjE/GxlohJxUXSt+PH
	 kSSaBCFgbCYlGC+goqcFJP7RQy0vmQkVWANyOc/KjPyDYELw9bgErcvpqTOelkn4f9
	 tGguNvKfSS7X46gRqhVp+OfHoVquR7Y1iXmkJO1bmBIgEjm7NgEULwEvBTyZhnZ1/p
	 ojcAyszeIXR5wCUAC3jnk1Q5ifGgMywBgtlGTUkSvjuw2cizlxxQIKP+Rg3C9UQVFu
	 JW02q1nfDzHLSPZMVT+70Z3A6jjyBQA3Uu7WRRTV4kQ/BiUDeKihzNwCEJXzyIXc1V
	 sfuGGWeLtrLEg==
Message-ID: <eeb4df05-ded6-4cc4-9d6f-8daf08d6ac36@kernel.org>
Date: Sat, 6 Sep 2025 21:32:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: extcon: linux,extcon-usb-gpio: GPIO must
 be provided
To: david@ixit.cz, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250904-yaml-extcon-usb-gpio-v2-1-a5c4afa496c3@ixit.cz>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20250904-yaml-extcon-usb-gpio-v2-1-a5c4afa496c3@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

25. 9. 5. 05:41에 David Heidelberg via B4 Relay 이(가) 쓴 글:
> From: David Heidelberg <david@ixit.cz>
> 
> Without providing either ID or VBUS GPIO the driver is not able to operate.
> Original text binding says:
>   "Either one of id-gpio or vbus-gpio must be present."
> 
> Fixes: 79a31ce03f41 ("dt-bindings: extcon: convert extcon-usb-gpio.txt to yaml format")
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Changes in v2:
> - Rebased and added Conor A-b.
> - Link to v1: https://lore.kernel.org/r/20250329-yaml-extcon-usb-gpio-v1-1-190696e53a0b@ixit.cz
> ---
>  Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml b/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
> index 8856107bdd33b8654812ab9c97e85e23dc2ef75a..8f29d333602b95fe5ccd8464aa64e2d1f0c1c781 100644
> --- a/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
> +++ b/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
> @@ -25,6 +25,12 @@ properties:
>  required:
>    - compatible
>  
> +anyOf:
> +  - required:
> +      - id-gpios
> +  - required:
> +      - vbus-gpios
> +
>  additionalProperties: false
>  
>  examples:
> 
> ---
> base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
> change-id: 20250329-yaml-extcon-usb-gpio-251b66522287
> 
> Best regards,

Hi,

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


