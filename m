Return-Path: <linux-kernel+bounces-789418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC1B3953F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7E11BA7FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66232D6E59;
	Thu, 28 Aug 2025 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1rm8LhT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062532D1911;
	Thu, 28 Aug 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366425; cv=none; b=NXIHF1zJPxmd42dw2EGK45jJHfUDkch0lay5xAdymKKuw+XHK/3z7nKfp85+dyS3rRbW7IJft3iAXyRr6Le9QmwIKkjhm40BeiwOf+/eptfKyB6oPbv07F0qmf1623sJXbwi1WDiRT6/EiL2Jn0AOE6QF2jQs2ruLQTpvmw8HqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366425; c=relaxed/simple;
	bh=fSkHwyAdTfPBZbyauNiD8m/zPmF7d1MILfH6vViWJpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufaLSSQF4WmbcHHvsMokOphSyUtY0bQ60BiSSBIcHwgN9UO288DB2pbZDETBy9FI4ZkkrR0fynwnpV4gPq0MCMps0MJ4NDXrx12JAin9kMHS0OKE0S9JovCmz8E503iwyu087jsAzpfFOeiSIwBJ1TMSl9WFKoQGG7qhEgrtdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1rm8LhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A269C4CEF5;
	Thu, 28 Aug 2025 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756366424;
	bh=fSkHwyAdTfPBZbyauNiD8m/zPmF7d1MILfH6vViWJpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1rm8LhTdikpSUDOuULtTHZ/pz/V0gMxECITZqMvw2C1lCgW8NSIOwH1ep4AJfvVy
	 JNiTbOArrtu10pyce/r9blEbgTJCSU9CPZVIzcYilpHOxi7ktEFnaCN86smu0o8b72
	 UgHPtd3eTjkChHe7d8hFAVTS98VM6m3OkdATV/LjBGT7AmCj2zPGijUcTWCoytfpSE
	 8ufyOt42LXtQR35VF7E+jG7oWfQRYMF+ZS/6qiCx/Za1/LvsFwUbPe+WRmJSSud8qF
	 GQlruRHzQad6OIx+sKJZOtCCdV2H1wUn3/URVRt1JbllGzFoWt3qAFM/1QrCCeWPm1
	 u0Lng2GV1P18Q==
Date: Thu, 28 Aug 2025 09:33:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/6] dt-bindings: display/msm: Document the DPU for
 QCS8300
Message-ID: <20250828-just-exuberant-anteater-d57ae9@kuoka>
References: <20250825-qcs8300_mdss-v9-0-ebda1de80ca0@oss.qualcomm.com>
 <20250825-qcs8300_mdss-v9-1-ebda1de80ca0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825-qcs8300_mdss-v9-1-ebda1de80ca0@oss.qualcomm.com>

On Mon, Aug 25, 2025 at 11:34:20AM +0800, Yongxing Mou wrote:
> Document the DPU for Qualcomm QCS8300 platform. It use the same DPU
> hardware with SA8775P and reuse it's driver.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml  | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


