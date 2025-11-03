Return-Path: <linux-kernel+bounces-883237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13CC2CC30
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD78734AD25
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A3321426;
	Mon,  3 Nov 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thBus7QG"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C132143A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183587; cv=none; b=IXEH7PZdtzFgSc3+OnFEii3+BRGypI1yU1QiD1rjsf3DC5w5Px51pWbRrsXuVRtl2IQXcb/Lr/m0DKEP+EKl6qaE/22fctN6F/2QlHLma2myQwkJyMJZHLoTz5pRNUf1Z4J15V3M/wxVsJvHrsI2F6y1x1VPVqAEIjOclxeIlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183587; c=relaxed/simple;
	bh=LNcKl9NMpb4FaNICRc4QFad97f639UCgC3oeB4HPq7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHcA4JZnvjItiQ4qLiFspJoFI6I2WaYPspOzDfjV9Fmavy1XUZ60YnQpXszi5wuQgu9xhao7pE8b1OxTLAkHKaX4zL5JPw4UjYYwlt6JoDgYeReOAsTe4uATUe3cIEFNOZAFthUceJjvinyjcLpCK5OiwQhA86gTA8kV2FJQEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=thBus7QG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c2f6a580so2539729f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762183584; x=1762788384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYMdtutpV/rdxaTZKfb/5sBHxK0huqnQvLXOA377vu4=;
        b=thBus7QGWoMS26HD0Q9lZ4QqksHuk/xtNOEVaV5cVLTc7IVQ9kuaimGY47EX5XlHpu
         LlpQnp62WoRnlQG2E8twVuHlQ0PVsxvdDLfivZWO7LvGtuoFhhd5dtnhMRo38oi5umuS
         3SiYP0YDSXooU5DoOD4B8cZNh4SH0IZbTrHYwDVCggOb5qo24aXBtcFxTGiL4neVdRa9
         64aYm7mmdtjFEeJ753Dslrp9OGrZAi2rx91AWrcbJeC6yG7M8qNWvPRclduuEuaJWllD
         N+6Los/UHUaPdMe22jrpeqcpwlZtS2kPo4e97UYf5Pf2gS910LeqAUv6Nkbovb9d/RT+
         RS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183584; x=1762788384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYMdtutpV/rdxaTZKfb/5sBHxK0huqnQvLXOA377vu4=;
        b=VSrz+2CkfTYoHgKCwRAt1KJS4oiUpAgCkFcvKw7DD2hjOcnVlwpu4eZoZ2Xw8o8zQb
         aBHSz760EVCz8Tz2Unc6o7yxv53mBt7YVchiftK6xgsun0Wp+SneUDazaLNb/3H10kLg
         jYsSquS2BAiY0IAuij500YQz6M/KmdRFr6uUoqCy3X31L4SnUs7QT5da5MlHWAmNusM5
         i4HxhIKlCRnzYxaiTIX+Ex5fVcgA8rrwyMj7ETuVxvPBX+4XybXvJyyyNe277y2yObTn
         ZSvEIpJj5JVzcdYgBV1fehwhM3h/hPgH1AIYGGb5u/H+/b/UWGZNPt95XZYZpQCXGWld
         5U1g==
X-Forwarded-Encrypted: i=1; AJvYcCUYAIHgp2FRYQrITa4gka8YixqQsMrd65q7XzDWskeqNW9fIVVMqweoGqZjERVNo6hh8fBv3aSIISdZDh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9xjkNIp92lefrH6eJIK033aNxF+qTRJUyjzs1eKaYlZDTs+v
	wKl+vVt/6v1Pp9G52kPWaE0TkE5JkYODhp2q2N8XbVhWUW/9puRHL0wZrGlLR58rLSg=
X-Gm-Gg: ASbGnctUGTLUjg5nqxMcIoY9a2QPsfbkG6bfbXyqqFCmL5AmjBn3rXpBIxnV9ngopbD
	sllkMrLtFAeiT9gUPQ3bF2hZtkPz9Zv6BDs29TP5ClZ1gbsnRVlbLj02nuHAipFDWd3MyhkDOgW
	LEf41fbWnpqqeT6dJuEXEY4TEn7c2kO5Hr+o/yjdoRKkcYUUqdIeP2169S41ovP5XShCYuXWt96
	RhuU51olg3XpgHUEu4lZnSpkRQyxmBYb5ComaTHqHR1Zp36uoumh+O6HVnfl8sAx4QmFY+omouw
	EGN6kCOsWIpckdV1YRgEiUNWATwTgtUFpqD4N6fxSqE75dx1eQfLJ+CGstMTVZDxHqNfbP+KBF+
	hDyJBRrHExzCwj8Bg5h6Wl3qbUrLJ2GyrcbjwlQhisx5ySr7wj9SYBJsCWCs0di4UD6+ZVCml1l
	IwHQzfKQg=
X-Google-Smtp-Source: AGHT+IEsr5m6w2R6Za9p2OQEXMw3u7Wecd+dJbxadgAKBtNus+iiq1UhdwMqQGyKnH5KHjwevdv2EA==
X-Received: by 2002:a05:6000:1849:b0:425:7406:d298 with SMTP id ffacd0b85a97d-429bd67a03bmr13016773f8f.5.1762183583944;
        Mon, 03 Nov 2025 07:26:23 -0800 (PST)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c85ad08esm15786597f8f.19.2025.11.03.07.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:26:23 -0800 (PST)
Date: Mon, 3 Nov 2025 17:26:21 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: Re: [PATCH 23/24] arm64: dts: qcom: glymur: Add USB support
Message-ID: <nlhzhepkkyhvpf6flms3xafvfpepi42ojiopf2vqiau37tv5f6@e3udg2rdglgm>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-23-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v1-23-24b601bbecc0@oss.qualcomm.com>

On 25-09-25 12:02:31, Pankaj Patil wrote:
> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> 
> The Glymur USB system contains 3 USB type C ports, and 1 USB multiport
> controller.  This encompasses 5 SS USB QMP PHYs (3 combo and 2 uni) and 5
> M31 eUSB2 PHYs.  The controllers are SNPS DWC3 based, and will use the
> flattened DWC3 QCOM design.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 243 ++++++++++++++
>  arch/arm64/boot/dts/qcom/glymur.dtsi    | 569 ++++++++++++++++++++++++++++++++
>  2 files changed, 812 insertions(+)
> 

[...]

> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index 8a563d55bdd4902222039946dd75eaf4d3a4895b..c48d3a70820e551822c5322761528159da127ca6 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -2417,6 +2417,231 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
>  			};
>  		};
>  

[...]

> +
> +		usb_1_ss0_qmpphy: phy@fd5000 {
> +			compatible = "qcom,glymur-qmp-usb3-dp-phy";
> +			reg = <0 0x00fd5000 0 0x8000>;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "ref",
> +				      "com_aux",
> +				      "usb3_pipe";

This one doesn't have a clkref. Why?

I just went through debugging an issue related to this clkref missing
on hamoa (my xps13, to be exact).

It seems whenever I drop the clk_disable_unused, I get a phy init
failure on usb_1_ss1_qmpphy, but never on the usb_1_ss0_qmpphy.
Traced it to the TCSR_USB4_1_CLKREF_EN which has no consumer.

Then came back to this patch and found that ss1 and ss2 have this
clkref and it is exactly as I found out on hamoa. So I guess we need
to fix hamoa.

Still, my question above remains...

