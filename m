Return-Path: <linux-kernel+bounces-833794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3880BA3187
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B71189CEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C772236E8;
	Fri, 26 Sep 2025 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ck/i/8K2"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169D21ADA7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878180; cv=none; b=nbbm/0BkXiGPDCnFHcb6KNm6rXrUUrJVIEUeBEOtoT+lxcYnC2GSPzzOMc3PhuZSx24LKgO+zkFXwJ+lKTB9VBB6BmP0qBkod4n71XqqyHejaXzZ5xa2Uqwusn+sInafXEXCmw/mzNzZTooqGH16qtlQ8rhzerMwFem8n9s/aM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878180; c=relaxed/simple;
	bh=N5Nn5ASoUV/CLfe1qwCVq4qrqLwYCl62U+RpSnol/00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRJNDwfzhuiQYY+kOtypQ5GVYTZtK3/mPjivQ408gWLRIujeFc/DxVbhRRBm4u8LFiQQks5bj9Rhq9de9pGIF0cyeByugMhc73XrShGBBWs6P7MQFEaR8m6V1GTqsi0USlCp1CZd7x6BIIqEgKAJaHf/6SSLRgS0yfjcX5SbzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ck/i/8K2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46b303f755aso17353735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758878177; x=1759482977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYShG4odej5vYKThNx262uoG6FdT0LyVmxecSIMK0Uk=;
        b=Ck/i/8K2Ewnx98L+wvIm4R8/2kMTphZr33Pqa7U5ZqTRQ4T0IDNz6Nx1+SQkGJPuKe
         ypN9xR35cjX+1tx2U7nFqCxuc3UWDgvCW7IjdN5sTC4mCHT6gSH9pl1hazQMiSNDpocf
         Js7yP1qILy+YOJuh7DtZcKyoW3YGis/3RGWEWUI5pVWtNHKvIwhY2ixNOrR6GzAHmoZF
         1gJB3GulmFjLTdLuMv59DXa2jN6VkbpjiesbPBIMi30DkJo22Q0bZ5nZhd8BN/gwN6xV
         wzPAFI0nDlqYgtqVWa9BMjWhXR4/Z51hLi2dfu++tEHb9tlEpqY0TYbO2unjUtngHHGW
         LdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758878177; x=1759482977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYShG4odej5vYKThNx262uoG6FdT0LyVmxecSIMK0Uk=;
        b=nzFTYrLlZNOMk8MIsvlUMk6R6yo3fZSiy4DTtYYzgf4+DKnK2T5ZJdBxPfZbCeOBxH
         XrBQrM7RWMRgUYoYqY0WQsGpn6nIMiA8cmznJ7VMJ126nEwN7Uo47CU85NPjw3FAre0X
         MKZ37hTZDJSIlT7RGupPdhSmk2qIqXlu8XknBOYgM+7CwH9+ibNjk8fx98P7H8IofSIv
         cjE22U6DUgMX2Vgygm+cyZeJ6RlzPnUaq8BgQOLP0dRQdPb8Xh+WekVXyuFSW4mjCjCA
         w4zOclqcYa4Xlzts9f1I/QPCbeC3OwNrK2IjuhK/jFXsXlHfxOuttTrrq59kfv3SwwLs
         zL2g==
X-Gm-Message-State: AOJu0YxgQ/i+I8Fo2HEbeMt3o0lKR1WsPiJXPWl2e7DH0f1CDKDUpJiy
	f/HsP5RfsqhPQo1AkrROy/IWd1LZ2EMAOIfWBWBxj+eY19EeOX2qZNTj+QU7EjUMAkA=
X-Gm-Gg: ASbGncv2k0PKkp1kN6b9+8IW2A2CB8gw432awcYb9lL057NYlyiUICV9u8CTkjsWscw
	nqeT2yNXZeINuxK/Czqe0MXsrdYhNKVuHVI1dtyAdRIJ46qxz0P1GOEazaJItAknPZYZGG8oTwc
	cAeWlpqcjK03QvMZQYuAyUEWcz118HOyQdAVQlX5Gg37BhOONd67ukvAJUfbDn2s3J4TnE+8xRc
	AWjnGmSbR6oaUlyqIws8wVIPeMpT9TStwu2JvdjXD3W0AidSZZnjqJF0KZjxYRjiIO3kerO4o69
	3XCOIBvH21rgsHsXqCJIK5/2VaigSS1PwVfFkJlaxtPUbPTk1zF4mNry10Bwn3c2SCE06YXwyyY
	1gG1oIQteVEBlxOG/2CcY3E3h8Qu+HjFO
X-Google-Smtp-Source: AGHT+IHWIpWJkFH6MgSaK7Lwa2sAdlk8StsGUnX1BeyXoXscm4t51npqgFevzyhLcqPW6OMTyJKXjg==
X-Received: by 2002:a05:600c:8b33:b0:46e:1fc2:f9ba with SMTP id 5b1f17b1804b1-46e32a0d5e7mr75187965e9.25.1758878177511;
        Fri, 26 Sep 2025 02:16:17 -0700 (PDT)
Received: from [10.11.12.107] ([79.118.185.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb71esm6152127f8f.1.2025.09.26.02.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:16:17 -0700 (PDT)
Message-ID: <ec25789f-eb79-4a52-b93a-3005756cb572@linaro.org>
Date: Fri, 26 Sep 2025 10:16:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] clk: samsung: add Exynos ACPM clock driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
References: <20250924-acpm-clk-v5-0-4cca1fadd00d@linaro.org>
 <20250924-acpm-clk-v5-4-4cca1fadd00d@linaro.org>
 <798600a43825818bcf828da7060f38105f7f3225.camel@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <798600a43825818bcf828da7060f38105f7f3225.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/24/25 5:00 PM, André Draszik wrote:
>> +	ACPM_CLK("b0"),
> The last one should be 'bo' (bigocean), not b0.

Oh, yes! Will change it, thanks!
ta

