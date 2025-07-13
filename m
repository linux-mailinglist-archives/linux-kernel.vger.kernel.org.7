Return-Path: <linux-kernel+bounces-728968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7C6B02FD8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358943BC00D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29E1EA7EC;
	Sun, 13 Jul 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjmE+0tS"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EDA1A8F60
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394808; cv=none; b=THix8/JzJi6Yp4I8dSyeACMmdT2k+UyH7zwqnhgCJ3a79Dbu0pShbdS/iy8QMz8f3VwNQY0r8iJ+QE5t5xYU0ly5bfj4B9F+hYDGAxOoL0bFFRzlBFxvkcoNPlrG/iPbuBh6nb3lV9fAUUXUUa9ADvmeDZTt46YWo7HuiYxaqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394808; c=relaxed/simple;
	bh=c3CMpqzcWhpk0RzXlUM6GTzeKaq9zbb8rgyjL3hbPCE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b4g96oKEW2huVF5sRqLbZqO8Ait0jQfxkY5vRqKfP5j17/ip1WwcMpFnc+bVaAHYJ6klOCSHKikUduvYWN1MpzB1qUa8cZzkBLqgSfmvxII0XFTXuSwJUx1+Gxbo4tDXNmThbQTf5psQdf05Xe13E4sZgeTPyJ+GE7nNNsAzid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FjmE+0tS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-456053b5b8cso476465e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752394806; x=1752999606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ebTXJjZiToHpEJi+iYoNzkHIv4Hq08aW7mp+XQ1QYLc=;
        b=FjmE+0tSdpOIshWmZzv67mdS4b2vny+th/JhcZonCaAEohZFDcDw5cqZNXsmNhoBCv
         QutR1xwfmg4fH8HUsKOXHjNg0z79GrKaNDxyvbyMpe2Q+k7pMDa6ziMNLMPxmOtRCMzb
         1yHrxlHmQI3nrBKaHCG6K7PjQNXKGes6He0EE32sIHEnnXYYcuC6t/zbZlcsJIiVmpuN
         tSM9cK4X61wVn0QXvruRrNVjWP3r2tB7YuAslxSalSHrZa/P3nMp6+evFZdiLvQYXy6c
         TJVh2DS7XG6PLlY/Vjgrk1DqlmbPj2emdYlZYXbFgviCI6e0M41ORcbczsukdw0oT+Jv
         x/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394806; x=1752999606;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebTXJjZiToHpEJi+iYoNzkHIv4Hq08aW7mp+XQ1QYLc=;
        b=FV/yuPuTAQtKv+n8PWKbVRK9vQIVbR82STC4sHKpkOaoKnMEiZFjVRgGv7Isx7plwt
         KFhQIcAtbM812QMKIT6Z5kszqX724hx8Jr31rhKZw2/hXo09VVib2morr18oxC/AF4Al
         UAB4MI/AN26QJyPsBq0X2EOD53/ipTYV8TIM5HSIx14lisakABNnQjV9IPR4oMvDUmKy
         Mon2/+GKgFcB1nay7feRcWkeru+TpQoqvo7op0Wg0AKhoTdv/5/22JQoIH/Ox9c3trpH
         /PJ8yIyBBToTUIu+XzsEbcAcCRZg8vByBOT9xifddogjz6hkivfE5UI/MWZJ5PqwoOIW
         WgOA==
X-Forwarded-Encrypted: i=1; AJvYcCVNaM3nge7SQVufcvztohR/h3U7/OollduyN+oHrq/va+yExl/1eP0f5c94IyBNWS4AQsOHXo7IX95A/KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVk4eKh+L03/bkercZSyI34AVWIanxTQAwXRhfcBPMbVPu0nyz
	nRgg7Y8P+SOnaYQM+bcoUvalVnsKm/l4RZZyALfVNwrHRewjKZsFtGF0h7tAjkTcj7c=
X-Gm-Gg: ASbGncsv96i0s69fyJp+fefdfN1l0NHUh08MGMlrEBCtpU/KjEyHPT6dFOyGSkwX7bp
	oUEsJ7XC/sxgEruf4T1YyGGO42Sw6eXZ+PVjyPYjeu3i/QvenvpFbbQWUIX/YJ4JW9IjnV+Q98t
	Ns/YBWpYRwDXTgQqYxmhyOegv9l7wkh0KRI7/CYJLeW5lXFQFeb0YrnYyzrptbEpzaS5bkt9bmc
	Sc1s9ZPw4U9ed1w/tSbrsjTBxAiNWv79J2Z/UpPMBzgdHbiUh0WQibrrw942uppi6mlgLkcaxZt
	+PzhkxtRjBe0IxdU/6E6XrY32wOWBVLDiLLR2WuROAcJzdrp82QhZkBbcpgRgbRKCme/D/2hDgN
	BDwTUDRzfLjMUSYhtWjU0iSUBVdtF6vU7Yvi63O+qpA==
X-Google-Smtp-Source: AGHT+IFmFE6gTdvCswovb35OYCFZC9QaFdUknkpsjvODfkScXW0qJTMpt+tnEGxkYNRSte2VWD24nQ==
X-Received: by 2002:a05:600c:c044:b0:456:11a6:a50a with SMTP id 5b1f17b1804b1-45611a6a859mr3579785e9.2.1752394805674;
        Sun, 13 Jul 2025 01:20:05 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd540b52sm96614785e9.28.2025.07.13.01.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 01:20:04 -0700 (PDT)
Message-ID: <eac19ad2-78dc-44e9-bc02-517272ba737d@linaro.org>
Date: Sun, 13 Jul 2025 10:20:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/15] dt-bindings: media: qcom,x1e80100-camss: Convert
 from inline PHY definitions to PHY handles
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-2-0bc5da82f526@linaro.org>
 <3376b0fb-f3c6-464a-9c35-30a3f589b856@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <3376b0fb-f3c6-464a-9c35-30a3f589b856@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2025 10:18, Krzysztof Kozlowski wrote:
> On 11/07/2025 14:57, Bryan O'Donoghue wrote:
>> We currently do not have an upstream user of the x1e CAMSS schema which
> 
> On first glance there is, in Linus tree:
> 
> git grep qcom,x1e80100-camss
> drivers/media/platform/qcom/camss/camss.c
> 
> If this wasn't released mention it.
... and then this should be marked as fixes and picked up fast, because
you have only like 2 weeks to fix it.

Best regards,
Krzysztof

