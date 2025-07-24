Return-Path: <linux-kernel+bounces-743701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 151ADB10211
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF21B1C279ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0720C488;
	Thu, 24 Jul 2025 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVog1w1L"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90874217F31
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342700; cv=none; b=WK5AtMwOUqIZfqlvNWgpcHX+UhvK263Yb3ccEtDQtGFKLSRyNZ/uoQQTHIecodbu6T+f3jirkPVuUKcj19zRkXI4C1nyojZx+0LoD2ekZfokrN8GTgZ/EFKCoa+o3jVv9yBmdUvsE0voKpddtMFGr8h5nV5pMQf+YtySwCDmlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342700; c=relaxed/simple;
	bh=XMo5wVnP/DHvbksMe66IGloTgufAjU7VBz1qtOl7914=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY7udqv9CKMSxbl9o7M5+uhBBZB7w7u0JlNg7VZfm3pH5Kaah7bQaASUdc9lv2j3YrMARTHRJDh3KaYj2092hNwMiyQsDBbCucZJzxr4JNC75ohNM4KwFXBATiEKSLsuzDiKG0L7PctU+llsvXW/jmgT4877M+EOo/CSpxmdaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cVog1w1L; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so116116166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753342697; x=1753947497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLS0cyVXvF9oWhEwcV+HClOdOr+8tl26dQR02w38alo=;
        b=cVog1w1LCkwPNESDAwKVkW13L66WAzQsjqkFGHjtUDf8IRdpLjCHh+HuIcOJuJAnUI
         opJZlPGeaEiNvnde1mZs7HXIZMgtszdTH/3hcwCUgY1d6var20r+9zrcB1lwtfLGermS
         dYFMqM+EjmATnDj25tD95z5QcLP5e43anA/D0osfe43bQ9c4Mh8ydQ23kRRqndvVh7dh
         OPqmRQwxK3eDsIOP4pkmkVvsrRzNw2KKXhhY0k4LwF+ZiIlfJdvwpYblfz7WnzaB4082
         +i4u6kK+MqM5XaAQhDjg4WbesTr577P6/07BjDvrJZNAze/hbSu7bfkeLXi5SzgJ1kMs
         WZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342697; x=1753947497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLS0cyVXvF9oWhEwcV+HClOdOr+8tl26dQR02w38alo=;
        b=lK+8+nSOAI8JD/T/f50Wt+wabotxiZN+uGYbwkx/LDbI+GVK5al+Td6cF0mMkygBQ5
         Xv+bJiaHJhz8z0v54EHgLWvcYS9BZ/lbIZ3hCznnnDAQnA5F6ZY61VAyKjoYuGRI5X6c
         Laoc+a69iN+35ezHSZ2v3UbOndHyDPMY5fNu97O70s5TOIrUnKefECzSU0NSas8GM/AE
         UcZzUBAhCWSBHasRISkPQYmV6MRRx9RiTmu/EUaF7bGnijKaWfVV+rqF1vFH02PyMWXD
         xO4LWmYVVvtCAgODr4QoiHcbSPA0xF3lkb/khKGRpnOdD0DiuIWY8Vtk5Pb7A8JFooAF
         aYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHSZg1mIwW4JIaoa5YIgEkYj+dX8ZOP72UTjEI89wVLhc0+WpzuhlsNk7NQyCUfmpbTOZq9r32dwoqxtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlC3JNCOtmWeYTwlefhL3c0rW9e1lnkHrOTnBmxz1BYP0PJrY
	v23Y7G1Xaf67BLit37xJ/H9d0FVNasf0LmFNLKRJExZnleTaLuoRBvyG7krZfS0U798=
X-Gm-Gg: ASbGncv5eWuNS5+4uNQT/0u95JqrWEa0OMXODtVvKjBS9AMSjPrWuXIMe7Pfp2/thXO
	kJM1aCLNotMLd8ORKLRj3tAIGb0UrN/S6VyECgRIoNiTy0qd4F2DfFakdN0rrVr3Buf4/ARr6/A
	xC/QV2Fs739Gyr6uo69VKMlzw5h6TiQM4Sv5ceMBpiXmcLG5AYNciObC+czr9Ns0dm8tk9Fd91F
	LUtDenruA8rFDcqqylbSXe/14JABU7r6ry7V5caDfILyYfiqXeyhgtOgmUx2ISo0nl1XRtS0M/Q
	n2m7Ilfuz4/yWETc4YXSxxnWhy24ID6HO1wS2BzAP8SxpfZ5vSOedCzs2cAp05t+0YoufVq4NH6
	qhvG9LhyDv/NMJLpU9sFkWB2esuGTdCAN2g==
X-Google-Smtp-Source: AGHT+IGduq9hDBYSNTPiUUK+/gg52xU7/5h42fk0D1bb1J2d+0Yxz9hXxWmGJGWnFnoN5N9AKY4J7g==
X-Received: by 2002:a17:906:9fc4:b0:ae6:ae75:4ff6 with SMTP id a640c23a62f3a-af2f9281dd1mr561122266b.52.1753342696807;
        Thu, 24 Jul 2025 00:38:16 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:706f:1fb4:134c:465d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff42b60sm69731366b.132.2025.07.24.00.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:38:16 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:38:14 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/23] arm64: dts: qcom: sc7180: use dedicated
 elite-audio dtsi
Message-ID: <aIHi5uPxAtYARc7O@linaro.org>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-14-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723222737.35561-14-srinivas.kandagatla@oss.qualcomm.com>

On Wed, Jul 23, 2025 at 11:27:27PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
> This move removes duplication.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  .../boot/dts/qcom/sc7180-acer-aspire1.dts     |  1 +
>  arch/arm64/boot/dts/qcom/sc7180-audio.dtsi    |  8 +++
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts       |  1 +
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  1 +
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 56 +------------------
>  arch/arm64/boot/dts/qcom/sm7125.dtsi          |  1 +
>  6 files changed, 13 insertions(+), 55 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-audio.dtsi
> 
> [...]
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-audio.dtsi b/arch/arm64/boot/dts/qcom/sc7180-audio.dtsi
> new file mode 100644
> index 000000000000..d6d41ba93195
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-audio.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#include "elite-audio.dtsi"
> +&q6asmdai{
> +	iommus = <&apps_smmu 0x1001 0x0>;
> +};
> [...]
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 74ab321d3333..0e267b9fdefc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/sound/sc7180-lpass.h>
>  
>  #include "sc7180.dtsi"
> +#include "sc7180-audio.dtsi"
>  #include "sc7180-firmware-tfa.dtsi"
>  /* PMICs depend on spmi_bus label and so must come after sc7180.dtsi */
>  #include "pm6150.dtsi"

ChromeOS on SC7180 uses ADSP bypass, so explicitly including
elite-audio.dtsi for Trogdor is a bit unexpected. It doesn't use those
nodes at all.

Thanks,
Stephan

