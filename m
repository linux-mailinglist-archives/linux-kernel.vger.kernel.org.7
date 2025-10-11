Return-Path: <linux-kernel+bounces-849137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E3BCF47D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D38D425B30
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863552367D1;
	Sat, 11 Oct 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNiMk2+L"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C023717F
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760182298; cv=none; b=Bd0lQHKoG3Tu15fRBOpfrGe0NDjpawgK0ue0BA/G8vr1T0pcyneVzkUiI46Fm2IQ5MvWo06ZEJSQWEHkSsf07yG0d4A1MMh22v4uLLqNXAP2J8Gn80MvzqDaRHBLoPB9h3zL2jGl6M30dSZZVvv6bZH0LUlhxULhL7OJAey4IJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760182298; c=relaxed/simple;
	bh=5RI+zDeyw3XTRljWW1rsNdQl1VRKEKQFrpl8fx9pYt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu9ACQ32a5m70zBmpTscBNmE87K9e+1IzRdVSPleGQG9aDBP3NqbGX2GhOXPDh6juIcaijZeRk2tC0Q/NkezPbtO0fY+JQeHCMKJQxfJ7jcWp5ToVWahNCntTua05/vKAstkgt7eAxI1Af6V7koou6Haz/aqHrh82UYWpCgjpnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNiMk2+L; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso2088984f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 04:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760182292; x=1760787092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mNTGbfmugn5jBn7rCYmZzAG7du6mX8yV8hZzW+D5Gyc=;
        b=lNiMk2+LNE09jjuUfwBiCAjb+yGdyW1G4D+glgpbl4ggbxVNED30YsEmhQrXmijbLS
         yXfqEJn9QD5slBHBywuCTDA096QY1C6JjoVWcaV7TQBNf0VCUEGKkUP9qBv4QUaxP5Ph
         kEQDsNk+elcUXmYEuaiNsa9Chkv3q+Eb1QJIF3VW54xdMKyAOL8uhNzLYYK91DvQqCrr
         5Cdvg/f3qVi0vgAsYG3Ix3gvlXFi5/Qa5Z8wGYgeusIFvN7EtCo5dw5tapmAJVwUsRKi
         I+xeV3PKrZMAfInLzaxn3lo7py3jmpTnMB8NhFlmVYl1X+FQA9NysyfXgqgr6eUErdEW
         OCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760182292; x=1760787092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNTGbfmugn5jBn7rCYmZzAG7du6mX8yV8hZzW+D5Gyc=;
        b=cZMlhaaB5q63w1gGIfTIxkGgo/ZBTIik9+Qa9Aht6m9dbuA9OE4ufqH7jH2tFwaFKP
         tdRfmJg+pPepj09LKfdWCl4V3GsKOkHSwEdxLPLZ9Cy0eli5n+XLkobzDDus/AKwSDmu
         0UofTOJx4aCfGI1V/XvsHgcNvvBSv0ZCuNsiw6tOdG/SkVVA6qTTFevr6DRpCWRR+O0O
         RxWibA2YbEGoY8JRKAD7oqAZj7vcAMm8Ah0GfXGvMb5v0Q+neTU51FZYcOOpmvjyoANf
         b/o1tlrNXvCDe/SqViTbLwfigNdgKVRnMcnB0O4d7wLgZAvi00twYEv5epKJsxckSZZx
         LKeA==
X-Forwarded-Encrypted: i=1; AJvYcCVGk/8G4Kx7i1IS4eggMuQyOl4+guGrv3xPRMsFBKsRh2NtTKbXFOx9LMPeyWXYKCkadgU1IxPwhnPmoTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcAgtx4OPYxweigSXnhIFscz5BvGbmPRpN5HZmZorgc6yQ18d7
	N5yV5cWmMDQVtcJ8XemLQKIczzEZ/fFn8SdoqVZpiTnlOigchFD/kaElu8Ti3e5em4M=
X-Gm-Gg: ASbGncsxdXWMThX1rXOqryRi6ryMIFgw93oUOXnHVNYNtPj8dyEaxgQ6TMoGSdxoood
	HP4xpNns10ANQqPXVRmNO+fCs4FmSc79D41r/0Xcv4oZkSdBWQITZoiWKxItjG79O4YJhlFhnEF
	1bSnj9CqamWqMdEZrbC12K3Hif5cHur4QDRvHB/0/8/IcfD7wEP96oO0sfP/etEW4vaBmw9NWrb
	PpVoONRZ/IMOUIKrg27Qy/vUCUw5aetYN1xG/Nb9m7XOe+RaDw3bZgwBAsIJslpHTiztfyAlq52
	dIRZKD6epeHOVBgg1xlqsWXMolezBqJSsZ0XfpB+b6sdBSrJ7njLp9RltQjuzt9hpRdgdfywKpW
	681bltZyHnvZpncU+QOegbcfWZWG2ZAmp+8bjlR4kiQ==
X-Google-Smtp-Source: AGHT+IFCjuGBYnCDqcmxB9IrSM+BqDe9Q2x6ToeA46ZBK1ltHn2SzcZl6eRhCx5sKgenvc7B4y15cw==
X-Received: by 2002:a05:6000:4305:b0:3c8:d236:26bd with SMTP id ffacd0b85a97d-42666ac2ce9mr9301019f8f.11.1760182291588;
        Sat, 11 Oct 2025 04:31:31 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d4bbsm8686681f8f.2.2025.10.11.04.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 04:31:28 -0700 (PDT)
Date: Sat, 11 Oct 2025 14:31:27 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: Re: [PATCH 09/24] arm64: dts: qcom: glymur-crd: Add RPMH regulator
 rails
Message-ID: <sean5dkqku4norpl5llaps6wd3qjcxbb5kodjgvh4dshjkqvt2@jtlqhser6hsn>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-9-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v1-9-24b601bbecc0@oss.qualcomm.com>

On 25-09-25 12:02:17, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add RPMH regulator rails for Glymur CRD.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 332 ++++++++++++++++++++++++++++++++
>  1 file changed, 332 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> index 4561c0b87b017cba0a1db8814123a070b37fd434..e89b81dcb4f47b78307fa3ab6831657cf6491c89 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "glymur.dtsi"
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. Glymur CRD";
> @@ -66,3 +67,334 @@ chosen {
>  &tlmm {
>  	gpio-reserved-ranges = <4 4>, <10 2>, <44 4>; /*Security SPI (TPM)*/
>  };
> +
> +&apps_rsc {
> +
> +	vph_pwr: vph-pwr-regulator {

dtbs_check gives this:

arch/arm64/boot/dts/qcom/glymur-crd.dtb: rsc@18900000 (qcom,rpmh-rsc): 'vph-pwr-regulator' does not match any of the regexes: '^pinctrl-[0-9]+$', '^regulators(-[0-9])?$'
        from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#

so node name needs to be regulator-vph-pwr instead.

