Return-Path: <linux-kernel+bounces-813471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD318B545EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4EF7BB19E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209971A3142;
	Fri, 12 Sep 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mp9CRmyS"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F225D202
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666945; cv=none; b=eDMKtbL6YbsysZeXQsL3ZZjyyRiK+Vxp06Hm2aO73QzaXLRGxAyNZfAN8KmzcmcU+KGFRh03u97GZjCZhCD3JzDg4hnu37tv9fJVovegfZbu4lgD+7KkP86RgG7nVguFFzRn9PEcG3JXYxoj63zng4FFpfwQcHX4tbtwLFr2F8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666945; c=relaxed/simple;
	bh=VXPyr1y1eVb3aoiXmD/7gslbuD5LlgKzM3CMrgMbH1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPb29awgWENIQmQ6tnK0C7jmRR0be6V22OFAhpKOC1K7syC1B+S+5u3ljcN+pfiAPqdhW8i4fSXCedsmizjJTJwGSnBNt/X5WmrMBqRUJKGFiTUhJR7nr6jvy+e26p1r7GoAFq1JUQyMuhQgmHtYlDfZtptN7vFmZDeD8HH/usU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mp9CRmyS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62ee438dc1bso487550a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757666942; x=1758271742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZvuOQturzsBblI9ZHMQg2RAl3gTfRHzsPsS+SgnjjQ=;
        b=Mp9CRmySAVvQXCThqurI4OlhnfaG8HiOZGOZpLbp5Jv8MAUpk0OL12UnbgFDnuu7HN
         X0/r3ksAD+BGu6KUEPEiuQQ2e3BMwPD7IAdUmTcbWdE2CpBATelSXM0tu27B50t/FqMc
         JoRSmlothzWaYATjhemgdhLF1LysUTZUQom/KZT1BH2IvhGxylihwNu/FIobVHAW90sS
         /pfP+tqq8pcBfR45BWcHfi6WLTAnUENNmQ2QkFqb+4AjCz5RX198mCD0TG0dJeud6P5t
         2mhyXsG+al4hNcAY1imssxHBUlChKNP2IqtO9gHEAWt+G7T1R+H9/Ap2GtvVu8+yNyOj
         px3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666942; x=1758271742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZvuOQturzsBblI9ZHMQg2RAl3gTfRHzsPsS+SgnjjQ=;
        b=eW/s4GueMVqyiAy7XgZPa332+16SAJ/cDsbZr2JOoqMmNgNAe1SDn7pdHO70Vi5kKp
         EdsXfcPKLv2VrmkG/6N9AnkcHUS5u9hp0emWRk/wA0ftQeZwavt3yl54UnDjQJB5Vhey
         O/mGzK1bHdzqWGFN9Q2RvVBZrK2BUz/0+sm8KckNiPnpG9g8FtxWSF4sz99JijuWMNtU
         yp++RRUI8dfhdEdfmgb4Q8RVjYR2c06n5U0gijJb7E6z1YWDqyBht2+VDxz9vS47JKQj
         pfiia9nNG97kYrxe/SZmG/75RQIFtfdOlX/xissR9XAKdINeOe89johwPTOFNgggfp5b
         465Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZHhWRy7zWTOeF6KCk812WSrOfjgzt2VQiUp1IMku51GmQQpoPe44rFFgnjSOfGv7bgpAq3D+h8nnLwqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvILuA+fB8obuurBek9HSDT4xe85lUfFod4OkL5FAWulXSOn1/
	otBsM4iWR5bM2hT4OpR6hhNT2gLtUR8A7FI6IlYrflcNp9etJUS0pm63g+rSkf8+T7NO5RYxJBd
	c2JbKXb0=
X-Gm-Gg: ASbGncsfV1V/wYT/VPOAj7MlY1NmI7GTqSOeKWjNGPGXnku9g28L3PQdwqBzYN53HIK
	Cq5rU8Wukqvmmawu7/kdkEun6BbTL0Acz/5sMDp6QT0BU2oWLil+o29EoQxKSpqNfbVQ+rpsIZL
	Ean5Bg9CuOoQkzHzft90rkqO8MMw2LF9+WgYIdR2XkkawMkj9lpYlcf0PXM7OaWynGC6M+yplmo
	BAzUuM2ApZDmRdntZ+PxrdNpdzc7iIBhoxA+nQuodjcb7TqsYkw5gEXrxq+uKislgak6opBbYlD
	oO5N8KpZ+dOoXTlVwyuLyEleflDx6W2wYowyvSXGHmmkPb4KvnvgLbU23wfK8DrdyicbMUex8P2
	nlUMA9nO4pLLwuvWccg0Pc1TJ4DM4SaDqKGImsu/CFQAeVZXqUKqLXQ==
X-Google-Smtp-Source: AGHT+IGIKDkSMzSm94IREaUAgReqwpKS7jzXgP9plHNzao7p19K/88keRhVXdp1JRes2jLYeeNrSFA==
X-Received: by 2002:a17:907:3c95:b0:aff:1586:14c2 with SMTP id a640c23a62f3a-b07c22b205dmr282086066b.4.1757666941812;
        Fri, 12 Sep 2025 01:49:01 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:5fc2:ee41:2050:2d49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f1e54sm324549266b.75.2025.09.12.01.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:49:01 -0700 (PDT)
Date: Fri, 12 Sep 2025 10:48:59 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v11 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
Message-ID: <aMPee9wEOrrW-KMU@linaro.org>
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-3-38ed7f2015f7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910-hamoa_initial-v11-3-38ed7f2015f7@oss.qualcomm.com>

On Wed, Sep 10, 2025 at 05:02:11PM +0800, Yijie Yang wrote:
> The HAMOA-IOT-SOM is a compact computing module that integrates a System
> on Chip (SoC) — specifically the x1e80100 — along with essential
> components optimized for IoT applications. It is designed to be mounted on
> carrier boards, enabling the development of complete embedded systems.
> 
> Make the following peripherals on the SOM enabled:
> - Regulators on the SOM
> - Reserved memory regions
> - PCIe6a and its PHY
> - PCIe4 and its PHY
> - USB0 through USB6 and their PHYs
> - ADSP, CDSP
> - Graphic
> - Video
> 
> Written in collaboration with Yingying Tang (PCIe4)
> <quic_yintang@quicinc.com> and Wangao Wang (Video)
> <quic_wangaow@quicinc.com>.

This looks like you should have Co-developed-by: tags together with
their Signed-off-by: tags.

> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 621 ++++++++++++++++++++++++++++
>  1 file changed, 621 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> new file mode 100644
> index 000000000000..c7c3a167eb6a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> @@ -0,0 +1,621 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include "x1e80100.dtsi"
> +#include "x1e80100-pmics.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +/ {
> +	compatible = "hamoa-iot-som", "qcom,x1e80100";

Undocumented compatible (without "qcom," prefix). I think you can just
drop this?

Thanks,
Stephan

