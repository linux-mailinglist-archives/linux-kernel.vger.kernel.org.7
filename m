Return-Path: <linux-kernel+bounces-743442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AB9B0FEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE96F189227C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE92E63F;
	Thu, 24 Jul 2025 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aosQesvb"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40D2AF0A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323855; cv=none; b=cAXl1Mi0mZcEvDwuSF8Owk/Fzwz0J9o1fuOLV9fxpe9HeOsF/tt+oaGUFEjjjZLT+ItjIPk1IYYvP0GG3GXesY7aGW7ydjEvV9bluCJRr8c3/aMRQvLBP0pFeNg/CYQ8F3c0VQYwvs6o0SA4Fcv6Z9ZZJBDZAs8BzFeEEkyiw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323855; c=relaxed/simple;
	bh=tOs4YYP2lGgetYVk/Z+31oGgEulwyZYfySAc44/5prU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha/dSG2R7tw3/2K7ghjEW2g5ssS9stLTIgMeExISrATR27JIFsds0SzpQvVIsNZh5RBLbxEd6JdlfZ8lebPAFwtyfkDfKRCcKxJhM39B3gHDPsmgUgacqAvviJkMocnOuYpn8ZwNM4rVbSjPqzBo/18cRvFpRK49vMwG5KJGhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aosQesvb; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7170344c100so5698937b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753323852; x=1753928652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plbqbjhGD5ArB2K1OZe2qy+YoPX7JAw+94CxrkAAtgI=;
        b=aosQesvb1RN/bDlK43fg3LwvUKbEDliKq1AklTPGR6xjOoempj0Iwx9vkCg7oNC34C
         ZWLVP2E/dik3xZekAlijgGGIRtqh518uCede6KZxHcni8yQWbmhYbSeZufdoJEB/g1Ui
         izBexMdIgAojlerNAfPvFbl+UY4svhAK1jNokq3wNf2FxJBmc1FRDS0Mm9V6OnK85V+H
         c8b9syAyUqsq7YNwf8WKc+AQ4Zo8x43B0KYUBg20faKATnQt1ZQOOjXhnZOAD+lqvHfN
         2zOQaeEq7RUYDd5+IOL1yaNUuv31qfXfzpszgyBdDftUrA9Wf8i8+yrXuUjhk5VhXH1o
         oiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753323852; x=1753928652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plbqbjhGD5ArB2K1OZe2qy+YoPX7JAw+94CxrkAAtgI=;
        b=e8w8V4m/OlDAaO0FvuzZ2qWYapRw0Vz4lHrI45Hl3Cm4lmr9sdt6uEVueU01y2RWS/
         1XVPvv7t4BLe8TyvL2QngBioIGQsqjBLqd/4mo+jnrERYL1ZjJZ8II4jAeTmWHSCDgrA
         7g0z/UQSaL9WrYa+6RoMVBnK+HmSjuohjONToqpWE5xTFSo7AAq4ArVnTR4hfDiKAuFr
         NIHLInpc4wsrKJ9mdF4X20U9WMaoOfVzwCLkWpyp3JX5/b1xM78APF1ctyMS+nE6MuMn
         JBrDPhlPCFC3ZjrX7hwqE1wSMLSgxPN/XhDVEp3RcJ2+MdLwprevrE1TQ4jQge8aFhQB
         NYng==
X-Forwarded-Encrypted: i=1; AJvYcCWRKn4yjoYAxDRcuThGb/OBHfhoDw0VYzH/rEi4GuYwaRSu+UU3BUXJq4xrcNt5caemxAv9XLI0pOzporM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzouEp7ne6lFk9rspWBBYlojwDaHhsEFPrziCHmV3/fbDBzO75
	LlZNm1+yxsvYK3poRgPJ3wkFGjrJXIlwDZCYoVmAqYsFfGMduh8f8RtLCO18++RZCPNkwwonT7R
	DTMwX1s7JW7lfGQWiTnizucjwIZ/g6nvXRy+l8yEt2w==
X-Gm-Gg: ASbGncviOcLuWPKVsQM1IK0LDriI4X04VkUC42AENrK/FPYv+NIlregbteBM0ampINf
	di2M4oPpQ6qCINcmV79lvAz4tzJkqdqZSFl7KfWc+9NcXJV2ldrWeQni5jiQy4jO7JNu29xHIMr
	gGSTIie1A3xw0/2tjA2jDvumXNwO25VnwV+09HTFU+e9AAR9Q4WFkm7vcUeudrMJMX8AwUQQaXv
	rYQ/Ag=
X-Google-Smtp-Source: AGHT+IFLCRGVWPBVKenBrgCb8KAsi3QO1NHPmUt4DTtA6N603DyqDpRgB5QVxKqVTa0yz2Twj20zCixVG7xRGCICKmo=
X-Received: by 2002:a05:690c:7109:b0:719:635b:a024 with SMTP id
 00721157ae682-719b414973dmr61644717b3.5.1753323852459; Wed, 23 Jul 2025
 19:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722121037.443385-1-ivo.ivanov.ivanov1@gmail.com> <20250722121037.443385-2-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250722121037.443385-2-ivo.ivanov.ivanov1@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 23 Jul 2025 21:24:01 -0500
X-Gm-Features: Ac12FXxZX8EzAUJNlTWvjXuwV24vStrDA_xIZ9oDwGDZ1h66dojGNIklv72yNkE
Message-ID: <CAPLW+4n1kYpGDM=VLgcXU0acxgi_8yY7mv5ty_42fhCOoctL5A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: soc: samsung: usi: add
 samsung,exynos2200-usi compatible
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 7:11=E2=80=AFAM Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
> Add samsung,exynos2200-usi dedicated compatible for representing the USI
> of Samsung Exynos 2200 SoC.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yam=
l b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> index 4ce871676..bbf6d3b2f 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> @@ -36,6 +36,7 @@ properties:
>        - items:
>            - enum:
>                - google,gs101-usi
> +              - samsung,exynos2200-usi
>                - samsung,exynosautov9-usi
>                - samsung,exynosautov920-usi
>            - const: samsung,exynos850-usi
> --
> 2.43.0
>

