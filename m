Return-Path: <linux-kernel+bounces-831959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17413B9E02C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06ADC7A7B91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC642701B8;
	Thu, 25 Sep 2025 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQYh4Mpq"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F626FDB6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788149; cv=none; b=JMdHN2DT/WBZ5tQrIQYH09S/Ih6rd6sURlew4HsGU0vr6rm812eBN4e7Q9ukjdCWjGsKwGSuJnLr7ZnB4nFrP0aATU0CxpUWuk1G+qwCWQK37fVKvm44znuiT2WrUc2nuqO76/JHQ6HwT0J2ZJt89TPf7+jlgfMBk0FI7kCdGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788149; c=relaxed/simple;
	bh=3fXiUWYjGWKVqU8lMvQIlNZWpDwmv3kekLmduLvwx5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzXtrOmgbwXAzXqBq+Rjlrq9eYNFRdKpAKu5/ztgFzPqgNEunX4VCpPvMWIDJBt4j9Zmin1Nu9q6HyqONaGlsdjqFg7yz/pxPF9Mr9saOrmIck/zxweoILo50yFcbdd6td7y5/GRqtwiHMxYm5LSL7x/gfwWo26k4uITOieLLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQYh4Mpq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso801908f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758788145; x=1759392945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIk5HEoQc9fl5mBS+Avjm6Evc+6IXsiML5Ejq5Yzfmo=;
        b=qQYh4Mpq1ICQ7o9JZ2hY7Ry8ZlcS4f3PJF4waW4iKHyRaLmqSMg5PPSvhZcyosz7sE
         y2pD0b8wyBNkQ4FLNympnFqKJ24yjC2Bl/t4n7NVH071WbGmoVQOG0faa0m3AwKaK1aq
         0lXSH2OmiyavjD0cdjJZYicvicTDB+BVEOsQR1UhQepdCUGjARQcJKX9oHDZy7ZXozsK
         sk9nkD336JDueIoakmfr+iFhz65qwyDw3O/m3EbgnBd+z4ewHX2u90ObMT738tunrGQx
         iuStu/ZNXwuZHVb1UCiBdlExc7zmjT7wI2DzMcYZ+FLBScjtTmeWr4bpq9+bUXVdmoc2
         lEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788145; x=1759392945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIk5HEoQc9fl5mBS+Avjm6Evc+6IXsiML5Ejq5Yzfmo=;
        b=FS4kh6rJA7FIYL3/4WDi3dTg24DTcrOFuCdynhlEynyW0jH+rKjsCOlfnGcb8PrBdJ
         X1MOsQCK6QYe7QFCrojc5sc9ZMHDxl4OQnVsNV81oN2lC9g7WcQMblU2rROyNbt7TXFd
         khTvav5t1wTHKssg+i0c5FhSLQrjFDj4uD6PpfobIQBef9ETYB8GplGIH3dUd62uL/+m
         KknTLVygy5NxSJsKuhqT9a0YX3o69POg7j7INJ8CLBGe/ZszANAw3rHP65NWzyjZuArH
         VC3GvJsl5K9NUk0iXXNHzgUyuLeO3tSGwh5Nj2mXKu9oIFi8EALcXZeDpM6Ld1Y9iiAo
         MSjw==
X-Forwarded-Encrypted: i=1; AJvYcCXxfQ/HL5LFAEqAZ12L1rk7x1hQtDHzVtA+lziAyXs+ebDS78BtwaE/ORfoZ31Hr9UHiOj2rfMpLifFPu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9W1c5wMYeGRTrn854JmcZIIOuS//4GjwWrQ/KLFRkjQpQUNf
	Ajd2VIqXDxIuu5kfYqfOq/vVUjgpxuuUNCMK6X7c4boy8Ad7La7gat+Ag64Fn6slhbc=
X-Gm-Gg: ASbGncvDUIVuxdX/cpiR7vPkpn11EveXFS8vHlPgeNxkNDq+l2KY9WBpQ0e6pEYby+a
	TziaqLfdgiY9Xgai45jkVOUQC3wR9pdYCkyCfPcwSvUYh+CS9oDRjk7RSqJI/Dz4m7fcE96f3Ms
	j9JmypbiPDndhirDIc68ItTCNKfB2zHcvOBpK8oLC5zB/oFafLLqLF9f64N4UbN8bwoxE7bRu6I
	yu8Adong7s+RbJwXqYcguRiGoh3LQtfqA7HRh+Z7bBVLnPQjyPlGfwI8rMKOGsNqJm6aIJReeSf
	RnEPCA3J7a5H4WJZAsx6/QSenRJgrs6IHE//Fxq7niut+mfWnpdayFTGYKGP0dDeY5IA/8/5cYY
	wqGi9PGrpY1S9rERuVRVDpw==
X-Google-Smtp-Source: AGHT+IGLlMgfoOBrZIGbeZcCuMdmxs/fw9AstHCHAfmextzt2Ns/K8P+iRRUgzeWNUsYJXxAK5jmvQ==
X-Received: by 2002:a05:6000:2385:b0:3da:d015:bf84 with SMTP id ffacd0b85a97d-40e481be8a9mr2735250f8f.25.1758788144740;
        Thu, 25 Sep 2025 01:15:44 -0700 (PDT)
Received: from linaro.org ([86.121.170.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6de90f9sm1888711f8f.48.2025.09.25.01.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 01:15:43 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:15:42 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: Re: [PATCH v2 15/24] arm64: dts: qcom: glymur: Add PMICs dtsi for CRD
Message-ID: <tsh4w4paux3g772ynjcbjx3ntz6ynqx2ucd273yz3ncscxihjk@dwwjbcqyheuo>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v2-15-8e1533a58d2d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v2-15-8e1533a58d2d@oss.qualcomm.com>

On 25-09-25 11:58:21, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Include all the PMICs present on the Glymur board into
> the glymur CRD DTS file.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts    |  1 +
>  arch/arm64/boot/dts/qcom/glymur-pmics.dtsi | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> index e89b81dcb4f47b78307fa3ab6831657cf6491c89..97f6eedd7222368f5cbfdd02e9c4d87261d7f19a 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "glymur.dtsi"
> +#include "glymur-pmics.dtsi"
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  / {
> diff --git a/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi b/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..59dcfb67a203a7c576406037377fc9fbdce51a97
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#define PMH0110_F_E0	0x5
> +#define PMH0110_H_E0	0x7
> +#define PMH0104_I_E0	0x8
> +#define PMH0104_J_E0	0x9

These haven't been used anywhere.

Maybe you meant to define the ones suffixed with _SID, like so:

#define PMH0110_F_E0_SID       5
#define PMH0110_H_E0_SID       7
#define PMH0104_I_E0_SID       8
#define PMH0104_J_E0_SID       9

and without the '0x' as you will get a build warning about it.

> +
> +#define PMH0110_F_E1	0x5
> +#define PMH0104_L_E1	0xb

and here is an even bigger issue. If you define it with '0x' prefix, then you
get the warning, but if you drop the '0x' prefix it will fail to build.

I'm sorry to point this out, but this hasn't been properly tested.

Thanks for the patch though!

