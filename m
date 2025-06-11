Return-Path: <linux-kernel+bounces-680895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D592EAD4B65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 08:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E3A16A4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F8D227E89;
	Wed, 11 Jun 2025 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxQrljdX"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09D227E87
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749622871; cv=none; b=e+PyymYdN9/aBBuMn1SIaFdKTrsl18wFATYQ61d1+u9ld4AXvvM8lyzRggOKEQ2naCBXbcX9ts5Tg/8IAPrhRotTCYXBmb/aZCalKf+of17Bq4gAkxH0v1Ff2Oe5UeiDS+0yl1mi+a0uCtsMBPGEzKLzDglP2TzrtFK2Ir0qlQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749622871; c=relaxed/simple;
	bh=wgfIdpRvO+AZaghNHz0zFC8jXc0J+BUrOlmFO4Hw5s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmXj4IiiUqIPfMCGW+b8WjciAhd/wIrSZTFQMOlwqeyEV4Fs0R81jTxqXr6H99zcMKE+itVO1cVDpj5VcQWKGhcN1myvX7iRJq/86gRiY9gjkMeFAfnjR4TpSbfU02rTGPL7bTSsTANzNMlUsTA6zMUEFDrBbI4ednnCf8PxamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VxQrljdX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so33883f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749622868; x=1750227668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H49y5YVCCcLC59k0m8v0JycfHHDJlxdG1p1wxeBPnio=;
        b=VxQrljdXAfggaMtHvav8BlYpvQ5murvfI6qYUXtjWnyMLlqn9vSHt2nkBLYhcMVWgr
         rngMgpaOCnnVkxcQOTpVOONfor4q3J7QpsT3Sw5nZv7FodvDZp5tSednFqBN/FNrz7lO
         mCjKyEWrWWmkRcL5EahradspPRz1NlgIxRHt3+8Kyl51rrbGOrhejb9n2ik1hhJ8ivKf
         Y6UbzkPx4grY1IOvwzmlOM/XohyWxhnHoATav0d15iDDTiGkiiWojQ9aLvZGDIG107/E
         Tij44DHITxccZWImlqC8f6nlMonL0IKJQKMH8r85IBSfoaT4nkfm6g6t+b/4vtXRytvz
         bnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749622868; x=1750227668;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H49y5YVCCcLC59k0m8v0JycfHHDJlxdG1p1wxeBPnio=;
        b=Rhns6peeepTbVyEDikKD7FC2Idgmf+80+WkwMCGDvv146saV5oSuSv5N3pCdf7pkbe
         dEXOWsYQAiOh5JlGLS8DNCHUlAMrJFgp7YNh8i9nsXOGgwjFjXWtc/qPFS7iVitV6+QL
         nzrDgvlYTKCNW1F16hcuR7lt+EQ5Fb07sNIq5g0IpK0o1anJtzkeoi1wYOMXEgEeULh5
         6IDTHcjT/D1ncfjxtfamwXCKP5MViOP793XEbpOGMrFhjIoodXPxVbwRMHx4HsTPX0Bk
         Vcz3jj5OE895BdxBqDsfQQO/jcJOM2R/lO9Sba5bsiSBAzsFfRJMPqUnvWYblnxCG6t+
         RAhw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ux6/WE8IK10b3o3R8EDDUDfkAgr2gXxbqB9DFxfYEO/n4lLDEXlMv8oRJ3eWvkEIrtV2shQxhpN03xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSL9612vzQ7SaUJJ7TpY8cTX0oNmPuW7BYVirrzyTuKniUF2a
	4xxZPqrN/v5xsMmCAuAqWmAcu/McoUxk1a77Q+EzQ5MnYkP7Ifess3VfOStJdaYSkfo=
X-Gm-Gg: ASbGnctzJObPfX0ElQXkg2YRe/HiJuH5sxvKzL55F3bj2BhELGgQFB+wIfO3D8LoNhT
	ODeQB2pNxcGO0YhaBqPXHH0cdN/04KPFwSC21nGv5r63ZOnUco1RF5kfPnjZdcwwsqT9vVyPrFX
	3VDONz1XH1l0CT8H89vzJm8nNTyL1WDnYJ7n7FpZon+WKuPT/l0LAutAQz+BYZRBg24NlI01vtl
	kXTPHmLq/oL04V3YcPkQLigf5TQSGU5OKeFSvKy6OJETzsm/IRTbA3wMnq/JT4G0gBSPv2a3lBN
	c6EwXcBsHmLQhGjm+KFk4jQ88e7RVR3uLWNGCI4AiGb3+VQNyEaOHvdbAftnFlArTVTLLNgV08U
	VRd4uv4k=
X-Google-Smtp-Source: AGHT+IEarnczQxYkldyQAgqK7gAPAp5A+If3BCU9tfItzyU2/3kobA5cfdLuXp5ux1yaylvgS8DRSg==
X-Received: by 2002:a05:600c:c087:b0:451:df07:f41e with SMTP id 5b1f17b1804b1-45324871143mr3839615e9.1.1749622868451;
        Tue, 10 Jun 2025 23:21:08 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de70sm13890748f8f.5.2025.06.10.23.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 23:21:06 -0700 (PDT)
Message-ID: <82733f35-f5d4-4927-b2f3-4d739b388bc3@linaro.org>
Date: Wed, 11 Jun 2025 08:21:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/17] drm/msm/dpu: Implement 10-bit color alpha for
 v12.0 DPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Abel Vesa <abel.vesa@linaro.org>, Srinivas Kandagatla <srini@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250610-b4-sm8750-display-v6-0-ee633e3ddbff@linaro.org>
 <20250610-b4-sm8750-display-v6-14-ee633e3ddbff@linaro.org>
 <3d576c19-6f68-4f04-b89a-e269c438b339@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <3d576c19-6f68-4f04-b89a-e269c438b339@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2025 16:10, Neil Armstrong wrote:
> On 10/06/2025 16:05, Krzysztof Kozlowski wrote:
>> v12.0 DPU on SM8750 comes with 10-bit color alpha.  Add register
>> differences and new implementations of setup_alpha_out(),
>> setup_border_color() and setup_blend_config().
>>
>> Notable changes in v6:
>> Correct fg_alpha shift on new DPU, pointed out by Abel Vesas.
> 
> -------------------------------------------------------- Vesa
> 
> Not sure this should be in the commit message.

DRM, at least multiple DRM-subsystems, adds full changelogs to the
commit msg, so I think adding notable part is worth.

Best regards,
Krzysztof

