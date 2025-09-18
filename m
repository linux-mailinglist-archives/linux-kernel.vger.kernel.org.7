Return-Path: <linux-kernel+bounces-821851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1466B82727
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E4A1C2429B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A874672628;
	Thu, 18 Sep 2025 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjaWvIFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F112869E;
	Thu, 18 Sep 2025 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156749; cv=none; b=jxZUK8lb/FKwb5MCDNG7z4OTcp2/XKdd3DT9yy5upP/MXIDlgwBeyb96xlFoyWl2On/BrLUcdXjtJbBNS35q1RM0/pfC44GhiUAjKZ+/flWN1XPPr2MLtttjgHxxDyqfnfPRLFKwzZztNHT4vd13Ayl0SQ3oEvay9hCYRC53aC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156749; c=relaxed/simple;
	bh=1P7eWHurPGkhwCHExphone9WUR9mnSjMxc2kjomNamc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOQNPMBRrtQL79lrzi2dFoDPi/6oTQXgYZ7KEuYMYV5J5PEuj+v/FyajhEUXpQP6TWfkvVjdw+lNJfO/gyL0eE5AbJmal9iUem1E3edCbUKGX2Pfu/E0KzLmZ8BL+zW44US7XgMPRFKanSIzrolbpsD9Vp7Vs4y7sI5oPLw4jms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjaWvIFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228CEC4CEE7;
	Thu, 18 Sep 2025 00:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758156748;
	bh=1P7eWHurPGkhwCHExphone9WUR9mnSjMxc2kjomNamc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjaWvIFIkcsSfrFhYAsb6myd9B5uWoIuLug3tVi9NUkdc7Wkma9lAZVapes0mVhPF
	 i7DdlEANt/EPH7jkS3RYX8K+x77Fg6MwAobeT1d7bjaegXyZ603tLZScDF5TQLKvYL
	 sUY3UKIyH4REsSwfsZMldqiRCmUeQYlD8hgfcosFn40R+AGWGuOGxhCtvvhZxOy7Az
	 fV2m1Ev78ax/x8G2T8xrxGEQc1IKMtHN60V1HqDOLFe/bUpdGucTmOChN8W8h9TeUi
	 z5YTiFCYC0NtPAbTXwAwaD/0BiUJZOr6mF0yjPeJzuOG2YI7P3ZTQ7un7aH3MoA3Qd
	 xaBJMgsJdipCg==
Date: Thu, 18 Sep 2025 09:52:26 +0900
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
Subject: Re: [PATCH v12 2/5] dt-bindings: display/msm: dp-controller:
 document QCS8300 compatible
Message-ID: <20250918-icy-dainty-bumblebee-2cee76@kuoka>
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
 <20250911-qcs8300_mdss-v12-2-5f7d076e2b81@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911-qcs8300_mdss-v12-2-5f7d076e2b81@oss.qualcomm.com>

On Thu, Sep 11, 2025 at 07:24:02PM +0800, Yongxing Mou wrote:
> Add compatible string for the DisplayPort controller found on the
> Qualcomm QCS8300 SoC.
> 
> The Qualcomm QCS8300 platform comes with one DisplayPort controller
> that supports 4 MST streams, similar to the one found on the SA8775P.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


