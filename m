Return-Path: <linux-kernel+bounces-832028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A99A3B9E2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054CD7B34CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B162773E4;
	Thu, 25 Sep 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcBMAzOp"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2476221540
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790903; cv=none; b=PxqFWYhVMZBJKYGtDKOsn3YOVh3SE8TOwELbL5uFBhSSswNRAm0EcCwpDvf7xJypOFv8WjwH8NLPxe762A2oDWMbLufyK+7XhNDuNHGFjEeVYzrSXe6K7nj11n/1DyKxee7/7QXqYTdFuik1GlqXUVEUxb7+r9bjMB2q5aGhB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790903; c=relaxed/simple;
	bh=yqstp8v0w5ZqvhHqs9nCFyjLloZ4iTt0o1sbH2L91Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dg92Yp05903gC1KtLGISdc60Cm3ys7PWnW9gZQuMR7XbNtKJKQbqt+vRam0A/ltKYYavVoLuVKxsa3GFJtFcvUJBjjkIah5DBW3iGxbcFrh6fSy/nxg0MEZ9PsJ5SJpiWnyoIFx7xAFLggCW2DkpVHi/+jqq+zlFxSWRGHbAP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KcBMAzOp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so1923515e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758790900; x=1759395700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqstp8v0w5ZqvhHqs9nCFyjLloZ4iTt0o1sbH2L91Q0=;
        b=KcBMAzOpgBkmgOocch8p8cFOUenehfx6DudKUPvCrNWWDmnJsQL7zcRP0O4lKi1irG
         nkyiXaIwogYr91qhYclzydOPex9sLbNcQOAbB0cEtkxJpRvNeNb+4LtDObOnFyzV6N1F
         GmILdP6DWfMDYHUr+JL/CMmZpCh7/aaXNE2tPaK+qkK5vlQQN72g8TB6nbT8Be9DgqyV
         jVYRVBTFfRjjF3NL+7yAlnZ7bVgS54yZBEZb/0fku7IZyyFuKMT/pwMQGk340yOxPMXU
         pyAOdZAWaAO6GXtHjXMTE4i9f9Cz2Kv/VmAET5PkDMVDRL8GmnxJAMAEG5uVCIcIGS3G
         lFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790900; x=1759395700;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqstp8v0w5ZqvhHqs9nCFyjLloZ4iTt0o1sbH2L91Q0=;
        b=JzZIgTTOQ/Ft2uyw8Lx+L8CIL+Ix55VGtSLCcvz82Xr3TPtXffHxHDGTCQvft89uDd
         IHSqYfEFCrqmbdfE3lnn3b3+excaCKsiCJmx4eDBeFVn2fQX564MiX3pTN4ir+b+ZuzN
         r0oPbWxkK+WxcgdQzZuQOISnX0I9X9VgUKiyKUf9/eHwXlNrOAvzW/fx+3BtGdqYZKOd
         NmXVxwPfAVgyMH61wTs6HwH140HRWPM8JASasUowgDbxwduKEZw0/uDynjSSu3tcEkul
         GaulSpik5rV44ZWoAsUTVSWYuXGjFF3ztx2zQ6pj4Vpo9/2/qQKWeKG7x6JGE3tWZEJt
         Rt+g==
X-Forwarded-Encrypted: i=1; AJvYcCX960kNrXXJGbT0u8CrVj6/6zg7EDB7a3ZnfDMK5SYHg6FAUCjyLsqDD1I5/8R5OBTo2g7+bawzMdjjubI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHFrY3IJ0yqfqMQICwUcJkn85rs3L+MYyQH/uj04aGRkDhtet
	qUTcRzkU5dpzpdzsFo2BpCduuOfse0IM9eUaRPLj1KweK0LR/5dpp0NDZYn7Eh3LGbo=
X-Gm-Gg: ASbGncsE265CnNG+fPYolHKjQaMb+NVqdbZMt0glCn4i6kLHj7ox1jT/6BggsM0Zrx2
	S2+O3PlYmbTLCFZNICTn6C5eum/RrNWYT2kUoPEMBwi+GUEJ8S+iouiUlIE8Y06nJnnXtHGoXT3
	RqJG527M0riVPpj8he1NiF9TMhRVL6EZ3CcWjmQmtsogNajbUJWiarF/HY5z248WdZ0NuAwsuzN
	2IPyTkzo7RT/WgXNYEt/TI1+3CRxTJb44e9gYMNGUCZHtoQYrpU4lVlnKzRVNM8UATzf3aPjtWD
	x9nyXywP8TP05sZj5LVhXYxGpSMc8YGsJYe/WeyoXCrvM3J3+g0+G7QlN3/JzlgzPjwxKM9/pKH
	Cm/yT7pzytdxLrAGf5gomTItsmG2u70vBSvNgtJb7e3SDTDnITG0gcNW4reevBVclpyjFZkq7wn
	Ib9EoGd7BxnYYZ0rivWEvdqZMy62DWQ5w=
X-Google-Smtp-Source: AGHT+IFPH5bNTpMjVvNRN26DifPNLAFoSeAoicHRC1HEEH9oRvExzs+S4YeuHSGoOiaUNTFghFYSSQ==
X-Received: by 2002:a05:600c:358e:b0:468:9798:1b4d with SMTP id 5b1f17b1804b1-46e329d1b47mr30509265e9.7.1758790900027;
        Thu, 25 Sep 2025 02:01:40 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb7203b8asm2128929f8f.9.2025.09.25.02.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:01:39 -0700 (PDT)
Message-ID: <14df3870-6cb1-4e5d-9c4d-bb8acef8c594@linaro.org>
Date: Thu, 25 Sep 2025 10:01:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: clock: qcom: Add support for CAMCC for
 Kaanapali
To: Taniya Das <quic_tdas@quicinc.com>,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
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
 <20250924-knp-mmclk-v1-3-d7ea96b4784a@oss.qualcomm.com>
 <4315205b-5320-4a8f-a707-45f5eb35ae51@linaro.org>
 <8c558ac3-541b-47c4-be4b-c9101997de7c@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <8c558ac3-541b-47c4-be4b-c9101997de7c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2025 09:46, Taniya Das wrote:
>> BIST == Built In Self Test ?
>>
>> Can this not just be put into one camcc header ?
> These are two different clock controllers CAMCC and CAM_BIST_MCLK they
> should not be in the same header.

BIST means Built In Self Test ?

Is this really something to be upstreamed ?

---
bod

