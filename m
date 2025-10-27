Return-Path: <linux-kernel+bounces-871566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D2C0D996
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7663B34DE8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEEF30EF8E;
	Mon, 27 Oct 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjFU2cIR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999E2FF675
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568687; cv=none; b=oWtzekGySCo/nIosMsiNnIyNFKKVS63a9VkR2sGY/Wll/ZnPruPDcZ/Rn7j17I4BKsN/F9VPlTWjHBMGruO8oiM/ribJE/FBsqppVa+u+WR3IFEeKEZSu8mw51xhjsyU9YU0Z37KGQXQT1NkIqpuKGe34tROHC8rBCIa4MJFg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568687; c=relaxed/simple;
	bh=lPiYTDtRjDZmT217lCKABlCpCvxK42i4gTfeJsqcnDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IqB00PAj4xQq84hhvJ6fdWZS/fqIkKXNXqLxeqYhT42LwnzTPbc1FSG8QRcisC7KLaBMZDLyhXVR5yw+98Xvq+7AZgtKIZ8T1iU3g6xeVH+Z6Le1A28eltoHEboBzgVWeptFEM+XNAz+XLPeV9xsGDVW0MWOWbKEPJmvvA7XEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjFU2cIR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471d83da4d1so1705435e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761568684; x=1762173484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHGUu/H89+nPNkVnAmHWGAl8x9ue4UGzIIMtUhE6fgY=;
        b=bjFU2cIRarJGL2zNOe4Y6PKrxCb97KDnSpKZq/n+tt8W65nGg/1K6Gy9wbphqZltym
         5DsKywlktXoDvXrPQKDWlszY8Ftg2+ssTRk7l7Uj8F95lPiysi4xH+ybpTKklu6ZO5PT
         5N8hYTAcqQgB0Bo//5CZiTgxnuckGTvbcQZXCymaUMD54dIMfoHD46XPYDjkMAjPvmKJ
         8iTILt+v6uN2KFDGkJesz06TY6+FQug3PavpyFAh4qBZY6ZK5pFMdUmRT6mgubv3Q1Yb
         SEHIAFdmsLntt8JBF9CYYoGEYIkb1yzb62hdl1uppdTrJMlKSifpumMc0ruSMW3EDs0s
         8X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568684; x=1762173484;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHGUu/H89+nPNkVnAmHWGAl8x9ue4UGzIIMtUhE6fgY=;
        b=Wg1DH52af4uB809XJjlNj4IWSrWTTKbu6yq2ureSODa7XnbVzWfJ+BRMBgD7c1Yn1v
         xpEtal9FqZA1660M0KUAxHuQH7k8Og/Jyi4+dzjrv607jEj56F5HEmJlo3fEZnOotQsI
         K4s8I5gVxsOuo5EY71E15W8Q7ohDWuSreonMDz3gWKZ0kK+kbI6Vit7yMCfP0/iAySqs
         HAWNRvJwNn3wMZSNiBZjRR8QgS3CmLjevxpWhmUix0ZcgFQm24ynOFpb14SHKf+7Aw94
         RGQnXPIt7lj0wqjikw+CYlGUK/leQ1byDjfalSjFy/gx5UjLSBNQhyCjln/SndaZ2Ofi
         6Kig==
X-Forwarded-Encrypted: i=1; AJvYcCV1vwl2b8G4cfmsjQUsH4h4XAvsApi1/FCPPaxihdg99aqYKM6ciBHB5QTdElWc9LeA0TXdpDwzQViRSF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpcKaIG/mSF3ZYDVMP1g/gtQf504dMRISeMo3L399w0PKJmNDP
	901KhqSpy7b+rTsYPR9GP2QRZYbtvG6xEdXsZrAHZm1c38zijgIy++VPzNxR4IMsxD4=
X-Gm-Gg: ASbGncuwyjEvisBF35DnD2Q6/Aw4lzQhCTeKEx0iyT+hWUE5IHM9vslXZSoVW2OzU0b
	q9B7c4WGKpDCIPYQk15qaelKFQnY0UJACkouZ/NPt0ENPqIvzf1lDUOHCAdKphhAQqGl71lrnLB
	CnOoMS+8AmoVLTFzlW66uF4TdyRMt/U00ShIFUrkCRoQ6oAp5c2X43+C8bevsrUbIQrgVV6BBJ1
	JEmJy7PugO7olAwSCjdPfIyE0sKHmSTgnACd5M5WafhO/9Gxq0T1hE6y66IQbo6xIuezt1E6BDO
	L1YjOQ0uM4kaoj9vXJuyNlCj4ikuftmmvDMYDHVw99xRFSmQ/OiwIHgl6yUplWBA8h5GY4tXEen
	ngRu4XTurW/U5KwxfYmfZ/pBodHhoOkzY1HJRVAYZxOnXj9EQpfBtATln5x+01J+ZlBW+CiRSDU
	Hv8za0xhEiOLlnTKffFOtF
X-Google-Smtp-Source: AGHT+IGNtmCu4D763h6+9G3lrm83csyPVRDnPaCSfA4fw/nANSongHAbjp7WQaqw83gqqPcc+kuLHA==
X-Received: by 2002:a05:600c:4f81:b0:475:de51:ccce with SMTP id 5b1f17b1804b1-475de51cd8dmr32268755e9.1.1761568683944;
        Mon, 27 Oct 2025 05:38:03 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm14127748f8f.38.2025.10.27.05.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:38:03 -0700 (PDT)
Message-ID: <a3808dca-2356-4871-83e8-c535cd0cce86@linaro.org>
Date: Mon, 27 Oct 2025 13:38:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e78100-t14s: Add audio playback
 over DisplayPort
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
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
 <51da0617-db4f-4c6f-9f46-0492e49c9a2f@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <51da0617-db4f-4c6f-9f46-0492e49c9a2f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2025 13:20, Konrad Dybcio wrote:
> On 10/21/25 1:10 PM, Krzysztof Kozlowski wrote:
>> Add necessary DAI links and DAI name prefixes to enable audio playback
>> over USB/DisplayPort and HDMI.  The HDMI port is not yet enabled, but it
>> should carry respective DAI name prefix regardless.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> ALSA UCM and audioreach topology will follow up as well.
>> ---
> 
> [...]
> 
>>  &mdss_dp0 {
>> +	sound-name-prefix = "DisplayPort0";
> 
> We should probably push this into SoC dtsi since #sound-dai-cells
> is there


Hm, that's important for user-space and represents actual naming or
wiring on the board, so it is strictly a board property. IOW, there
could be a board which does not have DP0, thus mdss_dp1 should be called
DP0.

If you are sure that such case does not exist, then indeed we can make
it shared.

Best regards,
Krzysztof

