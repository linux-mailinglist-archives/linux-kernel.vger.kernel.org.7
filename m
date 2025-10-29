Return-Path: <linux-kernel+bounces-875344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C1C18BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB244019A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EC330FC10;
	Wed, 29 Oct 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONj8wa1a"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA626D4C4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723661; cv=none; b=jlnseMPYqA4l2/4RzSem2wKpO9wsb2GJpcu2GTFQK2CwHJcUWrDbg9Mlv6N5y5rmWZgesVst4qqjfkWdguIkDbOLE3fprVUcvhQxLmhJzT/1v8NxtPqbHiHHl56+zJWt4+V8X/GL0rCsij1VKzNEmR58O576/7HxbTVWtzz1tU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723661; c=relaxed/simple;
	bh=fOAjv7j7SFgxzDGkJ4moXZTVUrxByDzt/RzwZg//8q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeAqJ6VMXGstaMwcJq8jvmA/wneXEnPnJyQ1GijII3BkuXq83uODZAAmzEsaewvXbzJqZh5sBTyWL//6xOSXUmUJqNAYNQtyQoUfvh4rrFu4+RawK7m+GJkFrxjQvKN/vi26lnovfNFgKyX1N7RH7cy4jGIuj3kFsLnOQH8VuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ONj8wa1a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47109187c32so37571875e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723657; x=1762328457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AbFme51wo4xn9EeHD5Qfvqgq+jXrkaUfGgQGuVELTCA=;
        b=ONj8wa1a/ZJQWv/vbEWrP5sGVJQz72UbpQTRGg8a2tWA+39MurjVSuTW4Hf/XWM9Yr
         HiJsEPS6T7ueUG2dFBih6GFKV7ZCa4VV3Ehw0pmLGYbgJDwCIKcJY4Ja9z5vGxo7Z4kt
         NNhZRMcNdrNlM7rAUVkLqaquD3SyEzov+PAVc9crdQSsY6DGYVFO4RXja48QgI0/VW/k
         c6vQRuWCIEuaoEswpHXhBSK4/njqe6MD1CSPbxQXAuG99Rl17C92PrESOvmnndO3JPtA
         CySI3mpm+3ZbXLPNZT9hNGNAcHxmZq6cssTRcnjMQL6QvD0s3vIA6V3rhAIixPBjAl/m
         rCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723657; x=1762328457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbFme51wo4xn9EeHD5Qfvqgq+jXrkaUfGgQGuVELTCA=;
        b=PPHb6+WmqeIE9iHVpJEYLOxq9yi9xz7VMkMxSlFjnIgU866A3pWNBhMjhf2T0VbT3Y
         IEyHxZ7ETcLU8UtNVyM4/SpPzcr4IcVTfLR5MFYDlM0RDmiIqCwm7fF3Me61z2Rcbp7S
         gzKr4jdwCqunkQGC/VBej6NIwBFSQ15e/Nb6vVtnt0OGzErnTiDMP2YjmGCaUigOmaRA
         peGwAV7uJlMNr7uxlsnTki3BzMdZ0fSm7cTzXc19NMXDatk7QYRSlbM9+Owfn9ThSRhD
         343Rpif4UHrDb1zlQXnb5swsHxGyXcQ1TaY/IXVpINXT8R6OOzQl8lIg/4ivcfvz/jB3
         9aYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDffDiMlvHzVTJFu7lB0AwW8R5SZmfRCSYV0p5jx1bzzbj4rlYGXwCHcTcEPunr1NmQFEl8nKcDXuvxqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PQrwkrBhRQpm7CLO3onyCmFJ310FKgodmnQJOZRJjaH3upww
	gUAvnVJsJ1sncUWsYwj7442QxBLSzdqZc2bHCdi56f3/opdYXjRZZ3paVgEhlUfknew=
X-Gm-Gg: ASbGncvb9/UyTEin8ofp3BQHJ9N3a9VOdp22MApQ040fxQfqbUDMnDeXKAAiSB9Nnph
	75W79G9pgYiBBSw+ShkA1DZDlNNIC02r4s++6j1msrcBqWdpI1P3SWXSrviEWjy69TIi1S9Feda
	Tx06qIb9TplEN64KxhnBiePil+9gfKn2MJp+w4mr6WJv/x5rdY1d+GuH9hNeNzj1sO6H7cgZBZo
	c7RLOj7+SdQshqo9vo/TpyCw3d0BE9C9StPXkELI6K0k1yJPOZlg+9S6g2ZNajpqgTsq7UL9ciL
	+q/V85zEmHGv7iOE3pbYctXoNQ/ptcVeXPUnqhYJfZG4/1gBeE85gBI+KiMCSoLe8xaRhJuQR89
	O7LDeG1By/vxjax0Xq9c5MZnx9nriGgXXI9bIqt2YuLpZPyLL7gW1JXrqQAVGA0E4nBIDJifx
X-Google-Smtp-Source: AGHT+IGMnDPTwT/kgdtrsrLOV6KEqnyYwSmrAPqp6vapwMp97UENpV8di+mbWQ4I3pUNNnIxvqWPYg==
X-Received: by 2002:a5d:5c8a:0:b0:3ee:154e:4f9 with SMTP id ffacd0b85a97d-429aef82fe0mr1522824f8f.20.1761723657326;
        Wed, 29 Oct 2025 00:40:57 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca569sm24298194f8f.12.2025.10.29.00.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:40:56 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:40:55 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jessica Zhang <jesszhan@quicinc.com>, Abhinav Kumar <abhinavk@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC/WIP 1/4] arm64: dts: qcom: sm8750: Add display (MDSS)
 with Display CC
Message-ID: <nwyrhupbrqrh6q5yvk6egtm3whi5h6xslhzio4g7f7l7yjx7c3@atl4bbk5f4vb>
References: <20250424-sm8750-display-dts-v1-0-6fb22ca95f38@linaro.org>
 <20250424-sm8750-display-dts-v1-1-6fb22ca95f38@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-sm8750-display-dts-v1-1-6fb22ca95f38@linaro.org>

On 25-04-24 15:04:25, Krzysztof Kozlowski wrote:
> Add device nodes for entire display: MDSS, DPU, DSI, DSI PHYs,
> DisplayPort and Display Clock Controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Bindings (dtbs_check dependency):
> https://lore.kernel.org/r/20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org/
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 415 +++++++++++++++++++++++++++++++++++
>  1 file changed, 415 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index 30ee98567b6078e8225142f2e13b25b5f35a3038..753b069cab1de636a3b1108747f300bec0f33980 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi

[...]

> +			mdss_dp0: displayport-controller@af54000 {
> +				compatible = "qcom,sm8750-dp", "qcom,sm8650-dp";
> +				reg = <0x0 0xaf54000 0x0 0x104>,
> +				      <0x0 0xaf54200 0x0 0xc0>,
> +				      <0x0 0xaf55000 0x0 0x770>,
> +				      <0x0 0xaf56000 0x0 0x9c>,
> +				      <0x0 0xaf57000 0x0 0x9c>;
> +
> +				interrupts-extended = <&mdss 12>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;

No PIXEL1_CLK ?

