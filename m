Return-Path: <linux-kernel+bounces-898992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8323AC5683A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7605434F5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7227027F163;
	Thu, 13 Nov 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETK0wmAc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046942D5A14
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024717; cv=none; b=Ag1SZIPM2FgA8HIBVRA59pdTdZ1DxtHNkWnUqxG6y4LmBnpVeui94sKp7T1EqU0X/vIVzAqQf0B/+1MXIQdOEFcGw8CykIB6zgQYJW4tie2QV2Qna8Rd3QURcIz97ULrOur8Lcsjam1+c+0xfBd1K+L238C1XatDFuJWtB7fz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024717; c=relaxed/simple;
	bh=3UjOMsFb9kbRymmKpTR/5HYw4uxQJJRFpFEQGX6ehQ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CEU/UU0qu3vaoszj9HbxlyqywjH1OiuPBSr31mlCdthiyCRjozSQPTDUeh1q3C9NT+9MthpiOUOfRqIr3nWnKcEW3udfGbSqSAnjurKN1PoZCLy8jm6QFHUY0CLmgqvyPL6f4XDFYhaCRLXIz4AoLtprVKB8gZxwQYCJ9fku3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ETK0wmAc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso3285725e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763024713; x=1763629513; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3UjOMsFb9kbRymmKpTR/5HYw4uxQJJRFpFEQGX6ehQ0=;
        b=ETK0wmAcq4nSLOjQOFfUeAkCIIl+h1s2voNEnzZWznsB18q5WDplOTjpXFmyueQIco
         Ohwhi3N86hVSztcZyWD2OVGTIZ8fAYs3zh/jcXjRaVzboD+cpV58BWFnxj2cCpV2isjG
         rzONsJPUaHwS0T6YsTT7icw9ggCIuCiYNmKwVroxnaIdiwRsON3fDMvMqwDSMDLA1FFU
         tHtDGeEBz2BUcaZ+GSYtjo1kBAq85rIvvRWvARVRyi1OrhfswUww7M5t8z4ApORijDkD
         yhdMdJliL5FhXjxUaQSiqT9nyDjq8t4ALjFV5Q4SRvLZPHoL4Uu5Mw5mvMGSeNJlOUFw
         bdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024713; x=1763629513;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UjOMsFb9kbRymmKpTR/5HYw4uxQJJRFpFEQGX6ehQ0=;
        b=CmlmszdeLV4+f64UugiXncou5lbqedE/BfG2mT9DRbvaUzbWsAXlThidG9Wn0qghtp
         MVmb6lqlHT9jwLdE11arfgUrtnA1y8EK9xlEXqQP9fw0WLOUiGiHP5N/ftvUTZC3a+6r
         Y3AsVjL8pS52Ztxl9dtZLUsnMCQ2MmlYFGh8smu5l0LpspF3ELG2c6avLKj+FsWp+ORG
         cgdsAC8Vq3sNz5CHt3ru/JVrTy71R38EtuaI6svm1bXkgCTmU6Y6r290aFChlRqEr7PJ
         jJbvz4AQRuhEbD4j+4LkLwpeLJ17o7bq5A2Px3VaaTClbUr3G2pIdsuEZWHR5jQZ5c2Y
         H+fg==
X-Forwarded-Encrypted: i=1; AJvYcCUT+RxKbRnSgXtkbZnWJtS+fr0ioj/kaembDL7CGFdAiVTxC5aro5RB5+4jNbcdGr5UH0V3OoD3gbAvnwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lnQoLM+Zc1NcXJ1qrI+hGjvcnjDlvZATC+xPqWLZj6Ba084A
	SvFvYwNaKeWgVlCczgWvsfpaIs27q+vcTczZ+J1+bvJnmq1hbfFl+kmQm3K4OSziJW8=
X-Gm-Gg: ASbGncsdMBJX+hJpSdMvP6o3sWSPkX2/VwVqUCJP4an8eJsdgCbgYM5m9amneVJr2rv
	nPUW/lLeSSJSwMDWhF90HlQ1COSxh1RSZwZI39MfuF/7+yFmUcOx//i00OGiggpm7/pMvJauZCd
	JiX/RBoxr+mUNYywiRcMrZNvX1TbSHfgw3OS6pgvFVhBE1iSGZckg5NVsfdZp3UpqMn21J/BMnt
	j1ZTX4wW4cSQbh4gJmP4oeuFZkbBtxz/qhuXOuoQWwIo94T7Cx5D8UovdDuw1GaW5eqfad6b0Sv
	CJ8GDjgEKwq/KpH28mbqNMD9WCHLaoWJQX5oPM9hBdngHph/NuuurpF12kTVVs8Ksn04abhCGCd
	L5cV6GxN9xG3WdL/qXTMtaUbFtSCp2T8pCQkAQ9XQILBIBVLGdsw/LDO6DfIIcoylN2SmgbYo9o
	trOqH0
X-Google-Smtp-Source: AGHT+IEtWoaffuaVTqHh20HuWI5Dpw76dp6as3Uhkrib83c8uxD8cJiQ4F+dYLKDixdUDUaZQUzkpA==
X-Received: by 2002:a05:600c:4455:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-47787071919mr61751085e9.6.1763024713192;
        Thu, 13 Nov 2025 01:05:13 -0800 (PST)
Received: from [10.1.1.59] ([212.129.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm2532796f8f.39.2025.11.13.01.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:05:12 -0800 (PST)
Message-ID: <27a5521cd7ddbed0e870ac416dc829722f1b36a5.camel@linaro.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: nvmem: add google,gs101-otp
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Srinivas Kandagatla	
 <srini@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski	 <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Peter
 Griffin	 <peter.griffin@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Thu, 13 Nov 2025 09:05:10 +0000
In-Reply-To: <20251112-gs101-otp-v2-1-bff2eb020c95@linaro.org>
References: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
	 <20251112-gs101-otp-v2-1-bff2eb020c95@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 08:29 +0000, Tudor Ambarus wrote:
> Add binding for the OTP controller found on Google GS101.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> =C2=A0.../bindings/nvmem/google,gs101-otp.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 56 ++++++++++++++++++++++
> =C2=A01 file changed, 56 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/google,gs101-otp.yam=
l b/Documentation/devicetree/bindings/nvmem/google,gs101-
> otp.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..ea87216761dbab9a7a5cecd87=
a553a6a2a1783f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/google,gs101-otp.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/google,gs101-otp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google GS101 OTP Controller
> +
> +maintainers:
> +=C2=A0 - Tudor Ambarus <tudor.ambarus@linaro.org>
> +
> +description: |
> +=C2=A0 OTP controller drives a NVMEM memory where system or user specifi=
c data
> +=C2=A0 can be stored. The OTP controller register space if of interest a=
s well

If there's another version:

-> if of interest
-> is of interest

In any case:

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Cheers,
Andre

