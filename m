Return-Path: <linux-kernel+bounces-790550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89875B3AA1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015C37A8522
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A362765F7;
	Thu, 28 Aug 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWUAZ8QG"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C22765C6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406181; cv=none; b=uZrVpoMBUDFqrlHfZH06V6GBbMcNbzCli80Bbuce4VO1xkydXuOu/GVx7XJCMoHeQ0AyUza0wck6opQ/DQrxYNFRoEzYsvP17xi6Uyoghn4GFMveQntitT9xdxkfMdQ3jDTvmjEVfioxkM93cehbfikrkJ11PeZ7XjrKzfdrl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406181; c=relaxed/simple;
	bh=KnS0W5Hh+l57/+HU4seoQni4gqN4R0ph3BTOOgn9K5U=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:
	 References:In-Reply-To; b=G+vwYM+MAYWryl6XYSCrrCA+bdR3nDkrgRwfKGUqfZgAIX8xzvOrrL2g45zOOUXO7OEoKWXSPSw4w2RRoOeJYqWrn0fQKnCy/qHQBYO/mcwUTcKYSnG8J2ATRT53Yw7UQCL5yku0pRiMorteIx00sPZdWBd3BRDqDexTDad8ff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rWUAZ8QG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7c01a8c1so7654445e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756406178; x=1757010978; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plZI8iRSPLJkfX6UA1rPXxqj9r/osCRLYPnrr8iFbR4=;
        b=rWUAZ8QGhMMvS0akYtK2z5rtavFNN4QLlRoCytrcKoUxwnowVWDAw8Ad1dvgXaKL4B
         2MYK8frV2PEnKDtIBcSNbOfHuvi9rVvVZOxUgM441+awi5yNGoeF+WbQ6V7zsfTvlysW
         3gECyADklaR6TOVs3JG6UJNMutfUjOzs2/yCXnGBniaWvIJq2hQqBx2wI0FsM2NO/Cgr
         omHtjis9ZJhO/oT8l1Oi2MCjz/RVUTfExGleFFT57ihhB0LkvbpD+CoEWm0ATKWJ7pip
         2cUFBI1nJ5wK0U1+xIxjRIMg1Xngfk6Q+/MbaK0UukpOoikVbmFXUOl3gv5cL+E1keG5
         QrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406178; x=1757010978;
        h=in-reply-to:references:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plZI8iRSPLJkfX6UA1rPXxqj9r/osCRLYPnrr8iFbR4=;
        b=HRtCRUrpdFziZKIX5Vn12ac9sxt7XuSG4pMmlwla/GKyDYcQGbGWiwibuGsF3IbtSo
         C4BC30KOqBuEoIq+X9p8Z2HMmvk5LaT9htrZAf0wqGDEDWoPOH7qpqtF2sllBTrEE3d6
         T+3OE4TvOtin5twrTVWk9X8ivmGGwmXNSv2WK85yptumrinDHd+GRvYXqLxGW0C2tfpI
         UIVtVXDst8t8Muj8/t1H3177MlxRkXmx7kQQO2IAeKh6jo+n+Vpn5+QdivaSt6BsqhoK
         q/aA2yuzb4rZ83MAHM5Nr9zMrkg/07RHy5BivrKpCUxsDk8pew6kY0njKTRWRsgCzMv2
         TIvw==
X-Forwarded-Encrypted: i=1; AJvYcCXiG9pkV3Qj5g41d1E10wEbWqNDeM9DQPAIOV2vMm0l4uwDyxxFMYmAIv4XRE6WSgvrRHFrhScVBUtaZ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2CyBhtrejz6KaAGAr5tTZVjyIwNZ0dGjzqXVzVcAbOwqiYeW
	P/6xOgzu1yOYpBJa/whRHk9f8AxlnS3fer5WhoGwPTBZx/hM3FBcCJfaWWKRKVIeVQE=
X-Gm-Gg: ASbGncuCm90LU6Hrvh40UyvwQyXP2ebWbIotJgQfUksxSQRKG2mXXQHCHSmm5PZGT+/
	xn/X+03y+LT6oRaNMnjff6pNUqE39ZuXf28Py5GJkgS1Oiz0CNKVgkhcQ9/5QylM750DTQZm7UO
	jaJbIaQ9VsfZEfHS6FMo+gc8+FMVUciio1m/sUBxV9qqLqhahmFQUsgs+CjqCrHBoh1W3Pbp0S6
	mMZ5H/14c64/rOkuDw6OskKxR3Z4Vdhsxp2wcPQ2oejX+xagRIdglNePDfOURv/O4GduGTKhLyd
	jLeGc1quTkL/etWPZ2pFcVqNAu00NNDcEr1Ar79TFm3/ed7E/AsBcudQguHo9F6JJau8J2EDT3r
	JLkZDGvTA5fiG9WFI3T8geRZemaEe4ba2f5ib71gZHgUh2bH6l5KcdcktHjnGBW6T9O2scanh
X-Google-Smtp-Source: AGHT+IGHfFomVo9e9hFrlPBlCkmuNAzoJAz+YrbYrU3TW1g1KlnphdMtRrEL5U16asEEEUzAcjip5g==
X-Received: by 2002:a05:600c:1f12:b0:45b:629b:dc1e with SMTP id 5b1f17b1804b1-45b72ed0730mr46781205e9.1.1756406178218;
        Thu, 28 Aug 2025 11:36:18 -0700 (PDT)
Received: from localhost (a95-94-245-170.cpe.netcabo.pt. [95.94.245.170])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b66cdaaa6sm56782795e9.7.2025.08.28.11.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 11:36:17 -0700 (PDT)
From: Rui Miguel Silva <rui.silva@linaro.org>
X-Google-Original-From: "Rui Miguel Silva" <rui.silva@linaro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 19:36:17 +0100
Message-Id: <DCEA0YL5MK30.3VV18EAGTGY5O@linaro.com>
To: "Frank Li" <Frank.Li@nxp.com>, "Rui Miguel Silva" <rmfrfs@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "open list:OMNIVISION OV2680 SENSOR DRIVER" <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>
Cc: <imx@lists.linux.dev>
Subject: Re: [PATCH 1/1] media: dt-bindings: ovti,ov2680: Use
 unevaluatedProperties for endpoint
References: <20250827194919.82725-1-Frank.Li@nxp.com>
In-Reply-To: <20250827194919.82725-1-Frank.Li@nxp.com>

Hi Frank,
Thanks for the patch.

On Wed Aug 27, 2025 at 8:49 PM WEST, Frank Li wrote:

> The endpoint ref to /schemas/media/video-interfaces.yaml#, so replace
> additionalProperties with unevaluatedProperties to allow use common
> properties.
>
> Fix below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx7s-warp.dtb: camera@36 (ovti,ov2680): port=
:endpoint: 'clock-lanes', 'data-lanes' do not match any of the regexes: '^p=
inctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov2680.yam=
l
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

LGTM.
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
    Rui

> ---
>  Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml=
 b/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
> index 634d3b821b8c7..ec5c40684b6bd 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
> @@ -58,7 +58,7 @@ properties:
>      properties:
>        endpoint:
>          $ref: /schemas/media/video-interfaces.yaml#
> -        additionalProperties: false
> +        unevaluatedProperties: false
> =20
>          properties:
>            link-frequencies: true
> --=20
> 2.34.1




