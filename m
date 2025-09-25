Return-Path: <linux-kernel+bounces-831977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF66FB9E0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EE2A4E24CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0C233707;
	Thu, 25 Sep 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+VmzwDH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98523E350;
	Thu, 25 Sep 2025 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789006; cv=none; b=fO2oFGjdEab2JAIo1Cv1N1YjUSpMqwlBv/xbjlbUw0oXrgwYie5ZwhRDzx1xfhsQMrt9ni1f1w0Kx1fj58yrvPQ0WnTP6xPtj6PWPdXl9Az6xcNtXFp2VdyhCgQz4YdJ2qi/RkszFLHOmm3zdOxlbjZJC/OEzLqKcn9y0fHU2cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789006; c=relaxed/simple;
	bh=97eP1RrZK1CzM7LJ/PhdktA7pOXsynV5Pvzv79A+srE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgyJkRUrv+VBXMK0xJhzYIFNrEOIDBBbgNyKaBuOcWKoKwYJSnmIVmpIpmdypKfNpKafcDIC4/gFsbIfFdMy543tPQsUohDsjVHfaS/5A2Z9ggkc3/PW1MyhEWyBKMH02ackctUYaa3c/kysGUYkysVBXV7iAaSvP5nP800hIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+VmzwDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59717C4CEF0;
	Thu, 25 Sep 2025 08:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758789004;
	bh=97eP1RrZK1CzM7LJ/PhdktA7pOXsynV5Pvzv79A+srE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S+VmzwDHVzfldoxi7HY1QHRXIjxUHBqpvaSHHtiAvoATuXZpUo4wVDIoXmF5P/mRr
	 2dIDoKuLD8cmq8wBVAmbf1lLzpZ3llVAM8GzgxjjB+KV7gyf1Bag9HupYchLUhrY4I
	 zrIbv0AZjlKOompmLwjfOzXNL3w5q8OLHvj4pOwPgNbkF+BpzciAQtBRQpdU8TPmcV
	 jakS27dQHZMDO8Y2dCXKfJFMYrp5w7tnkACv0VmzCFtCfUayN1pI3qbjdeMZolO3/R
	 fTQr9Q8SdFFQKSbdWjafnyVoyWeQG44KWS1VK6UdIgo3Z84LttwqpajJYpyU4zQAa8
	 h/ylSOSv0Sm3A==
Message-ID: <a8ebec72-eee2-4a02-ac6b-57678aa7c50f@kernel.org>
Date: Thu, 25 Sep 2025 09:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: clock: sm8450-camcc: Remove sc8280xp
 camcc to from sm8450 camcc
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Jagadeesh Kona <quic_jkona@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com
References: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
 <20250924-knp-mmclk-v1-2-d7ea96b4784a@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <20250924-knp-mmclk-v1-2-d7ea96b4784a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2025 00:56, Jingyi Wang wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> SC8280XP camcc only requires the MMCX power domain, unlike SM8450 camcc
> which now supports both MMCX and MXC power domains. Hence move SC8280XP
> camcc from SM8450.
> 
> Fixes: 842fa7482915 ("dt-bindings: clock: qcom,sm8450-camcc: Move sc8280xp camcc to sa8775p camcc")
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> index c1e06f39431e..dbfcc399f10b 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> @@ -63,7 +63,6 @@ allOf:
>           compatible:
>             contains:
>               enum:
> -              - qcom,sc8280xp-camcc
>                 - qcom,sm8450-camcc
>                 - qcom,sm8550-camcc
>       then:
> 

This is not a revert.

Where does the compat string go ?

You are missing the part where you move the compat string to where you 
think it should be...

Also why is this patch appearing in a series about _adding_ Kanaapali to 
CAMCC ?

NAK

---
bod

