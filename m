Return-Path: <linux-kernel+bounces-731339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91422B052C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B8F4A6D87
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928772777F3;
	Tue, 15 Jul 2025 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IL2rJNoA"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E375271458
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563960; cv=none; b=KF7xPLoLVglnnk4prowd59yrFtHbeqQvpvJX+b1ogfZ830jYYTzMVPGquwyotEt3InUmKQ+VKIUAf0xvT6PkaallgiUB7epwdUAHcSMLzbyy9T82vjk3t7tqREgOzZHEYlyqDdI1cIhXOjKVHY4LBrdtQLzAeuOdSuEBDd2AABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563960; c=relaxed/simple;
	bh=dOb9Epf/TTGBkZ5gyzcRhX8nkY6+Xl8serOtV4krvFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ug5xFgEjBSPSZXvSCEb63MrDjzv1gx1yO8ZSiwYPH9ZuiGn0zIbKYQKi23As8Qu6RAMNq58LOsWsGgtxR4km6ozsXEiJpQDHoeSPRCjkbfyC9nELCLd3MB7jYc9028kqCrM2cEweO+rnUPaphoQU5lw9ztVdo99oCwBZF+LvFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IL2rJNoA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553cbe3e77dso1048848e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752563956; x=1753168756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RSJvNlWoWjahN3C/yzd7QKoGlsR79XtnIfFExv1q1o=;
        b=IL2rJNoAuObhJpOEXDT3LhkNDxmMhFUZ7SNrXTUXbt4B9rRH9lFxisWwpr8rdpCiNa
         8Csr/zifh477uqmedPTsrXXIXE7ccOJGq8zKr64UaI+rD7LfXsBKoNTuTq9MWRz8slBa
         wZEWkyetyjLKsMawGfOMjY6mLKtr9Os3f9mbs06g36XiJL5NBiKPwLLkDAD5Xlb2QUyA
         zf0CCiahELywgUIWfzdZ90jX1k8NUAg0SwspWRijGPQomLIxsqwn3wLm8opWpJTkXSIf
         FPi9IKN4yxMCrG/9lCgq1IX4AOkvYr/lRflj4s75DZWgg8JMzctiitEBQDdWX4q19rJ4
         reqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563956; x=1753168756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RSJvNlWoWjahN3C/yzd7QKoGlsR79XtnIfFExv1q1o=;
        b=C0BBJrUdxhLBn/Ov5suwaZSRqSbvRQWSkF6XPxB3YwQwnROAbA8JWoSlePMR7PWJL7
         uX6aP6kbKT+KBxNzdhLObT0vhMmgfXR7cPqMwJ7YU1TICBKpj/nGNO1ycMXNyLppdE16
         KvHWlIaN3p2dhR2iIF45uwIj2n6gtX8nzxD2oYy3HQFGRPNdp1vpjOX0QAktjAYYS3Id
         0dc0Uy6S62FD0j5hWV3UNldj/HSat43ZIswXLWUKkeuRb3paDZGM+IC2JpjuG1vYhdyJ
         1WkWIaPeN8Of6kBptcEO4uJXb1Hm/HJSQRnj5epuKf4T027bkmcY7Pd3I19reKDwLF8I
         vLGw==
X-Forwarded-Encrypted: i=1; AJvYcCVjmTLVXayYwJixGsY7OfLexZcE6u8bKaaFqhpKmSp4InyElFf8gxHB0PHdPs+C4ZXWIAgXxbhp288tSt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLPobGs0iban3pJWExq+e1LkPij/akjDkrQjCQvA2j2DdMxyUU
	UmsrxRN4l9Uht3KDvzwXivy7Lbe/7h2eaZwD45p/JcXPgOksF+/8ZVqof5Goov7UbOc=
X-Gm-Gg: ASbGncu3i3yKuoJnbtTAT1FbSCIZWfYoTbsxlHlIWM95OrGLoRHua72HDP6nT20b31b
	zB5lKaGicMJW1Co6hPmCUd+G0DnRCYSvi8/d3W64WQ9TNMWFeTooKY8t94fGvt5RBIe8jKg9x3C
	r8/FwmRWNW8JIv6i3/RphGWSgUs7Y+C8uKC93kRD2y8dV8xVpnJoPX7oqi0etgDtlnaGybroUFI
	FretGGwViS6M1F7gp1LUAqYYpiVwQIRlvpGjP8rsOAlgejwKq9zlwOywGlaFIZ6n7wyXXv3DPCE
	xhvHuATCl3CNTtUs6f5JsZuEiJoA34rRg5prQ5+TSAkxAgcJxPfVETp24VHDcnEW2bW6lTRApsZ
	SDy4U3tErrAYbLdRZ++h8wnKu316wz154eJFwx66YWOyoeq1Ku+nvpe6znMDr3zdOVXXaaUM+iK
	XD
X-Google-Smtp-Source: AGHT+IFIHphgOuWL4hHbYQo8BUYKQWMRs2PJ8O0o5nTLr+EyV7m9/xz8o904WRm6rWfLBy+6fENRug==
X-Received: by 2002:a05:6512:4027:b0:556:2764:d207 with SMTP id 2adb3069b0e04-55a1fdce413mr78512e87.11.1752563956166;
        Tue, 15 Jul 2025 00:19:16 -0700 (PDT)
Received: from [192.168.1.100] (88-112-128-43.elisa-laajakaista.fi. [88.112.128.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a05daa619sm1688569e87.41.2025.07.15.00.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 00:19:15 -0700 (PDT)
Message-ID: <bd7cab62-f0ba-440d-8dc2-3304afe884df@linaro.org>
Date: Tue, 15 Jul 2025 10:19:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/15] Add dt-bindings and dtsi changes for CAMSS on
 x1e80100 silicon
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <9361e954-e2c9-41c6-be4c-12b0e4f367f5@linaro.org>
 <5f3b2bda-92f9-479a-9af7-5d08e420121d@kernel.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <5f3b2bda-92f9-479a-9af7-5d08e420121d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 10:01, Krzysztof Kozlowski wrote:
> On 15/07/2025 08:53, Vladimir Zapolskiy wrote:
>>
>> 2. The whole new changes for legacy/new CSIPHY support is not present
>> in v1-v6 of this changeset, it just appears out of nowhere in the v7,
>> and since it is broken it should be removed from v8 expectedly.
> 
> 
> Why? If it is broken, should be fixed in v8, not dropped from v8.

There is a conflict between these new v7 changes and another old and
still unreviewed/uncommented changeset, which provides quite a similar
functionality, but it has slightly different CSIPHY device tree node
descriptions and their connections to CAMSS.

This technical conflict should be resolved before making a bet which
one of two CHIPHY series is better and should be fixed in the next
version.

-- 
Best wishes,
Vladimir

