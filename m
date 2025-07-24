Return-Path: <linux-kernel+bounces-743706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66061B10224
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA99AA30D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C881FDE09;
	Thu, 24 Jul 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zh2SsGns"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB662222CA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343119; cv=none; b=LnSC9lRZtE6J0Z9+pumjVVwWoKSoTMjU7VDLBQNyv3nywL2CshXyz2iMCARO25XeujAirYJ7Ga4t5Pc8luCpamfD6IGY9Z7yX21Yuqnl41zJrocwjYl/Q3GyCD2Os9IaITCu+CoyiPrPKm550E/Nu6M56KNst7GaHimuFIh0rnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343119; c=relaxed/simple;
	bh=AP3zgH1Nqn7tJA2K6pKR5f5J9I8lQYldylhzWfqJmyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcHXBYfrNsVRZ/WwtCFJOGiaQcO2eBG3JpKg+H2arj2wTnO07g9b2sBrD1Vhi+U8y6StRW7OTXX0c18enThWGNrqjcp6XFsDt1DYyGCxBZPuUjFtm5ktpDZtTDjG27G40gM94KSjuOqI8tqW0pvU5TiphxInlojnTjfDzZc9kX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zh2SsGns; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aef575ad59eso117896666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753343116; x=1753947916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vV2M1bsYJIVHm7EjRSWQZf5QaQ36BKAfq31S/kJ3UE=;
        b=Zh2SsGnsMVirsRUjrDSUAcNfytfJCscCJS0b8mZvjLifwGZLVG8hN7nFLnvd4HJlXG
         +nGH3NK3JuTdWhf2PZsCgJFPYyN8lMEx67/MBCBiBQQZJUunTnz4+hRXQBwQ9onR32AF
         Puqu4z/1W2Y/Jjh/odKsd+nVVCoAfBf+4/PEFKWu8ZUlej1opBdkslkqi87GE4ayZI+X
         YPGLAqWAyeY+GHjfOy/3CZO5qi5hCdEve77z/lZj9vSsRGVcq7RuevC+FJJBpNLyy/63
         nJxQEYthyXfLa+UsEQBNjQIcUG5kCuP7PRfaWRMPDvBHsyUUPbGVWCVnXPH8A0SHScXn
         85Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753343116; x=1753947916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vV2M1bsYJIVHm7EjRSWQZf5QaQ36BKAfq31S/kJ3UE=;
        b=oz24QD6/EwahSgBmf330hGMMtWgC9nyqtBZVXowTxWfjCoWqkqlzpQfu69574NwQVF
         7+n4pjSUXoz+h02JxyM+VPDO35pBAN6ppQEvnkKUs3e2rGanng8m7M0setsOW/a+2199
         w4Ws7WXR1h7dgIHGiRJTTf6Xh1j68AYBVnUIpkK9droevkbPn2cvBlS07qBA5lixj1GL
         FAeKnbUvEsFcdKwHcWZSBY11UicEKPGmgtOvwuQWAZUu+qwUasFsdEd/uDa/xiu0Y0j1
         INcVapxhMJG5uUGjlooV/HLKEHv9iiTDFd1T04bpixsUV3sGWymdkntHP1r+RMnuE0Ss
         wivA==
X-Forwarded-Encrypted: i=1; AJvYcCVdfuV68npOpcKs9jGttWOGnHa6bl+dutd0z24QUc+hXQCjuLsYPobwxBSuEf98FdEyVuzOzujCXNcz/e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfl7t+k1pdhT6pUmlVDqcT1elhGF9xN7cUSpdDFjrWIjmnGdAT
	p78lBSdT/x7mX0TnjEg5uhARIRhGgdFHrrlzDYQGpIBFdoGqIFpjTJB/t9PUgXFluVE=
X-Gm-Gg: ASbGncubRgBYqD8TzQrArnH6tzHfcmVqbcmsG9ZqrtKm0N/zwmUbdQKdLhaNX7bWCp0
	QavwuEDE6wK5ZP+2M/NyUi/KIev8AKQ12sGZv4xrKcaWTI3OqLcH7SjrWrs+1VhMc5aBqRmW6BX
	tkxH9l3nWt29Cv6Afv54LO4hJOOuZKVrjZl1y2wmo/3oF7QkKYKU1GQnVMUkRvqeWUdoT1tuogi
	vjksj6cQysvxkdUF3TJtKa9M3lxaR41eB1M6/nvXWAuAxwPf/w62Bd3PHeoEOhqS/daVhPYgF71
	8+1gE6vCKN8eeWBl+Ej8PLFhWDc1Phj3EiB2HkSOgvJHFT5axcUB3km+LX7MtSSf5eSD5o2nZhB
	y+Nvlb3hcEf2IYyIC0GLfdmGYbxWMIHSWhw==
X-Google-Smtp-Source: AGHT+IGqk1fJgK3rWOc4Ks4tE3xn2mUJPMG6yF9MSruD3tjslLFEJpd4P2YhrhCZJbVOnLv7scDCDQ==
X-Received: by 2002:a17:907:2d12:b0:ae0:bee7:ad7c with SMTP id a640c23a62f3a-af2f8d4fb14mr600672466b.46.1753343115955;
        Thu, 24 Jul 2025 00:45:15 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:706f:1fb4:134c:465d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e769sm73922266b.45.2025.07.24.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:45:15 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:45:13 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/23] arm64: dts: qcom: msm8953: use dedicated
 elite-audio dtsi
Message-ID: <aIHkicKQq0vy5U7o@linaro.org>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-20-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723222737.35561-20-srinivas.kandagatla@oss.qualcomm.com>

On Wed, Jul 23, 2025 at 11:27:33PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Make use of elite-audio.dtsi and remove the arp nodes from SoC dtsi.
> This move removes duplication.
> Also msm8953 SoC level dtsi has q6asm-dai definations that should be
> part of the board level dts, so clean this up as part of this patch.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8953-audio.dtsi |  5 ++
>  arch/arm64/boot/dts/qcom/msm8953.dtsi       | 78 +--------------------
>  2 files changed, 6 insertions(+), 77 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8953-audio.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-audio.dtsi b/arch/arm64/boot/dts/qcom/msm8953-audio.dtsi
> new file mode 100644
> index 000000000000..fe17bc28e825
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-audio.dtsi
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#include "elite-audio.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 273e79fb7569..aaf179c2eb53 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -2015,84 +2015,8 @@ smd-edge {
>  				qcom,smd-edge = <1>;
>  				qcom,remote-pid = <2>;
>  
> -				apr {
> -					compatible = "qcom,apr-v2";
> +				apr: apr {
>  					qcom,smd-channels = "apr_audio_svc";
> -					qcom,domain = <APR_DOMAIN_ADSP>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					q6core: service@3 {
> -						reg = <APR_SVC_ADSP_CORE>;
> -						compatible = "qcom,q6core";
> -					};
> -
> -					q6afe: service@4 {
> -						compatible = "qcom,q6afe";
> -						reg = <APR_SVC_AFE>;
> -						q6afedai: dais {
> -							compatible = "qcom,q6afe-dais";
> -							#address-cells = <1>;
> -							#size-cells = <0>;
> -							#sound-dai-cells = <1>;
> -
> -							dai@16 {
> -								reg = <PRIMARY_MI2S_RX>;
> -								qcom,sd-lines = <0 1>;
> -							};
> -							dai@20 {
> -								reg = <TERTIARY_MI2S_TX>;
> -								qcom,sd-lines = <0 1>;
> -							};
> -							dai@127 {
> -								reg = <QUINARY_MI2S_RX>;
> -								qcom,sd-lines = <0>;
> -							};

I don't think these belong into the SoC dtsi, but elite-audio.dtsi
doesn't have the backend DAI definitions / sd-lines, so removing these
will likely break audio.

> -						};
> -
> -						q6afecc: clock-controller {
> -							compatible = "qcom,q6afe-clocks";
> -							#clock-cells = <2>;
> -						};
> -					};
> -
> -					q6asm: service@7 {
> -						compatible = "qcom,q6asm";
> -						reg = <APR_SVC_ASM>;
> -						q6asmdai: dais {
> -							compatible = "qcom,q6asm-dais";
> -							#address-cells = <1>;
> -							#size-cells = <0>;
> -							#sound-dai-cells = <1>;
> -
> -							dai@0 {
> -								reg = <MSM_FRONTEND_DAI_MULTIMEDIA1>;
> -								direction = <Q6ASM_DAI_RX>;
> -							};
> -							dai@1 {
> -								reg = <MSM_FRONTEND_DAI_MULTIMEDIA2>;
> -								direction = <Q6ASM_DAI_TX>;
> -							};
> -							dai@2 {
> -								reg = <MSM_FRONTEND_DAI_MULTIMEDIA3>;
> -								direction = <Q6ASM_DAI_RX>;
> -							};
> -							dai@3 {
> -								reg = <MSM_FRONTEND_DAI_MULTIMEDIA4>;
> -								direction = <Q6ASM_DAI_RX>;
> -								is-compress-dai;

Same here for the compress DAI.

Stephan

