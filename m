Return-Path: <linux-kernel+bounces-743705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28960B10221
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EF61C8757F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0C25BF15;
	Thu, 24 Jul 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8G82sJq"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192AD260580
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342944; cv=none; b=Rk5V7kNWWzDCMP21hlqk3Vh+uw+gFeqrUoxyrhcwKh0L95gUmFVccX1iP/imxBcAwkryPYXjglA7Bohc2rPXV81gHr4G7VozY06P3ixdPGyLknx5gJT/oBEZwy0fvhk/RMg0RYyDiXlAXMZMuy1axEXs4VhZd9MWDm/jIc0dI3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342944; c=relaxed/simple;
	bh=DdDwmx8wf8fH5xjJ93XBJQhgS6uw1I6CUObsXO8sXw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK9zrzsBuA5ykFF0zGsxc7lUwLiKzNEKtE+j2Arce2EUPQy4dWQyuB4xKybmjO3icLoyHN16axGnImNYYqPE40TucG97tbF+gpYZII/qbN3HfzJYeS5MJiPtpFX10Ow/wjDxRFSSU2an2j82gFJmfTA9B5PHUDFDu3M2D3LDqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8G82sJq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af2a2a54a95so108717266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753342941; x=1753947741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgE7JUNLN02T2vSIlKw5mIrqO2vBgfGrhxplFGxM99E=;
        b=o8G82sJqk1pdfZ0sIm7JJB29nlR0o5J+mV1kpcvxpjQ+BbMYMmSaaWAkXWgEv+oE/Y
         wemj3PhQ5JwlKkaR6d/LeNLKaV309JA9Ikxxj0ufNcnkeyet5rmKan303EriduIrTG0G
         h8wcbPWOqJlt84t5gPuMetqWy+a9yeCwjvC3YKmVFJy2WIM+IziegF0COF8Vac8Em/Bj
         1S2SahRLhpjYmWwkU/loegyCUfeokBM6ckemJ3WrLU0l9hGYFl1DIVngSIanFFMYliYH
         o9BMqZRtav+R+UxNKTMVGY50kMfdr6yiqqSEdUD7XeYWZYP38OVnkpcC9oQIhTyf4PdQ
         d4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342941; x=1753947741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgE7JUNLN02T2vSIlKw5mIrqO2vBgfGrhxplFGxM99E=;
        b=edxdKVvHOceIyIfzSxxPjxtPmRU0zQhsufum1Q0T9fS+p74YThjvaRHGFM/OkhGvoO
         BvlEnmvHqdlLGFbzwRCLwaV6Y1ytf7IhfGOnGbeaaea9sOzVQmZhuQ96w4glr6IQUjFl
         D5+q9WSN2+HRQnd6ZGUSbjrE0BhRaJ1a1PcaMTao5o0nc1wbGnWS9W3TTIrkvhd1Qw9x
         dr24PlgZ1dUU1cYPm5Cc+9QAxkzRQxv04l5YPEXvZzamiwh0cSI05sS3bHB8nrH+ytyL
         dqBD/WO8Q+TmHgo/i9LjF4p3gpKoFGLzoOQvGZwd/lhKRoxF5ko3i3cbQcl10Auc/oJo
         c4NA==
X-Forwarded-Encrypted: i=1; AJvYcCXTvyHK7vtWUAxFZgu/OGNC3dV3Vmp1CbZ5WSe/9iJyajIePcgdPR9xk5G5OkpBdZyLDyNWROSuWCefLEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtSqM6Iv39o1ugAxVyzYmDR8luU9NCudJ/jz+HSxgcpyMm5Sw
	47wQs+k4fytfiaK/lEculLm8QInFXmIhwzQ+vlKxEsuW9/fF1Xg0pZaI9TTWOtclB4s=
X-Gm-Gg: ASbGncvrhAR9uTY0hIbasuCCFSfa1CeX1UmQIoYf7QPuITtW2H5GfUyErZ6A/j2auQk
	IFSeCDSzDZD3Gfkef2CGsfvXetibVv4gwwjCRA86OVr3h9+WqNmUjcspUKBQuLqe2vYPfpDkIJg
	DF6Ym4KXcW2YhG/OutdqrDwT2w93klnm7XqXjgBOFR9/npEIXs8nt5OAU5pA+tT/73eEUpkFRQ7
	LnI7edc1Tm03xTSGF67GUXsXtbLY0qlaWO6laRVlA8E+7rqG3rczPYUHug73Vwrg6Y6Z015PEAb
	Qfnim3YFOFXyU6yPwoZSwOaNYLEL91VuGAteXhQUG759o+BfrI8/zbKRMsEqkbRaaeyyIw7ev5Y
	zJCIrNoq3x94vMq1XDcIdqJPR8U42s7Wucw==
X-Google-Smtp-Source: AGHT+IGeNjiweYf8TJOBcF5sXIb4zxJmd8JjHkZIbNQn5igDg+urUk9/v99tFBFNcy9+hK6+sVS/HQ==
X-Received: by 2002:a17:907:da1:b0:ae3:5be2:d9e8 with SMTP id a640c23a62f3a-af2f6b05139mr590442366b.18.1753342941248;
        Thu, 24 Jul 2025 00:42:21 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:706f:1fb4:134c:465d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff3f607sm71621366b.127.2025.07.24.00.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:42:20 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:42:19 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/23] arm64: dts: qcom: msm8916: use dedicated
 elite-audio dtsi
Message-ID: <aIHj27uJG18afnLc@linaro.org>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-16-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723222737.35561-16-srinivas.kandagatla@oss.qualcomm.com>

On Wed, Jul 23, 2025 at 11:27:29PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
> This move removes duplication.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8916-audio.dtsi  |  5 +++
>  arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi |  1 +
>  arch/arm64/boot/dts/qcom/msm8916.dtsi        | 44 --------------------
>  3 files changed, 6 insertions(+), 44 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-audio.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-audio.dtsi b/arch/arm64/boot/dts/qcom/msm8916-audio.dtsi
> new file mode 100644
> index 000000000000..fe17bc28e825
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-audio.dtsi
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#include "elite-audio.dtsi"

I don't think this will work. elite-audio.dtsi contains

	qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";

for all the APR service nodes, but the ADSP firmware on MSM8916 doesn't
have support for this as far as I know. This will likely prevent all the
drivers from probing.

The definition below doesn't use "qcom,protection-domain".

> diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
> index b1a7eafbee31..c0a48692c100 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
> @@ -9,6 +9,7 @@
>   */
>  
>  #include "msm8916.dtsi"
> +#include "msm8916-audio.dtsi"
>  #include "pm8916.dtsi"
>  
>  &camss {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index b50c7e6e0bfc..6d9807adc618 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1997,51 +1997,7 @@ smd-edge {
>  				label = "hexagon";
>  
>  				apr: apr {
> -					compatible = "qcom,apr-v2";
>  					qcom,smd-channels = "apr_audio_svc";
> -					qcom,domain = <APR_DOMAIN_ADSP>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -					status = "disabled";

status = "disabled" got lost in the conversion. This is needed on DB410c
to prevent crashes when probing the broken APR services in the GPS-only
ADSP firmware.

Instead of disabling APR by default, you could move the status =
"disabled" to apq8016-sbc. I think that would also be fine.

Thanks,
Stephan

