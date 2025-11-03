Return-Path: <linux-kernel+bounces-883401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B07CC2D64D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EBF4229A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6931CA59;
	Mon,  3 Nov 2025 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D69JAPRU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68631B81B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189228; cv=none; b=QIip/ejunC5oJDH6FZPsc62zsiR0zcX1yPYk5/XyOylGn+2nCpWk63z5toqhIgcRfrYt4AoIe8mP/eYnl2ZbH7jmH+9TneUVF7uCFOlhYt+BRXH76MhRJg1UbN4vl5T/DZ6maMhPMeFpXenkC44Mn7MD9RVwo2qtAvlM03DZkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189228; c=relaxed/simple;
	bh=eDMngs17dgbpDGMncsMV59kp9bJ9LsOsJv1AKcqo4oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz6ToVTG6YwNT00bd4siQh5VkQpjG+PD3vyN8qFF8pohGGK1CTrpECYObvGRiRJxS5lbLAsU6z7ARf6OQEMXroj/cQNwVAVH41R35+IHnbnaEGfoFsENvve7+jR/I912AI+6AW/xkb9tgkt8aorHIFV8b1N2s6iMepaDZu7mxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D69JAPRU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710683a644so36975515e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762189224; x=1762794024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8+SCTcWg0iEZ5Ozc/rYo37su+YkvO2pg3K/UcQo9S0=;
        b=D69JAPRUGqGkhFpL8pK3uQO+DkrZWS2Rje2RL3faVoO4Kpd8TtqxkzEK/5H3QHFAj/
         o7RX9BcN8MxAo70Su7ezh8IcwAj2PzC0R9jzEKiYTiMA5l7FHozKiSODdGzHH/iO26Dl
         m3iT0Ytvli49we0woJKNRZ+mD2Yk/fsQaUTo+jkdFwtOl3GAwXUlzuOk0BkJWoQNbZqr
         86f52n9c+/L0FRhD3x7xLyLKSzGmZJrQar8WZnJTAGX/wlmQMrtNlh3HqEmkGOhbnIy8
         IrLVz7uRZXKA+1CD3Oj9HDeHX6SrTGWIXG/NVgSI+NIhgfBe+yckQG0PtbDu71u5cVFu
         giAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189224; x=1762794024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8+SCTcWg0iEZ5Ozc/rYo37su+YkvO2pg3K/UcQo9S0=;
        b=AcDg1WuSpM75IPkIqrrDFqcKtazKc08nav++kbaDmkJ01U4usGRNfKiOLby/2WxCZU
         1mt2WXGlyyzjJvvvUaxhumWHUgzf9edTysTnjEMLrsQ9JWDyF/nRMAbyag8JwfVlX49W
         HqxruSiNIMC/EegRHm4zgWE46WiA1kLPd634biWHjEGbMuIdHI5KgxEID293jL7jRdmu
         AJM8B8DojXZEnsUQM8D+oqPwu+gzycwR3n2oUAyhz7DBfItz+/0xthrfSZ5R9g2eceG7
         YJTsnfqHH6rMOfXKQNneHYfhzZFsFhffcm7G5aoc5LefymBc2d6TsF2bQw/3mSdYTZOH
         FeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+eyBS9mbxr92Ec5IUD+Pq4WZFX8PopjX6NGN6ljcZ0CkFz5zl87KesGwAPCyxJeJNKhH1q6Z93pB+Y1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK01Y1ZTR3aJdg45LLLzMvXMtget+fSzAIaoNsnTPID8W09t7M
	Ai4S6EQt6pXjF4+9imMkRza/RAvcYRWgblFvvXgmC+7hA6F6I+UQ33Ie7eW/LmYVUxM=
X-Gm-Gg: ASbGncuU/K1YeyKSNEN89yUQh85jXoh/MaKLRQ1hMOtF75/3la+igkooU+BztTYXPKD
	7YozKX1EDEWCXi8Zv+L31BzK+mg5XcWYIn/POgdSSnS7zjSw7MRslzRjqp+2UZsYtHwjP1L+Dnz
	CLn+fwbqPRiKdi/qbWpW7OCS4KZMbNE6NRXn7gYVb9HnVmYGH6JZ3yunOUl1DXtKUYguJsZqXVI
	IqIbs04hh5qhkcBfM4fOpw+SySsZ0dtu3kTG4F9pHUiNpWSPMpCWh6AmKcORqt0UKELenVReNaY
	y9pDE5wCDVYqBnQEE1AxOE0F+g/DyyLUZLIop2GjZv1aOIwdFy5aREf7plfaNvjPZyTqbEG4iYq
	gctif8JMgl/MXfYqZBhAp4tAgNaN3y9JE6Oc+X9j6yr+REuaZx1NDDczgqw9ZgJLRH8lUJDSrj9
	llxUoQREI=
X-Google-Smtp-Source: AGHT+IELaFHSzBiO9AXPyBzLS0c7LY682782xN/+qHy88yBVFrN1pt7Y6DspDHfXPEXO6vZLrDUSeg==
X-Received: by 2002:a05:600c:548f:b0:477:25c0:798c with SMTP id 5b1f17b1804b1-47754c46ac2mr951505e9.20.1762189224236;
        Mon, 03 Nov 2025 09:00:24 -0800 (PST)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ce80df16sm10787228f8f.2.2025.11.03.09.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:00:23 -0800 (PST)
Date: Mon, 3 Nov 2025 19:00:21 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: Re: [PATCH 23/24] arm64: dts: qcom: glymur: Add USB support
Message-ID: <bfi6mobf77gevht5em4kzp4lylvcrxttfyptm77itqqhz6sskq@jq7w5jvjncou>
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

[...]

> +
> +		usb_1_ss1_hsphy: phy@fdd000  {
> +			compatible = "qcom,glymur-m31-eusb2-phy",
> +				     "qcom,sm8750-m31-eusb2-phy";
> +
> +			reg = <0 0x00fdd000 0 0x29c>;
> +			#phy-cells = <0>;
> +
> +			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb_1_ss1_qmpphy: phy@fde000 {
> +			compatible = "qcom,glymur-qmp-usb3-dp-phy";
> +			reg = <0 0x00fde000 0 0x8000>;
> +
> +			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>,
> +				 <&tcsrcc TCSR_USB4_1_CLKREF_EN>;

So I think this clock is actually needed, but I think it should
replace the RPMG_CXO_CLK above and then no need for "clkref" below.

The reason this works is because the bi_tcxo is already the parent of
this ref clock.

I did something similar on x1e just now:
https://lore.kernel.org/all/20251103-dts-qcom-x1e80100-fix-combo-ref-clks-v1-1-f395ec3cb7e8@linaro.org/

Still don't get why the SS0 doesn't have/need such a ref clock.
On both hamoa and glymur.

