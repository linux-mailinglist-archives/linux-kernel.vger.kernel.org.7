Return-Path: <linux-kernel+bounces-869557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A10C08287
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2253A6A49
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F82FCC01;
	Fri, 24 Oct 2025 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhhRB9T0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B72FF17D;
	Fri, 24 Oct 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340313; cv=none; b=i+Uo4aT20HpX15FPmLt3BDhomJTivj8zWobMdiGHzrQDcxqjppEyRMYl9RNktmiMGwndyO7PThrn2mn104WSuUdqtA1UCho3IenW1TMvYAXiXfDTQ3oTl8r0jjQXKPwho/55l25WR5ub+2fvFKK+90gQsGyWODszwj2g34xHRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340313; c=relaxed/simple;
	bh=vTpev92s4UD3E/29qiWWh1Wqu8g3L/oXWfnRj3eYxt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr+GKo4szzOa7VHrNsEsOeHx2GdE6MlPRH3W86z9kzfTAX6nAVPfrNCjomtkSSiO9ZqiOLYAf9PuculLiyPN0erYylP0VjhrVV/8IoYfFUGUQ6nFQcbz2ez783fcuKHRMOAjx/ry6zF8Wc6XLDOncCB4I7mP/gtQbhS8hikcnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhhRB9T0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F61C4CEF1;
	Fri, 24 Oct 2025 21:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761340312;
	bh=vTpev92s4UD3E/29qiWWh1Wqu8g3L/oXWfnRj3eYxt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhhRB9T0lCIxVTtyGnbvMdMebiou3kaWgvRscqCKNd8mVEk1cfiEuoxKz8krsIKOe
	 FcTNG0r0AkQepnOzaE9X/rGTQbj4OJxgSk1eu+sRWibnOf9yUEJzVozeMnZe1uPkfs
	 UgWK9W6T/PS81dqdZ76xOxtgg7f5mLjxCJtDzdC8A5uPZc4IFRU5NavTQzVrdRo4uZ
	 0Y8dMIpbZptB6iLRc6oXXuI089FLDMGYQexhHoFc9Q3dd0LWV+cPVrOclK3CCaVO/k
	 LrryIrLtnHyfGbA+lb5UGBMHO2d+V/HjkZCD3Rex/QbUvLypWvtFtOfX4eUud7mHgr
	 A0QAzty64A/cw==
Date: Fri, 24 Oct 2025 16:11:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: Update Krzysztof Kozlowski's email
Message-ID: <176134030564.2817396.13374038022056770628.robh@kernel.org>
References: <20251021095354.86455-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021095354.86455-2-krzysztof.kozlowski@linaro.org>


On Tue, 21 Oct 2025 11:53:55 +0200, Krzysztof Kozlowski wrote:
> Update Krzysztof Kozlowski's email address to kernel.org account to stay
> reachable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rob,
> This should apply cleanly on v6.18-rc1, can you grab it?
> 
> Maintainers + mailmap will go separately.
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml         | 2 +-
>  .../devicetree/bindings/display/bridge/parade,ps8622.yaml       | 2 +-
>  .../devicetree/bindings/display/bridge/sil,sii8620.yaml         | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml       | 2 +-
>  Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml         | 2 +-
>  Documentation/devicetree/bindings/input/cypress,cyapa.yaml      | 2 +-
>  .../devicetree/bindings/input/touchscreen/st,stmfts.yaml        | 2 +-
>  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 +-
>  .../bindings/interrupt-controller/ti,omap4-wugen-mpu.yaml       | 2 +-
>  Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml     | 2 +-
>  .../devicetree/bindings/media/i2c/samsung,s5k5baf.yaml          | 2 +-
>  Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml | 2 +-
>  Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml   | 2 +-
>  .../devicetree/bindings/media/samsung,exynos4210-csis.yaml      | 2 +-
>  .../devicetree/bindings/media/samsung,exynos4210-fimc.yaml      | 2 +-
>  .../devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml   | 2 +-
>  .../devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml | 2 +-
>  Documentation/devicetree/bindings/media/samsung,fimc.yaml       | 2 +-
>  Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml    | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml          | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml          | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml       | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml          | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml      | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml       | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml       | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml       | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml       | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml       | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml       | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml       | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml       | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml        | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml        | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml        | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml        | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml        | 2 +-
>  .../bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml         | 2 +-
>  .../bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml         | 2 +-
>  .../bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml         | 2 +-
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml      | 2 +-
>  Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml     | 2 +-
>  Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml   | 2 +-
>  Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml    | 2 +-
>  Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml       | 2 +-
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml        | 2 +-
>  Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml      | 2 +-
>  Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml       | 2 +-
>  Documentation/devicetree/bindings/sound/adi,adau7002.yaml       | 2 +-
>  Documentation/devicetree/bindings/sound/maxim,max98090.yaml     | 2 +-
>  Documentation/devicetree/bindings/sound/maxim,max98095.yaml     | 2 +-
>  Documentation/devicetree/bindings/sound/maxim,max98504.yaml     | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,q6adm.yaml         | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,q6afe.yaml         | 2 +-
>  .../devicetree/bindings/sound/qcom,q6apm-lpass-dais.yaml        | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,q6apm.yaml         | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,q6asm.yaml         | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,q6core.yaml        | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,q6prm.yaml         | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml       | 2 +-
>  Documentation/devicetree/bindings/sound/wlf,wm8994.yaml         | 2 +-
>  Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml   | 2 +-
>  Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml         | 2 +-
>  Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml | 2 +-
>  66 files changed, 66 insertions(+), 66 deletions(-)
> 

Applied, thanks!


