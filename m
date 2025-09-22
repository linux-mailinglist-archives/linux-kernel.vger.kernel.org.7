Return-Path: <linux-kernel+bounces-826841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FF0B8F78E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CFF1894F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE002F39B9;
	Mon, 22 Sep 2025 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esNX0wzm"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36AE248F69
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529324; cv=none; b=HBrHPO2kGLq8Ykp919UeSuW52lt71vTzVNbs+BoSxwgLCPrV2AS/1ihI3LYY+hPQs+2q4sDiNfnbKbnTqosBOg2nFJxLRT4qwYcvKyCzSyRSTFenebMAcnCvZBl0sNZ49AavXcwJqx7NF0xKVgrw+bYVIyVmRpnJO+O7BBQYl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529324; c=relaxed/simple;
	bh=hpXjIWjocmQg1IGQK/bNuOPK7P1EOh57IUJcZHoUUYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm8ER7wjt8w4A+36k7CZr+rBJz/hWy72H5bHcf48+nTbSoCGSKAcnp0pVnM3QF4OWk0TI2p3nMgcfCECvNKablTxCgA23sGgskNSY6QsLeKaf1kM4QQgyZo2HOn16xM3Fdvls/TEkq67CV45ECtv1lh5zxHvX9M4ikj1cmdjnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=esNX0wzm; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so30199755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758529321; x=1759134121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8T3m1gUsOj1mNTOZiLoeJIujrUc8nMWQoqIU1R+v3o=;
        b=esNX0wzm8x7d6VvkNGjRNhq72Lzt2Y4kyaWY+qNo2vPbXV8TTlP9HCFc0sR616YBfV
         gHNo55h4TJhVQ/jKnzUHbEsM0Rp/0kTjhTudADv+WizEe+5t/v5W/vj0vB+Aiqm9QO8P
         6ZR3JuJw+8hMXWJwSCNP14oRrbjJhS4PpCQpucs/5957QS8yczN7w+HTjNKG6w//QIZW
         dFIHiqC58y41I2SClfORMqH41jQUGES/8baB1DO4/rwz16e6BPSVBqEwS+RzeSK4r2Ra
         glnilo8ZnIFiat4XB8K0NfKdKX7xsecREk53Mbg9hedyI2VrunMoqoCRsadyitBl8Syk
         WNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529321; x=1759134121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8T3m1gUsOj1mNTOZiLoeJIujrUc8nMWQoqIU1R+v3o=;
        b=KqI+I4pOpJ9zaAsYwOUPwVU5EyGfk8jpvVo2nRCeClDwpkS/+SU01qNfk4S+TEwa2P
         bQ+uTqmfR1/XrxxuA9PAG3df80pdQR9XJmFkxlgM8uG8Sm7pgHySNBTWSo8U5RlewmId
         bqKjS1/BRzVUm0GjGdpyS1yRGLJzF2GDbid/nZt8aaaf8e1wIwlrQLVzk2+qyn+WK4NM
         va1QGyoFz41LncgLBF1qyKHb0y92OO15BrOflzMTHxP7Xd2rDqr8LnV6QTWGjlzubTOe
         4yY2K9PmtjvFeABVkHWCWUHE5K+bVVeNxFA860CrkuFBEBInaFE2h8cTh0gCp0q7TprB
         B6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0MTcyPeciBYWLxVlBUsHglp2NVuaAxBztQn2cCCUmL6bR3FtH6kgGprcys/GMXdJ8pWQe/PJu5ZB7GuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdF6YPCgiDFnsB8URM1kL3/JQ8Pe/YlrNPakIV8+55NmyltbVt
	havBc29fh2ZBgpzKE3DUYryJTk+RLqjitMbRTYNOIrsT++Osb+rUYL1kQmSI9QU9g6s5Usxi7ZJ
	nUYknWWwSQw==
X-Gm-Gg: ASbGncssQZ7yQ5LI6HDdn4ynNS0gmQpRCSxEkgau0YzVZFoLBa/Mgt787PNXizvMekN
	NehDRT5sVAf3lBVM8rW4LoPR7PJEk3H3JoIBjdg0XTUY05BlFESGV7qgxSbNvWsqpHTgfaxCqrI
	e/CzzOAFful+ozKCCVDcTwx6CmHQZ0ATM3V2CvkUhV9rH8D86MuRS2uGBMVtPepwb2G7qKLxE/j
	3cqi6e63JJnY0X/QbF0tKI7nHkd9kb4uU6i7hl5LPHZCRnErf7saBP+fBKbfBTqdezrHCmzRs0M
	amV9PJ4j7+03J/wb9iIejRHD0gZLQod/OeSXTryAIG/+NxNVuIwWiulVizReSnRvkyCBkpu6UeN
	kdeUUNedeB8LrA9b34KYp76vcjZDZd0PS
X-Google-Smtp-Source: AGHT+IFEeWcqrvmBfhuXFUAZYNAGM+LTG1i1l9VAl8hYeXesYUWH+BkcHK0X7YePLj4Vt4ebLu4Crw==
X-Received: by 2002:a05:600c:1f95:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-467e75ea470mr111029515e9.7.1758529321120;
        Mon, 22 Sep 2025 01:22:01 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:c61f:42e4:1d2c:1992])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139122cb5sm228556515e9.8.2025.09.22.01.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:22:00 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:21:58 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/12] arm64: dts: qcom: Add EL2 overlay for Lemans
Message-ID: <aNEHJv92i8NlaSO3@linaro.org>
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
 <20250921-kvm_rproc_pas-v3-12-458f09647920@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-kvm_rproc_pas-v3-12-458f09647920@oss.qualcomm.com>

On Sun, Sep 21, 2025 at 01:11:10AM +0530, Mukesh Ojha wrote:
> All the Lemans IOT variants boards are using Gunyah hypervisor which
> means that, so far, Linux-based OS could only boot in EL1 on those
> devices.  However, it is possible for us to boot Linux at EL2 on these
> devices [1].
> 
> When running under Gunyah, remote processor firmware IOMMU streams is
> controlled by the Gunyah however when Linux take ownership of it in EL2,
> It need to configure it properly to use remote processor.
> 
> Add a EL2-specific DT overlay and apply it to Lemans IOT variant
> devices to create -el2.dtb for each of them alongside "normal" dtb.
> 
> [1]
> https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |  7 ++++++-
>  arch/arm64/boot/dts/qcom/lemans-el2.dtso | 28 ++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 296688f7cb26..e2eb6c4f8e25 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -35,6 +35,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
>  lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx577.dtbo
>  
>  dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera-csi1-imx577.dtb
> +lemans-evk-el2-dtbs := lemans-evk.dtb lemans-el2.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-el2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
> @@ -136,7 +138,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-vision-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
> +qcs9100-ride-el2-dtbs := qcs9100-ride.dtb lemans-el2.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb qcs9100-ride-el2.dtb
> +qcs9100-ride-r3-el2-dtbs := qcs9100-ride-r3.dtb lemans-el2.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb qcs9100-ride-r3-el2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
> diff --git a/arch/arm64/boot/dts/qcom/lemans-el2.dtso b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
> new file mode 100644
> index 000000000000..55a2a9e2b10d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/*
> + * Lemans specific modifications required to boot in EL2.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +/*
> + * When running under Gunyah, remote processor firmware IOMMU streams is
> + * controlled by the Gunyah however when we take ownership of it in EL2,
> + * we need to configure it properly to use remote processor.
> + */
> +&remoteproc_adsp {
> +	iommus = <&apps_smmu 0x3000 0x0>;
> +};
> +
> +&remoteproc_cdsp0 {
> +	iommus = <&apps_smmu 0x21c0 0x0400>;
> +};
> +
> +&remoteproc_cdsp1 {
> +	iommus = <&apps_smmu 0x29c0 0x0400>;
> +};
> 

Would be good to disable &iris here for now similar to
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=c0f045e303e014cec5d883edf82fe5de74769944
(I'm assuming it is broken without specifying the iommus?)

What about GPU? You can load the GPU zap shader in EL2 without further
changes in the drm/msm driver?

What about &remoteproc_gpdsp0 and &remoteproc_gpdsp1?

Please make the changes in a way that they result in a properly
functional boot without errors. Disable functionality that needs
more work before it can be enabled in EL2.

Thanks,
Stephan

