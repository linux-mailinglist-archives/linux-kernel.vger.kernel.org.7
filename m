Return-Path: <linux-kernel+bounces-815637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FACEB56943
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CE13B65AE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022791D6194;
	Sun, 14 Sep 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pipUxAyu"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AC2356C9
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856066; cv=none; b=WABVMlyu6EvwbaJZnOYdD9FG3ngjOpWZo7ZTbpdlbSefhi5vmRfpT2e5roO+PXIdw+kV3nCTgFjzDXFYpZWtMDMAyRehGY7x8u0BOqbUeTtLBTEC+beYQNd7nrhTcNqHu5cQ2tdPvEH3pHbhCGZbb9T/6Bg2pkivb3MmN9pizWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856066; c=relaxed/simple;
	bh=FHRGm7LXfDWxk3h6js0O3WyYp7ia2gmJ2X8rfluSTRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh752X4TQ8KABS4u3vTXJIQCtRsbo/t+wn8x28mzW3D2z2jJwx9qZErQ0GMs0TrePs15sVRwC6aGS7jlOCu00+Df0ZwNZhAIw0UX6wlhRu6m3ilTAdpvrq60GpxqfSm8HYeMJKxlwps/cbpIhpuXjXxUQ9s+HqEQGmxn7JzPUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pipUxAyu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so23047655e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757856062; x=1758460862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+GK7SXOR7eYPYSb3rZX+Z9MMo2wc8zU01qlT09Kxeb8=;
        b=pipUxAyuqNUWuA1Ga05hUOnaXY3TMCUFJQum+4Wa/K9XYSAGP9TSNlAdPb2f2LVDVQ
         haIEH5XbNLYnTrXWa4WvPiQObfPbcK5Z+HuAn2hIyRitWJ4f9ImZuqzpFo/JLxztbCx2
         b6PeTrek309s/G9XSSZdrp20ayPdaX/SOiMBniGhjTGrl9yVRbsRuTtwhVtkIf7qDlvR
         6GLsJHnU2sRar6Dq5HgTcR/Qn5pEN9y7GFQi5+zDxrLfMkS6kPO3QfiBX0bUVF/mEn0G
         5UxW5Dt+Aakhjs5jfNzRdbzR6mU9I1E7F1/114HiX9iZ2/9s8It15X4piDd9+z1H1qJW
         jz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856062; x=1758460862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GK7SXOR7eYPYSb3rZX+Z9MMo2wc8zU01qlT09Kxeb8=;
        b=foBfWjoAe2OMaPnLECWvK0e27QK7u7ULnU7EBLWi9QP3oFkY8OMmA3PDySKb05NZbH
         vSRM8v8Ye1W3iXyFRB5ZbJ8daTxtUU028MB8vay2zgYFSIdL2nH/Ym6ix5Sl8hUOOTCT
         heq2D5L1RFZI4l4uoCrUriJfmXYJSYNK4xtz13zsRkyq+cAl/DoyY+wY4dZapB3BOmiJ
         mPobt8p7wtXsITLQxWJtEHwbaIL/280aQ5dLWiltR85X663DAfVthv01T94h8nQrV4Bc
         uIPTEQzvMuQ04cRohud3R4L+wtImQDq+nlUpU1iAW5G4S8cRF+IcNEgd6UCTWZZB6QKL
         PxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaphDlhg1iZMY+amFDt1hGKcGpJ+EeMJ8/a5Tg5HN16bf7tNI1+Uu00aClC38BJ8nOD4cK2wrHgK4qE7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCLy40pJZQccty78vQEvYfHHrwczvVde8SWrnEPL0GDlxpmLk
	2sg0sYZ4UkmiH+wRiN0dszlHTl8+8mmdROOTMddAZw18yWou7M/CfjnI5GT2smQOee0=
X-Gm-Gg: ASbGncs1lO4Xc+XkNUWf19c1UiVxJxNaCBKvsfW1DEk8Go0nEANg29i0Pfd+QLNWM65
	gYicHywYNQ0m44I5CUsCn1GsQXcWQYz8U1/ow++g9oZ0T7bV+8jT7bBZrvr6tu2X2zW0m50bi/M
	8uD4xQDzFnLQv/tj9ayr2mI21hwl31HAgad/666SSq0qXJes5K/5l6YEeQSenPyvmryglo/l0df
	59JH7RWhzVwkyq62BTN4JfD6cRqLJ9nbbu/iC9LVwtCoMj2OUhKwTylwkAwOaqoiUdkmEe24p4e
	djkeV2cCUoh5kV+k2lvDasTCrULcFZdk2GKlKDV1jUA7tLhQD62A824iXSTQ8MRsQ7MLze/tBW/
	pKD/JLFKKW65nL7fe04EOwO5E1KDnstkND0XJKiwfPg==
X-Google-Smtp-Source: AGHT+IHdgLvDTL4KVtGGIiFe+3oBC8tJ3o8FsHsupq0zhyzo+pH1R1CU6WA9dvqZ9/RfqTpJ+CDSUw==
X-Received: by 2002:a05:600c:1f8c:b0:45b:64bc:56ea with SMTP id 5b1f17b1804b1-45f211f8841mr78216515e9.23.1757856062040;
        Sun, 14 Sep 2025 06:21:02 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:52cc:acc0:aba:120d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c9d91sm133143445e9.20.2025.09.14.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:21:01 -0700 (PDT)
Date: Sun, 14 Sep 2025 15:20:58 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: jens.glathe@oldschoolsolutions.biz
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v8 2/3] arm64: dts: qcom: x1-hp-x14: Unify HP Omnibook
 X14 device tree structure
Message-ID: <aMbBOgNc-382vwMY@linaro.org>
References: <20250909-hp-x14-x1p-v8-0-8082ab069911@oldschoolsolutions.biz>
 <20250909-hp-x14-x1p-v8-2-8082ab069911@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-hp-x14-x1p-v8-2-8082ab069911@oldschoolsolutions.biz>

On Tue, Sep 09, 2025 at 07:02:34PM +0200, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Extract common elements into a shared .dtsi file for HP Omnibook X14 to
> support both Hamoa (x1e*/x1p6*) and Purwa (x1p4*/x1*) variants.
> Required because the device trees are not compatible.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  ...hp-omnibook-x14.dts => x1-hp-omnibook-x14.dtsi} |   48 +-
>  .../boot/dts/qcom/x1e80100-hp-omnibook-x14.dts     | 1606 +-------------------
>  2 files changed, 48 insertions(+), 1606 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
> similarity index 97%
> copy from arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
> copy to arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
> index 716205b437df55489cfb7d29846cdaf8e403cf72..e6851dbaba121029bde926310616169e319cf5e3 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
> +++ b/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
> [...]
> @@ -1028,6 +1015,7 @@ &mdss_dp0 {
>  };
>  
>  &mdss_dp0_out {
> +	data-lanes = <0 1>;
>  	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>  };
>  
> @@ -1036,15 +1024,13 @@ &mdss_dp1 {
>  };
>  
>  &mdss_dp1_out {
> +	data-lanes = <0 1>;
>  	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>  };
>  
>  &mdss_dp3 {
>  	/delete-property/ #sound-dai-cells;
>  
> -	pinctrl-0 = <&edp0_hpd_default>;
> -	pinctrl-names = "default";
> -
>  	status = "okay";
>  
>  	aux-bus {
> @@ -1061,13 +1047,19 @@ edp_panel_in: endpoint {
>  			};
>  		};
>  	};
> -};
>  
> -&mdss_dp3_out {
> -	data-lanes = <0 1 2 3>;
> -	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +
> +			mdss_dp3_out: endpoint {
> +				data-lanes = <0 1 2 3>;
> +				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>  
> -	remote-endpoint = <&edp_panel_in>;
> +				remote-endpoint = <&edp_panel_in>;
> +			};
> +		};
> +	};
>  };
>  
>  &mdss_dp3_phy {

Please review the resulting diff carefully when you rebase changes with
conflicts. You're reverting other changes (4 lane DP, eDP HPD pinctrl)
here. :-)

Thanks,
Stephan

