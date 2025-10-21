Return-Path: <linux-kernel+bounces-862827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FBFBF658B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BF23AC377
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC123321D7;
	Tue, 21 Oct 2025 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJ/wLzMd"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE3248F47
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047505; cv=none; b=VaAhgmctgqqhKLXqESHd1UDCIUioEG+NeN0qxFxSGbMZhxqW3dY89Efz/mUQIClOQ+SiWT0Fu426C0Efba8zKNCgpbM4zN3nX5fWLb/+ICh0hKWAsg43Pwd6x+cE4MMBiHTPUqlvdf5MPRbzopOPhov3oeQo9Dgs+BPNrmbRyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047505; c=relaxed/simple;
	bh=E5v8NwhHRGhGdzJ6qwcpXX8Ic1u+N9hHqou9+MvM3A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CKXy+/en0xZGSt0ao4wStbW1LpwLm8loz03cJrBG3oOiQ0lFw8r5zsEQKpe/B7QBwzxR1tE4EA9+hDN4riNGuawVivPCj9ccs4Gw4ABsiDmRSOZhawu/f1mjIB94Q/KUme1ugTVGOpSDPuUX7hhcBKaEtUTpftpHT/PKvsGSvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJ/wLzMd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4270a072a0bso579857f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761047501; x=1761652301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oW5/XOBvE7uDDwrEHiFEsRScYTj311N2yjZu7+rowU=;
        b=IJ/wLzMdDTap6pamOYyfQsWzlaKqTFTAb0RUeIfc+1IgWNN+nFCm2wpDwtLpnKxuXq
         xLTR+XM0ze+sVORMosmTZIZPgFjgoQUKPtQCQMhq9NGnvvw9HS43PAwSTGclXVoSDiaJ
         52ptwAaiQCwsbzfYIB6ZvP0o31+xjYLfY1gqBX4a6peCBgIHV3LMt6Eha/7LCuKOev0R
         cscKkANbmttwzQqpL4XICM4NF9fMMy3lFIyc6V4vguw4rsUU+FOzzEV2ewXsXfzGL0ow
         WScqJh3ijPpFupo8uIOMgB7j7RL+Ez2FqdsYMDi3XdkzSty0fghhR2oH1ZUe3pug6Qdv
         5dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761047501; x=1761652301;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oW5/XOBvE7uDDwrEHiFEsRScYTj311N2yjZu7+rowU=;
        b=n7ILJMivTduLCI4y8N7bJ+j3DEq2lLYGyb3VA7SbH5AZoh/aDtwVxamg04cG1gs35/
         79MBCJqU22V2a2O2WirVtdWvJ1fk2gXwE7FsptI1A8AihwaQO7Np6rYpReBV64qUTHSY
         EXqs1lSPLHidQIRCzrcBSTLAt/3N085jBsLOwD8QPDSzYdOnX3aBroPQFjfPcfuBHGAg
         V7W58Y+bsJI7TbGeVS4Uce3WjM7vyO6QzHeEwaYHIpJaLDVg1kEGi7kBQaSFZkZ/THdn
         OmCsQSkVXm6pOZr/sHYPKVor4A/iZWt2kLM23wF8wNqLYf1Zw+4TYRDuIFxvJe2jmQa2
         rElw==
X-Forwarded-Encrypted: i=1; AJvYcCU02bGEDLYgC2d0YIoUIKbql0umd9iNTFfCLorGgusX6d9rj4VCWPB94A8ZtfHMyu8HuFFCxoe/0FnvR0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrl+NS2CTy3S0T2U/c5GRcVK6lCdhmqSAbuSQgbCUQRE4JgkYJ
	Prw951ZpcWyzItEMGNlYJmQdOW/cPITwSx679yCE4WApcsUHxubjQ3v8yAeIRM7x4J4=
X-Gm-Gg: ASbGnctNCdA8a6LlOgDpQfK3BBy3xNcTFdeBLaMjearCVRQ8g268xZQUx0Nc/KNorsv
	WSD+n3XR2FNlrA+Gw/0B16fZ/641s7ZFWTr9PvGvzdWon2pufzJUSRCpP4Z7MlpXV3CO4+HoDZh
	xRR1kG+X4NoqrE8xQjlgRvLKpR2B6C7pvfp/hVT4ZvSahjYXWm5OPfOnhCsP/cklwxTpwYQuAiZ
	IMY8oC4NgXsqJ9RZRYP6d1EO9IyqHuK4CQA0tS7JNtT6tpPa7XeDYtf64lMkn/WdFRrYXkUqfo5
	IfzEz5UEQyf6jEfwoTXFS2e0HfrC8MX+OrdQDnVU/l2Ra5LqCZZZRQfvZdkXx90SKSA02r6cKQm
	yHm3kJWlPp7L3E3+f9xchVjkQcSsb8k4UEH5iOZmZ0kLkdUdarT5akDfB89+VpFDQxkFbN3K5Rc
	0Zwkm6Q5KoxIxxDwTSNtgH0V+2tjNWp9w=
X-Google-Smtp-Source: AGHT+IGapGQl9lwmTZCkT8BrnxKktV2NGxlaa53OeTneIyZI/RrGfOsAomtObddDU522LsfDuHf/RA==
X-Received: by 2002:a05:6000:2c0a:b0:408:4c25:60f1 with SMTP id ffacd0b85a97d-4284e56ffbemr1187253f8f.10.1761047500936;
        Tue, 21 Oct 2025 04:51:40 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba01bsm19717753f8f.41.2025.10.21.04.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 04:51:40 -0700 (PDT)
Message-ID: <15a1cd8d-bbbb-4a42-8061-64dbcd7d3200@linaro.org>
Date: Tue, 21 Oct 2025 13:51:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e78100-t14s: Add audio playback
 over DisplayPort
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021111050.28554-3-krzysztof.kozlowski@linaro.org>
 <20251021111050.28554-4-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251021111050.28554-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2025 13:10, Krzysztof Kozlowski wrote:
> Add necessary DAI links and DAI name prefixes to enable audio playback
> over USB/DisplayPort and HDMI.  The HDMI port is not yet enabled, but it
> should carry respective DAI name prefix regardless.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> ALSA UCM and audioreach topology will follow up as well.


Also, in case keeping both patches in one patchset was not obvious:
The first patch is needed to avoid dtbs_check warning, thus there is no
strict dependency and patches should go via different trees, however DTS
patch should reach next once binding hits it.


Best regards,
Krzysztof

