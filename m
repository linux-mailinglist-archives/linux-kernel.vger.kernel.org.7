Return-Path: <linux-kernel+bounces-832042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BC4B9E372
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED973BECD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457F2E8B71;
	Thu, 25 Sep 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNEVQhCi"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57C27EC7C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791423; cv=none; b=Zcgxgxmo6WkxlWzNKBBOJ3xHb4KPxlmRLwtf8Bv/5i1EWielW7B1z3YZUTh1S5MgKalgMxfJP4dNvxjYt5gH2v9h4t3xd6av8AyVPA/8BFopHe8+PVRb+96Qbp5kU0Jmoau8xV/nnbRDgj+7APynEw5s7e4DBbmWreon54kh9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791423; c=relaxed/simple;
	bh=L5XR6t5ZxwfG3rtP2YnGXIBz4GtqNch7l7akgqfMJNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3NO/1I3FcJiRb+rD+1xdF0FMMj9NfXA7qyj9l+ujd/teOyhKMVrHRMv2lCx1eC/eXDTdYtq/fcKKX3Yr9KKVx1UcIC8if/E2A3kRwFNzgoFQ6WUyLSBoowVrSeWflK7xdiVTKA8wPVnWUQK+/mcUHE5QdUbuw3thzhIpSyxzbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZNEVQhCi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso551786f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758791420; x=1759396220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMuA4DWC6qNeuux3AJTay/iyO89ifrzsRhDuGmNfotc=;
        b=ZNEVQhCiUaS4rNzMkUfSwGh75tyS/xDug9nFLpBRlRh600+XKL5d4QkFikSRs6y0fU
         nsd1nKRh1f+SBofkmrSphSxpGnVwOMti8pinY0Ahkk/nM4JyJYrb0FqUHZdBe26np63z
         TaLFo/XsNaCjyL8hl9dnsE+/BRYHO4jPvPifKWcwbqk7yHG27TkkwAhUjrRzImj94t/j
         g9izz81008mC0rtN6Ip7xjNgSN3RvxxCzwA0FhZSx2BISl3R/eO8BVbxytjl8vHLVlPY
         Fi+UB9mLUQlUugtLCa268g9hEC35EdWyuBYRDckiZPOmyu7gMYYNjwzZvRNvtcc0lSL6
         3WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758791420; x=1759396220;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMuA4DWC6qNeuux3AJTay/iyO89ifrzsRhDuGmNfotc=;
        b=eLn+3Ql8fX6kkrWWurQpMNp7CVojn/yTJIzAumz9Kne8OeTdf3gUD1YhPLtY3dFTB1
         YK3S/UyFQSobwrD0uaIORv16XDSGle+B4MPFftvaV0jzRuSv+tdFWe1B5W530ei8wBn7
         LaRoLumq9iyYTQs/zZPLsxgk5Xg/kZkscMqQD0nJMykCAYIG42m9EWWAid8iLEKDSFSY
         7M7qeFDPRU163gXcW0WJHOJn3aLdQF8acqXMhslOWaShL2G84MC9Hli56GVdjIEzbkjt
         A7QNHKaCSvfF384ICRoSTma41ZpmOAIGqDYHp2dvPjXdaq2+k9RMNafCZFUijwspvDf3
         nd0w==
X-Forwarded-Encrypted: i=1; AJvYcCUEqnSEl0m1/eihDNBpVI19ZbKNhA9uMRuKXny9iRffFaW11+mTNh1Ek2tMgnueDzAyhl6RVhjnM4ID3jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kj9eJw/4mugZ3GWZgyPtV5DW8gJ3TjKGbcf9sxNCJdrjWR6K
	1C7XPswII7z8VI6LfM0V6b4VhE7MT8gg1gsPbwJgHI6u+xG5Tnkni+eL+J3kOl18FGM=
X-Gm-Gg: ASbGncsVbydbFH68k2h/gjtySDpCy+zHapRkRgrUapcJWywD8gPhUPVBvJzVR1KYQ0c
	crtupzb5sswIQPmjHmn88W09JtK2VEojKNVCReulnP/yNhYhoyMGy/RVzTJHg+NcuEdB9WyOx1v
	hfxc6nDMZpKsJGg7EftkZBk2Q02sz+CYWJfQbrqM6KSNd1oWeJlIVTlP80shndDd7UYFkKI0cA0
	uZHMJAahzi4dxR0FM40P02+ihAkDu3g3bbq7Va7lZboOksT78lA1i7oqzaiHwjO40oVeA2635Cu
	PrF2nz7eOaSYxg9IWZyqeonT0fDuFY+gDmyJkEOTsdKlk4lCdaDTv+S7+Okt6ffEYgPOIpwdG2u
	umsZOa93AFCQn9mBy1ODsBxEDrSpCOWm/UN/nYXMm7Sb5Z6AYocV73tDQJBYN6shrNC1YDDgVrb
	zOjX16W+V4seYaw0uinnZO
X-Google-Smtp-Source: AGHT+IFDpMpHsFRgd6YSWfaUgP4h+TK2gackvhjt2ED62B1HXzzX5IdszOWCjQD2qcaPDSO7lAZ6/Q==
X-Received: by 2002:a05:6000:2484:b0:3f1:2671:6d9e with SMTP id ffacd0b85a97d-40e497c346fmr2389638f8f.1.1758791420460;
        Thu, 25 Sep 2025 02:10:20 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e3bdsm27566255e9.2.2025.09.25.02.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:10:19 -0700 (PDT)
Message-ID: <d18c5196-dd8e-47d6-87bd-de0ac94fbf3b@linaro.org>
Date: Thu, 25 Sep 2025 10:10:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] clk: qcom: camcc: Add support for camera clock
 controller for Kaanapali
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
 <20250924-knp-mmclk-v1-7-d7ea96b4784a@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924-knp-mmclk-v1-7-d7ea96b4784a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2025 00:56, Jingyi Wang wrote:
> +static u32 cam_cc_kaanapali_critical_cbcrs[] = {
> +	0x21398, /* CAM_CC_DRV_AHB_CLK */
> +	0x21390, /* CAM_CC_DRV_XO_CLK */
> +	0x21364, /* CAM_CC_GDSC_CLK */
> +	0x21368, /* CAM_CC_SLEEP_CLK */
> +};

How is this critical list decided ?

For example why is the AHB clock critical but the CAMNOC and AXI clocks 
not critical ?

---
bod

