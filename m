Return-Path: <linux-kernel+bounces-700549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A16FAE6A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 17:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A806167D83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009522D5409;
	Tue, 24 Jun 2025 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYd5Xvk2"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFE2D1F59
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777378; cv=none; b=kkoDY9HoULIRXFkfRg1BcIjbY3xfv7z/a7iguIjxE+XunT4C7MkGizk3DNNHHJ6cHPjzbXWF1XLHDfdyIEyr4ISnnBJGnc4y4V54XxmoP3VisSZ6Vf5rWIHh9n/fzUwV07/TtKzp23YRlht/zDs4SXe1/FhQ+xoXm6eL5TQhz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777378; c=relaxed/simple;
	bh=q9W5g/x2p8iuxmPpsoGB89P2dVxyTjw2U9FY9zGp/cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EskiXHSdwmHwHWuTbZmyM9wR5P//ZbQ3+Tks5adaz7Q01tCb0g4NFNJa7mFkCAVFGN90q8NCoCefrDFxHFlqRn8Av2hN0VMaf+YUsUqIpJmds83czdFZejV2vKyWlRvhCXSgNt1rhZ5cn4t5O/SuXp98H+agdKBW7Mf1cXQ0M+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zYd5Xvk2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a524caf77eso817273f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750777375; x=1751382175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=upZJKhPX6v0fBshAcJGhQeK2L7/ZLnoM13NbRk2m0p8=;
        b=zYd5Xvk2GNXGPwzrNesUbsGvr3lzqUH+C1jgNZfF4aLnHC76FQFPevpzitCkXxDwzu
         4xhI13RSUb3uWyvhKonLTlyL5Dawf4t7tKZzghFYr8T5O9E/C0D8obuSCd2oRm5FmdTD
         yN2eBraK9g8EnFIOZ+1H/ukm5XXCoPvDkqiY4DLQSgtYpqnDSAlr+QYCA454BRVTyqM/
         JRuyKXtmCAp2an9SUPJzySLRk1vVG806JmsnqwLwP33Pk0CmXy8+xwU3jic9YCiV1XrN
         HnQsZ+qZNv75HO+H8YLjXku8FBTFmRNygyvxbSnqLiV5yCM47C3vnlJl/zYd2XWYCKub
         VO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777375; x=1751382175;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upZJKhPX6v0fBshAcJGhQeK2L7/ZLnoM13NbRk2m0p8=;
        b=hHkcxgwGzkQq+R3aiw+XSxqMzdLxK5Xtz/Bzbqu9UGislDTCNWn9omaxzmpt0tKOl/
         k01joD/8pwiyedLpLhuaDADazRMAaJfhsNEX+b/cGA1mLQ+KTOMqHRosvaeWHMUuN0HG
         GLHI0dH/IapgVR65TAM96X/6QbubuS4DpuKuTmXskhNbjXBpTtOY77iIlg5hfX3WPK/p
         6tbkI5rNOs0Tu1G7N3AW3SnrNfCHSsIr1tX4OvkJXtrOA4rEm/a0Iw4NlGGTfdwYE9VV
         gZfmXT+++6niRnPcIwNh5TYxda0o9Pz0ffvmTHo1RDo/e4epaU+WbrFhELT3BSCC1Z+0
         9low==
X-Forwarded-Encrypted: i=1; AJvYcCXWECgPzKyJo1CtBBim7n7HfcFHant2el8ZFd/p+r7S4Z3YqJaz6jGrsSv23iqIU1guC5RcIHh/ELpZVk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGTAL274WS7Bw3Ce7GUzfjFDmjqxg6uclzTZK0W9f5Bs6cTMz
	KPckVV1zSVpC26vpgc8nqZscHoQulMcMl7CeLN2ksBdx6PhCES8x0vxtpA3S0SbXQQ8=
X-Gm-Gg: ASbGnctB/aYFPJz74M0f1mpN9gaj7AhKvlFZKLmAdC95JU1CgNt70qS1CrnAcs1UUvr
	V6lQXy1t2yHPT6VeiNZ8opEMP+6Xtg4He/xRz91FNlihJAi+lm8A+UXJHTVmFYGN411rHRo8Qm0
	CK2YB89TSYzfkJBZK8O+nA2aGukLOgM+1rf2NeWKeE6Y8KxwhQVEDAWNXNv2xxjvG8yrVdOIzTB
	mbe6IFI2956/73So0XKhfqL5DrXhcoanQ1YtcX6pVRjLAEV6A/mfzaY96G/SEZxxmPF6ACVk/wW
	ii9GVsVSmXg2ZVJqTitFe1rmOtwx1VQ9ub29hPTCltgt3lRPhsNC2GU63PVws9JQeqd6mehSvFy
	fTbLg6g==
X-Google-Smtp-Source: AGHT+IFDcUHForlttX6mwgJ9a9q/zmS5FDegLbCyKfmmcle79QFucWwKwP4U9VIzKorisanjNM+D6A==
X-Received: by 2002:a05:6000:4282:b0:3a4:d0dc:184b with SMTP id ffacd0b85a97d-3a6d12e7818mr5629150f8f.6.1750777373207;
        Tue, 24 Jun 2025 08:02:53 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45364703701sm146144705e9.27.2025.06.24.08.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 08:02:52 -0700 (PDT)
Message-ID: <a886e5ea-8561-4a34-ab2c-14f08458a0c0@linaro.org>
Date: Tue, 24 Jun 2025 17:02:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] dt-bindings: media: Add qcom,x1e80100-camss
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <20250314-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v6-0-edcb2cfc3122@linaro.org>
 <20250314-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v6-2-edcb2cfc3122@linaro.org>
 <3ec3fd62-bf21-47e7-873c-ce151589d743@linaro.org>
 <54eeb470-cd90-4bc2-b415-6dea1ce2321d@linaro.org>
 <0ab31397-580f-4e5a-b9ad-d9bf79d29106@linaro.org>
 <36feffed-4558-4e59-97db-2f0e916dbfc7@linaro.org>
 <krofzevprczeuptn6yfj4n656qsw52s52c7cgiwotidxmi2xo6@d3q5bb5zbccc>
 <f05cba73-6d8b-4b7b-9ebe-366fcd92a079@linaro.org>
 <lwv5pk3dtyyxgtrwxss43dyecesv7pvrzvgwacwrnztkiowfkp@jqosvhrs3jk5>
 <42b56d7d-26cc-4c10-aca2-a0a5a16b09f6@linaro.org>
 <3kprgpvzffupnjbh2aodsowwklliywpemzwpsftd2cng562yuw@37tpwmpemr2c>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <3kprgpvzffupnjbh2aodsowwklliywpemzwpsftd2cng562yuw@37tpwmpemr2c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2025 10:26, Dmitry Baryshkov wrote:
>>
>> vdd-csiphy0-1p2-supply = <&vreg_1p2_ex0>; <- individual supply in PCB
>> vdd-csiphy1-1p2-supply = <&vreg_1p2_ex1>; <- individual supply in PCB
>>
>> vdd-csiphy0-0p8-supply = <&vreg_0p9_ex0>; <- shared pin in the SoC
>> vdd-csiphy1-0p8-supply = <&vreg_0p9_ex0>; <- shared pin in the SoC
> 
> What should driver do if:
> 
> vdd-csiphy0-1p2-supply = <&vreg_1p2_ex0>; <- individual supply in PCB
> vdd-csiphy1-1p2-supply = <&vreg_1p2_ex1>; <- individual supply in PCB
> 
> vdd-csiphy0-0p8-supply = <&vreg_0p9_ex0>; <- shared pin in the SoC
> vdd-csiphy1-0p8-supply = <&vreg_0p9_ex1>; <- should be shared pin
> 
> I don't want to allow DT authors to make this kind of mistake.

I don't follow. What is the mistake here? Using wrong regulator? If so,
the job of the bindings and how we name here is not to create some
bullet-proof, wrong DTS solution.

Best regards,
Krzysztof

