Return-Path: <linux-kernel+bounces-845520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF88BC53C9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0A619E1CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60562285C9E;
	Wed,  8 Oct 2025 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxkkNTGN"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A081284671
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930628; cv=none; b=WsTbAX/biOPyoHFOfwvG4wmX0PFHyS9XBbDvw4rNsdF5UBMxpNeUBZv/cowJw/KNn2v9kr1YNao3ZdAhAv2ykakyqVy5vfB1qVREC0EglhkJXpco7r3Uc77Ef+6ijLJvIeSByUHByptjjevsyAWi4m8QziBUe2Ovl5Ww9EoTWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930628; c=relaxed/simple;
	bh=wVHBPwpVk3DUd7kZR0axYvRZ4099szWxpx3XB/i9yAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA+/gPP+P/VmiNWX+4sCzwDlXnsRwar5VFLjTnTawPs0F6S5vIkj5l/4JqWe7SFKvouiFJrWDuA/zR7gYhHaxnmL6WCpLGMvPEK5EMdHNDoZJFM7fFMzoQedRZLK1ifR678WanQvCMeYKlEHD8Ih8o0O7w4hGJinDu/aHkRZDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cxkkNTGN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso5730046f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759930624; x=1760535424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bERJWZGdKctqPmQLMomr/DAHLC2om0vQYmyzBO9BTrM=;
        b=cxkkNTGNf1w5d2Yb752ESNYfLG0NXLkRO2TK6dlkFSk5btEfFsC6F4Mlb23LoOoGhC
         IY6W3M9H+mKkvWAzKShsCoiiKyML/axM0tXwhPdMVhfnK5PYHVr2ILh2L73Arby7JDdK
         PaYUwcRNY8FioLFF04pjtrHl+HvqbhV49lnjtA6efwu3fD1Sd3cTvolNznzNUsWBoqgv
         VzPKMSRYgmIJIMwO/f8fyZLRXx7ozA8Db7OBljDE7UrprhQLhzkO7BszAGM1sKXeR/ME
         Erb7wopDQZecGP7XJ4SmWI0HaiiZmcM+4Rm1BCGDdhJ0sZ8HOWhV74oF5C4x3LIG8gVa
         XF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930624; x=1760535424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bERJWZGdKctqPmQLMomr/DAHLC2om0vQYmyzBO9BTrM=;
        b=SIY5yg9Z8rJuoTT05vNVLGLj6bRTaahdZiNKch4tva+iZ7n4sVyVf8MkFNyRzKZIVJ
         WV5r0M1IhzF4s+5O1HIBtiETekd1gx03+IwNXGwY7HzUeMRN+kksUP7dFD7/aqXY1eSq
         f8DQuQDTTrDmcLOqGpmvBydbMsWth052mLn4zmT0vP1cKaua/iLMplwAF99fA1Qwl+X6
         oB/9pR8xQL/Iezh/pDgowiYriU4dIOO3qc0FQLXuxANRt1bqf1tDP2FRald1smvIJdI1
         7ZKWTdqO+5EaEDwYcnHsrfYge04IdZ6KxyR+3coT+P/7UHTtcUfJsvzpTDu41zRZf/6/
         QJMA==
X-Forwarded-Encrypted: i=1; AJvYcCXQdTVbzTBcpqzYmOoGstuFMxau7HT3F+WPfxgX3BSv/GPo7ghqns7RlRny8F6fk1gO4RGAUkt5jcVkeQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmtxii7q8OzG00GUS9NTmpLrIdbKi2vxAn4MJS+Vq0TxJQFDrS
	Hrq7h4g4kNvzXVbJUQKpmu4GVSKkEb3p9QVyPtqxMW/WWRmH87bB3kAIHBAD8a9A8yc=
X-Gm-Gg: ASbGncsARaNfdl9qIumEjl55r0evTtPW/Fw/HPHGcdLb1/YQQP39siH/Osu4RxVSswU
	yk5TG0Rx08GoZQ+KEAt2bWgdOH6rTfXZUT9s9+HFYtp2CSDdd7zK0nD6smB4B0y2f/77ftMFP9J
	rbcmhlH26kajhLIFFfkC6bQuiUPDB8vYb5zAogu+8BvIl/ZvoAXPT+F9iXBtKcaO+r/xp6PadOn
	Nv3p5fIkWKJpiD3+VagPy3eciuhaITdaWpAV58hjBxTMGPUjsmml8JJN0ODZDGizAll2c2ELNDL
	eF9MIglcTrjK39Iml3YfG2NFPQXJMcSrlqRwtikTmD5cZB7D/VeAcRGHR8zdG5txqCaLyQvMako
	j30QtXXDp0vtgfwogpiDeD4nDGJ0oFeo79jrqgPkHT0IvWONMVk8/P0Mj9w==
X-Google-Smtp-Source: AGHT+IGKQqQuzGZb6jiAzLLCrkmUpSwJGngkOf/csBaLSBCsDn//kcndB3Pgpj86O8bJQcTWuM+30A==
X-Received: by 2002:a05:6000:2401:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-4266e8de2c2mr2452043f8f.44.1759930623657;
        Wed, 08 Oct 2025 06:37:03 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c54sm30366116f8f.11.2025.10.08.06.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:37:01 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:36:59 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 19/24] arm64: dts: qcom: glymur: Add support for PCIe5
Message-ID: <da2vvejbqdteaszzwyktczqivjblyawzh2k2giyoxdxlxcdrcb@fkuqivjmaggf>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>

On 25-09-25 12:02:27, Pankaj Patil wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> Describe PCIe5 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe5.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 208 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 207 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index e6e001485747785fd29c606773cba7793bbd2a5c..17a07d33b9396dba00e61a3b4260fa1a535600f2 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -951,7 +951,7 @@ gcc: clock-controller@100000 {
>  				 <0>,
>  				 <0>,
>  				 <0>,
> -				 <0>;
> +				 <&pcie5_phy>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> @@ -2511,6 +2511,212 @@ pcie_west_slv_noc: interconnect@1920000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		pcie5: pci@1b40000 {
> +			device_type = "pci";
> +			compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";

The first compatible is definitely "qcom,pcie-glymur".

